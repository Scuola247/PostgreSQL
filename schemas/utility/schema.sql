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
-- Name: utility; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA utility;


ALTER SCHEMA utility OWNER TO postgres;

--
-- Name: SCHEMA utility; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA utility IS 'Contains all the objects in a database that although very useful are not large enough or numerous enough to warrant a separate scheme';


SET search_path = utility, pg_catalog;

--
-- Name: language; Type: TYPE; Schema: utility; Owner: postgres
--

CREATE TYPE language AS ENUM (
    'de',
    'it',
    'en',
    'es',
    'fr',
    'nl',
    'sr',
    'sl',
    'bs',
    'hr',
    'sq',
    'lb',
    'pt'
);


ALTER TYPE language OWNER TO postgres;

--
-- Name: TYPE language; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON TYPE language IS '''de'' Deutsch
''it'' Italian
''en'' English
''es'' Spanish
''fr'' French
''nl'' Dutch
''sr'' Serbian
''sl'' Slovenian
''bs'' Bosnia
''hr'' Croatian
''sq'' Albanian
''lb'' Luxembourgish
''pt'' Portoguese';


--
-- Name: number_base34; Type: DOMAIN; Schema: utility; Owner: postgres
--

CREATE DOMAIN number_base34 AS character varying(12)
	CONSTRAINT number_base34_check_characters CHECK (((VALUE)::text ~ similar_escape('[0-9A-HJ-NP-Z]{0,12}'::text, NULL::text)));


ALTER DOMAIN number_base34 OWNER TO postgres;

--
-- Name: DOMAIN number_base34; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON DOMAIN number_base34 IS 'This is a number in base 34 
Number means that its value can be converted to a bigint this is because the maximun length is 12 characters
Base 34 means that the digits are: ''0123456789ABCEDFGHJKLMNPQRSTUWXYZ''
The digits: ''O'' and ''I'' was leave out to avoid error with ''0'' and ''1''';


--
-- Name: system_message; Type: TYPE; Schema: utility; Owner: postgres
--

CREATE TYPE system_message AS (
	language language,
	id smallint,
	message text
);


ALTER TYPE system_message OWNER TO postgres;

--
-- Name: week_day; Type: DOMAIN; Schema: utility; Owner: postgres
--

CREATE DOMAIN week_day AS smallint
	CONSTRAINT week_day_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN week_day OWNER TO postgres;

--
-- Name: DOMAIN week_day; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON DOMAIN week_day IS '<utility>';


--
-- Name: day_name(week_day); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION day_name(_weekday week_day) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context               text;
  full_function_name 	text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  RETURN to_char('2000-01-02'::date + _weekday, 'TMDay');
END;
$$;


ALTER FUNCTION utility.day_name(_weekday week_day) OWNER TO postgres;

--
-- Name: FUNCTION day_name(_weekday week_day); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION day_name(_weekday week_day) IS '<utility>';


--
-- Name: count_value(text, text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION count_value(search_db text, search_schema text, search_table text) RETURNS TABLE(on_datebase_name information_schema.sql_identifier, schema_name information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, count_value bigint, count_null_value bigint, count_not_null_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
   Visualizza per tutte le columns che possono contenere null della tabella, schema e catalogo indicati 
   quante valori null e not null ci sono
*/
<<me>>
DECLARE
  results record;
BEGIN 
  FOR results IN SELECT
		   columns.table_catalog, 
		   columns.table_schema,
		   columns.table_name, 
		   columns.column_name
		 FROM
		   information_schema.columns 
		WHERE
		    columns.table_catalog = search_db
		AND columns.table_schema = search_schema
		AND columns.table_name = search_table
		AND is_nullable = 'YES'
  LOOP
    on_datebase_name := results.table_catalog;
    schema_name := results.table_schema;
    table_name := results.table_name;
    column_name := results.column_name;
    EXECUTE 'SELECT COUNT(*), count(' || column_name || '), count(*) - count(' || column_name || ') FROM ' || table_name into strict count_value, count_null_value, count_not_null_value;
    RETURN NEXT;
   END LOOP;
 END;
$$;


ALTER FUNCTION utility.count_value(search_db text, search_schema text, search_table text) OWNER TO postgres;

--
-- Name: FUNCTION count_value(search_db text, search_schema text, search_table text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION count_value(search_db text, search_schema text, search_table text) IS '<utility>
Restituisce l''elenco delle colonne che ammettono valori null person l''indicazione del numero di valori contenuti person la sottodivisione fra quelli che non hanno valori nulle quelli che si.';


--
-- Name: enum2array(anyenum); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION enum2array(_enum anyenum) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE COST 1
    AS $$
BEGIN
  RETURN enum_range(_enum)::text[];
END;
$$;


ALTER FUNCTION utility.enum2array(_enum anyenum) OWNER TO postgres;

--
-- Name: FUNCTION enum2array(_enum anyenum); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION enum2array(_enum anyenum) IS 'Return un text array filled with the enum values';


--
-- Name: get_max_column_value(text, text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

BEGIN 

  IF schema_name = ''
  OR table_name = ''
  OR column_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: get_max_column_value(''schema'', ''table'', ''column'')'; 
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
 EXECUTE 'SELECT MAX(' || quote_ident(column_name) || ') FROM ' || quote_ident(schema_name) || '.' || quote_ident(table_name) INTO STRICT max_value;
END;
$$;


ALTER FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) OWNER TO postgres;

--
-- Name: FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) IS '<utility>
given the name of the schema, table, and column, it returns the maximum value of the column';


--
-- Name: int8(number_base34); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION int8(_in_value number_base34, OUT _out_value bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER COST 10
    AS $$
<<me>>
DECLARE
  digit_value			integer;
  digits 			text = '0123456789ABCDEFGHJKLMNPQRSTUVWXYZ'; 
  base				integer;
  context 			text;
  full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  IF _in_value IS NuLL THEN
    _out_value = NULL
    RETURN;
  END IF;

  base = length(digits);
  
  _out_value = 0;
  
--
-- elaboro il valore in input
--            
  
  FOR i in 1..length(_in_value) LOOP

    digit_value = position(SUBSTRING(_in_value FROM i FOR 1) in digits) -1;

    IF i = length(_in_value) THEN
      _out_value = _out_value + digit_value;
    ELSE
      _out_value = _out_value + (digit_value * (base ^ (length(_in_value) - i)));
    END IF;
    
  END LOOP;

  RETURN;
END;
$$;


ALTER FUNCTION utility.int8(_in_value number_base34, OUT _out_value bigint) OWNER TO postgres;

--
-- Name: number_base34(bigint); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION number_base34(_in_value bigint, OUT _out_value number_base34) RETURNS number_base34
    LANGUAGE plpgsql SECURITY DEFINER COST 10
    AS $$
<<me>>
DECLARE
  digits 			char[] = ARRAY['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z']; 
  reminder			integer;
  base				integer;
  context 			text;
  full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  base = array_length(digits, 1);
--
-- elaboro il valore in input
--            
  IF _in_value = 0 THEN 
    _out_value = '0'::utility.number_base34;
    RETURN;
  ELSE
    _out_value = '';
  END IF;
  
  WHILE _in_value > 0 LOOP
  
    reminder = _in_value % base;
    _in_value = _in_value / base;

    _out_value = concat(digits[reminder+1], _out_value );
    
  END LOOP;

  RETURN;
END;
$$;


ALTER FUNCTION utility.number_base34(_in_value bigint, OUT _out_value number_base34) OWNER TO postgres;

--
-- Name: number_base34_pl(number_base34, integer); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION number_base34_pl(number_base34, integer) RETURNS number_base34
    LANGUAGE plpgsql SECURITY DEFINER COST 1
    AS $_$
DECLARE
BEGIN 
  RETURN utility.number_base34(utility.int8($1) + $2);
END;
$_$;


ALTER FUNCTION utility.number_base34_pl(number_base34, integer) OWNER TO postgres;

--
-- Name: set_all_sequences_2_the_max(); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION set_all_sequences_2_the_max() RETURNS TABLE(sequence_namespace name, sequence_name name, sequence_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
BEGIN 
  RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
  FROM utility.sequence_references t
  GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$$;


ALTER FUNCTION utility.set_all_sequences_2_the_max() OWNER TO postgres;

--
-- Name: FUNCTION set_all_sequences_2_the_max(); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION set_all_sequences_2_the_max() IS '<utility>
sets all database sequences to the highest value found in the database';


--
-- Name: set_sequence_2_the_max(text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) RETURNS TABLE(sequence_schema_name name, sequence_name name, sequence_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE
 
BEGIN 

  IF _sequence_schema_name = ''
  OR _sequence_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: set_sequence_2_the_max(sequence_namespace, sequence_name)';
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
               FROM utility.sequence_references t
              WHERE t.sequence_schema_name = _sequence_schema_name
                AND t.sequence_name = _sequence_name
           GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$$;


ALTER FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) OWNER TO postgres;

--
-- Name: FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) IS '<utility>
sets the sequences in input to the highest value found in the database';


--
-- Name: strip_tags(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION strip_tags(text) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT regexp_replace(regexp_replace($1, E'(?x)<[^>]*?(\s alt \s* = \s* ([\'"]) ([^>]*?) \2) [^>]*? >', E'\3'), E'(?x)(< [^>]*? >)', '', 'g')
$_$;


ALTER FUNCTION utility.strip_tags(text) OWNER TO postgres;

--
-- Name: FUNCTION strip_tags(text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION strip_tags(text) IS '<utility>
Strip out the HTML tags from a string';


--
-- Name: system_messages_locale(system_message[], integer); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION system_messages_locale(_system_messages system_message[], _id integer, OUT _return_message text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, utility, pg_temp
    AS $$
<<me>>
DECLARE
  message_language	utility.language;
  system_lc_messages    text;
-- variables for system tool
  full_function_name	varchar;
  context		text;
BEGIN 
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
-- You can show the system language with:
--   SHOW lc_messages
-- and you can set it with:
--   SET lc_message = 'xxx'
-- If you want to set a variable:
--   SHOW lc_messages INTO pippo
-- un paio di esempi:
--   it_IT.UTF-8
--   en_US.UTF-8

  SHOW lc_messages INTO system_lc_messages;

  -- search for  the user language
  SELECT language 
    INTO me.message_language 
    FROM usenames_ex 
   WHERE usename = session_user;

  -- if not found try to get system langiage and if not set it to english
  IF NOT FOUND THEN
    BEGIN
      me.message_language = left(system_lc_messages,2)::utility.language;
    EXCEPTION WHEN OTHERS THEN
      me.message_language = 'en'::utility.language;
    END;
  END IF;

  -- search for the message in the system_messages table 
  SELECT t.message 
    INTO _return_message
    FROM unnest(_system_messages) t
   WHERE t.id = _id 
     AND t.language = me.message_language;

  -- if not found  try with english
  IF NOT FOUND THEN

    SELECT t.message 
      INTO _return_message
      FROM unnest(_system_messages) t
     WHERE t.id = _id 
       AND t.language = 'en';
  
    -- if i cannot find it setting a warning
    IF NOT FOUND THEN   
      _return_message = format('*** MESSAGE: %L WAS NOT FOUND in ''system_messages'' table ***',_id );
    END IF;
    
  END IF;

  _return_message = '(' || _id::text || ') ' || _return_message
  
  RETURN;
  
END;
$$;


ALTER FUNCTION utility.system_messages_locale(_system_messages system_message[], _id integer, OUT _return_message text) OWNER TO postgres;

--
-- Name: url_decode(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION url_decode(encode_url text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	bin bytea = '';
	byte text;
BEGIN
	FOR byte IN (select (regexp_matches(encode_url, '(%..|.)', 'g'))[1]) LOOP
		IF length(byte) = 3 THEN
			bin = bin || decode(substring(byte, 2, 2), 'hex');
		ELSE
			bin = bin || byte::bytea;
		END IF;
	END LOOP;
RETURN convert_from(bin, 'utf8');
END
$$;


ALTER FUNCTION utility.url_decode(encode_url text) OWNER TO postgres;

--
-- Name: FUNCTION url_decode(encode_url text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION url_decode(encode_url text) IS '<utility>';


--
-- Name: where_sequence(text, text, text, bigint); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) RETURNS TABLE(catalog_name information_schema.sql_identifier, schema_name information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, times_found bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

  results record;
  stack text;
  proname text;
  proargs text;
  prodesc text;

BEGIN 
  IF p_catalog = ''
  OR p_schema = ''
  OR p_sequence = ''
  OR p_value = 0 
  THEN
    GET DIAGNOSTICS stack = PG_CONTEXT;
    SELECT p.proname, pg_get_function_arguments(oid), obj_description(oid,'pg_proc') INTO proname, proargs, prodesc FROM pg_proc p WHERE oid = substring(stack from 'funzione .*? (.*?) riga')::regprocedure::oid; 
    RAISE NOTICE ''; 
    RAISE NOTICE 'SYNTAX ERROR !!! command format is: %s(%s)', proname, proargs; 
    RAISE NOTICE ''; 
    RAISE NOTICE '%', prodesc; 
    RAISE NOTICE ''; 
   RAISE invalid_parameter_value USING MESSAGE = 'Some parameters are missings e/o wrong', HINT = 'Check the parameters and rerun the command';
  END IF;

  catalog_name := p_catalog;
  schema_name := p_schema;
  
  FOR results IN
    SELECT
      columns.table_catalog, 
      columns.table_schema,
      columns.table_name, 
      columns.column_name
    FROM
      information_schema.columns, 
      information_schema.tables
    WHERE
      columns.table_catalog = tables.table_catalog AND
      columns.table_schema = tables.table_schema AND
      columns.table_name = tables.table_name AND
      tables.table_catalog = p_catalog AND 
      tables.table_schema = p_schema AND 
      tables.table_type = 'BASE TABLE' AND 
      columns.column_default =  'nextval(''' || p_sequence || '''::regclass)'
  LOOP
      table_name := results.table_name;
      column_name := results.column_name;
      EXECUTE 'SELECT COUNT(''x'') FROM ' || table_name || ' WHERE ' || column_name || ' = ' || p_value INTO STRICT times_found;
      RETURN NEXT;
  END LOOP;
END;
$$;


ALTER FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) OWNER TO postgres;

--
-- Name: FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) IS '<utility>
The function takes as input the name of a database, a schema, a sequence and a value of itself and looks in all the columns of all tables of all schemas in the database to find the specified value.
The usage scenario is to a database where all the primary key refer to only one sequence, in this case a value of the sequence is unique in the entire database.
So it can be usefull, starting from a value of the sequence, go back to the table to which it was attributed.';


--
-- Name: +; Type: OPERATOR; Schema: utility; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = number_base34_pl,
    LEFTARG = number_base34,
    RIGHTARG = integer,
    COMMUTATOR = OPERATOR(public.+)
);


ALTER OPERATOR utility.+ (number_base34, integer) OWNER TO postgres;

--
-- Name: enums_values; Type: VIEW; Schema: utility; Owner: postgres
--

CREATE VIEW enums_values AS
 SELECT n.nspname AS schema_name,
    t.typname AS enum_name,
    e.enumlabel AS enum_value
   FROM ((pg_type t
     JOIN pg_enum e ON ((t.oid = e.enumtypid)))
     JOIN pg_namespace n ON ((n.oid = t.typnamespace)));


ALTER TABLE enums_values OWNER TO postgres;

--
-- Name: VIEW enums_values; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON VIEW enums_values IS 'List all enum and all related values';


--
-- Name: sequence_references; Type: VIEW; Schema: utility; Owner: postgres
--

CREATE VIEW sequence_references AS
 SELECT sns.nspname AS sequence_schema_name,
    s.relname AS sequence_name,
    tns.nspname AS reference_schema_name,
    t.relname AS reference_table_name,
    a.attname AS reference_column_name,
    get_max_column_value((tns.nspname)::text, (t.relname)::text, (a.attname)::text) AS max_value
   FROM ((((((pg_class s
     JOIN pg_namespace sns ON ((sns.oid = s.relnamespace)))
     JOIN pg_depend d ON ((d.refobjid = s.oid)))
     JOIN pg_attrdef ad ON ((ad.oid = d.objid)))
     JOIN pg_class t ON ((t.oid = ad.adrelid)))
     JOIN pg_attribute a ON (((a.attrelid = ad.adrelid) AND (a.attnum = ad.adnum))))
     JOIN pg_namespace tns ON ((tns.oid = t.relnamespace)))
  WHERE (s.relkind = 'S'::"char");


ALTER TABLE sequence_references OWNER TO postgres;

--
-- Name: VIEW sequence_references; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON VIEW sequence_references IS 'List tables and columns where sequences are refererred and his max value';


--
-- Name: count_value(text, text, text); Type: ACL; Schema: utility; Owner: postgres
--

REVOKE ALL ON FUNCTION count_value(search_db text, search_schema text, search_table text) FROM PUBLIC;
GRANT ALL ON FUNCTION count_value(search_db text, search_schema text, search_table text) TO scuola247_relative;
