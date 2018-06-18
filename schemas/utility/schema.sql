--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Ubuntu 10.4-2.pgdg18.04+1)
-- Dumped by pg_dump version 10.4 (Ubuntu 10.4-2.pgdg18.04+1)

-- Started on 2018-06-18 12:25:52 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 22 (class 2615 OID 2163607)
-- Name: utility; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA utility;


ALTER SCHEMA utility OWNER TO postgres;

--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA utility; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA utility IS 'Contains all the objects in a database that although very useful are not large enough or numerous enough to warrant a separate scheme';


--
-- TOC entry 1440 (class 1247 OID 2164492)
-- Name: language; Type: TYPE; Schema: utility; Owner: scuola247_supervisor
--

CREATE TYPE utility.language AS ENUM (
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


ALTER TYPE utility.language OWNER TO scuola247_supervisor;

--
-- TOC entry 4324 (class 0 OID 0)
-- Dependencies: 1440
-- Name: TYPE language; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON TYPE utility.language IS '''de'' Deutsch
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
-- TOC entry 1454 (class 1247 OID 2164519)
-- Name: number_base34; Type: DOMAIN; Schema: utility; Owner: scuola247_supervisor
--

CREATE DOMAIN utility.number_base34 AS character varying(12)
	CONSTRAINT number_base34_check_characters CHECK (((VALUE)::text ~ similar_escape('[0-9A-HJ-NP-Z]{0,12}'::text, NULL::text)));


ALTER DOMAIN utility.number_base34 OWNER TO scuola247_supervisor;

--
-- TOC entry 4326 (class 0 OID 0)
-- Dependencies: 1454
-- Name: DOMAIN number_base34; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON DOMAIN utility.number_base34 IS 'This is a number in base 34 
Number means that its value can be converted to a bigint this is because the maximun length is 12 characters
Base 34 means that the digits are: ''0123456789ABCEDFGHJKLMNPQRSTUWXYZ''
The digits: ''O'' and ''I'' was leave out to avoid error with ''0'' and ''1''';


--
-- TOC entry 1591 (class 1247 OID 2575251)
-- Name: objects_type; Type: TYPE; Schema: utility; Owner: scuola247_supervisor
--

CREATE TYPE utility.objects_type AS ENUM (
    'domain',
    'function',
    'sequence',
    'table',
    'view',
    'type'
);


ALTER TYPE utility.objects_type OWNER TO scuola247_supervisor;

--
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 1591
-- Name: TYPE objects_type; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON TYPE utility.objects_type IS 'list the object''s database';


--
-- TOC entry 1466 (class 1247 OID 2164523)
-- Name: system_message; Type: TYPE; Schema: utility; Owner: scuola247_supervisor
--

CREATE TYPE utility.system_message AS (
	language utility.language,
	id smallint,
	message text
);


ALTER TYPE utility.system_message OWNER TO scuola247_supervisor;

--
-- TOC entry 1456 (class 1247 OID 2164524)
-- Name: week_day; Type: DOMAIN; Schema: utility; Owner: scuola247_supervisor
--

CREATE DOMAIN utility.week_day AS smallint
	CONSTRAINT week_day_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN utility.week_day OWNER TO scuola247_supervisor;

--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 1456
-- Name: DOMAIN week_day; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON DOMAIN utility.week_day IS '<utility>';


--
-- TOC entry 408 (class 1255 OID 2164731)
-- Name: day_name(utility.week_day); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.day_name(_weekday utility.week_day) RETURNS character varying
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


ALTER FUNCTION utility.day_name(_weekday utility.week_day) OWNER TO scuola247_supervisor;

--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION day_name(_weekday utility.week_day); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.day_name(_weekday utility.week_day) IS '<utility>';


--
-- TOC entry 819 (class 1255 OID 2304577)
-- Name: check_path(text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.check_path(_path text DEFAULT '/tmp'::text) RETURNS void
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'Error trying check path')::utility.system_message,
    ('en', 2, 'The command used was: %L')::utility.system_message,
    ('en', 3, 'Check the input path and rerun the function')::utility.system_message,
    ('it', 1, 'Errore durante il controllo del path')::utility.system_message,
    ('it', 2, 'Il comando usato era: %L')::utility.system_message,
    ('it', 3, 'Controllare il path di input e rilanciare la funzione.')::utility.system_message];

  context 			text;
  full_function_name		text;
  error				diagnostic.error;
  command			text;

  path_to_check			text;
  message			text;
  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  BEGIN
    me.command = format('COPY (SELECT 1) TO PROGRAM %L',format('mkdir -p  %L', _path)); 
    EXECUTE me.command;
    message = format('%s %s path: %L',to_char(clock_timestamp(),'HH24:MI:SS.US'),full_function_name, _path); RAISE NOTICE '%', message;   
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    PERFORM diagnostic.show(error);
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(me.system_messages,1),
      DETAIL = format(utility.system_messages_locale(me.system_messages,2), me.command),
      HINT = utility.system_messages_locale(me.system_messages,3);  
  END;
END
$$;


ALTER FUNCTION utility.check_path(_path text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 819
-- Name: FUNCTION check_path(_path text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.check_path(_path text) IS 'Check existence of path in input and create it if not exists';


--
-- TOC entry 462 (class 1255 OID 2304775)
-- Name: copyright_notice(); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.copyright_notice() RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN '/*Scuola247(v1)' || e'\n' ||
         e'\n' ||
         '  Copyright (C) 2013-2018 FULCRO SRL (http://www.fulcro.net).' || e'\n' ||
         e'\n' ||
         '  This file is part of Scuola247 (http://www.scuola247.org).' || e'\n' ||
         e'\n' ||
         '  Scuola247 is free software: you can redistribute it and/or modify'  || e'\n' ||
         '  it under the terms of the GNU Affero General Public License as published by'  || e'\n' ||
         '  the Free Software Foundation, either version 3 of the License, or'  || e'\n' ||
         '  any later version.'  || e'\n' ||
         e'\n' ||
         '  Scuola247 is distributed in the hope that it will be useful,' || e'\n' ||
         '  but WITHOUT ANY WARRANTY; without even the implied warranty of' || e'\n' ||
         '  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the' || e'\n' ||
         '  GNU Affero General Public License for more details.' || e'\n' ||
         e'\n' ||
         '  You should have received a copy of the GNU Affero General Public License' || e'\n' ||
         '  along with Scuola247. If not, see <http://www.gnu.org/licenses/>.' || e'\n' ||
         '*/';
END;
$$;


ALTER FUNCTION utility.copyright_notice() OWNER TO scuola247_supervisor;

--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION copyright_notice(); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.copyright_notice() IS 'Returns the copyright notice to include in all files';


--
-- TOC entry 437 (class 1255 OID 2165044)
-- Name: count_value(text, text, text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.count_value(search_db text, search_schema text, search_table text) RETURNS TABLE(on_datebase_name information_schema.sql_identifier, schema_name information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, count_value bigint, count_null_value bigint, count_not_null_value bigint)
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


ALTER FUNCTION utility.count_value(search_db text, search_schema text, search_table text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4338 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION count_value(search_db text, search_schema text, search_table text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.count_value(search_db text, search_schema text, search_table text) IS '<utility>
Restituisce l''elenco delle colonne che ammettono valori null person l''indicazione del numero di valori contenuti person la sottodivisione fra quelli che non hanno valori nulle quelli che si.';


--
-- TOC entry 836 (class 1255 OID 2304557)
-- Name: delete_file(text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.delete_file(_file_path text) RETURNS void
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE  
  context 			text;
  full_function_name		text;
     
  command			text;
  error				diagnostic.error;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  BEGIN
    me.command = format('COPY (SELECT 1) TO PROGRAM %L','rm ' || format ('%L', _file_path));
  EXCEPTION WHEN OTHERS THEN
      -- trap exception only to show it and rethrow it
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
      RAISE EXCEPTION USING
        ERRCODE = error.returned_sqlstate,
        MESSAGE = error.message_text,
        DETAIL = error.pg_exception_detail,
        HINT = error.pg_exception_hint; 
  END;
END
$$;


ALTER FUNCTION utility.delete_file(_file_path text) OWNER TO scuola247_supervisor;

--
-- TOC entry 668 (class 1255 OID 2165045)
-- Name: enum2array(anyenum); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.enum2array(_enum anyenum) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE COST 1
    AS $$
BEGIN
  RETURN enum_range(_enum)::text[];
END;
$$;


ALTER FUNCTION utility.enum2array(_enum anyenum) OWNER TO scuola247_supervisor;

--
-- TOC entry 4341 (class 0 OID 0)
-- Dependencies: 668
-- Name: FUNCTION enum2array(_enum anyenum); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.enum2array(_enum anyenum) IS 'Return un text array filled with the enum values';


--
-- TOC entry 938 (class 1255 OID 2583518)
-- Name: execute_command_query(text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.execute_command_query(_query text) RETURNS void
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE 
  context 			text;
  full_function_name		text;
     
  command			text;
  error				diagnostic.error;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  BEGIN
    FOR me.command IN EXECUTE _query LOOP
      RAISE NOTICE 'EXECUTE IMMEDIATE: %', me.command;
      EXECUTE command;
    END LOOP;
  EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
  END;
END
$$;


ALTER FUNCTION utility.execute_command_query(_query text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 938
-- Name: FUNCTION execute_command_query(_query text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.execute_command_query(_query text) IS 'Exec the command column in all rows from the input query';


--
-- TOC entry 793 (class 1255 OID 2165046)
-- Name: get_max_column_value(text, text, text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) RETURNS bigint
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


ALTER FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) OWNER TO scuola247_supervisor;

--
-- TOC entry 4345 (class 0 OID 0)
-- Dependencies: 793
-- Name: FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) IS '<utility>
given the name of the schema, table, and column, it returns the maximum value of the column';


--
-- TOC entry 435 (class 1255 OID 2165047)
-- Name: int8(utility.number_base34); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.int8(_in_value utility.number_base34, OUT _out_value bigint) RETURNS bigint
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


ALTER FUNCTION utility.int8(_in_value utility.number_base34, OUT _out_value bigint) OWNER TO scuola247_supervisor;

--
-- TOC entry 691 (class 1255 OID 2165048)
-- Name: load_settings(); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.load_settings() RETURNS TABLE(_message text)
    LANGUAGE plpgsql COST 1 ROWS 30
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name         = diagnostic.full_function_name(me.context); 

  SET scuola247.db_current_version     = '0.0.0';
  SET scuola247.git.base_path          = '/var/lib/postgresql/10/main/git/scuola247/PostgreSQL';

  _message = format('scuola247.db_current_version ..........:%s',current_setting('scuola247.db_current_version'));  RAISE NOTICE '%', _message; RETURN NEXT; 
  _message = format('scuola247.git.base_path ...............:%s',current_setting('scuola247.git.base_path'));           RAISE NOTICE '%', _message; RETURN NEXT; 

END
$$;


ALTER FUNCTION utility.load_settings() OWNER TO scuola247_supervisor;

--
-- TOC entry 676 (class 1255 OID 2165049)
-- Name: number_base34(bigint); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.number_base34(_in_value bigint, OUT _out_value utility.number_base34) RETURNS utility.number_base34
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


ALTER FUNCTION utility.number_base34(_in_value bigint, OUT _out_value utility.number_base34) OWNER TO scuola247_supervisor;

--
-- TOC entry 740 (class 1255 OID 2165050)
-- Name: number_base34_pl(utility.number_base34, integer); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.number_base34_pl(utility.number_base34, integer) RETURNS utility.number_base34
    LANGUAGE plpgsql SECURITY DEFINER COST 1
    AS $_$
DECLARE
BEGIN 
  RETURN utility.number_base34(utility.int8($1) + $2);
END;
$_$;


ALTER FUNCTION utility.number_base34_pl(utility.number_base34, integer) OWNER TO scuola247_supervisor;

--
-- TOC entry 475 (class 1255 OID 2304459)
-- Name: read_file(text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.read_file(_file_path text, OUT _file_content text) RETURNS text
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE  
  context 			text;
  full_function_name		text;
     
  command			text;
  error				diagnostic.error;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  BEGIN
    CREATE TEMP TABLE IF NOT EXISTS tmp_read_file_file_rows (file_row text);
    DELETE FROM tmp_read_file_file_rows;
    me.command = format('COPY tmp_read_file_file_rows(file_row) FROM %L', _file_path); EXECUTE me.command;
    SELECT array_to_string(array_agg(file_row), E'\n') INTO _file_content FROM tmp_read_file_file_rows;
  EXCEPTION WHEN OTHERS THEN
      -- trap exception only to show it and rethrow it
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
      RAISE EXCEPTION USING
        ERRCODE = error.returned_sqlstate,
        MESSAGE = error.message_text,
        DETAIL = error.pg_exception_detail,
        HINT = error.pg_exception_hint; 
  END;
END
$$;


ALTER FUNCTION utility.read_file(_file_path text, OUT _file_content text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION read_file(_file_path text, OUT _file_content text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.read_file(_file_path text, OUT _file_content text) IS 'Read a text file putting the content into a text variable';


--
-- TOC entry 680 (class 1255 OID 2165051)
-- Name: set_all_sequences_2_the_max(); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.set_all_sequences_2_the_max() RETURNS TABLE(sequence_namespace name, sequence_name name, sequence_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
BEGIN 
  RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
  FROM utility.sequence_references t
  GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$$;


ALTER FUNCTION utility.set_all_sequences_2_the_max() OWNER TO scuola247_supervisor;

--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 680
-- Name: FUNCTION set_all_sequences_2_the_max(); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.set_all_sequences_2_the_max() IS '<utility>
sets all database sequences to the highest value found in the database';


--
-- TOC entry 804 (class 1255 OID 2165052)
-- Name: set_sequence_2_the_max(text, text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) RETURNS TABLE(sequence_schema_name name, sequence_name name, sequence_value bigint)
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


ALTER FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 804
-- Name: FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) IS '<utility>
sets the sequences in input to the highest value found in the database';


--
-- TOC entry 568 (class 1255 OID 2165053)
-- Name: show_error(); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.show_error() RETURNS diagnostic.error
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE 
  error			diagnostic.error;
BEGIN
  BEGIN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RETURN error;
  END;
END
$$;


ALTER FUNCTION utility.show_error() OWNER TO scuola247_supervisor;

--
-- TOC entry 829 (class 1255 OID 2165054)
-- Name: strip_tags(text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.strip_tags(text) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT regexp_replace(regexp_replace($1, E'(?x)<[^>]*?(\s alt \s* = \s* ([\'"]) ([^>]*?) \2) [^>]*? >', E'\3'), E'(?x)(< [^>]*? >)', '', 'g')
$_$;


ALTER FUNCTION utility.strip_tags(text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 829
-- Name: FUNCTION strip_tags(text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.strip_tags(text) IS '<utility>
Strip out the HTML tags from a string';


--
-- TOC entry 715 (class 1255 OID 2165055)
-- Name: system_messages_locale(utility.system_message[], integer); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.system_messages_locale(_system_messages utility.system_message[], _id integer, OUT _return_message text) RETURNS text
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


ALTER FUNCTION utility.system_messages_locale(_system_messages utility.system_message[], _id integer, OUT _return_message text) OWNER TO scuola247_supervisor;

--
-- TOC entry 509 (class 1255 OID 2165056)
-- Name: url_decode(text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.url_decode(encode_url text) RETURNS text
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


ALTER FUNCTION utility.url_decode(encode_url text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION url_decode(encode_url text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.url_decode(encode_url text) IS '<utility>';


--
-- TOC entry 657 (class 1255 OID 2165057)
-- Name: where_sequence(text, text, text, bigint); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) RETURNS TABLE(catalog_name information_schema.sql_identifier, schema_name information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, times_found bigint)
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


ALTER FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) OWNER TO scuola247_supervisor;

--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 657
-- Name: FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) IS '<utility>
The function takes as input the name of a database, a schema, a sequence and a value of itself and looks in all the columns of all tables of all schemas in the database to find the specified value.
The usage scenario is to a database where all the primary key refer to only one sequence, in this case a value of the sequence is unique in the entire database.
So it can be usefull, starting from a value of the sequence, go back to the table to which it was attributed.';


--
-- TOC entry 710 (class 1255 OID 2304461)
-- Name: write_file(text, text); Type: FUNCTION; Schema: utility; Owner: scuola247_supervisor
--

CREATE FUNCTION utility.write_file(_file_path text, _file_content text) RETURNS void
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE 
  context 			text;
  full_function_name		text;
     
  command			text;
  error				diagnostic.error;
  message			text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  --
  -- don't get out or the COPY command will fails
  --
  set client_encoding to 'latin2';
  BEGIN

    CREATE TEMP TABLE IF NOT EXISTS tmp_write_file_file_rows (file_row text);
    DELETE FROM tmp_write_file_file_rows;
    INSERT INTO tmp_write_file_file_rows SELECT unnest(string_to_array(_file_content,E'\n'));
    message = format('%s %s write file: %L',to_char(clock_timestamp(),'HH24:MI:SS.US'),full_function_name, _file_path); RAISE NOTICE '%', message;   

    me.command = format('COPY (SELECT file_row FROM tmp_write_file_file_rows) TO %L', _file_path); EXECUTE me.command;
  EXCEPTION WHEN OTHERS THEN
      -- trap exception only to show it and rethrow it
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
      RAISE EXCEPTION USING
        ERRCODE = error.returned_sqlstate,
        MESSAGE = error.message_text,
        DETAIL = error.pg_exception_detail,
        HINT = error.pg_exception_hint; 
  END;
END
$$;


ALTER FUNCTION utility.write_file(_file_path text, _file_content text) OWNER TO scuola247_supervisor;

--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION write_file(_file_path text, _file_content text); Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON FUNCTION utility.write_file(_file_path text, _file_content text) IS 'Write a text file getting the content from a text variable';


--
-- TOC entry 2649 (class 2617 OID 2575208)
-- Name: +; Type: OPERATOR; Schema: utility; Owner: scuola247_supervisor
--

CREATE OPERATOR utility.+ (
    PROCEDURE = utility.number_base34_pl,
    LEFTARG = utility.number_base34,
    RIGHTARG = integer,
    COMMUTATOR = OPERATOR(public.+)
);


ALTER OPERATOR utility.+ (utility.number_base34, integer) OWNER TO scuola247_supervisor;

--
-- TOC entry 400 (class 1259 OID 2575900)
-- Name: domains; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.domains AS
 SELECT (domains.domain_schema)::text AS schema_name,
    (domains.domain_name)::text AS object_name
   FROM information_schema.domains
  WHERE ((domains.domain_schema)::text <> 'information_schema'::text);


ALTER TABLE utility.domains OWNER TO scuola247_supervisor;

--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 400
-- Name: VIEW domains; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.domains IS 'List all domains';


--
-- TOC entry 393 (class 1259 OID 2166012)
-- Name: enums_values; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.enums_values AS
 SELECT n.nspname AS schema_name,
    t.typname AS enum_name,
    e.enumlabel AS enum_value
   FROM ((pg_type t
     JOIN pg_enum e ON ((t.oid = e.enumtypid)))
     JOIN pg_namespace n ON ((n.oid = t.typnamespace)));


ALTER TABLE utility.enums_values OWNER TO scuola247_supervisor;

--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 393
-- Name: VIEW enums_values; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.enums_values IS 'List all enum and all related values';


--
-- TOC entry 401 (class 1259 OID 2575904)
-- Name: functions; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.functions AS
 WITH functions_raw AS (
         SELECT
                CASE
                    WHEN (((pg_proc.pronamespace)::regnamespace)::text = 'public'::text) THEN concat('public.', ((pg_proc.oid)::regprocedure)::text)
                    ELSE ((pg_proc.oid)::regprocedure)::text
                END AS function_signature
           FROM pg_proc
          WHERE (((pg_proc.pronamespace)::regnamespace)::oid <> ALL (ARRAY[('pg_catalog'::regnamespace)::oid, ('information_schema'::regnamespace)::oid]))
        )
 SELECT "left"(functions_raw.function_signature, (strpos(functions_raw.function_signature, '.'::text) - 1)) AS schema_name,
    "right"(functions_raw.function_signature, (length(functions_raw.function_signature) - strpos(functions_raw.function_signature, '.'::text))) AS object_name
   FROM functions_raw;


ALTER TABLE utility.functions OWNER TO scuola247_supervisor;

--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 401
-- Name: VIEW functions; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.functions IS 'List all functions';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 398 (class 1259 OID 2575263)
-- Name: objects_list_excluded; Type: TABLE; Schema: utility; Owner: scuola247_supervisor
--

CREATE TABLE utility.objects_list_excluded (
    automation_exclusion bigint DEFAULT nextval('public.pk_seq'::regclass) NOT NULL,
    object_type utility.objects_type,
    schema_name text,
    object_name text
);


ALTER TABLE utility.objects_list_excluded OWNER TO scuola247_supervisor;

--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 398
-- Name: TABLE objects_list_excluded; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON TABLE utility.objects_list_excluded IS 'objct''s database to exclude from automatic set of owner';


--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN objects_list_excluded.automation_exclusion; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON COLUMN utility.objects_list_excluded.automation_exclusion IS 'identify tables''s row';


--
-- TOC entry 402 (class 1259 OID 2575909)
-- Name: sequences; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.sequences AS
 SELECT (sequences.sequence_schema)::text AS schema_name,
    (sequences.sequence_name)::text AS object_name
   FROM information_schema.sequences;


ALTER TABLE utility.sequences OWNER TO scuola247_supervisor;

--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 402
-- Name: VIEW sequences; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.sequences IS 'List all sequences';


--
-- TOC entry 403 (class 1259 OID 2575913)
-- Name: tables; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.tables AS
 SELECT (tables.table_schema)::text AS schema_name,
    (tables.table_name)::text AS object_name
   FROM information_schema.tables
  WHERE (((tables.table_schema)::text <> 'pg_catalog'::text) AND ((tables.table_schema)::text <> 'information_schema'::text) AND ((tables.table_type)::text <> 'VIEW'::text));


ALTER TABLE utility.tables OWNER TO scuola247_supervisor;

--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 403
-- Name: VIEW tables; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.tables IS 'List all schema with own table name ';


--
-- TOC entry 399 (class 1259 OID 2575896)
-- Name: types; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.types AS
 SELECT ((pg_type.typnamespace)::regnamespace)::text AS schema_name,
    (pg_type.typname)::text AS object_name
   FROM pg_type
  WHERE ((((pg_type.typnamespace)::regnamespace)::oid <> ALL (ARRAY[('pg_catalog'::regnamespace)::oid, ('information_schema'::regnamespace)::oid, ('pg_toast'::regnamespace)::oid])) AND (pg_type.typcategory <> 'A'::"char") AND (pg_type.typrelid = (0)::oid));


ALTER TABLE utility.types OWNER TO scuola247_supervisor;

--
-- TOC entry 4375 (class 0 OID 0)
-- Dependencies: 399
-- Name: VIEW types; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.types IS 'List all types ';


--
-- TOC entry 405 (class 1259 OID 2575921)
-- Name: views; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.views AS
 SELECT (tables.table_schema)::text AS schema_name,
    (tables.table_name)::text AS object_name
   FROM information_schema.tables
  WHERE (((tables.table_type)::text = 'VIEW'::text) AND ((tables.table_schema)::text <> 'pg_catalog'::text) AND ((tables.table_schema)::text <> 'information_schema'::text));


ALTER TABLE utility.views OWNER TO scuola247_supervisor;

--
-- TOC entry 4377 (class 0 OID 0)
-- Dependencies: 405
-- Name: VIEW views; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.views IS 'List all view table  ';


--
-- TOC entry 406 (class 1259 OID 2575925)
-- Name: objects_list; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.objects_list AS
 WITH objects_list AS (
         SELECT 'domain'::utility.objects_type AS object_type,
            domains.schema_name,
            domains.object_name
           FROM utility.domains
        UNION ALL
         SELECT 'function'::utility.objects_type AS object_type,
            functions.schema_name,
            functions.object_name
           FROM utility.functions
        UNION ALL
         SELECT 'sequence'::utility.objects_type AS object_type,
            sequences.schema_name,
            sequences.object_name
           FROM utility.sequences
        UNION ALL
         SELECT 'table'::utility.objects_type AS object_type,
            tables.schema_name,
            tables.object_name
           FROM utility.tables
        UNION ALL
         SELECT 'view'::utility.objects_type AS object_type,
            views.schema_name,
            views.object_name
           FROM utility.views
        UNION ALL
         SELECT 'type'::utility.objects_type AS object_type,
            types.schema_name,
            types.object_name
           FROM utility.types
        )
 SELECT o.object_type,
    o.schema_name,
    o.object_name
   FROM (objects_list o
     LEFT JOIN utility.objects_list_excluded a ON (((o.object_type = a.object_type) AND (o.schema_name = a.schema_name) AND (o.object_name = a.object_name))))
  WHERE ((a.object_type IS NULL) AND (a.schema_name IS NULL) AND (a.object_name IS NULL));


ALTER TABLE utility.objects_list OWNER TO scuola247_supervisor;

--
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 406
-- Name: VIEW objects_list; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.objects_list IS 'List all object''s database excluding those in utility-automation.exclusions';


--
-- TOC entry 407 (class 1259 OID 2583455)
-- Name: objects_set_owner; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.objects_set_owner AS
 WITH objects_preproccesed AS (
         SELECT
                CASE objects_list.object_type
                    WHEN 'view'::utility.objects_type THEN 'TABLE'::text
                    ELSE upper((objects_list.object_type)::text)
                END AS object_type,
            objects_list.schema_name,
            objects_list.object_name
           FROM utility.objects_list
        )
 SELECT format('ALTER %s %s OWNER to scuola247_supervisor;'::text, objects_preproccesed.object_type, ((objects_preproccesed.schema_name || '.'::text) || objects_preproccesed.object_name)) AS command
   FROM objects_preproccesed
  ORDER BY objects_preproccesed.schema_name, objects_preproccesed.object_name;


ALTER TABLE utility.objects_set_owner OWNER TO scuola247_supervisor;

--
-- TOC entry 394 (class 1259 OID 2166017)
-- Name: sequence_references; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.sequence_references AS
 SELECT sns.nspname AS sequence_schema_name,
    s.relname AS sequence_name,
    tns.nspname AS reference_schema_name,
    t.relname AS reference_table_name,
    a.attname AS reference_column_name,
    utility.get_max_column_value((tns.nspname)::text, (t.relname)::text, (a.attname)::text) AS max_value
   FROM ((((((pg_class s
     JOIN pg_namespace sns ON ((sns.oid = s.relnamespace)))
     JOIN pg_depend d ON ((d.refobjid = s.oid)))
     JOIN pg_attrdef ad ON ((ad.oid = d.objid)))
     JOIN pg_class t ON ((t.oid = ad.adrelid)))
     JOIN pg_attribute a ON (((a.attrelid = ad.adrelid) AND (a.attnum = ad.adnum))))
     JOIN pg_namespace tns ON ((tns.oid = t.relnamespace)))
  WHERE (s.relkind = 'S'::"char");


ALTER TABLE utility.sequence_references OWNER TO scuola247_supervisor;

--
-- TOC entry 4380 (class 0 OID 0)
-- Dependencies: 394
-- Name: VIEW sequence_references; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.sequence_references IS 'List tables and columns where sequences are refererred and his max value';


--
-- TOC entry 404 (class 1259 OID 2575917)
-- Name: triggers; Type: VIEW; Schema: utility; Owner: scuola247_supervisor
--

CREATE VIEW utility.triggers AS
 SELECT (triggers.trigger_schema)::text AS schema_name,
    (triggers.trigger_name)::text AS object_name
   FROM information_schema.triggers;


ALTER TABLE utility.triggers OWNER TO scuola247_supervisor;

--
-- TOC entry 4381 (class 0 OID 0)
-- Dependencies: 404
-- Name: VIEW triggers; Type: COMMENT; Schema: utility; Owner: scuola247_supervisor
--

COMMENT ON VIEW utility.triggers IS 'List all trigger functions';


--
-- TOC entry 4095 (class 2606 OID 2575271)
-- Name: objects_list_excluded automation_exclusions_pk; Type: CONSTRAINT; Schema: utility; Owner: scuola247_supervisor
--

ALTER TABLE ONLY utility.objects_list_excluded
    ADD CONSTRAINT automation_exclusions_pk PRIMARY KEY (automation_exclusion);


--
-- TOC entry 4097 (class 2606 OID 2583483)
-- Name: objects_list_excluded automation_exclusions_uq_type_schema_object; Type: CONSTRAINT; Schema: utility; Owner: scuola247_supervisor
--

ALTER TABLE ONLY utility.objects_list_excluded
    ADD CONSTRAINT automation_exclusions_uq_type_schema_object UNIQUE (object_type, schema_name, object_name);


--
-- TOC entry 4323 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA utility; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA utility TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA utility TO scuola247_user;


--
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 1440
-- Name: TYPE language; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TYPE utility.language FROM scuola247_supervisor;
GRANT ALL ON TYPE utility.language TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE utility.language TO scuola247_user;


--
-- TOC entry 4327 (class 0 OID 0)
-- Dependencies: 1454
-- Name: TYPE number_base34; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TYPE utility.number_base34 FROM scuola247_supervisor;
GRANT ALL ON TYPE utility.number_base34 TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE utility.number_base34 TO scuola247_user WITH GRANT OPTION;


--
-- TOC entry 4329 (class 0 OID 0)
-- Dependencies: 1466
-- Name: TYPE system_message; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TYPE utility.system_message FROM scuola247_supervisor;
GRANT ALL ON TYPE utility.system_message TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE utility.system_message TO scuola247_user;


--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 1456
-- Name: TYPE week_day; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TYPE utility.week_day FROM scuola247_supervisor;
GRANT ALL ON TYPE utility.week_day TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE utility.week_day TO scuola247_user WITH GRANT OPTION;


--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION day_name(_weekday utility.week_day); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.day_name(_weekday utility.week_day) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.day_name(_weekday utility.week_day) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.day_name(_weekday utility.week_day) TO scuola247_user;


--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 819
-- Name: FUNCTION check_path(_path text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.check_path(_path text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.check_path(_path text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.check_path(_path text) TO scuola247_user;


--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION copyright_notice(); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.copyright_notice() FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.copyright_notice() TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.copyright_notice() TO scuola247_user;


--
-- TOC entry 4339 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION count_value(search_db text, search_schema text, search_table text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.count_value(search_db text, search_schema text, search_table text) FROM PUBLIC;
REVOKE ALL ON FUNCTION utility.count_value(search_db text, search_schema text, search_table text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.count_value(search_db text, search_schema text, search_table text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.count_value(search_db text, search_schema text, search_table text) TO scuola247_relative;
GRANT ALL ON FUNCTION utility.count_value(search_db text, search_schema text, search_table text) TO scuola247_user;


--
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 836
-- Name: FUNCTION delete_file(_file_path text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.delete_file(_file_path text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.delete_file(_file_path text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.delete_file(_file_path text) TO scuola247_user;


--
-- TOC entry 4342 (class 0 OID 0)
-- Dependencies: 668
-- Name: FUNCTION enum2array(_enum anyenum); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.enum2array(_enum anyenum) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.enum2array(_enum anyenum) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.enum2array(_enum anyenum) TO scuola247_user;


--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 938
-- Name: FUNCTION execute_command_query(_query text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.execute_command_query(_query text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.execute_command_query(_query text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.execute_command_query(_query text) TO scuola247_user;


--
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 793
-- Name: FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) TO scuola247_user;


--
-- TOC entry 4347 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION int8(_in_value utility.number_base34, OUT _out_value bigint); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.int8(_in_value utility.number_base34, OUT _out_value bigint) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.int8(_in_value utility.number_base34, OUT _out_value bigint) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.int8(_in_value utility.number_base34, OUT _out_value bigint) TO scuola247_user;


--
-- TOC entry 4348 (class 0 OID 0)
-- Dependencies: 691
-- Name: FUNCTION load_settings(); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.load_settings() FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.load_settings() TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.load_settings() TO scuola247_user;


--
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 676
-- Name: FUNCTION number_base34(_in_value bigint, OUT _out_value utility.number_base34); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.number_base34(_in_value bigint, OUT _out_value utility.number_base34) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.number_base34(_in_value bigint, OUT _out_value utility.number_base34) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.number_base34(_in_value bigint, OUT _out_value utility.number_base34) TO scuola247_user;


--
-- TOC entry 4350 (class 0 OID 0)
-- Dependencies: 740
-- Name: FUNCTION number_base34_pl(utility.number_base34, integer); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.number_base34_pl(utility.number_base34, integer) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.number_base34_pl(utility.number_base34, integer) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.number_base34_pl(utility.number_base34, integer) TO scuola247_user;


--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION read_file(_file_path text, OUT _file_content text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.read_file(_file_path text, OUT _file_content text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.read_file(_file_path text, OUT _file_content text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.read_file(_file_path text, OUT _file_content text) TO scuola247_user;


--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 680
-- Name: FUNCTION set_all_sequences_2_the_max(); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.set_all_sequences_2_the_max() FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.set_all_sequences_2_the_max() TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.set_all_sequences_2_the_max() TO scuola247_user;


--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 804
-- Name: FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) TO scuola247_user;


--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 568
-- Name: FUNCTION show_error(); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.show_error() FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.show_error() TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.show_error() TO scuola247_user;


--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 829
-- Name: FUNCTION strip_tags(text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.strip_tags(text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.strip_tags(text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.strip_tags(text) TO scuola247_user;


--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 715
-- Name: FUNCTION system_messages_locale(_system_messages utility.system_message[], _id integer, OUT _return_message text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.system_messages_locale(_system_messages utility.system_message[], _id integer, OUT _return_message text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.system_messages_locale(_system_messages utility.system_message[], _id integer, OUT _return_message text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.system_messages_locale(_system_messages utility.system_message[], _id integer, OUT _return_message text) TO scuola247_user;


--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION url_decode(encode_url text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.url_decode(encode_url text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.url_decode(encode_url text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.url_decode(encode_url text) TO scuola247_user;


--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 657
-- Name: FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) TO scuola247_user;


--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION write_file(_file_path text, _file_content text); Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON FUNCTION utility.write_file(_file_path text, _file_content text) FROM scuola247_supervisor;
GRANT ALL ON FUNCTION utility.write_file(_file_path text, _file_content text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON FUNCTION utility.write_file(_file_path text, _file_content text) TO scuola247_user;


--
-- TOC entry 4374 (class 0 OID 0)
-- Dependencies: 403
-- Name: TABLE tables; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TABLE utility.tables FROM scuola247_supervisor;
GRANT ALL ON TABLE utility.tables TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TABLE utility.tables TO postgres;


--
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 399
-- Name: TABLE types; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TABLE utility.types FROM scuola247_supervisor;
GRANT ALL ON TABLE utility.types TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TABLE utility.types TO postgres;


--
-- TOC entry 4378 (class 0 OID 0)
-- Dependencies: 405
-- Name: TABLE views; Type: ACL; Schema: utility; Owner: scuola247_supervisor
--

REVOKE ALL ON TABLE utility.views FROM scuola247_supervisor;
GRANT ALL ON TABLE utility.views TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TABLE utility.views TO postgres;


-- Completed on 2018-06-18 12:25:52 CEST

--
-- PostgreSQL database dump complete
--

