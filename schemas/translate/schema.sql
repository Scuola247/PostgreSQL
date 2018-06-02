-- This file is part of Scuola247.
--
-- Scuola247 is free software: you can redistribute it and/or modify it
-- under the terms of the GNU Affero General Public License version 3
-- as published by the Free Software Foundation.
--
-- Scuola247 is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Nome-Programma.  If not, see <http://www.gnu.org/licenses/>.
--
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: translate; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA translate;


ALTER SCHEMA translate OWNER TO postgres;

--
-- Name: SCHEMA translate; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA translate IS 'Manage the translation of your public schema in another language (more than one). You can translate tables, views and procedures so that your user can work with his/her own language';


SET search_path = translate, pg_catalog;

--
-- Name: synch(); Type: FUNCTION; Schema: translate; Owner: postgres
--

CREATE FUNCTION synch() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  row_count integer;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

-- cancello le tabelle o le viste create dall'ultima volta
-- e tramite il cascade della fk anche le colonne
  DELETE FROM translate.relations 
  WHERE name IN (SELECT DISTINCT r.name
 	                    FROM translate.relations_to_translate  tt
 	              RIGHT JOIN translate.relations r ON r.name = tt.name AND r.language = tt.language
 	                   WHERE tt.name IS NULL );
 		        
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Relazioni (tabelle e/o viste) cancellate...: ' || row_count::text;
  RETURN NEXT; 
 
 -- inserisco le tabelle o le viste create dall'ultima volta
  INSERT INTO translate.relations (name, language, comment)
  SELECT isrt.name, isrt.language, isrt.comment
  FROM (SELECT tt.name, tt.language, tt.comment
 	FROM translate.relations_to_translate  tt
 	LEFT JOIN translate.relations r ON r.name = tt.name and r.language = tt.language
 	WHERE r.name IS NULL ) isrt;
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Relazioni (tabelle e/o viste) inserite.....: ' || row_count::text;
  RETURN NEXT;
  
-- cancello le colonne rimosse dal catalogo di postgres
  DELETE FROM translate.columns
   WHERE "column" IN (SELECT c.column
                        FROM translate.columns c                      
                        JOIN translate.relations r  ON r.relation = c.relation
                                                   AND r.language = c.language
                   LEFT JOIN translate.columns_to_translate ctt ON ctt.name = c.name 
                                                               AND ctt.relation_name = r.name 
                                                               AND ctt.language = c.language  
                       WHERE ctt.name IS NULL) ;
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Colonne cancellate.........................: ' || row_count::text;
  RETURN NEXT; 

-- mi assicuro della posizione delle colonne rimaste
  UPDATE translate.columns c SET position = updt.position
    FROM (SELECT c.column, r.relation, ctt.language, ctt.relation_name, ctt.name, ctt.position, ctt.comment
            FROM translate.columns_to_translate ctt
            JOIN translate.relations r ON r.name = ctt.relation_name 
                                      AND r.language = ctt.language
            JOIN translate.columns c ON c.relation = r.relation 
                                    AND c.language = r.language
                                    AND c.name = ctt.name
           WHERE c.position <> ctt.position) updt
   WHERE c.column = updt.column;
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Posizione di colonne cambiate..............: ' || row_count::text;
  RETURN NEXT; 

-- inserisco le colonne mancanti
INSERT INTO translate.columns (relation, position, name, language, comment)
     SELECT isrt.relation, isrt.position, isrt.name, isrt.language, isrt.comment
       FROM (SELECT r.relation, ctt.position, ctt.name, ctt.language, ctt.comment
               FROM translate.columns_to_translate ctt
               JOIN translate.relations r ON r.name = ctt.relation_name 
                                         AND r.language = ctt.language
          LEFT JOIN translate.columns c ON c.relation = r.relation
                                       AND c.name = ctt.name
                                       AND c.language = r.language 
              WHERE c.name IS NULL) isrt;
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Colonne inserite...........................: ' || row_count::text;
  RETURN NEXT; 
 
-- cancello le procedure tolte 
  DELETE FROM translate.procedures 
  WHERE name IN (SELECT DISTINCT p.name
 	           FROM translate.procedures p 
              LEFT JOIN translate.procedures_to_translate ptt ON p.name = ptt.name 
                                                             AND p.arguments_type = ptt.arguments_type
                                                             AND p.language = ptt.language
 	          WHERE ptt.name IS NULL);  
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Procedure cancellate.......................: ' || row_count::text;
  RETURN NEXT; 
     
-- inserisco le procedure nuove
  INSERT INTO translate.procedures (name, language, arguments_name, arguments_type, comment)
       SELECT isrt.name, isrt.language, isrt.arguments_name, isrt.arguments_type, isrt.comment
         FROM ( SELECT ptt.name, ptt.language, ptt.arguments_name, ptt.arguments_type,  ptt.comment
 	          FROM translate.procedures_to_translate ptt
             LEFT JOIN translate.procedures p ON p.name = ptt.name 
                                             AND p.arguments_type = ptt.arguments_type
                                             AND p.language = ptt.language
 	         WHERE p.name IS NULL ) isrt;  
     
  GET DIAGNOSTICS row_count = ROW_COUNT;  
  message := 'Procedure inserite ........................: ' || row_count::text;
  RETURN NEXT; 
 		   
  END
$$;


ALTER FUNCTION translate.synch() OWNER TO postgres;

--
-- Name: translation(); Type: FUNCTION; Schema: translate; Owner: postgres
--

CREATE FUNCTION translation() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
<<me>>
DECLARE
  r_languages 		record;
  r_relations 		record;
  r_columns 		record;
  r_procedures 		record;
  function_table	boolean;
  passato		BOOLEAN;
  columns_count	 	integer;
  columns_position	integer;
  arguments_count 	integer;
  param_default	 	text;
  i			integer;
  i_step2		integer;
  y			integer;
  sql			text;

  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
	           
  FOR r_languages IN SELECT language, schema, description
                       FROM translate.languages
  LOOP
    -- Drop the translate schema if exists
    sql = 'DROP SCHEMA IF EXISTS ' || r_languages.schema || ' CASCADE;';
    RAISE NOTICE 'sql: %',sql;
    BEGIN 
      EXECUTE sql;
    EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show('UNEXPECTED EXCEPTION 1',
                               format('sql: %L',sql));
      PERFORM diagnostic.show(error);
      RETURN;
    END;
    
    -- Recreate the translate schema
    sql = 'CREATE SCHEMA ' || r_languages.schema || ';';
    RAISE NOTICE 'sql: %',sql;
    BEGIN 
      EXECUTE sql;
    EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show('UNEXPECTED EXCEPTION 2',
                               format('sql: %L',sql));
      PERFORM diagnostic.show(error);
      RETURN;
    END;

    -- Comment the translate schema
    sql = format('COMMENT ON SCHEMA %I IS %L;',r_languages.schema, r_languages.description);
    RAISE NOTICE 'sql: %',sql;
    BEGIN 
      EXECUTE sql;
    EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show('UNEXPECTED EXCEPTION 3',
                               format('sql: %L',sql));
      PERFORM diagnostic.show(error);
      RETURN;
    END;

    -- Create table synonym (with the view)
    FOR r_relations IN SELECT relation, 
                              name, 
                              coalesce(translation,name) AS translation
                         FROM translate.relations
                        WHERE language = r_languages.language
                     ORDER BY 3 ASC
    LOOP
      sql = 'CREATE VIEW "' || r_languages.schema || '"."' || r_relations.translation || '" AS SELECT ';
      
      SELECT COUNT(name) 
        INTO columns_count
        FROM translate.columns
       WHERE relation = r_relations.relation;      

      me.columns_position = 0;
              
      FOR r_columns IN SELECT name, 
                              coalesce(translation,name) as translation, 
                              position 
                         FROM translate.columns
                        WHERE relation = r_relations.relation
                        ORDER BY position
      LOOP

        me.columns_position =  me.columns_position + 1;
              
        sql = sql || '"' || r_columns.name || '" AS "' || r_columns.translation || '"';

        IF columns_count = me.columns_position THEN
          sql = sql || ' FROM public."' || r_relations.name || '";' ;
          RAISE NOTICE 'sql: %',sql;
	  BEGIN 
	    EXECUTE sql;
	  EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
            PERFORM diagnostic.show('UNEXPECTED EXCEPTION 4',
                                    format('sql: %L',sql));
            PERFORM diagnostic.show(error);
            RETURN;
          END;
          sql = '';
        ELSE
          SQL = sql || ', '; 
        END IF;         
      END LOOP;
    END LOOP;

   -- Create comment for the view and its columns
    FOR r_relations IN SELECT relation, 
                              name, 
                              coalesce(translation,name) AS translation, 
                              comment
                         FROM translate.relations
                        WHERE language = r_languages.language
                     ORDER BY 3
    LOOP

      sql = format('COMMENT ON VIEW "%s"."%s" IS %L;', r_languages.schema, r_relations.translation, r_relations.comment);
      RAISE NOTICE 'sql: %',sql;

      BEGIN 
        EXECUTE sql;
      EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        PERFORM diagnostic.show('UNEXPECTED EXCEPTION 5',
                                format('sql: %L',sql));
        PERFORM diagnostic.show(error);
        RETURN;
      END;
      
      FOR r_columns IN SELECT name, 
                              coalesce(translation,name) as translation, 
                              position, 
                              comment
                         FROM translate.columns
                        WHERE relation = r_relations.relation
                        ORDER BY position
      LOOP

        sql = format('COMMENT ON COLUMN "%s"."%s"."%s" IS %L;', r_languages.schema, r_relations.translation, r_columns.translation, r_columns.comment);
        RAISE NOTICE 'sql: %',sql;

        BEGIN 
	  EXECUTE sql;
	EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
          PERFORM diagnostic.show('UNEXPECTED EXCEPTION 6',
                                  format('sql: %L',sql));
          PERFORM diagnostic.show(error);
          RETURN;
        END;
      END LOOP;
    END LOOP;
       
    -- Create the functions
    FOR r_procedures IN SELECT pd.procedure, 
			       pd.name, 
                               COALESCE(pd.translation, pd.name) AS translation, 
                               --^ if someone did the translation fine, otherwise i will use the original one
                               COALESCE(pd.arguments_name_translation, pd.arguments_name, array_fill(''::text, ARRAY[array_length(COALESCE(proallargtypes,proargtypes),1)])) AS arguments_name_translation, 
                               --^ if someone did the translation fine, otherwise i will use the original one
                               --^ if there aren't any arguments name i  will fill an array with one empty string for every arguments
                               COALESCE(pr.proallargtypes, string_to_array(array_to_string(pr.proargtypes,','),',')::oid[])::regtype[]::text[] AS proallargregtypes, 
                               --^ if the proallargtype is null then i will use proargtype
                               --^ since the proallargtype is 1 based array and the proargtype is 0 based arrary
                               --^ i will convert proargtype to and from a string with the aim to convert it in 1 based array
                               --^ last but non least i convert to a regtypes description array
                               COALESCE(proargmodes::char[], array_fill('i'::char, ARRAY[array_length(proargtypes,1)])) AS proargmodes,
                               --^ if proargmodes is null then i build the array with the assumption that all arguments are of input type
                               pr.prorettype::regtype::text as prorettype,
                               pr.provariadic,
                               pd.comment
                          FROM translate.procedures pd
                          JOIN pg_proc pr ON pr.proname = pd.name
                                         AND COALESCE(pr.proallargtypes, string_to_array(array_to_string(pr.proargtypes,','),',')::oid[])::regtype[]::text[] = pd.arguments_type
                         WHERE language = r_languages.language
                         ORDER BY 2
               
    LOOP
    
      sql = 'CREATE FUNCTION ' || r_languages.schema || '.' || r_procedures.translation || '(';
      
      me.function_table = FALSE;
      me.arguments_count = COALESCE(array_length(r_procedures.proallargregtypes,1),0);

      -- loop the arguments to build the function firm
      FOR i IN 1..me.arguments_count LOOP

        IF r_procedures.proargmodes[i] = 't' THEN
          me.function_table = TRUE;
          i_step2 = i; 
          EXIT;
        END IF;

        IF i > 1 THEN
          sql = sql || ', ';
        END IF;
  
	-- arguments type
        CASE r_procedures.proargmodes[i]
          WHEN 'i' THEN sql = sql || ' IN ';
	  WHEN 'o' THEN sql = sql || ' OUT ';
          WHEN 'b' THEN sql = sql || ' INOUT ';
          WHEN 'v' THEN sql = sql || ' VARIADIC ';
        END CASE;

        -- argument name
	IF length(r_procedures.arguments_name_translation[i]) > 0 THEN
	  sql = sql || r_procedures.arguments_name_translation[i] || ' ';
        END IF;

	-- argument data type
	sql = sql ||  r_procedures.proallargregtypes[i];

	-- check default value
        me.param_default = pg_get_function_arg_default(r_procedures.procedure,i);

        IF me.param_default IS NULL THEN
        ELSE
          sql = sql || ' DEFAULT ' || me.param_default;
        END IF;
        
      END LOOP;
      
      sql = sql || ') ';

      -- loop the arguments to build the table descrition for function table
      IF me.function_table THEN

        i = i_step2;
        sql = sql || 'RETURNS TABLE( ';

        FOR i IN i..me.arguments_count LOOP
        
          -- for returns table the argument name is mandatory
          IF length(r_procedures.arguments_name_translation[i]) > 0 then
	    
          END IF;

          -- argument name
          sql = sql || r_procedures.arguments_name_translation[i] || ' ';

          -- argument data type
	  sql = sql ||  r_procedures.proallargregtypes[i];

	  IF i < me.arguments_count THEN
            sql = sql || ', ';
          END IF;
        
        END LOOP;

        sql = sql || ') ';        

      -- loop the arguments to build the table descrition for function table
      ELSE
        sql = sql || 'RETURNS ' || r_procedures.prorettype;
      END IF;

      sql = sql || ' AS ' || '''SELECT public.' || r_procedures.name || '(';

      -- loop the arguments to build the column list
      y = 0;
      FOR i IN 1..me.arguments_count LOOP

	if y > 0 THEN
          IF r_procedures.proargmodes[i] IN ('i','b','v') THEN
            sql = sql || ', ';
          END IF;	
	END IF;

	-- arguments type
        IF r_procedures.proargmodes[i] IN ('i','b') THEN
          y = y + 1;
          sql = sql || '$' || y;
        END If;
        
        IF r_procedures.proargmodes[i] = 'v' THEN
          y = y + 1;
          sql = sql || 'VARIADIC $' || y;
        END IF;

      END LOOP;

      sql = sql || ');''' || ' LANGUAGE sql VOLATILE;';

      RAISE NOTICE 'sql: %',sql;
      BEGIN 
        EXECUTE sql;
      EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        PERFORM diagnostic.show('UNEXPECTED EXCEPTION 7',
                                format('sql: %L',sql));
        PERFORM diagnostic.show(error);
        RETURN;
      END;

      -- Create the comment for the functions
      sql = 'COMMENT ON FUNCTION ' || r_languages.schema || '.' || r_procedures.translation || '(';
      
      -- loop the arguments to build the argument list
      me.passato = FALSE;
      FOR i IN 1..me.arguments_count LOOP

	IF me.passato THEN
	  IF r_procedures.proargmodes[i] IN ('i','b','v') THEN
	    sql = sql || ', ';
	  END IF;
	END IF;

        IF r_procedures.proargmodes[i] IN ('i','b') THEN
          me.passato = TRUE;
          sql = sql || ' ' || r_procedures.proallargregtypes[i];
        END IF;

        IF r_procedures.proargmodes[i] = 'v' THEN
          me.passato = TRUE;
          sql = sql || ' VARIADIC ' || r_procedures.proallargregtypes[i];
        END IF;

      END LOOP;

      sql = sql || format(') IS %L',r_procedures.comment);

      RAISE NOTICE 'sql: %',sql;
      BEGIN 
        EXECUTE sql;
      EXCEPTION WHEN OTHERS THEN GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        PERFORM diagnostic.show('UNEXPECTED EXCEPTION 8',
                                format('sql: %L',sql));
        PERFORM diagnostic.show(error);
        RETURN;
      END;
    END LOOP;
  END LOOP;
END;
$_$;


ALTER FUNCTION translate.translation() OWNER TO postgres;

--
-- Name: FUNCTION translation(); Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON FUNCTION translation() IS '<translate>';


--
-- Name: pk_seq; Type: SEQUENCE; Schema: translate; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 713650
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- Name: SEQUENCE pk_seq; Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON SEQUENCE pk_seq IS 'Sequence shared by all primary key in translate schema';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: languages; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE languages (
    language bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description text NOT NULL,
    schema text NOT NULL
);


ALTER TABLE languages OWNER TO postgres;

--
-- Name: TABLE languages; Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON TABLE languages IS 'Language for translation';


--
-- Name: procedures_excluded; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE procedures_excluded (
    procedure_excluded bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    name text NOT NULL
);


ALTER TABLE procedures_excluded OWNER TO postgres;

--
-- Name: columns; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE columns (
    "column" bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    relation bigint NOT NULL,
    "position" integer NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text,
    comment text
);


ALTER TABLE columns OWNER TO postgres;

--
-- Name: COLUMN columns.comment; Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON COLUMN columns.comment IS 'Comment for the column in the language selected';


--
-- Name: columns_to_translate; Type: VIEW; Schema: translate; Owner: postgres
--

CREATE VIEW columns_to_translate AS
 SELECT l.language,
    c.relname AS relation_name,
    a.attname AS name,
    a.attnum AS "position",
    d.description AS comment
   FROM ((((pg_namespace n
     JOIN pg_class c ON ((c.relnamespace = n.oid)))
     JOIN pg_attribute a ON ((a.attrelid = c.oid)))
     LEFT JOIN pg_description d ON (((d.objoid = c.oid) AND (d.objsubid = a.attnum))))
     CROSS JOIN languages l)
  WHERE ((n.nspname = 'public'::name) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char"])) AND (a.attnum > 0) AND (a.attisdropped = false));


ALTER TABLE columns_to_translate OWNER TO postgres;

--
-- Name: procedures; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE procedures (
    procedure bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text,
    arguments_name text[],
    arguments_name_translation text[],
    comment text,
    arguments_type text[]
);


ALTER TABLE procedures OWNER TO postgres;

--
-- Name: COLUMN procedures.comment; Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON COLUMN procedures.comment IS 'Comment for the procedure in the language selected';


--
-- Name: procedures_to_translate; Type: VIEW; Schema: translate; Owner: postgres
--

CREATE VIEW procedures_to_translate AS
 SELECT l.language,
    p.proname AS name,
    p.proargnames AS arguments_name,
    ((COALESCE(p.proallargtypes, (string_to_array(array_to_string(p.proargtypes, ','::text), ','::text))::oid[]))::regtype[])::text[] AS arguments_type,
    d.description AS comment
   FROM (((pg_namespace n
     JOIN pg_proc p ON ((p.pronamespace = n.oid)))
     LEFT JOIN pg_description d ON ((d.objoid = p.oid)))
     CROSS JOIN languages l)
  WHERE ((n.nspname = 'public'::name) AND (p.prorettype <> ALL (ARRAY[('trigger'::regtype)::oid, ('refcursor'::regtype)::oid])) AND (NOT ((p.proname)::text IN ( SELECT procedures_excluded.name
           FROM procedures_excluded))));


ALTER TABLE procedures_to_translate OWNER TO postgres;

--
-- Name: relations; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE relations (
    relation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text,
    comment text
);


ALTER TABLE relations OWNER TO postgres;

--
-- Name: COLUMN relations.comment; Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON COLUMN relations.comment IS 'Comment for the relation the language selected';


--
-- Name: relations_excluded; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE relations_excluded (
    relation_excluded bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    name text NOT NULL
);


ALTER TABLE relations_excluded OWNER TO postgres;

--
-- Name: relations_to_translate; Type: VIEW; Schema: translate; Owner: postgres
--

CREATE VIEW relations_to_translate AS
 SELECT l.language,
    c.relname AS name,
    d.description AS comment
   FROM (((pg_namespace n
     JOIN pg_class c ON ((c.relnamespace = n.oid)))
     LEFT JOIN pg_description d ON ((d.objoid = c.oid)))
     CROSS JOIN languages l)
  WHERE ((n.nspname = 'public'::name) AND (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char"])) AND ((d.objsubid = 0) OR (d.objsubid IS NULL)) AND (NOT ((c.relname)::text IN ( SELECT relations_excluded.name
           FROM relations_excluded))));


ALTER TABLE relations_to_translate OWNER TO postgres;

--
-- Name: texts_to_translate_for_procedure_and_arguments; Type: VIEW; Schema: translate; Owner: postgres
--

CREATE VIEW texts_to_translate_for_procedure_and_arguments AS
 SELECT procedures.procedure,
    procedures.name,
    procedures.arguments_type,
    languages.language,
    languages.description AS language_description,
    procedures.translation,
    procedures.arguments_name,
    procedures.arguments_name_translation,
    procedures.comment
   FROM (procedures
     JOIN languages ON ((procedures.language = languages.language)))
  WHERE (procedures.translation IS NULL);


ALTER TABLE texts_to_translate_for_procedure_and_arguments OWNER TO postgres;

--
-- Name: texts_to_translate_for_relations_and_columns; Type: VIEW; Schema: translate; Owner: postgres
--

CREATE VIEW texts_to_translate_for_relations_and_columns AS
 SELECT relations.relation,
    relations.name AS relation_name,
    relations.language,
    languages.description AS language_description,
    relations.translation AS relation_translation,
    relations.comment AS relation_comment,
    columns."column",
    columns."position",
    columns.name AS column_name,
    columns.translation AS column_translation,
    columns.comment AS column_comment
   FROM relations,
    columns,
    languages
  WHERE ((relations.relation = columns.relation) AND (languages.language = relations.language) AND ((relations.translation IS NULL) OR (columns.translation IS NULL)))
  ORDER BY relations.name, languages.description, columns."position";


ALTER TABLE texts_to_translate_for_relations_and_columns OWNER TO postgres;

--
-- Name: columns columns_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_pk PRIMARY KEY ("column");


--
-- Name: columns columns_uq_relation_name_language; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_uq_relation_name_language UNIQUE (relation, name, language);


--
-- Name: columns columns_uq_relation_name_language_translation; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_uq_relation_name_language_translation UNIQUE (relation, name, language, translation);


--
-- Name: languages languages_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pk PRIMARY KEY (language);


--
-- Name: languages languages_uq_description; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_uq_description UNIQUE (description);


--
-- Name: languages languages_uq_schema; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_uq_schema UNIQUE (schema);


--
-- Name: procedures_excluded procedures_excluded_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures_excluded
    ADD CONSTRAINT procedures_excluded_pk PRIMARY KEY (procedure_excluded);


--
-- Name: procedures procedures_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_pk PRIMARY KEY (procedure);


--
-- Name: relations_excluded relations_excluded_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations_excluded
    ADD CONSTRAINT relations_excluded_pk PRIMARY KEY (relation_excluded);


--
-- Name: relations relations_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_pk PRIMARY KEY (relation);


--
-- Name: relations relations_uq_language_translation; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_uq_language_translation UNIQUE (language, translation);


--
-- Name: relations relations_uq_name_language; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_uq_name_language UNIQUE (name, language);


--
-- Name: procedures_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX procedures_fx_language ON procedures USING btree (language);


--
-- Name: relations_columns_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX relations_columns_fx_language ON columns USING btree (language);


--
-- Name: relations_columns_fx_relation; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX relations_columns_fx_relation ON columns USING btree (relation);


--
-- Name: relations_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX relations_fx_language ON relations USING btree (language);


--
-- Name: columns columns_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_fk_language FOREIGN KEY (language) REFERENCES languages(language) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: columns columns_fk_relation; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_fk_relation FOREIGN KEY (relation) REFERENCES relations(relation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: procedures procedures_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_fk_language FOREIGN KEY (language) REFERENCES languages(language);


--
-- Name: relations relations_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_fk_language FOREIGN KEY (language) REFERENCES languages(language) ON UPDATE CASCADE ON DELETE RESTRICT;


