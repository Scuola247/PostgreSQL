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
-- Name: unit_testing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA unit_testing;


ALTER SCHEMA unit_testing OWNER TO postgres;

--
-- Name: SCHEMA unit_testing; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA unit_testing IS 'Eenable to use the unit_testing method to test your database';


SET search_path = unit_testing, pg_catalog;

--
-- Name: check_point_status; Type: TYPE; Schema: unit_testing; Owner: postgres
--

CREATE TYPE check_point_status AS ENUM (
    'Failed',
    'Passed',
    'Skipped'
);


ALTER TYPE check_point_status OWNER TO postgres;

--
-- Name: TYPE check_point_status; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TYPE check_point_status IS '<unit_testing>';


--
-- Name: check_point; Type: TYPE; Schema: unit_testing; Owner: postgres
--

CREATE TYPE check_point AS (
	function_name text,
	test_name text,
	checked_at timestamp without time zone,
	status check_point_status,
	message text
);


ALTER TYPE check_point OWNER TO postgres;

--
-- Name: TYPE check_point; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TYPE check_point IS '<unit_testing>';


--
-- Name: unit_test_result; Type: TYPE; Schema: unit_testing; Owner: postgres
--

CREATE TYPE unit_test_result AS (
	check_point check_point,
	error diagnostic.error
);


ALTER TYPE unit_test_result OWNER TO postgres;

--
-- Name: TYPE unit_test_result; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TYPE unit_test_result IS '<unit_testing>';


--
-- Name: build_function_dependencies(text, text[]); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION build_function_dependencies(_before_function_name text, VARIADIC _run_function_names text[] DEFAULT NULL::text[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  full_function_name_matrix	text[];
  schema_name_index 		integer = 1;
  function_name_index 		integer = 2;
  context			text;
  full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  me.full_function_name_matrix=parse_ident(_before_function_name);
--
-- delete all the currente dependencies
-- 
  DELETE FROM unit_testing.dependencies WHERE before_schema_name = me.full_function_name_matrix[schema_name_index]
                                          AND before_function_name = me.full_function_name_matrix[function_name_index];
  IF _run_function_names IS NULL THEN
  ELSE
    INSERT INTO unit_testing.dependencies (before_schema_name, before_function_name, run_schema_name, run_function_name)
                                  SELECT me.full_function_name_matrix[schema_name_index], me.full_function_name_matrix[function_name_index], 'unit_tests', unnest(_run_function_names);
  END IF;
  RETURN;
 END;
$$;


ALTER FUNCTION unit_testing.build_function_dependencies(_before_function_name text, VARIADIC _run_function_names text[]) OWNER TO postgres;

--
-- Name: FUNCTION build_function_dependencies(_before_function_name text, VARIADIC _run_function_names text[]); Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON FUNCTION build_function_dependencies(_before_function_name text, VARIADIC _run_function_names text[]) IS 'test';


--
-- Name: count_unit_tests(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION count_unit_tests() RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  count 		bigint;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT COUNT(*) INTO me.count FROM unit_testing.unit_tests_list;
  RETURN me.count; 
END
$$;


ALTER FUNCTION unit_testing.count_unit_tests() OWNER TO postgres;

--
-- Name: FUNCTION count_unit_tests(); Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON FUNCTION count_unit_tests() IS '<unit_testing>';


--
-- Name: count_unit_tests_level(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION count_unit_tests_level() RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  count 		bigint;
  context		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT COUNT(*) INTO me.count FROM unit_testing.unit_tests_run_level;
  RETURN me.count; 
END
$$;


ALTER FUNCTION unit_testing.count_unit_tests_level() OWNER TO postgres;

--
-- Name: FUNCTION count_unit_tests_level(); Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON FUNCTION count_unit_tests_level() IS '<unit_testing>';


--
-- Name: export_table(text, text); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION export_table(export_schema text, export_table text) RETURNS SETOF text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  results 			record;
  sql_command 			text := '';
  columns_name_list 		text := '';
  columns_placeholder_list 	TEXT := '';
  columns_value_list 		TEXT := '';
  format_string 		TEXT;
  context			text;
  full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  FOR results IN SELECT	attname AS columnname, t.typname AS typename
		   FROM pg_attribute a
                   JOIN pg_type t ON a.atttypid = t.oid
                   JOIN pg_class c on a.attrelid = c.oid
                   JOIN pg_namespace n ON c.relnamespace = n.oid
                  WHERE n.nspname = export_schema
                    AND c.relname = export_table
		    AND a.attnum > 0
                    AND NOT a.attisdropped
	       ORDER BY attnum
  LOOP
    if  results.typename = 'bytea' THEN
    ELSE
      IF columns_name_list = '' THEN
        columns_name_list := results.columnname;
        CASE results.typename
	  WHEN 'int8' THEN
            columns_placeholder_list := '%L';
            columns_value_list := results.columnname || ' * 1000000000';
	  WHEN 'text', 'char', 'varchar' THEN
            columns_placeholder_list := '%L';
            columns_value_list := results.columnname;
          ELSE 
            columns_placeholder_list := '%L';
            columns_value_list := results.columnname;
        END CASE;
      ELSE
        columns_name_list := columns_name_list || ',' || results.columnname;
        CASE results.typename
	  WHEN 'int8' THEN
            columns_placeholder_list := columns_placeholder_list || ',%L';
            columns_value_list := columns_value_list || ',' || results.columnname || ' * 1000000000';
	  WHEN 'text', 'char', 'varchar' THEN
            columns_placeholder_list := columns_placeholder_list || ',%L';
            columns_value_list := columns_value_list || ',' || results.columnname;
          ELSE 
            columns_placeholder_list := columns_placeholder_list || ',%L';
            columns_value_list := columns_value_list || ',' || results.columnname;  
        END CASE;
      END IF;
    END IF; 
  END LOOP;
  format_string := 'INSERT INTO ' || export_schema || '.' || export_table || '(' || columns_name_list || ') VALUES (' || columns_placeholder_list || ');'; 
  sql_command = 'SELECT format(''' || format_string || ''',' || columns_value_list || ') FROM ' || export_schema || '.' || export_table || ';';
  RAISE INFO '%',sql_command;
  RETURN QUERY EXECUTE sql_command;
END;
$$;


ALTER FUNCTION unit_testing.export_table(export_schema text, export_table text) OWNER TO postgres;

--
-- Name: function_versions_synch(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION function_versions_synch() RETURNS void
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  INSERT INTO unit_testing.function_versions AS i (schema_name, function_name, function_xmin) 
                                                   SELECT utv.schema_name, utv.function_name, utv.xmin
                                                     FROM unit_testing.unit_tests_versions utv
                                                    WHERE utv.function_xmin IS NULL;
  UPDATE unit_testing.function_versions as u SET function_xmin = utv.xmin 
                                         FROM unit_testing.unit_tests_versions utv
                                        WHERE u.schema_name = utv.schema_name
                                          AND u.function_name = utv.function_name
                                          AND u.function_xmin <> utv.xmin;
  RETURN;
END
$$;


ALTER FUNCTION unit_testing.function_versions_synch() OWNER TO postgres;

--
-- Name: run(text, boolean, boolean, boolean, bigint, oid, text); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION run(_verbosity text DEFAULT 'warning'::text, _check_functions boolean DEFAULT false, _check_queries boolean DEFAULT false, _check_unit_tests boolean DEFAULT true, _unit_test_set bigint DEFAULT NULL::bigint, _function_oid oid DEFAULT NULL::oid, _note text DEFAULT NULL::text, OUT _current_test bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $_$
<<me>>
DECLARE
  context		    	text;
  full_function_name        	text;
  message_text              	text;
  verbosities               	text[] =  ARRAY['debug5', 'debug4', 'debug3', 'debug2', 'debug1', 'log', 'notice', 'warning', 'error', 'fatal', 'panic'];
  start_at                  	timestamp without time zone;
  end_at                    	timestamp without time zone;
  run_time                  	interval;
  unit_test_start_at        	timestamp without time zone;
  unit_test_end_at          	timestamp without time zone;  
  unit_test_run_time        	interval;
  unit_tests_to_skip        	text[];
  unit_tests_to_add_to_skip 	text[];
  result		    	unit_testing.unit_test_result;
  results                   	unit_testing.unit_test_result[];
  all_results               	unit_testing.unit_test_result[];
  this                      	record;
  should_skip               	boolean = FALSE;
  add_dependencies_to_skip  	boolean;
  unit_test_name            	text;
  sql_command               	text;
  check_point		    	unit_testing.check_point;
  error        		    	diagnostic.error;
  functions_total	    	integer;
  functions_passed          	integer;
  functions_failed          	integer;
  functions_skipped         	integer;
  check_points_total        	integer;
  check_points_passed       	integer;
  check_points_failed       	integer;  
BEGIN
  -- get the full_function_name
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);


  -- check _verbosity parameter
  IF array_position(verbosities, _verbosity) IS NULL THEN
    message_text =  'verbosity wrong value, the value have to be one of: ' || array_to_string(verbosities,',');
    PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
  ELSE
    -- set _verbosity parameter
    EXECUTE 'SET CLIENT_MIN_MESSAGES TO ' || _verbosity;
  END IF;

  -- check mandatory parameter
  IF _check_functions IS NULL THEN
    message_text =  'parameter: ''_check_functions'' IS MANDATORY and therefore cannot be set to null';
    PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
  END IF;

  IF _check_queries IS NULL THEN
    message_text =  'parameter: ''_check_queries'' IS MANDATORY and therefore cannot be set to null';
    PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
  END IF;

  IF _check_unit_tests IS NULL THEN
    message_text =  'parameter: ''_check_unit_tests'' IS MANDATORY and therefore cannot be set to null';
    PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
  END IF;

  IF _verbosity IS NULL THEN
    message_text =  'parameter: ''_verbosity'' IS MANDATORY and therefore cannot be set to null';
    PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
  END IF;

  -- get the start time
  start_at = clock_timestamp()::timestamp;

  RAISE WARNING '************************************************************************************';
  RAISE WARNING '% START %', to_char(start_at, 'HH24:MI:SS.US'), full_function_name;
  RAISE WARNING '************************************************************************************';

  -- check function_version
  RAISE WARNING '% START function synch',to_char(current_timestamp, 'HH24:MI:SS.US');

  BEGIN
    FOR this IN SELECT utv.schema_name, utv.function_name
                  FROM unit_testing.unit_tests_versions utv
                 WHERE utv.function_xmin IS NULL or utv.xmin <> utv.function_xmin
    LOOP
      sql_command = 'SELECT ' || this.schema_name || '.' || this.function_name || '(TRUE);';
      RAISE WARNING '% BUILD dependencies for function: %.%', to_char(current_timestamp, 'HH24:MI:SS.US'), this.schema_name , this.function_name ;
      EXECUTE sql_command;
    END LOOP;
    EXCEPTION
      WHEN OTHERS THEN -- the build option crashes
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        RAISE WARNING '$$$$$$$$$$$$$$$$$$$$$';
        RAISE WARNING 'UNEXPECTED EXCEPTION!';
        RAISE WARNING '$$$$$$$$$$$$$$$$$$$$$';
        PERFORM diagnostic.show(error);
        RAISE plpgsql_error USING MESSAGE = 'in the function: ' || this.schema_name || '.' || this.function_name  || '(boolean) the build option crashes', 
                                   DETAIL = error.message_text,
                                     HINT = 'Call the programmer and check the code';
  END;
  RAISE WARNING '% END   function synch',to_char(current_timestamp, 'HH24:MI:SS.US');
  -- allineo le versioni delle store procedure
  PERFORM unit_testing.function_versions_synch();
  -- check _unit_test_set
  IF _unit_test_set IS NOT NULL THEN
    IF _check_unit_tests OR _function_oid IS NOT NULL THEN
      message_text =  'parameter: _check_unit_tests,  _unit_test_set, _function_oid are mutually exclusive';
      PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
    END IF; 
    PERFORM 1 FROM unit_testing.unit_test_sets uts  WHERE uts.unit_test_set = _unit_test_set ;
    IF NOT FOUND THEN
      message_text =  'unit test set: ' || _unit_test_set ||  ' not found in table: unit_testing.unit_test_sets';
      PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
    END IF;
  END IF;
  
  -- check _function
  IF _function_oid IS NOT NULL THEN
    IF _check_unit_tests OR _unit_test_set IS NOT NULL THEN
      message_text =  'parameter: _check_unit_tests,  _unit_test_set, _function_oid are mutually exclusive';
      PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
    END IF; 
    PERFORM 1 FROM unit_testing.unit_tests_list utl  WHERE utl.oid = _function_oid ;
    IF NOT FOUND THEN
      message_text =  'function: ' || _function_oid ||  ' not found in view: unit_testing.unit_tests_list';
      PERFORM diagnostic.function_syntax_error(full_function_name, message_text);
    END IF;
  END IF;
  
  BEGIN -- execution test (all this block will abort at the end)

    -- check circular reference 
    PERFORM 1 FROM unit_testing.unit_tests_circular_references;
    IF FOUND THEN
      RAISE plpgsql_error USING 
        MESSAGE = 'The table: unit_testing.dependencies contains data that lead to a circular reference.', 
        DETAIL = 'A circular reference was detected (https://en.wikipedia.org/wiki/Circular_reference)',
        HINT = 'Use the ''unit_testing.unit_tests_circular_references'' view to list the relation in error, fix them and rerun the test';
    ELSE
      RAISE WARNING '% CHECK circular references OK !!!',to_char(current_timestamp, 'HH24:MI:SS.US');
    END IF;

    -- check compile functions 
    IF _check_functions THEN
      PERFORM 1 FROM diagnostic.functions_check WHERE level = 'error';
      IF FOUND THEN
        RAISE plpgsql_error USING
          MESSAGE = 'Some functions generate errors', 
	  DETAIL = 'Forcing compile of all database functions some have generate errors',
	  HINT = 'Use the ''diagnostic.functions_check'' view to list the functions with compile erros, fix them and rerun the test';    
      ELSE
        RAISE WARNING '% CHECK functions OK !!!',to_char(current_timestamp, 'HH24:MI:SS.US');
      END IF;
    END IF;

    -- check queries
    IF _check_queries THEN
      PERFORM 1 FROM diagnostic.views_working WHERE works = FALSE;
      IF FOUND THEN
        RAISE plpgsql_error USING
          MESSAGE = 'Some views not working', 
          DETAIL = 'Checking working of all database views some have gone wrong',
	  HINT = 'Use the ''diagnostic.views_working'' view to list the views that not working, fix them and rerun the test';   
      ELSE
        RAISE WARNING '% CHECK query OK !!!',to_char(current_timestamp, 'HH24:MI:SS.US');
      END IF;
    END IF;

    RAISE WARNING '% STARTING UNIT TESTING', to_char(current_timestamp, 'HH24:MI:SS.US');
  
    FOR this IN SELECT l.schema_name, l.function_name, MIN(l.run_level) AS run_level
                  FROM unit_testing.unit_tests_run_level l
                 WHERE (_check_unit_tests = TRUE  AND _unit_test_set IS     NULL AND _function_oid IS     NULL)
                    OR (_check_unit_tests = FALSE AND _unit_test_set IS NOT NULL AND _function_oid IS     NULL AND unit_test_set = _unit_test_set)         
                    OR (_check_unit_tests = FALSE AND _unit_test_set IS     NULL AND _function_oid IS NOT NULL AND oid = _function_oid)
              GROUP BY l.schema_name, l.function_name
              ORDER BY 3, 1, 2

    LOOP
      BEGIN
        unit_test_name = this.schema_name || '.' || this.function_name;
        add_dependencies_to_skip = false;
        should_skip = FALSE;
        
        -- check if the function have to be skip
        SELECT array_position(unit_tests_to_skip, unit_test_name) IS NOT NULL INTO should_skip;
            
        IF should_skip THEN
          add_dependencies_to_skip = true;

          -- add a result test to indicate that the present unit_test was skipped
          check_point.function_name = unit_test_name || '(boolean)';
          check_point.test_name = NULL;
          check_point.checked_at = clock_timestamp()::timestamp;
          check_point.status = 'Skipped';
          check_point.message = 'Unit test skipped because depend on a failed one';
          result.check_point = check_point;
          result.error = NULL;
          all_results = array_append(all_results, result);

          unit_test_end_at = clock_timestamp()::timestamp;
          RAISE WARNING '% SKIPPED! unit test: %', to_char(unit_test_end_at, 'HH24:MI:SS.US'), unit_test_name;

        ELSE
          sql_command = 'SELECT ' || unit_test_name || '();';
          unit_test_start_at = clock_timestamp()::timestamp;
          RAISE WARNING '% START unit test: %',to_char(unit_test_start_at, 'HH24:MI:SS.US'), unit_test_name;

          EXECUTE sql_command INTO results;
          unit_test_end_at = clock_timestamp()::timestamp;
          unit_test_run_time := unit_test_end_at - unit_test_start_at;
          RAISE WARNING '% END     runtime: %',to_char(unit_test_end_at, 'HH24:MI:SS.US'), unit_test_run_time;

          all_results = array_cat(all_results, results);

          -- test if a checkpoint failed
          PERFORM 1 FROM unnest(results) r WHERE (r.check_point).status = 'Failed';
          
          -- add a result test to indicate that the unit test function was Failed or Passed
          IF FOUND THEN 
             add_dependencies_to_skip = true;
             check_point.status = 'Failed';
             check_point.message = 'Unit test function failed because depend on a failed check_point';
          ELSE
             check_point.status = 'Passed';
             check_point.message = 'Unit test function passed because all check_point passed';
          END IF;
          
          check_point.function_name = unit_test_name || '(boolean)';
         -- check_point.test_name = '=== END TESTING ==='; (se lo si mette non funziona la statistica)
          check_point.checked_at = unit_test_end_at;
          result.check_point = check_point;
          result.error = NULL;
          all_results = array_append(all_results, result);

        END IF;

      EXCEPTION WHEN OTHERS THEN
        -- unexptected error from the unit test
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        unit_test_end_at = clock_timestamp()::timestamp;
        unit_test_run_time := unit_test_end_at - unit_test_start_at;
        RAISE WARNING '<<<<<<<<<<<<<<<<<<<<<';
        RAISE WARNING 'END !!! UNIT TEST...: % at: % runtime: %', unit_test_name, unit_test_end_at, unit_test_run_time;
        RAISE WARNING '<<<<<<<<<<<<<<<<<<<<<';
        result = assert.fail(unit_test_name || '(boolean)',NULL,'Unexpected exception raised',error);   
        all_results=array_append(all_results, result);
        add_dependencies_to_skip = TRUE;
      END;
      IF add_dependencies_to_skip THEN
        -- add the unit test that depend on this one to the unit test to skip 
       SELECT array_agg(d.before_schema_name || '.' || d.before_function_name || '()') INTO unit_tests_to_add_to_skip
          FROM unit_testing.dependencies d
         WHERE d.run_schema_name = this.schema_name
           AND d.run_function_name = this.function_name;
        unit_tests_to_skip = array_cat(unit_tests_to_skip, unit_tests_to_add_to_skip);   
      END IF;
    END LOOP;
    RAISE EXCEPTION SQLSTATE 'ZZZZZ'; -- raise the error to abort the transaction and rollback all data updates
  EXCEPTION WHEN SQLSTATE 'ZZZZZ' THEN -- questo è per annullare eventuali modifiche ai dati fatte dai test
            WHEN plpgsql_error THEN
              GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
              result = assert.fail('unit_testing.run()','EXCEPTION plpgsql_error',(error).message_text,error);   
              all_results=array_append(all_results, result);
            WHEN OTHERS THEN -- questo è nel caso, invece, venga generata un' eccezzione per qualsivoglia motivo non gestita e quindi da rilanciare
              GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
              RAISE WARNING '$$$$$$$$$$$$$$$$$$$$$';
              RAISE WARNING 'UNEXPECTED EXCEPTION!';
              RAISE WARNING '$$$$$$$$$$$$$$$$$$$$$';
              PERFORM diagnostic.show(error);
              RAISE plpgsql_error USING MESSAGE = 'in the Functon: ' || full_function_name || ' something was wrong', 
                                        DETAIL = error.message_text,
                                        HINT = 'Call the programmer and check the code';
  END;

  end_at = clock_timestamp()::timestamp;
  run_time := end_at - start_at;

  RAISE WARNING '************************************************************************************';
  RAISE WARNING '% END ! %', to_char(end_at, 'HH24:MI:SS.US'), full_function_name;
  RAISE WARNING '************************************************************************************';

-- store the result
  SELECT nextval('unit_testing.pk_seq') INTO _current_test;

  INSERT INTO unit_testing.tests(test, start_at, end_at, unit_test_set, function_oid, note, check_queries, check_functions, check_unit_tests) 
       VALUES (_current_test, me.start_at, me.end_at, _unit_test_set, _function_oid, _note, _check_queries, _check_functions, _check_unit_tests);

  INSERT INTO unit_testing.tests_details(test, check_point, error)
       SELECT _current_test, * FROM unnest(all_results);

  SELECT "Total", "Passed", "Failed", "Skipped" 
    FROM unit_testing.tests_functions_count_crosstab 
   WHERE test = _current_test
    INTO functions_total, functions_passed, functions_failed, functions_skipped;

  SELECT "Total", "Passed", "Failed" 
    FROM unit_testing.tests_check_points_count_crosstab
   WHERE test = _current_test
    INTO check_points_total , check_points_passed , check_points_failed;

  RAISE WARNING '--------------------------------';
  RAISE WARNING '---------- STATISTICS ----------';
  RAISE WARNING '--------------------------------';
  RAISE WARNING 'Test id.........................: %', _current_test;
  RAISE WARNING 'Test started on.................: %', start_at;
  RAISE WARNING 'Test ended on...................: %', end_at;
  RAISE WARNING 'Test runtime was................: %', run_time;
  RAISE WARNING '     total functions............: %', functions_total;
  RAISE WARNING '     functions passed...........: %', functions_passed;
  RAISE WARNING '     functions failed...........: %', functions_failed;
  RAISE WARNING '     functions skipped..........: %', functions_skipped;
  RAISE WARNING '          total check points....: %', check_points_total;
  RAISE WARNING '          check points passed...: %', check_points_passed;   
  RAISE WARNING '          check points failed...: %', check_points_failed;
 
  SET CLIENT_MIN_MESSAGES TO WARNING;
  RETURN;  
END
$_$;


ALTER FUNCTION unit_testing.run(_verbosity text, _check_functions boolean, _check_queries boolean, _check_unit_tests boolean, _unit_test_set bigint, _function_oid oid, _note text, OUT _current_test bigint) OWNER TO postgres;

--
-- Name: pk_seq; Type: SEQUENCE; Schema: unit_testing; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tests; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE tests (
    test bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone NOT NULL,
    unit_test_set bigint,
    note text,
    check_queries boolean DEFAULT false NOT NULL,
    check_functions boolean DEFAULT false NOT NULL,
    check_unit_tests boolean DEFAULT false NOT NULL,
    function_oid oid
);


ALTER TABLE tests OWNER TO postgres;

--
-- Name: tests_details; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE tests_details (
    tests_detail bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    test bigint NOT NULL,
    check_point check_point,
    error diagnostic.error
);


ALTER TABLE tests_details OWNER TO postgres;

--
-- Name: tests_details_ex; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW tests_details_ex AS
 SELECT tests.test,
    tests.start_at,
    tests.end_at,
    tests.unit_test_set,
    tests.note,
    tests.check_queries,
    tests.check_functions,
    tests.check_unit_tests,
    tests_details.tests_detail,
    (tests_details.check_point).function_name AS function_name,
    (tests_details.check_point).test_name AS test_name,
    (tests_details.check_point).checked_at AS checked_at,
    (tests_details.check_point).status AS status,
    (tests_details.check_point).message AS message,
    (tests_details.error).returned_sqlstate AS returned_sqlstate,
    (tests_details.error).message_text AS message_text,
    (tests_details.error).schema_name AS schema_name,
    (tests_details.error).table_name AS table_name,
    (tests_details.error).column_name AS column_name,
    (tests_details.error).constraint_name AS constraint_name,
    (tests_details.error).pg_exception_context AS pg_exception_context,
    (tests_details.error).pg_exception_detail AS pg_exception_detail,
    (tests_details.error).pg_exception_hint AS pg_exception_hint,
    (tests_details.error).pg_datatype_name AS pg_datatype_name
   FROM (tests
     JOIN tests_details ON ((tests_details.test = tests.test)));


ALTER TABLE tests_details_ex OWNER TO postgres;

--
-- Name: run_ex(text, boolean, boolean, boolean, bigint, oid, text); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION run_ex(_verbosity text DEFAULT 'notice'::text, _check_functions boolean DEFAULT false, _check_queries boolean DEFAULT false, _check_unit_tests boolean DEFAULT true, _unit_test_set bigint DEFAULT NULL::bigint, _function oid DEFAULT NULL::oid, _note text DEFAULT NULL::text) RETURNS SETOF tests_details_ex
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  test			bigint;
  context		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT unit_testing.run(_verbosity, _check_functions, _check_queries, _check_unit_tests, _unit_test_set, _function, _note) INTO me.test;
  RETURN QUERY SELECT *
	         FROM unit_testing.tests_details_ex
	         WHERE tests_details_ex.test = me.test;
END;
$$;


ALTER FUNCTION unit_testing.run_ex(_verbosity text, _check_functions boolean, _check_queries boolean, _check_unit_tests boolean, _unit_test_set bigint, _function oid, _note text) OWNER TO postgres;

--
-- Name: set_continuous_integration(boolean); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION set_continuous_integration(activate boolean) RETURNS text
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  message 		text;
  context		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  DROP EVENT TRIGGER IF EXISTS continuous_integration;
  message = 'Continuous integration deactivated';
  IF activate THEN
    CREATE EVENT TRIGGER continuous_integration ON ddl_command_end 
      WHEN TAG IN (
        'ALTER AGGREGATE',
	'ALTER COLLATION',
	'ALTER CONVERSION',
	'ALTER DOMAIN',
--	'ALTER EXTENSION',
--	'ALTER FOREIGN DATA WRAPPER',
--	'ALTER FOREIGN TABLE',
	'ALTER FUNCTION',
--	'ALTER LANGUAGE',
	'ALTER OPERATOR',
	'ALTER OPERATOR CLASS',
	'ALTER OPERATOR FAMILY',
	'ALTER POLICY',
	'ALTER SCHEMA',
	'ALTER SEQUENCE',
--	'ALTER SERVER',
	'ALTER TABLE',
	'ALTER TEXT SEARCH CONFIGURATION',
	'ALTER TEXT SEARCH DICTIONARY',
	'ALTER TEXT SEARCH PARSER',
	'ALTER TEXT SEARCH TEMPLATE',
	'ALTER TRIGGER',
	'ALTER TYPE',
--	'ALTER USER MAPPING',
	'ALTER VIEW',
	'CREATE AGGREGATE',
--	'COMMENT',
	'CREATE CAST',
	'CREATE COLLATION',
	'CREATE CONVERSION',
	'CREATE DOMAIN',
--	'CREATE EXTENSION',
--	'CREATE FOREIGN DATA WRAPPER',
--	'CREATE FOREIGN TABLE',
	'CREATE FUNCTION',
	'CREATE INDEX',
	'CREATE LANGUAGE',
	'CREATE OPERATOR',
	'CREATE OPERATOR CLASS',
	'CREATE OPERATOR FAMILY',
	'CREATE POLICY',
	'CREATE RULE',
	'CREATE SCHEMA',
	'CREATE SEQUENCE',
--	'CREATE SERVER',
	'CREATE TABLE',
	'CREATE TABLE AS',
	'CREATE TEXT SEARCH CONFIGURATION',
	'CREATE TEXT SEARCH DICTIONARY',
	'CREATE TEXT SEARCH PARSER',
	'CREATE TEXT SEARCH TEMPLATE',
	'CREATE TRIGGER',
	'CREATE TYPE',
--	'CREATE USER MAPPING',
	'CREATE VIEW',
	'DROP AGGREGATE',
	'DROP CAST',
	'DROP COLLATION',
	'DROP CONVERSION',
--	'DROP DOMAIN',
--	'DROP EXTENSION',
--	'DROP FOREIGN DATA WRAPPER',
--	'DROP FOREIGN TABLE',
	'DROP FUNCTION',
	'DROP INDEX',
	'DROP LANGUAGE',
	'DROP OPERATOR',
	'DROP OPERATOR CLASS',
	'DROP OPERATOR FAMILY',
	'DROP OWNED',
	'DROP POLICY',
	'DROP RULE',
	'DROP SCHEMA',
	'DROP SEQUENCE',
--	'DROP SERVER',
	'DROP TABLE',
	'DROP TEXT SEARCH CONFIGURATION',
	'DROP TEXT SEARCH DICTIONARY',
	'DROP TEXT SEARCH PARSER',
	'DROP TEXT SEARCH TEMPLATE',
	'DROP TRIGGER',
	'DROP TYPE',
--	'DROP USER MAPPING',
	'DROP VIEW',
	'GRANT',
--	'IMPORT FOREIGN SCHEMA',
--	'SECURITY LABEL',
--      'SELECT INTO',
	'REVOKE')      
      EXECUTE PROCEDURE unit_testing.tr_continuous_integration();
    message = 'Continuous integration activated';
  END IF;
  RETURN message;
END
$$;


ALTER FUNCTION unit_testing.set_continuous_integration(activate boolean) OWNER TO postgres;

--
-- Name: FUNCTION set_continuous_integration(activate boolean); Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON FUNCTION set_continuous_integration(activate boolean) IS '<unit_testing>';


--
-- Name: show(check_point); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION show(_check_point check_point) RETURNS void
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RAISE NOTICE '=====================';
  RAISE NOTICE '>>>> CHECK POINT <<<<';
  RAISE NOTICE '=====================';
  RAISE NOTICE 'Function name.......: %', _check_point.function_name;
  RAISE NOTICE 'Test name...........: %', _check_point.test_name;
  RAISE NOTICE 'Checked at..........: %', _check_point.checked_at::text;
  RAISE NOTICE 'Status..............: %', _check_point.status::text;
  RAISE NOTICE 'Message.............: %', _check_point.message;
  RAISE NOTICE '=====================';
  RETURN;
END
$$;


ALTER FUNCTION unit_testing.show(_check_point check_point) OWNER TO postgres;

--
-- Name: show_test_errors(bigint); Type: FUNCTION; Schema: unit_testing; Owner: giuliacobels@gmail.com
--

CREATE FUNCTION show_test_errors(_test bigint) RETURNS TABLE(function_name text, test_name text, status check_point_status, message text, returned_sqlstate text, message_text text, schema_name text, table_name text, column_name text, constraint_name text, pg_exception_context text, pg_exception_detail text, pg_exception_hint text, pg_datatype_name text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN QUERY 
    SELECT  
      (utd.check_point).function_name AS function_name,
      (utd.check_point).test_name AS test_name,
      (utd.check_point).status AS status,
      (utd.check_point).message AS message,
      (utd.error).returned_sqlstate AS returned_sqlstate,
      (utd.error).message_text AS message_text,
      (utd.error).schema_name AS schema_name,
      (utd.error).table_name AS table_name,
      (utd.error).column_name AS column_name,
      (utd.error).constraint_name AS constraint_name,
      (utd.error).pg_exception_context AS pg_exception_context,
      (utd.error).pg_exception_detail AS pg_exception_detail,
      (utd.error).pg_exception_hint AS pg_exception_hint,
      (utd.error).pg_datatype_name AS pg_datatype_name
    FROM unit_testing.tests ut
    JOIN unit_testing.tests_details utd ON utd.test = ut.test
   WHERE ut.test = _test
     AND (utd.check_point).status  = 'Failed'
ORDER BY 1,2;
  RETURN;
END
$$;


ALTER FUNCTION unit_testing.show_test_errors(_test bigint) OWNER TO "giuliacobels@gmail.com";

--
-- Name: tr_continuous_integration(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_continuous_integration() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  test_id		bigint;
  context		text;
  full_function_name	text;
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'The test: %L HAD ERRORS !!! Looking table: ''unit_testing.tests_details'' to investigate test results')::utility.system_message,
    ('en', 2, 'For the test: %L. the function ''unit_testing.run()'' run by ''unit_testing.tr_continuous_integration()'' function HAD ERRORS')::utility.system_message,
    ('en', 3, 'Search the ''unit_testing.tests_details'' table to the test results: %L, after finding errors, take the appropriate actions to restore the system functionality')::utility.system_message,
    ('it', 1, 'Il test: %L CONTIENE ERRORI !!! CONTROLLARE LA TABELLA:''unit_testing.tests_details'' e controllare i risultati del test')::utility.system_message,
    ('it', 2, 'Per il test: %L. la funzione ''unit_testing.run()'' eseguita da ''unit_testing.tr_continuous_integration()'', CONTIENE ERRORI!')::utility.system_message,
    ('it', 3, 'Cercare l'' ''unit_testing.tests_details'' tabella dei risultati del test: %L, dopo aver trovato gli errori, prendere adeguate decisioni per sistemare la funzionalità del sistema')::utility.system_message];
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that school_year and degree are of the same school
--
  
  SELECT unit_testing.run('error','FALSE','FALSE','TRUE',NULL,NULL,'automatic test run by ' || full_function_name) into test_id;
  PERFORM 1
    FROM  unit_testing.tests_details 
      WHERE test = test_id
        AND (tests_details.check_point).test_name IS NULL 
        AND (tests_details.check_point).status = 'Failed';
  IF FOUND THEN
    RAISE WARNING USING 
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = format(utility.system_messages_locale(system_messages,1),test_id),
      DETAIL = format(utility.system_messages_locale(system_messages,2),test_id),
      HINT = format(utility.system_messages_locale(system_messages,3),test_id);
  END IF;
   
  RETURN;
END;
$$;


ALTER FUNCTION unit_testing.tr_continuous_integration() OWNER TO postgres;

--
-- Name: tr_dependencies_iu(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_dependencies_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context	text;
  full_function_name text;
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'The before_schema and the before_function doesn''t match with any unit_test functions')::utility.system_message,
    ('en', 2, 'The schema: %L and the function: %L doesn''t match with any unit_test functions')::utility.system_message,
    ('en', 3, 'Check the inserted data and try to re-insert them.')::utility.system_message,
    ('en', 4, 'The run_schema and the run_function doesn''t match with any unit_test functions')::utility.system_message,
    ('en', 5, 'The schema: %L and the function: %L doesn''t match with any unit_test functions')::utility.system_message,
    ('en', 6, 'Check the inserted data and try to re-insert them.')::utility.system_message,
    ('en', 7, 'The circular reference doesn''t end well.')::utility.system_message,
    ('en', 8, 'The schema: %L and the function: %L doesn''t match with any unit_test functions')::utility.system_message,
    ('en', 9, 'Check the inserted data and try to re-insert them.')::utility.system_message,
    ('it', 1, 'il  before_schema e la before_function non coincidono con la funzione di unit_test')::utility.system_message,
    ('it', 2, 'Lo schema: %L e la funzione: %L non corrispondono a nessuna funzione di unit_test')::utility.system_message,
    ('it', 3, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message,
    ('it', 4, 'Lo run_schema e la run_function non coincidono con la funzione di unit_test')::utility.system_message,
    ('it', 5, 'Lo schema: %L e la funzione: %L non corrispondono a nessuna funzione di unit_test')::utility.system_message,
    ('it', 6, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message,
    ('it', 7, 'La referenza circolare non è andata a buon termine')::utility.system_message,
    ('it', 8, 'Lo schema: %L e la funzione %L non corrispondo allo schema: %L e alla funzione: %L')::utility.system_message,
    ('it', 9, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message];
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.full_function_name = diagnostic.full_function_name(me.context);
--
-- check before_schema_name and before_function name are unit_test_functions
--
  PERFORM 1 FROM unit_testing.unit_tests_list utl
	   WHERE utl.schema_name = new.before_schema_name
	     AND utl.function_name  = new.before_function_name;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(me.system_messages,1),
      DETAIL = format(utility.system_messages_locale(me.system_messages,2), new.before_schema_name, new.before_function_name),
      HINT = utility.system_messages_locale(me.system_messages,3);   
  END IF;
--
-- check run_schema_name and run_function name are unit_test_functions
--
  PERFORM 1 FROM unit_testing.unit_tests_list utl
	   WHERE utl.schema_name = new.run_schema_name
	     AND utl.function_name  = new.run_function_name;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
      MESSAGE = utility.system_messages_locale(me.system_messages,4),
      DETAIL = format(utility.system_messages_locale(me.system_messages,5), new.run_schema_name, new.run_function_name),
      HINT = utility.system_messages_locale(me.system_messages,6);	   
  END IF;  
--
-- check circular references
--
  PERFORM 1 FROM unit_testing.unit_tests_circular_references cr;
  IF FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
      MESSAGE = utility.system_messages_locale(me.system_messages,7),
      DETAIL = format(utility.system_messages_locale(me.system_messages,8), new.before_schema_name, new.before_function_name, new.run_schema_name, new.run_function_name),
      HINT = utility.system_messages_locale(me.system_messages,9);
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION unit_testing.tr_dependencies_iu() OWNER TO postgres;

--
-- Name: tr_function_versions_iu(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_function_versions_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context	text;
  function_name text;
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'The schema and the before_function aren''t in the unit_test_functions')::utility.system_message,
    ('en', 2, 'The schema: %L and the before_function:L aren''t in the unit_test_functions')::utility.system_message,
    ('en', 3, 'Check the inserted data and try re-insert them')::utility.system_message,
    ('it', 1, 'Lo schema e la before_function non si trovano in unit_test_functions')::utility.system_message,
    ('it', 2, 'Lo schema: %L e la before_function: %L non si trovano in unit_test_functions')::utility.system_message,
    ('it', 3, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message];
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.function_name = diagnostic.function_name(me.context);
--
-- check schema_name and before_function name are unit_test_functions
--
  PERFORM 1 FROM unit_testing.unit_tests_list utl
	   WHERE utl.schema_name = new.schema_name
	     AND utl.function_name  = new.function_name;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), new.schema_name, new.function_name),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION unit_testing.tr_function_versions_iu() OWNER TO postgres;

--
-- Name: tr_unit_test_sets_details_iu(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_unit_test_sets_details_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context	text;
  function_name text;
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'The dependent_schema and the dependent_function aren''t in ''unit_test_functions''.')::utility.system_message,
    ('en', 2, 'The schema: %L and the function: %L aren''t in the ''unit_test_functions''.')::utility.system_message,
    ('en', 3, 'Check the data inserted and try to insert them.')::utility.system_message,
    ('it', 1, 'Il dependent_schema e il dependent_function non si trovano in '' unit_test_functions''.')::utility.system_message,
    ('it', 2, 'Lo schema: %L e la funzione: %L non sono in ''unit_test_functions''.')::utility.system_message,
    ('it', 3, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message];
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.function_name = diagnostic.function_name(me.context);
--
-- check dependent_schema_name and dependent_function name are unit_test_functions
--
  PERFORM 1 
  FROM unit_testing.unit_tests_list utl
    WHERE utl.schema_name = new.schema_name
      AND utl.function_name  = new.function_name;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), new.schema_name, new.function_name),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION unit_testing.tr_unit_test_sets_details_iu() OWNER TO postgres;

--
-- Name: dependencies; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE dependencies (
    dependency bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    before_schema_name name NOT NULL,
    before_function_name name NOT NULL,
    run_schema_name name NOT NULL,
    run_function_name name NOT NULL,
    CONSTRAINT dependencies_ck_schema_function CHECK ((((before_schema_name)::text || (before_function_name)::text) <> ((run_schema_name)::text || (run_function_name)::text)))
);


ALTER TABLE dependencies OWNER TO postgres;

--
-- Name: TABLE dependencies; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TABLE dependencies IS 'Contains the relationship between tests.
It allows to determine the execution sequence of the various tests';


--
-- Name: function_versions; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE function_versions (
    function_version bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    schema_name name NOT NULL,
    function_name name NOT NULL,
    function_xmin xid NOT NULL
);


ALTER TABLE function_versions OWNER TO postgres;

--
-- Name: TABLE function_versions; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TABLE function_versions IS 'Contains the proc row version (xmin) checked by the unit test framework: if the version differs from that of the Postgres schema the dependencies table have to be update.';


--
-- Name: last_failed_tests_details_ex; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW last_failed_tests_details_ex AS
 SELECT tests.test,
    tests_details.tests_detail,
    (tests_details.check_point).function_name AS function_name,
    (tests_details.check_point).test_name AS test_name,
    (tests_details.check_point).checked_at AS checked_at,
    (tests_details.check_point).message AS message,
    (tests_details.error).returned_sqlstate AS returned_sqlstate,
    (tests_details.error).message_text AS message_text,
    (tests_details.error).schema_name AS schema_name,
    (tests_details.error).table_name AS table_name,
    (tests_details.error).column_name AS column_name,
    (tests_details.error).constraint_name AS constraint_name,
    (tests_details.error).pg_exception_context AS pg_exception_context,
    (tests_details.error).pg_exception_detail AS pg_exception_detail,
    (tests_details.error).pg_exception_hint AS pg_exception_hint,
    (tests_details.error).pg_datatype_name AS pg_datatype_name
   FROM (tests
     JOIN tests_details ON ((tests_details.test = tests.test)))
  WHERE (((tests_details.check_point).status = 'Failed'::check_point_status) AND (tests.test = ( SELECT max(tests_1.test) AS last_test
           FROM tests tests_1)));


ALTER TABLE last_failed_tests_details_ex OWNER TO postgres;

--
-- Name: tests_check_points_count; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW tests_check_points_count AS
 SELECT tests_details.test,
    (tests_details.check_point).status AS status,
    count(tests_details.test) AS count
   FROM tests_details
  WHERE ((tests_details.check_point).test_name IS NOT NULL)
  GROUP BY tests_details.test, (tests_details.check_point).status;


ALTER TABLE tests_check_points_count OWNER TO postgres;

--
-- Name: tests_check_points_count_crosstab; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW tests_check_points_count_crosstab AS
 SELECT crosstab.test,
    COALESCE(crosstab."Failed", 0) AS "Failed",
    COALESCE(crosstab."Passed", 0) AS "Passed",
    COALESCE(crosstab."Skipped", 0) AS "Skipped",
    ((COALESCE(crosstab."Failed", 0) + COALESCE(crosstab."Passed", 0)) + COALESCE(crosstab."Skipped", 0)) AS "Total"
   FROM public.crosstab('SELECT test, status, count FROM unit_testing.tests_check_points_count ORDER BY 1'::text, 'SELECT enum_value FROM utility.enums_values WHERE schema_name = ''unit_testing'' AND enum_name = ''check_point_status'' ORDER BY 1'::text) crosstab(test integer, "Failed" integer, "Passed" integer, "Skipped" integer);


ALTER TABLE tests_check_points_count_crosstab OWNER TO postgres;

--
-- Name: tests_functions_count; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW tests_functions_count AS
 SELECT tests_details.test,
    (tests_details.check_point).status AS status,
    count(tests_details.test) AS count
   FROM tests_details
  WHERE ((tests_details.check_point).test_name IS NULL)
  GROUP BY tests_details.test, (tests_details.check_point).status;


ALTER TABLE tests_functions_count OWNER TO postgres;

--
-- Name: tests_functions_count_crosstab; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW tests_functions_count_crosstab AS
 SELECT crosstab.test,
    COALESCE(crosstab."Failed", 0) AS "Failed",
    COALESCE(crosstab."Passed", 0) AS "Passed",
    COALESCE(crosstab."Skipped", 0) AS "Skipped",
    ((COALESCE(crosstab."Failed", 0) + COALESCE(crosstab."Passed", 0)) + COALESCE(crosstab."Skipped", 0)) AS "Total"
   FROM public.crosstab('SELECT test, status, count FROM unit_testing.tests_functions_count ORDER BY 1'::text, 'SELECT enum_value FROM utility.enums_values WHERE schema_name = ''unit_testing'' AND enum_name = ''check_point_status'' ORDER BY 1'::text) crosstab(test integer, "Failed" integer, "Passed" integer, "Skipped" integer);


ALTER TABLE tests_functions_count_crosstab OWNER TO postgres;

--
-- Name: unit_test_sets; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE unit_test_sets (
    unit_test_set bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description text
);


ALTER TABLE unit_test_sets OWNER TO postgres;

--
-- Name: unit_test_sets_details; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE unit_test_sets_details (
    unit_test_set_detail bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    unit_test_set bigint NOT NULL,
    schema_name text NOT NULL,
    function_name text NOT NULL
);


ALTER TABLE unit_test_sets_details OWNER TO postgres;

--
-- Name: TABLE unit_test_sets_details; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TABLE unit_test_sets_details IS 'Contains the list of functions reletad to a unit test set';


--
-- Name: unit_tests_list; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_list AS
 SELECT p.oid,
    ns.nspname AS schema_name,
    p.proname AS function_name,
    d.description,
    p.xmin
   FROM ((pg_namespace ns
     JOIN pg_proc p ON ((p.pronamespace = ns.oid)))
     LEFT JOIN pg_description d ON ((p.oid = d.objoid)))
  WHERE ((p.prorettype = ('unit_test_result[]'::regtype)::oid) AND (p.pronargs = 1));


ALTER TABLE unit_tests_list OWNER TO postgres;

--
-- Name: VIEW unit_tests_list; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON VIEW unit_tests_list IS 'Return all test function (all function that return an array of unit_test_result)';


--
-- Name: unit_tests_run_level; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_run_level AS
 WITH RECURSIVE dependency_levels(unit_test_set, unit_test_set_description, oid, reference_schema_name, reference_function_name, schema_name, function_name, run_level) AS (
         SELECT uts.unit_test_set,
            uts.description AS unit_test_set_description,
            l.oid,
            l.schema_name AS reference_schema_name,
            l.function_name AS reference_function_name,
            l.schema_name,
            l.function_name,
            count_unit_tests() AS run_level
           FROM ((unit_tests_list l
             LEFT JOIN unit_test_sets_details utsd ON (((utsd.schema_name = (l.schema_name)::text) AND (utsd.function_name = (l.function_name)::text))))
             LEFT JOIN unit_test_sets uts ON ((uts.unit_test_set = utsd.unit_test_set)))
        UNION
         SELECT dl.unit_test_set,
            dl.unit_test_set_description,
            dl.oid,
            dl.reference_schema_name,
            dl.reference_function_name,
            d.run_schema_name AS schema_name,
            d.run_function_name AS function_name,
            (dl.run_level - 1) AS run_level
           FROM (dependency_levels dl
             JOIN dependencies d ON ((((dl.schema_name)::text = (d.before_schema_name)::text) AND ((dl.function_name)::text = (d.before_function_name)::text))))
          WHERE (dl.run_level > 0)
        )
 SELECT dependency_levels.oid,
    dependency_levels.unit_test_set,
    dependency_levels.unit_test_set_description,
    dependency_levels.reference_schema_name,
    dependency_levels.reference_function_name,
    dependency_levels.schema_name,
    dependency_levels.function_name,
    dependency_levels.run_level
   FROM dependency_levels;


ALTER TABLE unit_tests_run_level OWNER TO postgres;

--
-- Name: unit_tests_circular_references; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_circular_references AS
 SELECT DISTINCT utrl.schema_name,
    utrl.function_name
   FROM unit_tests_run_level utrl
  WHERE (utrl.run_level = 0);


ALTER TABLE unit_tests_circular_references OWNER TO postgres;

--
-- Name: VIEW unit_tests_circular_references; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON VIEW unit_tests_circular_references IS 'List all unit_test with cyclic dependencies';


--
-- Name: unit_tests_run_level_tree; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_run_level_tree AS
 SELECT unit_tests_run_level.schema_name,
    unit_tests_run_level.function_name,
    min(unit_tests_run_level.run_level) AS run_level
   FROM unit_tests_run_level
  WHERE (unit_tests_run_level.unit_test_set IS NULL)
  GROUP BY unit_tests_run_level.schema_name, unit_tests_run_level.function_name
  ORDER BY (min(unit_tests_run_level.run_level)), unit_tests_run_level.schema_name, unit_tests_run_level.function_name;


ALTER TABLE unit_tests_run_level_tree OWNER TO postgres;

--
-- Name: unit_tests_versions; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_versions AS
 SELECT utl.schema_name,
    utl.function_name,
    utl.xmin,
    utv.function_xmin,
    utv.function_version
   FROM (unit_tests_list utl
     LEFT JOIN function_versions utv ON (((utl.schema_name = utv.schema_name) AND (utl.function_name = utv.function_name))));


ALTER TABLE unit_tests_versions OWNER TO postgres;

--
-- Name: dependencies dependencies_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pk PRIMARY KEY (dependency);


--
-- Name: dependencies dependencies_uq_all_but_dependency; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_uq_all_but_dependency UNIQUE (before_schema_name, before_function_name, run_schema_name, run_function_name);


--
-- Name: function_versions function_versions_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY function_versions
    ADD CONSTRAINT function_versions_pk PRIMARY KEY (function_version);


--
-- Name: function_versions function_versions_uq_schema_function; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY function_versions
    ADD CONSTRAINT function_versions_uq_schema_function UNIQUE (schema_name, function_name);


--
-- Name: tests_details test_details_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY tests_details
    ADD CONSTRAINT test_details_pk PRIMARY KEY (tests_detail);


--
-- Name: tests tests_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pk PRIMARY KEY (test);


--
-- Name: unit_test_sets_details unit_test_sets_details_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT unit_test_sets_details_pk PRIMARY KEY (unit_test_set_detail);


--
-- Name: unit_test_sets_details unit_test_sets_details_uq_all_but_unit_test_set_detail; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT unit_test_sets_details_uq_all_but_unit_test_set_detail UNIQUE (unit_test_set, schema_name, function_name);


--
-- Name: unit_test_sets unit_test_sets_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets
    ADD CONSTRAINT unit_test_sets_pk PRIMARY KEY (unit_test_set);


--
-- Name: unit_test_sets unit_test_sets_uq_description; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets
    ADD CONSTRAINT unit_test_sets_uq_description UNIQUE (description);


--
-- Name: dependencies_ix_all_but_dependency; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX dependencies_ix_all_but_dependency ON dependencies USING btree (before_schema_name, before_function_name, run_schema_name, run_function_name);


--
-- Name: dependencies_ix_dependent; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX dependencies_ix_dependent ON dependencies USING btree (before_schema_name, before_function_name);


--
-- Name: dependencies_ix_depends_on; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX dependencies_ix_depends_on ON dependencies USING btree (run_schema_name, run_function_name);


--
-- Name: unit_test_sets_details_fi_unit_test_set; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX unit_test_sets_details_fi_unit_test_set ON unit_test_sets_details USING btree (unit_test_set);


--
-- Name: unit_test_sets_details_ix_name_space_function_name; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX unit_test_sets_details_ix_name_space_function_name ON unit_test_sets_details USING btree (schema_name, function_name);


--
-- Name: unit_test_sets_details_ui_all_but_unit_test_set_detail; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX unit_test_sets_details_ui_all_but_unit_test_set_detail ON unit_test_sets_details USING btree (unit_test_set, schema_name, function_name);


--
-- Name: dependencies dependencies_iu; Type: TRIGGER; Schema: unit_testing; Owner: postgres
--

CREATE TRIGGER dependencies_iu AFTER INSERT OR UPDATE ON dependencies FOR EACH ROW EXECUTE PROCEDURE tr_dependencies_iu();


--
-- Name: function_versions function_versions_iu; Type: TRIGGER; Schema: unit_testing; Owner: postgres
--

CREATE TRIGGER function_versions_iu AFTER INSERT OR UPDATE ON function_versions FOR EACH ROW EXECUTE PROCEDURE tr_function_versions_iu();


--
-- Name: unit_test_sets_details unit_test_sets_details_iu; Type: TRIGGER; Schema: unit_testing; Owner: postgres
--

CREATE TRIGGER unit_test_sets_details_iu BEFORE INSERT OR UPDATE ON unit_test_sets_details FOR EACH ROW EXECUTE PROCEDURE tr_unit_test_sets_details_iu();


--
-- Name: tests_details test_detals_fk_tests; Type: FK CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY tests_details
    ADD CONSTRAINT test_detals_fk_tests FOREIGN KEY (test) REFERENCES tests(test) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: unit_test_sets_details test_fk_unit_test_set; Type: FK CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT test_fk_unit_test_set FOREIGN KEY (unit_test_set) REFERENCES unit_test_sets(unit_test_set) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: unit_test_sets_details unit_test_sets_details_fk_unit_test_set; Type: FK CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT unit_test_sets_details_fk_unit_test_set FOREIGN KEY (unit_test_set) REFERENCES unit_test_sets(unit_test_set) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: tr_dependencies_iu(); Type: ACL; Schema: unit_testing; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_dependencies_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_dependencies_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_dependencies_iu() TO scuola247_relative;


--
-- Name: tr_function_versions_iu(); Type: ACL; Schema: unit_testing; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_function_versions_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_function_versions_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_function_versions_iu() TO scuola247_relative;


