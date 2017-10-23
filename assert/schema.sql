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
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: assert; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA assert;


ALTER SCHEMA assert OWNER TO postgres;

--
-- Name: SCHEMA assert; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA assert IS 'Contains all the asserts used in the unit_testing project';


SET search_path = assert, pg_catalog;

--
-- Name: are_equals(text, text, anyarray); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION are_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  are_equal		boolean ;
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  WITH counter      AS ( SELECT * FROM unnest(_param_list) AS item ),
       count_max    AS ( SELECT COUNT(*) AS max FROM counter),
       count_groups AS ( SELECT COUNT(*) AS max FROM counter GROUP BY item LIMIT 1)
  SELECT count_max.max = count_groups.max INTO are_equal
    FROM count_max, count_groups;
  IF are_equal THEN
    _result = assert.pass(_function_name, _test_name, 'the values passed: ' || array_to_string(_param_list, ',', 'NULL') || ' are EQUALS as expected');
  ELSE
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'the values passed: ' || array_to_string(_param_list, ',', 'NULL') || ' are NOT equals but equals was expected', error);
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.are_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION are_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION are_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: are_not_equals(text, text, anyarray); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION are_not_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  are_equal		boolean ;
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  WITH counter      AS ( SELECT * FROM unnest(_param_list) AS item ),
       count_max    AS ( SELECT COUNT(*) AS max FROM counter),
       count_groups AS ( SELECT COUNT(*) AS max FROM counter GROUP BY item LIMIT 1)
  SELECT count_max.max = count_groups.max INTO are_equal
    FROM count_max, count_groups;
  IF are_equal THEN
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'The values passed: ' || array_to_string(_param_list, ',', 'NULL') || ' are EQUALS but not equals was expected', error);
  ELSE
    _result = assert.pass(_function_name, _test_name, 'The values passed: ' || array_to_string(_param_list, ',', 'NULL') || ' are NOT EQUALS as expected');
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.are_not_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION are_not_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION are_not_equals(_function_name text, _test_name text, VARIADIC _param_list anyarray, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: fail(text, text, text, diagnostic.error); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION fail(_function_name text, _test_name text, _message text, _error diagnostic.error, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  my_checkpoint 	unit_testing.check_point;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  my_checkpoint.function_name := _function_name;
  my_checkpoint.test_name := _test_name;
  my_checkpoint.checked_at := clock_timestamp();
  my_checkpoint.status := 'Failed';
  my_checkpoint.message := _message;
  _result.check_point = my_checkpoint;
  _result.error := _error;
  
  PERFORM unit_testing.show(_result.check_point);
  PERFORM diagnostic.show(_result.error);
  RETURN;
END
$$;


ALTER FUNCTION assert.fail(_function_name text, _test_name text, _message text, _error diagnostic.error, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION fail(_function_name text, _test_name text, _message text, _error diagnostic.error, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION fail(_function_name text, _test_name text, _message text, _error diagnostic.error, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: is_false(text, text, boolean); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_false(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  error       		diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  IF(_assert) THEN
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'The assert is TRUE but false was expected', error);
  ELSE
    _result = assert.pass(_function_name, _test_name, 'The assert is FALSE as expected');
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.is_false(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION is_false(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION is_false(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: is_greater_than(text, text, anyelement, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_greater_than(_function_name text, _test_name text, _greater_value anyelement, _less_value anyelement, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  IF(_greater_value > _less_value) THEN
    _result = assert.pass(_function_name, _test_name, 'The value: ' || _greater_value::text || ' is GREATER than the value: ' || _less_value::text || ' as expected');
  ELSE
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'The value: ' || _greater_value::text || ' is LESS or EQUAL than the value: ' || _less_value::text || ' but greater was expected', error);
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.is_greater_than(_function_name text, _test_name text, _greater_value anyelement, _less_value anyelement, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION is_greater_than(_function_name text, _test_name text, _greater_value anyelement, _less_value anyelement, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION is_greater_than(_function_name text, _test_name text, _greater_value anyelement, _less_value anyelement, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: is_less_than(text, text, anyelement, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_less_than(_function_name text, _test_name text, _less_value anyelement, _greater_value anyelement, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  IF(_less_value < _greater_value ) THEN
    error = NULL;
    _result = assert.pass(_function_name, _test_name, 'The value: ' || _less_value::text || ' is LESS than the value: ' || _greater_value::text || ' as expected');
  ELSE
    _result = assert.fail(_function_name, _test_name, 'The value: ' || _less_value::text || ' is GREATER or EQUAL than the value: ' || _greater_value::text || ' but minor was expected', error);
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.is_less_than(_function_name text, _test_name text, _less_value anyelement, _greater_value anyelement, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION is_less_than(_function_name text, _test_name text, _less_value anyelement, _greater_value anyelement, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION is_less_than(_function_name text, _test_name text, _less_value anyelement, _greater_value anyelement, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: is_not_null(text, text, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_not_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  IF(_value IS NULL) THEN
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'The value is NULL but not null was expected', error);
  ELSE
    _result = assert.pass(_function_name, _test_name, 'The value: ' || _value::text || ' is NOT NULL as expected');
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.is_not_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION is_not_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION is_not_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: is_null(text, text, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  IF(_value IS NULL) THEN
    _result = assert.pass(_function_name, _test_name, 'The value is NULL as expected');
  ELSE
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'The value: ' || _value::text || ' is NOT NULL but null was expected', error);
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.is_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION is_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION is_null(_function_name text, _test_name text, _value anyelement, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: is_true(text, text, boolean); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_true(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  IF(_assert) THEN
    _result = assert.pass(_function_name, _test_name, 'The assert is TRUE as expected');
  ELSE
    error = NULL;
    _result = assert.fail(_function_name, _test_name, 'The assert is FALSE but true was expected', error);
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.is_true(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION is_true(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION is_true(_function_name text, _test_name text, _assert boolean, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: pass(text, text, text); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION pass(_function_name text, _test_name text, _message text DEFAULT 'Check point completed with no errors'::text, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  check_point	unit_testing.check_point;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  check_point.function_name = _function_name;
  check_point.test_name = _test_name;
  check_point.checked_at = clock_timestamp();
  check_point.status = 'Passed';
  check_point.message = _message;  
  
  _result.check_point = check_point;
  _result.error = NULL;
  PERFORM unit_testing.show(check_point);
   RETURN;
END
$$;


ALTER FUNCTION assert.pass(_function_name text, _test_name text, _message text, OUT _result unit_testing.unit_test_result) OWNER TO postgres;

--
-- Name: FUNCTION pass(_function_name text, _test_name text, _message text, OUT _result unit_testing.unit_test_result); Type: COMMENT; Schema: assert; Owner: postgres
--

COMMENT ON FUNCTION pass(_function_name text, _test_name text, _message text, OUT _result unit_testing.unit_test_result) IS '<assert>';


--
-- Name: sqlstate_equals(text, text, diagnostic.error, text[]); Type: FUNCTION; Schema: assert; Owner: apiccinno98@gmail.com
--

CREATE FUNCTION sqlstate_equals(_function_name text, _test_name text, _error diagnostic.error, VARIADIC _sqlstates text[], OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE COST 1
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _error.returned_sqlstate = ANY (_sqlstates) THEN
    _result = assert.pass(_function_name, _test_name, format('The sqlstate:%L is EQUAL to one of those allowed: %L', _error.returned_sqlstate, _sqlstates));
  ELSE
    _result = assert.fail(_function_name, _test_name, format('The sqlstate:%L is NOT EQUAL as any of of those allowed: %L', _error.returned_sqlstate, _sqlstates), _error);
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION assert.sqlstate_equals(_function_name text, _test_name text, _error diagnostic.error, VARIADIC _sqlstates text[], OUT _result unit_testing.unit_test_result) OWNER TO "apiccinno98@gmail.com";
