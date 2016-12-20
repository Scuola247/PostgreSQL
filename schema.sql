--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

-- Started on 2016-12-20 13:00:26 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 13 (class 2615 OID 16453)
-- Name: assert; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA assert;


ALTER SCHEMA assert OWNER TO postgres;

--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA assert; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA assert IS 'Contains all the asserts used in the unit_testing project';


--
-- TOC entry 11 (class 2615 OID 16454)
-- Name: diagnostic; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA diagnostic;


ALTER SCHEMA diagnostic OWNER TO postgres;

--
-- TOC entry 12 (class 2615 OID 16456)
-- Name: translate; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA translate;


ALTER SCHEMA translate OWNER TO postgres;

--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA translate; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA translate IS 'Manage the translation of your public schema in another language (more than one). You can translate tables, views and procedures so that your user can work with his/her own language';


--
-- TOC entry 19 (class 2615 OID 16457)
-- Name: unit_testing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA unit_testing;


ALTER SCHEMA unit_testing OWNER TO postgres;

--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 19
-- Name: SCHEMA unit_testing; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA unit_testing IS 'Eenable to use the unit_testing method to test your database';


--
-- TOC entry 17 (class 2615 OID 16458)
-- Name: unit_tests; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA unit_tests;


ALTER SCHEMA unit_tests OWNER TO postgres;

--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 17
-- Name: SCHEMA unit_tests; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA unit_tests IS 'Contains all unit_test functions that use the unit_testing project';


--
-- TOC entry 18 (class 2615 OID 16459)
-- Name: utility; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA utility;


ALTER SCHEMA utility OWNER TO postgres;

--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 18
-- Name: SCHEMA utility; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA utility IS 'Contains all the objects in a database that although very useful are not large enough or numerous enough to warrant a separate scheme';


--
-- TOC entry 2 (class 3079 OID 12395)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 109521)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 7 (class 3079 OID 16469)
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- TOC entry 3 (class 3079 OID 109500)
-- Name: http; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS http WITH SCHEMA public;


--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION http; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION http IS 'HTTP client for PostgreSQL, allows web page retrieval inside the database.';


--
-- TOC entry 4 (class 3079 OID 109463)
-- Name: pldbgapi; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pldbgapi WITH SCHEMA public;


--
-- TOC entry 3947 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pldbgapi; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pldbgapi IS 'server-side support for debugging PL/pgSQL functions';


--
-- TOC entry 6 (class 3079 OID 17081)
-- Name: plpgsql_check; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql_check WITH SCHEMA public;


--
-- TOC entry 3948 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION plpgsql_check; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql_check IS 'extended check for plpgsql functions';


--
-- TOC entry 5 (class 3079 OID 17086)
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- TOC entry 3949 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET search_path = diagnostic, pg_catalog;

--
-- TOC entry 1106 (class 1247 OID 17109)
-- Name: error; Type: TYPE; Schema: diagnostic; Owner: postgres
--

CREATE TYPE error AS (
	returned_sqlstate text,
	message_text text,
	schema_name text,
	table_name text,
	column_name text,
	constraint_name text,
	pg_exception_context text,
	pg_exception_detail text,
	pg_exception_hint text,
	pg_datatype_name text
);


ALTER TYPE error OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 1586 (class 1247 OID 17124)
-- Name: address_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE address_type AS ENUM (
    'Domicile',
    'Work',
    'Residence'
);


ALTER TYPE address_type OWNER TO postgres;

--
-- TOC entry 1587 (class 1247 OID 17131)
-- Name: course_year; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN course_year AS smallint
	CONSTRAINT course_year_range CHECK (((VALUE >= 1) AND (VALUE <= 6)));


ALTER DOMAIN course_year OWNER TO postgres;

--
-- TOC entry 1589 (class 1247 OID 17134)
-- Name: explanation_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE explanation_type AS ENUM (
    'Absent',
    'Late',
    'Leave'
);


ALTER TYPE explanation_type OWNER TO postgres;

--
-- TOC entry 1113 (class 1247 OID 17142)
-- Name: file_extension; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE file_extension AS ENUM (
    '.json',
    '.exe',
    '.pdf',
    '.txt',
    '.png',
    '.jpg',
    '.bmp',
    '.gif',
    '.html'
);


ALTER TYPE file_extension OWNER TO postgres;

--
-- TOC entry 1590 (class 1247 OID 17162)
-- Name: geographical_area; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geographical_area AS ENUM (
    'North-west',
    'North-east',
    'Center',
    'South',
    'Islands'
);


ALTER TYPE geographical_area OWNER TO postgres;

--
-- TOC entry 1118 (class 1247 OID 17174)
-- Name: mime_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE mime_type AS ENUM (
    'application/json',
    'application/octet-stream',
    'application/pdf',
    'text/plain',
    'image/png',
    'image/jpg',
    'image/bmp',
    'image/gif',
    'text/html'
);


ALTER TYPE mime_type OWNER TO postgres;

--
-- TOC entry 1121 (class 1247 OID 17193)
-- Name: mime_type_image; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN mime_type_image AS mime_type
	CONSTRAINT mime_types_image_list CHECK ((VALUE = ANY (ARRAY['image/png'::mime_type, 'image/jpg'::mime_type, 'image/bmp'::mime_type, 'image/gif'::mime_type])));


ALTER DOMAIN mime_type_image OWNER TO postgres;

--
-- TOC entry 1123 (class 1247 OID 17197)
-- Name: image; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE image AS (
	mime_type mime_type_image,
	content bytea
);


ALTER TYPE image OWNER TO postgres;

--
-- TOC entry 1591 (class 1247 OID 17199)
-- Name: language; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE language AS ENUM (
    'it',
    'en',
    'de'
);


ALTER TYPE language OWNER TO postgres;

--
-- TOC entry 1592 (class 1247 OID 17206)
-- Name: marital_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE marital_status AS ENUM (
    'Single',
    'Married',
    'Widowed',
    'Separated'
);


ALTER TYPE marital_status OWNER TO postgres;

--
-- TOC entry 1593 (class 1247 OID 17215)
-- Name: period_lesson; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN period_lesson AS smallint
	CONSTRAINT period_lesson_range CHECK (((VALUE >= 1) AND (VALUE <= 24)));


ALTER DOMAIN period_lesson OWNER TO postgres;

--
-- TOC entry 1595 (class 1247 OID 17218)
-- Name: qualificationtion_types; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE qualificationtion_types AS ENUM (
    'Root',
    'Axis',
    'Expertise',
    'Knowledge',
    'Skill'
);


ALTER TYPE qualificationtion_types OWNER TO postgres;

--
-- TOC entry 1596 (class 1247 OID 17230)
-- Name: relationships; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE relationships AS ENUM (
    'Parent',
    'Brother/Sister',
    'Grandparent',
    'Uncle/Aunt',
    'Tutor'
);


ALTER TYPE relationships OWNER TO postgres;

--
-- TOC entry 1597 (class 1247 OID 17242)
-- Name: role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE role AS ENUM (
    'Student',
    'Employee',
    'Executive',
    'Teacher',
    'Relative',
    'Supervisor'
);


ALTER TYPE role OWNER TO postgres;

--
-- TOC entry 1598 (class 1247 OID 17256)
-- Name: sex; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE sex AS ENUM (
    'M',
    'F'
);


ALTER TYPE sex OWNER TO postgres;

--
-- TOC entry 1138 (class 1247 OID 17261)
-- Name: test_result; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN test_result AS text;


ALTER DOMAIN test_result OWNER TO postgres;

--
-- TOC entry 1599 (class 1247 OID 17262)
-- Name: week; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN week AS smallint
	CONSTRAINT week_range CHECK (((VALUE >= 1) AND (VALUE <= 4)));


ALTER DOMAIN week OWNER TO postgres;

--
-- TOC entry 1601 (class 1247 OID 17264)
-- Name: week_day; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN week_day AS smallint
	CONSTRAINT week_day_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN week_day OWNER TO postgres;

--
-- TOC entry 1139 (class 1247 OID 17267)
-- Name: wikimedia_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE wikimedia_type AS ENUM (
    'Female portrait',
    'Male portrait'
);


ALTER TYPE wikimedia_type OWNER TO postgres;

SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 1142 (class 1247 OID 17272)
-- Name: check_point_status; Type: TYPE; Schema: unit_testing; Owner: postgres
--

CREATE TYPE check_point_status AS ENUM (
    'Failed',
    'Passed',
    'Skipped'
);


ALTER TYPE check_point_status OWNER TO postgres;

--
-- TOC entry 1145 (class 1247 OID 17281)
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
-- TOC entry 1148 (class 1247 OID 17284)
-- Name: unit_test_result; Type: TYPE; Schema: unit_testing; Owner: postgres
--

CREATE TYPE unit_test_result AS (
	check_point check_point,
	error diagnostic.error
);


ALTER TYPE unit_test_result OWNER TO postgres;

SET search_path = utility, pg_catalog;

--
-- TOC entry 1151 (class 1247 OID 17285)
-- Name: week_day; Type: DOMAIN; Schema: utility; Owner: postgres
--

CREATE DOMAIN week_day AS smallint
	CONSTRAINT week_day_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN week_day OWNER TO postgres;

SET search_path = assert, pg_catalog;

--
-- TOC entry 534 (class 1255 OID 17287)
-- Name: are_equal(anyarray); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION are_equal(VARIADIC anyarray, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
    DECLARE count integer=0;
    DECLARE total_items bigint;
    DECLARE total_rows bigint;
BEGIN
    result := false;
    
    WITH counter
    AS
    (
        SELECT *
        FROM unnest($1) AS items
    )
    SELECT
        COUNT(items),
        COUNT(*)
    INTO
        total_items,
        total_rows
    FROM counter;

    IF(total_items = 0 OR total_items = total_rows) THEN
        result := true;
    END IF;

    IF(result AND total_items > 0) THEN
        SELECT COUNT(DISTINCT $1[s.i])
        INTO count
        FROM generate_series(array_lower($1,1), array_upper($1,1)) AS s(i)
        ORDER BY 1;

        IF count <> 1 THEN
            result := FALSE;
        END IF;
    END IF;

    IF(NOT result) THEN
        message := 'ASSERT ARE_EQUAL FAILED.';  
        PERFORM assert.fail(message);
        RETURN;
    END IF;

    message := 'Asserts are equal.';
    PERFORM assert.ok(message);
    result := true;
    RETURN;
END
$_$;


ALTER FUNCTION assert.are_equal(VARIADIC anyarray, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 535 (class 1255 OID 17288)
-- Name: are_not_equal(anyarray); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION are_not_equal(VARIADIC anyarray, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
    DECLARE count integer=0;
    DECLARE count_nulls bigint;
BEGIN    
    SELECT COUNT(*)
    INTO count_nulls
    FROM unnest($1) AS items
    WHERE items IS NULL;

    SELECT COUNT(DISTINCT $1[s.i]) INTO count
    FROM generate_series(array_lower($1,1), array_upper($1,1)) AS s(i)
    ORDER BY 1;
    
    IF(count + count_nulls <> array_upper($1,1) OR count_nulls > 1) THEN
        message := 'ASSERT ARE_NOT_EQUAL FAILED.';  
        PERFORM assert.fail(message);
        RESULT := FALSE;
        RETURN;
    END IF;

    message := 'Asserts are not equal.';
    PERFORM assert.ok(message);
    result := true;
    RETURN;
END
$_$;


ALTER FUNCTION assert.are_not_equal(VARIADIC anyarray, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 17289)
-- Name: fail(text, text, text, diagnostic.error); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION fail(_function_name text, _test_name text, _message text, _error diagnostic.error, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql
    AS $$
DECLARE
  my_checkpoint unit_testing.check_point;
BEGIN

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
-- TOC entry 537 (class 1255 OID 17290)
-- Name: is_equal(anyelement, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_equal(have anyelement, want anyelement, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1 IS NOT DISTINCT FROM $2) THEN
        message := 'Assert is equal.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_EQUAL FAILED.\n\nHave -> ' || COALESCE($1::text, 'NULL') || E'\nWant -> ' || COALESCE($2::text, 'NULL') || E'\n';    
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_equal(have anyelement, want anyelement, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 538 (class 1255 OID 17291)
-- Name: is_false(boolean); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_false(boolean, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF(NOT $1) THEN
        message := 'Assert is false.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_FALSE FAILED. A false condition was expected.\n\n\n';    
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_false(boolean, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 539 (class 1255 OID 17292)
-- Name: is_greater_than(anyelement, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_greater_than(x anyelement, y anyelement, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1 > $2) THEN
        message := 'Assert greater than condition is satisfied.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_GREATER_THAN FAILED.\n\n X : -> ' || COALESCE($1::text, 'NULL') || E'\n is not greater than Y:   -> ' || COALESCE($2::text, 'NULL') || E'\n';    
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_greater_than(x anyelement, y anyelement, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 540 (class 1255 OID 17293)
-- Name: is_less_than(anyelement, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_less_than(x anyelement, y anyelement, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1 < $2) THEN
        message := 'Assert less than condition is satisfied.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_LESS_THAN FAILED.\n\n X : -> ' || COALESCE($1::text, 'NULL') || E'\n is not less than Y:   -> ' || COALESCE($2::text, 'NULL') || E'\n';  
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_less_than(x anyelement, y anyelement, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 541 (class 1255 OID 17294)
-- Name: is_not_equal(anyelement, anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_not_equal(already_have anyelement, dont_want anyelement, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1 IS DISTINCT FROM $2) THEN
        message := 'Assert is not equal.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_NOT_EQUAL FAILED.\n\nAlready Have -> ' || COALESCE($1::text, 'NULL') || E'\nDon''t Want   -> ' || COALESCE($2::text, 'NULL') || E'\n';   
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_not_equal(already_have anyelement, dont_want anyelement, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 542 (class 1255 OID 17295)
-- Name: is_not_null(anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_not_null(anyelement, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1 IS NOT NULL) THEN
        message := 'Assert is not NULL.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_NOT_NULL FAILED. The value is NULL.\n\n\n';  
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_not_null(anyelement, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 17296)
-- Name: is_null(anyelement); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_null(anyelement, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1 IS NULL) THEN
        message := 'Assert is NULL.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_NULL FAILED. NULL value was expected.\n\n\n';    
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_null(anyelement, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 544 (class 1255 OID 17297)
-- Name: is_true(boolean); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION is_true(boolean, OUT message text, OUT result boolean) RETURNS record
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF($1) THEN
        message := 'Assert is true.';
        PERFORM assert.ok(message);
        result := true;
        RETURN;
    END IF;
    
    message := E'ASSERT IS_TRUE FAILED. A true condition was expected.\n\n\n';  
    PERFORM assert.fail(message);
    result := false;
    RETURN;
END
$_$;


ALTER FUNCTION assert.is_true(boolean, OUT message text, OUT result boolean) OWNER TO postgres;

--
-- TOC entry 545 (class 1255 OID 17298)
-- Name: pass(text, text, text); Type: FUNCTION; Schema: assert; Owner: postgres
--

CREATE FUNCTION pass(_function_name text, _test_name text, _message text DEFAULT 'Check point completed with no errors'::text, OUT _result unit_testing.unit_test_result) RETURNS unit_testing.unit_test_result
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
  check_point unit_testing.check_point;
BEGIN

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

SET search_path = diagnostic, pg_catalog;

--
-- TOC entry 546 (class 1255 OID 17299)
-- Name: function_exists(regprocedure); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION function_exists(_function_signature regprocedure, OUT _found boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
BEGIN
  PERFORM 1 FROM diagnostic.functions_list WHERE function_signature = _function_signature;
  _found = FOUND;
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.function_exists(_function_signature regprocedure, OUT _found boolean) OWNER TO postgres;

--
-- TOC entry 710 (class 1255 OID 17300)
-- Name: function_name(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION function_name(_context text, OUT _function_name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
BEGIN
  _function_name = (regexp_matches(_context, 'funzione PL\/pgSQL (.*?\))'))[1];
  IF _function_name IS NULL THEN -- tento in inglese
      _function_name = (regexp_matches(_context, 'PL\/pgSQL function(.*?\))'))[1];
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.function_name(_context text, OUT _function_name text) OWNER TO postgres;

--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION function_name(_context text, OUT _function_name text); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION function_name(_context text, OUT _function_name text) IS 'The function return the current function name, this is dependent from the language choose from client, so you have to customize the function for language other than italian.
You can also change the code to manage multiple languade (please send me back your code)
The tipcal usage is:
$BODY$
<<me>>
DECLARE
  context text;
BEGIN
  get diagnostics me.context = pg_context;
  RETURN utility.function_name(me.context);
END
$BODY$
I would prefer something like: 
me.function_name = function_name();
But you have to manage the different ways you function will called (from another function, from pgadmin)';


--
-- TOC entry 547 (class 1255 OID 17301)
-- Name: function_syntax_error(text, text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION function_syntax_error(_function_name text, _message_text text) RETURNS void
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
  function_signature_ex  text;
  function_description   text;
BEGIN
  SELECT p.proname || '(' || pg_get_function_arguments(oid) || ')', obj_description(oid,'pg_proc') INTO function_signature_ex, function_description FROM pg_proc p WHERE oid = _function_name::regprocedure::oid;
  IF function_description IS NULL THEN
    function_description = 'N/A';
  END IF;
  RAISE invalid_parameter_value USING MESSAGE = 'FUNCTION SYNTAX: ' || _message_text, 
                                DETAIL = 'FUNCTION SYNTAX: ' || function_signature_ex, 
                                HINT = 'Check the parameters and rerun the command, FUNCTION DESCRIPTION: ' || function_description;
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.function_syntax_error(_function_name text, _message_text text) OWNER TO postgres;

--
-- TOC entry 548 (class 1255 OID 17302)
-- Name: if_function_compile(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION if_function_compile(_function_signature text, OUT _compile boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
BEGIN
  PERFORM 1 FROM diagnostic.functions_check WHERE function_signature::text = _function_signature AND level = 'error';
  IF FOUND THEN
    _compile = FALSE;
  ELSE 
    _compile =  TRUE;
  END IF;
END;
$$;


ALTER FUNCTION diagnostic.if_function_compile(_function_signature text, OUT _compile boolean) OWNER TO postgres;

--
-- TOC entry 549 (class 1255 OID 17303)
-- Name: if_view_works(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION if_view_works(_view_name text, OUT _works boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  sql_command		text;
  error	diagnostic.error;
BEGIN
  _works = TRUE;
  BEGIN
    sql_command := 'SELECT * FROM ' || _view_name || ' WHERE FALSE;';
    EXECUTE sql_command;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _works = FALSE;
    PERFORM diagnostic.show(error);
  END;
RETURN;
END;
$$;


ALTER FUNCTION diagnostic.if_view_works(_view_name text, OUT _works boolean) OWNER TO postgres;

--
-- TOC entry 550 (class 1255 OID 17304)
-- Name: show(error); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION show(_error error) RETURNS void
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
  RAISE NOTICE '=====================';
  RAISE NOTICE '>>>>>>> ERROR <<<<<<<';
  RAISE NOTICE '=====================';
  RAISE NOTICE 'Sqlcode.............: %', _error.returned_sqlstate;
  RAISE NOTICE 'Message.............: %', _error.message_text;
  RAISE NOTICE 'Schema..............: %', _error.schema_name;
  RAISE NOTICE 'Table...............: %', _error.table_name;
  RAISE NOTICE 'Column..............: %', _error.column_name;
  RAISE NOTICE 'Constraint..........: %', _error.constraint_name;
  RAISE NOTICE 'Exception context...: %', _error.pg_exception_context;
  RAISE NOTICE 'Exception detail....: %', _error.pg_exception_detail;
  RAISE NOTICE 'Exception hint......: %', _error.pg_exception_hint;
  RAISE NOTICE 'Datatype............: %', _error.pg_datatype_name;
  RAISE NOTICE '=====================';
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.show(_error error) OWNER TO postgres;

--
-- TOC entry 551 (class 1255 OID 17305)
-- Name: test_function_name(); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION test_function_name() RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  context text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  RETURN diagnostic.function_name(me.context);
END
$$;


ALTER FUNCTION diagnostic.test_function_name() OWNER TO postgres;

--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 551
-- Name: FUNCTION test_function_name(); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION test_function_name() IS 'Show the correct use of function_name function';


SET search_path = public, pg_catalog;

--
-- TOC entry 587 (class 1255 OID 17313)
-- Name: classroom_students_ex(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classroom_students_ex(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT classroom,
		       student,
		       COALESCE(thumbnail,thumbnail_default()) as thumbnail,
		       tax_code,
		       name,
		       surname,
		       sex,
		       born,
		       city_of_birth_description,
		       absences,
		       absences_not_explained,
		       delays,
		       delays_not_explained,
		       leavings,
		       leavings_not_explained,
		       out_of_classrooms,
		       notes
		  FROM classrooms_students_ex
		 WHERE classroom = p_classroom
	      ORDER BY surname, name, tax_code;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.classroom_students_ex(p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 589 (class 1255 OID 17314)
-- Name: classrooms_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classrooms_list(p_school_year bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
				 
DECLARE

	cur refcursor;
	function_name varchar = 'classrooms_list';

BEGIN

	OPEN cur FOR SELECT xmin::text::bigint AS rv, classroom, school_year, degree, section, course_year, description, building
		       FROM classrooms
	              WHERE school_year = p_school_year
	           ORDER BY description;

	RETURN cur;
END;
$$;


ALTER FUNCTION public.classrooms_list(p_school_year bigint) OWNER TO postgres;

--
-- TOC entry 590 (class 1255 OID 17315)
-- Name: classrooms_students_addresses_ex_by_classroom(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classrooms_students_addresses_ex_by_classroom(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT classroom,
                       student,
                       name,
                       surname,
                       tax_code,
                       sex,
                       born,
                       city_of_birth,
                       street,
                       zip_code,
                       city,
                       province,
                       absences
		  FROM classrooms_students_addresses_ex
		 WHERE classroom = p_classroom
	      ORDER BY surname, name, tax_code;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.classrooms_students_addresses_ex_by_classroom(p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 552 (class 1255 OID 17316)
-- Name: file_extension(mime_type); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION file_extension(p_mime_type mime_type) RETURNS file_extension
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */			 
DECLARE
  function_name varchar = 'file_extension(mime_type)';
BEGIN
  CASE p_mime_type
    WHEN 'application/json' THEN RETURN '.json'::file_extension;
    WHEN 'application/octet-stream' THEN RETURN '.exe'::file_extension;
    WHEN 'application/pdf' THEN RETURN '.pdf'::file_extension;
    WHEN 'text/plain' THEN RETURN '.txt'::file_extension;
    WHEN 'image/png' THEN RETURN '.png'::file_extension;
    WHEN 'image/jpg' THEN RETURN '.jpg'::file_extension;
    WHEN 'image/bmp' THEN RETURN '.bmp'::file_extension;
    WHEN 'image/gif' THEN RETURN '.gif'::file_extension;
    WHEN 'text/html' THEN RETURN '.html'::file_extension;
    WHEN NULL THEN RETURN NULL::file_extension;
    ELSE RAISE EXCEPTION USING
           ERRCODE = my_sqlcode(function_name,'1'),
           MESSAGE = utility.system_messages_locale('public',function_name,1),
           DETAIL = format(utility.system_messages_locale('public',function_name,2), p_mime_type),
           HINT = utility.system_messages_locale('public',function_name,3);
  END CASE;
END;
$$;


ALTER FUNCTION public.file_extension(p_mime_type mime_type) OWNER TO postgres;

--
-- TOC entry 588 (class 1255 OID 17317)
-- Name: grade_types_by_subject(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grade_types_by_subject(p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       grade_type,
		       description
		  FROM grade_types
		 WHERE subject = p_subject
	      ORDER BY description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.grade_types_by_subject(p_subject bigint) OWNER TO postgres;

--
-- TOC entry 591 (class 1255 OID 17318)
-- Name: grades_by_metric(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grades_by_metric(p_metric bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       grade,
		       metric,
		       description,
		       mnemonic,
		       thousandths
		  FROM grades
		 WHERE metric = p_metric
	      ORDER BY thousandths;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.grades_by_metric(p_metric bigint) OWNER TO postgres;

--
-- TOC entry 592 (class 1255 OID 17319)
-- Name: grid_valutations_columns_by_classroom_teacher_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grid_valutations_columns_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT DISTINCT va.on_date AS on_date,
			       va.grade_type AS grade_type,
                               tv.description AS grade_type_description,
                               COALESCE(a.topic,0) AS topic,
			       COALESCE(a.description,'') AS topic_description,
                               m.metric as metric,
                               m.description AS metric_description
                          FROM valutations va
			  LEFT JOIN topics a ON a.topic = va.topic 
			  JOIN grade_types tv ON tv.grade_type = va.grade_type
			  JOIN grades vo ON vo.grade = va.grade
			  JOIN metrics m ON m.metric = vo.metric
			 WHERE va.classroom = p_classroom
			   AND va.teacher = p_teacher
			   AND va.subject = p_subject
		      ORDER BY on_date, grade_type_description, topic, metric;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.grid_valutations_columns_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) OWNER TO postgres;

--
-- TOC entry 593 (class 1255 OID 17320)
-- Name: grid_valutations_rows_by_classroom_teacher_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grid_valutations_rows_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) RETURNS TABLE(student bigint, surname character varying, name character varying, absences integer, delays integer, leavings integer, out_of_classroom integer, notes integer, faults integer, behavior character varying, rvs bigint[], valutations bigint[], grades bigint[])
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
	v_days character varying[];
	v_student record;
	v_valutation record;
	v_grading_meeting bigint;
	v_behavior bigint;
	v_school_year bigint;
	i integer;
BEGIN 

v_days :=  ARRAY( SELECT DISTINCT va.on_date || to_char(va.grade_type,'0000000000000000000') || to_char(COALESCE(va.topic,0),'0000000000000000000')  || to_char(vo.metric,'0000000000000000000')
			       FROM valutations va
			       JOIN grades vo ON vo.grade = va.grade 
			      WHERE va.classroom = p_classroom
			        AND va.teacher = p_teacher
			        AND va.subject = p_subject
		           ORDER BY 1);

SELECT i.behavior INTO v_behavior
  FROM schools i
  JOIN subjects m ON m.school = i.school
 WHERE subject = p_subject;

 SELECT school_year INTO v_school_year
   FROM classrooms
  WHERE classroom = p_classroom;

SELECT grading_meeting into v_grading_meeting
  FROM grading_meetings
 WHERE school_year = v_school_year
   AND on_date IN (SELECT MAX(on_date) 
		  FROM grading_meetings
		 WHERE school_year = v_school_year
		   AND close = true);
   		           
FOR v_student IN SELECT p.person AS student,
	               p.surname AS surname,
		       p.name AS name,
		       COALESCE(a.absences,0) AS absences,
		       COALESCE(r.delays,0) AS delays,
		       COALESCE(u.leavings,0) AS leavings,
		       COALESCE(fc.out_of_classrooms,0) AS out_of_classroom,
		       COALESCE(n.notes,0) AS notes,
		       COALESCE(m.faults,0) AS faults,
		       COALESCE(v.mnemonic,'N/D') AS behavior
	          FROM classrooms_students ca 
	          JOIN persons p ON ca.student = p.person
	          LEFT JOIN absences_grp a ON a.classroom = ca.classroom AND a.student = ca.student
	          LEFT JOIN delays_grp r ON r.classroom = ca.classroom AND r.student = ca.student
	          LEFT JOIN leavings_grp u ON u.classroom = ca.classroom AND u.student = ca.student
	          LEFT JOIN out_of_classrooms_grp fc ON fc.classroom = ca.classroom AND fc.student = ca.student
	          LEFT JOIN notes_grp n ON n.classroom = ca.classroom AND n.student = ca.student
	          LEFT JOIN faults_grp m ON m.classroom = ca.classroom AND m.student = ca.student
	          LEFT JOIN (SELECT svi.classroom, svi.student, svi.grade 
	                       FROM grading_meetings_valutations svi
	                      WHERE svi.grading_meeting = v_grading_meeting
				AND svi.subject = v_behavior) AS sv ON sv.classroom = ca.classroom AND sv.student = ca.student
	          LEFT JOIN grades v ON v.grade = sv.grade
	         WHERE ca.classroom = p_classroom
	       ORDER BY p.surname, p.name, p.tax_code
LOOP
	student := v_student.student;
	surname := v_student.surname;
	name := v_student.name;
	absences := v_student.absences;
	delays := v_student.delays;
	leavings := v_student.leavings;
	out_of_classroom := v_student.out_of_classroom;
	notes := v_student.notes;
	faults := v_student.faults;
	behavior := v_student.behavior;
	rvs := null;
        valutations := null;
	grades := null;

	i := 1;

	RAISE NOTICE 'student... : % % %', v_student.student, v_student.surname, v_student.name;
	RAISE NOTICE 'i-------------------... : %', i;

	FOR v_valutation IN SELECT va.on_date || to_char(va.grade_type,'0000000000000000000') || to_char(COALESCE(va.topic,0),'0000000000000000000') || to_char(vo.metric,'0000000000000000000')  AS on_date ,
				    va.xmin::text::bigint AS rv,
				    va.valutation,
	                            va.grade
	                       FROM valutations va
	                       JOIN grades vo ON vo.grade = va.grade
	                      WHERE va.classroom = p_classroom
	                        AND va.subject = p_subject
	                        AND va.teacher = p_teacher
	                        AND va.student = v_student.student
	                   ORDER BY 1
	LOOP    
		RAISE NOTICE 'v_valutation.on_date... : %', v_valutation.on_date;
		RAISE NOTICE 'v_days[i]............ : %', v_days[i];
		
		WHILE v_days[i] < v_valutation.on_date AND i <= array_length(v_days,1) LOOP
			rvs[i] = null;
			valutations[i] = null;
			grades[i] = null;
			RAISE NOTICE '(a) v_days[i]............ : %', v_days[i];
			RAISE NOTICE 'i.......................... : %', i;
			i := i + 1;
		END LOOP;
		IF i <= array_length(v_days,1) THEN
			rvs[i] = v_valutation.rv;
			valutations[i] = v_valutation.valutation;
			grades[i] = v_valutation.grade;
			RAISE NOTICE '(b) v_valutation.on_date... : %', v_valutation.on_date;
			RAISE NOTICE '(b) v_days[i]............ : %', v_days[i];
			RAISE NOTICE 'i.......................... : %', i;
			i := i + 1;
		END IF;
	END LOOP;
	WHILE i <= array_length(v_days,1) LOOP
		RAISE NOTICE '(c) v_days[i]............ : %', v_days[i];
		RAISE NOTICE 'i.......................... : %', i;
		rvs[i] = null;
		valutations[i] = null;
		grades[i] = null;
		i := i +1;
	END LOOP;
	RETURN NEXT;
END LOOP;	        
END;
$$;


ALTER FUNCTION public.grid_valutations_rows_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) OWNER TO postgres;

--
-- TOC entry 594 (class 1255 OID 17322)
-- Name: in_rule(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_rule(p_rule character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	PERFORM 1 FROM persons_roles pr
	          JOIN persons p ON p.person = pr.person 
	          JOIN db_users u ON u.db_user = p.db_user
	         WHERE u.usename = session_user
	           AND pr.rule = p_rule::rule;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_rule(p_rule character varying) OWNER TO postgres;

--
-- TOC entry 3972 (class 0 OID 0)
-- Dependencies: 594
-- Name: FUNCTION in_rule(p_rule character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION in_rule(p_rule character varying) IS 'Il comando  restituisce TRUE o FALSE a seconfrom_time se l''db_user collegato Ã¨ abilitato to_time rule indicato in input';


--
-- TOC entry 595 (class 1255 OID 17323)
-- Name: in_rule(character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_rule(p_rule character varying, p_person bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM persons_roles
	         WHERE person  = p_person
	           AND rule = p_rule::rule;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_rule(p_rule character varying, p_person bigint) OWNER TO postgres;

--
-- TOC entry 3974 (class 0 OID 0)
-- Dependencies: 595
-- Name: FUNCTION in_rule(p_rule character varying, p_person bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION in_rule(p_rule character varying, p_person bigint) IS 'Il comando  restituisce TRUE o FALSE a seconfrom_time se la person indicata in input Ã¨ abilitata to_time rule indicato in input';


--
-- TOC entry 596 (class 1255 OID 17324)
-- Name: in_rule(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_rule(p_rule character varying, p_usename character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM persons_roles pr
	          JOIN persons p ON p.person = pr.person 
	          JOIN db_users u ON u.db_user = p.db_user
	         WHERE u.usename = p_usename::name
	           AND pr.rule = p_rule::rule;
	RETURN FOUND;
	
END;
$$;


ALTER FUNCTION public.in_rule(p_rule character varying, p_usename character varying) OWNER TO postgres;

--
-- TOC entry 3976 (class 0 OID 0)
-- Dependencies: 596
-- Name: FUNCTION in_rule(p_rule character varying, p_usename character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION in_rule(p_rule character varying, p_usename character varying) IS 'Il comando  restituisce TRUE o FALSE a seconfrom_time se l''db_user indicato Ã¨ abilitato to_time rule indicato in input';


--
-- TOC entry 597 (class 1255 OID 17325)
-- Name: is_person_enable_to_any(character varying[], bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_person_enable_to_any(p_ruoli character varying[], p_person bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
 -- 
-- controllo che l'db_user indicato sia in uno dei ruoli indicati nell'array 
--
-- example d'uso: is_person_enable_to_any('{"Supervisor","Executive","Teacher"}',person)
--

	PERFORM 1 FROM persons_roles
	         WHERE person  = p_person
	           AND rule = ANY(p_ruoli::rule[]);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.is_person_enable_to_any(p_ruoli character varying[], p_person bigint) OWNER TO postgres;

--
-- TOC entry 598 (class 1255 OID 17326)
-- Name: is_session_user_enable_to_any(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION is_session_user_enable_to_any(p_ruoli character varying[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 
-- 
-- controllo che l'db_user della sesione corrente sia in uno dei ruoli indicati nell'array 
--
-- example d'uso: is_session_user_enable_to_any('{"Supervisor","Executive","Teacher"}')
--
	
	PERFORM 1 FROM persons_roles pr
	          JOIN persons p ON p.person = pr.person 
	          JOIN db_users u ON u.db_user = p.db_user
	         WHERE u.usename = session_user
	           AND pr.rule = ANY(p_ruoli::rule[]);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.is_session_user_enable_to_any(p_ruoli character varying[]) OWNER TO postgres;

--
-- TOC entry 553 (class 1255 OID 17327)
-- Name: italian_fiscal_code(character varying, character varying, sex, date, smallint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION italian_fiscal_code(_name character varying, _surname character varying, _sex sex, _birthday date, _country_of_birth smallint, _city_of_birth character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
<<me>>
DECLARE
    context text;
    message_text text;
    function_name varchar;
    month_letters char[] := array['A','B','C','D','E','H','L','M','P','R','S','T']; -- 0=Jan, 1=Feb, 2=Mar, Etc ...
    check_chars char[] :=        array[ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']; -- character 
    check_values smallint[][] := array[['1', '0', '5', '7', '9','13','15','17','19','21', '1', '0', '5', '7', '9','13','15','17','19','21', '2', '4','18','20','11', '3', '6', '8','12','14','16','10','22','25','24','23'],  -- odd position value
                                       ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '1', '2', '3', '4', '5', '6', '7', '8' ,'9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25']]; -- even position value       
    check_alphabet char[] := array['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];  
    buffer varchar := '';
    fiscal_code varchar(16) := '';
    i int := 0;
    check_digit int := 0;
BEGIN

 GET DIAGNOSTICS me.context = PG_CONTEXT;
 function_name = diagnostic.function_name(me.context);

  -- controllo parametri
  -- name is mandatory
  IF _name IS NULL THEN
    message_text = utility.system_messages_locale('public',function_name,1);
    PERFORM diagnostic.function_syntax_error(function_name,message_text);
  END IF;

  -- surname is mandatory
  IF _surname IS NULL THEN
    message_text = utility.system_messages_locale('public',function_name,2);
    PERFORM diagnostic.function_syntax_error(function_name,message_text);
  END IF; 
    
  -- sex is mandatory
  IF _sex IS NULL THEN
    message_text = utility.system_messages_locale('public',function_name,3);
    PERFORM diagnostic.function_syntax_error(function_name,message_text);
  END IF;  
   
  -- birthday is mandatory
  IF _birthday IS NULL THEN
    message_text = utility.system_messages_locale('public',function_name,4);
    PERFORM diagnostic.function_syntax_error(function_name,message_text);
  END IF;    

  -- EITHER country_of_birth OR city_of birth is mandatory
  --i cannot have both 
  IF _country_of_birth IS NOT NULL THEN
    IF _city_of_birth IS NOT NULL THEN
      message_text = utility.system_messages_locale('public',function_name,5);
      PERFORM diagnostic.function_syntax_error(function_name,message_text);
    END IF;  
  END IF;  

  --but i cannot have both NULL
  IF _country_of_birth IS NULL THEN
    IF _city_of_birth IS NULL THEN
      message_text = utility.system_messages_locale('public',function_name,6);
      PERFORM diagnostic.function_syntax_error(function_name,message_text);
    END IF;  
  END IF;  
     
  -- calcolate surname
  _surname := translate(upper(_surname),'0123456789\/!|"Â£$%&()=?^*+-_.,:;@#Ã§Â°Â§[]{}<>''  ','');
  _surname := translate(_surname,'Ã²Ã Ã¹Ã¨Ã©Ã¬','OAUEEI');
  buffer := translate(_surname, 'AEIOU', '');
  buffer := buffer || translate(_surname, 'BCDFGHJKLMNPQRSTVWXYZ','');
  buffer := buffer || 'XXX';
  fiscal_code := left(buffer, 3);

  -- calcolate name
  _name := translate(upper(_name),'0123456789\/!|"Â£$%&()=?^*+-_.,:;@#Ã§Â°Â§[]{}<>''  ','');
  _name := translate(_name,'Ã²Ã Ã¹Ã¨Ã©Ã¬','OAUEEI');
  buffer = translate(upper(_name), 'AEIOU', '');
  IF length(buffer) > 3 THEN
     buffer = left(buffer,1) || right(buffer, length(buffer)-2); 
  END IF;
  buffer := buffer || translate(_name, 'BCDFGHJKLMNPQRSTVWXYZ','');
  buffer := buffer || 'XXX';
  fiscal_code := fiscal_code || left(buffer, 3);

  -- calcolate year birthday
  fiscal_code := fiscal_code || to_char(_birthday, 'YY');

  -- calcolate month birthday
  fiscal_code := fiscal_code || month_letters[to_number(to_char(_birthday, 'MM'), '99')];

  -- calcolate day birthday
  IF _sex = 'M' THEN
      fiscal_code := fiscal_code || to_char(_birthday, 'DD');
  ELSE
      fiscal_code := fiscal_code || trim(to_char(to_number(to_char(_birthday, 'DD'), '99') + 40, '99'));
  END IF;

  -- calcolate place of birth
  IF _country_of_birth IS NULL THEN
      fiscal_code := fiscal_code || _city_of_birth;
  ELSE
      fiscal_code := fiscal_code || 'Z' || _country_of_birth;
  END IF;

  --- check digit
  WHILE i < length(fiscal_code)
      LOOP
      	i = i + 1;
          check_digit := check_digit + check_values[((i + 1) % 2) + 1][array_position(check_chars, substring(fiscal_code from i for 1)::char)];
      END LOOP;
  fiscal_code = fiscal_code || check_alphabet[(check_digit % 26) + 1];
  RETURN fiscal_code;
END;

$_$;


ALTER FUNCTION public.italian_fiscal_code(_name character varying, _surname character varying, _sex sex, _birthday date, _country_of_birth smallint, _city_of_birth character varying) OWNER TO postgres;

--
-- TOC entry 599 (class 1255 OID 17328)
-- Name: lessons_by_teacher_classroom_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT substitute,
		       on_date,
		       from_time,
		       to_time,
		       description
		  FROM lessons
		 WHERE teacher = p_teacher
		   AND classroom = p_classroom
		   AND subject = p_subject
	      ORDER BY on_date, from_time;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) OWNER TO postgres;

--
-- TOC entry 3980 (class 0 OID 0)
-- Dependencies: 599
-- Name: FUNCTION lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) IS 'Dato un teacher, una classroom ed una subject ritona l''elenco delle lessons';


--
-- TOC entry 600 (class 1255 OID 17329)
-- Name: metrics_by_school(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION metrics_by_school(p_school bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       metric,
		       description
		  FROM metrics
		 WHERE school = p_school
	      ORDER BY description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.metrics_by_school(p_school bigint) OWNER TO postgres;

--
-- TOC entry 554 (class 1255 OID 17330)
-- Name: mime_type(file_extension); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mime_type(p_file_extension file_extension) RETURNS mime_type
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */			 
DECLARE
  function_name varchar = 'mime_type(file_extension)';
BEGIN
  CASE p_file_extension
    WHEN '.json' THEN RETURN 'application/json'::mime_type;
--    WHEN '.json' THEN RETURN 'application/pdf'::mime_type;
    WHEN '.exe' THEN RETURN 'application/octet-stream'::mime_type;
    WHEN '.pdf' THEN RETURN 'application/pdf'::mime_type;
    WHEN '.txt' THEN RETURN 'text/plain'::mime_type;
    WHEN '.png' THEN RETURN 'image/png'::mime_type;
    WHEN '.jpg' THEN RETURN 'image/jpg'::mime_type;
--    WHEN '.jpg' THEN RETURN 'image/xxx'::mime_type;
    WHEN '.bmp' THEN RETURN 'image/bmp'::mime_type;
    WHEN '.gif' THEN RETURN 'image/gif'::mime_type;
    WHEN '.html' THEN RETURN 'text/html'::mime_type;
    WHEN NULL THEN RETURN NULL::mime_type;
       ELSE RAISE EXCEPTION USING
           ERRCODE = my_sqlcode(function_name,'1'),
           MESSAGE = utility.system_messages_locale('public',function_name,1),
           DETAIL = format(utility.system_messages_locale('public',function_name,2), p_file_extension),
           HINT = utility.system_messages_locale('public',function_name,3);
  END CASE;
END;
$$;


ALTER FUNCTION public.mime_type(p_file_extension file_extension) OWNER TO postgres;

--
-- TOC entry 555 (class 1255 OID 17331)
-- Name: my_sqlcode(text, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION my_sqlcode(p_function text, p_id character) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
BEGIN
--
-- these codes are assigned by hand (prefix UM)
-- 
  IF p_function = 'schools_sel_logo' THEN RETURN 'UM01' || p_id::text; END IF;
  IF p_function = 'tr_db_users_iu' THEN RETURN 'UM02'|| p_id::text; END IF;
  IF p_function = 'schools_upd_logo' THEN RETURN 'UM03' || p_id::text; END IF;
  IF p_function = 'tr_valutations_iu' THEN RETURN 'UM04'|| p_id::text; END IF;
  IF p_function = 'persons_sel_photo_tmb' THEN RETURN 'UM05'|| p_id::text; END IF;
  IF p_function = 'tr_communications_media_iu' THEN RETURN 'UM06'|| p_id::text; END IF;
  IF p_function = 'tr_absences_iu' THEN RETURN 'UM07'|| p_id::text; END IF;
  IF p_function = 'students_by_classroom' THEN RETURN 'UM08'|| p_id::text; END IF;
  IF p_function = 'relatives_by_classroom' THEN RETURN 'UM09'|| p_id::text; END IF;
  IF p_function = 'tr_classrooms_iu' THEN RETURN 'UM10'|| p_id::text; END IF;
  IF p_function = 'tr_classrooms_students_iu' THEN RETURN 'UM11'|| p_id::text; END IF;
  IF p_function = 'tr_parents_meetings_iu' THEN RETURN 'UM12'|| p_id::text; END IF;
  IF p_function = 'tr_conversations_invites_iu' THEN RETURN 'UM13'|| p_id::text; END IF;
  IF p_function = 'tr_signatures_iu' THEN RETURN 'UM14'|| p_id::text; END IF;
  IF p_function = 'tr_grading_meetings_valutations_iu' THEN RETURN 'UM15'|| p_id::text; END IF;
  IF p_function = 'tr_valutations_qualificationtions_iu' THEN RETURN 'UM16'|| p_id::text; END IF;
  IF p_function = 'topics_upd_rid' THEN RETURN 'UM17'|| p_id::text; END IF;
  IF p_function = 'tr_grading_meetings_valutations_qua_iu' THEN RETURN 'UM18'|| p_id::text; END IF;
  IF p_function = 'tr_grading_meetings_valutations_d' THEN RETURN 'UM19'|| p_id::text; END IF;
  IF p_function = 'tr_grading_meetings_valutations_qua_d' THEN RETURN 'UM20'|| p_id::text; END IF;
  IF p_function = 'tr_grading_meetings_i' THEN RETURN 'UM21'|| p_id::text; END IF;
  IF p_function = 'tr_out_of_classrooms_iu' THEN RETURN 'UM22'|| p_id::text; END IF;
  IF p_function = 'tr_delays_iu' THEN RETURN 'UM23'|| p_id::text; END IF;
  IF p_function = 'tr_leavings_iu' THEN RETURN 'UM24'|| p_id::text; END IF;
  IF p_function = 'tr_notes_iu' THEN RETURN 'UM25'|| p_id::text; END IF;
  IF p_function = 'tr_explanations_iu' THEN RETURN 'UM26'|| p_id::text; END IF;
  IF p_function = 'valutations_upd_grade' THEN RETURN 'UM27'|| p_id::text; END IF;
  IF p_function = 'tr_lessons_iu' THEN RETURN 'UM28'|| p_id::text; END IF;
  IF p_function = 'tr_faults_iu' THEN RETURN 'UM29'|| p_id::text; END IF;
  IF p_function = 'tr_messages_iu' THEN RETURN 'UM30'|| p_id::text; END IF;
  IF p_function = 'tr_teachears_notes_iu' THEN RETURN 'UM31'|| p_id::text; END IF;
  IF p_function = 'tr_notes_signed_iu' THEN RETURN 'UM32'|| p_id::text; END IF;
  IF p_function = 'topics_ins_rid' THEN RETURN 'UM33'|| p_id::text; END IF;
  IF p_function = 'tr_schools_iu' THEN RETURN 'UM34'|| p_id::text; END IF;
  IF p_function = 'file_extension(mime_type)' THEN RETURN 'UM35'|| p_id::text; END IF; 
  IF p_function = 'mime_type(file_extension)' THEN RETURN 'UM36'|| p_id::text; END IF; 
--
-- these codes are generated by template
--
  IF p_function = 'degrees_sel' THEN RETURN 'U001'|| p_id::text; END IF;
  IF p_function = 'degrees_ins' THEN RETURN 'U002'|| p_id::text; END IF;
  IF p_function = 'degrees_upd' THEN RETURN 'U003'|| p_id::text; END IF;
  IF p_function = 'degrees_del' THEN RETURN 'U004'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangelog_sel' THEN RETURN 'U005'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangelog_ins' THEN RETURN 'U006'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangelog_upd' THEN RETURN 'U007'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangelog_del' THEN RETURN 'U008'|| p_id::text; END IF;
  IF p_function = 'logging_event_exception_sel' THEN RETURN 'U009'|| p_id::text; END IF;
  IF p_function = 'logging_event_exception_ins' THEN RETURN 'U010'|| p_id::text; END IF;
  IF p_function = 'logging_event_exception_upd' THEN RETURN 'U011'|| p_id::text; END IF;
  IF p_function = 'logging_event_exception_del' THEN RETURN 'U012'|| p_id::text; END IF;
  IF p_function = 'gruppi_db_users_sel' THEN RETURN 'U013'|| p_id::text; END IF;
  IF p_function = 'gruppi_db_users_ins' THEN RETURN 'U014'|| p_id::text; END IF;
  IF p_function = 'gruppi_db_users_upd' THEN RETURN 'U015'|| p_id::text; END IF;
  IF p_function = 'gruppi_db_users_del' THEN RETURN 'U016'|| p_id::text; END IF;
  IF p_function = 'lessons_sel' THEN RETURN 'U017'|| p_id::text; END IF;
  IF p_function = 'lessons_ins' THEN RETURN 'U018'|| p_id::text; END IF;
  IF p_function = 'lessons_upd' THEN RETURN 'U019'|| p_id::text; END IF;
  IF p_function = 'lessons_del' THEN RETURN 'U020'|| p_id::text; END IF;
  IF p_function = 'subjects_sel' THEN RETURN 'U021'|| p_id::text; END IF;
  IF p_function = 'subjects_ins' THEN RETURN 'U022'|| p_id::text; END IF;
  IF p_function = 'subjects_upd' THEN RETURN 'U023'|| p_id::text; END IF;
  IF p_function = 'subjects_del' THEN RETURN 'U024'|| p_id::text; END IF;
  IF p_function = 'appuserroles_sel' THEN RETURN 'U025'|| p_id::text; END IF;
  IF p_function = 'appuserroles_ins' THEN RETURN 'U026'|| p_id::text; END IF;
  IF p_function = 'appuserroles_upd' THEN RETURN 'U027'|| p_id::text; END IF;
  IF p_function = 'appuserroles_del' THEN RETURN 'U028'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_dettaglio_sel' THEN RETURN 'U029'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_dettaglio_ins' THEN RETURN 'U030'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_dettaglio_upd' THEN RETURN 'U031'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_dettaglio_del' THEN RETURN 'U032'|| p_id::text; END IF;
  IF p_function = 'faults_sel' THEN RETURN 'U033'|| p_id::text; END IF;
  IF p_function = 'faults_ins' THEN RETURN 'U034'|| p_id::text; END IF;
  IF p_function = 'faults_upd' THEN RETURN 'U035'|| p_id::text; END IF;
  IF p_function = 'faults_del' THEN RETURN 'U036'|| p_id::text; END IF;
  IF p_function = 'messages_sel' THEN RETURN 'U037'|| p_id::text; END IF;
  IF p_function = 'messages_ins' THEN RETURN 'U038'|| p_id::text; END IF;
  IF p_function = 'messages_upd' THEN RETURN 'U039'|| p_id::text; END IF;
  IF p_function = 'messages_del' THEN RETURN 'U040'|| p_id::text; END IF;
  IF p_function = 'system_messages_sel' THEN RETURN 'U041'|| p_id::text; END IF;
  IF p_function = 'system_messages_ins' THEN RETURN 'U042'|| p_id::text; END IF;
  IF p_function = 'system_messages_upd' THEN RETURN 'U043'|| p_id::text; END IF;
  IF p_function = 'system_messages_del' THEN RETURN 'U044'|| p_id::text; END IF;
  IF p_function = 'db_users_schools_sel' THEN RETURN 'U045'|| p_id::text; END IF;
  IF p_function = 'db_users_schools_ins' THEN RETURN 'U046'|| p_id::text; END IF;
  IF p_function = 'db_users_schools_upd' THEN RETURN 'U047'|| p_id::text; END IF;
  IF p_function = 'db_users_schools_del' THEN RETURN 'U048'|| p_id::text; END IF;
  IF p_function = 'signatures_sel' THEN RETURN 'U049'|| p_id::text; END IF;
  IF p_function = 'signatures_ins' THEN RETURN 'U050'|| p_id::text; END IF;
  IF p_function = 'signatures_upd' THEN RETURN 'U051'|| p_id::text; END IF;
  IF p_function = 'signatures_del' THEN RETURN 'U052'|| p_id::text; END IF;
  IF p_function = 'role_sel' THEN RETURN 'U053'|| p_id::text; END IF;
  IF p_function = 'role_ins' THEN RETURN 'U054'|| p_id::text; END IF;
  IF p_function = 'role_upd' THEN RETURN 'U055'|| p_id::text; END IF;
  IF p_function = 'role_del' THEN RETURN 'U056'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_sel' THEN RETURN 'U057'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_ins' THEN RETURN 'U058'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_upd' THEN RETURN 'U059'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_del' THEN RETURN 'U060'|| p_id::text; END IF;
  IF p_function = 'topics_sel' THEN RETURN 'U061'|| p_id::text; END IF;
  IF p_function = 'topics_ins' THEN RETURN 'U062'|| p_id::text; END IF;
  IF p_function = 'topics_upd' THEN RETURN 'U063'|| p_id::text; END IF;
  IF p_function = 'topics_del' THEN RETURN 'U064'|| p_id::text; END IF;
  IF p_function = 'addresses_sel' THEN RETURN 'U065'|| p_id::text; END IF;
  IF p_function = 'addresses_ins' THEN RETURN 'U066'|| p_id::text; END IF;
  IF p_function = 'addresses_upd' THEN RETURN 'U067'|| p_id::text; END IF;
  IF p_function = 'addresses_del' THEN RETURN 'U068'|| p_id::text; END IF;
  IF p_function = 'grades_sel' THEN RETURN 'U069'|| p_id::text; END IF;
  IF p_function = 'grades_ins' THEN RETURN 'U070'|| p_id::text; END IF;
  IF p_function = 'grades_upd' THEN RETURN 'U071'|| p_id::text; END IF;
  IF p_function = 'grades_del' THEN RETURN 'U072'|| p_id::text; END IF;
  IF p_function = 'classrooms_students_sel' THEN RETURN 'U073'|| p_id::text; END IF;
  IF p_function = 'classrooms_students_ins' THEN RETURN 'U074'|| p_id::text; END IF;
  IF p_function = 'classrooms_students_upd' THEN RETURN 'U075'|| p_id::text; END IF;
  IF p_function = 'classrooms_students_del' THEN RETURN 'U076'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_qua_sel' THEN RETURN 'U077'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_qua_ins' THEN RETURN 'U078'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_qua_upd' THEN RETURN 'U079'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_valutations_qua_del' THEN RETURN 'U080'|| p_id::text; END IF;
  IF p_function = 'logging_event_property_sel' THEN RETURN 'U081'|| p_id::text; END IF;
  IF p_function = 'logging_event_property_ins' THEN RETURN 'U082'|| p_id::text; END IF;
  IF p_function = 'logging_event_property_upd' THEN RETURN 'U083'|| p_id::text; END IF;
  IF p_function = 'logging_event_property_del' THEN RETURN 'U084'|| p_id::text; END IF;
  IF p_function = 'valutations_sel' THEN RETURN 'U085'|| p_id::text; END IF;
  IF p_function = 'valutations_ins' THEN RETURN 'U086'|| p_id::text; END IF;
  IF p_function = 'valutations_upd' THEN RETURN 'U087'|| p_id::text; END IF;
  IF p_function = 'valutations_del' THEN RETURN 'U088'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangeloglock_sel' THEN RETURN 'U089'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangeloglock_ins' THEN RETURN 'U090'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangeloglock_upd' THEN RETURN 'U091'|| p_id::text; END IF;
  IF p_function = 'on_datebasechangeloglock_del' THEN RETURN 'U092'|| p_id::text; END IF;
  IF p_function = 'absences_sel' THEN RETURN 'U093'|| p_id::text; END IF;
  IF p_function = 'absences_ins' THEN RETURN 'U094'|| p_id::text; END IF;
  IF p_function = 'absences_upd' THEN RETURN 'U095'|| p_id::text; END IF;
  IF p_function = 'absences_del' THEN RETURN 'U096'|| p_id::text; END IF;
  IF p_function = 'buildings_sel' THEN RETURN 'U097'|| p_id::text; END IF;
  IF p_function = 'buildings_ins' THEN RETURN 'U098'|| p_id::text; END IF;
  IF p_function = 'buildings_upd' THEN RETURN 'U099'|| p_id::text; END IF;
  IF p_function = 'buildings_del' THEN RETURN 'U100'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_sel' THEN RETURN 'U101'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_ins' THEN RETURN 'U102'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_upd' THEN RETURN 'U103'|| p_id::text; END IF;
  IF p_function = 'gruppi_qualificationtions_del' THEN RETURN 'U104'|| p_id::text; END IF;
  IF p_function = 'teachears_notes_sel' THEN RETURN 'U105'|| p_id::text; END IF;
  IF p_function = 'teachears_notes_ins' THEN RETURN 'U106'|| p_id::text; END IF;
  IF p_function = 'teachears_notes_upd' THEN RETURN 'U107'|| p_id::text; END IF;
  IF p_function = 'teachears_notes_del' THEN RETURN 'U108'|| p_id::text; END IF;
  IF p_function = 'schools_sel' THEN RETURN 'U109'|| p_id::text; END IF;
  IF p_function = 'schools_ins' THEN RETURN 'U110'|| p_id::text; END IF;
  IF p_function = 'schools_upd' THEN RETURN 'U111'|| p_id::text; END IF;
  IF p_function = 'schools_del' THEN RETURN 'U112'|| p_id::text; END IF;
  IF p_function = 'messages_read_sel' THEN RETURN 'U113'|| p_id::text; END IF;
  IF p_function = 'messages_read_ins' THEN RETURN 'U114'|| p_id::text; END IF;
  IF p_function = 'messages_read_upd' THEN RETURN 'U115'|| p_id::text; END IF;
  IF p_function = 'messages_read_del' THEN RETURN 'U116'|| p_id::text; END IF;
  IF p_function = 'persons_addresses_sel' THEN RETURN 'U117'|| p_id::text; END IF;
  IF p_function = 'persons_addresses_ins' THEN RETURN 'U118'|| p_id::text; END IF;
  IF p_function = 'persons_addresses_upd' THEN RETURN 'U119'|| p_id::text; END IF;
  IF p_function = 'persons_addresses_del' THEN RETURN 'U120'|| p_id::text; END IF;
  IF p_function = 'logging_event_sel' THEN RETURN 'U121'|| p_id::text; END IF;
  IF p_function = 'logging_event_ins' THEN RETURN 'U122'|| p_id::text; END IF;
  IF p_function = 'logging_event_upd' THEN RETURN 'U123'|| p_id::text; END IF;
  IF p_function = 'logging_event_del' THEN RETURN 'U124'|| p_id::text; END IF;
  IF p_function = 'holydays_sel' THEN RETURN 'U125'|| p_id::text; END IF;
  IF p_function = 'holydays_ins' THEN RETURN 'U126'|| p_id::text; END IF;
  IF p_function = 'holydays_upd' THEN RETURN 'U127'|| p_id::text; END IF;
  IF p_function = 'holydays_del' THEN RETURN 'U128'|| p_id::text; END IF;
  IF p_function = 'regions_sel' THEN RETURN 'U129'|| p_id::text; END IF;
  IF p_function = 'regions_ins' THEN RETURN 'U130'|| p_id::text; END IF;
  IF p_function = 'regions_upd' THEN RETURN 'U131'|| p_id::text; END IF;
  IF p_function = 'regions_del' THEN RETURN 'U132'|| p_id::text; END IF;
  IF p_function = 'communication_types_sel' THEN RETURN 'U133'|| p_id::text; END IF;
  IF p_function = 'communication_types_ins' THEN RETURN 'U134'|| p_id::text; END IF;
  IF p_function = 'communication_types_upd' THEN RETURN 'U135'|| p_id::text; END IF;
  IF p_function = 'communication_types_del' THEN RETURN 'U136'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_sel' THEN RETURN 'U137'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_ins' THEN RETURN 'U138'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_upd' THEN RETURN 'U139'|| p_id::text; END IF;
  IF p_function = 'grading_meetings_del' THEN RETURN 'U140'|| p_id::text; END IF;
  IF p_function = 'parents_meetings_sel' THEN RETURN 'U141'|| p_id::text; END IF;
  IF p_function = 'parents_meetings_ins' THEN RETURN 'U142'|| p_id::text; END IF;
  IF p_function = 'parents_meetings_upd' THEN RETURN 'U143'|| p_id::text; END IF;
  IF p_function = 'parents_meetings_del' THEN RETURN 'U144'|| p_id::text; END IF;
  IF p_function = 'appuser_sel' THEN RETURN 'U145'|| p_id::text; END IF;
  IF p_function = 'appuser_ins' THEN RETURN 'U146'|| p_id::text; END IF;
  IF p_function = 'appuser_upd' THEN RETURN 'U147'|| p_id::text; END IF;
  IF p_function = 'appuser_del' THEN RETURN 'U148'|| p_id::text; END IF;
  IF p_function = 'libretti_sel' THEN RETURN 'U149'|| p_id::text; END IF;
  IF p_function = 'libretti_ins' THEN RETURN 'U150'|| p_id::text; END IF;
  IF p_function = 'libretti_upd' THEN RETURN 'U151'|| p_id::text; END IF;
  IF p_function = 'libretti_del' THEN RETURN 'U152'|| p_id::text; END IF;
  IF p_function = 'school_years_sel' THEN RETURN 'U153'|| p_id::text; END IF;
  IF p_function = 'school_years_ins' THEN RETURN 'U154'|| p_id::text; END IF;
  IF p_function = 'school_years_upd' THEN RETURN 'U155'|| p_id::text; END IF;
  IF p_function = 'school_years_del' THEN RETURN 'U156'|| p_id::text; END IF;
  IF p_function = 'conversations_sel' THEN RETURN 'U157'|| p_id::text; END IF;
  IF p_function = 'conversations_ins' THEN RETURN 'U158'|| p_id::text; END IF;
  IF p_function = 'conversations_upd' THEN RETURN 'U159'|| p_id::text; END IF;
  IF p_function = 'conversations_del' THEN RETURN 'U160'|| p_id::text; END IF;
  IF p_function = 'districts_sel' THEN RETURN 'U161'|| p_id::text; END IF;
  IF p_function = 'districts_ins' THEN RETURN 'U162'|| p_id::text; END IF;
  IF p_function = 'districts_upd' THEN RETURN 'U163'|| p_id::text; END IF;
  IF p_function = 'districts_del' THEN RETURN 'U164'|| p_id::text; END IF;
  IF p_function = 'leavings_sel' THEN RETURN 'U165'|| p_id::text; END IF;
  IF p_function = 'leavings_ins' THEN RETURN 'U166'|| p_id::text; END IF;
  IF p_function = 'leavings_upd' THEN RETURN 'U167'|| p_id::text; END IF;
  IF p_function = 'leavings_del' THEN RETURN 'U168'|| p_id::text; END IF;
  IF p_function = 'explanations_sel' THEN RETURN 'U169'|| p_id::text; END IF;
  IF p_function = 'explanations_ins' THEN RETURN 'U170'|| p_id::text; END IF;
  IF p_function = 'explanations_upd' THEN RETURN 'U171'|| p_id::text; END IF;
  IF p_function = 'explanations_del' THEN RETURN 'U172'|| p_id::text; END IF;
  IF p_function = 'communications_media_sel' THEN RETURN 'U173'|| p_id::text; END IF;
  IF p_function = 'communications_media_ins' THEN RETURN 'U174'|| p_id::text; END IF;
  IF p_function = 'communications_media_upd' THEN RETURN 'U175'|| p_id::text; END IF;
  IF p_function = 'communications_media_del' THEN RETURN 'U176'|| p_id::text; END IF;
  IF p_function = 'metrics_sel' THEN RETURN 'U177'|| p_id::text; END IF;
  IF p_function = 'metrics_ins' THEN RETURN 'U178'|| p_id::text; END IF;
  IF p_function = 'metrics_upd' THEN RETURN 'U179'|| p_id::text; END IF;
  IF p_function = 'metrics_del' THEN RETURN 'U180'|| p_id::text; END IF;
  IF p_function = 'qualificationtions_sel' THEN RETURN 'U181'|| p_id::text; END IF;
  IF p_function = 'qualificationtions_ins' THEN RETURN 'U182'|| p_id::text; END IF;
  IF p_function = 'qualificationtions_upd' THEN RETURN 'U183'|| p_id::text; END IF;
  IF p_function = 'qualificationtions_del' THEN RETURN 'U184'|| p_id::text; END IF;
  IF p_function = 'grade_types_sel' THEN RETURN 'U185'|| p_id::text; END IF;
  IF p_function = 'grade_types_ins' THEN RETURN 'U186'|| p_id::text; END IF;
  IF p_function = 'grade_types_upd' THEN RETURN 'U187'|| p_id::text; END IF;
  IF p_function = 'grade_types_del' THEN RETURN 'U188'|| p_id::text; END IF;
  IF p_function = 'cities_sel' THEN RETURN 'U189'|| p_id::text; END IF;
  IF p_function = 'cities_ins' THEN RETURN 'U190'|| p_id::text; END IF;
  IF p_function = 'cities_upd' THEN RETURN 'U191'|| p_id::text; END IF;
  IF p_function = 'cities_del' THEN RETURN 'U192'|| p_id::text; END IF;
  IF p_function = 'countries_sel' THEN RETURN 'U193'|| p_id::text; END IF;
  IF p_function = 'countries_ins' THEN RETURN 'U194'|| p_id::text; END IF;
  IF p_function = 'countries_upd' THEN RETURN 'U195'|| p_id::text; END IF;
  IF p_function = 'countries_del' THEN RETURN 'U196'|| p_id::text; END IF;
  IF p_function = 'notes_sel' THEN RETURN 'U197'|| p_id::text; END IF;
  IF p_function = 'notes_ins' THEN RETURN 'U198'|| p_id::text; END IF;
  IF p_function = 'notes_upd' THEN RETURN 'U199'|| p_id::text; END IF;
  IF p_function = 'notes_del' THEN RETURN 'U200'|| p_id::text; END IF;
  IF p_function = 'weekly_timetable_sel' THEN RETURN 'U201'|| p_id::text; END IF;
  IF p_function = 'weekly_timetable_ins' THEN RETURN 'U202'|| p_id::text; END IF;
  IF p_function = 'weekly_timetable_upd' THEN RETURN 'U203'|| p_id::text; END IF;
  IF p_function = 'weekly_timetable_del' THEN RETURN 'U204'|| p_id::text; END IF;
  IF p_function = 'out_of_classrooms_sel' THEN RETURN 'U205'|| p_id::text; END IF;
  IF p_function = 'out_of_classrooms_ins' THEN RETURN 'U206'|| p_id::text; END IF;
  IF p_function = 'out_of_classrooms_upd' THEN RETURN 'U207'|| p_id::text; END IF;
  IF p_function = 'out_of_classrooms_del' THEN RETURN 'U208'|| p_id::text; END IF;
  IF p_function = 'persons_sel' THEN RETURN 'U209'|| p_id::text; END IF;
  IF p_function = 'persons_ins' THEN RETURN 'U210'|| p_id::text; END IF;
  IF p_function = 'persons_upd' THEN RETURN 'U211'|| p_id::text; END IF;
  IF p_function = 'persons_del' THEN RETURN 'U212'|| p_id::text; END IF;
  IF p_function = 'persons_parenti_sel' THEN RETURN 'U213'|| p_id::text; END IF;
  IF p_function = 'persons_parenti_ins' THEN RETURN 'U214'|| p_id::text; END IF;
  IF p_function = 'persons_parenti_upd' THEN RETURN 'U215'|| p_id::text; END IF;
  IF p_function = 'persons_parenti_del' THEN RETURN 'U216'|| p_id::text; END IF;
  IF p_function = 'valutations_qualificationtions_sel' THEN RETURN 'U217'|| p_id::text; END IF;
  IF p_function = 'valutations_qualificationtions_ins' THEN RETURN 'U218'|| p_id::text; END IF;
  IF p_function = 'valutations_qualificationtions_upd' THEN RETURN 'U219'|| p_id::text; END IF;
  IF p_function = 'valutations_qualificationtions_del' THEN RETURN 'U220'|| p_id::text; END IF;
  IF p_function = 'gruppi_sel' THEN RETURN 'U221'|| p_id::text; END IF;
  IF p_function = 'gruppi_ins' THEN RETURN 'U222'|| p_id::text; END IF;
  IF p_function = 'gruppi_upd' THEN RETURN 'U223'|| p_id::text; END IF;
  IF p_function = 'gruppi_del' THEN RETURN 'U224'|| p_id::text; END IF;
  IF p_function = 'persistent_logins_sel' THEN RETURN 'U225'|| p_id::text; END IF;
  IF p_function = 'persistent_logins_ins' THEN RETURN 'U226'|| p_id::text; END IF;
  IF p_function = 'persistent_logins_upd' THEN RETURN 'U227'|| p_id::text; END IF;
  IF p_function = 'persistent_logins_del' THEN RETURN 'U228'|| p_id::text; END IF;
  IF p_function = 'db_users_sel' THEN RETURN 'U229'|| p_id::text; END IF;
  IF p_function = 'db_users_ins' THEN RETURN 'U230'|| p_id::text; END IF;
  IF p_function = 'db_users_upd' THEN RETURN 'U231'|| p_id::text; END IF;
  IF p_function = 'db_users_del' THEN RETURN 'U232'|| p_id::text; END IF;
  IF p_function = 'delays_sel' THEN RETURN 'U233'|| p_id::text; END IF;
  IF p_function = 'delays_ins' THEN RETURN 'U234'|| p_id::text; END IF;
  IF p_function = 'delays_upd' THEN RETURN 'U235'|| p_id::text; END IF;
  IF p_function = 'delays_del' THEN RETURN 'U236'|| p_id::text; END IF;
  IF p_function = 'classrooms_sel' THEN RETURN 'U237'|| p_id::text; END IF;
  IF p_function = 'classrooms_ins' THEN RETURN 'U238'|| p_id::text; END IF;
  IF p_function = 'classrooms_upd' THEN RETURN 'U239'|| p_id::text; END IF;
  IF p_function = 'classrooms_del' THEN RETURN 'U240'|| p_id::text; END IF;
  IF p_function = 'accesslog_sel' THEN RETURN 'U241'|| p_id::text; END IF;
  IF p_function = 'accesslog_ins' THEN RETURN 'U242'|| p_id::text; END IF;
  IF p_function = 'accesslog_upd' THEN RETURN 'U243'|| p_id::text; END IF;
  IF p_function = 'accesslog_del' THEN RETURN 'U244'|| p_id::text; END IF;
  IF p_function = 'configuration_sel' THEN RETURN 'U245'|| p_id::text; END IF;
  IF p_function = 'configuration_ins' THEN RETURN 'U246'|| p_id::text; END IF;
  IF p_function = 'configuration_upd' THEN RETURN 'U247'|| p_id::text; END IF;
  IF p_function = 'configuration_del' THEN RETURN 'U248'|| p_id::text; END IF;
  IF p_function = 'work_spaces_sel' THEN RETURN 'U249'|| p_id::text; END IF;
  IF p_function = 'work_spaces_ins' THEN RETURN 'U250'|| p_id::text; END IF;
  IF p_function = 'work_spaces_upd' THEN RETURN 'U251'|| p_id::text; END IF;
  IF p_function = 'work_spaces_del' THEN RETURN 'U252'|| p_id::text; END IF;
--
-- if we didn't find the function we set the last possible user code
--
  RETURN 'UZZZZ';
 END;
$$;


ALTER FUNCTION public.my_sqlcode(p_function text, p_id character) OWNER TO postgres;

--
-- TOC entry 601 (class 1255 OID 17333)
-- Name: persons_sel_thumbnail(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persons_sel_thumbnail(p_person bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  m_miniatura bytea;
  function_name varchar = 'persons_sel_thumbnail';
BEGIN 
	SELECT COALESCE(thumbnail,thumbnail_default()) INTO m_miniatura from persons where person = p_person;
	IF NOT FOUND THEN 
		RAISE USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = format(system_messages_locale(function_name,1), p_person::varchar),
		DETAIL = format(system_messages_locale(function_name,2) ,current_query()),
		HINT = system_messages_locale(function_name,3);
	END IF;  
RETURN m_miniatura;
END;
$$;


ALTER FUNCTION public.persons_sel_thumbnail(p_person bigint) OWNER TO postgres;

--
-- TOC entry 602 (class 1255 OID 17334)
-- Name: persons_surname_name(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persons_surname_name(p_person bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  v_surname_name varchar;
  function_name varchar = 'persons_surname_name';
BEGIN 
  SELECT surname || ' ' || name INTO v_surname_name 
  FROM persons p
  JOIN schools i ON i.school = p.school 
  JOIN db_users_schools ui ON ui.school = i.school
  JOIN db_users u ON u.db_user = ui .db_user
  WHERE u.usename = session_user 
    AND p.person = p_person;
  IF NOT FOUND THEN 
	  RAISE USING
	        ERRCODE = function_sqlcode(function_name,'1'),
	        MESSAGE = format(system_messages_locale(function_name,1), p_person::varchar),
	        DETAIL = format(system_messages_locale(function_name,2) ,current_query()),
	        HINT = system_messages_locale(function_name,3);
	END IF;                   
  RETURN v_surname_name;
 END;
$$;


ALTER FUNCTION public.persons_surname_name(p_person bigint) OWNER TO postgres;

--
-- TOC entry 603 (class 1255 OID 17335)
-- Name: photo_default(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION photo_default() RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $$

BEGIN
	RETURN  decode('/9j/4AAQSkZJRgABAQEAWQBZAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
			ODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2Nj
			Y2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAGQASwDASIA
			AhEBAxEB/8QAGwABAAIDAQEAAAAAAAAAAAAAAAUGAQIEAwf/xAAzEAEAAgICAAQEBAUDBQAAAAAA
			AQIDBAURITFBUQYSImETIzJxFENSgaEzQmIlcoKRsf/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAU
			EQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
			AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
			AAAAAAAAAAAAAAAAAAADm2t7Bq17y3iJ9vUHS1tatY7tMRH3V7b+Ib27rr0+WPeUTm3djPP5mW0/
			3BbsvI6mL9Wav9nLfntOs+E2t+yqeYCzz8Ra3pS7avxDqz51tCrALhi5nTyfzOp+7rx7GHL/AKeS
			tv7qI2pkvSe6Wms/aQX1lUNbmdvBMd3+evtKZ1Od18/Vcv5dvv5AlhrW1b17rMTHvDYAAAAAAAAA
			AAAAAAAAAAAAABpkyUxUm17RWsesvLb28Wpim+S3XtHuqnIcll3ck9zNaelYBI8jz0zM49Xwj+pB
			5Ml8tpte02mfdqAAAAAAAAAAA7NPktjUtHy2ma/0ysuhymHcrERPy39aypzal7UtFqTMTHrAL6yg
			+J5mMnWHZnq3pb3TcT3HcAyAAAAAAAAAAAAAAAAAA59zbx6eGcmSf2j3embLTDitkvPVYhT+S3r7
			uxNpn6I/TANN3cybmab3nw9I9nMAAAAAAAAAAAAAAAET1PcLDwvLd9a+xb/ttKvETMT3HmC/sofg
			+SjYx/g5Z/Mr5fdMAAAAAAAAAAAAAAAMMuHlduNTTtaJ+u3hUERz+/8AiZP4fHP01/V16yhGbWm1
			ptM9zLAAAAAAAAAAAAAAAAAAAN8OW2DLXJSeprPa6aG1Xb1q5Kz4+sfdSEpwW7OvtRjtP0X8AWwY
			ZAAAAAAAAAAAABhU+d252NyaRP0U8IWPkdiNbTyZO/HrqFKtabWm0+cz2DAAAAAAAAAAAAAAAAAA
			AADMTNZiY84YAXLiNr+K0q2mfqr4S7lW+Hdr8LanFafpv/8AVpAAAAAAAAAAABgED8TZ+q48MT5+
			Mq87+Zzfjchk8fCvhDgAAAAAAAAAAAAAAAAAAAAAAB6a+ScWel4/2yvOG8ZMVbx5WjtQlu4LN+Lx
			9e57mvgCSAAAAAAAAAAaZbfJivb2jtu5eSv8mhln/iCmZrzfNe0+sy0AAAAAAAAAAAAAAAAAAAAA
			AABYPhjL4ZcU/vCvpb4cv8u9Nf6qgtQAAAAAAAAACO5yeuMyJFGc/P8A0637gqQAAAAAAAAAAAAA
			AAAAAAAAAACQ4OeuTxo928PPXI4v3BcwAAAAAAAAAEbz0d8bf7JJxcvT5+Oyx9uwUwAAAAAAAAAA
			AAAAAAAAAAAAAB3cLHfJYnCk/h+nzcjWf6Y7BbQAAAAAAAAAHjtU+fWyV96y9mJjuJgFBtHy2mPa
			WHTyOL8Hey0+7mAAAAAAAAAAAAAAAAAAAAAAATnwzj7z5L+0dINaPhzF8mlN587SCYAAAAAAAAAA
			ABWPiTB8m1XLEeF4Qy287rfj6MzEfVTxVIAAAAAAAAAAAAAAAAAAAAAAGa1m1orHnM9LvoYYwaeP
			H7QqvD687G9SOvCvjK4+QMgAAAAAAAAAAA1vWL0ms+Ux0pW/rzrbeTHMeHfgu6F+IdP8TDGekfVT
			z/YFZAAAAAAAAAAAAAAAAAAAAB0aGtO1tUxxHhM+P7An/h3V/C1pzWj6r+X7Jlpix1xY60rHUVjp
			uAAAAAAAAAAAAA1yUrkpNLR3Ex1LYBS+T07ae1avX0z41lxrlymjXd15j/fXxrKn5MdsWSaXjq0T
			1INQAAAAAAAAAAAAAAAAAPNauC0P4fB+NePrv/iEVwnHTs5Yy5I/LrP/ALWqIiI6jyBkAAAAAAAA
			AAAAAAABD81xf8RWc2GPzI8490wwCg2rNZmJjqYYWbl+HjP3mwR1f1j3Vu9LUtNbRMTHpINQAAAA
			AAAAAAAAAHbxvH5N3NERHVI85Z47jcu7k8I6xx52WzV1serhjHjjqI/yDbBhpgxVx446iIegAAAA
			AAAAAAAAAAAAAAAwj+R4nFuRNq/Rk949UiAo+3p5tTJNctZj2n0lzr5mwY89JrlpFo+6D3vh/wA7
			6s/+Mgr49s+rm17dZcc1/s8QAAAAAABmIm09REzP2d+pw+zszEzX5K+8g4IiZnqI7lMcbwd83WTY
			+mnt6yl9LidfUiJ+X57+8u8GmLFTDjimOsVrHs9AAAAAAAAAAAAAAAAYmYrHcz1ENcuWmGk3yWit
			Y91Y5TmL7MzjwzNcfv7g7eS52Mczj1vG3rZ7cPy0bMfhZpiMseU+6rNqXtS0WrPUx5SC+sobieYr
			niMWeflyek+6YBkAAAGmTFjy16yUi0feEdscFqZe5rE0n7JQBW8vw5ljv8PLE/u5L8Ju1nwxxb9l
			vAUyeJ3I/ky2rw+7b+UuICq4vh/av+qa1duD4cxxPebJNvtCdAcmvx2rr/6eKO/eXUyAAAAAPLPn
			pr4pyZJ6rDGzs4tXFOTLaIiPT3VPkuSybuTr9OOPKAddufzRtzeI7xf0p3S3sO5j+bHbx9a+sKS9
			dfYya2SL4rTEwC9iN4zlce5WK2mK5Y9PdIgyAAAAAA88+amDFOTJbqsGbLTBitkyT1WFS5Tkr7uW
			YiZjHHlAHJ8lk3csxEzGOPKHAAAAMxMxPcT1Kb4znJxxGLZ8a+lkGAvuPJTLSLUtFqz6w3UvR5HP
			pW+i3dfWsrHo8xr7URW0/Jf2kEiMRPfkyAAAAAAAAAAADyz7GLXpNst4rAPRw7/KYdOsxM/Nk9Kw
			i9/n5vE01o6j+qUJe9r2m15mZn1kHvu7uXcyzfJPh6R7OYAAAbUvbHaLUmYmPWFn4fla7NYxZp6y
			x5T7qs2pe2O0WrPUx5SC+sonh+VrtUjFlnrLH+UsAAAxMxWJmZ6iBA89yXy962GfH/dMA4+a5Kdr
			LOLHP5Vf8ooAAAAAAACJmJ7iegBIanMbOt1E2+evtKb1Oc1s/UZPy7fdVAF9plx5I7petv2luoeP
			PlxT3jyWr+0u/Dzm3ijqbRePuC2ivYviSf5mH+8OivxFrT50vAJkRMc/qT/VDFviHVjyraQS4g8n
			xHiiPoxTP7uTL8RbFv0UrUFmmYjznpzZ+Q1teJm+WvcekKpn5Laz/ryz17Q5ZmZnuZmf3BO7fxDa
			e661Ov8AlKGz7OXYt82W82l5AAAAAAAAAN8WS2LJF6T1aJ8Fv4vfru4I7nrJX9UKa6NLavqZ65KT
			+8e4LwPDU2KbWCuWk+EvcHFym7XT1bW7+ufCsKdkvbJeb2nuZnuXXym9O7szbv6I8Kw4gAAAAAAA
			AAAAAAAAAAAAAAAAAAAAAAAAAAASvBb/APDZ/wAK8/l3/wAStUeMdwoET1PcLFx/OYqa1abEz89f
			DsFdAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
			AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//2Q==','base64');
END;
$$;


ALTER FUNCTION public.photo_default() OWNER TO postgres;

--
-- TOC entry 3985 (class 0 OID 0)
-- Dependencies: 603
-- Name: FUNCTION photo_default(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION photo_default() IS 'Restituisce l''immagine di default per la photo della person
****************************************
* Questa funzione Ã¨ definita IMMUTABLE *
****************************************';


--
-- TOC entry 604 (class 1255 OID 17337)
-- Name: qualificationtions_tree(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION qualificationtions_tree() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
/*

Ancat_time non sono riuscito a mettere in una funzione la query che segue:

SELECT q.type, repeat('   ',level) || q.name as tree,
       t.qualification,
       q.name,
       t.level,
       t.qualificationtion_parent,
       r.name,
       t.branch
FROM connectby('public.qualificationtions','qualification','qualificationtion_parent','96203',100,'-')
AS t(qualification bigint, qualificationtion_parent bigint, level int, branch text)
LEFT JOIN qualificationtions q on (q.qualification = t.qualification)
LEFT JOIN qualificationtions r on (r.qualification = t.qualificationtion_parent)
ORDER BY t.branch;
*/
  v_min_qualification text;
BEGIN 
  SELECT MIN(qualification)::text INTO v_min_qualification FROM qualificationtions;
--  EXECUTE 'SELECT repeat(''   '',level) || q.name as tree, t.qualification, q.name, t.level, t.riferimento, r.name, t.branch FROM connectby(''public.qualificationtions'',''qualification'',''riferimento'',' || v_min_qualification || ',100,''-'')'
 END;
$$;


ALTER FUNCTION public.qualificationtions_tree() OWNER TO postgres;

--
-- TOC entry 605 (class 1255 OID 17338)
-- Name: relatives_by_classroom(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION relatives_by_classroom(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
	cur refcursor;
	function_name varchar = 'relatives_by_classroom';
BEGIN 
	IF in_uno_dei_ruoli('{"Supervisor","Executive","Teacher"}')  THEN
		OPEN cur FOR SELECT p.person AS student,
			       p.surname,
			       p.name,
			       p.tax_code,
			       COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
			  FROM classrooms_students ca 
		          JOIN persons_relations rel ON ca.student = rel.person
		          JOIN persons p ON rel.person_related_to = p.person
			 WHERE ca.classroom = p_classroom
		      ORDER BY surname, name, tax_code;

	ELSEIF in_rule('Relative') THEN
		OPEN cur FOR SELECT p.person AS student,
			       p.surname,
			       p.name,
			       p.tax_code,
			       COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
			  FROM classrooms_students ca 
		          JOIN persons_relations rel ON ca.student = rel.person
		          JOIN persons p ON rel.person_related_to = p.person
			 WHERE ca.classroom = p_classroom
			   AND rel.person_related_to = session_db_user()
		      ORDER BY surname, name, tax_code;

	ELSEIF in_rule('Student') THEN
		OPEN cur FOR SELECT p.person AS student,
			       p.surname,
			       p.name,
			       p.tax_code,
			       COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
			  FROM classrooms_students ca 
		          JOIN persons_relations rel ON ca.student = rel.person
		          JOIN persons p ON rel.person_related_to = p.person
			 WHERE ca.classroom = p_classroom
			   AND ca.student = session_db_user()
		      ORDER BY surname, name, tax_code;
	ELSE
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = system_messages_locale(function_name,1),
		DETAIL = format(system_messages_locale(function_name,2), session_user),
		HINT = system_messages_locale(function_name,3);
	END IF;
	RETURN cur;	        
END;
$$;


ALTER FUNCTION public.relatives_by_classroom(p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 606 (class 1255 OID 17339)
-- Name: rs_columns_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rs_columns_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT *
                 FROM rs_columns;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.rs_columns_list() OWNER TO postgres;

--
-- TOC entry 607 (class 1255 OID 17340)
-- Name: rs_rows_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rs_rows_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT *
                 FROM rs_rows;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.rs_rows_list() OWNER TO postgres;

--
-- TOC entry 608 (class 1255 OID 17341)
-- Name: ruoli_by_session_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ruoli_by_session_user() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT pr.rule
 		 FROM persons_roles pr 
           INNER JOIN persons p ON ( pr.person = p.person  )  
	   INNER JOIN db_users u ON ( p.db_user = u.db_user  )  
	   INNER JOIN work_spaces sl ON ( u.work_space = sl.work_space  )  
		WHERE u.usename = "session_user"()
		  AND p.school = sl.school;
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.ruoli_by_session_user() OWNER TO postgres;

--
-- TOC entry 609 (class 1255 OID 17342)
-- Name: school_years_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION school_years_list(p_school bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
				 
DECLARE

	cur refcursor;
	function_name varchar = 'school_years_list';

BEGIN

	OPEN cur FOR SELECT xmin::text::bigint AS rv, school_year, school, description, begin_on, end_on, start_lessons_on, end_lesson_on 
		       FROM school_years 
		      WHERE school = p_school
		   ORDER BY description;

	RETURN cur;
END;
$$;


ALTER FUNCTION public.school_years_list(p_school bigint) OWNER TO postgres;

--
-- TOC entry 611 (class 1255 OID 17343)
-- Name: schools_by_description(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_by_description(p_description character varying) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT i.xmin::text::bigint AS rv,
  		      i.school,
  		      i.description,
  		      i.on_date_processing_code,
  		      i.mnemonic,
  		      i.example
	         FROM schools i
	        WHERE i.description LIKE p_description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.schools_by_description(p_description character varying) OWNER TO postgres;

--
-- TOC entry 612 (class 1255 OID 17344)
-- Name: schools_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_del(p_rv bigint, p_school bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messages di sistema utilizzati from_timela funzione 
 
DELETE FROM system_messages WHERE function_name = 'schools_del';


INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_del',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''schools'' con: ''revisione'' = ''%s'',  ''school'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_del',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_del',3,'it','Controllare il valore di: ''revisione'', ''school'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'schools_del';

BEGIN
    DELETE FROM schools t WHERE t.school = p_school AND xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_school),
	     DETAIL = format(system_messages_locale(function_name,2),current_query()),
	     HINT = system_messages_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.schools_del(p_rv bigint, p_school bigint) OWNER TO postgres;

--
-- TOC entry 610 (class 1255 OID 17345)
-- Name: schools_del_cascade(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_del_cascade(school_da_cancellare bigint) RETURNS TABLE(table_name character varying, record_deleted bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
--
-- cancella l'school in input e tutti i dati from_time esso dipendenti
--
declare
     rowcount bigint;
begin 

delete from work_spaces where school = school_da_cancellare; 
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'work_spaces .......................... : % rows cancellate', rowcount;
table_name := 'work_spaces';
record_deleted := rowcount;
return next;

delete from conversations
      using classrooms_students, persons
      where classrooms_students.classroom_student = conversations.school_record
        and classrooms_students.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'conversations ......................... : % rows cancellate', rowcount;
table_name := 'conversations';
record_deleted := rowcount;
return next;

delete from signatures
      using persons
      where signatures.teacher = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'signatures ................................. : % rows cancellate', rowcount;
table_name := 'signatures';
record_deleted := rowcount;
return next;

delete from faults
      using persons
      where faults.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'faults .............................. : % rows cancellate', rowcount;
table_name := 'faults';
record_deleted := rowcount;
return next;

delete from lessons
      using persons
      where lessons.teacher = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'lessons ............................... : % rows cancellate', rowcount;
table_name := 'lessons';
record_deleted := rowcount;
return next;

delete from absences
      using persons
      where absences.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'absences ............................... : % rows cancellate', rowcount;
table_name := 'absences';
record_deleted := rowcount;
return next;

delete from delays
      using persons
      where delays.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'delays ............................... : % rows cancellate', rowcount;
table_name := 'delays';
record_deleted := rowcount;
return next;

delete from leavings
      using persons
      where leavings.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'leavings ................................ : % rows cancellate', rowcount;
table_name := 'leavings';
record_deleted := rowcount;
return next;

delete from notes
      using classrooms, school_years
      where notes.classroom = classrooms.classroom
        and classrooms.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'notes .................................. : % rows cancellate', rowcount;
table_name := 'notes';
record_deleted := rowcount;
return next;

delete from out_of_classrooms
      using persons
      where out_of_classrooms.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'out_of_classrooms .......................... : % rows cancellate', rowcount;
table_name := 'out_of_classrooms';
record_deleted := rowcount;
return next;

delete from teachears_notes
      using classrooms, school_years
      where teachears_notes.classroom = classrooms.classroom
        and classrooms.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'teachears_notes .......................... : % rows cancellate', rowcount;
table_name := 'teachears_notes';
record_deleted := rowcount;
return next;

delete from explanations 
      using persons
      where explanations.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'explanations ....................... : % rows cancellate', rowcount;
table_name := 'explanations';
record_deleted := rowcount;
return next;

delete from valutations_qualificationtions
      using valutations, classrooms, school_years
      where valutations_qualificationtions.valutation = valutations.valutation
        and valutations.classroom = classrooms.classroom
        and classrooms.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'valutations_qualificationtions ................ : % rows cancellate', rowcount;
table_name := 'valutations_qualificationtions';
record_deleted := rowcount;
return next;

delete from valutations
      using classrooms, school_years
      where valutations.classroom = classrooms.classroom
        and classrooms.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'valutations ........................... : % rows cancellate', rowcount;
table_name := 'valutations';
record_deleted := rowcount;
return next;

delete from topics
      using degrees
      where topics.degree = degrees.degree
        and degrees.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'topics ............................. : % rows cancellate', rowcount;
table_name := 'topics';
record_deleted := rowcount;
return next;

delete from grade_types
      using subjects
      where grade_types.subject = subjects.subject
        and subjects.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'grade_types ............................. : % rows cancellate', rowcount;
table_name := 'grade_types';
record_deleted := rowcount;
return next;
--
-- riapro gli grading_meetings altrimenti non riesco a cancellare le rows from_time grading_meetings_valutations_qua
--
update grading_meetings s set close = false
  from school_years a
 where a.school_year = s.school_year
   and a.school = school_da_cancellare;

delete from grading_meetings_valutations_qua
      using grading_meetings_valutations, grading_meetings, school_years 
      where grading_meetings_valutations_qua.grading_meeting_valutation = grading_meetings_valutations.grading_meeting_valutation
        and grading_meetings_valutations.grading_meeting = grading_meetings.grading_meeting
        and grading_meetings.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'grading_meetings_valutations_qua ....... : % rows cancellate', rowcount;
table_name := 'grading_meetings_valutations_qua';
record_deleted := rowcount;
return next;

delete from grading_meetings_valutations
      using grading_meetings, school_years 
      where grading_meetings_valutations.grading_meeting = grading_meetings.grading_meeting
        and grading_meetings.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'grading_meetings_valutations .................. : % rows cancellate', rowcount;
table_name := 'grading_meetings_valutations';
record_deleted := rowcount;
return next;

delete from grading_meetings
      using school_years 
      where grading_meetings.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'grading_meetings .............................. : % rows cancellate', rowcount;
table_name := 'grading_meetings';
record_deleted := rowcount;
return next;

delete from weekly_timetable
      using classrooms, school_years
      where weekly_timetable.classroom = classrooms.classroom
        and classrooms.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'weekly_timetable ..................... : % rows cancellate', rowcount;
table_name := 'weekly_timetable';
record_deleted := rowcount;
return next;

delete from holydays 
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'holydays ............................... : % rows cancellate', rowcount;
table_name := 'holydays';
record_deleted := rowcount;
return next;

delete from classrooms_students
      using persons
      where classrooms_students.student = persons.person
        and persons.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'classrooms_students ......................... : % rows cancellate', rowcount;
table_name := 'classrooms_students';
record_deleted := rowcount;
return next;

delete from parents_meetings
      using persons
      where parents_meetings.teacher = persons.person
        and school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'parents_meetings .............................. : % rows cancellate', rowcount;
table_name := 'parents_meetings';
record_deleted := rowcount;
return next;

delete from persons
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'persons ............................... : % rows cancellate', rowcount;
table_name := 'persons';
record_deleted := rowcount;
return next;

delete from classrooms 
      using school_years
      where classrooms.school_year = school_years.school_year
        and school_years.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'classrooms ................................ : % rows cancellate', rowcount;
table_name := 'classrooms';
record_deleted := rowcount;
return next;

delete from qualificationtions
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'qualificationtions ............................ : % rows cancellate', rowcount;
table_name := 'qualificationtions';
record_deleted := rowcount;
return next;
    
delete from school_years
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'school_years ....................... : % rows cancellate', rowcount;
table_name := 'school_years';
record_deleted := rowcount;
return next;

delete from degrees
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'degrees .................. : % rows cancellate', rowcount;
table_name := 'degrees';
record_deleted := rowcount;
return next;

delete from buildings
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'buildings ................................ : % rows cancellate', rowcount;
table_name := 'buildings';
record_deleted := rowcount;
return next;
--
-- tolgo l'eventuale subject della behavior from_timel'school
--
update schools set behavior = null 
 where school = school_da_cancellare;

delete from subjects 
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'subjects ............................... : % rows cancellate', rowcount;
table_name := 'subjects';
record_deleted := rowcount;
return next;
      
delete from grades
      using metrics
      where grades.metric = metrics.metric
        and metrics.school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'grades .................................. : % rows cancellate', rowcount;
table_name := 'grades';
record_deleted := rowcount;
return next;

delete from metrics
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'metrics .............................. : % rows cancellate', rowcount;
table_name := 'metrics';
record_deleted := rowcount;
return next;

delete from communication_types
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'communication_types .................... : % rows cancellate', rowcount;
table_name := 'communication_types';
record_deleted := rowcount;
return next;

delete from schools
      where school = school_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'schools .............................. : % rows cancellate', rowcount;
table_name := 'schools';
record_deleted := rowcount;
return next;

 return ;

 end;
$$;


ALTER FUNCTION public.schools_del_cascade(school_da_cancellare bigint) OWNER TO postgres;

--
-- TOC entry 3995 (class 0 OID 0)
-- Dependencies: 610
-- Name: FUNCTION schools_del_cascade(school_da_cancellare bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_del_cascade(school_da_cancellare bigint) IS 'Il comando prende in input il codice di un school e cancella tutti i record di tutte le tabelle collegate all''school';


--
-- TOC entry 613 (class 1255 OID 17346)
-- Name: schools_enabled(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_enabled() RETURNS bigint[]
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
BEGIN 

RETURN  ARRAY( SELECT school 
   	         FROM persons
	        WHERE usename = "session_user"());
END;
$$;


ALTER FUNCTION public.schools_enabled() OWNER TO postgres;

--
-- TOC entry 614 (class 1255 OID 17347)
-- Name: schools_ins(character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'schools_ins';

BEGIN 

    INSERT INTO schools (description, on_date_processing_code, mnemonic, example)
         VALUES (p_description, p_on_date_processing_code, p_mnemonic, p_example);
         
    SELECT currval('pk_seq') INTO p_school;
    SELECT xmin::text::bigint INTO p_rv FROM schools WHERE school = p_school;
END;
$$;


ALTER FUNCTION public.schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) OWNER TO postgres;

--
-- TOC entry 616 (class 1255 OID 17348)
-- Name: schools_ins(character varying, character varying, character varying, boolean, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'schools_ins';

BEGIN 

    INSERT INTO schools (description, on_date_processing_code, mnemonic, example, logo)
         VALUES (p_description, p_on_date_processing_code, p_mnemonic, p_example, p_logo);
         
    SELECT currval('pk_seq') INTO p_school;
    SELECT xmin::text::bigint INTO p_rv FROM schools WHERE school = p_school;
END;
$$;


ALTER FUNCTION public.schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) OWNER TO postgres;

--
-- TOC entry 615 (class 1255 OID 17349)
-- Name: schools_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT i.xmin::text::bigint AS rv,
  		      i.school,
  		      i.description,
  		      i.on_date_processing_code,
  		      i.mnemonic,
  		      i.example
                 FROM schools i 
	   INNER JOIN persons p ON ( i.school = p.school  )  
	   INNER JOIN db_users u ON ( p.db_user = u.db_user  )  
	        WHERE u.usename = session_user
	     ORDER BY i.description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.schools_list() OWNER TO postgres;

--
-- TOC entry 617 (class 1255 OID 17350)
-- Name: schools_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_sel(OUT p_rv bigint, p_school bigint, OUT p_description character varying, OUT p_on_date_processing_code character varying, OUT p_mnemonic character varying, OUT p_example boolean, OUT p_logo bytea) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione
 
DELETE FROM system_messages WHERE function_name = 'schools_sel';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_sel',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''schools'' con:  ''school'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_sel',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_sel',3,'it','Controllare il valore di: ''school'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'schools_sel';

BEGIN

	SELECT xmin::text::bigint, school, description, on_date_processing_code, mnemonic, example, logo
	INTO p_rv, p_school, p_description, p_on_date_processing_code, p_mnemonic, p_example, p_logo
	FROM schools
	WHERE school = p_school;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_school),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.schools_sel(OUT p_rv bigint, p_school bigint, OUT p_description character varying, OUT p_on_date_processing_code character varying, OUT p_mnemonic character varying, OUT p_example boolean, OUT p_logo bytea) OWNER TO postgres;

--
-- TOC entry 618 (class 1255 OID 17351)
-- Name: schools_sel_logo(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_sel_logo(p_school bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  m_logo bytea;
  function_name varchar = 'schools_sel_logo';
BEGIN 
  SELECT logo INTO m_logo from schools where school = p_school;
  IF NOT FOUND THEN 
	  RAISE USING
	        ERRCODE = function_sqlcode(function_name,'1'),
	        MESSAGE = format(system_messages_locale(function_name,1), p_school::varchar),
	        DETAIL = format(system_messages_locale(function_name,2) ,current_query()),
	        HINT = system_messages_locale(function_name,3);
	END IF;                   
  RETURN m_logo;
 END;
$$;


ALTER FUNCTION public.schools_sel_logo(p_school bigint) OWNER TO postgres;

--
-- TOC entry 619 (class 1255 OID 17352)
-- Name: schools_upd(bigint, bigint, character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'schools_upd';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_upd',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''schools'' con: ''revisione'' = ''%s'',  ''school'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_upd',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_upd',3,'it','Controllare il valore di: ''revisione'', ''school'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'schools_upd';

BEGIN

	UPDATE schools SET school = p_school,description = p_description,on_date_processing_code = p_on_date_processing_code,mnemonic = p_mnemonic,example = p_example
    	WHERE school = p_school AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_school),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM schools WHERE school = p_school;
END;
$$;


ALTER FUNCTION public.schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) OWNER TO postgres;

--
-- TOC entry 621 (class 1255 OID 17353)
-- Name: schools_upd(bigint, bigint, character varying, character varying, character varying, boolean, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'schools_upd';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_upd',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''schools'' con: ''revisione'' = ''%s'',  ''school'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_upd',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('schools_upd',3,'it','Controllare il valore di: ''revisione'', ''school'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'schools_upd';

BEGIN

	UPDATE schools SET school = p_school,description = p_description,on_date_processing_code = p_on_date_processing_code,mnemonic = p_mnemonic,example = p_example,logo = p_logo
    	WHERE school = p_school AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_school),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM schools WHERE school = p_school;
END;
$$;


ALTER FUNCTION public.schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) OWNER TO postgres;

--
-- TOC entry 622 (class 1255 OID 17354)
-- Name: schools_upd_logo(bigint, bigint, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_upd_logo(p_rv bigint, p_school bigint, p_logo bytea) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'schools_upd_logo';
BEGIN 
  UPDATE schools SET logo=p_logo WHERE school = p_school  AND xmin = p_rv::text::xid;
  IF NOT FOUND THEN 
	  RAISE USING
	        ERRCODE = function_sqlcode(function_name,'1'),
	        MESSAGE = format(system_messages_locale(function_name,1), p_school::varchar),
	        DETAIL = format(system_messages_locale(function_name,1) ,current_query()),
	        HINT = system_messages_locale(function_name,3);
	END IF;                   
   RETURN xmin::text::bigint FROM schools WHERE school = p_school;
 END;
$$;


ALTER FUNCTION public.schools_upd_logo(p_rv bigint, p_school bigint, p_logo bytea) OWNER TO postgres;

--
-- TOC entry 623 (class 1255 OID 17355)
-- Name: session_db_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_db_user() RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
declare
	v_db_user bigint;
begin 

	SELECT db_user
	INTO v_db_user
	FROM db_users
	WHERE usename = session_user;

	return v_db_user;

 end;
$$;


ALTER FUNCTION public.session_db_user() OWNER TO postgres;

--
-- TOC entry 4006 (class 0 OID 0)
-- Dependencies: 623
-- Name: FUNCTION session_db_user(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION session_db_user() IS 'Il comando  restituisce l''db_user collegato';


--
-- TOC entry 620 (class 1255 OID 17356)
-- Name: session_person(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_person(p_school bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
declare
	v_person bigint;
begin 

	SELECT p.person INTO v_person
	  FROM persons p
          JOIN db_users u ON u.db_user = p.db_user
         WHERE u.usename = session_user
           AND p.school = p_school;

	return v_person;

 end;
$$;


ALTER FUNCTION public.session_person(p_school bigint) OWNER TO postgres;

--
-- TOC entry 4008 (class 0 OID 0)
-- Dependencies: 620
-- Name: FUNCTION session_person(p_school bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION session_person(p_school bigint) IS 'Il comando  restituisce la person dell''db_user collegato a seconfrom_time dell''school passato come parametro';


--
-- TOC entry 624 (class 1255 OID 17357)
-- Name: set_work_space_default(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_work_space_default(p_work_space bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
La funzione imposta lo spazio di lavoro per l'db_user corrente
non viene gestito il row versioning
*/
DECLARE
  function_name varchar = 'set_work_space_default';
BEGIN
  UPDATE db_users SET work_space = p_work_space WHERE usename = session_user;
  IF NOT FOUND THEN 
     RAISE EXCEPTION USING
     ERRCODE = function_sqlcode(function_name,'1'),
     MESSAGE = format(system_messages_locale(function_name,1),p_work_space),
     DETAIL = format(system_messages_locale(function_name,2),current_query()),
     HINT = system_messages_locale(function_name,3);
  END IF;
END;
$$;


ALTER FUNCTION public.set_work_space_default(p_work_space bigint) OWNER TO postgres;

--
-- TOC entry 625 (class 1255 OID 17358)
-- Name: signatures_by_teacher_classroom(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION signatures_by_teacher_classroom(p_teacher bigint, p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT on_date,
		       at_time
		  FROM signatures
		 WHERE teacher = p_teacher
		   AND classroom = p_classroom
	      ORDER BY on_date, at_time;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.signatures_by_teacher_classroom(p_teacher bigint, p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 626 (class 1255 OID 17359)
-- Name: students_by_classroom(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION students_by_classroom(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
	cur refcursor;
	function_name varchar = 'students_by_classroom';
BEGIN 
	IF in_uno_dei_ruoli('{"Supervisor","Executive","Teacher"}') THEN
		OPEN cur FOR SELECT p.person AS student,
			       p.surname,
			       p.name,
			       p.tax_code,
	--		       p.thumbnail
			       encode(thumbnail,'base64') as thumbnail
			  FROM classrooms_students ca 
		          JOIN persons p ON ca.student = p.person
			 WHERE ca.classroom = p_classroom
		      ORDER BY surname, name, tax_code;

	ELSEIF in_rule('Relative') THEN
		OPEN cur FOR SELECT p.person AS student,
			       p.surname,
			       p.name,
			       p.tax_code,
	--		       p.thumbnail
			       encode(thumbnail,'base64') as thumbnail
			  FROM classrooms_students ca 
		          JOIN persons p ON ca.student = p.person
		          JOIN persons_relations rel ON ca.student = rel.person
			 WHERE ca.classroom = p_classroom
			   AND rel.person_related_to = session_db_user()
		      ORDER BY surname, name, tax_code;

	ELSEIF in_rule('Student') THEN
		OPEN cur FOR SELECT p.person AS student,
			       p.surname,
			       p.name,
			       p.tax_code,
	--		       p.thumbnail
			       encode(thumbnail,'base64') as thumbnail
			  FROM classrooms_students ca
		          JOIN persons p ON ca.student = p.person
			 WHERE ca.classroom = p_classroom
			   AND ca.student = session_db_user()
		      ORDER BY surname, name, tax_code;
	ELSE
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = system_messages_locale(function_name,1),
		DETAIL = format(system_messages_locale(function_name,2), session_user),
		HINT = system_messages_locale(function_name,3);
	END IF;
	RETURN cur;	        
END;
$$;


ALTER FUNCTION public.students_by_classroom(p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 627 (class 1255 OID 17360)
-- Name: subjects_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_del(p_rv bigint, p_subject bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messages di sistema utilizzati from_timela funzione 
 
DELETE FROM system_messages WHERE function_name = 'subjects_del';


INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_del',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''subjects'' con: ''revisione'' = ''%s'',  ''subject'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_del',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_del',3,'it','Controllare il valore di: ''revisione'', ''subject'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'subjects_del';

BEGIN
    DELETE FROM subjects t
	      WHERE t.subject = p_subject AND
	            xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_subject),
	     DETAIL = format(system_messages_locale(function_name,2),current_query()),
	     HINT = system_messages_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.subjects_del(p_rv bigint, p_subject bigint) OWNER TO postgres;

--
-- TOC entry 628 (class 1255 OID 17361)
-- Name: subjects_ins(bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'subjects_ins';

BEGIN 

    INSERT INTO subjects (school, description)
         VALUES (p_school, p_description);
         
    SELECT currval('pk_seq') INTO p_subject;
    SELECT xmin::text::bigint INTO p_rv FROM public.subjects WHERE subject = p_subject;
END;
$$;


ALTER FUNCTION public.subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying) OWNER TO postgres;

--
-- TOC entry 630 (class 1255 OID 17362)
-- Name: subjects_ins(bigint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'subjects_ins';

BEGIN 

    INSERT INTO subjects (school, description, metric)
         VALUES (p_school, p_description, p_metric);
         
    SELECT currval('pk_seq') INTO p_subject;
    SELECT xmin::text::bigint INTO p_rv FROM subjects WHERE subject = p_subject;
END;
$$;


ALTER FUNCTION public.subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) OWNER TO postgres;

--
-- TOC entry 629 (class 1255 OID 17363)
-- Name: subjects_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_list(p_school bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
				 
DECLARE

	cur refcursor;
	function_name varchar = 'subjects_list';

BEGIN

	OPEN cur FOR SELECT xmin::text::bigint AS rv, subject, school, description
		       FROM subjects 
	              WHERE school = p_school
		   ORDER BY description;
	RETURN cur;
END;
$$;


ALTER FUNCTION public.subjects_list(p_school bigint) OWNER TO postgres;

--
-- TOC entry 631 (class 1255 OID 17364)
-- Name: subjects_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione
 
DELETE FROM system_messages WHERE function_name = 'subjects_sel';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_sel',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''subjects'' con:  ''subject'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_sel',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_sel',3,'it','Controllare il valore di: ''subject'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'subjects_sel';

BEGIN

	SELECT xmin::text::bigint, subject, school, description
	INTO p_rv, p_subject, p_school, p_description
	FROM subjects
	WHERE subject = p_subject;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_subject),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) OWNER TO postgres;

--
-- TOC entry 632 (class 1255 OID 17365)
-- Name: subjects_upd(bigint, bigint, bigint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_upd(p_rv bigint, p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'subjects_upd';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_upd',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''subjects'' con: ''revisione'' = ''%s'',  ''subject'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_upd',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('subjects_upd',3,'it','Controllare il valore di: ''revisione'', ''subject'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'subjects_upd';

BEGIN

	UPDATE subjects SET subject = p_subject,school = p_school,description = p_description,metric = p_metric
		WHERE subject = p_subject AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_subject),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM schools WHERE school = p_school;
END;
$$;


ALTER FUNCTION public.subjects_upd(p_rv bigint, p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) OWNER TO postgres;

--
-- TOC entry 633 (class 1255 OID 17366)
-- Name: teachers_by_school(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION teachers_by_school(p_school bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
	IF in_uno_dei_ruoli('{"Supervisor","Executive","Employee"}')  THEN
		OPEN cur FOR SELECT p.person AS teacher,
				    p.surname,
				    p.name,
				    p.tax_code,
				    COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
		               FROM persons p
			       JOIN persons_roles pr ON p.person = pr.person
			      WHERE school = p_school
				AND pr.rule = 'Teacher'
			   ORDER BY surname, name, tax_code;
	ELSEIF in_rule('Teacher') THEN
		OPEN cur FOR SELECT p.person AS teacher,
				    p.surname,
				    p.name,
				    p.tax_code,
				    COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
		               FROM persons p
			       JOIN persons_roles pr ON p.person = pr.person
			      WHERE school = p_school
			        AND p.person = session_person(p_school)
				AND pr.rule = 'Teacher'
			   ORDER BY surname, name, tax_code;
	ELSE
		OPEN cur FOR SELECT p.person AS teacher,
				    p.surname,
				    p.name,
				    p.tax_code,
				    COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
		               FROM persons p
			       JOIN persons_roles pr ON p.person = pr.person
			      WHERE 1=0;
	END IF;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.teachers_by_school(p_school bigint) OWNER TO postgres;

--
-- TOC entry 634 (class 1255 OID 17367)
-- Name: thumbnail_default(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION thumbnail_default() RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $$

BEGIN
	RETURN  decode('/9j/4AAQSkZJRgABAQEAFgAWAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
			ODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2Nj
			Y2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCABkAEsDASIA
			AhEBAxEB/8QAGwABAAMBAQEBAAAAAAAAAAAAAAQFBgMBAgf/xAAyEAACAgECAwYDBwUAAAAAAAAA
			AQIDBAURITFRBhIiQWFxE4HRFEJSscHh8SMyM2KR/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQR
			AQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AP0AAAADjkZVGNHe+2MPRvi/kB2BVS7QYKey
			dkvVRJGPq2FkPuwvSl0n4fzAmg8PQAAAAEfOyViYllz5xXBdX5AQNY1f7HvRRs72uL8ofuZiyyds
			3OyTnJ823uLJysslObcpSe7b8z5AAAC10vWbMSSrvk50cuPFx9voamEozgpRacZLdNeZgTRdmsxy
			jPEnLfu+KG/TzQF8AABRdqLWqaKV96Tk/l/Jemb7UJ/Hofl3X+YFGAAAAAEvSrXTqVE1+NRfs+H6
			kQ6YybyakuffW3/QN4AABSdp6e9i1XJf2S2fs/4Ls5ZNEcnHspnymtvb1AwgOmRRPGvnTatpRezO
			YAAACbo9Px9TpjtwjLvv5cSEafs7guiiWRYtp2rwrpH9wLkAAAc7rq6KpWWyUYR5tmX1DWr8i9Oi
			cqq4PeKT4v1f0AvNU0uvPr3W0Lorwy6+jMtlYd+JZ3L63Ho/J+zNJpmtU5UY13tV3cuPKXsWcoxn
			FxklJPmmtwMCexjKclGKcm+SS3NpLTMGT3eLV8o7HanHpo/w1Qr3592KQFFpWhScldmx2iuKr6+/
			0NCcMvNow6+/fNLpFc37IzOVrOVdlK2qbrjB+GCfD59QNcCBpmp159e3CN0V4ofqvQngZPXNR+13
			/Cqf9Gt8P9n1KsAATMbVMzF2VdzcV92fFEMAXMe0mUl4qqW+uz+pxu17Oti0pQr3/BH6lYAPqdk7
			JOVk5Tk+bk92fIAHTHvnjXwuqe04vdGux9VxLqIWSuhXKS4xk+KZjQAAAAAAAAAAAAAAf//Z','base64');
END;
$$;


ALTER FUNCTION public.thumbnail_default() OWNER TO postgres;

--
-- TOC entry 4020 (class 0 OID 0)
-- Dependencies: 634
-- Name: FUNCTION thumbnail_default(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION thumbnail_default() IS 'Restituisce l''immagine di default per la miniatura della photo della person
****************************************
* Questa funzione Ã¨ definita IMMUTABLE *
****************************************';


--
-- TOC entry 635 (class 1255 OID 17368)
-- Name: topics_by_subject_classroom(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_by_subject_classroom(p_subject bigint, p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT a.xmin::text::bigint AS rv,
		       a.topic,
		       a.description
		  FROM topics a, classrooms c 
		 WHERE c.classroom = p_classroom
		   AND a.subject = p_subject
		   AND a.course_year = c.course_year
		   AND a.degree = c.degree  
	      ORDER BY a.description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.topics_by_subject_classroom(p_subject bigint, p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 636 (class 1255 OID 17369)
-- Name: topics_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_del(p_rv bigint, p_topic bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... martedÃ¬ 02 settembre 2014 (18:39:17 CEST)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messages di sistema utilizzati from_timela funzione 
 
DELETE FROM system_messages WHERE function_name = 'topics_del';


INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_del',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''topics'' con: ''revisione'' = ''%s'',  ''topic'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_del',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_del',3,'it','Controllare il valore di: ''revisione'', ''topic'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'topics_del';

BEGIN
    DELETE FROM topics t
	      WHERE t.topic = p_topic AND
	            xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_topic),
	     DETAIL = format(system_messages_locale(function_name,2),current_query()),
	     HINT = system_messages_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.topics_del(p_rv bigint, p_topic bigint) OWNER TO postgres;

--
-- TOC entry 637 (class 1255 OID 17370)
-- Name: topics_ins_rid(bigint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_ins_rid(OUT p_rv bigint, OUT p_topic bigint, p_subject bigint, p_description character varying, p_classroom bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... martedÃ¬ 02 settembre 2014 (18:39:17 CEST)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

/*
-- messages di sistema utilizzati from_timela funzione 
 
DELETE FROM system_messages WHERE function_name = 'topics_ins_rid';


INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_ins_rid',1,'it','Non Ã¨ stata trovata la classroom: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_ins_rid',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_ins_rid',3,'it','Controllare il valore della classroom e riprovare l''operazione'); 

*/

  function_name varchar = 'topics_ins_rid';

BEGIN 
    PERFORM 1 FROM CLASSI WHERE CLASSE = p_classroom;
    
    IF NOT FOUND THEN RAISE USING
	ERRCODE = function_sqlcode(function_name,'1'),
	MESSAGE = format(system_messages_locale(function_name,1),p_classroom),
	DETAIL = format(system_messages_locale(function_name,2),current_query()),
	HINT = system_messages_locale(function_name,3);
    END IF;

    INSERT INTO topics (subject, description, course_year, degree)
         SELECT p_subject, p_description, course_year, degree
           FROM classrooms
          WHERE classroom = p_classroom;
         
    SELECT currval('pk_seq') INTO p_topic;
    SELECT xmin::text::bigint INTO p_rv FROM topics WHERE topic = p_topic;
END;
$$;


ALTER FUNCTION public.topics_ins_rid(OUT p_rv bigint, OUT p_topic bigint, p_subject bigint, p_description character varying, p_classroom bigint) OWNER TO postgres;

--
-- TOC entry 638 (class 1255 OID 17371)
-- Name: topics_upd_rid(bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_upd_rid(p_rv bigint, p_topic bigint, p_description character varying) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... martedÃ¬ 02 settembre 2014 (18:55:26 CEST)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'topics_upd_rid';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_upd_rid',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''topics'' con: ''revisione'' = ''%s'',  ''topic'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_upd_rid',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('topics_upd_rid',3,'it','Controllare il valore di: ''revisione'', ''topic'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'topics_upd_rid';

BEGIN

	UPDATE topics SET topic = p_topic,description = p_description
    	WHERE topic = p_topic AND xmin = p_rv::text::xid;

	IF NOT FOUND THEN RAISE USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_topic),
		DETAIL = format(system_messages_locale(function_name,2),current_query()),
		HINT = system_messages_locale(function_name,3);
	END IF;
	
	RETURN xmin::text::bigint FROM topics WHERE topic = p_topic;
END;
$$;


ALTER FUNCTION public.topics_upd_rid(p_rv bigint, p_topic bigint, p_description character varying) OWNER TO postgres;

--
-- TOC entry 639 (class 1255 OID 17372)
-- Name: tr_absences_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_absences_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_absences_iu';
	v_school bigint;
BEGIN
--
-- leggo l'school della classroom
--
        SELECT a.school INTO v_school FROM classrooms c
	                                  JOIN school_years a ON a.school_year = c.school_year
	                                 WHERE c.classroom = new.classroom;
--
-- controllo che nel on_date dell'absence ci sia almeno una lesson
--
	PERFORM 1 FROM lessons l
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.absence,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.on_date, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la explanation, se indicata, sia relativa a quell'student, a quel on_date di absence e creata dopo o to_time massimo il on_date stesso dell'absence
--
	IF new.explanation IS NOT NULL THEN
		PERFORM 1 FROM explanations WHERE explanation=new.explanation AND student = new.student AND created_on >= new.on_date AND new.on_date BETWEEN from_time AND to_time ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,6), new.absence, new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,8), new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school dell'student sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = system_messages_locale(function_name,9),
		   DETAIL = format(system_messages_locale(function_name,10), new.absence, new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = system_messages_locale(function_name,9),
		   DETAIL = format(system_messages_locale(function_name,12), new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,11);
	   END IF;	   
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'7'),
		   MESSAGE = system_messages_locale(function_name,13),
		   DETAIL = format(system_messages_locale(function_name,14), new.absence, new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'8'),
		   MESSAGE = system_messages_locale(function_name,13),
		   DETAIL = format(system_messages_locale(function_name,16), new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,15);
	   END IF;	   
	END IF;	
--
-- controllo che l'student,  nello on_date, non sia giÃ  stato segborn come delay
--
	PERFORM 1 FROM delays 
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date
	           AND student = new.student;
	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'9'),
			   MESSAGE = system_messages_locale(function_name,17),
			   DETAIL = format(system_messages_locale(function_name,18), new.absence, new.student, new.classroom, new.on_date),
			   HINT = system_messages_locale(function_name,19);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'A'),
			   MESSAGE = system_messages_locale(function_name,17),
			   DETAIL = format(system_messages_locale(function_name,20), new.student, new.classroom, new.on_date),
			   HINT = system_messages_locale(function_name,19);
		END IF;	   
	END IF;
--
-- controllo che l'student,  nello on_date, non sia giÃ  stato segborn come uscito
--
	PERFORM 1 FROM leavings 
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date
	           AND student = new.student;
	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'B'),
			   MESSAGE = system_messages_locale(function_name,21),
			   DETAIL = format(system_messages_locale(function_name,22),new.absence, new.student, new.classroom, new.on_date),
			   HINT = system_messages_locale(function_name,23);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'C'),
			   MESSAGE = system_messages_locale(function_name,21),
			   DETAIL = format(system_messages_locale(function_name,24),new.student, new.classroom, new.on_date),
			   HINT = system_messages_locale(function_name,23);
		END IF;	   
	END IF;
--
-- controllo che l'student, nello on_date, non sia giÃ  stato segborn come fuori classroom
--
	PERFORM 1 FROM out_of_classrooms 
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date
	           AND student = new.student;
	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'D'),
			   MESSAGE = system_messages_locale(function_name,25),
			   DETAIL = format(system_messages_locale(function_name,26), new.absence, new.student, new.classroom, new.on_date),
			   HINT = system_messages_locale(function_name,27);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'E'),
			   MESSAGE = system_messages_locale(function_name,25),
			   DETAIL = format(system_messages_locale(function_name,28), new.student, new.classroom, new.on_date),
			   HINT = system_messages_locale(function_name,27);
		END IF;	   
	END IF;
--
-- controllo che l'student sia nel rule students
--
	IF NOT in_rule('Student',new.student) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = system_messages_locale(function_name,29),
			   DETAIL = format(system_messages_locale(function_name,30), new.absence, new.student),
			   HINT = system_messages_locale(function_name,31);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = system_messages_locale(function_name,29),
			   DETAIL = format(system_messages_locale(function_name,32), new.student),
			   HINT = system_messages_locale(function_name,31);
		END IF;	   
	END IF;
--
-- controllo che il teacher sia nel rule teachers
--
	IF NOT in_rule('Teacher',new.teacher) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'H'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,34), new.absence, new.teacher),
			   HINT = system_messages_locale(function_name,35);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'I'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,36), new.teacher),
			   HINT = system_messages_locale(function_name,35);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_absences_iu() OWNER TO postgres;

--
-- TOC entry 640 (class 1255 OID 17373)
-- Name: tr_classrooms_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_classrooms_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_classrooms_iu';
BEGIN
--
-- controllo che school_year e degree siano dello stesso school
--
	PERFORM 1 FROM school_years a
	          JOIN degrees i ON i.school = a.school
	         WHERE a.school_year = new.school_year
	           AND i.degree = new.degree;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.classroom, new.school_year, new.degree),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.school_year, new.degree),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_classrooms_iu() OWNER TO postgres;

--
-- TOC entry 641 (class 1255 OID 17374)
-- Name: tr_classrooms_students_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_classrooms_students_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_classrooms_students_iu';
BEGIN
--
-- controllo che classroom e student siano dello stesso school
--
	PERFORM 1 FROM classrooms c
		  JOIN school_years a ON a.school_year = c.school_year
	          JOIN persons p ON a.school = p.school
	         WHERE c.classroom = new.classroom
	           AND p.person = new.student;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.classroom_student, new.classroom, new_student),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.classroom, new_anno_student),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- l'aluuno puÃ² far parte di piÃ¹ classrooms:
-- esiste il caso che una classroom abbia alcune subjects in city e poi aluni students abbiano
-- alcune subjects e altri abbiano altre subjects, in questo caso ogni student farÃ  parte di due classrooms
-- una per le subjects cities ed un'altra per le restanti.
-- questo commento Ã¨ stato messo per evitare di ripetere l'errore di aggiungere un controllo errato
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_classrooms_students_iu() OWNER TO postgres;

--
-- TOC entry 642 (class 1255 OID 17375)
-- Name: tr_communications_media_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_communications_media_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_communications_media_iu';
BEGIN
--
-- controllo che se richiesta la notification il mezzo di citiescazione la gestisca
--
	IF new.notification = TRUE THEN
		PERFORM 1 FROM communication_types WHERE communication_type = new.communication_type AND notificationtion_management = TRUE;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'1'),
				   MESSAGE = system_messages_locale(function_name,1),
				   DETAIL = format(system_messages_locale(function_name,2), new.communication_media, new.communication_type),
				   HINT = system_messages_locale(function_name,3);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'2'),
				   MESSAGE = system_messages_locale(function_name,1),
				   DETAIL = format(system_messages_locale(function_name,4), new.communication_type),
				   HINT = system_messages_locale(function_name,3);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school del communication_type sia uguale a quello della person
--
	PERFORM 1 FROM communication_types tc
	          JOIN persons p ON p.school = tc.school
	         WHERE tc.communication_type = new.communication_type
	           AND p.person = new.person;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,6), new.communication_media, new.communication_type, new.person),
			   HINT = system_messages_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,8), new.communication_type, new.person),
			   HINT = system_messages_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_communications_media_iu() OWNER TO postgres;

--
-- TOC entry 643 (class 1255 OID 17376)
-- Name: tr_conversations_invites_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_conversations_invites_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_conversations_invites_iu';
BEGIN
--
-- controllo che la person invitata sia dello stesso istituo dell'student a cui fa' zip_codeo la conversation
--
	PERFORM 1 FROM conversations c
	          JOIN classrooms_students ca ON c.school_record = ca.classroom_student
	          JOIN persons alu ON ca.student = p.person
	          JOIN persons inv ON alu.school = inv.school
	         WHERE c.conversation = new.conversation
	           AND inv.person = new.invited;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.conversations_invited, new.conversation, new.invited),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.conversation, new.invited),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_conversations_invites_iu() OWNER TO postgres;

--
-- TOC entry 644 (class 1255 OID 17377)
-- Name: tr_db_users_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_db_users_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_db_users_iu';
    BEGIN
        --
        -- check user name
        --
        PERFORM 1 FROM pg_shadow WHERE usename = new.usename;

        IF NOT FOUND THEN
           IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,2) ,new.db_user, new.usename),
		   HINT = system_messages_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = system_messages_locale(function_name,4),
		   DETAIL = format(system_messages_locale(function_name,5) ,new.usename),
		   HINT = system_messages_locale(function_name,3);
	   END IF;
	END IF;
	RETURN NEW;
    END;
$$;


ALTER FUNCTION public.tr_db_users_iu() OWNER TO postgres;

--
-- TOC entry 646 (class 1255 OID 17378)
-- Name: tr_delays_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_delays_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_delays_iu';
BEGIN
--
-- controllo che nel on_date dell'delay ci sia almeno una lesson
--
	PERFORM 1 FROM lessons l
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.delay,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.on_date, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la explanation, se indicata, sia relativa a quell'student, a quel on_date di delay e creata dopo o to_time massimo il on_date stesso dell'delay
--
	IF new.explanation IS NOT NULL THEN
		PERFORM 1 FROM explanations WHERE explanation=new.explanation AND student = new.student AND created_on >= new.on_date AND new.on_date BETWEEN from_time AND to_time ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,6), new.delay, new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,8), new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school dell'student sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

	IF NOT FOUND THEN
	IF (TG_OP = 'UPDATE') THEN
		RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'5'),
			MESSAGE = system_messages_locale(function_name,9),
			DETAIL = format(system_messages_locale(function_name,10), new.out_of_classroom, new.student, v_school, new.classroom),
			HINT = system_messages_locale(function_name,11);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'6'),
			MESSAGE = system_messages_locale(function_name,9),
			DETAIL = format(system_messages_locale(function_name,12), new.student, v_school, new.classroom),
			HINT = system_messages_locale(function_name,11);
		END IF;	   
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'7'),
			MESSAGE = system_messages_locale(function_name,13),
			DETAIL = format(system_messages_locale(function_name,14), new.out_of_classroom, new.teacher, v_school, new.classroom),
			HINT = system_messages_locale(function_name,15);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'8'),
			MESSAGE = system_messages_locale(function_name,13),
			DETAIL = format(system_messages_locale(function_name,16), new.teacher, v_school, new.classroom),
			HINT = system_messages_locale(function_name,15);
		END IF;	   
	END IF;	
--
-- l'student in delay non puÃ² essere assente
--
	PERFORM 1 FROM absences WHERE on_date = new.on_date AND student = new.student;

	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'9'),
			MESSAGE = system_messages_locale(function_name,17),
			DETAIL = format(system_messages_locale(function_name,18), new.delay, new.student, new.on_date),
			HINT = system_messages_locale(function_name,19);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'A'),
			MESSAGE = system_messages_locale(function_name,17),
			DETAIL = format(system_messages_locale(function_name,20), new.student, new.on_date),
			HINT = system_messages_locale(function_name,19);
		END IF;	   
	END IF;	
--
-- controllo che il teacher sia nel rule 'Teacher'
--
	IF NOT in_rule('Teacher',new.teacher) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'B'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,34), new.delay, new.teacher),
			   HINT = system_messages_locale(function_name,35);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'C'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,36), new.teacher),
			   HINT = system_messages_locale(function_name,35);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_delays_iu() OWNER TO postgres;

--
-- TOC entry 647 (class 1255 OID 17379)
-- Name: tr_explanations_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_explanations_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_explanations_iu';
	v_school	bigint;
	v_born		date;

BEGIN
--
-- controllo che l'student sia effettivamento un student
--
	IF NOT in_rule('Student',student) THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,2), new.explanation, new.student),
		   HINT = system_messages_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,4), new.student),
		   HINT = system_messages_locale(function_name,3);
	   END IF;	   
	END IF;

--
-- recupero l'school e la on_date di nascita dell'student dell'student
--
	SELECT school, born INTO v_school, v_born
		FROM persons 
		WHERE person = student;
--
-- controllo che l'school dell'student sia uguale a quello della person che ha creato la explanation
--
	PERFORM 1 FROM persons WHERE person = new.created_by AND school = v_school;

	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'3'),
			MESSAGE = system_messages_locale(function_name,5),
			DETAIL = format(system_messages_locale(function_name,6), new.explanation, new.student, v_school, new.created_by),
			HINT = system_messages_locale(function_name,7);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'4'),
			MESSAGE = system_messages_locale(function_name,5),
			DETAIL = format(system_messages_locale(function_name,8), new.student, v_school, new.created_by),
			HINT = system_messages_locale(function_name,7);
		END IF;	   
	END IF;
--
-- controllo che se la explanation Ã¨ stata fatta from_timel'student e questo sia maggiorenne
--
	IF new.created_by = new.student THEN
		IF (SELECT extract('year' from age(new.registrato_il, v_born)) < 18) THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'5'),
				MESSAGE = system_messages_locale(function_name,9),
				DETAIL = format(system_messages_locale(function_name,10), new.explanation, new.student),
				HINT = system_messages_locale(function_name,11);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'6'),
				MESSAGE = system_messages_locale(function_name,9),
				DETAIL = format(system_messages_locale(function_name,12), new.student),
				HINT = system_messages_locale(function_name,11);
			END IF;
		END IF;
	ELSE
	--
	-- altrimenti controllo che se la explanation sia stata fatta from_time un family 
	-- esplicitamente autorizzato a giustificare e maggiorenne
	--
		PERFORM 1 FROM persons_relations pr
			  JOIN persons p ON pr.person_related_to = p.person
		         WHERE pr.person = new.student
		           AND pr.person_related_to = new.created_by
		           AND pr.can_do_explanation = true
		           AND extract('year' from age(new.registrato_il, p.born)) >= 18;
		IF NOT FOUND THEN
			--
			-- altrimenti controllo se la person che ha creato la explanation Ã¨ nel rule di
			-- gestori, dirigenti, impiegati o teachers 
			--
			IF NOT in_uno_dei_ruoli('{"Supervisor","Executive","Impiegati","Teacher"}',new.created_by) THEN
				IF (TG_OP = 'UPDATE') THEN
					RAISE EXCEPTION USING
					ERRCODE = function_sqlcode(function_name,'7'),
					MESSAGE = system_messages_locale(function_name,13),
					DETAIL = format(system_messages_locale(function_name,14), new.explanation, new.created_by),
					HINT = system_messages_locale(function_name,15);
				ELSE
					RAISE EXCEPTION USING
					ERRCODE = function_sqlcode(function_name,'8'),
					MESSAGE = system_messages_locale(function_name,13),
					DETAIL = format(system_messages_locale(function_name,16), new.created_by),
					HINT = system_messages_locale(function_name,15);
				END IF;	
			END IF;			
		END IF;
	END IF;
--	
-- controllo che l'school dell'student sia uguale a quello della person che ha registrato la explanation
--
	IF new.registered_by IS NOT NULL THEN

		PERFORM 1 FROM persons WHERE person = new.registered_by AND school = v_school;

		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'9'),
				MESSAGE = system_messages_locale(function_name,17),
				DETAIL = format(system_messages_locale(function_name,18), new.explanation, new.registrato_from_time),
				HINT = system_messages_locale(function_name,19);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'10'),
				MESSAGE = system_messages_locale(function_name,17),
				DETAIL = format(system_messages_locale(function_name,20), new.registrato_from_time),
				HINT = system_messages_locale(function_name,19);
			END IF;	   
		END IF;
--
-- controllo che la person che ha registrato la explanation sia un teacher, un impiegato, un dirigente o un gestore
--
		IF NOT uno_dei_ruoli('{"Supervisor","Executive","Employee","Teacher"}')  THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'11'),
				MESSAGE = system_messages_locale(function_name,21),
				DETAIL = format(system_messages_locale(function_name,22), new.explanation, new.registrato_from_time),
				HINT = system_messages_locale(function_name,23);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'12'),
				MESSAGE = system_messages_locale(function_name,21),
				DETAIL = format(system_messages_locale(function_name,24), new.registrato_from_time),
				HINT = system_messages_locale(function_name,23);
			END IF;	   
		END IF;			
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_explanations_iu() OWNER TO postgres;

--
-- TOC entry 645 (class 1255 OID 17380)
-- Name: tr_faults_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_faults_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_faults_iu';
	v_school bigint;
BEGIN
--
-- leggo l'school della classroom
--
        SELECT school INTO v_school FROM classrooms WHERE classroom = new.classroom;
--
-- controllo che l'student faccia parte della classroom della lesson
--
	PERFORM 1 FROM lessons l
		  JOIN classrooms_students ca ON  ca.classroom = l.classroom
	         WHERE l.lesson = new.lesson
	           AND ca.student = new.student;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.fault, new.student,  new.lesson),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4),  new.student,  new.lesson),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la note, se indicata, sia relativa a quell'student, e a quella classroom
--
	IF new.note IS NOT NULL THEN
		PERFORM 1 FROM notes n
		          JOIN lessons l ON n.classroom = l.classroom
 		         WHERE n.note = new.note
		           AND n.student = new.student
		           AND l.lesson = new.lesson;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,6), new.fault, new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,8), new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'student sia nel rule students
--
	IF NOT in_rule('Student',new.student) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = system_messages_locale(function_name,9),
			   DETAIL = format(system_messages_locale(function_name,10), new.fault, new.student),
			   HINT = system_messages_locale(function_name,11);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = system_messages_locale(function_name,9),
			   DETAIL = format(system_messages_locale(function_name,12), new.student),
			   HINT = system_messages_locale(function_name,11);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_faults_iu() OWNER TO postgres;

--
-- TOC entry 648 (class 1255 OID 17381)
-- Name: tr_grading_meetings_i(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_i() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_grading_meetings_i';
BEGIN
--
-- controllo che ci sia un solo grading_meeting dopo la on_date di end_on lessons
--
	PERFORM 1 FROM grading_meetings s
	          JOIN school_years a ON a.school_year = s.school_year
		 WHERE s.school_year = new.school_year
		   AND new.on_date > a.end_lesson_on
		   AND s.on_date > a.end_lesson_on;
	IF FOUND THEN
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = system_messages_locale(function_name,1),
		DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.school_year, new.grading_meeting),
		HINT = system_messages_locale(function_name,3);
	END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_i() OWNER TO postgres;

--
-- TOC entry 649 (class 1255 OID 17382)
-- Name: tr_grading_meetings_valutations_d(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_d() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_grading_meetings_valutations_d';
BEGIN
--
-- controllo che lo grading_meeting sia aperto
--
	PERFORM 1 FROM grading_meetings 
		 WHERE grading_meeting = old.grading_meeting
		   AND close = false;
	IF NOT FOUND THEN
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = system_messages_locale(function_name,1),
		DETAIL = format(system_messages_locale(function_name,2), new.grading_meeting_valutation, new.grading_meeting),
		HINT = system_messages_locale(function_name,3);
	END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_d() OWNER TO postgres;

--
-- TOC entry 650 (class 1255 OID 17383)
-- Name: tr_grading_meetings_valutations_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_grading_meetings_valutations_iu';
BEGIN
--
-- controllo che la classroom sia dello stesso school_year dello grading_meeting
--
	PERFORM 1 FROM grading_meetings s
	          JOIN classrooms c ON s.school_year = c.school_year
	         WHERE s.grading_meeting = new.grading_meeting
	           AND c.classroom = new.classroom;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.grading_meeting_valutation, new.grading_meeting,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.grading_meeting,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'student appartenga alla classroom 
--
	PERFORM 1 FROM classrooms_students ca
	         WHERE ca.classroom = new.classroom
	           AND ca.student = new.student;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,6), new.grading_meeting_valutation, new.classroom,  new.student),
			   HINT = system_messages_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,8), new.classroom, new.student),
			   HINT = system_messages_locale(function_name,7);
		END IF;	   
	END IF;
--
-- controllo che la subject appartenga allo stesso school dell'school_year dello grading_meeting
--
	PERFORM 1 FROM grading_meetings s
	          JOIN school_years a ON s.school_year = a.school_year
	          JOIN subjects m ON a.school = m.school
	         WHERE s.grading_meeting = new.grading_meeting
	           AND m.subject = new.subject;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'5'),
			   MESSAGE = system_messages_locale(function_name,9),
			   DETAIL = format(system_messages_locale(function_name,10), new.grading_meeting_valutation, new.subject,  new.grading_meeting),
			   HINT = system_messages_locale(function_name,11);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'6'),
			   MESSAGE = system_messages_locale(function_name,9),
			   DETAIL = format(system_messages_locale(function_name,12), new.subject, new.grading_meeting),
			   HINT = system_messages_locale(function_name,11);
		END IF;	   
	END IF;
--
-- controllo l'school della metric del grade_proposto sia lo stesso di quello dell'school_year dello grading_meeting
--
	PERFORM 1 FROM grades v
	          JOIN metrics m ON v.metric = m.metric
	          JOIN school_years a ON m.school = a.school
	          JOIN grading_meetings s ON a.school_year = s.school_year
	         WHERE v.grade =  new.grade_proposto
	           AND s.grading_meeting = new.grading_meeting;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'7'),
			   MESSAGE = system_messages_locale(function_name,13),
			   DETAIL = format(system_messages_locale(function_name,14), new.grading_meeting_valutation, new.grade_proposto, new.grading_meeting),
			   HINT = system_messages_locale(function_name,15);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'8'),
			   MESSAGE = system_messages_locale(function_name,13),
			   DETAIL = format(system_messages_locale(function_name,16), new.grade_proposto, new.grading_meeting),
			   HINT = system_messages_locale(function_name,15);
		END IF;	   
	END IF;
--
-- controllo l'school della metric del grade sia lo stesso di quello dell'school_year dello grading_meeting
--
	PERFORM 1 FROM grades v
	          JOIN metrics m ON v.metric = m.metric
	          JOIN school_years a ON m.school = a.school
	          JOIN grading_meetings s ON a.school_year = s.school_year
	         WHERE v.grade =  new.grade
	           AND s.grading_meeting = new.grading_meeting;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'9'),
			   MESSAGE = system_messages_locale(function_name,17),
			   DETAIL = format(system_messages_locale(function_name,18), new.grading_meeting_valutation, new.grade, new.grading_meeting),
			   HINT = system_messages_locale(function_name,19);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'A'),
			   MESSAGE = system_messages_locale(function_name,17),
			   DETAIL = format(system_messages_locale(function_name,20), new.grade, new.grading_meeting),
			   HINT = system_messages_locale(function_name,19);
		END IF;	   
	END IF;	
	--
-- controllo che lo grading_meeting sia aperto
--
	PERFORM 1 FROM grading_meetings 
		 WHERE grading_meeting = new.grading_meeting
		   AND close = false;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,21),
			   DETAIL = format(system_messages_locale(function_name,22), new.grading_meeting_valutation, new.grading_meeting),
			   HINT = system_messages_locale(function_name,23);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,21),
			   DETAIL = format(system_messages_locale(function_name,24), new.grading_meeting),
			   HINT = system_messages_locale(function_name,23);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_iu() OWNER TO postgres;

--
-- TOC entry 651 (class 1255 OID 17384)
-- Name: tr_grading_meetings_valutations_qua_d(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_qua_d() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_grading_meetings_valutations_qua_d';
BEGIN
--
-- controllo che lo grading_meeting sia aperto
--
	PERFORM 1 FROM grading_meetings_valutations sv
		  JOIN grading_meetings s ON s.grading_meeting = sv.grading_meeting
		 WHERE sv.grading_meeting_valutation = old.grading_meeting_valutation
		   AND s.close = false;
	IF NOT FOUND THEN
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = system_messages_locale(function_name,1),
		DETAIL = format(system_messages_locale(function_name,2), old.grading_meeting_valutation_qua, old.grading_meeting_valutation),
		HINT = system_messages_locale(function_name,3);
	END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_qua_d() OWNER TO postgres;

--
-- TOC entry 652 (class 1255 OID 17385)
-- Name: tr_grading_meetings_valutations_qua_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_qua_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_grading_meetings_valutations_qua_iu';
BEGIN
--
-- controllo che l'school della qualification sia lo stesso di quello dell'student della grading_meeting_valutation
--
	PERFORM 1 FROM grading_meetings_valutations v
	          JOIN persons p ON v.student = p.person
	          JOIN qualificationtions q ON p.school = q.school
	         WHERE v.grading_meeting_valutation = new.grading_meeting_valutation
	           AND q.qualification = new.qualification;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.grading_meeting_valutation_qua, new.qualification,  new.valutation),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.qualification,  new.valutation),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'school della qualification sia lo stesso di quello della metric della subject del grade
--
	IF new.grade IS NOT NULL THEN
		PERFORM 1 FROM grades v
			  JOIN metrics m ON v.metric = m.metric
			  JOIN qualificationtions q ON m.school = q.school
			 WHERE v.grade = new.grade
			   AND q.qualification = new.qualification;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'5'),
				   MESSAGE = system_messages_locale(function_name,9),
				   DETAIL = format(system_messages_locale(function_name,10), new.grading_meeting_valutation_qua, new.qualification,  new.grade),
				   HINT = system_messages_locale(function_name,11);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'6'),
				   MESSAGE = system_messages_locale(function_name,9),
				   DETAIL = format(system_messages_locale(function_name,12), new.qualification,  new.grade),
				   HINT = system_messages_locale(function_name,11);
			END IF;	   
		END IF;
	END IF;
--
-- controllo lo grading_meeting sia aperto
--
	PERFORM 1 FROM grading_meetings_valutations sv
		  JOIN grading_meetings s ON s.grading_meeting = sv.grading_meeting
		 WHERE sv.grading_meeting_valutation = new.grading_meeting_valutation
		   AND s.close = false;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'7'),
			   MESSAGE = system_messages_locale(function_name,13),
			   DETAIL = format(system_messages_locale(function_name,14), new.grading_meeting_valutation_qua, new.grading_meeting_valutation),
			   HINT = system_messages_locale(function_name,15);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'8'),
			   MESSAGE = system_messages_locale(function_name,13),
			   DETAIL = format(system_messages_locale(function_name,16), new.grading_meeting_valutation),
			   HINT = system_messages_locale(function_name,15);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_qua_iu() OWNER TO postgres;

--
-- TOC entry 653 (class 1255 OID 17386)
-- Name: tr_leavings_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_leavings_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_leavings_iu';
	v_school bigint;
BEGIN
--
-- leggo l'school della classroom
--
        SELECT a.school INTO v_school FROM classrooms c
	                                  JOIN school_years a ON a.school_year = c.school_year
	                                 WHERE c.classroom = new.classroom;
--
-- controllo che nel on_date dell'leaving ci sia almeno una lesson
--
	PERFORM 1 FROM lessons l
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.leaving,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.on_date, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la explanation, se indicata, sia relativa a quell'student, a quel on_date di leaving e creata dopo o to_time massimo il on_date stesso dell'leaving
--
	IF new.explanation IS NOT NULL THEN
		PERFORM 1 FROM explanations WHERE explanation=new.explanation AND student = new.student AND created_on >= new.on_date AND new.on_date BETWEEN from_time AND to_time ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,6), new.leaving, new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = system_messages_locale(function_name,5),
				   DETAIL = format(system_messages_locale(function_name,8), new.explanation, new.student, new.on_date),
				   HINT = system_messages_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school dell'student sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = system_messages_locale(function_name,9),
		   DETAIL = format(system_messages_locale(function_name,10), new.leaving, new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = system_messages_locale(function_name,9),
		   DETAIL = format(system_messages_locale(function_name,12), new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,11);
	   END IF;	   
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'7'),
		   MESSAGE = system_messages_locale(function_name,13),
		   DETAIL = format(system_messages_locale(function_name,14), new.leaving, new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'8'),
		   MESSAGE = system_messages_locale(function_name,13),
		   DETAIL = format(system_messages_locale(function_name,16), new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,15);
	   END IF;	   
	END IF;	
--
-- l'student che leaving_at non puÃ² essere assente
--
	PERFORM 1 FROM absences WHERE on_date = new.on_date AND student = new.student;

	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'9'),
			MESSAGE = system_messages_locale(function_name,17),
			DETAIL = format(system_messages_locale(function_name,18), new.leaving, new.student, new.on_date),
			HINT = system_messages_locale(function_name,19);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'A'),
			MESSAGE = system_messages_locale(function_name,17),
			DETAIL = format(system_messages_locale(function_name,20), new.student, new.on_date),
			HINT = system_messages_locale(function_name,19);
		END IF;	   
	END IF;	
--
-- controllo che il teacher sia nel rule 'Teacher'
--
	IF NOT in_rule('Teacher',new.teacher) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'B'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,34), new.leaving, new.teacher),
			   HINT = system_messages_locale(function_name,35);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'C'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,36), new.teacher),
			   HINT = system_messages_locale(function_name,35);
		END IF;	   
	END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_leavings_iu() OWNER TO postgres;

--
-- TOC entry 654 (class 1255 OID 17387)
-- Name: tr_lessons_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_lessons_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_lessons_iu';
	v_school bigint;
BEGIN
--
-- leggo l'school della classroom
--
        SELECT school INTO v_school FROM classrooms WHERE classroom = new.classroom;
--
-- controllo che l'school della subject sia uguale a quello della classroom
--
	PERFORM 1 FROM subjects WHERE subject = new.subject AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,2), new.lesson, new.subject, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,4), new.subject, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,3);
	   END IF;	   
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'3'),
		   MESSAGE = system_messages_locale(function_name,5),
		   DETAIL = format(system_messages_locale(function_name,6), new.lesson, new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,7);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'4'),
		   MESSAGE = system_messages_locale(function_name,5),
		   DETAIL = format(system_messages_locale(function_name,8), new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,7);
	   END IF;	   
	END IF;	
--
-- controllo che il teacher sia nel rule teachers
--
	IF NOT in_rule('Teacher',new.teacher) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'5'),
			   MESSAGE = system_messages_locale(function_name,9),
			   DETAIL = format(system_messages_locale(function_name,10), new.lesson, new.teacher),
			   HINT = system_messages_locale(function_name,11);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'6'),
			   MESSAGE = system_messages_locale(function_name,9),
			   DETAIL = format(system_messages_locale(function_name,12), new.teacher),
			   HINT = system_messages_locale(function_name,11);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_lessons_iu() OWNER TO postgres;

--
-- TOC entry 655 (class 1255 OID 17388)
-- Name: tr_messages_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_messages_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_messages_iu';
	v_school bigint;
BEGIN
--
-- leggo l'school della person che ha scritto il message
--
        SELECT school INTO v_school FROM persons WHERE person = new.da;
--
-- controllo che la person che ha scritto il message (from_time) sia dello stesso school dell'student a cui fa' zip_codeo il school_record della conversation
--
	PERFORM 1 FROM classrooms_students ca
		  JOIN conversations c ON  ca.classroom_student = c.school_record
		  JOIN persons p ON p.person = ca.student
	         WHERE c.conversation = new.conversation
	           AND p.school = v_school;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), v_school, new.from_time, new.message, new.conversation),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), v_school, new.from_time, new.conversation),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_messages_iu() OWNER TO postgres;

--
-- TOC entry 656 (class 1255 OID 17389)
-- Name: tr_messages_read_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_messages_read_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_messages_read_iu';
	v_school bigint;
BEGIN
--
-- leggo l'school della person che ha scritto il messages_reado
--
        SELECT school INTO v_school FROM persons WHERE person = new.da;
--
-- controllo che la person che ha scritto il messages_reado (from_time) sia dello stesso school dell'student a cui fa' zip_codeo il school_record della conversation
--
	PERFORM 1 FROM classrooms_students ca
		  JOIN conversations c ON  ca.classroom_student = c.school_record
		  JOIN persons p ON p.person = ca.student
	         WHERE c.conversation = new.conversation
	           AND p.school = v_school;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messages_read_sistema_locale(function_name,1),
			   DETAIL = format(messages_read_sistema_locale(function_name,2), v_school, new.from_time, new.messages_reado, new.conversation),
			   HINT = messages_read_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messages_read_sistema_locale(function_name,1),
			   DETAIL = format(messages_read_sistema_locale(function_name,4), v_school, new.from_time, new.conversation),
			   HINT = messages_read_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_messages_read_iu() OWNER TO postgres;

--
-- TOC entry 658 (class 1255 OID 17390)
-- Name: tr_notes_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_notes_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_notes_iu';
	v_school bigint;
	v_delete_signed boolean := FALSE;
	v_insert_signed boolean := FALSE;

BEGIN
--
-- recupero l'school della classroom
--
	SELECT a.school INTO v_school FROM classrooms c
	                                  JOIN school_years a ON a.school_year = c.school_year
	                                 WHERE c.classroom = new.classroom;
--
-- controllo che nel on_date dell'note ci sia almeno una lesson
--
	PERFORM 1 FROM lessons l
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.note,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.on_date, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- se l'student Ã¨ stato specificato
--
	IF new.student IS NOT NULL THEN
		--
		-- controllo che l'school dell'student sia uguale a quello della classroom
		--
		PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'3'),
				MESSAGE = system_messages_locale(function_name,9),
				DETAIL = format(system_messages_locale(function_name,10), new.note, new.student, v_school, new.classroom),
				HINT = system_messages_locale(function_name,11);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'4'),
				MESSAGE = system_messages_locale(function_name,9),
				DETAIL = format(system_messages_locale(function_name,12), new.student, v_school, new.classroom),
				HINT = system_messages_locale(function_name,11);
			END IF;	   
		END IF;
		--
		-- l'student in delay non puÃ² essere assente
		--
		PERFORM 1 FROM absences WHERE on_date = new.on_date AND student = new.student;

		IF FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'7'),
				MESSAGE = system_messages_locale(function_name,17),
				DETAIL = format(system_messages_locale(function_name,18), new.note, new.student, new.on_date),
				HINT = system_messages_locale(function_name,19);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'8'),
				MESSAGE = system_messages_locale(function_name,17),
				DETAIL = format(system_messages_locale(function_name,20), new.student, new.on_date),
				HINT = system_messages_locale(function_name,19);
			END IF;	
		END IF;	
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'5'),
			MESSAGE = system_messages_locale(function_name,13),
			DETAIL = format(system_messages_locale(function_name,14), new.note, new.teacher, v_school, new.classroom),
			HINT = system_messages_locale(function_name,15);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'6'),
			MESSAGE = system_messages_locale(function_name,13),
			DETAIL = format(system_messages_locale(function_name,16), new.teacher, v_school, new.classroom),
			HINT = system_messages_locale(function_name,15);
		END IF;	   
	END IF;	
--
-- gestione dei visti 
--
	IF TG_OP = 'INSERT' THEN
		IF new.to_approve = TRUE THEN
			v_insert_signed := TRUE;
		END IF;
	END IF;
	IF TG_OP = 'UPDATE' THEN
		--
		-- se sono richiesti i visti controllo che lo fossero anche prima
		--
		IF new.to_approve = TRUE THEN
			--
			-- se sono stati richiesti i visti controllo se Ã¨ cambiata la classroom, l'student o la description
			-- nel quto_time caso si devono cancellare i vecchi visti ed inserire i nuovi
			-- ponendo attenzione che l'student puÃ² essere null
			--
			IF old.to_approve = TRUE THEN
				IF new.description != old.description THEN
					v_delete_signed := TRUE;
					v_insert_signed := TRUE;
				END IF;
				IF new.classroom != old.classroom THEN
					v_delete_signed := TRUE;
					v_insert_signed := TRUE;
				END IF;
				IF new.student IS NULL THEN
					IF old.student IS NULL THEN
					ELSE
						v_delete_signed := TRUE;
					END IF;
				ELSE
					IF old.student IS NULL THEN
						v_insert_signed := TRUE;
					ELSE
						IF new.student != old.student THEN
							v_delete_signed := TRUE;
							v_insert_signed := TRUE;
						END IF;
					END IF;
				END IF ;
			END IF;
			--
			-- se non erano stati richiesti i visti allat_time devo inserirli
			--
			IF old.to_approve = FALSE THEN
				v_insert_signed := TRUE;
			END IF;
		END IF;
		--
		-- se non sono richiesti i visti controllo se lo erano stati
		--
		IF new.to_approve = FALSE THEN
			--
			-- se erano stati richiesti i visti allat_time devo cancellare queeli vecchi
			--
			IF old.to_approve = TRUE THEN
				v_delete_signed := TRUE;
			END IF;
		END IF;
	END IF;

	--
	-- cancello fisicament i vecchi visti se Ã¨ stato determiborn di cancellarli
	--
	IF v_delete_signed THEN 
		DELETE FROM notes_signed WHERE note = old.note;
	END IF;
	--
	-- inserirso i nuovi visti se Ã¨ stato determiborn di inserirli
	--
	IF v_insert_signed THEN
		IF new.student IS NULL THEN
			INSERT INTO notes_signed (note, person) SELECT new.note, person_related_to
			                                         FROM  persons_relations WHERE sign_request = TRUE 
			                                                                AND person IN (SELECT student
			                                                                                  FROM classrooms_students
			                                                                                 WHERE classroom = new.classroom 
			                                                                                   AND student NOT IN (SELECT student
			                                                                                                        FROM absences where on_date = new.on_date));
		ELSE
			INSERT INTO notes_signed (note, person) SELECT new.note, person_related_to
			                                         FROM  persons_relations WHERE sign_request = TRUE 
			                                                                  AND person = new.student;
		END IF;
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_notes_iu() OWNER TO postgres;

--
-- TOC entry 660 (class 1255 OID 17391)
-- Name: tr_notes_signed_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_notes_signed_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_notes_signed_iu';
	v_school bigint;
BEGIN
--
-- metto from_time una parte l'school della classroom
--
	SELECT c.school INTO v_school 
	  FROM notes n
	  JOIN classrooms c ON c.classroom = n.classroom
	 WHERE n.note = new.note;
----
-- controllo che l'school della person sia lo stesso di quello della classroom della note
--
	PERFORM 1 FROM persons
	         WHERE person = new.person
	           AND school = v_school;
	           
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.note_signed, new.person, v_school, new.note),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.person, v_school, new.note),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_notes_signed_iu() OWNER TO postgres;

--
-- TOC entry 657 (class 1255 OID 17392)
-- Name: tr_out_of_classrooms_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_out_of_classrooms_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_out_of_classrooms_iu';
	v_school	bigint;

BEGIN
--
-- controllo che nel on_date del out_of_classroom ci sia almeno una lesson
--
	PERFORM 1 FROM lessons l
	          JOIN classrooms_students ca ON ca.classroom=l.classroom
	         WHERE student = new.student
	           AND on_date = new.on_date;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.out_of_classroom,  new.student),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.on_date, new.student),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- recupero l'school della classroom
--
	SELECT a.school INTO v_school 
		FROM school_years a
		JOIN classrooms c ON a.school_year = c.school_year
		WHERE c.classroom = new.classroom;
--
-- controllo che l'school dell'student sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'3'),
		   MESSAGE = system_messages_locale(function_name,5),
		   DETAIL = format(system_messages_locale(function_name,6), new.out_of_classroom, new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,7);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'4'),
		   MESSAGE = system_messages_locale(function_name,5),
		   DETAIL = format(system_messages_locale(function_name,8), new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,7);
	   END IF;	   
	END IF;
--
-- controllo che l'school dell'addetto scolastico sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.school_operator AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = system_messages_locale(function_name,9),
		   DETAIL = format(system_messages_locale(function_name,10), new.out_of_classroom, new.school_operator, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = system_messages_locale(function_name,9),
		   DETAIL = format(system_messages_locale(function_name,12), new.school_operator, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,10);
	   END IF;	   
	END IF;
--
-- l'student che leaving_at non puÃ² essere assente
--
	PERFORM 1 FROM absences WHERE on_date = new.on_date AND student = new.student;

	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'7'),
			MESSAGE = system_messages_locale(function_name,13),
			DETAIL = format(system_messages_locale(function_name,14), new.out_of_classroom, new.student, new.on_date),
			HINT = system_messages_locale(function_name,15);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'8'),
			MESSAGE = system_messages_locale(function_name,13),
			DETAIL = format(system_messages_locale(function_name,14), new.student, new.on_date),
			HINT = system_messages_locale(function_name,15);
		END IF;	   
	END IF;	
--
-- controllo che l'school_operator abbia uno dei ruoli richiesti
--
	IF NOT in_uno_dei_ruoli('{"Supervisor","Executive","Teacher","Employee"}')THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'H'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,34), new.out_of_classroom, new.school_operator),
			   HINT = system_messages_locale(function_name,35);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'I'),
			   MESSAGE = system_messages_locale(function_name,33),
			   DETAIL = format(system_messages_locale(function_name,36), new.school_operator),
			   HINT = system_messages_locale(function_name,35);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_out_of_classrooms_iu() OWNER TO postgres;

--
-- TOC entry 661 (class 1255 OID 17393)
-- Name: tr_parents_meetings_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_parents_meetings_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_parents_meetings_iu';
BEGIN
--
-- controllo che il teacher e la person che ha fissato il parents_meetings siano dello stesso school
--
	IF new.person IS NOT NULL THEN
		PERFORM 1 FROM persons doc
			  JOIN persons person ON doc.school = con.school
			 WHERE doc.person = new.teacher
			   AND con.person = new.con;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'1'),
				   MESSAGE = system_messages_locale(function_name,1),
				   DETAIL = format(system_messages_locale(function_name,2), new.classroom, new.school_year, new_degree),
				   HINT = system_messages_locale(function_name,3);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'2'),
				   MESSAGE = system_messages_locale(function_name,1),
				   DETAIL = format(system_messages_locale(function_name,4), new.school_year, new_degree),
				   HINT = system_messages_locale(function_name,3);
			END IF;	   
		END IF;
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_parents_meetings_iu() OWNER TO postgres;

--
-- TOC entry 662 (class 1255 OID 17394)
-- Name: tr_schools_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_schools_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context text;
  function_name text;
BEGIN
  get diagnostics me.context = pg_context;
  me.function_name = diagnostic.function_name(me.context);
--
-- check behavior
--
	IF new.behavior IS NOT NULL THEN
		IF (TG_OP = 'UPDATE') THEN
			--
			-- check that subject's school as equal as school
			--
			PERFORM 1 FROM subjects WHERE subject = new.behavior AND school = new.school;
			IF NOT FOUND THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(me.function_name,'1'),
				MESSAGE = system_messages_locale(me.function_name,1),
				DETAIL = format(system_messages_locale(me.function_name,2), new.school, new.behavior),
				HINT = system_messages_locale(me.function_name,3);
			END IF;
		ELSE
			--
			-- cannot set the behavior because it needs school. You must:
			-- 1) insert school
			-- 2) insert subject 
			-- 3) update school with the subject
			--
			RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(me.function_name,'2'),
				MESSAGE = system_messages_locale(me.function_name,4),
				DETAIL = format(system_messages_locale(me.function_name,5)),
				HINT = system_messages_locale(me.function_name,6);
		END IF;
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_schools_iu() OWNER TO postgres;

--
-- TOC entry 663 (class 1255 OID 17395)
-- Name: tr_signatures_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_signatures_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_signatures_iu';
BEGIN
--
-- controllo che il teacher sia dello stesso istituo della classroom
--
	PERFORM 1 FROM classrooms c
	          JOIN school_years a ON c.school_year = a.school_year
	          JOIN persons doc ON a.school = doc.school
	         WHERE doc.person = new.teacher
	           AND c.classroom = new.classroom;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.signature, new.teacher, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.teacher, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la person indicata come teacher abbia il rule di teacher o dirigente
--
	IF NOT in_uno_dei_ruoli('{"Executive","Teacher"}',new.teacher) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,6), new.signature, new.teacher),
			   HINT = system_messages_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = system_messages_locale(function_name,6),
			   DETAIL = format(system_messages_locale(function_name,8), new.teacher),
			   HINT = system_messages_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_signatures_iu() OWNER TO postgres;

--
-- TOC entry 664 (class 1255 OID 17396)
-- Name: tr_teachears_notes_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_teachears_notes_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_teachears_notes_iu';
	v_school bigint;
BEGIN
--
-- metto from_time una parte l'school della classroom
--
	SELECT school INTO v_school FROM classrooms WHERE classroom = new.classroom;
----
-- controllo che nel on_date dell'teacher_notes ci sia almeno una lesson
--
	PERFORM 1 FROM lessons l
	         WHERE classroom = new.classroom
	           AND on_date = new.on_date;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.on_date, new.teacher_notes,  new.classroom),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.on_date, new.classroom),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'school dell'student sia uguale a quello della classroom
--
	IF new.student IS NOT NULL THEN
		PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'3'),
				MESSAGE = system_messages_locale(function_name,9),
				DETAIL = format(system_messages_locale(function_name,10), new.teacher_notes, new.student, v_school, new.classroom),
				HINT = system_messages_locale(function_name,11);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'4'),
				MESSAGE = system_messages_locale(function_name,9),
				DETAIL = format(system_messages_locale(function_name,12), new.student, v_school, new.classroom),
				HINT = system_messages_locale(function_name,11);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = system_messages_locale(function_name,13),
		   DETAIL = format(system_messages_locale(function_name,14), new.teacher_notes, new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = system_messages_locale(function_name,13),
		   DETAIL = format(system_messages_locale(function_name,16), new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,15);
	   END IF;	   
	END IF;	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_teachears_notes_iu() OWNER TO postgres;

--
-- TOC entry 665 (class 1255 OID 17397)
-- Name: tr_topics_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_topics_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_topics_iu';
	v_course_years course_year;
BEGIN
--
-- controllo che la subject e l'indirizzo scolastico siano dello stesso school
--
	SELECT i.course_years INTO v_course_years
	          FROM subjects m
	          JOIN degrees i ON i.school = m.school
	         WHERE m.subject = new.subject
	           AND i.degree = new.degree;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.topic, new.subject,  new.degree),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.subject,  new.degree),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
	IF new.course_year > v_course_years THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,6), new.topic, new.course_year, v_course_years, new.degree),
			   HINT = system_messages_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,8), new.course_year, v_course_years, new.degree),
			   HINT = system_messages_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_topics_iu() OWNER TO postgres;

--
-- TOC entry 666 (class 1255 OID 17398)
-- Name: tr_valutations_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutations_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_school	bigint;
	v_metric	bigint;
	function_name varchar = 'tr_valutations_iu';
BEGIN
--
-- recupero l'school della classroom
--
	SELECT a.school INTO v_school 
		FROM school_years a
		JOIN classrooms c ON a.school_year = c.school_year
		WHERE c.classroom = new.classroom;
--
-- controllo che l'school dell'student sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.student AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,2), new.valutation, new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = system_messages_locale(function_name,1),
		   DETAIL = format(system_messages_locale(function_name,34), new.student, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,3);
	   END IF;	   
	END IF;
--
-- controllo che l'school della subject sia uguale a quello della classroom
--
	PERFORM 1 FROM subjects WHERE subject = new.subject AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'3'),
		   MESSAGE = system_messages_locale(function_name,4),
		   DETAIL = format(system_messages_locale(function_name,5), new.valutation, new.subject, v_school,new.classroom),
		   HINT = system_messages_locale(function_name,6);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'4'),
		   MESSAGE = system_messages_locale(function_name,4),
		   DETAIL = format(system_messages_locale(function_name,35), new.valutation, new.subject, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,6);
	   END IF;	   
	END IF;
--
-- controllo che il type grade sia della stessa subject della valutation
--
	PERFORM 1 FROM grade_types WHERE grade_type = new.grade_type AND subject = new.subject;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = system_messages_locale(function_name,7),
		   DETAIL = format(system_messages_locale(function_name,8), new.valutation, new.grade_type, new.subject),
		   HINT = system_messages_locale(function_name,9);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = system_messages_locale(function_name,7),
		   DETAIL = format(system_messages_locale(function_name,36), new.grade_type, new.subject),
		   HINT = system_messages_locale(function_name,9);
	   END IF;	   
	END IF;
--
-- controllo che l'topic sia della stessa subject della valutation
--
        IF new.topic IS NOT NULL THEN
		PERFORM 1 FROM topics WHERE topic = new.topic AND subject = new.subject;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'7'),
			   MESSAGE = system_messages_locale(function_name,10),
			   DETAIL = format(system_messages_locale(function_name,11), new.valutation, new.topic, new.subject),
			   HINT = system_messages_locale(function_name,12);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'8'),
			   MESSAGE = system_messages_locale(function_name,10),
			   DETAIL = format(system_messages_locale(function_name,37), new.topic, new.subject),
			   HINT = system_messages_locale(function_name,12);
		   END IF;	   
		END IF;
	END IF;
--
-- controllo che course_year e degree dell'topic siano gli stessi della classroom
--
        IF new.topic IS NOT NULL THEN
		PERFORM 1 FROM classrooms c
			  JOIN topics a ON (c.degree = a.degree AND
					       c.course_year = a.course_year)
			  WHERE c.classroom = new.classroom 
			  AND a.topic = new.topic;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'9'),
			   MESSAGE = system_messages_locale(function_name,13),
			   DETAIL = format(system_messages_locale(function_name,14), new.valutation, new.topic, new.classroom),
			   HINT = system_messages_locale(function_name,15);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'A'),
			   MESSAGE = system_messages_locale(function_name,13),
			   DETAIL = format(system_messages_locale(function_name,38), new.topic, new.classroom),
			   HINT = system_messages_locale(function_name,15);
		   END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school della metric del grade sia lo stesso della classroom
--
	PERFORM 1 FROM metrics m
	          JOIN grades v ON (m.metric = v.metric)
	          WHERE v.grade = new.grade 
	          AND m.school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'B'),
		   MESSAGE = system_messages_locale(function_name,16),
		   DETAIL = format(system_messages_locale(function_name,17), new.valutation, new.grade, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,18);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'C'),
		   MESSAGE = system_messages_locale(function_name,16),
		   DETAIL = format(system_messages_locale(function_name,39), new.grade, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,18);
	   END IF;	   
	END IF;
--
-- controllo che l'student sia una person person il rule 'Student'
--
	IF NOT in_rule('Student',new.student) THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'D'),
		   MESSAGE = system_messages_locale(function_name,19),
		   DETAIL = format(system_messages_locale(function_name,20), new.valutation, new.student),
		   HINT = system_messages_locale(function_name,21);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'E'),
		   MESSAGE = system_messages_locale(function_name,19),
		   DETAIL = format(system_messages_locale(function_name,40), new.student),
		   HINT = system_messages_locale(function_name,21);
	   END IF;	   
	END IF;
--
-- controllo che la note faccia riferimento allo stesso student e allo stesso teacher
--
        IF new.note IS NOT NULL THEN
		PERFORM 1 FROM notes
			 WHERE note = new.note
			   AND student = new.student
			   AND teacher = new.teacher;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = system_messages_locale(function_name,22),
			   DETAIL = format(system_messages_locale(function_name,23), new.valutation, new.note, new.student, new.teacher),
			   HINT = system_messages_locale(function_name,24);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = system_messages_locale(function_name,22),
			   DETAIL = format(system_messages_locale(function_name,41), new.note, new.student, new.teacher),
			   HINT = system_messages_locale(function_name,24);
		   END IF;	   
		END IF;
	END IF;
--
-- controllo che l'school del teacher sia uguale a quello della classroom
--
	PERFORM 1 FROM persons WHERE person = new.teacher AND school = v_school;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'H'),
		   MESSAGE = system_messages_locale(function_name,25),
		   DETAIL = format(system_messages_locale(function_name,26), new.valutation, new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,27);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'I'),
		   MESSAGE = system_messages_locale(function_name,25),
		   DETAIL = format(system_messages_locale(function_name,42), new.teacher, v_school, new.classroom),
		   HINT = system_messages_locale(function_name,27);
	   END IF;	   
	END IF;
--
-- controllo che il teacher sia una person person il rule 'Teacher'
--
	IF NOT in_rule('Teacher',new.teacher) THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'L'),
		   MESSAGE = system_messages_locale(function_name,28),
		   DETAIL = format(system_messages_locale(function_name,29), new.valutation, new.teacher),
		   HINT = system_messages_locale(function_name,30);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'M'),
		   MESSAGE = system_messages_locale(function_name,28),
		   DETAIL = format(system_messages_locale(function_name,43), new.teacher),
		   HINT = system_messages_locale(function_name,30);
	   END IF;	   
	END IF;
--
-- controllo che la on_date della valutation sia compresa fra l'begin_on e la end_on dell'anno scolastico
--
	PERFORM 1 FROM school_years a
		  JOIN classrooms c ON a.school_year = c.school_year
		  WHERE c.classroom = new.classroom AND
		        new.on_date BETWEEN a.start_lessons_on AND a.end_lesson_on;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'N'),
		   MESSAGE = system_messages_locale(function_name,31),
		   DETAIL = format(system_messages_locale(function_name,32), new.valutation, new.on_date, new.classroom),
		   HINT = system_messages_locale(function_name,33);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'O'),
		   MESSAGE = system_messages_locale(function_name,31),
		   DETAIL = format(system_messages_locale(function_name,44), new.on_date, new.classroom),
		   HINT = system_messages_locale(function_name,33);
	   END IF;	   
	END IF;
--
-- controllo che per quella classroom, subject, teacher, on_date, grade_type, topic vi sia una sola metric
--
	SELECT metric INTO v_metric FROM grades WHERE grade = new.grade;
	
	PERFORM 1 FROM valutations va
		  JOIN grades vo ON va.grade = vo.grade
         	 WHERE va.classroom = new.classroom
		   AND va.subject = new.subject
		   AND va.teacher = new.teacher
		   AND va.student = new.student
		   AND va.on_date = new.on_date
		   AND va.grade_type = new.grade_type
		   AND va.topic = new.topic
		   AND vo.metric = v_metric
		   AND va.valutation <> new.valutation;

	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'P'),
			MESSAGE = function_sqlcode(function_name,'P') || ' ' || system_messages_locale(function_name,45),
			DETAIL = format(system_messages_locale(function_name,46), new.grade, new.valutation, v_metric, new.classroom, new.subject, new.teacher, new.student, new.on_date, new.grade_type, new.topic),
			HINT = system_messages_locale(function_name,47);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'Q'),
			MESSAGE = function_sqlcode(function_name,'Q') || ' ' || system_messages_locale(function_name,45),
			DETAIL = format(system_messages_locale(function_name,48), new.grade, v_metric, new.classroom, new.subject, new.teacher, new.student, new.on_date, new.grade_type, new.topic),
			HINT = system_messages_locale(function_name,47);
		END IF;	   
	END IF;	     
--
-- se la valutation Ã¨ private non puÃ² essere assegnata una note
--
	IF  new.private = true AND new.note IS NOT NULL THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'R'),
			MESSAGE = system_messages_locale(function_name,49),
			DETAIL = format(system_messages_locale(function_name,50), new.valutation, new.private, new.note),
			HINT = system_messages_locale(function_name,51);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'S'),
			MESSAGE = system_messages_locale(function_name,49),
			DETAIL = format(system_messages_locale(function_name,52), new.private, new.note),
			HINT = system_messages_locale(function_name,51);
		END IF;	   
	END IF;
	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutations_iu() OWNER TO postgres;

--
-- TOC entry 659 (class 1255 OID 17400)
-- Name: tr_valutations_qualificationtions_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutations_qualificationtions_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_valutations_qualificationtions_iu';
BEGIN
--
-- controllo che l'school della qualification sia lo stesso di quello dell'student della valutation
--
	PERFORM 1 FROM valutations v
	          JOIN persons p ON v.student = p.person
	          JOIN qualificationtions q ON p.school = q.school
	         WHERE v.valutation = new.valutation
	           AND q.qualification = new.qualification;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.valutation_qualificationtion, new.qualification,  new.valutation),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.qualification,  new.valutation),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'school della qualification sia lo stesso di quello della metric del grade 
--
	PERFORM 1 FROM grades v
	          JOIN metrics m ON v.metric = v.metric
	          JOIN qualificationtions q ON m.school = q.school
	         WHERE v.grade = new.grade
	           AND q.qualification = new.qualification;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,6), new.valutation_qualificationtion, new.qualification,  new.grade),
			   HINT = system_messages_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = system_messages_locale(function_name,5),
			   DETAIL = format(system_messages_locale(function_name,8), new.qualification,  new.grade),
			   HINT = system_messages_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutations_qualificationtions_iu() OWNER TO postgres;

--
-- TOC entry 667 (class 1255 OID 17401)
-- Name: tr_weekly_timetables_days_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_weekly_timetables_days_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_weekly_timetables_days_iu';
	v_school bigint;
BEGIN
--
-- metto from_time una parte l'school della classroom
--
	SELECT c.school INTO v_school 
	  FROM notes n
	  JOIN classrooms c ON c.classroom = n.classroom
	 WHERE n.note = new.note;
----
-- controllo che l'school della person sia lo stesso di quello della classroom della note
--
	PERFORM 1 FROM persons
	         WHERE person = new.person
	           AND school = v_school;
	           
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,2), new.at_timerio_weekli_on_date, new.person, v_school, new.note),
			   HINT = system_messages_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = system_messages_locale(function_name,1),
			   DETAIL = format(system_messages_locale(function_name,4), new.person, v_school, new.note),
			   HINT = system_messages_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_weekly_timetables_days_iu() OWNER TO postgres;

--
-- TOC entry 668 (class 1255 OID 17402)
-- Name: uno_nei_ruoli(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uno_nei_ruoli(p_ruoli character varying[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	
	PERFORM 1 FROM persons_roles pr
	          JOIN persons p ON p.person = pr.person 
	          JOIN db_users u ON u.db_user = p.db_user
	         WHERE u.usename = session_user
	           AND pr.rule = ANY(p_ruoli::rule[]);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.uno_nei_ruoli(p_ruoli character varying[]) OWNER TO postgres;

--
-- TOC entry 669 (class 1255 OID 17403)
-- Name: update_person_photo_and_thumbnail(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_person_photo_and_thumbnail() RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'update_person_photo_and_thumbnail';
  row_count int;
BEGIN
  SET http.timeout_msec = 200000;
  UPDATE persons set photo = textsend(content), thumbnail = textsend(content), note = (xpath('/response/file/urls/file/text()',info::xml))[1]
  FROM copyrights, http(('GET', (xpath('/response/file/urls/file/text()',info::xml))[1], ARRAY[('user-agent','postgresql')::http_header], NULL, NULL)::http_request)
  WHERE copyrights.person = persons.person;

  GET DIAGNOSTICS row_count = ROW_COUNT;
  return row_count;
END;
$$;


ALTER FUNCTION public.update_person_photo_and_thumbnail() OWNER TO postgres;

--
-- TOC entry 670 (class 1255 OID 17404)
-- Name: valutations_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_del(p_rv bigint, p_valutation bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messages di sistema utilizzati from_timela funzione 
 
DELETE FROM system_messages WHERE function_name = 'valutations_del';


INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_del',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''valutations'' con: ''revisione'' = ''%s'',  ''valutation'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_del',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_del',3,'it','Controllare il valore di: ''revisione'', ''valutation'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'valutations_del';

BEGIN
    DELETE FROM valutations t WHERE t.valutation = p_valutation AND xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_valutation),
	     DETAIL = format(system_messages_locale(function_name,2),current_query()),
	     HINT = system_messages_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.valutations_del(p_rv bigint, p_valutation bigint) OWNER TO postgres;

--
-- TOC entry 671 (class 1255 OID 17405)
-- Name: valutations_ex_by_classroom_teacher_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_ex_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT rv,
		       classroom,
		       teacher,
		       subject,
		       valutation,
		       student,
		       surname,
		       name,
		       on_date,
		       grade_type,
		       grade_type_description,
		       topic,
		       topic_description,
		       metric,
		       metric_description,
		       grade,
		       grade_description,
		       evaluation,
		       privato
		  FROM valutations_ex
		 WHERE classroom = p_classroom
		   AND teacher = p_teacher
		   AND subject = p_subject   
	      ORDER BY on_date, surname, name, student, grade_type, topic;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.valutations_ex_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) OWNER TO postgres;

--
-- TOC entry 672 (class 1255 OID 17406)
-- Name: valutations_ins(bigint, bigint, bigint, bigint, bigint, bigint, character varying, boolean, bigint, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_ins(OUT p_rv bigint, OUT p_valutation bigint, p_classroom bigint, p_student bigint, p_subject bigint, p_grade_type bigint, p_topic bigint, p_grade bigint, p_evaluation character varying, p_private boolean, p_teacher bigint, p_on_date date) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE

  function_name varchar := 'valutations_ins';

BEGIN 
	IF p_topic = 0 THEN 
		p_topic := nULL ;
	END IF;
	INSERT INTO valutations (classroom, student, subject, grade_type, topic, grade, evaluation, private, teacher, on_date)
	VALUES (p_classroom, p_student, p_subject, p_grade_type, p_topic, p_grade, p_evaluation, p_private, p_teacher, p_on_date);

	SELECT currval('pk_seq') INTO p_valutation;
	SELECT xmin::text::bigint INTO p_rv FROM public.valutations WHERE valutation = p_valutation;
END;
$$;


ALTER FUNCTION public.valutations_ins(OUT p_rv bigint, OUT p_valutation bigint, p_classroom bigint, p_student bigint, p_subject bigint, p_grade_type bigint, p_topic bigint, p_grade bigint, p_evaluation character varying, p_private boolean, p_teacher bigint, p_on_date date) OWNER TO postgres;

--
-- TOC entry 674 (class 1255 OID 17407)
-- Name: valutations_ins_note(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_ins_note(OUT p_rv bigint, OUT p_note bigint, p_valutation bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE

  function_name varchar := 'valutations_ins_note';
  v_subject_description varchar := null;
  v_grade_type_description varchar := null;
  v_topic_description varchar := null;
  v_grade_description varchar := null;
  v_teacher_surname_name varchar := null;
  v_student_name varchar := null;
  v_description varchar :=null;

BEGIN 
	SELECT alu.name , doc.surname + ' ' + doc.name , m.description, tv.description, a.description, vo.description
	INTO v_teacher_surname_name, v_subject_description, v_grade_type_description, v_topic_description, v_grade_description
	FROM valutations va
	JOIN persons alu ON va.student = alu.person
	JOIN persons doc ON va.teacher = doc.person
	JOIN subjects m ON va.subject = m.subject
	JOIN tipi_grades tv ON va.grade_type = tv.grade_type
	JOIN topics a ON va.topic = a.topic
	JOIN grades vo ON va.grade = vo.grade
	WHERE valutation = p_valutation;

	v_description := format('In on_date: %s ad: %s il teacher: %s (%s) ha dato sull''topic: %s nel type di valutation: %s il grade: %s e ha richiesto il vostro visto',
	                           to_char('2014-01-31'::date,'Dy DD Mon yyyy'), v_student_name, v_teacher_surname_name, v_subject_description, v_topic_description, v_grade_type_description, v_grade_description);

	INSERT INTO notes (student, description, teacher, disciplinary, on_date, at_time, to_approve, classroom)
	VALUES (p_student, v_description, 'false', p_on_date, now()::time, 'true', p_classroom);

	SELECT currval('pk_seq') INTO p_note;
	SELECT xmin::text::bigint INTO p_rv FROM notes WHERE note = p_note;

END;
$$;


ALTER FUNCTION public.valutations_ins_note(OUT p_rv bigint, OUT p_note bigint, p_valutation bigint) OWNER TO postgres;

--
-- TOC entry 675 (class 1255 OID 17408)
-- Name: valutations_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
-- messages di sistema utilizzati from_timela funzione
 
DELETE FROM system_messages WHERE function_name = 'valutations_sel';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_sel',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''valutations'' con:  ''valutation'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_sel',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_sel',3,'it','Controllare il valore di: ''valutation'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'valutations_sel';

BEGIN

	SELECT xmin::text::bigint, valutation, evaluation, private, note IS NOT NULL AS note
	INTO p_rv, p_valutation, p_evaluation, p_private, p_note 
	FROM valutations
	WHERE valutation = p_valutation;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_valutation),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) OWNER TO postgres;

--
-- TOC entry 676 (class 1255 OID 17409)
-- Name: valutations_upd(bigint, bigint, character varying, boolean, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_upd(p_rv bigint, p_valutation bigint, p_evaluation character varying, p_private boolean, p_note boolean) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'valutations_upd';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_upd',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''valutations'' con: ''revisione'' = ''%s'',  ''valutation'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_upd',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_upd',3,'it','Controllare il valore di: ''revisione'', ''valutation'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'valutations_upd';

BEGIN

	UPDATE valutations SET valutation = p_valutation, evaluation = p_evaluation, private = p_private
    	WHERE valutation = p_valutation;--AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,2),p_rv, p_valutation),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
    END IF;
    IF p_note THEN
	--controllo se la note manca ed eventualmente quindi la inserisco 
	PERFORM 1 FROM valutations WHERE valutation = p_valutation AND note IS NOT NULL;
	IF NOT FOUND THEN
	-- inserire la note 
	/*
		INSERT INTO notes (classroom,student,teacher,disciplinary,on_date,at_time,to_approve,description)
			    SELECT classroom,student,teacher,'true',on_date,now()::time,'true',
			         'Si citiesca che il on_date: %s l''student ha ricevuto una valutation di: %s '
			         'from_time parte di: %s teacher di: %s durante la prova: %s person topic: %s '
			         ' riportando il seguente evaluation: %s. Si richiede la visione' 
			    FROM valutation 
			    WHERE valutation = p_valutation;
			    */
	END IF;	
    ELSE
	DELETE FROM notes WHERE note IN (SELECT note FROM valutations WHERE valutation = p_valutation);
    END IF;

    RETURN xmin::text::bigint  FROM valutations WHERE valutation = p_valutation;
END;
$$;


ALTER FUNCTION public.valutations_upd(p_rv bigint, p_valutation bigint, p_evaluation character varying, p_private boolean, p_note boolean) OWNER TO postgres;

--
-- TOC entry 678 (class 1255 OID 17411)
-- Name: valutations_upd_grade(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$

/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'valutations_upd_grade';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_upd_grade',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''valutations'' con: ''revisione'' = ''%s'',  ''valutation'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_upd_grade',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('valutations_upd_grade',3,'it','Controllare il valore di: ''revisione'', ''valutation'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'valutations_upd_grade';

BEGIN

	UPDATE valutations
	   SET grade = p_grade
    	 WHERE valutation = p_valutation
    	   AND xmin = p_rv::text::xid;

	IF NOT FOUND THEN RAISE USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = format(system_messages_locale(function_name,1),p_rv, p_valutation),
		DETAIL = format(system_messages_locale(function_name,2),current_query()),
		HINT = system_messages_locale(function_name,3);
	END IF;
    RETURN xmin::text::bigint  FROM valutations WHERE valutation = p_valutation;
END;
$$;


ALTER FUNCTION public.valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17412)
-- Name: pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 204
-- Name: SEQUENCE pk_seq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE pk_seq IS 'Sequence shared by all primary key in public schema';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 205 (class 1259 OID 17414)
-- Name: branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE branches (
    branch bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL
);


ALTER TABLE branches OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 206 (class 1259 OID 17418)
-- Name: classrooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE classrooms (
    classroom bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_year bigint NOT NULL,
    degree bigint NOT NULL,
    section character varying(5),
    course_year course_year NOT NULL,
    description character varying(160) NOT NULL,
    building bigint NOT NULL
);


ALTER TABLE classrooms OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 17422)
-- Name: school_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE school_years (
    school_year bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL,
    duration daterange,
    lessons_duration daterange,
    CONSTRAINT school_years_ck_duration CHECK ((duration @> lessons_duration))
);


ALTER TABLE school_years OWNER TO postgres;

--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE school_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE school_years IS 'Rappresenta l''anno scolastico ed Ã¨ suddiviso per school';


--
-- TOC entry 208 (class 1259 OID 17430)
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schools (
    school bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description character varying(160) NOT NULL,
    processing_code character varying(160) NOT NULL,
    mnemonic character varying(30) NOT NULL,
    example boolean DEFAULT false NOT NULL,
    logo bytea,
    behavior bigint,
    CONSTRAINT schools_min_description CHECK ((length((description)::text) > 1)),
    CONSTRAINT schools_min_mnemonic CHECK ((length((mnemonic)::text) > 1)),
    CONSTRAINT schools_min_processing_code CHECK ((length((processing_code)::text) > 1))
);


ALTER TABLE schools OWNER TO postgres;

--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE schools; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE schools IS 'An institution for the instruction of children or people under college age';


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN schools.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.school IS 'Uniquely identifies the table row';


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN schools.processing_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.processing_code IS 'A code that identify the school on the government information system';


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN schools.mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.mnemonic IS 'Short description to be use as code';


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN schools.example; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.example IS 'It indicates that the data have been inserted to be an example of the use of the data base';


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN schools.logo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.logo IS 'Picture to be used as a logo';


--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN schools.behavior; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.behavior IS 'Indicates the subject used for the behavior';


--
-- TOC entry 209 (class 1259 OID 17441)
-- Name: classrooms_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_ex WITH (security_barrier='false') AS
 SELECT i.school,
    i.description AS school_description,
    i.logo,
    a.school_year,
    a.description AS school_year_description,
    p.description AS building_description,
    c.classroom,
    c.description AS classrom_description
   FROM (((schools i
     JOIN school_years a ON ((i.school = a.school)))
     JOIN classrooms c ON ((a.school_year = c.school_year)))
     JOIN branches p ON ((c.building = p.branch)));


ALTER TABLE classrooms_ex OWNER TO postgres;

--
-- TOC entry 679 (class 1255 OID 17446)
-- Name: w_classrooms_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classrooms_ex() RETURNS SETOF classrooms_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM classrooms_ex;
 END;
$$;


ALTER FUNCTION public.w_classrooms_ex() OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 17447)
-- Name: absences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE absences (
    absence bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    on_date date NOT NULL,
    teacher bigint NOT NULL,
    explanation bigint,
    classroom_student bigint
);


ALTER TABLE absences OWNER TO postgres;

--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 210
-- Name: TABLE absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE absences IS 'Rileva le absences di un student';


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN absences.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences.teacher IS 'Il teacher che ha certificato l''absence';


--
-- TOC entry 211 (class 1259 OID 17451)
-- Name: classrooms_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE classrooms_students (
    classroom_student bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    student bigint NOT NULL,
    retreat_on date,
    classroom_destination bigint
);


ALTER TABLE classrooms_students OWNER TO postgres;

--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN classrooms_students.retreat_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.retreat_on IS 'Data in cui l''student si Ã¨ ritirato from_timela classroom oppure Ã¨ stato trasferito in un''altra classroom dello stesso school o di un altro school';


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN classrooms_students.classroom_destination; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.classroom_destination IS 'Viene tenuto traccia della classroom cui l''student Ã¨ stato trasferito se nello stesso school';


--
-- TOC entry 212 (class 1259 OID 17455)
-- Name: absences_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS absences
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE absences_grp OWNER TO postgres;

--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 212
-- Name: VIEW absences_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_grp IS 'Raggruppa le absences per classroom (e quindi per anno scolastico) e student';


--
-- TOC entry 213 (class 1259 OID 17459)
-- Name: absences_not_explanated_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_not_explanated_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS absences
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  WHERE (a.explanation IS NULL)
  GROUP BY cs.classroom, cs.student;


ALTER TABLE absences_not_explanated_grp OWNER TO postgres;

--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 213
-- Name: VIEW absences_not_explanated_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_not_explanated_grp IS 'Raggruppa le absences per classroom (e quindi per anno scolastico) e student limitando perÃ² la selesson a quelle non giustificate';


--
-- TOC entry 214 (class 1259 OID 17463)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cities (
    city character(4) NOT NULL,
    description character varying(160) NOT NULL,
    district character(2) NOT NULL
);


ALTER TABLE cities OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 17466)
-- Name: delays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE delays (
    delay bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    teacher bigint NOT NULL,
    explanation bigint,
    on_date date NOT NULL,
    at_time time without time zone NOT NULL,
    classroom_student bigint
);


ALTER TABLE delays OWNER TO postgres;

--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE delays IS 'Rileva i delays di un student';


--
-- TOC entry 216 (class 1259 OID 17470)
-- Name: delays_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS delays
   FROM (delays d
     JOIN classrooms_students cs ON ((d.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE delays_grp OWNER TO postgres;

--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 216
-- Name: VIEW delays_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_grp IS 'Raggruppa i delays per classroom (e quindi per anno acolastico) e student';


--
-- TOC entry 217 (class 1259 OID 17474)
-- Name: delays_not_explained_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_not_explained_grp AS
 SELECT cs.classroom,
    cs.student,
    count(cs.student) AS delays
   FROM (delays d
     JOIN classrooms_students cs ON ((cs.classroom_student = d.classroom_student)))
  WHERE (d.explanation IS NULL)
  GROUP BY cs.classroom, cs.student;


ALTER TABLE delays_not_explained_grp OWNER TO postgres;

--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 217
-- Name: VIEW delays_not_explained_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_not_explained_grp IS 'Raggruppa i delays per classroom (e quindi per anno acolastico) e student limitando perÃ² la selesson a quelli non giustificati';


--
-- TOC entry 218 (class 1259 OID 17478)
-- Name: leavings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE leavings (
    leaving bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint NOT NULL,
    teacher bigint NOT NULL,
    explanation bigint NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone NOT NULL,
    classroom_student bigint
);


ALTER TABLE leavings OWNER TO postgres;

--
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE leavings IS 'Rileva i leavings di un student';


--
-- TOC entry 219 (class 1259 OID 17482)
-- Name: leavings_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_grp AS
 SELECT cs.classroom,
    cs.student,
    count(cs.student) AS leavings
   FROM (leavings l
     JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE leavings_grp OWNER TO postgres;

--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 219
-- Name: VIEW leavings_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_grp IS 'Raggruppa le leavings per classroom (e quindi per anno acolastico) e student';


--
-- TOC entry 220 (class 1259 OID 17486)
-- Name: leavings_not_explained_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_not_explained_grp AS
 SELECT cs.classroom,
    cs.student,
    count(cs.student) AS leavings
   FROM (leavings l
     JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
  WHERE (l.explanation IS NULL)
  GROUP BY cs.classroom, cs.student;


ALTER TABLE leavings_not_explained_grp OWNER TO postgres;

--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 220
-- Name: VIEW leavings_not_explained_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_not_explained_grp IS 'Raggruppa le leavings per classroom (e quindi per anno acolastico) e student limitando perÃ² la selesson a quelle non giutificate';


--
-- TOC entry 221 (class 1259 OID 17490)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notes (
    note bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint,
    description character varying(2048) NOT NULL,
    teacher bigint NOT NULL,
    disciplinary boolean NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone NOT NULL,
    to_approve boolean DEFAULT false NOT NULL,
    classroom bigint NOT NULL,
    CONSTRAINT notes_ck_to_approve CHECK ((((disciplinary = false) AND (to_approve = false)) OR ((disciplinary = false) AND (to_approve = true)) OR ((disciplinary = true) AND (to_approve = true))))
);


ALTER TABLE notes OWNER TO postgres;

--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN notes.disciplinary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.disciplinary IS 'Indica che l''annotezione Ã¨ di type disciplinary verrÃ  quindi riportata sul school_record personle per la signature di visione del genitore.
L''annotezione Ã¨ rivolta a tutta la classroom a meno che non sia indicato il singolo student.
Se si vuole fare una note disciplinary (ma anche normale) a due o piÃ¹ students Ã¨ necesario inserire la note per ciascuno.';


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN notes.to_approve; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.to_approve IS 'indica che Ã¨ richiesto il visto from_time parte dell''student (se maggiorenne) o from_time parte di chi esercita la patria potestÃ  e ha richiesto di essere avvisato.
Se non Ã¨ specificato l''student il visto deve essere richiesto per tutta la classroom, se perÃ² Ã¨ una note disciplinary e manca l''student il visto deve essere richiesto per i soli students presenti';


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN notes.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.classroom IS 'indica se la note Ã¨ per tutta la classroom';


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 221
-- Name: CONSTRAINT notes_ck_to_approve ON notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT notes_ck_to_approve ON notes IS 'Se Ã¨ una note disciplinary allat_time deve essere richiesto il visto';


--
-- TOC entry 222 (class 1259 OID 17499)
-- Name: notes_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_grp AS
 SELECT notes.classroom,
    notes.student,
    count(1) AS notes
   FROM notes
  WHERE (notes.disciplinary = true)
  GROUP BY notes.classroom, notes.student;


ALTER TABLE notes_grp OWNER TO postgres;

--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 222
-- Name: VIEW notes_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW notes_grp IS 'Raggruppa le notes per classroom (e quindi per anno acolastico) e student';


--
-- TOC entry 223 (class 1259 OID 17503)
-- Name: out_of_classrooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE out_of_classrooms (
    out_of_classroom bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_operator bigint NOT NULL,
    description character varying(160) NOT NULL,
    on_date date NOT NULL,
    from_time time without time zone NOT NULL,
    to_time time without time zone NOT NULL,
    classroom_student bigint,
    CONSTRAINT out_of_classrooms_ck_to_time CHECK ((to_time > from_time))
);


ALTER TABLE out_of_classrooms OWNER TO postgres;

--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE out_of_classrooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE out_of_classrooms IS 'Indica quando un student non Ã¨ presente in classroom ma non deve essere considerato assente ad example per impegni sportivi';


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN out_of_classrooms.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.from_time IS 'at_time di leaving';


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN out_of_classrooms.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.to_time IS 'at_time di rientro';


--
-- TOC entry 224 (class 1259 OID 17508)
-- Name: out_of_classrooms_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS out_of_classrooms
   FROM (out_of_classrooms ooc
     JOIN classrooms_students cs ON ((cs.classroom_student = ooc.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE out_of_classrooms_grp OWNER TO postgres;

--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 224
-- Name: VIEW out_of_classrooms_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW out_of_classrooms_grp IS 'Raggruppa le fuori classroom per classroom (e quindi per anno acolastico) e student';


--
-- TOC entry 225 (class 1259 OID 17512)
-- Name: persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons (
    person bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    name character varying(60) NOT NULL,
    surname character varying(60) NOT NULL,
    born date,
    deceased date,
    country_of_birth smallint,
    tax_code character(16),
    sex sex NOT NULL,
    school bigint,
    sidi bigint,
    city_of_birth character(4),
    thumbnail image,
    note text,
    usename name,
    photo image
);


ALTER TABLE persons OWNER TO postgres;

--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN persons.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.note IS 'contains addtional informatio about person';


--
-- TOC entry 226 (class 1259 OID 17519)
-- Name: classrooms_students_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_students_ex AS
 SELECT ca.classroom,
    ca.student,
    p.thumbnail,
    p.tax_code,
    p.name,
    p.surname,
    p.sex,
    p.born,
    co.description AS city_of_birth_description,
    COALESCE(agrp.absences, (0)::bigint) AS absences,
    COALESCE(anggrp.absences, (0)::bigint) AS absences_not_explained,
    COALESCE(rgrp.delays, (0)::bigint) AS delays,
    COALESCE(rnggrp.delays, (0)::bigint) AS delays_not_explained,
    COALESCE(ugrp.leavings, (0)::bigint) AS leavings,
    COALESCE(unggrp.leavings, (0)::bigint) AS leavings_not_explained,
    COALESCE(fcgrp.out_of_classrooms, (0)::bigint) AS out_of_classrooms,
    COALESCE(ngrp.notes, (0)::bigint) AS notes
   FROM ((((((((((classrooms_students ca
     JOIN persons p ON ((p.person = ca.student)))
     LEFT JOIN cities co ON ((co.city = p.city_of_birth)))
     LEFT JOIN absences_grp agrp ON ((agrp.student = ca.student)))
     LEFT JOIN absences_not_explanated_grp anggrp ON ((anggrp.student = ca.student)))
     LEFT JOIN delays_grp rgrp ON ((rgrp.student = ca.student)))
     LEFT JOIN delays_not_explained_grp rnggrp ON ((rnggrp.student = ca.student)))
     LEFT JOIN leavings_grp ugrp ON ((ugrp.student = ca.student)))
     LEFT JOIN leavings_not_explained_grp unggrp ON ((unggrp.student = ca.student)))
     LEFT JOIN out_of_classrooms_grp fcgrp ON ((fcgrp.student = ca.student)))
     LEFT JOIN notes_grp ngrp ON ((ngrp.student = ca.student)))
  WHERE (p.school = ANY (schools_enabled()));


ALTER TABLE classrooms_students_ex OWNER TO postgres;

--
-- TOC entry 680 (class 1255 OID 17524)
-- Name: w_classrooms_students_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classrooms_students_ex() RETURNS SETOF classrooms_students_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM classrooms_students_ex;
 END;
$$;


ALTER FUNCTION public.w_classrooms_students_ex() OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17525)
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE subjects (
    subject bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL
);


ALTER TABLE subjects OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17529)
-- Name: valutations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE valutations (
    valutation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    student bigint NOT NULL,
    subject bigint NOT NULL,
    grade_type bigint NOT NULL,
    topic bigint,
    grade bigint NOT NULL,
    evaluation character varying(160),
    private boolean DEFAULT false NOT NULL,
    teacher bigint NOT NULL,
    on_date date NOT NULL,
    note bigint
);


ALTER TABLE valutations OWNER TO postgres;

--
-- TOC entry 4121 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE valutations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutations IS 'Contiene le valutations di tutti gli students fatti from_time tutti gli insegnati ';


--
-- TOC entry 4122 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN valutations.private; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.private IS 'Indica che il grade Ã¨ visibile to_time solo teacher che lo ha inserito';


--
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN valutations.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.teacher IS 'La colonna teacher Ã¨ stata inserita poichÃ¨ il teacher durante l`anno potrebbe cambiare in questo modo viene tenuto traccia di chi ha inserito il dato';


--
-- TOC entry 229 (class 1259 OID 17534)
-- Name: classrooms_teachers_subjects_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers_subjects_ex AS
 SELECT i.school,
    i.description AS school_description,
    i.logo,
    a.school_year,
    a.description AS school_year_description,
    p.description AS building_description,
    c.classroom,
    c.degree,
    c.course_year,
    c.description AS classrom_description,
    doc.person AS teacher,
    doc.name,
    doc.surname,
    doc.tax_code,
    m.subject,
    m.description AS subject_description
   FROM ((((((schools i
     JOIN school_years a ON ((i.school = a.school)))
     JOIN classrooms c ON ((a.school_year = c.school_year)))
     JOIN ( SELECT DISTINCT valutations.classroom,
            valutations.teacher,
            valutations.subject
           FROM valutations) cdm ON ((cdm.classroom = c.classroom)))
     JOIN branches p ON ((c.building = p.branch)))
     JOIN persons doc ON ((doc.person = cdm.teacher)))
     JOIN subjects m ON ((m.subject = cdm.subject)));


ALTER TABLE classrooms_teachers_subjects_ex OWNER TO postgres;

--
-- TOC entry 556 (class 1255 OID 17539)
-- Name: w_classrooms_teachers_subjects_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classrooms_teachers_subjects_ex() RETURNS SETOF classrooms_teachers_subjects_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * 
                 FROM classrooms_teachers_subjects_ex
                WHERE school = ANY (schools_abilitati());
 END;
$$;


ALTER FUNCTION public.w_classrooms_teachers_subjects_ex() OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17540)
-- Name: weekly_timetable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE weekly_timetable (
    weekly_timetable bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    description character varying(160)
);


ALTER TABLE weekly_timetable OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17544)
-- Name: weekly_timetable_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW weekly_timetable_ex AS
 SELECT c.classroom,
    os.weekly_timetable,
    os.description AS weekly_timetable_description
   FROM ((weekly_timetable os
     JOIN classrooms c ON ((os.classroom = c.classroom)))
     JOIN school_years a ON ((c.school_year = a.school_year)))
  WHERE (a.school = ANY (schools_enabled()));


ALTER TABLE weekly_timetable_ex OWNER TO postgres;

--
-- TOC entry 673 (class 1255 OID 17548)
-- Name: w_weekly_timetable_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_weekly_timetable_ex() RETURNS SETOF weekly_timetable_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM weekly_timetable_ex;
 END;
$$;


ALTER FUNCTION public.w_weekly_timetable_ex() OWNER TO postgres;

SET search_path = utility, pg_catalog;

--
-- TOC entry 557 (class 1255 OID 17549)
-- Name: day_name(week_day); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION day_name(_weekday week_day) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  function_name varchar = 'dayname';
BEGIN 
  RETURN to_char('2000-01-02'::date + _weekday, 'TMDay');
END;
$$;


ALTER FUNCTION utility.day_name(_weekday week_day) OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 232 (class 1259 OID 17550)
-- Name: weekly_timetables_days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE weekly_timetables_days (
    weekly_timetable_day bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    weekly_timetable bigint NOT NULL,
    weekday utility.week_day NOT NULL,
    teacher bigint,
    subject bigint,
    team_teaching smallint DEFAULT 1 NOT NULL,
    from_time time(0) without time zone NOT NULL,
    to_time time(0) without time zone NOT NULL,
    CONSTRAINT weekly_timetables_days_ck_teacher_subject CHECK (((teacher IS NOT NULL) OR (subject IS NOT NULL)))
);


ALTER TABLE weekly_timetables_days OWNER TO postgres;

--
-- TOC entry 4129 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN weekly_timetables_days.team_teaching; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.team_teaching IS 'Indica il numero di team_teaching (1 il primo insegnante, 2 il secondo insgnante e cosÃ¬ street) se c''Ã¨ un insegnante solo mettere 1 ';


--
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 232
-- Name: CONSTRAINT weekly_timetables_days_ck_teacher_subject ON weekly_timetables_days; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT weekly_timetables_days_ck_teacher_subject ON weekly_timetables_days IS 'Almeno uno dei campi tra teacher e subject deve essere compilato.';


--
-- TOC entry 233 (class 1259 OID 17556)
-- Name: weekly_timetables_days_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW weekly_timetables_days_ex AS
 SELECT c.classroom,
    os.weekly_timetable,
    os.description AS weekly_timetable_description,
    osg.weekly_timetable_day,
    osg.weekday,
    utility.day_name(osg.weekday) AS name_weekday,
    ((to_char((('now'::text)::date + osg.from_time), 'HH24:MI'::text) || ' - '::text) || to_char((('now'::text)::date + osg.to_time), ((('HH24:MI'::text || ' ('::text) || (osg.team_teaching)::text) || ')'::text))) AS period,
    (((p.name)::text || ' '::text) || (p.surname)::text) AS teacher_name_surname,
    p.thumbnail AS teacher_thumbnail,
    m.description AS subject_description
   FROM (((((school_years a
     JOIN classrooms c ON ((c.school_year = a.school_year)))
     JOIN weekly_timetable os ON ((os.classroom = c.classroom)))
     JOIN weekly_timetables_days osg ON ((osg.weekly_timetable = os.weekly_timetable)))
     JOIN persons p ON ((p.person = osg.teacher)))
     LEFT JOIN subjects m ON ((m.subject = osg.subject)))
  WHERE (a.school = ANY (schools_enabled()));


ALTER TABLE weekly_timetables_days_ex OWNER TO postgres;

--
-- TOC entry 677 (class 1255 OID 17561)
-- Name: w_weekly_timetables_days_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_weekly_timetables_days_ex() RETURNS SETOF weekly_timetables_days_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM weekly_timetables_days_ex;
 END;
$$;


ALTER FUNCTION public.w_weekly_timetables_days_ex() OWNER TO postgres;

--
-- TOC entry 681 (class 1255 OID 17562)
-- Name: weekly_timetable_xt_subject(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION weekly_timetable_xt_subject(p_weekly_timetable bigint) RETURNS TABLE(period text, "lunedÃ¬" text, "martedÃ¬" text, "mercoledÃ¬" text, "giovedÃ¬" text, "venerdÃ¬" text, sabato text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $_$
BEGIN 
  RETURN QUERY SELECT *
                 FROM crosstab('SELECT period, weekday, subject::text 
                                  FROM weekly_timetables_days_ex 
                                 WHERE weekly_timetable='  || p_weekly_timetable || ' ORDER BY 1',
                                 $$VALUES (1),(2),(3),(4),(5),(6)$$
                               )
                   AS ct (period text, lunedÃ¬ text, martedÃ¬ text, mercoledÃ¬ text, giovedÃ¬ text, venerdÃ¬ text, sabato text);                   
 END;
$_$;


ALTER FUNCTION public.weekly_timetable_xt_subject(p_weekly_timetable bigint) OWNER TO postgres;

--
-- TOC entry 682 (class 1255 OID 17563)
-- Name: weekly_timetable_xt_teacher(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION weekly_timetable_xt_teacher(p_weekly_timetable bigint) RETURNS TABLE(period text, "lunedÃ¬" text, "martedÃ¬" text, "mercoledÃ¬" text, "giovedÃ¬" text, "venerdÃ¬" text, sabato text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $_$
BEGIN 
  RETURN QUERY SELECT *
                 FROM crosstab('SELECT period, weekday, teacher_name_surname 
                                  FROM weekly_timetables_days_ex 
                                 WHERE weekly_timetable='  || p_weekly_timetable || ' ORDER BY 1',
                                 $$VALUES (1),(2),(3),(4),(5),(6)$$
                               )
                   AS ct (period text, lunedÃ¬ text, martedÃ¬ text, mercoledÃ¬ text, giovedÃ¬ text, venerdÃ¬ text, sabato text);                   
 END;
$_$;


ALTER FUNCTION public.weekly_timetable_xt_teacher(p_weekly_timetable bigint) OWNER TO postgres;

--
-- TOC entry 683 (class 1255 OID 17564)
-- Name: where_sequence(text, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION where_sequence(name text, search_value bigint) RETURNS TABLE(table_catalog information_schema.sql_identifier, table_schema information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, num_time_found bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
   Cerca in tutte le columns del on_datebase che hanno per default 
   la sequenza indicata nel parametro name il valore indicato nel
   parametro value
*/
declare
      results record;
      default_column character varying;
begin 
      default_column = 'nextval(''' || name || '''::regclass)';
      for  results in select
			columns.table_catalog, 
			columns.table_schema,
			columns.table_name, 
			columns.column_name
		      from
			information_schema.columns, 
			information_schema.tables
		      where
			columns.table_catalog = tables.table_catalog AND
			columns.table_schema = tables.table_schema AND
			columns.table_name = tables.table_name AND
			tables.table_catalog = 'scuola247' AND 
			tables.table_schema = 'public' AND 
			tables.table_type = 'BASE TABLE' AND 
			columns.column_default =  default_column
      loop
	table_catalog := results.table_catalog;
	table_schema := results.table_schema;
	table_name := results.table_name;
	column_name := results.column_name;
	execute 'SELECT COUNT(''x'') FROM ' || table_name || ' WHERE ' || column_name || ' = ' || search_value into strict num_time_found;
        return next;
      end loop;
 end;
$$;


ALTER FUNCTION public.where_sequence(name text, search_value bigint) OWNER TO postgres;

--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 683
-- Name: FUNCTION where_sequence(name text, search_value bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(name text, search_value bigint) IS 'Restituisce l''elenco delle tabelle che hanno la colonna collegata alla sequenza indicata e contengono il valore indicato.';


--
-- TOC entry 714 (class 1255 OID 17565)
-- Name: wikimedia_0_reset(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_0_reset() RETURNS TABLE(_message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  row_count_wikimedia_files int = 0;
  row_count_persons         int = 0;
  my_command                text;
  error		            diagnostic.error;
  my_data_path              text = '/var/lib/scuola247/';
BEGIN 

-- table wikimedia_files

  BEGIN
    UPDATE wikimedia_files SET info = NULL, thumbnail = NULL, photo = NULL;
    GET DIAGNOSTICS row_count_wikimedia_files = ROW_COUNT;
    RAISE NOTICE 'table wikimedia_files: set null to info, photo e thumbnail...: % rows updated', row_count_wikimedia_files::text;
    _message =   'table wikimedia_files: set null to info, photo e thumbnail...: ' || row_count_wikimedia_files::text || ' rows updated'; RETURN NEXT; 
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'table wikimedia_files: set null to info, photo e thumbnail...: *** KO ***';
    _message  =  'table wikimedia_files: set null to info, photo e thumbnail...: *** KO ***'; RETURN NEXT; 
    PERFORM diagnostic.show(error);
  END;

-- table persons

  BEGIN
    UPDATE persons SET thumbnail = NULL, photo = NULL;
    GET DIAGNOSTICS row_count_persons = ROW_COUNT;
    RAISE NOTICE 'table persons: set null to photo e thumbnail.................: % rows updated', row_count_persons::text;
    _message =   'table persons: set null to photo e thumbnail.................: ' || row_count_persons::text || ' rows updated'; RETURN NEXT; 
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'table persons: set null to photo e thumbnail.................: *** KO ***';
    _message =   'table persons: set null to photo e thumbnail.................: *** KO ***'; RETURN NEXT; 
    PERFORM diagnostic.show(error);
  END;  

-- files wikimedia_files/infos
  
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/wikimedia_files/infos/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files wikimedia_files: remove info...........................: !!! OK !!!';
    _message =   'files wikimedia_files: remove info...........................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files wikimedia_files: remove info...........................: *** KO ***';
    _message =   'files wikimedia_files: remove info...........................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
  
-- files wikimedia_files/thumbnail
  
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/wikimedia_files/thumbnails/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files wikimedia_files: remove thumbnail......................: !!! OK !!!';
    _message =   'files wikimedia_files: remove thumbnail......................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files wikimedia_files: remove thumbnail......................: *** KO ***';
    _message =   'files wikimedia_files: remove thumbnail......................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;

-- files wikimedia_files/photos
    
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/wikimedia_files/photos/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files wikimedia_files: remove photo..........................: !!! OK !!!';
    _message =   'files wikimedia_files: remove photo..........................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files wikimedia_files: remove photo..........................: *** KO ***';
    _message =   'files wikimedia_files: remove photo..........................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
  
-- files persons/thumbnails

  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/persons/thumbnails/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files persons: remove thumbnails.............................: !!! OK !!!';
    _message =   'files persons: remove thumbnails.............................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files persons: remove thumbnails.............................: *** KO ***';
    _message =   'files persons: remove thumbnails.............................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;

-- files persons/photos
  
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/persons/photos/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files persons: remove photos.................................: !!! OK !!!';
    _message =   'files persons: remove photo..................................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files persons: remove photo..................................: *** KO ***';
    _message =   'files persons: remove photo..................................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
         
END
$$;


ALTER FUNCTION public.wikimedia_0_reset() OWNER TO postgres;

--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 714
-- Name: FUNCTION wikimedia_0_reset(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_0_reset() IS 'This procedure delete all data downloaded from wikimedia';


--
-- TOC entry 711 (class 1255 OID 107872)
-- Name: wikimedia_1_hydration(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_1_hydration(_count integer DEFAULT 1) RETURNS TABLE(_message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  ctr_info_ok                int = 0;
  ctr_info_ko                int = 0;
  ctr_photo_ok               int = 0;
  ctr_photo_ko               int = 0;
  ctr_thumbnail_ok           int = 0;
  ctr_thumbnail_ko           int = 0;
  
  my_record                  record;
  url_wikimedia_api_prefix   text := 'https://tools.wmflabs.org/magnus-toolserver/commonsapi.php?image=';
  error                      diagnostic.error;
  my_thumbnail_info          xml;
  my_url                     text;
  
BEGIN 

  SET http.keepalive = 'on';
  SET http.timeout_msec = 30000;

-- hydration column info

  FOR my_record IN SELECT wikimedia_file, name
                     FROM wikimedia_files 
                    WHERE info IS NULL 
                 ORDER BY wikimedia_file
                    LIMIT _count
  LOOP
    BEGIN
      UPDATE wikimedia_files SET info = (http(('GET', url_wikimedia_api_prefix || my_record.name , ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content::xml
        WHERE wikimedia_file = my_record.wikimedia_file;
      ctr_info_ok := ctr_info_ok + 1;
      _message := 'wikimedia_files: set info..................: '|| my_record.name || ' !!! OK !!!'; RETURN NEXT;  
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_info_ko := ctr_info_ko + 1;
      RAISE NOTICE 'wikimedia_files: set info..................: % *** KO ***', my_record.name;
      PERFORM diagnostic.show(error);
      _message := 'wikimedia_files: set info..................: '|| my_record.name || ' *** KO ***'; RETURN NEXT;       
    END;
  END LOOP;

-- hydration column thumbnail

  FOR my_record IN SELECT wikimedia_file, info, name
                     FROM wikimedia_files 
                    WHERE thumbnail IS NULL 
                 ORDER BY wikimedia_file
                    LIMIT _count
  LOOP
    BEGIN
      my_thumbnail_info := (http(('GET', url_wikimedia_api_prefix || my_record.name::text || '&thumbwidth=100', ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content::xml;
      my_url := (xpath('/response/file/urls/thumbnail/text()',my_thumbnail_info))[1];
      UPDATE wikimedia_files SET thumbnail = textsend((http(('GET', my_url , ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content)
        WHERE wikimedia_file = my_record.wikimedia_file;
      ctr_thumbnail_ok := ctr_thumbnail_ok + 1;
      _message := 'wikimedia_files: set thumbnail.............: '|| my_record.name || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_thumbnail_ko := ctr_thumbnail_ko + 1;
      RAISE NOTICE 'wikimedia_files: set thumbnail.............: % *** KO ***', my_record.name;
      PERFORM diagnostic.show(error);
      _message := 'wikimedia_files: set thumbnail.............: '|| my_record.name || ' *** KO ***'; RETURN NEXT;      
    END;
  END LOOP;

-- hydration column photo

  FOR my_record IN SELECT wikimedia_file, info, name
                     FROM wikimedia_files 
                    WHERE photo IS NULL 
                 ORDER BY wikimedia_file                    
                    LIMIT _count
  LOOP
    BEGIN
      my_thumbnail_info := (http(('GET', url_wikimedia_api_prefix || my_record.name::text || '&thumbwidth=400', ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content::xml;
      my_url := (xpath('/response/file/urls/thumbnail/text()',my_thumbnail_info))[1];
      UPDATE wikimedia_files SET photo = textsend((http(('GET', my_url , ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content)
        WHERE wikimedia_file = my_record.wikimedia_file;
      ctr_photo_ok := ctr_photo_ok + 1;
      _message := 'wikimedia_files: set photo.................: '|| my_record.name || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_photo_ko := ctr_photo_ko + 1;
      RAISE NOTICE 'wikimedia_files: set photo.................: % *** KO ***', my_record.name;
      PERFORM diagnostic.show(error);
      _message := 'wikimedia_files: set photo.................: '|| my_record.name || ' *** KO ***'; RETURN NEXT;      
    END;
  END LOOP;


  RAISE NOTICE 'wikimedia_files: set info ***OK*** ........: % ', ctr_info_ok;
  RAISE NOTICE 'wikimedia_files: set info !!!KO!!! ........: % ', ctr_info_ko;
  RAISE NOTICE 'wikimedia_files: set thumbnail ***KO*** ...: % ', ctr_thumbnail_ok;
  RAISE NOTICE 'wikimedia_files: set thumbnail !!!OK!!! ...: % ', ctr_thumbnail_ko;
  RAISE NOTICE 'wikimedia_files: set photo ***KO*** .......: % ', ctr_photo_ok;
  RAISE NOTICE 'wikimedia_files: set photo !!!OK!!! .......: % ', ctr_photo_ko;

  _message := 'wikimedia_files: set info ***OK*** ........: ' || ctr_info_ok::text; RETURN NEXT; 
  _message := 'wikimedia_files: set info !!!KO!!! ........: ' || ctr_info_ko::text; RETURN NEXT;
  _message := 'wikimedia_files: set thumbnail ***KO*** ...: ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  _message := 'wikimedia_files: set thumbnail !!!OK!!! ...: ' || ctr_thumbnail_ko::text; RETURN NEXT; 
  _message := 'wikimedia_files: set photo ***KO*** .......: ' || ctr_photo_ok::text; RETURN NEXT; 
  _message := 'wikimedia_files: set photo !!!OK!!! .......: ' || ctr_photo_ko::text; RETURN NEXT; 
      
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE 'Normally errors are due to timeouts or slow connections.';
  RAISE NOTICE 'Please retry the operation until you clear the error.';
  RAISE NOTICE 'It is recommended to investigate the errors only if them are not decreasing.';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';

  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := 'Normally errors are due to timeouts or slow connections.'; RETURN NEXT; 
  _message := 'Please retry the operation until you clear the error.'; RETURN NEXT; 
  _message := 'It is recommended to investigate the errors only if them are not decreasing.'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 

END
$$;


ALTER FUNCTION public.wikimedia_1_hydration(_count integer) OWNER TO postgres;

--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 711
-- Name: FUNCTION wikimedia_1_hydration(_count integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_1_hydration(_count integer) IS 'This procedure updates the columns "info", "photo" and "thumbnail" of wikimedia_files table taking the data from the Wikimedia Commons site (http://commons.wikimedia.org) all downloaded data have a compatible license of GPLv3 (you can check the license in the column "info").
This procedure is made because to have a light script to create and populate the scuola247 database the heavy data like picture and info file are hydrate from this procedure.
Since the command is costly in terms of execution time, the _count parameter default set to 1, allows you to limit the run to experiment, verified the smooth running and setting the count parameter to a high value (typically 10,000 ) you run the rest of the work';


--
-- TOC entry 712 (class 1255 OID 17568)
-- Name: wikimedia_2_popolate_files(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_2_popolate_files() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  my_record		record;
  my_command		text;
  error			diagnostic.error;
  my_data_path		text = '/var/lib/scuola247/wikimedia_files/';

  ctr_info_ok		int = 0;
  ctr_info_ko		int = 0;
  ctr_photo_ok		int = 0;
  ctr_photo_ko		int = 0;
  ctr_thumbnail_ok	int = 0;
  ctr_thumbnail_ko	int = 0;
  
BEGIN 

 -- info

  FOR my_record IN SELECT wikimedia_file, info
                     FROM wikimedia_files 
                    WHERE info IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode(info::text::bytea, ''hex'') FROM wikimedia_files WHERE wikimedia_file = ' || my_record.wikimedia_file::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'infos/' || my_record.wikimedia_file::text || '.xml''';
      EXECUTE my_command;
      ctr_info_ok := ctr_info_ok + 1;
      message := 'wikimedia_files: write info file.....................: '|| my_record.wikimedia_file::text || ' !!! OK !!!'; RETURN NEXT;         
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_info_ko := ctr_info_ko + 1;
      RAISE NOTICE 'wikimedia_files: write info file.....................: % *** KO ***', my_record.wikimedia_file::text;
      message := 'wikimedia_files: write info file.....................: '|| my_record.wikimedia_file::text || ' *** KO ***'; RETURN NEXT;
      PERFORM diagnostic.show(error); 
    END;
  END LOOP;

-- thumbnail

  FOR my_record IN SELECT wikimedia_file, name, thumbnail
                     FROM wikimedia_files 
                    WHERE thumbnail IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode(thumbnail, ''hex'') FROM wikimedia_files WHERE wikimedia_file = ' || my_record.wikimedia_file::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'thumbnails/' || my_record.wikimedia_file::text ||  right(my_record.name,4) || '''';
      EXECUTE my_command;
      ctr_thumbnail_ok := ctr_thumbnail_ok + 1;
      message := 'wikimedia_files: write thumbnail file................: '|| my_record.wikimedia_file::text || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_thumbnail_ko := ctr_thumbnail_ko + 1;
      RAISE NOTICE 'wikimedia_files: write thumbnail file................: % *** KO ***', my_record.wikimedia_file::text;
      message := 'wikimedia_files: write thumbnail file................: '|| my_record.wikimedia_file::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM diagnostic.show(error);
    END;
  END LOOP;
  
-- photo

  FOR my_record IN SELECT wikimedia_file, name, photo
                     FROM wikimedia_files 
                    WHERE photo IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode(photo, ''hex'') FROM wikimedia_files WHERE wikimedia_file = ' || my_record.wikimedia_file::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'photos/' || my_record.wikimedia_file::text || right(my_record.name,4) || '''';
      EXECUTE my_command;
      ctr_photo_ok := ctr_photo_ok + 1;
      message := 'wikimedia_files: write photo file....................: '|| my_record.wikimedia_file::text || ' !!! OK !!!';  RETURN NEXT; 
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_photo_ko := ctr_photo_ko + 1;
      RAISE NOTICE 'wikimedia_files: write photo file....................: % *** KO ***', my_record.wikimedia_file::text;
      message := 'wikimedia_files: write photo file....................: '|| my_record.wikimedia_file::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM diagnostic.show(error);
     END;
  END LOOP;

  RAISE NOTICE 'wikimedia_files: write info file .........!!! OK !!! : % ', ctr_info_ok;
  RAISE NOTICE 'wikimedia_files: write info file .........*** KO *** : % ', ctr_info_ko;
  RAISE NOTICE 'wikimedia_files: write thumbnail file ... !!! OK !!! : % ', ctr_thumbnail_ok;
  RAISE NOTICE 'wikimedia_files: write thumbnail file ....*** KO *** : % ', ctr_thumbnail_ko;
  RAISE NOTICE 'wikimedia_files: write photo file ........!!! OK !!! : % ', ctr_photo_ok;
  RAISE NOTICE 'wikimedia_files: write photo file ........*** KO *** : % ', ctr_photo_ko;

  message := 'wikimedia_files: write info file .........!!! OK !!! : ' || ctr_info_ok::text; RETURN NEXT; 
  message := 'wikimedia_files: write info file .........*** KO *** : ' || ctr_info_ko::text; RETURN NEXT;
  message := 'wikimedia_files: write thumbnail file ... !!! OK !!! : ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  message := 'wikimedia_files: write thumbnail file ....*** KO *** : ' || ctr_thumbnail_ko::text; RETURN NEXT; 
  message := 'wikimedia_files: write photo file ........!!! OK !!! : ' || ctr_photo_ok::text; RETURN NEXT; 
  message := 'wikimedia_files: write photo file ........*** KO *** : ' || ctr_photo_ko::text; RETURN NEXT; 
      
END
$$;


ALTER FUNCTION public.wikimedia_2_popolate_files() OWNER TO postgres;

--
-- TOC entry 4140 (class 0 OID 0)
-- Dependencies: 712
-- Name: FUNCTION wikimedia_2_popolate_files(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_2_popolate_files() IS 'This procedure create the info, photo and thumbnail file for the corresponding columns of table wikimedia_files as the template: 
"/var/lib/scuola247/wikimedia_files/infos/<wikimedia_file>.<name.extension>"
"/var/lib/scuola247/wikimedia_files/photos/<wikimedia_file>.<name.extension>"
"/var/lib/scuola247/wikimedia_files/thumbnails/<wikimedia_file>.<name.extension>"';


--
-- TOC entry 713 (class 1255 OID 17569)
-- Name: wikimedia_3_hydration_persons(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_3_hydration_persons() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  my_record record;
  url_wikimedia_api_prefix text := 'https://tools.wmflabs.org/magnus-toolserver/commonsapi.php?image=';

  ctr_photo_ok int = 0;
  ctr_thumbnail_ok int = 0;
  
BEGIN 

  UPDATE persons p SET thumbnail.content = wf.thumbnail, thumbnail.mime_type = lower(right(wf.name,4))::file_extension
    FROM wikimedia_files wf, wikimedia_files_persons wfp
   WHERE wfp.wikimedia_file = wf.wikimedia_file
     AND wfp.person = p.person
     AND p.thumbnail IS NULL 
     AND wf.thumbnail IS NOT NULL;

  GET DIAGNOSTICS ctr_thumbnail_ok = ROW_COUNT;
  
  UPDATE persons p SET photo.content = wf.photo, photo.mime_type = lower(right(wf.name,4))::file_extension
    FROM wikimedia_files wf, wikimedia_files_persons wfp
   WHERE wfp.wikimedia_file = wf.wikimedia_file
     AND wfp.person = p.person
     AND p.photo IS NULL 
     AND wf.photo IS NOT NULL;

  GET DIAGNOSTICS ctr_photo_ok = ROW_COUNT;

  RAISE NOTICE 'persons: update thumbnail....: % ', ctr_thumbnail_ok;
  RAISE NOTICE 'persons: update photo........: % ', ctr_photo_ok;
  
  message := 'persons: update thumbnail....: ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  message := 'persons: update photo........: ' || ctr_photo_ok::text; RETURN NEXT;
  
END
$$;


ALTER FUNCTION public.wikimedia_3_hydration_persons() OWNER TO postgres;

--
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 713
-- Name: FUNCTION wikimedia_3_hydration_persons(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_3_hydration_persons() IS 'This procedure updates the table columns "photo" and "thumbnail" of the table "persons" taking the data from the wikimedia_files table.
The operation is performed only if the photo column of person table is null and the photo column of wikimedia_files table is not null.';


--
-- TOC entry 561 (class 1255 OID 17570)
-- Name: wikimedia_4_popolate_files_persons(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_4_popolate_files_persons() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  my_record record;
  my_command text;
  error diagnostic.error;
  my_data_path text = '/var/lib/scuola247/persons/';

  ctr_photo_ok int = 0;
  ctr_photo_ko int = 0;
  ctr_thumbnail_ok int = 0;
  ctr_thumbnail_ko int = 0;
     
BEGIN 

  -- thumbnail
  
   FOR my_record IN SELECT person, thumbnail
                     FROM persons
                    WHERE thumbnail IS NOT NULL
  LOOP
    BEGIN   
      my_command := 'COPY (SELECT encode((thumbnail).content, ''hex'') FROM persons WHERE person = ' || my_record.person::text || ') ' || 
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'thumbnails/' || my_record.person::text || (my_record.thumbnail).mime_type::file_extension::text  || '''';

      EXECUTE my_command;
      ctr_thumbnail_ok := ctr_thumbnail_ok + 1;
      message := 'persons: write thumbnail file.................: '|| my_record.person::text || ' !!! OK !!!'; RETURN NEXT;         
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_thumbnail_ko := ctr_thumbnail_ko + 1;
      RAISE NOTICE 'persons: write thumbnail file.................: % *** KO ***', my_record.person::text;
      message := 'persons: write thumbnail file.................: '|| my_record.person::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM assert.show(diags);
    END;
  END LOOP;
  
-- photo

   FOR my_record IN SELECT person, photo
                     FROM persons
                    WHERE photo IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode((photo).content, ''hex'') FROM persons WHERE person = ' || my_record.person::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'photos/' || my_record.person::text || (my_record.photo).mime_type::file_extension::text  || '''';
      EXECUTE my_command;
      ctr_photo_ok := ctr_photo_ok + 1;
      message := 'persons: write photo file.....................: '|| my_record.person::text || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_photo_ko := ctr_photo_ko + 1;
      RAISE NOTICE 'persons: write photo file.....................: % *** KO ***', my_record.person::text;
      message := 'persons: write photo file.....................: '|| my_record.person::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM assert.show(diags);
    END;
    
  END LOOP;
  
  RAISE NOTICE 'persons: write thumbnail file ... !!! OK !!!! : % ', ctr_thumbnail_ok;
  RAISE NOTICE 'persons: write thumbnail file ... *** KO **** : % ', ctr_thumbnail_ko;
  RAISE NOTICE 'persons: write photo file ....... !!! OK !!!! : % ', ctr_photo_ok;
  RAISE NOTICE 'persons: write photo file ....... *** KO **** : % ', ctr_photo_ko;

  message := 'persons: write thumbnail file ... !!! OK !!!! : % ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  message := 'persons: write thumbnail file ... *** KO **** : % ' || ctr_thumbnail_ko::text; RETURN NEXT; 
  message := 'persons: write photo file ....... !!! OK !!!! : % ' || ctr_photo_ok::text; RETURN NEXT; 
  message := 'persons: write photo file ....... *** KO **** : % ' || ctr_photo_ko::text; RETURN NEXT; 
      
END
$$;


ALTER FUNCTION public.wikimedia_4_popolate_files_persons() OWNER TO postgres;

--
-- TOC entry 4142 (class 0 OID 0)
-- Dependencies: 561
-- Name: FUNCTION wikimedia_4_popolate_files_persons(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_4_popolate_files_persons() IS 'This procedure create the photo and thumbnail file for the corresponding columns of table persons as the templater: 
"<postgresql installation path>/scuola247/persons/photos/<person>.jpg"
"<postgresql installation path>/scuola247/persons/thumbnails/<person>.jpg"';


--
-- TOC entry 558 (class 1255 OID 17571)
-- Name: wikimedia_old_1_wikimedia_from_disk(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_old_1_wikimedia_from_disk() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  row_count integer;
BEGIN 

-- azzero il file di wikimedia per i ritratti
                        
  DELETE FROM wikimedia WHERE type = 'Male portrait';
  
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Ritratti maschili di wikimedia cancellati..: ' || row_count::text;
  RETURN NEXT;   
  
  DELETE FROM wikimedia WHERE type = 'Female portrait';

  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Ritratti femminili di wikimedia cancellati.: ' || row_count::text;
  RETURN NEXT; 

-- inserisco i ritratti che ho su file

  INSERT INTO wikimedia (name, type)
  SELECT pg_ls_dir, 'Male portrait'  FROM pg_ls_dir('scuola247/images/men')
  WHERE pg_ls_dir NOT IN ('info', 'thumbnails');
  
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Ritratti maschili di wikimedia inseriti....: ' || row_count::text;
  RETURN NEXT;

  INSERT INTO wikimedia (name, type)
  SELECT pg_ls_dir, 'Female portrait' FROM pg_ls_dir('scuola247/images/women')
  WHERE pg_ls_dir NOT IN ('info', 'thumbnails');
    
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Ritratti femminili di wikimedia inseriti...: ' || row_count::text;
  RETURN NEXT;

  RETURN;
  END
$$;


ALTER FUNCTION public.wikimedia_old_1_wikimedia_from_disk() OWNER TO postgres;

--
-- TOC entry 4143 (class 0 OID 0)
-- Dependencies: 558
-- Name: FUNCTION wikimedia_old_1_wikimedia_from_disk(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_old_1_wikimedia_from_disk() IS '1Â° STEP nel processo di popolamento delle immagini da wikimedia.
Dopo aver selezionato manualmente i file di wikimedia popolo la tabella wikimedia a partire dai suddetti file: creo in pratica il catalogo dei file di wikimedia selezionati memorizzando il nome del file e il suo tipo: ritratto femminile o maschile
';


--
-- TOC entry 559 (class 1255 OID 17572)
-- Name: wikimedia_old_3_persons_file(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_old_3_persons_file() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  row_count integer;
BEGIN 

  WITH p AS (SELECT person, ((row_number() OVER() -1 )% (select count (*) from wikimedia where type = 'Male portrait')) + 1 AS row_number FROM persons WHERE sex = 'M'),
       c AS (SELECT file, row_number() OVER() AS row_number from wikimedia  WHERE type = 'Male portrait')
  UPDATE persons per SET file = c.file
  FROM p
  JOIN c on p.row_number = c.row_number
  WHERE per.person = p.person;

  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Filename persone maschile aggiornato.......: ' || row_count::text;
  RETURN NEXT; 

  WITH p AS (SELECT person, ((row_number() OVER() -1 )% (select count (*) from wikimedia where type = 'Female portrait')) + 1 AS row_number FROM persons WHERE sex = 'F'),
       c AS (SELECT file, row_number() OVER() AS row_number from wikimedia  WHERE type = 'Female portrait')
  UPDATE persons per SET file = c.file
  FROM p
  JOIN c on p.row_number = c.row_number
  WHERE per.person = p.person;
 
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Filename persone femminili aggiornate......: ' || row_count::text;
  RETURN NEXT; 

  RETURN;
  END
$$;


ALTER FUNCTION public.wikimedia_old_3_persons_file() OWNER TO postgres;

--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 559
-- Name: FUNCTION wikimedia_old_3_persons_file(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_old_3_persons_file() IS '3Â° STEP nel processo di popolamento delle immagini da wikimedia 
Aggiorno la tabella persons assegnando in maniera casuale le immagini che ho nella tabella wikimedia, prima per i maschi e poi per le femmine, nel caso le persone siano di piÃ¹ delle immagini queste verranno riutilizzate ciclicamente in maniera da avere tutte le persone con un''immagine anche se Ã¨ ovviamente possibile che la stessa immagine sia assegnata a piÃ¹ persone';


--
-- TOC entry 560 (class 1255 OID 17573)
-- Name: wikimedia_old_4_alt_persons_photo_thumbnail_from_disk(boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_old_4_alt_persons_photo_thumbnail_from_disk(p_only_null boolean DEFAULT true) RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  row_count integer;
BEGIN 
 
  UPDATE persons p SET photo = pg_read_binary_file('scuola247/images/men/' || w.name) 
  FROM wikimedia w 
  WHERE w.file = p.file 
    AND p.sex = 'M'
    AND ((photo IS NULL AND p_only_null) OR (NOT p_only_null));
  
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Photo persone maschili aggiornate..........: ' || row_count::text;
  RETURN NEXT; 

  UPDATE persons p SET thumbnail = pg_read_binary_file('scuola247/images/men/thumbnails/' || w.name) 
  FROM wikimedia w 
  WHERE w.file = p.file 
    AND p.sex = 'M'
    AND ((thumbnail IS NULL AND p_only_null) OR (NOT p_only_null));
  
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Miniature persone maschili aggiornate......: ' || row_count::text;
  RETURN NEXT; 

  UPDATE persons p SET photo = pg_read_binary_file('scuola247/images/women/' || w.name) 
  FROM wikimedia w 
  WHERE w.file = p.file 
    AND p.sex = 'F'
    AND ((photo IS NULL AND p_only_null) OR (NOT p_only_null));

  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Photo persone femminili aggiornate.........: ' || row_count::text;
  RETURN NEXT; 

  UPDATE persons p SET thumbnail = pg_read_binary_file('scuola247/images/women/thumbnails/' || w.name) 
  FROM wikimedia w 
  WHERE w.file = p.file 
    AND p.sex = 'F'
    AND ((thumbnail IS NULL AND p_only_null) OR (NOT p_only_null));
  
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Miniature persone femminili aggiornate.....: ' || row_count::text;
  RETURN NEXT; 

  RETURN;
  END
$$;


ALTER FUNCTION public.wikimedia_old_4_alt_persons_photo_thumbnail_from_disk(p_only_null boolean) OWNER TO postgres;

--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 560
-- Name: FUNCTION wikimedia_old_4_alt_persons_photo_thumbnail_from_disk(p_only_null boolean); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION wikimedia_old_4_alt_persons_photo_thumbnail_from_disk(p_only_null boolean) IS '4Â° STEP (alternativa) nel processo di popolamento delle immagini da wikimedia.
E'' per quelle persone che hanno scaricato su disco le immagini con altri mezzi.
Lo script aggiorna il campo photo e thumbnails con le immagine prese dalla directory scuola247 che deve essere presente nella directory di installazione di postgres e avere la seguente struttura:
/images/men/<name> (colonna photo per le persone con: sex=''M'')
/images/men/thumbnails/<name> (colonna photo per le persone con: sex=''M'')
/images/men/<name>  (colonna thumbnail per le persone con: sex=''M'')
/images/women/<name> (colonna photo per le persone con: sex=''M'')
/images/men/<name> (colonna thumbnail per le persone con: sex=''F'')
/images/women/thumbnails/<name>  (colonna thumbnail per le persone con: sex=''F'')
Il nome del file viene preso dalla colonna omonima della tabella wikimedia puntata dalla colonna file';


--
-- TOC entry 704 (class 1255 OID 17574)
-- Name: work_spaces_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION work_spaces_del(p_rv bigint, p_work_space bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE

  function_name varchar := 'work_spaces_del';
  v_db_user bigint := null;

BEGIN 

  SELECT db_user INTO v_db_user FROM db_users WHERE usename = session_user;

  DELETE FROM work_spaces 
   WHERE work_space = p_work_space 
     AND xmin = p_rv::text::xid
     AND db_user = v_db_user;
     
  IF NOT FOUND THEN 
     RAISE EXCEPTION USING
     ERRCODE = function_sqlcode(function_name,'1'),
     MESSAGE = format(system_messages_locale(function_name,1),p_work_space, p_rv),
     DETAIL = format(system_messages_locale(function_name,2),current_query()),
     HINT = system_messages_locale(function_name,3);
  END IF;

END;

$$;


ALTER FUNCTION public.work_spaces_del(p_rv bigint, p_work_space bigint) OWNER TO postgres;

--
-- TOC entry 705 (class 1255 OID 17575)
-- Name: work_spaces_ins(character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION work_spaces_ins(OUT p_rv bigint, OUT p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'work_spaces_ins';
  v_db_user bigint;
BEGIN 
  SELECT db_user INTO v_db_user FROM db_users WHERE usename = session_user;
  INSERT INTO work_spaces(db_user, description, school, school_year, classroom, subject, teacher, family, student) 
         VALUES (v_db_user, p_description, p_school, p_school_year, p_classroom, p_subject, p_teacher, p_family, p_student);
  SELECT currval('pk_seq') INTO p_work_space;
  SELECT xmin::text::bigint INTO p_rv FROM work_spaces WHERE work_space = p_work_space;

END;
$$;


ALTER FUNCTION public.work_spaces_ins(OUT p_rv bigint, OUT p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) OWNER TO postgres;

--
-- TOC entry 706 (class 1255 OID 17576)
-- Name: work_spaces_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION work_spaces_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR  SELECT sl.xmin::text::bigint AS rv,
		        sl.work_space,
		        sl.school,
		        sl.school_year,
		        sl.classroom,
		        sl.subject,
		        sl.teacher,
		        sl.family,
		        sl.student,
		        sl.description,
		        CASE WHEN sl.work_space = u.work_space THEN true ELSE false END AS default
		FROM work_spaces sl 
		JOIN db_users u ON ( sl.db_user = u.db_user  )  
		WHERE u.usename = session_user
		ORDER BY sl.description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.work_spaces_list() OWNER TO postgres;

--
-- TOC entry 707 (class 1255 OID 17577)
-- Name: work_spaces_upd(bigint, bigint, character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION work_spaces_upd(p_rv bigint, p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$

/*
-- messages di sistema utilizzati from_timela funzione 

DELETE FROM system_messages WHERE function_name = 'work_spaces_upd';

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('work_spaces_upd',1,'it','Non Ã¨ stata trovata nessuna riga nella tabella ''work_spaces'' con: ''revisione'' = ''%s'',  ''work_space'' = ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('work_spaces_upd',2,'it','La funzione in errore Ã¨: ''%s'''); 

INSERT INTO system_messages (function_name, id, language, description)
                     VALUES ('work_spaces_upd',3,'it','Controllare il valore di: ''revisione'', ''work_space'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar := 'work_spaces_upd';
	v_db_user bigint := null;
BEGIN 
	SELECT db_user INTO v_db_user FROM db_users WHERE usename = session_user;

	UPDATE work_spaces SET work_space = p_work_space,
				description = p_description,
				school = p_school,
				school_year = p_school_year,
				classroom = p_classroom,
				subject = p_subject,
				teacher = p_teacher,
				family = p_family,
				student = p_student 											
    	  WHERE work_space = p_work_space
    	    AND xmin = p_rv::text::xid
    	    AND db_user = v_db_user;

    IF NOT FOUND THEN RAISE USING
           ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(system_messages_locale(function_name,1),p_rv, p_work_space),
	   DETAIL = format(system_messages_locale(function_name,2),current_query()),
	   HINT = system_messages_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM work_spaces WHERE work_space = p_work_space;
END;
$$;


ALTER FUNCTION public.work_spaces_upd(p_rv bigint, p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) OWNER TO postgres;

SET search_path = translate, pg_catalog;

--
-- TOC entry 562 (class 1255 OID 17578)
-- Name: synch(); Type: FUNCTION; Schema: translate; Owner: postgres
--

CREATE FUNCTION synch() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
DECLARE
  row_count integer;
BEGIN 

 -- inserisco le tabelle o le viste create dall'ultima volta

  INSERT INTO translate.relations (name, language)
  SELECT isrt.name, l.language
  FROM ( SELECT pg.name::text AS name  
 	FROM ( SELECT c.relname AS name
 		 FROM pg_namespace n
 		 JOIN pg_class c ON c.relnamespace = n.oid
 		WHERE n.nspname = 'public'
 		  AND c.relkind IN ('r', 'v') ) pg
 	FULL JOIN translate.relations t ON t.name = pg.name
 	WHERE t.name IS NULL ) isrt
  CROSS JOIN translate.languages l;

  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Relazioni (tabelle e/o viste) inserite.....: ' || row_count::text;
  RETURN NEXT;
  
 -- cancello le tabelle o le viste create dall'ultima volta

  DELETE FROM translate.relations 
  WHERE name IN ( SELECT DISTINCT t.name AS name
 		   FROM ( SELECT c.relname AS name
 			    FROM pg_namespace n
 			    JOIN pg_class c ON c.relnamespace = n.oid
 			   WHERE n.nspname = 'public'
 			     AND c.relkind IN ('r', 'v') ) pg
 		   FULL JOIN translate.relations t on t.name = pg.name
 		   WHERE pg.name IS NULL );
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Relazioni (tabelle e/o viste) cancellate...: ' || row_count::text;
  RETURN NEXT; 
  
-- inserisco le colonne mancanti
 
  INSERT INTO translate.columns (relation, position, name, language)
  SELECT isrt.relation, isrt.position, isrt.col_name, l.language
  FROM ( SELECT pg.relation AS relation, pg.position, pg.col_name
    FROM (SELECT r.relation as relation, c.relname AS rel_name, a.attnum AS position, a.attname AS col_name 
	    FROM pg_namespace n
	    JOIN pg_class c ON c.relnamespace = n.oid 
	    JOIN pg_attribute a ON a.attrelid = c.oid 
	    JOIN translate.relations r ON r.name = c.relname
	   WHERE n.nspname = 'public'
	     AND c.relkind IN ( 'r', 'v' )
	     AND a.attnum > 0 
	     AND a.attisdropped = FALSE) pg
    FULL JOIN (SELECT r.name as rel_name, c.position AS position, c.name as col_name
	       FROM translate.relations r
	       JOIN translate.columns c ON c.relation = r.relation) t ON t.rel_name = pg.rel_name 
								     AND t.position = pg.position
								     AND t.col_name = pg.col_name
	      WHERE t.rel_name IS NULL ) isrt
  CROSS JOIN translate.languages l;
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Colonne inserite...........................: ' || row_count::text;
  RETURN NEXT; 
   
-- cancello le colonne tolte

  DELETE FROM translate.columns
   WHERE "column" IN ( SELECT t.column
                         FROM ( SELECT c.relname AS rel_name, a.attnum AS position, a.attname AS col_name 
				  FROM pg_namespace n
				  JOIN pg_class c ON c.relnamespace = n.oid 
				  JOIN pg_attribute a ON a.attrelid = c.oid 
				 WHERE n.nspname = 'public'
				   AND c.relkind IN ( 'r', 'v' )
				   AND a.attnum > 0 ) pg
			 FULL JOIN (SELECT c.column as column, r.name as rel_name, c.position AS position, c.name as col_name
				      FROM translate.relations r
				      JOIN translate.columns c ON c.relation = r.relation) t ON t.rel_name = pg.rel_name 
											    AND t.position = pg.position
											    AND t.col_name = pg.col_name
			WHERE pg.rel_name IS NULL );
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Colonne cancellate.........................: ' || row_count::text;
  RETURN NEXT; 
  
-- inserisco le procedure nuove (non considero i trigger)

  INSERT INTO translate.procedures (name, language)
  SELECT isrt.name, l.language
  FROM ( SELECT pg.name::text AS name  
 	FROM ( SELECT DISTINCT p.proname AS name
 		 FROM pg_namespace n
 		 JOIN pg_proc p ON p.pronamespace = n.oid
 		WHERE n.nspname = 'public'
 		  AND p.prorettype NOT IN ('pg_catalog.trigger'::pg_catalog.regtype, 'pg_catalog.refcursor'::pg_catalog.regtype) ) pg
 	FULL JOIN translate.procedures t ON t.name = pg.name
 	WHERE t.name IS NULL ) isrt
  CROSS JOIN translate.languages l;  
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Procedure inserite.........................: ' || row_count::text;
  RETURN NEXT; 
  
-- cancello le procedure tolte (non considero i trigger)

  DELETE FROM translate.procedures 
  WHERE name IN ( SELECT t.name 
                    FROM (SELECT DISTINCT p.proname AS name
 		            FROM pg_namespace n
 		            JOIN pg_proc p ON p.pronamespace = n.oid
 		           WHERE n.nspname = 'public' 
 		             AND p.prorettype NOT IN ('pg_catalog.trigger'::pg_catalog.regtype, 'pg_catalog.refcursor'::pg_catalog.regtype) ) pg
 	               FULL JOIN translate.procedures t ON t.name = pg.name
	                  WHERE pg.name IS NULL );  
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Procedure cancellate.......................: ' || row_count::text;
  RETURN NEXT; 
  
-- inserisco i parametri nuovi 

  INSERT INTO translate.parameters (procedure, signature, name, language)
  SELECT pro.procedure, pg.signature, pg.name, l.language
  FROM ( SELECT arglist.procedure, array_to_string(array_agg(typname),' ') as signature, unnest(min(arglist.proargnames)) as name
           FROM ( SELECT arg.procedure, arg.proargnames, CASE WHEN left(t.typname,1) = '_' THEN right(t.typname,length(t.typname)-1) || '[]' ELSE t.typname END AS typname
                    FROM ( SELECT p.proname AS procedure, p.proargnames, unnest(string_to_array(p.proargtypes::text,' '))::oid AS argument
                             FROM pg_namespace n
                             JOIN pg_proc p ON p.pronamespace = n.oid
                            WHERE n.nspname = 'public'
                              AND p.prorettype NOT IN ('pg_catalog.trigger'::pg_catalog.regtype, 'pg_catalog.refcursor'::pg_catalog.regtype) ) arg
            JOIN pg_type t on t.oid = arg.argument ) arglist
            GROUP BY procedure ) pg 
  JOIN translate.procedures pro ON pro.name = pg.procedure
  FULL JOIN translate.parameters par ON par.procedure = pro.procedure
                                    AND par.signature = pg.signature
                                    AND par.name = pg.name
  CROSS JOIN translate.languages l
  WHERE par.parameter IS NULL;
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Parametri inseriti.........................: ' || row_count::text;
  RETURN NEXT; 
  
-- cancello i parametri vecchi 

  DELETE FROM translate.parameters 
  WHERE parameter IN ( SELECT par.parameter
                       FROM ( SELECT arglist.procedure, array_to_string(array_agg(typname),' ') as signature, unnest(min(arglist.proargnames)) as name
                                FROM ( SELECT arg.procedure, arg.proargnames, CASE WHEN left(t.typname,1) = '_' THEN right(t.typname,length(t.typname)-1) || '[]' ELSE t.typname END AS typname
                                         FROM ( SELECT p.proname AS procedure, p.proargnames, unnest(string_to_array(p.proargtypes::text,' '))::oid AS argument
                                                  FROM pg_namespace n
                                                  JOIN pg_proc p ON p.pronamespace = n.oid
                                                 WHERE n.nspname = 'public'
                                                   AND p.prorettype NOT IN ('pg_catalog.trigger'::pg_catalog.regtype, 'pg_catalog.refcursor'::pg_catalog.regtype) ) arg
                                 JOIN pg_type t on t.oid = arg.argument ) arglist
                                 GROUP BY procedure ) pg 
                       JOIN translate.procedures pro ON pro.name = pg.procedure
                       FULL JOIN translate.parameters par ON par.procedure = pro.procedure
                                                         AND par.signature = pg.signature
                                                         AND par.name = pg.name
                       WHERE pro.procedure IS NULL);
 		   
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'Parametri cancellati.......................: ' || row_count::text;               
  RETURN NEXT;
  END
$$;


ALTER FUNCTION translate.synch() OWNER TO postgres;

--
-- TOC entry 563 (class 1255 OID 17580)
-- Name: translation(); Type: FUNCTION; Schema: translate; Owner: postgres
--

CREATE FUNCTION translation() RETURNS TABLE(message text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  r_languages record;
  r_relations record;
  r_columns record;
  columns_count integer;
  sql text;
BEGIN 	           
  FOR r_languages IN SELECT language, schema 
                       FROM translate.languages
  LOOP
    sql := 'DROP SCHEMA IF EXISTS ' || r_languages.schema || ' CASCADE;';
    EXECUTE sql;
    message := sql;
    RETURN NEXT;
    sql := 'CREATE schema ' || r_languages.schema || ';';
    EXECUTE sql;
    message := sql;
    RETURN NEXT;
    FOR r_relations IN SELECT relation, name, translation
                         FROM translate.relations
                        WHERE language = r_languages.language
    LOOP
      sql := 'CREATE VIEW "' || r_languages.schema || '"."' || r_relations.translation || '" AS SELECT ';
      SELECT COUNT(name) INTO columns_count
        FROM translate.columns
       WHERE relation = r_relations.relation;             
      FOR r_columns IN SELECT name, translation, position 
                         FROM translate.columns
                        WHERE relation = r_relations.relation
                        ORDER BY position
      LOOP
        sql := sql || '"' || r_columns.name || '" AS "' || r_columns.translation || '"';
        IF columns_count = r_columns.position THEN
          sql := sql || ' FROM public."' || r_relations.name || '";' ;
          EXECUTE sql;
          message := sql;
          RETURN NEXT;
          sql := '';
        ELSE
          SQL := sql || ', '; 
        END IF;         
      END LOOP;
    END LOOP;
  END LOOP;
END;
$$;


ALTER FUNCTION translate.translation() OWNER TO postgres;

SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 564 (class 1255 OID 17581)
-- Name: count_unit_tests(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION count_unit_tests() RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  count bigint;
BEGIN
  SELECT COUNT(*) INTO me.count FROM unit_testing.unit_tests_list;
  RETURN me.count; 
END
$$;


ALTER FUNCTION unit_testing.count_unit_tests() OWNER TO postgres;

--
-- TOC entry 565 (class 1255 OID 17582)
-- Name: count_unit_tests_level(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION count_unit_tests_level() RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  count bigint;
BEGIN
  SELECT COUNT(*) INTO me.count FROM unit_testing.unit_tests_level;
  RETURN me.count; 
END
$$;


ALTER FUNCTION unit_testing.count_unit_tests_level() OWNER TO postgres;

--
-- TOC entry 566 (class 1255 OID 17583)
-- Name: fol(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION fol() RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  unit_tests_to_skip     text[];
BEGIN
       SELECT array_agg(d.dependent_schema_name || '.' || d.dependent_function_name || '()') INTO unit_tests_to_skip
          FROM unit_testing.dependencies d
         WHERE d.depends_on_schema_name = 'unit_tests'
           AND d.depends_on_function_name = '_sample'; 
  RETURN unit_tests_to_skip; 
END
$$;


ALTER FUNCTION unit_testing.fol() OWNER TO postgres;

--
-- TOC entry 567 (class 1255 OID 17584)
-- Name: my_sqlcode(text, character); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION my_sqlcode(p_function text, p_id character) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
BEGIN
--
-- these codes are assigned by hand (prefix UM)
-- 
  IF p_function = 'unit_testing.tr_dependencies_iu()' THEN RETURN 'UT01' || p_id::text; END IF;

--
-- if we didn't find the function we set the last possible user code
--
  RETURN 'UTZZZ';
 END;
$$;


ALTER FUNCTION unit_testing.my_sqlcode(p_function text, p_id character) OWNER TO postgres;

--
-- TOC entry 569 (class 1255 OID 17585)
-- Name: run(boolean, boolean, boolean, bigint, text, text); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION run(_check_functions boolean DEFAULT false, _check_queries boolean DEFAULT false, _check_unit_tests boolean DEFAULT true, _unit_test_set bigint DEFAULT NULL::bigint, _verbosity text DEFAULT 'notice'::text, _note text DEFAULT NULL::text, OUT _current_test bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $_$
<<me>>
DECLARE
  context		    text;
  function_name             text;
  function_signature_ex     text;
  function_description      text;
  message_text              text;
  verbosities               text[] =  ARRAY['debug5', 'debug4', 'debug3', 'debug2', 'debug1', 'log', 'notice', 'warning', 'error', 'fatal', 'panic'];
  start_at                  timestamp without time zone;
  end_at                    timestamp without time zone;
  run_time                  interval;
  unit_test_start_at        timestamp without time zone;
  unit_test_end_at          timestamp without time zone;  
  unit_test_run_time        interval;
  unit_tests_to_skip        text[];
  unit_tests_to_add_to_skip text[];
  result		    unit_testing.unit_test_result;
  results                   unit_testing.unit_test_result[];
  all_results               unit_testing.unit_test_result[];
  this                      record;
  should_skip               boolean = FALSE;
  add_dependencies_to_skip  boolean;
  unit_test_name            text;
  sql_command               text;
  check_point		    unit_testing.check_point;
  error        		    diagnostic.error;
  functions_total	    integer;
  functions_passed          integer;
  functions_failed          integer;
  functions_skipped         integer;
  check_points_total        integer;
  check_points_passed       integer;
  check_points_failed       integer;
  
BEGIN
  -- get the function_name
  GET DIAGNOSTICS context = PG_CONTEXT;
  function_name = diagnostic.function_name(context);

  -- get the start time
  start_at = clock_timestamp()::timestamp;
  RAISE NOTICE '*********************';
  RAISE NOTICE '** START  FUNCTION ** % at: %', function_name, start_at;
  RAISE NOTICE '*********************';
 
  -- check _verbosity parameter
  IF array_position(verbosities, _verbosity) IS NULL THEN
    message_text =  'verbosity wrong value, the value have to be one of: ' || array_to_string(verbosities,',');
    PERFORM diagnostic.function_syntax_error(function_name, message_text);
  ELSE
    -- set _verbosity parameter
    EXECUTE 'SET CLIENT_MIN_MESSAGES TO ' || _verbosity;
    RAISE NOTICE 'SET_MIN_MESSAGES to.: %', _verbosity;
  END IF;

  -- check _unit_test_set
  IF _unit_test_set IS NOT NULL THEN
    PERFORM 1 FROM unit_testing.unit_test_sets uts  WHERE uts.unit_test_set = _unit_test_set ;
    IF NOT FOUND THEN
      message_text =  'unit test set: ' || _unit_test_set ||  ' not found in table: unit_testing.unit_test_sets';
      PERFORM diagnostic.function_syntax_error(function_name, message_text);
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
      RAISE NOTICE '---------------------';
      RAISE NOTICE 'Circular reference..: PASSED !!!';
      RAISE NOTICE '---------------------';
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
        RAISE NOTICE '---------------------';
        RAISE NOTICE 'Check functions......: PASSED !!!';
        RAISE NOTICE '---------------------';
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
        RAISE NOTICE '---------------------';
        RAISE NOTICE 'Check queries.......: PASSED !!!';
        RAISE NOTICE '---------------------';
      END IF;
    END IF;
  
    FOR this IN
      SELECT l.schema_name, l.function_name, l.max_level
        FROM unit_testing.unit_tests_level l
        WHERE _check_unit_tests -- if false no result from select
        ORDER BY l.max_level, l.schema_name, l.function_name
    LOOP
      BEGIN
        unit_test_name = this.schema_name || '.' || this.function_name || '()';
        add_dependencies_to_skip = false;
        should_skip = FALSE;
        
        -- check if the function have to be skip
        SELECT array_position(unit_tests_to_skip, unit_test_name) IS NOT NULL INTO should_skip;
            
        IF should_skip THEN
          add_dependencies_to_skip = true;

          -- add a result test to indicate that the present unit_test was skipped
          check_point.function_name = unit_test_name;
          check_point.test_name = NULL;
          check_point.checked_at = clock_timestamp()::timestamp;
          check_point.status = 'Skipped';
          check_point.message = 'Unit test function skipped because depend on a failed function';
          result.check_point = check_point;
          result.error = NULL;
          all_results = array_append(all_results, result);

          RAISE NOTICE 'SKIPPED !!! Unit Test: % skipped', unit_test_name;

        ELSE
          sql_command = 'SELECT ' || unit_test_name || ';';
          unit_test_start_at = clock_timestamp()::timestamp;
          RAISE NOTICE '>>>>>>>>>>>>>>>>>>>>>';
          RAISE NOTICE 'START !!! UNIT TEST : % at: %', unit_test_name, unit_test_start_at;
          RAISE NOTICE '>>>>>>>>>>>>>>>>>>>>>';

          EXECUTE sql_command INTO results;
          unit_test_end_at = clock_timestamp()::timestamp;
          unit_test_run_time := unit_test_end_at - unit_test_start_at;
          RAISE NOTICE '<<<<<<<<<<<<<<<<<<<<<';
          RAISE NOTICE 'END !!! UNIT TEST...: % at: % runtime: %', unit_test_name, unit_test_end_at, unit_test_run_time;
          RAISE NOTICE '<<<<<<<<<<<<<<<<<<<<<';

          all_results = array_cat(all_results, results);

          -- test if a checkpoint failed
          PERFORM 1 FROM unnest(results) r WHERE (r.check_point).status = 'Failed';
          
          -- add a result test to indicate that the unit test function was Failed or Passed
          IF FOUND THEN 
             add_dependencies_to_skip = true;
             check_point.status = 'Failed';
             check_point.message = 'Unit test function skipped because depend on a failed check_point';
          ELSE
             check_point.status = 'Passed';
             check_point.message = 'Unit test function passed because all check_point passed';
          END IF;
          
          check_point.function_name = unit_test_name;
          check_point.test_name = NULL;
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
        RAISE NOTICE '<<<<<<<<<<<<<<<<<<<<<';
        RAISE NOTICE 'END !!! UNIT TEST...: % at: % runtime: %', unit_test_name, unit_test_end_at, unit_test_run_time;
        RAISE NOTICE '<<<<<<<<<<<<<<<<<<<<<';
        result = assert.fail(unit_test_name,NULL,'Unexpected exception raised',error);   
        all_results=array_append(all_results, result);
        add_dependencies_to_skip = TRUE;
      END;
      IF add_dependencies_to_skip THEN
        -- add the unit test that depend on this one to the unit test to skip 
       SELECT array_agg(d.dependent_schema_name || '.' || d.dependent_function_name || '()') INTO unit_tests_to_add_to_skip
          FROM unit_testing.dependencies d
         WHERE d.depends_on_schema_name = this.schema_name
           AND d.depends_on_function_name = this.function_name;
        unit_tests_to_skip = array_cat(unit_tests_to_skip, unit_tests_to_add_to_skip);   
      END IF;
    END LOOP;
    RAISE EXCEPTION SQLSTATE 'ZZZZZ'; -- raise the error to abort the transaction and rollback all data updates
  EXCEPTION WHEN SQLSTATE 'ZZZZZ' THEN -- questo Ã¨ per annullare eventuali modifiche ai dati fatte dai test
            WHEN plpgsql_error THEN
              GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
              --PERFORM diagnostic.show(error);
              result = assert.fail(NULL,NULL,(error).message_text,error);   
              all_results=array_append(all_results, result);
            WHEN OTHERS THEN -- questo Ã¨ nel caso, invece, venga generata un' eccezzione per qualsivoglia motivo non gestita e quindi da rilanciare
              GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
              RAISE NOTICE '$$$$$$$$$$$$$$$$$$$$$';
              RAISE NOTICE 'UNEXPECTED EXCEPTION!';
              RAISE NOTICE '$$$$$$$$$$$$$$$$$$$$$';
              PERFORM diagnostic.show(error);
              RAISE plpgsql_error USING MESSAGE = 'in the Functon: ' || function_name || ' something was wrong', 
                                        DETAIL = error.message_text,
                                        HINT = 'Call the programmer and check the code';
  END;

  end_at = clock_timestamp()::timestamp;
  run_time := end_at - start_at;

  RAISE NOTICE '*********************';
  RAISE NOTICE '*** END  FUNCTION ***';
  RAISE NOTICE '*********************';
  RAISE NOTICE 'Function............: % ending at: % runtime: %', function_name, end_at, run_time;
  
-- store the result
  SELECT nextval('unit_testing.pk_seq') INTO _current_test;

  INSERT INTO unit_testing.tests(test, start_at, end_at, unit_test_set, note, check_queries, check_functions, check_unit_tests) 
       VALUES (_current_test, me.start_at, me.end_at, _unit_test_set, _note, _check_queries, _check_functions, _check_unit_tests);

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

  RAISE NOTICE '--------------------------------';
  RAISE NOTICE '---------- STATISTICS ----------';
  RAISE NOTICE '--------------------------------';
  RAISE NOTICE 'Test id.........................: %', _current_test;
  RAISE NOTICE 'Test started on.................: %', start_at;
  RAISE NOTICE 'Test ended on...................: %', end_at;
  RAISE NOTICE 'Test runtime was................: %', run_time;
  RAISE NOTICE '     total functions............: %', functions_total;
  RAISE NOTICE '     functions passed...........: %', functions_passed;
  RAISE NOTICE '     functions failed...........: %', functions_failed;
  RAISE NOTICE '     functions skipped..........: %', functions_skipped;
  RAISE NOTICE '          total check points....: %', check_points_total;
  RAISE NOTICE '          check points passed...: %', check_points_passed;   
  RAISE NOTICE '          check points failed...: %', check_points_failed;
 
  SET CLIENT_MIN_MESSAGES TO notice;
  RETURN;  
END
$_$;


ALTER FUNCTION unit_testing.run(_check_functions boolean, _check_queries boolean, _check_unit_tests boolean, _unit_test_set bigint, _verbosity text, _note text, OUT _current_test bigint) OWNER TO postgres;

--
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 569
-- Name: FUNCTION run(_check_functions boolean, _check_queries boolean, _check_unit_tests boolean, _unit_test_set bigint, _verbosity text, _note text, OUT _current_test bigint); Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON FUNCTION run(_check_functions boolean, _check_queries boolean, _check_unit_tests boolean, _unit_test_set bigint, _verbosity text, _note text, OUT _current_test bigint) IS 'Check all unit test or only one set and, optionally, specify whether to check the syntax of all functions and indicate the level of detail in the reports';


--
-- TOC entry 570 (class 1255 OID 17587)
-- Name: run_ex(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION run_ex(OUT function text, OUT name text, OUT checked_at timestamp without time zone, OUT passed boolean, OUT message text, OUT returned_sqlstate text, OUT message_text text, OUT schema_name text, OUT table_name text, OUT column_name text, OUT constraint_name text, OUT pg_exception_context text, OUT pg_exception_detail text, OUT pg_exception_hint text, OUT pg_datatype_name text) RETURNS SETOF record
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY SELECT (check_point).*, (diagnostics).* FROM unnest(assert.folrun());
END
$$;


ALTER FUNCTION unit_testing.run_ex(OUT function text, OUT name text, OUT checked_at timestamp without time zone, OUT passed boolean, OUT message text, OUT returned_sqlstate text, OUT message_text text, OUT schema_name text, OUT table_name text, OUT column_name text, OUT constraint_name text, OUT pg_exception_context text, OUT pg_exception_detail text, OUT pg_exception_hint text, OUT pg_datatype_name text) OWNER TO postgres;

--
-- TOC entry 571 (class 1255 OID 17588)
-- Name: set_continuous_integration(boolean); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION set_continuous_integration(activate boolean) RETURNS text
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  message text;
BEGIN
  DROP EVENT TRIGGER IF EXISTS continuous_integration;
  message = 'Continuous integration deactivated';
  IF activate THEN
    CREATE EVENT TRIGGER continuous_integration ON ddl_command_end 
      WHEN TAG IN (
        'ALTER AGGREGATE',
	'ALTER COLLATION',
	'ALTER CONVERSION',
--	'ALTER DOMAIN',
--	'ALTER EXTENSION',
--	'ALTER FOREIGN DATA WRAPPER',
	'ALTER FOREIGN TABLE',
	'ALTER FUNCTION',
--	'ALTER LANGUAGE',
	'ALTER OPERATOR',
	'ALTER OPERATOR CLASS',
	'ALTER OPERATOR FAMILY',
	'ALTER POLICY',
--	'ALTER SCHEMA',
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
	'CREATE FOREIGN TABLE',
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
	'CREATE SERVER',
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
	'DROP FOREIGN TABLE',
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
	'DROP SERVER',
	'DROP TABLE',
	'DROP TEXT SEARCH CONFIGURATION',
	'DROP TEXT SEARCH DICTIONARY',
	'DROP TEXT SEARCH PARSER',
	'DROP TEXT SEARCH TEMPLATE',
	'DROP TRIGGER',
	'DROP TYPE',
	'DROP USER MAPPING',
	'DROP VIEW',
	'GRANT',
	'IMPORT FOREIGN SCHEMA',
	'REVOKE',
	'SECURITY LABEL')
--        'SELECT INTO')       
      EXECUTE PROCEDURE unit_testing.tr_continuous_integration();
    message = 'Continuous integration activated';
  END IF;
  RETURN message;
END
$$;


ALTER FUNCTION unit_testing.set_continuous_integration(activate boolean) OWNER TO postgres;

--
-- TOC entry 572 (class 1255 OID 17589)
-- Name: show(check_point); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION show(_check_point check_point) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
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
-- TOC entry 573 (class 1255 OID 17590)
-- Name: tr_continuous_integration(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_continuous_integration() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  
BEGIN
  --RAISE EXCEPTION SQLSTATE 'ZZZZZ';
  RETURN;
END;
$$;


ALTER FUNCTION unit_testing.tr_continuous_integration() OWNER TO postgres;

--
-- TOC entry 708 (class 1255 OID 17591)
-- Name: tr_dependencies_iu(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_dependencies_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context	text;
  function_name text;
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.function_name = diagnostic.function_name(me.context);
--
-- check dependent_schema_name and dependent_function name are unit_test_functions
--
	PERFORM 1 FROM unit_testing.unit_tests_list utl
	         WHERE utl.schema_name = new.dependent_schema_name
	           AND utl.function_name  = new.dependent_function_name;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = unit_testing.my_sqlcode(me.function_name,'1'),
			   MESSAGE = utility.system_messages_locale('unit_testing'::text,me.function_name,1),
			   DETAIL = format(utility.system_messages_locale('unit_testing'::text,me.function_name,2), new.dependent_schema_name, new.dependent_function_name),
			   HINT = utility.system_messages_locale('unit_testing'::text,me.function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = unit_testing.my_sqlcode(me.function_name,'2'),
			   MESSAGE = utility.system_messages_locale('unit_testing'::text,me.function_name,4),
			   DETAIL = format(utility.system_messages_locale('unit_testing'::text,me.function_name,2), new.dependent_schema_name, new.dependent_function_name),
			   HINT = utility.system_messages_locale('unit_testing'::text,me.function_name,3);
		END IF;	   
	END IF;
--
-- check depend_on_schema_name and depends_on_function name are unit_test_functions
--
	PERFORM 1 FROM unit_testing.unit_tests_list utl
	         WHERE utl.schema_name = new.depends_on_schema_name
	           AND utl.function_name  = new.depends_on_function_name;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = unit_testing.my_sqlcode(me.function_name,'1'),
			   MESSAGE = utility.system_messages_locale('unit_testing'::text,me.function_name,1),
			   DETAIL = format(utility.system_messages_locale('unit_testing'::text,me.function_name,2), new.depends_on_schema_name, new.depends_on_function_name),
			   HINT = utility.system_messages_locale('unit_testing'::text,me.function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = unit_testing.my_sqlcode(me.function_name,'2'),
			   MESSAGE = utility.system_messages_locale('unit_testing'::text,me.function_name,4),
			   DETAIL = format(utility.system_messages_locale('unit_testing'::text,me.function_name,2), new.depends_on_schema_name, new.depends_on_function_name),
			   HINT = utility.system_messages_locale('unit_testing'::text,me.function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION unit_testing.tr_dependencies_iu() OWNER TO postgres;

--
-- TOC entry 574 (class 1255 OID 17592)
-- Name: tr_unit_test_sets_details_iu(); Type: FUNCTION; Schema: unit_testing; Owner: postgres
--

CREATE FUNCTION tr_unit_test_sets_details_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context	text;
  function_name text;
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.function_name = utility.function_name(me.context);
--
-- check dependent_schema_name and dependent_function name are unit_test_functions
--
	PERFORM 1 FROM unit_testing.unit_tests_list utl
	         WHERE utl.name_space = new.name_space
	           AND utl.function_name  = new.function_name;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = unit_testing.my_sqlcode(me.function_name,'1'),
			   MESSAGE = utility.system_messages_locale('unit_testing'::text,me.function_name,1),
			   DETAIL = format(utility.system_messages_locale('unit_testing'::text,me.function_name,2), new.name_space, new.function_name),
			   HINT = utility.system_messages_locale('unit_testing'::text,me.function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = unit_testing.my_sqlcode(me.function_name,'2'),
			   MESSAGE = utility.system_messages_locale('unit_testing'::text,me.function_name,4),
			   DETAIL = format(utility.system_messages_locale('unit_testing'::text,me.function_name,2), new.name_space, new.function_name),
			   HINT = utility.system_messages_locale('unit_testing'::text,me.function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION unit_testing.tr_unit_test_sets_details_iu() OWNER TO postgres;

SET search_path = unit_tests, pg_catalog;

--
-- TOC entry 576 (class 1255 OID 17593)
-- Name: _school_years(); Type: FUNCTION; Schema: unit_tests; Owner: postgres
--

CREATE FUNCTION _school_years(OUT _results unit_testing.unit_test_result[]) RETURNS unit_testing.unit_test_result[]
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE 
  context               text;
  function_name 	text;
  test_name		text = '';
  const_name		text;
  error			diagnostic.error;
  result		unit_testing.unit_test_result;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  function_name = diagnostic.function_name(context);
----------------------------------------------
  test_name = 'insert schools_year: ''2016/2017''';
----------------------------------------------
  BEGIN

    INSERT INTO public.school_years(
            school_year, school, description, duration, lessons_duration)
    VALUES (8000001, 9000001,'2016/2017', '[2016-09-11,2017-09-11)', '[2016-09-11,2017-06-08)');

    result =  assert.pass(function_name, test_name);
    _results=array_append(_results, result);     

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        result = assert.fail(function_name, test_name, 'inserimento schools non riuscito'::text, error);   
        _results=array_append(_results, result);      
        RETURN; 
  END;
-----------
--- END ---
-----------   
  RETURN; 
END
$$;


ALTER FUNCTION unit_tests._school_years(OUT _results unit_testing.unit_test_result[]) OWNER TO postgres;

--
-- TOC entry 577 (class 1255 OID 17594)
-- Name: mime_type(); Type: FUNCTION; Schema: unit_tests; Owner: postgres
--

CREATE FUNCTION mime_type(OUT _results unit_testing.unit_test_result[]) RETURNS unit_testing.unit_test_result[]
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE 
  context               text;
  function_name 	text;
  test_name		text = '';
  const_name		text;
  error			diagnostic.error;
  result		unit_testing.unit_test_result;
  file_extension        file_extension;
  mime_type	        mime_type;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  function_name = diagnostic.function_name(context);
----------------------------------------------
  test_name = 'conversione .json to file_extension';
----------------------------------------------
  BEGIN
    SELECT '.json'::file_extension INTO me.file_extension;
    result =  assert.pass(function_name, test_name);
    _results=array_append(_results, result);     
  EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        result = assert.fail(function_name, test_name, 'conversione non riuscita'::text, error);   
        _results=array_append(_results, result);      
        RETURN; 
  END; 
----------------------------------------------
  test_name = 'conversione .json file_extension to mime_type';
----------------------------------------------
  BEGIN
    SELECT '.json'::file_extension::mime_type INTO me.mime_type;
    IF mime_type = 'application/json' THEN
      result =  assert.pass(function_name, test_name);
      _results=array_append(_results, result);  
    ELSE
      error = NULL;
      result = assert.fail(function_name, test_name, 'conversione non riuscita'::text, error);   
      _results=array_append(_results, result);
    END IF;  
  EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        result = assert.fail(function_name, test_name, 'conversione non riuscita'::text, error);   
        _results=array_append(_results, result);      
        RETURN; 
  END; 
----------------------------------------------
  test_name = 'conversione .pdf to file_extension';
----------------------------------------------
  BEGIN
    SELECT '.pdf'::file_extension INTO me.file_extension;
    result =  assert.pass(function_name, test_name);
    _results=array_append(_results, result);     
  EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        result = assert.fail(function_name, test_name, 'conversione non riuscita'::text, error);   
        _results=array_append(_results, result);      
        RETURN; 
  END; 
----------------------------------------------
  test_name = 'conversione .pdf file_extension to mime_type';
----------------------------------------------
  BEGIN
    SELECT '.pdf'::file_extension::mime_type INTO me.mime_type;
    IF mime_type = 'application/pdf' THEN
      result =  assert.pass(function_name, test_name);
      _results=array_append(_results, result);  
    ELSE
      error = NULL;
      result = assert.fail(function_name, test_name, 'conversione non riuscita'::text, error);   
      _results=array_append(_results, result);
    END IF;  
  EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        result = assert.fail(function_name, test_name, 'conversione non riuscita'::text, error);   
        _results=array_append(_results, result);      
        RETURN; 
  END; 
  RETURN; 
END
$$;


ALTER FUNCTION unit_tests.mime_type(OUT _results unit_testing.unit_test_result[]) OWNER TO postgres;

--
-- TOC entry 578 (class 1255 OID 17595)
-- Name: schools(); Type: FUNCTION; Schema: unit_tests; Owner: postgres
--

CREATE FUNCTION schools(OUT _results unit_testing.unit_test_result[]) RETURNS unit_testing.unit_test_result[]
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE 
  context               text;
  function_name 	text;
  test_name		text = '';
  const_name		text;
  error			diagnostic.error;
  result		unit_testing.unit_test_result;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  function_name = diagnostic.function_name(context);
----------------------------------------------
  test_name = 'insert schools: ''UNITTEST1''';
----------------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) 
                 VALUES (9000001, 'Isituto di UNITTEST1','UNIT-TEST-CODE1','UNITTEST1', TRUE, NULL, NULL);

    result =  assert.pass(function_name, test_name);
    _results=array_append(_results, result);     

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        result = assert.fail(function_name, test_name, 'inserimento schools non riuscito'::text, error);   
        _results=array_append(_results, result);      
        RETURN; 
  END;
  /*
--------------------------------------------------------------------------
  test_name = 'insert school: ''UNITTEST1'' to test duplicate description';
--------------------------------------------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) 
                 VALUES (9000002, 'Isituto di UNITTEST1','UNIT-TEST-CODE2','UNITTEST2', TRUE, NULL, NULL);

    result = assert.fail(function_name, test_name, error);   
    _results=array_append(_results, result);        
    RETURN;      

    EXCEPTION WHEN SQLSTATE '23505' THEN 
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;	
      IF const_name = 'schools_uq_description' THEN
        result = assert.pass(function_name, test_name);
        _results=array_append(_results, result);    
      ELSE
	result = assert.fail(function_name, test_name, error);   
	_results=array_append(_results, result);        
	RETURN; 
      END IF; 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
	result = assert.fail(function_name, test_name, error);   
	_results=array_append(_results, result);       
        RETURN; 
  END;

-----------------------------------------------------------------------
  test_name = 'insert school: ''NITTEST1'' to test duplicate mnemonic';
-----------------------------------------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) 
                 VALUES (9000002, 'Isituto di UNITTEST2','UNIT-TEST-CODE2','UNITTEST1', TRUE, NULL, NULL);
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);     
    RETURN;        
    EXCEPTION WHEN SQLSTATE '23505' THEN 
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;	
      IF const_name = 'schools_uq_mnemonic' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);    
      ELSE
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);      
        RETURN;
      END IF; 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN; 
  END;
------------------------------------------------------------------------------
  test_name = 'insert school: ''NITTEST1'' to test duplicate processing code';
------------------------------------------------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) 
                 VALUES (9000002, 'Isituto di UNITTEST2','UNIT-TEST-CODE1','UNITTEST2', TRUE, NULL, NULL);
    result = assert.fail(function_name, test_name, '',error);   
    _results=array_append(_results, result);     
    RETURN;       
    EXCEPTION WHEN SQLSTATE '23505' THEN 
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;	
      IF const_name = 'schools_uq_processing_code' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);  
      ELSE
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
      END IF; 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN; 
  END;
--------------------------------------------
  test_name = 'insert school: ''NITTEST2''';
--------------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) 
                 VALUES (9000002, 'Isituto di UNITTEST2','UNIT-TEST-CODE2','UNITTEST2', TRUE, NULL, NULL);
    SELECT * FROM assert.pass(function_name, test_name)  INTO result;
    _results=array_append(_results, result);      
    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN; 
  END;
----------------------------------------------
  test_name = 'insert subject: ''Condotta1''';
----------------------------------------------
  BEGIN
    INSERT INTO subjects (subject, school, description) 
                 VALUES (9000003, 9000001, 'Condotta1');
    SELECT * FROM assert.pass(function_name, test_name)  INTO result;
    _results=array_append(_results, result);       
    EXCEPTION
      WHEN OTHERS THEN 
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
  END;
----------------------------------------------
  test_name = 'insert subject: ''Condotta2''';
----------------------------------------------
  BEGIN
    INSERT INTO subjects (subject, school, description) 
                 VALUES (9000004, 9000002, 'Condotta2');
    SELECT * FROM assert.pass(function_name, test_name)  INTO result;
    _results=array_append(_results, result);       
    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END;
----------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' description''s mndatory';
----------------------------------------------------------------------
  BEGIN
    UPDATE schools SET description = NULL WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);      
    RETURN;    
    EXCEPTION WHEN SQLSTATE '23502' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' description''s min lenght';
------------------------------------------------------------------------
  BEGIN
    UPDATE schools SET description = '' WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);      
    RETURN;   
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;	
      IF const_name = 'schools_min_description' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
     ELSE
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);         
        RETURN;
      END IF;    
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);        
        RETURN;
  END; 
------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' description''s max lenght';
------------------------------------------------------------------------
 BEGIN
    UPDATE schools SET description = repeat('X', 161) WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);   
    RETURN;
    EXCEPTION WHEN SQLSTATE '22001' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
  END; 
--------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' processing_code''s mndatory';
--------------------------------------------------------------------------
  BEGIN
    UPDATE schools SET processing_code = NULL WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);       
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);     
        RETURN;
  END; 
----------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' processing_code''s min lenght';
----------------------------------------------------------------------------
  BEGIN
    UPDATE schools SET processing_code = '' WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);    
    RETURN;   
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;	
      IF const_name = 'schools_min_processing_code' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
     ELSE
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
      END IF;    
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
----------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' processing_code''s max lenght';
----------------------------------------------------------------------------
 BEGIN
    UPDATE schools SET processing_code = repeat('X', 161) WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);   
    RETURN;
    EXCEPTION WHEN SQLSTATE '22001' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
--------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' mnemonic''s mandatory';
--------------------------------------------------------------------
  BEGIN
    UPDATE schools SET mnemonic = NULL WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);       
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);      
        RETURN;
  END; 
---------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' mnemonic''s min lenght';
---------------------------------------------------------------------
  BEGIN
    UPDATE schools SET mnemonic = '' WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);     
    RETURN;   
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;	
      IF const_name = 'schools_min_mnemonic' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
     ELSE
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
      END IF;    
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
---------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' mnemonic''s max lenght';
---------------------------------------------------------------------
 BEGIN
    UPDATE schools SET mnemonic = repeat('X', 31) WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);          
    RETURN;
    EXCEPTION WHEN SQLSTATE '22001' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);      
        RETURN;
  END; 
-------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' example''s mandatory';
-------------------------------------------------------------------
  BEGIN
    UPDATE schools SET example = NULL WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);       
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
-----------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' example type';
-----------------------------------------------------------
  BEGIN
    UPDATE schools SET example = 'X' WHERE school = 9000001;
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);   
    RETURN;
    EXCEPTION WHEN SQLSTATE '22P02' THEN 
	SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
----------------------------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' set behavior with subject with different school';
----------------------------------------------------------------------------------------------
  BEGIN
    UPDATE schools SET behavior = 9000004 WHERE school = 9000001; 
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'UM341' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
  END; 
---------------------------------------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1''  set behavior with non existence subject';
---------------------------------------------------------------------------------------
  BEGIN
    UPDATE schools SET behavior = 9999999 WHERE school = 9000001; 
    SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
    _results=array_append(_results, result);       
    RETURN;
    EXCEPTION WHEN SQLSTATE '23503' THEN
      GET STACKED DIAGNOSTICS const_name = CONSTRAINT_NAME;
      IF const_name = 'schools_fk_subject' THEN
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);   
      ELSE
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);      
        RETURN;
      END IF;
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);       
        RETURN;
  END; 
-----------------------------------------------------------
  test_name = 'update schools: ''UNITTEST1'' set behavior';
-----------------------------------------------------------
  BEGIN
    UPDATE schools SET behavior = 9000003 WHERE school = 9000001;
        SELECT * FROM assert.pass(function_name, test_name)  INTO result;
        _results=array_append(_results, result);      
    EXCEPTION 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    	SELECT * FROM assert.fail(function_name, test_name, error) INTO result;   
	_results=array_append(_results, result);   
        RETURN;
  END; 
  */
-----------
--- END ---
-----------   
  RETURN; 
END
$$;


ALTER FUNCTION unit_tests.schools(OUT _results unit_testing.unit_test_result[]) OWNER TO postgres;

--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 578
-- Name: FUNCTION schools(OUT _results unit_testing.unit_test_result[]); Type: COMMENT; Schema: unit_tests; Owner: postgres
--

COMMENT ON FUNCTION schools(OUT _results unit_testing.unit_test_result[]) IS 'Testa tutti i controlli della tabella schools';


SET search_path = utility, pg_catalog;

--
-- TOC entry 709 (class 1255 OID 17597)
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
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 709
-- Name: FUNCTION count_value(search_db text, search_schema text, search_table text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION count_value(search_db text, search_schema text, search_table text) IS 'Restituisce l''elenco delle colonne che ammettono valori null person l''indicazione del numero di valori contenuti person la sottodivisione fra quelli che non hanno valori nulle quelli che si.';


--
-- TOC entry 579 (class 1255 OID 17598)
-- Name: entity2char(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION entity2char(t text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
    r record;
begin
    for r in
        select distinct ce.coding as ch, ce.entity as name
        from
            utility.entity_coding() ce
            inner join (
                select name[1] "name"
                from regexp_matches(t, '&([A-Za-z]+?);', 'g') r(name)
            ) s on ce.entity = s.name
    loop
        t := replace(t, '&' || r.name || ';', r.ch);
    end loop;

    for r in
        select distinct
            hex[1] hex,
            ('x' || repeat('0', 8 - length(hex[1])) || hex[1])::bit(32)::int codepoint
        from regexp_matches(t, '&#x([0-9a-f]{1,8}?);', 'gi') s(hex)
    loop
        t := regexp_replace(t, '&#x' || r.hex || ';', chr(r.codepoint), 'gi');
    end loop;

    for r in
        select distinct
            chr(codepoint[1]::int) ch,
            codepoint[1] codepoint
        from regexp_matches(t, '&#([0-9]{1,10}?);', 'g') s(codepoint)
    loop
        t := replace(t, '&#' || r.codepoint || ';', r.ch);
    end loop;

    return t;
end;
$$;


ALTER FUNCTION utility.entity2char(t text) OWNER TO postgres;

--
-- TOC entry 580 (class 1255 OID 17599)
-- Name: entity_coding(); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION entity_coding() RETURNS TABLE(entity text, coding character)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
DECLARE
BEGIN 
  entity := 'Aacute'::text; coding := E'\u00C1'::character; RETURN NEXT;
  entity := 'Acirc'::text; coding := E'\u00C2'::character; RETURN NEXT;
  entity := 'AElig'::text; coding := E'\u00C6'::character; RETURN NEXT;
  entity := 'Agrave'::text; coding := E'\u00C0'::character; RETURN NEXT;
  entity := 'Alpha'::text; coding := E'\u0391'::character; RETURN NEXT;
  entity := 'Aring'::text; coding := E'\u00C5'::character; RETURN NEXT;
  entity := 'Atilde'::text; coding := E'\u00C3'::character; RETURN NEXT;
  entity := 'Auml'::text; coding := E'\u00C4'::character; RETURN NEXT;
  entity := 'Beta'::text; coding := E'\u0392'::character; RETURN NEXT;
  entity := 'Ccedil'::text; coding := E'\u00C7'::character; RETURN NEXT;
  entity := 'Chi'::text; coding := E'\u03A7'::character; RETURN NEXT;
  entity := 'Dagger'::text; coding := E'\u2021'::character; RETURN NEXT;
  entity := 'Delta'::text; coding := E'\u0394'::character; RETURN NEXT;
  entity := 'ETH'::text; coding := E'\u00D0'::character; RETURN NEXT;
  entity := 'Eacute'::text; coding := E'\u00C9'::character; RETURN NEXT;
  entity := 'Ecirc'::text; coding := E'\u00CA'::character; RETURN NEXT;
  entity := 'Egrave'::text; coding := E'\u00C8'::character; RETURN NEXT;
  entity := 'Epsilon'::text; coding := E'\u0395'::character; RETURN NEXT;
  entity := 'Eta'::text; coding := E'\u0397'::character; RETURN NEXT;
  entity := 'Euml'::text; coding := E'\u00CB'::character; RETURN NEXT;
  entity := 'Gamma'::text; coding := E'\u0393'::character; RETURN NEXT;
  entity := 'Iacute'::text; coding := E'\u00CD'::character; RETURN NEXT;
  entity := 'Icirc'::text; coding := E'\u00CE'::character; RETURN NEXT;
  entity := 'Igrave'::text; coding := E'\u00CC'::character; RETURN NEXT;
  entity := 'Iota'::text; coding := E'\u0399'::character; RETURN NEXT;
  entity := 'Iuml'::text; coding := E'\u00CF'::character; RETURN NEXT;
  entity := 'Kappa'::text; coding := E'\u039A'::character; RETURN NEXT;
  entity := 'Lambda'::text; coding := E'\u039B'::character; RETURN NEXT;
  entity := 'Mu'::text; coding := E'\u039C'::character; RETURN NEXT;
  entity := 'Ntilde'::text; coding := E'\u00D1'::character; RETURN NEXT;
  entity := 'Nu'::text; coding := E'\u039D'::character; RETURN NEXT;
  entity := 'OElig'::text; coding := E'\u0152'::character; RETURN NEXT;
  entity := 'Oacute'::text; coding := E'\u00D3'::character; RETURN NEXT;
  entity := 'Ocirc'::text; coding := E'\u00D4'::character; RETURN NEXT;
  entity := 'Ograve'::text; coding := E'\u00D2'::character; RETURN NEXT;
  entity := 'Omega'::text; coding := E'\u03A9'::character; RETURN NEXT;
  entity := 'Omicron'::text; coding := E'\u039F'::character; RETURN NEXT;
  entity := 'Oslash'::text; coding := E'\u00D8'::character; RETURN NEXT;
  entity := 'Otilde'::text; coding := E'\u00D5'::character; RETURN NEXT;
  entity := 'Ouml'::text; coding := E'\u00D6'::character; RETURN NEXT;
  entity := 'Phi'::text; coding := E'\u03A6'::character; RETURN NEXT;
  entity := 'Pi'::text; coding := E'\u03A0'::character; RETURN NEXT;
  entity := 'Prime'::text; coding := E'\u2033'::character; RETURN NEXT;
  entity := 'Psi'::text; coding := E'\u03A8'::character; RETURN NEXT;
  entity := 'Rho'::text; coding := E'\u03A1'::character; RETURN NEXT;
  entity := 'Scaron'::text; coding := E'\u0160'::character; RETURN NEXT;
  entity := 'Sigma'::text; coding := E'\u03A3'::character; RETURN NEXT;
  entity := 'THORN'::text; coding := E'\u00DE'::character; RETURN NEXT;
  entity := 'Tau'::text; coding := E'\u03A4'::character; RETURN NEXT;
  entity := 'Theta'::text; coding := E'\u0398'::character; RETURN NEXT;
  entity := 'Uacute'::text; coding := E'\u00DA'::character; RETURN NEXT;
  entity := 'Ucirc'::text; coding := E'\u00DB'::character; RETURN NEXT;
  entity := 'Ugrave'::text; coding := E'\u00D9'::character; RETURN NEXT;
  entity := 'Upsilon'::text; coding := E'\u03A5'::character; RETURN NEXT;
  entity := 'Uuml'::text; coding := E'\u00DC'::character; RETURN NEXT;
  entity := 'Xi'::text; coding := E'\u039E'::character; RETURN NEXT;
  entity := 'Yacute'::text; coding := E'\u00DD'::character; RETURN NEXT;
  entity := 'Yuml'::text; coding := E'\u0178'::character; RETURN NEXT;
  entity := 'Zeta'::text; coding := E'\u0396'::character; RETURN NEXT;
  entity := 'aacute'::text; coding := E'\u00E1'::character; RETURN NEXT;
  entity := 'acirc'::text; coding := E'\u00E2'::character; RETURN NEXT;
  entity := 'acute'::text; coding := E'\u00B4'::character; RETURN NEXT;
  entity := 'aelig'::text; coding := E'\u00E6'::character; RETURN NEXT;
  entity := 'agrave'::text; coding := E'\u00E0'::character; RETURN NEXT;
  entity := 'alefsym'::text; coding := E'\u2135'::character; RETURN NEXT;
  entity := 'alpha'::text; coding := E'\u03B1'::character; RETURN NEXT;
  entity := 'amp'::text; coding := E'\u0026'::character; RETURN NEXT;
  entity := 'and'::text; coding := E'\u2227'::character; RETURN NEXT;
  entity := 'ang'::text; coding := E'\u2220'::character; RETURN NEXT;
  entity := 'aring'::text; coding := E'\u00E5'::character; RETURN NEXT;
  entity := 'asymp'::text; coding := E'\u2248'::character; RETURN NEXT;
  entity := 'atilde'::text; coding := E'\u00E3'::character; RETURN NEXT;
  entity := 'auml'::text; coding := E'\u00E4'::character; RETURN NEXT;
  entity := 'bdquo'::text; coding := E'\u201E'::character; RETURN NEXT;
  entity := 'beta'::text; coding := E'\u03B2'::character; RETURN NEXT;
  entity := 'brvbar'::text; coding := E'\u00A6'::character; RETURN NEXT;
  entity := 'bull'::text; coding := E'\u2022'::character; RETURN NEXT;
  entity := 'cap'::text; coding := E'\u2229'::character; RETURN NEXT;
  entity := 'ccedil'::text; coding := E'\u00E7'::character; RETURN NEXT;
  entity := 'cedil'::text; coding := E'\u00B8'::character; RETURN NEXT;
  entity := 'cent'::text; coding := E'\u00A2'::character; RETURN NEXT;
  entity := 'chi'::text; coding := E'\u03C7'::character; RETURN NEXT;
  entity := 'circ'::text; coding := E'\u02C6'::character; RETURN NEXT;
  entity := 'clubs'::text; coding := E'\u2663'::character; RETURN NEXT;
  entity := 'cong'::text; coding := E'\u2245'::character; RETURN NEXT;
  entity := 'copy'::text; coding := E'\u00A9'::character; RETURN NEXT;
  entity := 'crarr'::text; coding := E'\u21B5'::character; RETURN NEXT;
  entity := 'cup'::text; coding := E'\u222A'::character; RETURN NEXT;
  entity := 'curren'::text; coding := E'\u00A4'::character; RETURN NEXT;
  entity := 'dArr'::text; coding := E'\u21D3'::character; RETURN NEXT;
  entity := 'dagger'::text; coding := E'\u2020'::character; RETURN NEXT;
  entity := 'darr'::text; coding := E'\u2193'::character; RETURN NEXT;
  entity := 'deg'::text; coding := E'\u00B0'::character; RETURN NEXT;
  entity := 'delta'::text; coding := E'\u03B4'::character; RETURN NEXT;
  entity := 'diams'::text; coding := E'\u2666'::character; RETURN NEXT;
  entity := 'divide'::text; coding := E'\u00F7'::character; RETURN NEXT;
  entity := 'eacute'::text; coding := E'\u00E9'::character; RETURN NEXT;
  entity := 'ecirc'::text; coding := E'\u00EA'::character; RETURN NEXT;
  entity := 'egrave'::text; coding := E'\u00E8'::character; RETURN NEXT;
  entity := 'empty'::text; coding := E'\u2205'::character; RETURN NEXT;
  entity := 'emsp'::text; coding := E'\u2003'::character; RETURN NEXT;
  entity := 'ensp'::text; coding := E'\u2002'::character; RETURN NEXT;
  entity := 'epsilon'::text; coding := E'\u03B5'::character; RETURN NEXT;
  entity := 'equiv'::text; coding := E'\u2261'::character; RETURN NEXT;
  entity := 'eta'::text; coding := E'\u03B7'::character; RETURN NEXT;
  entity := 'eth'::text; coding := E'\u00F0'::character; RETURN NEXT;
  entity := 'euml'::text; coding := E'\u00EB'::character; RETURN NEXT;
  entity := 'euro'::text; coding := E'\u20AC'::character; RETURN NEXT;
  entity := 'exist'::text; coding := E'\u2203'::character; RETURN NEXT;
  entity := 'fnof'::text; coding := E'\u0192'::character; RETURN NEXT;
  entity := 'forall'::text; coding := E'\u2200'::character; RETURN NEXT;
  entity := 'frac12'::text; coding := E'\u00BD'::character; RETURN NEXT;
  entity := 'frac14'::text; coding := E'\u00BC'::character; RETURN NEXT;
  entity := 'frac34'::text; coding := E'\u00BE'::character; RETURN NEXT;
  entity := 'frasl'::text; coding := E'\u2044'::character; RETURN NEXT;
  entity := 'gamma'::text; coding := E'\u03B3'::character; RETURN NEXT;
  entity := 'ge'::text; coding := E'\u2265'::character; RETURN NEXT;
  entity := 'gt'::text; coding := E'\u003E'::character; RETURN NEXT;
  entity := 'hArr'::text; coding := E'\u21D4'::character; RETURN NEXT;
  entity := 'harr'::text; coding := E'\u2194'::character; RETURN NEXT;
  entity := 'hearts'::text; coding := E'\u2665'::character; RETURN NEXT;
  entity := 'hellip'::text; coding := E'\u2026'::character; RETURN NEXT;
  entity := 'iacute'::text; coding := E'\u00ED'::character; RETURN NEXT;
  entity := 'icirc'::text; coding := E'\u00EE'::character; RETURN NEXT;
  entity := 'iexcl'::text; coding := E'\u00A1'::character; RETURN NEXT;
  entity := 'igrave'::text; coding := E'\u00EC'::character; RETURN NEXT;
  entity := 'image'::text; coding := E'\u2111'::character; RETURN NEXT;
  entity := 'infin'::text; coding := E'\u221E'::character; RETURN NEXT;
  entity := 'int'::text; coding := E'\u222B'::character; RETURN NEXT;
  entity := 'iota'::text; coding := E'\u03B9'::character; RETURN NEXT;
  entity := 'iquest'::text; coding := E'\u00BF'::character; RETURN NEXT;
  entity := 'isin'::text; coding := E'\u2208'::character; RETURN NEXT;
  entity := 'iuml'::text; coding := E'\u00EF'::character; RETURN NEXT;
  entity := 'kappa'::text; coding := E'\u03BA'::character; RETURN NEXT;
  entity := 'lArr'::text; coding := E'\u21D0'::character; RETURN NEXT;
  entity := 'lambda'::text; coding := E'\u03BB'::character; RETURN NEXT;
  entity := 'lang'::text; coding := E'\u2329'::character; RETURN NEXT;
  entity := 'laquo'::text; coding := E'\u00AB'::character; RETURN NEXT;
  entity := 'larr'::text; coding := E'\u2190'::character; RETURN NEXT;
  entity := 'lceil'::text; coding := E'\u2308'::character; RETURN NEXT;
  entity := 'ldquo'::text; coding := E'\u201C'::character; RETURN NEXT;
  entity := 'le'::text; coding := E'\u2264'::character; RETURN NEXT;
  entity := 'lfloor'::text; coding := E'\u230A'::character; RETURN NEXT;
  entity := 'lowast'::text; coding := E'\u2217'::character; RETURN NEXT;
  entity := 'loz'::text; coding := E'\u25CA'::character; RETURN NEXT;
  entity := 'lrm'::text; coding := E'\u200E'::character; RETURN NEXT;
  entity := 'lsaquo'::text; coding := E'\u2039'::character; RETURN NEXT;
  entity := 'lsquo'::text; coding := E'\u2018'::character; RETURN NEXT;
  entity := 'lt'::text; coding := E'\u003C'::character; RETURN NEXT;
  entity := 'macr'::text; coding := E'\u00AF'::character; RETURN NEXT;
  entity := 'mdash'::text; coding := E'\u2014'::character; RETURN NEXT;
  entity := 'micro'::text; coding := E'\u00B5'::character; RETURN NEXT;
  entity := 'middot'::text; coding := E'\u00B7'::character; RETURN NEXT;
  entity := 'minus'::text; coding := E'\u2212'::character; RETURN NEXT;
  entity := 'mu'::text; coding := E'\u03BC'::character; RETURN NEXT;
  entity := 'nabla'::text; coding := E'\u2207'::character; RETURN NEXT;
  entity := 'nbsp'::text; coding := E'\u00A0'::character; RETURN NEXT;
  entity := 'ndash'::text; coding := E'\u2013'::character; RETURN NEXT;
  entity := 'ne'::text; coding := E'\u2260'::character; RETURN NEXT;
  entity := 'ni'::text; coding := E'\u220B'::character; RETURN NEXT;
  entity := 'not'::text; coding := E'\u00AC'::character; RETURN NEXT;
  entity := 'notin'::text; coding := E'\u2209'::character; RETURN NEXT;
  entity := 'nsub'::text; coding := E'\u2284'::character; RETURN NEXT;
  entity := 'ntilde'::text; coding := E'\u00F1'::character; RETURN NEXT;
  entity := 'nu'::text; coding := E'\u03BD'::character; RETURN NEXT;
  entity := 'oacute'::text; coding := E'\u00F3'::character; RETURN NEXT;
  entity := 'ocirc'::text; coding := E'\u00F4'::character; RETURN NEXT;
  entity := 'oelig'::text; coding := E'\u0153'::character; RETURN NEXT;
  entity := 'ograve'::text; coding := E'\u00F2'::character; RETURN NEXT;
  entity := 'oline'::text; coding := E'\u203E'::character; RETURN NEXT;
  entity := 'omega'::text; coding := E'\u03C9'::character; RETURN NEXT;
  entity := 'omicron'::text; coding := E'\u03BF'::character; RETURN NEXT;
  entity := 'oplus'::text; coding := E'\u2295'::character; RETURN NEXT;
  entity := 'or'::text; coding := E'\u2228'::character; RETURN NEXT;
  entity := 'ordf'::text; coding := E'\u00AA'::character; RETURN NEXT;
  entity := 'ordm'::text; coding := E'\u00BA'::character; RETURN NEXT;
  entity := 'oslash'::text; coding := E'\u00F8'::character; RETURN NEXT;
  entity := 'otilde'::text; coding := E'\u00F5'::character; RETURN NEXT;
  entity := 'otimes'::text; coding := E'\u2297'::character; RETURN NEXT;
  entity := 'ouml'::text; coding := E'\u00F6'::character; RETURN NEXT;
  entity := 'para'::text; coding := E'\u00B6'::character; RETURN NEXT;
  entity := 'part'::text; coding := E'\u2202'::character; RETURN NEXT;
  entity := 'permil'::text; coding := E'\u2030'::character; RETURN NEXT;
  entity := 'perp'::text; coding := E'\u22A5'::character; RETURN NEXT;
  entity := 'phi'::text; coding := E'\u03C6'::character; RETURN NEXT;
  entity := 'pi'::text; coding := E'\u03C0'::character; RETURN NEXT;
  entity := 'piv'::text; coding := E'\u03D6'::character; RETURN NEXT;
  entity := 'plusmn'::text; coding := E'\u00B1'::character; RETURN NEXT;
  entity := 'pound'::text; coding := E'\u00A3'::character; RETURN NEXT;
  entity := 'prime'::text; coding := E'\u2032'::character; RETURN NEXT;
  entity := 'prod'::text; coding := E'\u220F'::character; RETURN NEXT;
  entity := 'prop'::text; coding := E'\u221D'::character; RETURN NEXT;
  entity := 'psi'::text; coding := E'\u03C8'::character; RETURN NEXT;
  entity := 'quot'::text; coding := E'\u0022'::character; RETURN NEXT;
  entity := 'rArr'::text; coding := E'\u21D2'::character; RETURN NEXT;
  entity := 'radic'::text; coding := E'\u221A'::character; RETURN NEXT;
  entity := 'rang'::text; coding := E'\u232A'::character; RETURN NEXT;
  entity := 'raquo'::text; coding := E'\u00BB'::character; RETURN NEXT;
  entity := 'rarr'::text; coding := E'\u2192'::character; RETURN NEXT;
  entity := 'rceil'::text; coding := E'\u2309'::character; RETURN NEXT;
  entity := 'rdquo'::text; coding := E'\u201D'::character; RETURN NEXT;
  entity := 'real'::text; coding := E'\u211C'::character; RETURN NEXT;
  entity := 'reg'::text; coding := E'\u00AE'::character; RETURN NEXT;
  entity := 'rfloor'::text; coding := E'\u230B'::character; RETURN NEXT;
  entity := 'rho'::text; coding := E'\u03C1'::character; RETURN NEXT;
  entity := 'rlm'::text; coding := E'\u200F'::character; RETURN NEXT;
  entity := 'rsaquo'::text; coding := E'\u203A'::character; RETURN NEXT;
  entity := 'rsquo'::text; coding := E'\u2019'::character; RETURN NEXT;
  entity := 'sbquo'::text; coding := E'\u201A'::character; RETURN NEXT;
  entity := 'scaron'::text; coding := E'\u0161'::character; RETURN NEXT;
  entity := 'sdot'::text; coding := E'\u22C5'::character; RETURN NEXT;
  entity := 'sect'::text; coding := E'\u00A7'::character; RETURN NEXT;
  entity := 'shy'::text; coding := E'\u00AD'::character; RETURN NEXT;
  entity := 'sigma'::text; coding := E'\u03C3'::character; RETURN NEXT;
  entity := 'sigmaf'::text; coding := E'\u03C2'::character; RETURN NEXT;
  entity := 'sim'::text; coding := E'\u223C'::character; RETURN NEXT;
  entity := 'spades'::text; coding := E'\u2660'::character; RETURN NEXT;
  entity := 'sub'::text; coding := E'\u2282'::character; RETURN NEXT;
  entity := 'sube'::text; coding := E'\u2286'::character; RETURN NEXT;
  entity := 'sum'::text; coding := E'\u2211'::character; RETURN NEXT;
  entity := 'sup'::text; coding := E'\u2283'::character; RETURN NEXT;
  entity := 'sup1'::text; coding := E'\u00B9'::character; RETURN NEXT;
  entity := 'sup2'::text; coding := E'\u00B2'::character; RETURN NEXT;
  entity := 'sup3'::text; coding := E'\u00B3'::character; RETURN NEXT;
  entity := 'supe'::text; coding := E'\u2287'::character; RETURN NEXT;
  entity := 'szlig'::text; coding := E'\u00DF'::character; RETURN NEXT;
  entity := 'tau'::text; coding := E'\u03C4'::character; RETURN NEXT;
  entity := 'there4'::text; coding := E'\u2234'::character; RETURN NEXT;
  entity := 'theta'::text; coding := E'\u03B8'::character; RETURN NEXT;
  entity := 'thetasym'::text; coding := E'\u03D1'::character; RETURN NEXT;
  entity := 'thinsp'::text; coding := E'\u2009'::character; RETURN NEXT;
  entity := 'thorn'::text; coding := E'\u00FE'::character; RETURN NEXT;
  entity := 'tilde'::text; coding := E'\u02DC'::character; RETURN NEXT;
  entity := 'times'::text; coding := E'\u00D7'::character; RETURN NEXT;
  entity := 'trade'::text; coding := E'\u2122'::character; RETURN NEXT;
  entity := 'uArr'::text; coding := E'\u21D1'::character; RETURN NEXT;
  entity := 'uacute'::text; coding := E'\u00FA'::character; RETURN NEXT;
  entity := 'uarr'::text; coding := E'\u2191'::character; RETURN NEXT;
  entity := 'ucirc'::text; coding := E'\u00FB'::character; RETURN NEXT;
  entity := 'ugrave'::text; coding := E'\u00F9'::character; RETURN NEXT;
  entity := 'uml'::text; coding := E'\u00A8'::character; RETURN NEXT;
  entity := 'upsih'::text; coding := E'\u03D2'::character; RETURN NEXT;
  entity := 'upsilon'::text; coding := E'\u03C5'::character; RETURN NEXT;
  entity := 'uuml'::text; coding := E'\u00FC'::character; RETURN NEXT;
  entity := 'weierp'::text; coding := E'\u2118'::character; RETURN NEXT;
  entity := 'xi'::text; coding := E'\u03BE'::character; RETURN NEXT;
  entity := 'yacute'::text; coding := E'\u00FD'::character; RETURN NEXT;
  entity := 'yen'::text; coding := E'\u00A5'::character; RETURN NEXT;
  entity := 'yuml'::text; coding := E'\u00FF'::character; RETURN NEXT;
  entity := 'zeta'::text; coding := E'\u03B6'::character; RETURN NEXT;
  entity := 'zwj'::text; coding := E'\u200D'::character; RETURN NEXT;
  entity := 'zwnj'::text; coding := E'\u200C'::character; RETURN NEXT;
  RETURN;
END;
$$;


ALTER FUNCTION utility.entity_coding() OWNER TO postgres;

--
-- TOC entry 581 (class 1255 OID 17601)
-- Name: enum2array(anyenum); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION enum2array(enum anyenum) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$

begin

  RETURN enum_range(enum)::text[];
end;$$;


ALTER FUNCTION utility.enum2array(enum anyenum) OWNER TO postgres;

--
-- TOC entry 582 (class 1255 OID 17602)
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
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 582
-- Name: FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) IS 'given the name of the schema, table, and column, it returns the maximum value of the column';


--
-- TOC entry 583 (class 1255 OID 17603)
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
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 583
-- Name: FUNCTION set_all_sequences_2_the_max(); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION set_all_sequences_2_the_max() IS 'sets all database sequences to the highest value found in the database';


--
-- TOC entry 568 (class 1255 OID 17604)
-- Name: set_sequence_2_the_max(text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION set_sequence_2_the_max(p_sequence_namespace text, p_sequence_name text) RETURNS TABLE(sequence_namespace name, sequence_name name, sequence_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE
 
BEGIN 

  IF p_sequence_namespace = ''
  OR p_sequence_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: set_sequence_2_the_max(sequence_namespace, sequence_name)';
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
RETURN QUERY SELECT t.sequence_namespace, t.sequence_name, setval(quote_ident(t.sequence_namespace) || '.' || quote_ident(t.sequence_name), max(t.max_value))
  FROM utility.sequence_references t
  WHERE t.sequence_namespace = p_sequence_namespace
    AND t.sequence_name = p_sequence_name
  GROUP BY t.sequence_namespace, t.sequence_name;
END;
$$;


ALTER FUNCTION utility.set_sequence_2_the_max(p_sequence_namespace text, p_sequence_name text) OWNER TO postgres;

--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 568
-- Name: FUNCTION set_sequence_2_the_max(p_sequence_namespace text, p_sequence_name text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION set_sequence_2_the_max(p_sequence_namespace text, p_sequence_name text) IS 'sets the sequences in input to the highest value found in the database';


--
-- TOC entry 575 (class 1255 OID 17605)
-- Name: strip_tags(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION strip_tags(text) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT regexp_replace(regexp_replace($1, E'(?x)<[^>]*?(\s alt \s* = \s* ([\'"]) ([^>]*?) \2) [^>]*? >', E'\3'), E'(?x)(< [^>]*? >)', '', 'g')
$_$;


ALTER FUNCTION utility.strip_tags(text) OWNER TO postgres;

--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 575
-- Name: FUNCTION strip_tags(text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION strip_tags(text) IS 'Strip out the HTML tags from a string';


--
-- TOC entry 584 (class 1255 OID 17606)
-- Name: system_messages_locale(text, text, integer); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION system_messages_locale(p_name_space text, p_function_name text, p_id integer) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
    msg text;
    locale text;
    lng language := 'en';
    cmd text;
    rc integer;
    
BEGIN 
    -- Ã¨ possibile conoscere il lingaggio del sistema con
    -- SHOW lc_message
    -- ed impostarlo con:
    -- SET lc_message = 'xxx'
    -- ovviamente per metterlo in una variabile: SHOW lc_message INTO pippo
    -- un paio di esemi:
    -- it_IT.UTF-8
    -- en_US.UTF-8

    SHOW lc_messages INTO locale;
    locale := LEFT(locale,2);
    
    IF locale = 'it' THEN lng := 'it'; END IF;
    IF locale = 'de' THEN lng := 'de'; END IF;
    IF locale = 'en' THEN lng := 'en'; END IF;

    cmd = 'SELECT description FROM ' || quote_ident(p_name_space) || '.system_messages WHERE function_name = ''' || p_function_name || ''' AND id = ' || p_id::text || ' AND language = ''' || lng || '''';
    EXECUTE cmd INTO msg;
    GET DIAGNOSTICS rc = ROW_COUNT;
    IF rc = 0 THEN
        msg := format('I didn''t find any message for name space: ''%s'', table: ''system_messages'', function: ''%s'' id: ''%s'' language: ''%s''', p_name_space, p_function_name, p_id, lng);
    END IF;

    RETURN msg;
    END;
$$;


ALTER FUNCTION utility.system_messages_locale(p_name_space text, p_function_name text, p_id integer) OWNER TO postgres;

--
-- TOC entry 585 (class 1255 OID 17607)
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
-- TOC entry 586 (class 1255 OID 17608)
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
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 586
-- Name: FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) IS 'The function takes as input the name of a database, a schema, a sequence and a value of itself and looks in all the columns of all tables of all schemas in the database to find the specified value.
The usage scenario is to a database where all the primary key refer to only one sequence, in this case a value of the sequence is unique in the entire database.
So it can be usefull, starting from a value of the sequence, go back to the table to which it was attributed.';


SET search_path = pg_catalog;

--
-- TOC entry 3130 (class 2605 OID 17609)
-- Name: CAST (public.file_extension AS public.mime_type); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.file_extension AS public.mime_type) WITH FUNCTION public.mime_type(public.file_extension) AS IMPLICIT;


--
-- TOC entry 3131 (class 2605 OID 17610)
-- Name: CAST (public.mime_type AS public.file_extension); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (public.mime_type AS public.file_extension) WITH FUNCTION public.file_extension(public.mime_type) AS IMPLICIT;


SET search_path = diagnostic, pg_catalog;

--
-- TOC entry 234 (class 1259 OID 17611)
-- Name: functions_check; Type: VIEW; Schema: diagnostic; Owner: postgres
--

CREATE VIEW functions_check AS
 SELECT ((ss.pcf).functionid)::regprocedure AS function_signature,
    (ss.pcf).lineno AS lineno,
    (ss.pcf).statement AS statement,
    (ss.pcf).sqlstate AS sqlstate,
    (ss.pcf).message AS message,
    (ss.pcf).detail AS detail,
    (ss.pcf).hint AS hint,
    (ss.pcf).level AS level,
    (ss.pcf)."position" AS "position",
    (ss.pcf).query AS query,
    (ss.pcf).context AS context
   FROM ( SELECT public.plpgsql_check_function_tb((pg_proc.oid)::regprocedure, (COALESCE(pg_trigger.tgrelid, (0)::oid))::regclass, true, true, true, true) AS pcf
           FROM (pg_proc
             LEFT JOIN pg_trigger ON ((pg_trigger.tgfoid = pg_proc.oid)))
          WHERE ((pg_proc.prolang = ( SELECT lang.oid
                   FROM pg_language lang
                  WHERE (lang.lanname = 'plpgsql'::name))) AND (pg_proc.pronamespace <> ( SELECT nsp.oid
                   FROM pg_namespace nsp
                  WHERE (nsp.nspname = 'pg_catalog'::name))) AND ((pg_proc.prorettype <> ( SELECT typ.oid
                   FROM pg_type typ
                  WHERE (typ.typname = 'trigger'::name))) OR (pg_trigger.tgfoid IS NOT NULL)))
         OFFSET 0) ss
  ORDER BY (((ss.pcf).functionid)::regprocedure)::text, (ss.pcf).lineno;


ALTER TABLE functions_check OWNER TO postgres;

--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 234
-- Name: VIEW functions_check; Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON VIEW functions_check IS 'Check if functions can be compiled and if not list the related error';


--
-- TOC entry 235 (class 1259 OID 17616)
-- Name: functions_list; Type: VIEW; Schema: diagnostic; Owner: postgres
--

CREATE VIEW functions_list AS
 SELECT n.nspname AS schema_name,
    p.proname AS function_name,
    (p.oid)::regprocedure AS function_signature
   FROM (pg_proc p
     JOIN pg_namespace n ON ((n.oid = p.pronamespace)));


ALTER TABLE functions_list OWNER TO postgres;

--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 235
-- Name: VIEW functions_list; Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON VIEW functions_list IS 'List all the function in all schema';


--
-- TOC entry 236 (class 1259 OID 17621)
-- Name: views_working; Type: VIEW; Schema: diagnostic; Owner: postgres
--

CREATE VIEW views_working AS
 SELECT pg_views.schemaname AS schema_name,
    pg_views.viewname AS view_name,
    if_view_works(((quote_ident((pg_views.schemaname)::text) || '.'::text) || quote_ident((pg_views.viewname)::text))) AS works
   FROM pg_views
  WHERE (pg_views.schemaname <> ALL (ARRAY['information_schema'::name, 'pg_catalog'::name]));


ALTER TABLE views_working OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 237 (class 1259 OID 17625)
-- Name: absences_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_certified_grp AS
 SELECT cs.classroom,
    a.teacher,
    count(1) AS absences_certified
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, a.teacher;


ALTER TABLE absences_certified_grp OWNER TO postgres;

--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 237
-- Name: VIEW absences_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_certified_grp IS 'groups the absences certified by date, teacher, class';


--
-- TOC entry 238 (class 1259 OID 17629)
-- Name: absences_certified_grp_mat; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW absences_certified_grp_mat AS
 SELECT cs.classroom,
    a.teacher,
    count(1) AS absences_certified
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, a.teacher
  WITH NO DATA;


ALTER TABLE absences_certified_grp_mat OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17633)
-- Name: explanations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE explanations (
    explanation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint NOT NULL,
    description character varying(2048) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    created_by bigint NOT NULL,
    registered_on timestamp without time zone,
    registered_by bigint,
    from_time date,
    to_time date,
    coming_at time without time zone,
    leaving_at time without time zone,
    type explanation_type,
    CONSTRAINT explanations_ck_leaving_at CHECK ((leaving_at > coming_at)),
    CONSTRAINT explanations_ck_registered_on CHECK ((registered_on >= created_on)),
    CONSTRAINT explanations_ck_to_time CHECK ((to_time >= from_time))
);


ALTER TABLE explanations OWNER TO postgres;

--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE explanations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE explanations IS 'contiene le explanations per absences, delays e leavings.
PuÃ² essere fatta from_time un addetto scolastico che compilerÃ  la description o from_time un esercenta la patria potestÃ ';


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.created_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.created_by IS 'La person, addetto scolastico, family o l''student stesso, se maggiorenne, che ha inserito la explanation';


--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.registered_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.registered_on IS 'Data ed at_time in cui la explanation Ã¨ stata usata (Ã¨ stata cioÃ¨ associata ad un''absence)';


--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.registered_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.registered_by IS 'L''addetto scolastico che ha usato la explanation (l''ha associata ad un''absence)';


--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.from_time IS 'on_date di begin_on della explanation (per i delay e le leavings coincide person al)';


--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.to_time IS 'on_date di end_on explanation (per i delay e le leavings coincide person from_time)';


--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.coming_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.coming_at IS 'at_time di coming_atta (delay)';


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN explanations.leaving_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.leaving_at IS 'Ora di leaving';


--
-- TOC entry 240 (class 1259 OID 17643)
-- Name: absences_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_ex AS
 SELECT cs.classroom,
    a.on_date,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code,
    g.description AS explanation_description,
    g.created_on AS explanation_created_on,
    pcre.surname AS created_by_surname,
    pcre.name AS created_by_name,
    pcre.thumbnail AS created_by_thumbnail,
    g.registered_on AS explanation_registered_on,
    preg.surname AS registered_on_surname,
    preg.name AS registered_on_name,
    preg.thumbnail AS registered_on_thumbnail
   FROM (((((((absences a
     JOIN classrooms_students cs ON ((cs.classroom_student = a.classroom_student)))
     JOIN classrooms c ON ((c.classroom = cs.classroom)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons doc ON ((a.teacher = doc.person)))
     LEFT JOIN explanations g ON ((g.explanation = a.explanation)))
     LEFT JOIN persons pcre ON ((pcre.person = g.created_by)))
     LEFT JOIN persons preg ON ((preg.person = g.registered_by)));


ALTER TABLE absences_ex OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17648)
-- Name: absences_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, a.on_date) AS month,
            count(1) AS absences
           FROM (absences a
             JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, a.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.absences, (0)::bigint) AS absences
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE absences_month_grp OWNER TO postgres;

--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 241
-- Name: VIEW absences_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_month_grp IS 'Raggruppa le absences per classroom (e quindi per anno scolastico) e month
viene usata una crossjoin per creare la lista di tutte le classrooms person tutti i mesi a zero per unirli person le absences della tabella lo scopo e di avere le absences di ttti i mesi dell''anno. anche quelli a zero. che altrimenti, interrogando la sola tabelle delle absences, non ci sarebbero';


--
-- TOC entry 242 (class 1259 OID 17653)
-- Name: delays_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, d.on_date) AS month,
            count(1) AS delays
           FROM (delays d
             JOIN classrooms_students cs ON ((d.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, d.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.delays, (0)::bigint) AS delays
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE delays_month_grp OWNER TO postgres;

--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 242
-- Name: VIEW delays_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_month_grp IS 'Raggruppa i delays per classroom (e quindi per anno scolastico) e month
viene usata una crossjoin per creare la lista di tutte le classrooms person tutti i mesi a zero per unirli person i delays della tabell, lo scopo e di avere i delays di ttti i mesi dell''anno. anche quelli a zero. che altrimenti, interrogando la sola tabelle dei delays, non ci sarebbero';


--
-- TOC entry 243 (class 1259 OID 17658)
-- Name: leavings_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, l.on_date) AS month,
            count(1) AS leavings
           FROM (leavings l
             JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, l.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.leavings, (0)::bigint) AS leavings
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE leavings_month_grp OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17663)
-- Name: notes_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_month_grp AS
 WITH cmg AS (
         SELECT notes.classroom,
            date_part('month'::text, notes.on_date) AS month,
            count(1) AS notes
           FROM notes
          GROUP BY notes.classroom, (date_part('month'::text, notes.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.notes, (0)::bigint) AS notes
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE notes_month_grp OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17668)
-- Name: out_of_classrooms_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, ooc.on_date) AS month,
            count(1) AS out_of_classrooms
           FROM (out_of_classrooms ooc
             JOIN classrooms_students cs ON ((ooc.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, ooc.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.out_of_classrooms, (0)::bigint) AS out_of_classrooms
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE out_of_classrooms_month_grp OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17673)
-- Name: classbooks_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classbooks_month_grp AS
 SELECT 'absences'::text AS evento,
    absences_month_grp.classroom,
    absences_month_grp.month,
    absences_month_grp.absences AS numero
   FROM absences_month_grp
UNION ALL
 SELECT 'delays'::text AS evento,
    delays_month_grp.classroom,
    delays_month_grp.month,
    delays_month_grp.delays AS numero
   FROM delays_month_grp
UNION ALL
 SELECT 'leavings'::text AS evento,
    leavings_month_grp.classroom,
    leavings_month_grp.month,
    leavings_month_grp.leavings AS numero
   FROM leavings_month_grp
UNION ALL
 SELECT 'fuori classrooms'::text AS evento,
    out_of_classrooms_month_grp.classroom,
    out_of_classrooms_month_grp.month,
    out_of_classrooms_month_grp.out_of_classrooms AS numero
   FROM out_of_classrooms_month_grp
UNION ALL
 SELECT 'notes'::text AS evento,
    notes_month_grp.classroom,
    notes_month_grp.month,
    notes_month_grp.notes AS numero
   FROM notes_month_grp;


ALTER TABLE classbooks_month_grp OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17677)
-- Name: persons_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons_addresses (
    person_address bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    address_type address_type NOT NULL,
    street character varying(160) NOT NULL,
    zip_code character varying(15) NOT NULL,
    city character(4) NOT NULL
);


ALTER TABLE persons_addresses OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17681)
-- Name: classrooms_students_addresses_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_students_addresses_ex AS
 SELECT ca.classroom,
    ca.student,
    p.name,
    p.surname,
    p.tax_code,
    p.sex,
    p.born,
    cn.description AS city_of_birth,
    pi.street,
    pi.zip_code,
    ci.description AS city,
    ci.district AS province,
    COALESCE(agrp.absences, (0)::bigint) AS absences
   FROM (((((classrooms_students ca
     JOIN persons p ON ((p.person = ca.student)))
     JOIN persons_addresses pi ON ((pi.person = p.person)))
     LEFT JOIN cities cn ON ((cn.city = p.city_of_birth)))
     LEFT JOIN cities ci ON ((ci.city = pi.city)))
     LEFT JOIN absences_grp agrp ON ((agrp.student = ca.student)))
  WHERE (p.school = ANY (schools_enabled()));


ALTER TABLE classrooms_students_addresses_ex OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17686)
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lessons (
    lesson bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    on_date date NOT NULL,
    subject bigint NOT NULL,
    teacher bigint NOT NULL,
    description character varying(2048) NOT NULL,
    substitute boolean DEFAULT false NOT NULL,
    from_time time without time zone NOT NULL,
    to_time time without time zone NOT NULL,
    assignment character varying(2048),
    period tsrange,
    CONSTRAINT lessons_ck_to_time CHECK ((to_time > from_time))
);


ALTER TABLE lessons OWNER TO postgres;

--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN lessons.substitute; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.substitute IS 'Indica se la lesson Ã¨ di substitute cioÃ¨ tenuta from_time un insegnante non titolare della cattedra';


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN lessons.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.from_time IS 'begin_on della lesson';


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN lessons.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.to_time IS 'end_on della lesson';


--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN lessons.assignment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.assignment IS 'assignment assegnati durante la lesson';


--
-- TOC entry 250 (class 1259 OID 17695)
-- Name: classrooms_teachers; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers AS
 SELECT DISTINCT lessons.classroom,
    lessons.teacher
   FROM lessons
UNION
 SELECT DISTINCT valutations.classroom,
    valutations.teacher
   FROM valutations;


ALTER TABLE classrooms_teachers OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17699)
-- Name: delays_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_certified_grp AS
 SELECT cs.classroom,
    d.teacher,
    count(1) AS delays_certified
   FROM (delays d
     JOIN classrooms_students cs ON ((d.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, d.teacher;


ALTER TABLE delays_certified_grp OWNER TO postgres;

--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 251
-- Name: VIEW delays_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_certified_grp IS 'raggruppa i delays certified from_time ogni teacher per ogni classroom';


--
-- TOC entry 252 (class 1259 OID 17703)
-- Name: leavings_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_certified_grp AS
 SELECT cs.classroom,
    l.teacher,
    count(1) AS leavings_certified
   FROM (leavings l
     JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, l.teacher;


ALTER TABLE leavings_certified_grp OWNER TO postgres;

--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 252
-- Name: VIEW leavings_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_certified_grp IS 'raggruppa le leavings certified from_time ogni teacher per ogni classroom';


--
-- TOC entry 253 (class 1259 OID 17707)
-- Name: lessons_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lessons_grp AS
 SELECT l.classroom,
    l.teacher,
    count(1) AS lessons
   FROM lessons l
  GROUP BY l.classroom, l.teacher;


ALTER TABLE lessons_grp OWNER TO postgres;

--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 253
-- Name: VIEW lessons_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW lessons_grp IS 'raggruppa le lezioi fatti from_time ogni teacher per ogni classroom';


--
-- TOC entry 254 (class 1259 OID 17711)
-- Name: notes_iussed_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_iussed_grp AS
 SELECT notes.classroom,
    notes.teacher,
    count(1) AS notes_iussed
   FROM notes
  GROUP BY notes.classroom, notes.teacher;


ALTER TABLE notes_iussed_grp OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17715)
-- Name: out_of_classrooms_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_certified_grp AS
 SELECT cs.classroom,
    ooc.school_operator,
    count(1) AS out_of_classrooms_certified
   FROM (out_of_classrooms ooc
     JOIN classrooms_students cs ON ((ooc.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, ooc.school_operator;


ALTER TABLE out_of_classrooms_certified_grp OWNER TO postgres;

--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 255
-- Name: VIEW out_of_classrooms_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW out_of_classrooms_certified_grp IS 'raggruppa i fuori classrooms certified from_time ogni addetto scolastico per ogni classroom';


--
-- TOC entry 256 (class 1259 OID 17719)
-- Name: signatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signatures (
    signature bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    teacher bigint NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone
);


ALTER TABLE signatures OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17723)
-- Name: signatures_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW signatures_grp AS
 SELECT f.classroom,
    f.teacher,
    count(1) AS signatures
   FROM signatures f
  GROUP BY f.classroom, f.teacher;


ALTER TABLE signatures_grp OWNER TO postgres;

--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 257
-- Name: VIEW signatures_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW signatures_grp IS 'raggruppa le signatures fatte from_time ogni teachers per ogni classroom';


--
-- TOC entry 258 (class 1259 OID 17727)
-- Name: classrooms_teachers_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers_ex AS
 SELECT cd.classroom,
    cd.teacher,
    p.thumbnail,
    p.tax_code,
    p.surname,
    p.name,
    p.sex,
    p.born,
    co.description AS city_of_birth_description,
    COALESCE(lgrp.lessons, (0)::bigint) AS lessons,
    COALESCE(fgrp.signatures, (0)::bigint) AS signatures,
    COALESCE(acgrp.absences_certified, (0)::bigint) AS absences_certified,
    COALESCE(rcgrp.delays_certified, (0)::bigint) AS delays_certified,
    COALESCE(ucgrp.leavings_certified, (0)::bigint) AS leavings_certified,
    COALESCE(fccgrp.out_of_classrooms_certified, (0)::bigint) AS out_of_classroom_certified,
    COALESCE(negrp.notes_iussed, (0)::bigint) AS notes_iussed
   FROM (((((((((classrooms_teachers cd
     JOIN persons p ON ((p.person = cd.teacher)))
     LEFT JOIN lessons_grp lgrp ON (((lgrp.classroom = cd.classroom) AND (lgrp.teacher = cd.teacher))))
     LEFT JOIN cities co ON ((co.city = p.city_of_birth)))
     LEFT JOIN signatures_grp fgrp ON (((fgrp.classroom = cd.classroom) AND (fgrp.teacher = cd.teacher))))
     LEFT JOIN absences_certified_grp acgrp ON (((acgrp.classroom = cd.classroom) AND (acgrp.teacher = cd.teacher))))
     LEFT JOIN delays_certified_grp rcgrp ON (((rcgrp.classroom = cd.classroom) AND (rcgrp.teacher = cd.teacher))))
     LEFT JOIN leavings_certified_grp ucgrp ON (((ucgrp.classroom = cd.classroom) AND (ucgrp.teacher = cd.teacher))))
     LEFT JOIN out_of_classrooms_certified_grp fccgrp ON (((fccgrp.classroom = cd.classroom) AND (fccgrp.school_operator = cd.teacher))))
     LEFT JOIN notes_iussed_grp negrp ON (((negrp.classroom = cd.classroom) AND (negrp.teacher = cd.teacher))));


ALTER TABLE classrooms_teachers_ex OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17732)
-- Name: classrooms_teachers_subject; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers_subject AS
 SELECT DISTINCT lessons.classroom,
    lessons.teacher,
    lessons.subject
   FROM lessons;


ALTER TABLE classrooms_teachers_subject OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17736)
-- Name: communication_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE communication_types (
    communication_type bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description character varying(160) NOT NULL,
    notificationtion_management boolean DEFAULT false NOT NULL,
    school bigint
);


ALTER TABLE communication_types OWNER TO postgres;

--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE communication_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE communication_types IS 'Indica i tipi di citiescazioni gestiti from_time singolo school e l''eventuale gestione della notification che viene tenuta distinta from_time school a school perchÃ¨ potrebbe avere costi aggiuntivi che non tutti gli schools vogliono';


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN communication_types.notificationtion_management; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communication_types.notificationtion_management IS 'indica se quel type di citiescazione gestisce le notifiche';


--
-- TOC entry 261 (class 1259 OID 17741)
-- Name: communications_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE communications_media (
    communication_media bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    communication_type bigint NOT NULL,
    description character varying(160),
    uri character varying(255) NOT NULL,
    notification boolean DEFAULT false NOT NULL
);


ALTER TABLE communications_media OWNER TO postgres;

--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 261
-- Name: COLUMN communications_media.notification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.notification IS 'Indica se usare questo mezzo di citiescazione nelle notifiche, ovstreetmente solo se il type di citiescazione lo permette';


--
-- TOC entry 262 (class 1259 OID 17746)
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversations (
    conversation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_record bigint NOT NULL,
    subject character varying(160) NOT NULL,
    confidential boolean DEFAULT false NOT NULL,
    begin_on timestamp without time zone DEFAULT now(),
    end_on timestamp without time zone,
    CONSTRAINT conversations_ck_end_on CHECK ((end_on >= begin_on))
);


ALTER TABLE conversations OWNER TO postgres;

--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN conversations.school_record; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.school_record IS 'Riferimento alla tabella classrooms_students';


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN conversations.confidential; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.confidential IS 'Indica che la conversation puÃ² essere visualizzata solo dai partecipante e non, come Ã¨ norma, anche dagli addetti scolastici.
Inoltre non viene inclusa nella stampa del school_record personle.';


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 262
-- Name: COLUMN conversations.end_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.end_on IS 'quando una conversation Ã¨ terminta non + piÃ¹ possibile aggiungere o modificare messages';


SET default_with_oids = false;

--
-- TOC entry 263 (class 1259 OID 17753)
-- Name: conversations_invites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversations_invites (
    conversation_invite bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversation bigint NOT NULL,
    invited bigint NOT NULL
);


ALTER TABLE conversations_invites OWNER TO postgres;

--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE conversations_invites; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE conversations_invites IS 'definisce gli invitati ad una conversation cioÃ¨ le persons abilitate a vedere e/o partecipare ad una determinata conversation';


SET default_with_oids = true;

--
-- TOC entry 264 (class 1259 OID 17757)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE countries (
    country smallint NOT NULL,
    description character varying(160) NOT NULL,
    existing boolean DEFAULT true NOT NULL
);


ALTER TABLE countries OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17761)
-- Name: degrees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE degrees (
    degree bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL,
    course_years course_year NOT NULL
);


ALTER TABLE degrees OWNER TO postgres;

--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 265
-- Name: COLUMN degrees.course_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN degrees.course_years IS 'anni del corso ad example:
5 per le primarie
3 per le secondarie di primo grado
5 per le secondarie di secondo grado';


--
-- TOC entry 266 (class 1259 OID 17765)
-- Name: delays_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_ex AS
 SELECT cs.classroom,
    r.on_date,
    r.at_time,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code,
    g.description AS explanation_description,
    g.created_on AS explanation_created_on,
    pcre.surname AS created_by_surname,
    pcre.name AS created_by_name,
    pcre.thumbnail AS created_by_thumbnail,
    g.registered_on AS explanation_registered_on,
    preg.surname AS registered_on_surname,
    preg.name AS registered_on_name,
    preg.thumbnail AS registered_on_thumbnail
   FROM ((((((delays r
     JOIN classrooms_students cs ON ((r.classroom_student = cs.classroom_student)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons doc ON ((r.teacher = doc.person)))
     LEFT JOIN explanations g ON ((g.explanation = r.explanation)))
     LEFT JOIN persons pcre ON ((pcre.person = g.created_by)))
     LEFT JOIN persons preg ON ((preg.person = g.registered_by)));


ALTER TABLE delays_ex OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17770)
-- Name: districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE districts (
    district character(2) NOT NULL,
    description character varying(160) NOT NULL,
    region smallint
);


ALTER TABLE districts OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17773)
-- Name: faults; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE faults (
    fault bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint NOT NULL,
    description character varying(2048) NOT NULL,
    lesson bigint NOT NULL,
    note bigint
);


ALTER TABLE faults OWNER TO postgres;

--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE faults; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE faults IS 'Rileva le faults di un student';


--
-- TOC entry 269 (class 1259 OID 17780)
-- Name: faults_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW faults_grp AS
 SELECT l.classroom,
    m.student,
    count(1) AS faults
   FROM (faults m
     JOIN lessons l ON ((l.lesson = m.lesson)))
  GROUP BY l.classroom, m.student;


ALTER TABLE faults_grp OWNER TO postgres;

--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 269
-- Name: VIEW faults_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW faults_grp IS 'Raggruppa le faults per classroom (e quindi per anno scolastico) e student';


--
-- TOC entry 270 (class 1259 OID 17784)
-- Name: grade_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grade_types (
    grade_type bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description character varying(60) NOT NULL,
    subject bigint NOT NULL,
    mnemonic character varying(3)
);


ALTER TABLE grade_types OWNER TO postgres;

--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE grade_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE grade_types IS 'The marks has to been grouped by mark type.
Example: `Oral` or `Written` ';


--
-- TOC entry 271 (class 1259 OID 17788)
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grades (
    grade bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    metric bigint NOT NULL,
    description character varying(160) NOT NULL,
    thousandths smallint NOT NULL,
    mnemonic character varying(3) NOT NULL
);


ALTER TABLE grades OWNER TO postgres;

--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE grades; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE grades IS 'For each metric here we have the possible grades';


SET default_with_oids = false;

--
-- TOC entry 272 (class 1259 OID 17792)
-- Name: grading_meetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grading_meetings (
    grading_meeting bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_year bigint,
    on_date date,
    description character varying(60) NOT NULL,
    close boolean DEFAULT false NOT NULL
);


ALTER TABLE grading_meetings OWNER TO postgres;

--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN grading_meetings.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.on_date IS 'Data dello grading_meeting';


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN grading_meetings.close; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.close IS 'Indica che lo grading_meeting Ã¨ close e non si possono piÃ¹ fare modifiche';


--
-- TOC entry 273 (class 1259 OID 17797)
-- Name: grading_meetings_valutations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grading_meetings_valutations (
    grading_meeting_valutation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    grading_meeting bigint NOT NULL,
    classroom bigint NOT NULL,
    student bigint NOT NULL,
    subject bigint NOT NULL,
    grade bigint NOT NULL,
    notes character varying(2048),
    lack_of_training boolean DEFAULT false NOT NULL,
    council_vote boolean DEFAULT false,
    teacher bigint,
    CONSTRAINT grading_meetings_valutations_ck_grade_consiglio CHECK ((((teacher IS NOT NULL) AND (council_vote IS NULL)) OR ((teacher IS NULL) AND (council_vote IS NOT NULL))))
);


ALTER TABLE grading_meetings_valutations OWNER TO postgres;

--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN grading_meetings_valutations.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.grade IS 'Se il teacher Ã¨ nullo indica il grade di grading_meeting altrimenti il grade proposto from_time teacher';


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN grading_meetings_valutations.lack_of_training; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.lack_of_training IS 'indica se l''student ha dimostrato di avere carenze formative';


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN grading_meetings_valutations.council_vote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.council_vote IS 'Indica che il grade Ã¨ stato deciso from_time consiglio di classroom in difformitÃ  a quanto proposto from_time teacher se il teacher Ã¨ indicato _(quindi la riga del db indica una proposta di grade deve essere nullo)';


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN grading_meetings_valutations.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.teacher IS 'se nullo indica il grade dello grading_meeting altrimenti indica il teacher proponente il grade';


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 273
-- Name: CONSTRAINT grading_meetings_valutations_ck_grade_consiglio ON grading_meetings_valutations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT grading_meetings_valutations_ck_grade_consiglio ON grading_meetings_valutations IS 'Se Ã¨ indicato il teacher (proposta di grade) allat_time il flag ''council_vote'' non deve essere indicato perchÃ¨ Ã¨ valido solo per il grade di grading_meeting e viceversa';


SET default_with_oids = true;

--
-- TOC entry 274 (class 1259 OID 17807)
-- Name: grading_meetings_valutations_qua; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grading_meetings_valutations_qua (
    grading_meeting_valutation_qua bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    grading_meeting_valutation bigint NOT NULL,
    qualification bigint NOT NULL,
    grade bigint NOT NULL,
    notes character varying(2048)
);


ALTER TABLE grading_meetings_valutations_qua OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17814)
-- Name: holydays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE holydays (
    holiday bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    on_date date NOT NULL,
    description character varying(160)
);


ALTER TABLE holydays OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17818)
-- Name: leavings_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_ex AS
 SELECT cs.classroom,
    u.on_date,
    u.at_time,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code,
    g.description AS explanation_description,
    g.created_on AS explanation_created_on,
    pcre.surname AS created_by_surname,
    pcre.name AS created_by_name,
    pcre.thumbnail AS created_by_thumbnail,
    g.registered_on AS explanation_registered_on,
    preg.surname AS registered_on_surname,
    preg.name AS registered_on_name,
    preg.thumbnail AS registered_on_thumbnail
   FROM ((((((leavings u
     JOIN classrooms_students cs ON ((u.classroom_student = cs.classroom_student)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons doc ON ((u.teacher = doc.person)))
     LEFT JOIN explanations g ON ((g.explanation = u.explanation)))
     LEFT JOIN persons pcre ON ((pcre.person = g.created_by)))
     LEFT JOIN persons preg ON ((preg.person = g.registered_by)));


ALTER TABLE leavings_ex OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17823)
-- Name: lessons_days; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lessons_days AS
 SELECT DISTINCT l.classroom,
    l.on_date
   FROM lessons l;


ALTER TABLE lessons_days OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17827)
-- Name: lessons_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lessons_ex AS
 SELECT l.classroom,
    l.on_date,
    l.from_time,
    l.to_time,
    p.surname,
    p.name,
    p.tax_code,
    p.thumbnail,
    l.description AS lesson_description,
    m.description AS subject_description
   FROM ((lessons l
     JOIN persons p ON ((l.teacher = p.person)))
     LEFT JOIN subjects m ON ((l.subject = m.subject)));


ALTER TABLE lessons_ex OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17832)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE messages (
    message bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversation bigint NOT NULL,
    written_on timestamp without time zone DEFAULT now() NOT NULL,
    message_text character varying(2048) NOT NULL,
    from_time bigint NOT NULL
);


ALTER TABLE messages OWNER TO postgres;

--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 279
-- Name: COLUMN messages.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages.from_time IS 'La person fisica che ha scritto il message';


--
-- TOC entry 280 (class 1259 OID 17840)
-- Name: messages_read; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE messages_read (
    message_read bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    message bigint NOT NULL,
    person bigint NOT NULL,
    read_on timestamp without time zone
);


ALTER TABLE messages_read OWNER TO postgres;

--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 280
-- Name: COLUMN messages_read.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages_read.person IS 'Naturto_time person che ha letto il message';


--
-- TOC entry 281 (class 1259 OID 17844)
-- Name: metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metrics (
    metric bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint,
    description character varying(160) NOT NULL,
    sufficiency smallint DEFAULT 600 NOT NULL
);


ALTER TABLE metrics OWNER TO postgres;

--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 281
-- Name: COLUMN metrics.sufficiency; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metrics.sufficiency IS 'indica i thousandths from_time raggiungere per ottenere la sufficiency';


--
-- TOC entry 282 (class 1259 OID 17849)
-- Name: notes_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_ex AS
 SELECT n.classroom,
    n.on_date,
    n.at_time,
    n.note,
    n.description,
    n.disciplinary,
    n.to_approve,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code
   FROM ((notes n
     JOIN persons doc ON ((n.teacher = doc.person)))
     LEFT JOIN persons alu ON ((n.student = alu.person)));


ALTER TABLE notes_ex OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 283 (class 1259 OID 17854)
-- Name: notes_signed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notes_signed (
    note_signed bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    on_date timestamp without time zone,
    note bigint NOT NULL
);


ALTER TABLE notes_signed OWNER TO postgres;

--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN notes_signed.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed.person IS 'person che deve vistare la note: i parenti dell''student che nella colonna visto della tabella persons_parenti hanno il valore true';


--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN notes_signed.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed.on_date IS 'date e at_time in cui la note Ã¨ stata vista from_timela person';


--
-- TOC entry 284 (class 1259 OID 17858)
-- Name: notes_signed_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_signed_ex AS
 SELECT n.note,
    v.on_date AS visto_il,
    per.surname AS visto_surname,
    per.name AS visto_name,
    per.thumbnail AS visto_thumbnail,
    per.tax_code AS visto_tax_code
   FROM ((notes n
     LEFT JOIN notes_signed v ON ((v.note = n.note)))
     LEFT JOIN persons per ON ((v.person = per.person)));


ALTER TABLE notes_signed_ex OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17863)
-- Name: out_of_classrooms_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_ex AS
 SELECT cs.classroom,
    ooc.on_date,
    ooc.from_time,
    ooc.to_time,
    ooc.description,
    adsco.thumbnail AS school_operator_thumbnail,
    adsco.surname AS school_operator_surname,
    adsco.name AS school_operator_name,
    adsco.tax_code AS school_operator_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code
   FROM (((out_of_classrooms ooc
     JOIN classrooms_students cs ON ((ooc.classroom_student = cs.classroom_student)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons adsco ON ((ooc.school_operator = adsco.person)));


ALTER TABLE out_of_classrooms_ex OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17868)
-- Name: parents_meetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE parents_meetings (
    interview bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    teacher bigint NOT NULL,
    person bigint,
    on_date timestamp without time zone
);


ALTER TABLE parents_meetings OWNER TO postgres;

--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE parents_meetings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE parents_meetings IS 'in questa tabella sono memorizzati tutti i periodi di disponibilitÃ  per i parents_meetings person gli esercenti la patria ';


--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN parents_meetings.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.teacher IS 'teacher che Ã¨ disponibile nella on_date indicata from_timela colonna il';


--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN parents_meetings.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.person IS 'person person la quale Ã¨ stato prenoteto il interview';


--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 286
-- Name: COLUMN parents_meetings.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.on_date IS 'on_date e at_time in cui il teacher Ã¨ disponibile per un interview';


SET default_with_oids = true;

--
-- TOC entry 287 (class 1259 OID 17872)
-- Name: persons_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons_relations (
    person_relation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    person_related_to bigint NOT NULL,
    sign_request boolean DEFAULT true NOT NULL,
    relationship relationships NOT NULL,
    can_do_explanation boolean DEFAULT false
);


ALTER TABLE persons_relations OWNER TO postgres;

--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE persons_relations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE persons_relations IS 'Indica le relazioni fra le persons: tipicamente l''student (colonna person) avrÃ  come relationship ''Parent''  il padre (person_related_to) per indicare la madre si inserirÃ  una riga person i valori uguali a quelli appena detti avendo cura, questa volta, di mettere nella colona person_related_to il codice della person che identifica la madre';


--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN persons_relations.sign_request; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.sign_request IS 'Indica se, nel caso di notes di classroom (ad example l''avviso per la gita scolastica) o nel caso di notes discplinari, il teacher deve avere cura di verificare se il parente in object ha visto la note';


--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN persons_relations.can_do_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.can_do_explanation IS 'puÃ² signaturere explanations per la person in relationship';


SET default_with_oids = false;

--
-- TOC entry 288 (class 1259 OID 17878)
-- Name: persons_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons_roles (
    person_role bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    role role NOT NULL
);


ALTER TABLE persons_roles OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 289 (class 1259 OID 17882)
-- Name: qualificationtions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE qualificationtions (
    qualification bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint,
    name character varying(160) NOT NULL,
    description character varying(4000) NOT NULL,
    metric bigint NOT NULL,
    type qualificationtion_types NOT NULL,
    qualificationtion_parent bigint
);


ALTER TABLE qualificationtions OWNER TO postgres;

--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE qualificationtions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualificationtions IS 'Descrive per il singolo school le competenze conoscenze e abilita.
Mettendo tutto in una singola tabella si Ã¨ coniato il termine qualification per essere generico rispetto alla declicountry che puÃ² avere: Expertise, conosenza, abilitÃ ';


--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN qualificationtions.qualificationtion_parent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualificationtions.qualificationtion_parent IS 'Serve a creare la gerarchia delle qualificationtions in questa colonna si indica la qualification from_time cui si dipende: la qualification padre';


SET default_with_oids = false;

--
-- TOC entry 290 (class 1259 OID 17889)
-- Name: qualificationtions_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE qualificationtions_plan (
    qualificationtion_plan bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    qualification bigint NOT NULL,
    degree bigint,
    course_year course_year,
    subject bigint
);


ALTER TABLE qualificationtions_plan OWNER TO postgres;

--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE qualificationtions_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualificationtions_plan IS 'Contiene i collegamenti fra il piano formativo (degree, course_year e subject) e le qualificationtions.
Serve in fase di valutation per presentare le qualificationtions coerenti person la valutation espressa';


SET default_with_oids = true;

--
-- TOC entry 291 (class 1259 OID 17893)
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE regions (
    region smallint NOT NULL,
    description character varying(160) NOT NULL,
    geographical_area geographical_area
);


ALTER TABLE regions OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 292 (class 1259 OID 17896)
-- Name: residence_grp_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE residence_grp_city (
    school bigint,
    description character varying(160),
    count bigint
);

ALTER TABLE ONLY residence_grp_city REPLICA IDENTITY NOTHING;


ALTER TABLE residence_grp_city OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17899)
-- Name: schools_school_years_classrooms_weekly_timetable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW schools_school_years_classrooms_weekly_timetable AS
 SELECT i.school,
    i.description AS school_description,
    i.logo,
    a.school_year,
    a.description AS school_year_description,
    c.classroom,
    c.description AS classrom_description,
    o.weekly_timetable,
    o.description AS weekly_timetable_description
   FROM (((schools i
     JOIN school_years a ON ((i.school = a.school)))
     JOIN classrooms c ON ((a.school_year = c.school_year)))
     JOIN weekly_timetable o ON ((c.classroom = o.classroom)))
  WHERE (i.school = ANY (schools_enabled()));


ALTER TABLE schools_school_years_classrooms_weekly_timetable OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17904)
-- Name: signatures_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW signatures_ex AS
 SELECT f.classroom,
    f.on_date,
    f.at_time,
    p.thumbnail,
    p.person AS teacher,
    p.surname,
    p.name,
    p.tax_code
   FROM (signatures f
     JOIN persons p ON ((f.teacher = p.person)));


ALTER TABLE signatures_ex OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 295 (class 1259 OID 17908)
-- Name: system_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE system_messages (
    system_message bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    function_name text NOT NULL,
    id integer NOT NULL,
    language language DEFAULT 'it'::language NOT NULL,
    description text NOT NULL
);


ALTER TABLE system_messages OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17916)
-- Name: teachears_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teachears_notes (
    teacher_notes bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint,
    description character varying(2048) NOT NULL,
    teacher bigint NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone,
    classroom bigint NOT NULL
);


ALTER TABLE teachears_notes OWNER TO postgres;

--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE teachears_notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE teachears_notes IS 'Svolge le stesse funzioni della tabella notes ma per il registro del professore.
L''unica differenza Ã¨ che non Ã¨ stato necessario replicare anche la colonna ''disciplinary'' perchÃ¨ le notes disciplinari si fanno solo sul registro di classroom mentre queste notes sono principalmente ad uso privato dell''insegnante.';


--
-- TOC entry 297 (class 1259 OID 17923)
-- Name: teachers_classbooks_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW teachers_classbooks_ex AS
 SELECT DISTINCT i.school,
    a.school_year,
    va.classroom,
    va.teacher,
    va.subject,
    i.description AS school_description,
    i.mnemonic AS school_mnemonic,
    a.description AS school_year_description,
    c.description AS classrom_description,
    doc.surname,
    doc.name,
    doc.tax_code,
    m.description AS subject_description
   FROM (((((valutations va
     JOIN classrooms c ON ((c.classroom = va.classroom)))
     JOIN school_years a ON ((a.school_year = c.school_year)))
     JOIN schools i ON ((i.school = a.school)))
     JOIN persons doc ON ((doc.person = va.teacher)))
     JOIN subjects m ON ((m.subject = va.subject)));


ALTER TABLE teachers_classbooks_ex OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17928)
-- Name: teachers_lessons_signatures_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW teachers_lessons_signatures_ex AS
 SELECT 'lesson'::text AS type_riga,
    l.classroom,
    p.person AS teacher,
    (((p.surname)::text || ' '::text) || (p.name)::text) AS teacher_surname_name,
    p.thumbnail AS teacher_thumbnail,
    l.on_date,
    l.from_time,
    l.to_time,
    COALESCE(m.description, '* nessuna subject specificata *'::character varying(160)) AS subject_description,
    l.description,
    l.substitute
   FROM ((lessons l
     JOIN persons p ON ((l.teacher = p.person)))
     LEFT JOIN subjects m ON ((l.subject = m.subject)))
UNION ALL
 SELECT 'signature'::text AS type_riga,
    f.classroom,
    p.person AS teacher,
    (((p.surname)::text || ' '::text) || (p.name)::text) AS teacher_surname_name,
    p.thumbnail AS teacher_thumbnail,
    f.on_date,
    f.at_time AS from_time,
    NULL::time without time zone AS to_time,
    NULL::character varying AS subject_description,
    NULL::character varying AS description,
    NULL::boolean AS substitute
   FROM (signatures f
     JOIN persons p ON ((f.teacher = p.person)));


ALTER TABLE teachers_lessons_signatures_ex OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17933)
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE topics (
    topic bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    subject bigint NOT NULL,
    description character varying(160) NOT NULL,
    course_year course_year,
    degree bigint NOT NULL
);


ALTER TABLE topics OWNER TO postgres;

--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE topics; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE topics IS 'Contiene gli topics object di una valutation';


SET default_with_oids = false;

--
-- TOC entry 300 (class 1259 OID 17937)
-- Name: usenames_ex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usenames_ex (
    usename name NOT NULL,
    token character varying(1024),
    language language DEFAULT 'it'::language NOT NULL
);


ALTER TABLE usenames_ex OWNER TO postgres;

--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE usenames_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE usenames_ex IS 'add informations to usename''s system table usefull only to scuola247';


--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 300
-- Name: COLUMN usenames_ex.token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_ex.token IS 'serve per il ripristino della password street email';


--
-- TOC entry 301 (class 1259 OID 17944)
-- Name: usenames_rolnames; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW usenames_rolnames AS
 SELECT (members.rolname)::character varying AS usename,
    (roles.rolname)::character varying AS rolname
   FROM ((pg_authid roles
     JOIN pg_auth_members links ON ((links.roleid = roles.oid)))
     JOIN pg_authid members ON ((links.member = members.oid)));


ALTER TABLE usenames_rolnames OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17948)
-- Name: valutations_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_ex AS
 SELECT ((v.xmin)::text)::bigint AS rv,
    v.classroom,
    v.teacher,
    v.subject,
    v.valutation,
    v.student,
    alu.surname,
    alu.name,
    v.on_date,
    v.grade_type,
    tv.description AS grade_type_description,
    v.topic,
    a.description AS topic_description,
    m.metric,
    m.description AS metric_description,
    v.grade,
    vo.description AS grade_description,
    v.evaluation,
    v.private AS privato
   FROM (((((valutations v
     JOIN persons alu ON ((alu.person = v.student)))
     JOIN grade_types tv ON ((tv.grade_type = v.grade_type)))
     JOIN topics a ON ((a.topic = v.topic)))
     JOIN grades vo ON ((vo.grade = v.grade)))
     JOIN metrics m ON ((m.metric = vo.metric)));


ALTER TABLE valutations_ex OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 17953)
-- Name: valutations_references; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_references AS
 SELECT t.classroom,
    t.teacher,
    t.subject,
    t.on_date,
    t.grade_type,
    t.grade_type_description,
    t.grade_type_mnemonic,
    t.topic,
    t.topic_description,
    t.metric,
    t.metric_description,
    row_number() OVER (PARTITION BY t.classroom, t.teacher, t.subject, t.on_date ORDER BY t.grade_type_description, t.topic_description, t.metric_description) AS row_number
   FROM ( SELECT DISTINCT va.classroom,
            va.teacher,
            va.subject,
            va.on_date,
            va.grade_type,
            tv.description AS grade_type_description,
            tv.mnemonic AS grade_type_mnemonic,
            va.topic,
            COALESCE(a.description, ''::character varying) AS topic_description,
            m.metric,
            m.description AS metric_description
           FROM ((((valutations va
             LEFT JOIN topics a ON ((a.topic = va.topic)))
             JOIN grade_types tv ON ((tv.grade_type = va.grade_type)))
             JOIN grades vo ON ((vo.grade = va.grade)))
             JOIN metrics m ON ((m.metric = vo.metric)))
          ORDER BY va.on_date, tv.description, COALESCE(a.description, ''::character varying), m.description) t;


ALTER TABLE valutations_references OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17958)
-- Name: valutations_ex_references; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_ex_references AS
 SELECT va.classroom,
    va.teacher,
    va.subject,
    alu.surname,
    alu.name,
    alu.tax_code,
    va.on_date,
    vr.row_number,
    (((to_char((va.on_date)::timestamp with time zone, 'YYYY-MM-DD'::text) || ' ['::text) || "right"(('000'::text || vr.row_number), 3)) || ']'::text) AS riferimento,
    vo.mnemonic
   FROM ((((valutations va
     JOIN persons alu ON ((alu.person = va.student)))
     JOIN grades vo ON ((vo.grade = va.grade)))
     JOIN metrics m ON ((m.metric = vo.metric)))
     JOIN valutations_references vr ON (((vr.classroom = va.classroom) AND (vr.teacher = va.teacher) AND (vr.subject = va.subject) AND (vr.on_date = va.on_date) AND (vr.grade_type = va.grade_type) AND (COALESCE(vr.topic, (0)::bigint) = COALESCE(va.topic, (0)::bigint)) AND (vr.metric = m.metric))));


ALTER TABLE valutations_ex_references OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 305 (class 1259 OID 17963)
-- Name: valutations_qualificationtions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE valutations_qualificationtions (
    valutation_qualificationtion bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    valutation bigint NOT NULL,
    qualification bigint NOT NULL,
    grade bigint NOT NULL,
    notes character varying(2048)
);


ALTER TABLE valutations_qualificationtions OWNER TO postgres;

--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE valutations_qualificationtions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutations_qualificationtions IS 'Per ogni valutation inserita nella tabella valutations Ã¨ possibile collegare anche la valutation delle qualificationtions collegate che vengono memorizzate qui';


--
-- TOC entry 306 (class 1259 OID 17970)
-- Name: valutations_stats_classrooms_students_subjects; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_students_subjects AS
 SELECT va.classroom,
    va.student,
    va.subject,
    min(vo.thousandths) AS min,
    max(vo.thousandths) AS max,
    round(avg(vo.thousandths)) AS media,
    round(stddev_pop(vo.thousandths)) AS dev_std
   FROM (valutations va
     JOIN grades vo ON ((vo.grade = va.grade)))
  GROUP BY va.classroom, va.student, va.subject;


ALTER TABLE valutations_stats_classrooms_students_subjects OWNER TO postgres;

--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 306
-- Name: VIEW valutations_stats_classrooms_students_subjects; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW valutations_stats_classrooms_students_subjects IS 'statistiche per classroom / student / subject';


--
-- TOC entry 307 (class 1259 OID 17975)
-- Name: valutations_stats_classrooms_students_subjects_on_date; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_students_subjects_on_date AS
 SELECT valutations.classroom,
    valutations.student,
    valutations.subject,
    min(valutations.on_date) AS min,
    max(valutations.on_date) AS max
   FROM valutations
  GROUP BY valutations.classroom, valutations.student, valutations.subject;


ALTER TABLE valutations_stats_classrooms_students_subjects_on_date OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 17979)
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_students_subjects_on_date_ex AS
 SELECT vas.classroom,
    c.description AS classrom_description,
    vas.student,
    ((((((alu.surname)::text || ' '::text) || (alu.name)::text) || ' ('::text) || (alu.tax_code)::text) || ')'::text) AS student_description,
    vas.subject,
    m.description AS subject_description,
    vas.min,
    vas.max,
    vas.media,
    vas.dev_std,
    vo_f.thousandths AS primo,
    vo_l.thousandths AS ultimo
   FROM ((((((((valutations_stats_classrooms_students_subjects vas
     JOIN valutations_stats_classrooms_students_subjects_on_date vas_g ON (((vas.classroom = vas_g.classroom) AND (vas.student = vas_g.student) AND (vas_g.subject = vas.subject))))
     JOIN valutations va_f ON (((va_f.classroom = vas.classroom) AND (va_f.student = vas.student) AND (va_f.subject = vas.subject) AND (va_f.on_date = vas_g.min))))
     JOIN grades vo_f ON ((vo_f.grade = va_f.grade)))
     JOIN valutations va_l ON (((va_l.classroom = vas.classroom) AND (va_l.student = vas.student) AND (va_l.subject = vas.subject) AND (va_l.on_date = vas_g.max))))
     JOIN grades vo_l ON ((vo_l.grade = va_l.grade)))
     JOIN classrooms c ON ((c.classroom = vas.classroom)))
     JOIN persons alu ON ((alu.person = vas.student)))
     JOIN subjects m ON ((m.subject = vas.subject)));


ALTER TABLE valutations_stats_classrooms_students_subjects_on_date_ex OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 17984)
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex_mat; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW valutations_stats_classrooms_students_subjects_on_date_ex_mat AS
 SELECT vas.classroom,
    c.description AS classrom_description,
    vas.student,
    ((((((alu.surname)::text || ' '::text) || (alu.name)::text) || ' ('::text) || (alu.tax_code)::text) || ')'::text) AS student_description,
    vas.subject,
    m.description AS subject_description,
    vas.min,
    vas.max,
    vas.media,
    vas.dev_std,
    vo_f.thousandths AS primo,
    vo_l.thousandths AS ultimo
   FROM ((((((((valutations_stats_classrooms_students_subjects vas
     JOIN valutations_stats_classrooms_students_subjects_on_date vas_g ON (((vas.classroom = vas_g.classroom) AND (vas.student = vas_g.student) AND (vas_g.subject = vas.subject))))
     JOIN valutations va_f ON (((va_f.classroom = vas.classroom) AND (va_f.student = vas.student) AND (va_f.subject = vas.subject) AND (va_f.on_date = vas_g.min))))
     JOIN grades vo_f ON ((vo_f.grade = va_f.grade)))
     JOIN valutations va_l ON (((va_l.classroom = vas.classroom) AND (va_l.student = vas.student) AND (va_l.subject = vas.subject) AND (va_l.on_date = vas_g.max))))
     JOIN grades vo_l ON ((vo_l.grade = va_l.grade)))
     JOIN classrooms c ON ((c.classroom = vas.classroom)))
     JOIN persons alu ON ((alu.person = vas.student)))
     JOIN subjects m ON ((m.subject = vas.subject)))
  WITH NO DATA;


ALTER TABLE valutations_stats_classrooms_students_subjects_on_date_ex_mat OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 17992)
-- Name: valutations_stats_classrooms_subjects; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_subjects AS
 SELECT va.classroom,
    va.subject,
    min(vo.thousandths) AS min,
    max(vo.thousandths) AS max,
    round(avg(vo.thousandths)) AS media,
    round(stddev_pop(vo.thousandths)) AS dev_std
   FROM (valutations va
     JOIN grades vo ON ((vo.grade = va.grade)))
  GROUP BY va.classroom, va.subject;


ALTER TABLE valutations_stats_classrooms_subjects OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 17996)
-- Name: valutations_stats_classrooms_subjects_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_subjects_ex AS
 SELECT v.classroom,
    v.subject,
    c.school_year,
    c.degree,
    c.section,
    c.course_year,
    c.description,
    c.building,
    p.description AS building_description,
    v.min,
    v.max,
    v.media,
    v.dev_std
   FROM ((valutations_stats_classrooms_subjects v
     JOIN classrooms c ON ((v.classroom = c.classroom)))
     JOIN branches p ON ((p.branch = c.building)));


ALTER TABLE valutations_stats_classrooms_subjects_ex OWNER TO postgres;

--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 311
-- Name: VIEW valutations_stats_classrooms_subjects_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW valutations_stats_classrooms_subjects_ex IS 'statistiche per classroom';


--
-- TOC entry 312 (class 1259 OID 18001)
-- Name: weekly_timetable_teachers_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW weekly_timetable_teachers_ex AS
 SELECT c.classroom,
    p.person AS teacher,
    (((p.surname)::text || ' '::text) || (p.name)::text) AS teacher_surname_name,
    os.description AS weekly_timetable_description,
    COALESCE(m.description, 'Materia non specificata'::character varying) AS subject_description,
    osg.weekday,
    ((to_char((('now'::text)::date + osg.from_time), 'HH24:MI'::text) || ' - '::text) || to_char((('now'::text)::date + osg.to_time), ((('HH24:MI'::text || ' ('::text) || (osg.team_teaching)::text) || ')'::text))) AS period
   FROM (((((school_years a
     JOIN classrooms c ON ((c.school_year = a.school_year)))
     JOIN weekly_timetable os ON ((os.classroom = c.classroom)))
     JOIN weekly_timetables_days osg ON ((osg.weekly_timetable = os.weekly_timetable)))
     JOIN persons p ON ((p.person = osg.teacher)))
     LEFT JOIN subjects m ON ((m.subject = osg.subject)))
  WHERE (a.school = ANY (schools_enabled()));


ALTER TABLE weekly_timetable_teachers_ex OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 313 (class 1259 OID 18006)
-- Name: wikimedia_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wikimedia_files (
    name text NOT NULL,
    type wikimedia_type NOT NULL,
    wikimedia_file bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    info xml,
    photo bytea,
    thumbnail bytea
);


ALTER TABLE wikimedia_files OWNER TO postgres;

--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE wikimedia_files; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE wikimedia_files IS 'files from wikimedia commons';


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN wikimedia_files.info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.info IS 'contiene tutti imetadati del file in formato xml come dalle api di wikimedia';


--
-- TOC entry 314 (class 1259 OID 18013)
-- Name: wikimedia_files_persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wikimedia_files_persons (
    wikimedia_file_person bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    wikimedia_file bigint NOT NULL,
    person bigint NOT NULL
);


ALTER TABLE wikimedia_files_persons OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 18017)
-- Name: wikimedia_license_infos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW wikimedia_license_infos AS
 SELECT wikimedia_files.name,
    array_length((xpath('/response/licenses/license/name/text()'::text, wikimedia_files.info))::text[], 1) AS license_number,
    (xpath('/response/licenses/license/name/text()'::text, wikimedia_files.info))::text[] AS license,
    utility.strip_tags(utility.entity2char(((xpath('/response/file/author/text()'::text, wikimedia_files.info))[1])::text)) AS author,
    utility.strip_tags(utility.entity2char(((xpath('/response/file/source/text()'::text, wikimedia_files.info))[1])::text)) AS source,
    utility.strip_tags(utility.entity2char(((xpath('/response/file/permission/text()'::text, wikimedia_files.info))[1])::text)) AS permission
   FROM wikimedia_files;


ALTER TABLE wikimedia_license_infos OWNER TO postgres;

--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 315
-- Name: VIEW wikimedia_license_infos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW wikimedia_license_infos IS 'Estrapola dalla colonna info della tabella di wikimedia i dati relativi alla licenza d''''uso del file';


SET search_path = translate, pg_catalog;

--
-- TOC entry 316 (class 1259 OID 18021)
-- Name: columns; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE columns (
    "column" bigint DEFAULT nextval('public.pk_seq'::regclass) NOT NULL,
    relation bigint NOT NULL,
    "position" integer NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text
);


ALTER TABLE columns OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 18028)
-- Name: languages; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE languages (
    language bigint DEFAULT nextval('public.pk_seq'::regclass) NOT NULL,
    description text NOT NULL,
    schema text NOT NULL
);


ALTER TABLE languages OWNER TO postgres;

--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE languages; Type: COMMENT; Schema: translate; Owner: postgres
--

COMMENT ON TABLE languages IS 'Language for translation';


--
-- TOC entry 318 (class 1259 OID 18035)
-- Name: parameters; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE parameters (
    parameter bigint DEFAULT nextval('public.pk_seq'::regclass) NOT NULL,
    procedure bigint NOT NULL,
    signature text NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text
);


ALTER TABLE parameters OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 18042)
-- Name: pk_seq; Type: SEQUENCE; Schema: translate; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 18044)
-- Name: procedures; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE procedures (
    procedure bigint DEFAULT nextval('public.pk_seq'::regclass) NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text
);


ALTER TABLE procedures OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 18051)
-- Name: relations; Type: TABLE; Schema: translate; Owner: postgres
--

CREATE TABLE relations (
    relation bigint DEFAULT nextval('public.pk_seq'::regclass) NOT NULL,
    name text NOT NULL,
    language bigint NOT NULL,
    translation text
);


ALTER TABLE relations OWNER TO postgres;

SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 322 (class 1259 OID 18058)
-- Name: pk_seq; Type: SEQUENCE; Schema: unit_testing; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 18060)
-- Name: dependencies; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE dependencies (
    dependency bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    dependent_schema_name text NOT NULL,
    dependent_function_name text NOT NULL,
    depends_on_schema_name text NOT NULL,
    depends_on_function_name text NOT NULL
);


ALTER TABLE dependencies OWNER TO postgres;

--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE dependencies; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TABLE dependencies IS 'Contains the relationship between tests.
It allows to determine the execution sequence of the various tests';


SET default_with_oids = true;

--
-- TOC entry 324 (class 1259 OID 18067)
-- Name: system_messages; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE system_messages (
    system_message bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    function_name text NOT NULL,
    id integer NOT NULL,
    language public.language DEFAULT 'it'::public.language NOT NULL,
    description text NOT NULL
);


ALTER TABLE system_messages OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 325 (class 1259 OID 18075)
-- Name: tests; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE tests (
    test bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    end_at timestamp without time zone,
    unit_test_set bigint,
    note text,
    check_queries boolean DEFAULT false NOT NULL,
    check_functions boolean DEFAULT false NOT NULL,
    check_unit_tests boolean DEFAULT false NOT NULL
);


ALTER TABLE tests OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 18085)
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
-- TOC entry 327 (class 1259 OID 18092)
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
-- TOC entry 328 (class 1259 OID 18096)
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
-- TOC entry 329 (class 1259 OID 18100)
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
-- TOC entry 330 (class 1259 OID 18104)
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
-- TOC entry 331 (class 1259 OID 18108)
-- Name: unit_test_sets; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE unit_test_sets (
    unit_test_set bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description text
);


ALTER TABLE unit_test_sets OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 18115)
-- Name: unit_test_sets_details; Type: TABLE; Schema: unit_testing; Owner: postgres
--

CREATE TABLE unit_test_sets_details (
    unit_test_set_detail bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    unit_test_set bigint NOT NULL,
    name_space text NOT NULL,
    function_name text NOT NULL
);


ALTER TABLE unit_test_sets_details OWNER TO postgres;

--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE unit_test_sets_details; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON TABLE unit_test_sets_details IS 'Contains the list of functions reletad to a unit test set';


--
-- TOC entry 333 (class 1259 OID 18122)
-- Name: unit_tests_list; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_list AS
 SELECT p.oid,
    ns.nspname AS schema_name,
    p.proname AS function_name,
    d.description
   FROM ((pg_namespace ns
     JOIN pg_proc p ON ((p.pronamespace = ns.oid)))
     LEFT JOIN pg_description d ON ((p.oid = d.objoid)))
  WHERE (p.prorettype = ('unit_test_result[]'::regtype)::oid);


ALTER TABLE unit_tests_list OWNER TO postgres;

--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 333
-- Name: VIEW unit_tests_list; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON VIEW unit_tests_list IS 'Return all test function (all function that return an array of unit_test_result)';


--
-- TOC entry 334 (class 1259 OID 18127)
-- Name: unit_tests_level; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_level AS
 WITH RECURSIVE dependency_levels(oid, schema_name, function_name, level) AS (
         SELECT l.oid,
            l.schema_name,
            l.function_name,
            0 AS level
           FROM (unit_tests_list l
             LEFT JOIN dependencies d ON ((((l.schema_name)::text = d.dependent_schema_name) AND ((l.function_name)::text = d.dependent_function_name))))
          WHERE (d.dependency IS NULL)
        UNION
         SELECT l.oid,
            d.dependent_schema_name,
            d.dependent_function_name,
            (dl.level + 1)
           FROM ((dependency_levels dl
             JOIN dependencies d ON ((((dl.schema_name)::text = d.depends_on_schema_name) AND ((dl.function_name)::text = d.depends_on_function_name))))
             JOIN unit_tests_list l ON (((d.dependent_schema_name = (l.schema_name)::text) AND (d.dependent_function_name = (l.function_name)::text))))
          WHERE (dl.level < count_unit_tests())
        )
 SELECT dependency_levels.oid,
    dependency_levels.schema_name,
    dependency_levels.function_name,
    max(dependency_levels.level) AS max_level
   FROM dependency_levels
  GROUP BY dependency_levels.oid, dependency_levels.schema_name, dependency_levels.function_name;


ALTER TABLE unit_tests_level OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 18132)
-- Name: unit_tests_circular_references; Type: VIEW; Schema: unit_testing; Owner: postgres
--

CREATE VIEW unit_tests_circular_references AS
 SELECT lst.oid,
    lst.schema_name,
    lst.function_name
   FROM (unit_tests_list lst
     LEFT JOIN unit_tests_level lvl ON ((lst.oid = lvl.oid)))
  WHERE (lvl.oid IS NULL)
UNION
 SELECT unit_tests_level.oid,
    unit_tests_level.schema_name,
    unit_tests_level.function_name
   FROM unit_tests_level
  WHERE (unit_tests_level.max_level = count_unit_tests());


ALTER TABLE unit_tests_circular_references OWNER TO postgres;

--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 335
-- Name: VIEW unit_tests_circular_references; Type: COMMENT; Schema: unit_testing; Owner: postgres
--

COMMENT ON VIEW unit_tests_circular_references IS 'List all unit_test with cyclic dependencies';


SET search_path = utility, pg_catalog;

--
-- TOC entry 336 (class 1259 OID 18137)
-- Name: entity_coding2; Type: TABLE; Schema: utility; Owner: postgres
--

CREATE TABLE entity_coding2 (
    entity text NOT NULL,
    coding character(1)
);


ALTER TABLE entity_coding2 OWNER TO postgres;

--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE entity_coding2; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON TABLE entity_coding2 IS 'create table character_entity(
    name text primary key,
    ch char(1) unique
);
insert into character_entity (ch, name) values
    (E''\u00C6'',''AElig''),(E''\u00C1'',''Aacute''),(E''\u00C2'',''Acirc''),(E''\u00C0'',''Agrave''),(E''\u0391'',''Alpha''),(E''\u00C5'',''Aring''),(E''\u00C3'',''Atilde''),(E''\u00C4'',''Auml''),(E''\u0392'',''Beta''),(E''\u00C7'',''Ccedil''),
    (E''\u03A7'',''Chi''),(E''\u2021'',''Dagger''),(E''\u0394'',''Delta''),(E''\u00D0'',''ETH''),(E''\u00C9'',''Eacute''),(E''\u00CA'',''Ecirc''),(E''\u00C8'',''Egrave''),(E''\u0395'',''Epsilon''),(E''\u0397'',''Eta''),(E''\u00CB'',''Euml''),
    (E''\u0393'',''Gamma''),(E''\u00CD'',''Iacute''),(E''\u00CE'',''Icirc''),(E''\u00CC'',''Igrave''),(E''\u0399'',''Iota''),(E''\u00CF'',''Iuml''),(E''\u039A'',''Kappa''),(E''\u039B'',''Lambda''),(E''\u039C'',''Mu''),(E''\u00D1'',''Ntilde''),
    (E''\u039D'',''Nu''),(E''\u0152'',''OElig''),(E''\u00D3'',''Oacute''),(E''\u00D4'',''Ocirc''),(E''\u00D2'',''Ograve''),(E''\u03A9'',''Omega''),(E''\u039F'',''Omicron''),(E''\u00D8'',''Oslash''),(E''\u00D5'',''Otilde''),(E''\u00D6'',''Ouml''),
    (E''\u03A6'',''Phi''),(E''\u03A0'',''Pi''),(E''\u2033'',''Prime''),(E''\u03A8'',''Psi''),(E''\u03A1'',''Rho''),(E''\u0160'',''Scaron''),(E''\u03A3'',''Sigma''),(E''\u00DE'',''THORN''),(E''\u03A4'',''Tau''),(E''\u0398'',''Theta''),
    (E''\u00DA'',''Uacute''),(E''\u00DB'',''Ucirc''),(E''\u00D9'',''Ugrave''),(E''\u03A5'',''Upsilon''),(E''\u00DC'',''Uuml''),(E''\u039E'',''Xi''),(E''\u00DD'',''Yacute''),(E''\u0178'',''Yuml''),(E''\u0396'',''Zeta''),(E''\u00E1'',''aacute''),
    (E''\u00E2'',''acirc''),(E''\u00B4'',''acute''),(E''\u00E6'',''aelig''),(E''\u00E0'',''agrave''),(E''\u2135'',''alefsym''),(E''\u03B1'',''alpha''),(E''\u0026'',''amp''),(E''\u2227'',''and''),(E''\u2220'',''ang''),(E''\u00E5'',''aring''),
    (E''\u2248'',''asymp''),(E''\u00E3'',''atilde''),(E''\u00E4'',''auml''),(E''\u201E'',''bdquo''),(E''\u03B2'',''beta''),(E''\u00A6'',''brvbar''),(E''\u2022'',''bull''),(E''\u2229'',''cap''),(E''\u00E7'',''ccedil''),(E''\u00B8'',''cedil''),
    (E''\u00A2'',''cent''),(E''\u03C7'',''chi''),(E''\u02C6'',''circ''),(E''\u2663'',''clubs''),(E''\u2245'',''cong''),(E''\u00A9'',''copy''),(E''\u21B5'',''crarr''),(E''\u222A'',''cup''),(E''\u00A4'',''curren''),(E''\u21D3'',''dArr''),
    (E''\u2020'',''dagger''),(E''\u2193'',''darr''),(E''\u00B0'',''deg''),(E''\u03B4'',''delta''),(E''\u2666'',''diams''),(E''\u00F7'',''divide''),(E''\u00E9'',''eacute''),(E''\u00EA'',''ecirc''),(E''\u00E8'',''egrave''),(E''\u2205'',''empty''),
    (E''\u2003'',''emsp''),(E''\u2002'',''ensp''),(E''\u03B5'',''epsilon''),(E''\u2261'',''equiv''),(E''\u03B7'',''eta''),(E''\u00F0'',''eth''),(E''\u00EB'',''euml''),(E''\u20AC'',''euro''),(E''\u2203'',''exist''),(E''\u0192'',''fnof''),
    (E''\u2200'',''forall''),(E''\u00BD'',''frac12''),(E''\u00BC'',''frac14''),(E''\u00BE'',''frac34''),(E''\u2044'',''frasl''),(E''\u03B3'',''gamma''),(E''\u2265'',''ge''),(E''\u003E'',''gt''),(E''\u21D4'',''hArr''),(E''\u2194'',''harr''),
    (E''\u2665'',''hearts''),(E''\u2026'',''hellip''),(E''\u00ED'',''iacute''),(E''\u00EE'',''icirc''),(E''\u00A1'',''iexcl''),(E''\u00EC'',''igrave''),(E''\u2111'',''image''),(E''\u221E'',''infin''),(E''\u222B'',''int''),(E''\u03B9'',''iota''),
    (E''\u00BF'',''iquest''),(E''\u2208'',''isin''),(E''\u00EF'',''iuml''),(E''\u03BA'',''kappa''),(E''\u21D0'',''lArr''),(E''\u03BB'',''lambda''),(E''\u2329'',''lang''),(E''\u00AB'',''laquo''),(E''\u2190'',''larr''),(E''\u2308'',''lceil''),
    (E''\u201C'',''ldquo''),(E''\u2264'',''le''),(E''\u230A'',''lfloor''),(E''\u2217'',''lowast''),(E''\u25CA'',''loz''),(E''\u200E'',''lrm''),(E''\u2039'',''lsaquo''),(E''\u2018'',''lsquo''),(E''\u003C'',''lt''),(E''\u00AF'',''macr''),
    (E''\u2014'',''mdash''),(E''\u00B5'',''micro''),(E''\u00B7'',''middot''),(E''\u2212'',''minus''),(E''\u03BC'',''mu''),(E''\u2207'',''nabla''),(E''\u00A0'',''nbsp''),(E''\u2013'',''ndash''),(E''\u2260'',''ne''),(E''\u220B'',''ni''),
    (E''\u00AC'',''not''),(E''\u2209'',''notin''),(E''\u2284'',''nsub''),(E''\u00F1'',''ntilde''),(E''\u03BD'',''nu''),(E''\u00F3'',''oacute''),(E''\u00F4'',''ocirc''),(E''\u0153'',''oelig''),(E''\u00F2'',''ograve''),(E''\u203E'',''oline''),
    (E''\u03C9'',''omega''),(E''\u03BF'',''omicron''),(E''\u2295'',''oplus''),(E''\u2228'',''or''),(E''\u00AA'',''ordf''),(E''\u00BA'',''ordm''),(E''\u00F8'',''oslash''),(E''\u00F5'',''otilde''),(E''\u2297'',''otimes''),(E''\u00F6'',''ouml''),
    (E''\u00B6'',''para''),(E''\u2202'',''part''),(E''\u2030'',''permil''),(E''\u22A5'',''perp''),(E''\u03C6'',''phi''),(E''\u03C0'',''pi''),(E''\u03D6'',''piv''),(E''\u00B1'',''plusmn''),(E''\u00A3'',''pound''),(E''\u2032'',''prime''),
    (E''\u220F'',''prod''),(E''\u221D'',''prop''),(E''\u03C8'',''psi''),(E''\u0022'',''quot''),(E''\u21D2'',''rArr''),(E''\u221A'',''radic''),(E''\u232A'',''rang''),(E''\u00BB'',''raquo''),(E''\u2192'',''rarr''),(E''\u2309'',''rceil''),
    (E''\u201D'',''rdquo''),(E''\u211C'',''real''),(E''\u00AE'',''reg''),(E''\u230B'',''rfloor''),(E''\u03C1'',''rho''),(E''\u200F'',''rlm''),(E''\u203A'',''rsaquo''),(E''\u2019'',''rsquo''),(E''\u201A'',''sbquo''),(E''\u0161'',''scaron''),
    (E''\u22C5'',''sdot''),(E''\u00A7'',''sect''),(E''\u00AD'',''shy''),(E''\u03C3'',''sigma''),(E''\u03C2'',''sigmaf''),(E''\u223C'',''sim''),(E''\u2660'',''spades''),(E''\u2282'',''sub''),(E''\u2286'',''sube''),(E''\u2211'',''sum''),
    (E''\u2283'',''sup''),(E''\u00B9'',''sup1''),(E''\u00B2'',''sup2''),(E''\u00B3'',''sup3''),(E''\u2287'',''supe''),(E''\u00DF'',''szlig''),(E''\u03C4'',''tau''),(E''\u2234'',''there4''),(E''\u03B8'',''theta''),(E''\u03D1'',''thetasym''),
    (E''\u2009'',''thinsp''),(E''\u00FE'',''thorn''),(E''\u02DC'',''tilde''),(E''\u00D7'',''times''),(E''\u2122'',''trade''),(E''\u21D1'',''uArr''),(E''\u00FA'',''uacute''),(E''\u2191'',''uarr''),(E''\u00FB'',''ucirc''),(E''\u00F9'',''ugrave''),
    (E''\u00A8'',''uml''),(E''\u03D2'',''upsih''),(E''\u03C5'',''upsilon''),(E''\u00FC'',''uuml''),(E''\u2118'',''weierp''),(E''\u03BE'',''xi''),(E''\u00FD'',''yacute''),(E''\u00A5'',''yen''),(E''\u00FF'',''yuml''),(E''\u03B6'',''zeta''),
    (E''\u200D'',''zwj''),(E''\u200C'',''zwnj'')
;';


--
-- TOC entry 337 (class 1259 OID 18144)
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
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 337
-- Name: VIEW enums_values; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON VIEW enums_values IS 'List all enum and all related values';


--
-- TOC entry 338 (class 1259 OID 18149)
-- Name: pk_seq; Type: SEQUENCE; Schema: utility; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 18151)
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
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 339
-- Name: VIEW sequence_references; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON VIEW sequence_references IS 'List tables and columns where sequences are refererred and his max value';


--
-- TOC entry 340 (class 1259 OID 18156)
-- Name: test; Type: TABLE; Schema: utility; Owner: postgres
--

CREATE TABLE test (
    "Descrizione" text,
    "Codice" timestamp without time zone DEFAULT clock_timestamp() NOT NULL,
    codice2 timestamp without time zone DEFAULT make_timestamp(2000, 1, 1, (date_part('hour'::text, clock_timestamp()))::integer, (date_part('minute'::text, clock_timestamp()))::integer, date_part('second'::text, clock_timestamp()))
);


ALTER TABLE test OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 3262 (class 2606 OID 18165)
-- Name: absences absences_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_pk PRIMARY KEY (absence);


--
-- TOC entry 3264 (class 2606 OID 18167)
-- Name: absences absences_uq_classroom_student_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_uq_classroom_student_on_date UNIQUE (classroom_student, on_date);


--
-- TOC entry 3230 (class 2606 OID 18169)
-- Name: branches branches_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_pk PRIMARY KEY (branch);


--
-- TOC entry 3232 (class 2606 OID 18171)
-- Name: branches branches_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_uq_description UNIQUE (school, description);


--
-- TOC entry 3272 (class 2606 OID 18173)
-- Name: cities cities_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pk PRIMARY KEY (city);


--
-- TOC entry 3274 (class 2606 OID 18175)
-- Name: cities cities_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_uq_description UNIQUE (description, district);


--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 3274
-- Name: CONSTRAINT cities_uq_description ON cities; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT cities_uq_description ON cities IS 'Non ci possono essere due cities person la stessa description nella stessa province';


--
-- TOC entry 3237 (class 2606 OID 18177)
-- Name: classrooms classrooms_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_pk PRIMARY KEY (classroom);


--
-- TOC entry 3267 (class 2606 OID 18179)
-- Name: classrooms_students classrooms_students_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_pk PRIMARY KEY (classroom_student);


--
-- TOC entry 3269 (class 2606 OID 18181)
-- Name: classrooms_students classrooms_students_uq_classroom_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_uq_classroom_student UNIQUE (classroom, student);


--
-- TOC entry 3239 (class 2606 OID 18183)
-- Name: classrooms classrooms_uq_classroom; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_uq_classroom UNIQUE (school_year, building, degree, section, course_year);


--
-- TOC entry 3241 (class 2606 OID 18185)
-- Name: classrooms classrooms_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_uq_description UNIQUE (school_year, description);


--
-- TOC entry 3362 (class 2606 OID 18187)
-- Name: communication_types communication_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT communication_types_pk PRIMARY KEY (communication_type);


--
-- TOC entry 3364 (class 2606 OID 18189)
-- Name: communication_types communication_types_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT communication_types_uq_description UNIQUE (school, description);


--
-- TOC entry 3368 (class 2606 OID 18191)
-- Name: communications_media communications_media_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_pk PRIMARY KEY (communication_media);


--
-- TOC entry 3377 (class 2606 OID 18193)
-- Name: conversations_invites conversations_invites_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_pk PRIMARY KEY (conversation_invite);


--
-- TOC entry 3379 (class 2606 OID 18195)
-- Name: conversations_invites conversations_invites_uq_invited; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_uq_invited UNIQUE (conversation, invited);


--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 3379
-- Name: CONSTRAINT conversations_invites_uq_invited ON conversations_invites; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT conversations_invites_uq_invited ON conversations_invites IS 'Non Ã¨ possibile, per una determinata conversation, invitare la stessa person piÃ¹ volte';


--
-- TOC entry 3375 (class 2606 OID 18197)
-- Name: conversations conversations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_pk PRIMARY KEY (conversation);


--
-- TOC entry 3383 (class 2606 OID 18199)
-- Name: countries countries_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pk PRIMARY KEY (country);


--
-- TOC entry 3385 (class 2606 OID 18201)
-- Name: countries countries_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_uq_description UNIQUE (description);


--
-- TOC entry 3388 (class 2606 OID 18203)
-- Name: degrees degrees_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_pk PRIMARY KEY (degree);


--
-- TOC entry 3390 (class 2606 OID 18205)
-- Name: degrees degrees_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_uq_description UNIQUE (school, description);


--
-- TOC entry 3279 (class 2606 OID 18207)
-- Name: delays delays_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_pk PRIMARY KEY (delay);


--
-- TOC entry 3281 (class 2606 OID 18209)
-- Name: delays delays_uq_classroom_student_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_uq_classroom_student_on_date UNIQUE (classroom_student, on_date);


--
-- TOC entry 4310 (class 0 OID 0)
-- Dependencies: 3281
-- Name: CONSTRAINT delays_uq_classroom_student_on_date ON delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT delays_uq_classroom_student_on_date ON delays IS 'Per un student di una classroom in un on_date Ã¨ possibile un solo delay';


--
-- TOC entry 3392 (class 2606 OID 18211)
-- Name: districts districts_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_pk PRIMARY KEY (district);


--
-- TOC entry 3394 (class 2606 OID 18213)
-- Name: districts districts_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_uq_description UNIQUE (description);


--
-- TOC entry 3342 (class 2606 OID 18215)
-- Name: explanations explanations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_pk PRIMARY KEY (explanation);


--
-- TOC entry 3398 (class 2606 OID 18217)
-- Name: faults faults_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faults
    ADD CONSTRAINT faults_pk PRIMARY KEY (fault);


--
-- TOC entry 3401 (class 2606 OID 18219)
-- Name: grade_types grade_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT grade_types_pk PRIMARY KEY (grade_type);


--
-- TOC entry 3403 (class 2606 OID 18221)
-- Name: grade_types grade_types_uq_mnemonic; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT grade_types_uq_mnemonic UNIQUE (subject, mnemonic);


--
-- TOC entry 3408 (class 2606 OID 18223)
-- Name: grades grades_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_pk PRIMARY KEY (grade);


--
-- TOC entry 3410 (class 2606 OID 18225)
-- Name: grades grades_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_uq_description UNIQUE (metric, description);


--
-- TOC entry 3412 (class 2606 OID 18227)
-- Name: grades grades_uq_mnemonic; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_uq_mnemonic UNIQUE (metric, mnemonic);


--
-- TOC entry 3415 (class 2606 OID 18229)
-- Name: grading_meetings grading_meetings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_pk PRIMARY KEY (grading_meeting);


--
-- TOC entry 3417 (class 2606 OID 18231)
-- Name: grading_meetings grading_meetings_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_uq_description UNIQUE (school_year, description);


--
-- TOC entry 3419 (class 2606 OID 18233)
-- Name: grading_meetings grading_meetings_uq_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_uq_on_date UNIQUE (school_year, on_date);


--
-- TOC entry 3426 (class 2606 OID 18235)
-- Name: grading_meetings_valutations grading_meetings_valutations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_pk PRIMARY KEY (grading_meeting_valutation);


--
-- TOC entry 3434 (class 2606 OID 18237)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_pk PRIMARY KEY (grading_meeting_valutation_qua);


--
-- TOC entry 3436 (class 2606 OID 18239)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_uq_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_uq_qualification UNIQUE (grading_meeting_valutation, qualification);


--
-- TOC entry 3428 (class 2606 OID 18241)
-- Name: grading_meetings_valutations grading_meetings_valutations_uq_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_uq_student UNIQUE (grading_meeting, classroom, student, subject, teacher);


--
-- TOC entry 3439 (class 2606 OID 18243)
-- Name: holydays holydays_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY holydays
    ADD CONSTRAINT holydays_pk PRIMARY KEY (holiday);


--
-- TOC entry 3441 (class 2606 OID 18245)
-- Name: holydays holydays_uq_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY holydays
    ADD CONSTRAINT holydays_uq_on_date UNIQUE (school, on_date);


--
-- TOC entry 4311 (class 0 OID 0)
-- Dependencies: 3441
-- Name: CONSTRAINT holydays_uq_on_date ON holydays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT holydays_uq_on_date ON holydays IS 'Nello stesso school ogni on_date deve essere indicato to_time massimo una volta';


--
-- TOC entry 3286 (class 2606 OID 18247)
-- Name: leavings leavings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_pk PRIMARY KEY (leaving);


--
-- TOC entry 3288 (class 2606 OID 18249)
-- Name: leavings leavings_uq_classroom_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_uq_classroom_student UNIQUE (classroom_student, on_date);


--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 3288
-- Name: CONSTRAINT leavings_uq_classroom_student ON leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT leavings_uq_classroom_student ON leavings IS 'Per ub student di una classroom in un on_date Ã¨ possibile una sola leaving';


--
-- TOC entry 3353 (class 2606 OID 18251)
-- Name: lessons lessons_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_pk PRIMARY KEY (lesson);


--
-- TOC entry 3445 (class 2606 OID 18253)
-- Name: messages messages_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pk PRIMARY KEY (message);


--
-- TOC entry 3451 (class 2606 OID 18255)
-- Name: messages_read messages_read_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_pk PRIMARY KEY (message_read);


--
-- TOC entry 3453 (class 2606 OID 18257)
-- Name: messages_read messages_read_uq_read_on; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_uq_read_on UNIQUE (message, person);


--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 3453
-- Name: CONSTRAINT messages_read_uq_read_on ON messages_read; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT messages_read_uq_read_on ON messages_read IS 'L''indicazione di quando Ã¨ stato letto un message Ã¨ univoco per ogni messagio e person (from_time) che lo ha letto';


--
-- TOC entry 3447 (class 2606 OID 18259)
-- Name: messages messages_uq_from_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_uq_from_time UNIQUE (conversation, from_time, written_on);


--
-- TOC entry 3456 (class 2606 OID 18261)
-- Name: metrics metrics_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metrics
    ADD CONSTRAINT metrics_pk PRIMARY KEY (metric);


--
-- TOC entry 3458 (class 2606 OID 18263)
-- Name: metrics metrics_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metrics
    ADD CONSTRAINT metrics_uq_description UNIQUE (school, description);


--
-- TOC entry 3370 (class 2606 OID 18265)
-- Name: communications_media mezzi_di_citiescazione_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT mezzi_di_citiescazione_uq_description UNIQUE (person, communication_type, description);


--
-- TOC entry 3372 (class 2606 OID 18267)
-- Name: communications_media mezzi_di_citiescazione_uq_uri; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT mezzi_di_citiescazione_uq_uri UNIQUE (person, communication_type, uri);


--
-- TOC entry 3293 (class 2606 OID 18269)
-- Name: notes notes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pk PRIMARY KEY (note);


--
-- TOC entry 3462 (class 2606 OID 18271)
-- Name: notes_signed notes_signed_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_pk PRIMARY KEY (note_signed);


--
-- TOC entry 3464 (class 2606 OID 18273)
-- Name: notes_signed notes_signed_uq_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_uq_person UNIQUE (note, person);


--
-- TOC entry 3295 (class 2606 OID 18275)
-- Name: notes notes_uq_on_date_at_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_uq_on_date_at_time UNIQUE (classroom, student, on_date, at_time);


--
-- TOC entry 3299 (class 2606 OID 18277)
-- Name: out_of_classrooms out_of_classrooms_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_pk PRIMARY KEY (out_of_classroom);


--
-- TOC entry 3301 (class 2606 OID 18279)
-- Name: out_of_classrooms out_of_classrooms_uq_classroom_student_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_uq_classroom_student_on_date UNIQUE (classroom_student, on_date);


--
-- TOC entry 3468 (class 2606 OID 18281)
-- Name: parents_meetings parents_meetings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_pk PRIMARY KEY (interview);


--
-- TOC entry 3470 (class 2606 OID 18283)
-- Name: parents_meetings parents_meetings_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_uq UNIQUE (teacher, on_date);


--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 3470
-- Name: CONSTRAINT parents_meetings_uq ON parents_meetings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT parents_meetings_uq ON parents_meetings IS 'Un teacher non puÃ² avere piÃ¹ di un interview in un determiborn momento';


--
-- TOC entry 3346 (class 2606 OID 18285)
-- Name: persons_addresses persons_addresses_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_pk PRIMARY KEY (person_address);


--
-- TOC entry 3348 (class 2606 OID 18287)
-- Name: persons_addresses persons_addresses_uq_indirizzo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_uq_indirizzo UNIQUE (person, street, zip_code, city);


--
-- TOC entry 3307 (class 2606 OID 18289)
-- Name: persons persons_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_pk PRIMARY KEY (person);


--
-- TOC entry 3474 (class 2606 OID 18291)
-- Name: persons_relations persons_relations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_pk PRIMARY KEY (person_relation);


--
-- TOC entry 3476 (class 2606 OID 18293)
-- Name: persons_relations persons_relations_uq_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_uq_person UNIQUE (person, relationship, person_related_to);


--
-- TOC entry 3479 (class 2606 OID 18295)
-- Name: persons_roles persons_roles_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_roles
    ADD CONSTRAINT persons_roles_pk PRIMARY KEY (person_role);


--
-- TOC entry 3481 (class 2606 OID 18297)
-- Name: persons_roles persons_roles_uq_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_roles
    ADD CONSTRAINT persons_roles_uq_person UNIQUE (person, role);


--
-- TOC entry 3309 (class 2606 OID 18299)
-- Name: persons persons_uq_school_tax_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_uq_school_tax_code UNIQUE (school, tax_code);


--
-- TOC entry 3311 (class 2606 OID 18301)
-- Name: persons persons_uq_usename; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_uq_usename UNIQUE (school, usename);


--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 3311
-- Name: CONSTRAINT persons_uq_usename ON persons; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT persons_uq_usename ON persons IS 'for every school we cannot have more than one person with the same usename (we can have hovewer the same person with more roles in the same school) ';


--
-- TOC entry 3486 (class 2606 OID 18303)
-- Name: qualificationtions qualificationtions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions
    ADD CONSTRAINT qualificationtions_pk PRIMARY KEY (qualification);


--
-- TOC entry 3493 (class 2606 OID 18305)
-- Name: qualificationtions_plan qualificationtions_plan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions_plan
    ADD CONSTRAINT qualificationtions_plan_pk PRIMARY KEY (qualificationtion_plan);


--
-- TOC entry 3495 (class 2606 OID 18307)
-- Name: qualificationtions_plan qualificationtions_plan_uq_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions_plan
    ADD CONSTRAINT qualificationtions_plan_uq_qualification UNIQUE (degree, course_year, subject, qualification);


--
-- TOC entry 3488 (class 2606 OID 18309)
-- Name: qualificationtions qualificationtions_uq_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions
    ADD CONSTRAINT qualificationtions_uq_name UNIQUE (school, name);


--
-- TOC entry 3497 (class 2606 OID 18311)
-- Name: regions regions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pk PRIMARY KEY (region);


--
-- TOC entry 3499 (class 2606 OID 18313)
-- Name: regions regions_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_uq_description UNIQUE (description);


--
-- TOC entry 3243 (class 2606 OID 18315)
-- Name: school_years school_years_ex_duration; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_ex_duration EXCLUDE USING gist (school WITH =, duration WITH &&);


--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 3243
-- Name: CONSTRAINT school_years_ex_duration ON school_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT school_years_ex_duration ON school_years IS 'in the same school we cannot have duration overlap';


--
-- TOC entry 3246 (class 2606 OID 18317)
-- Name: school_years school_years_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_pk PRIMARY KEY (school_year);


--
-- TOC entry 3248 (class 2606 OID 18319)
-- Name: school_years school_years_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_uq_description UNIQUE (school, description);


--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 3248
-- Name: CONSTRAINT school_years_uq_description ON school_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT school_years_uq_description ON school_years IS 'La description deve essere univoca all''interno di un school';


--
-- TOC entry 3251 (class 2606 OID 18321)
-- Name: schools schools_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pk PRIMARY KEY (school);


--
-- TOC entry 3253 (class 2606 OID 18323)
-- Name: schools schools_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_uq_description UNIQUE (description);


--
-- TOC entry 3255 (class 2606 OID 18325)
-- Name: schools schools_uq_mnemonic; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_uq_mnemonic UNIQUE (mnemonic);


--
-- TOC entry 3257 (class 2606 OID 18327)
-- Name: schools schools_uq_processing_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_uq_processing_code UNIQUE (processing_code, example);


--
-- TOC entry 3357 (class 2606 OID 18329)
-- Name: signatures signatures_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_pk PRIMARY KEY (signature);


--
-- TOC entry 3359 (class 2606 OID 18331)
-- Name: signatures signatures_uq_classroom; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_uq_classroom UNIQUE (classroom, teacher, on_date, at_time);


--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 3359
-- Name: CONSTRAINT signatures_uq_classroom ON signatures; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT signatures_uq_classroom ON signatures IS 'Un teacher non puÃ² signaturere piÃ¹ di una volta nello stesso on_date e  nella stessa at_time (indipendentemente from_timela classroom)';


--
-- TOC entry 3314 (class 2606 OID 18333)
-- Name: subjects subjects_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pk PRIMARY KEY (subject);


--
-- TOC entry 3316 (class 2606 OID 18335)
-- Name: subjects subjects_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_uq_description UNIQUE (school, description);


--
-- TOC entry 3501 (class 2606 OID 18337)
-- Name: system_messages system_messages_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY system_messages
    ADD CONSTRAINT system_messages_pk PRIMARY KEY (system_message);


--
-- TOC entry 3503 (class 2606 OID 18339)
-- Name: system_messages system_messages_uq_function_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY system_messages
    ADD CONSTRAINT system_messages_uq_function_name UNIQUE (function_name, id, language);


--
-- TOC entry 3508 (class 2606 OID 18341)
-- Name: teachears_notes teachears_notes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_pk PRIMARY KEY (teacher_notes);


--
-- TOC entry 3510 (class 2606 OID 18343)
-- Name: teachears_notes teachears_notes_uq_on_date_at_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_uq_on_date_at_time UNIQUE (classroom, student, on_date, at_time);


--
-- TOC entry 3405 (class 2606 OID 18345)
-- Name: grade_types tipi_grades_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT tipi_grades_uq_description UNIQUE (subject, description);


--
-- TOC entry 3514 (class 2606 OID 18347)
-- Name: topics topics_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pk PRIMARY KEY (topic);


--
-- TOC entry 3516 (class 2606 OID 18349)
-- Name: topics topics_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_uq_description UNIQUE (degree, course_year, subject, description);


--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 3516
-- Name: CONSTRAINT topics_uq_description ON topics; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT topics_uq_description ON topics IS 'test';


--
-- TOC entry 3518 (class 2606 OID 18351)
-- Name: usenames_ex usenames_ex_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_ex
    ADD CONSTRAINT usenames_ex_pk PRIMARY KEY (usename);


--
-- TOC entry 3520 (class 2606 OID 18353)
-- Name: usenames_ex usenames_ex_uq_usename; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_ex
    ADD CONSTRAINT usenames_ex_uq_usename UNIQUE (usename);


--
-- TOC entry 4320 (class 0 OID 0)
-- Dependencies: 3520
-- Name: CONSTRAINT usenames_ex_uq_usename ON usenames_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT usenames_ex_uq_usename ON usenames_ex IS 'ad ogni db_user di sistema deve corrispondere un solo db_user ';


--
-- TOC entry 3325 (class 2606 OID 18355)
-- Name: valutations valutations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_pk PRIMARY KEY (valutation);


--
-- TOC entry 3525 (class 2606 OID 18357)
-- Name: valutations_qualificationtions valutations_qualificationtions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualificationtions
    ADD CONSTRAINT valutations_qualificationtions_pk PRIMARY KEY (valutation_qualificationtion);


--
-- TOC entry 3527 (class 2606 OID 18359)
-- Name: valutations_qualificationtions valutations_qualificationtions_uq_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualificationtions
    ADD CONSTRAINT valutations_qualificationtions_uq_qualification UNIQUE (valutation, qualification);


--
-- TOC entry 3328 (class 2606 OID 18361)
-- Name: weekly_timetable weekly_timetable_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetable
    ADD CONSTRAINT weekly_timetable_pk PRIMARY KEY (weekly_timetable);


--
-- TOC entry 3330 (class 2606 OID 18363)
-- Name: weekly_timetable weekly_timetable_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetable
    ADD CONSTRAINT weekly_timetable_uq_description UNIQUE (classroom, description);


--
-- TOC entry 3335 (class 2606 OID 18365)
-- Name: weekly_timetables_days weekly_timetables_days_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_pk PRIMARY KEY (weekly_timetable_day);


--
-- TOC entry 3337 (class 2606 OID 18367)
-- Name: weekly_timetables_days weekly_timetables_days_uq_weekly_timetable; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_uq_weekly_timetable UNIQUE (weekly_timetable, weekday, teacher, subject, from_time);


--
-- TOC entry 3533 (class 2606 OID 18369)
-- Name: wikimedia_files_persons wikimedia_files_persons_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_pk PRIMARY KEY (wikimedia_file_person);


--
-- TOC entry 3535 (class 2606 OID 18371)
-- Name: wikimedia_files_persons wikimedia_files_persons_uq_wikimedia_file_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_uq_wikimedia_file_person UNIQUE (wikimedia_file, person);


--
-- TOC entry 3529 (class 2606 OID 18373)
-- Name: wikimedia_files wikimedia_files_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files
    ADD CONSTRAINT wikimedia_files_pk PRIMARY KEY (wikimedia_file);


SET search_path = translate, pg_catalog;

--
-- TOC entry 3537 (class 2606 OID 18375)
-- Name: columns columns_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_pk PRIMARY KEY ("column");


--
-- TOC entry 3539 (class 2606 OID 18377)
-- Name: columns columns_uq_relation_language_translation; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_uq_relation_language_translation UNIQUE (relation, language, translation);


--
-- TOC entry 3541 (class 2606 OID 18379)
-- Name: columns columns_uq_relation_name_language; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_uq_relation_name_language UNIQUE (relation, name, language);


--
-- TOC entry 3545 (class 2606 OID 18381)
-- Name: languages languages_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pk PRIMARY KEY (language);


--
-- TOC entry 3547 (class 2606 OID 18383)
-- Name: languages languages_uq_description; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_uq_description UNIQUE (description);


--
-- TOC entry 3549 (class 2606 OID 18385)
-- Name: languages languages_uq_schema; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_uq_schema UNIQUE (schema);


--
-- TOC entry 3553 (class 2606 OID 18387)
-- Name: parameters parameters_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY parameters
    ADD CONSTRAINT parameters_pk PRIMARY KEY (parameter);


--
-- TOC entry 3555 (class 2606 OID 18389)
-- Name: parameters parameters_uq_procedure_signature_language_translation; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY parameters
    ADD CONSTRAINT parameters_uq_procedure_signature_language_translation UNIQUE (procedure, signature, language, translation);


--
-- TOC entry 3557 (class 2606 OID 18391)
-- Name: parameters parameters_uq_procedure_signature_name; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY parameters
    ADD CONSTRAINT parameters_uq_procedure_signature_name UNIQUE (procedure, signature, name);


--
-- TOC entry 3560 (class 2606 OID 18393)
-- Name: procedures procedures_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_pk PRIMARY KEY (procedure);


--
-- TOC entry 3562 (class 2606 OID 18395)
-- Name: procedures procedures_uq_language_translation; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_uq_language_translation UNIQUE (language, translation);


--
-- TOC entry 3564 (class 2606 OID 18397)
-- Name: procedures procedures_uq_name_language; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_uq_name_language UNIQUE (name, language);


--
-- TOC entry 3567 (class 2606 OID 18399)
-- Name: relations relations_pk; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_pk PRIMARY KEY (relation);


--
-- TOC entry 3569 (class 2606 OID 18401)
-- Name: relations relations_uq_language_translation; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_uq_language_translation UNIQUE (language, translation);


--
-- TOC entry 3571 (class 2606 OID 18403)
-- Name: relations relations_uq_name_language; Type: CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_uq_name_language UNIQUE (name, language);


SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 3576 (class 2606 OID 18405)
-- Name: dependencies dependencies_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pk PRIMARY KEY (dependency);


--
-- TOC entry 3578 (class 2606 OID 18407)
-- Name: dependencies dependencies_uq_all_but_dependency; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_uq_all_but_dependency UNIQUE (dependent_schema_name, dependent_function_name, depends_on_schema_name, depends_on_function_name);


--
-- TOC entry 3580 (class 2606 OID 18409)
-- Name: system_messages system_messages_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY system_messages
    ADD CONSTRAINT system_messages_pk PRIMARY KEY (system_message);


--
-- TOC entry 3582 (class 2606 OID 18411)
-- Name: system_messages system_messages_uq_function_name; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY system_messages
    ADD CONSTRAINT system_messages_uq_function_name UNIQUE (function_name, id, language);


--
-- TOC entry 3586 (class 2606 OID 18413)
-- Name: tests_details test_details_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY tests_details
    ADD CONSTRAINT test_details_pk PRIMARY KEY (tests_detail);


--
-- TOC entry 3584 (class 2606 OID 18415)
-- Name: tests tests_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pk PRIMARY KEY (test);


--
-- TOC entry 3594 (class 2606 OID 18417)
-- Name: unit_test_sets_details unit_test_sets_details_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT unit_test_sets_details_pk PRIMARY KEY (unit_test_set_detail);


--
-- TOC entry 3597 (class 2606 OID 18419)
-- Name: unit_test_sets_details unit_test_sets_details_uq_all_but_unit_test_set_detail; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT unit_test_sets_details_uq_all_but_unit_test_set_detail UNIQUE (unit_test_set, name_space, function_name);


--
-- TOC entry 3588 (class 2606 OID 18421)
-- Name: unit_test_sets unit_test_sets_pk; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets
    ADD CONSTRAINT unit_test_sets_pk PRIMARY KEY (unit_test_set);


--
-- TOC entry 3590 (class 2606 OID 18423)
-- Name: unit_test_sets unit_test_sets_uq_description; Type: CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets
    ADD CONSTRAINT unit_test_sets_uq_description UNIQUE (description);


SET search_path = utility, pg_catalog;

--
-- TOC entry 3599 (class 2606 OID 18425)
-- Name: entity_coding2 character_entity_ch_key; Type: CONSTRAINT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY entity_coding2
    ADD CONSTRAINT character_entity_ch_key UNIQUE (coding);


--
-- TOC entry 3601 (class 2606 OID 18427)
-- Name: entity_coding2 character_entity_pkey; Type: CONSTRAINT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY entity_coding2
    ADD CONSTRAINT character_entity_pkey PRIMARY KEY (entity);


--
-- TOC entry 3603 (class 2606 OID 18429)
-- Name: test test_pk; Type: CONSTRAINT; Schema: utility; Owner: postgres
--

ALTER TABLE ONLY test
    ADD CONSTRAINT test_pk PRIMARY KEY ("Codice");


SET search_path = public, pg_catalog;

--
-- TOC entry 3258 (class 1259 OID 18430)
-- Name: absences_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX absences_fx_classroom_student ON absences USING btree (classroom_student);


--
-- TOC entry 3259 (class 1259 OID 18431)
-- Name: absences_fx_explanation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX absences_fx_explanation ON absences USING btree (explanation);


--
-- TOC entry 4321 (class 0 OID 0)
-- Dependencies: 3259
-- Name: INDEX absences_fx_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX absences_fx_explanation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3260 (class 1259 OID 18432)
-- Name: absences_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX absences_fx_teacher ON absences USING btree (teacher);


--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 3260
-- Name: INDEX absences_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX absences_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3228 (class 1259 OID 18433)
-- Name: branches_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX branches_fx_school ON branches USING btree (school);


--
-- TOC entry 3270 (class 1259 OID 18434)
-- Name: cities_fx_district; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cities_fx_district ON cities USING btree (district);


--
-- TOC entry 3233 (class 1259 OID 18435)
-- Name: classrooms_fx_building; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_fx_building ON classrooms USING btree (building);


--
-- TOC entry 3234 (class 1259 OID 18436)
-- Name: classrooms_fx_degree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_fx_degree ON classrooms USING btree (degree);


--
-- TOC entry 4323 (class 0 OID 0)
-- Dependencies: 3234
-- Name: INDEX classrooms_fx_degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classrooms_fx_degree IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3235 (class 1259 OID 18437)
-- Name: classrooms_fx_school_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_fx_school_year ON classrooms USING btree (school_year);


--
-- TOC entry 4324 (class 0 OID 0)
-- Dependencies: 3235
-- Name: INDEX classrooms_fx_school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classrooms_fx_school_year IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3265 (class 1259 OID 18438)
-- Name: classrooms_students_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_students_fx_classroom ON classrooms_students USING btree (classroom);


--
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 3265
-- Name: INDEX classrooms_students_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classrooms_students_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3360 (class 1259 OID 18439)
-- Name: communication_types_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX communication_types_fx_school ON communication_types USING btree (school);


--
-- TOC entry 3365 (class 1259 OID 18440)
-- Name: communications_media_ix_communication_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX communications_media_ix_communication_type ON communications_media USING btree (communication_type);


--
-- TOC entry 4326 (class 0 OID 0)
-- Dependencies: 3365
-- Name: INDEX communications_media_ix_communication_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX communications_media_ix_communication_type IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3366 (class 1259 OID 18441)
-- Name: communications_media_ix_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX communications_media_ix_person ON communications_media USING btree (person);


--
-- TOC entry 4327 (class 0 OID 0)
-- Dependencies: 3366
-- Name: INDEX communications_media_ix_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX communications_media_ix_person IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3373 (class 1259 OID 18442)
-- Name: conversations_fx_school_record; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_fx_school_record ON conversations USING btree (school_record);


--
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 3373
-- Name: INDEX conversations_fx_school_record; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX conversations_fx_school_record IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3380 (class 1259 OID 18443)
-- Name: conversations_partecipanti_fx_conversation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_partecipanti_fx_conversation ON conversations_invites USING btree (conversation);


--
-- TOC entry 3381 (class 1259 OID 18444)
-- Name: conversations_partecipanti_fx_partecipante; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_partecipanti_fx_partecipante ON conversations_invites USING btree (invited);


--
-- TOC entry 3386 (class 1259 OID 18445)
-- Name: degrees_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX degrees_fx_school ON degrees USING btree (school);


--
-- TOC entry 4329 (class 0 OID 0)
-- Dependencies: 3386
-- Name: INDEX degrees_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX degrees_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3275 (class 1259 OID 18446)
-- Name: delays_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delays_fx_classroom_student ON delays USING btree (classroom_student);


--
-- TOC entry 3276 (class 1259 OID 18447)
-- Name: delays_fx_explanation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delays_fx_explanation ON delays USING btree (explanation);


--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 3276
-- Name: INDEX delays_fx_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX delays_fx_explanation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3277 (class 1259 OID 18448)
-- Name: delays_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delays_fx_teacher ON delays USING btree (teacher);


--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 3277
-- Name: INDEX delays_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX delays_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3338 (class 1259 OID 18449)
-- Name: explanations_fx_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX explanations_fx_created_by ON explanations USING btree (created_by);


--
-- TOC entry 3339 (class 1259 OID 18450)
-- Name: explanations_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX explanations_fx_student ON explanations USING btree (student);


--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 3339
-- Name: INDEX explanations_fx_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX explanations_fx_student IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3340 (class 1259 OID 18451)
-- Name: explanations_fx_usata_from_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX explanations_fx_usata_from_time ON explanations USING btree (registered_by);


--
-- TOC entry 3395 (class 1259 OID 18452)
-- Name: faults_fx_lesson; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faults_fx_lesson ON faults USING btree (lesson);


--
-- TOC entry 3396 (class 1259 OID 18453)
-- Name: faults_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faults_fx_student ON faults USING btree (student);


--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 3396
-- Name: INDEX faults_fx_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX faults_fx_student IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3399 (class 1259 OID 18454)
-- Name: grade_types_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grade_types_fx_subject ON grade_types USING btree (subject);


--
-- TOC entry 3406 (class 1259 OID 18455)
-- Name: grades_fx_metric; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grades_fx_metric ON grades USING btree (metric);


--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 3406
-- Name: INDEX grades_fx_metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grades_fx_metric IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3413 (class 1259 OID 18456)
-- Name: grading_meetings_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_fx_school ON grading_meetings USING btree (school_year);


--
-- TOC entry 3420 (class 1259 OID 18457)
-- Name: grading_meetings_valutations_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_classroom ON grading_meetings_valutations USING btree (classroom);


--
-- TOC entry 3421 (class 1259 OID 18458)
-- Name: grading_meetings_valutations_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_grade ON grading_meetings_valutations USING btree (grade);


--
-- TOC entry 3422 (class 1259 OID 18459)
-- Name: grading_meetings_valutations_fx_grading_meeting; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_grading_meeting ON grading_meetings_valutations USING btree (grading_meeting);


--
-- TOC entry 3423 (class 1259 OID 18460)
-- Name: grading_meetings_valutations_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_student ON grading_meetings_valutations USING btree (student);


--
-- TOC entry 3424 (class 1259 OID 18461)
-- Name: grading_meetings_valutations_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_subject ON grading_meetings_valutations USING btree (subject);


--
-- TOC entry 3430 (class 1259 OID 18462)
-- Name: grading_meetings_valutations_qua_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_qua_fx_grade ON grading_meetings_valutations_qua USING btree (grade);


--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 3430
-- Name: INDEX grading_meetings_valutations_qua_fx_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grading_meetings_valutations_qua_fx_grade IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3431 (class 1259 OID 18463)
-- Name: grading_meetings_valutations_qua_fx_grading_meeting_valutation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation ON grading_meetings_valutations_qua USING btree (grading_meeting_valutation);


--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 3431
-- Name: INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3432 (class 1259 OID 18464)
-- Name: grading_meetings_valutations_qua_fx_qualification; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_qua_fx_qualification ON grading_meetings_valutations_qua USING btree (qualification);


--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 3432
-- Name: INDEX grading_meetings_valutations_qua_fx_qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grading_meetings_valutations_qua_fx_qualification IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3437 (class 1259 OID 18465)
-- Name: holydays_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX holydays_fx_school ON holydays USING btree (school);


--
-- TOC entry 4338 (class 0 OID 0)
-- Dependencies: 3437
-- Name: INDEX holydays_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX holydays_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3429 (class 1259 OID 18466)
-- Name: idx_grading_meetings_valutations; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_grading_meetings_valutations ON grading_meetings_valutations USING btree (teacher);


--
-- TOC entry 3477 (class 1259 OID 18467)
-- Name: idx_persons_roles; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_persons_roles ON persons_roles USING btree (person);


--
-- TOC entry 3282 (class 1259 OID 18468)
-- Name: leavings_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leavings_fx_classroom_student ON leavings USING btree (classroom_student);


--
-- TOC entry 3283 (class 1259 OID 18469)
-- Name: leavings_fx_explanation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leavings_fx_explanation ON leavings USING btree (explanation);


--
-- TOC entry 4339 (class 0 OID 0)
-- Dependencies: 3283
-- Name: INDEX leavings_fx_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX leavings_fx_explanation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3284 (class 1259 OID 18470)
-- Name: leavings_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leavings_fx_teacher ON leavings USING btree (teacher);


--
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 3284
-- Name: INDEX leavings_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX leavings_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3349 (class 1259 OID 18471)
-- Name: lessons_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lessons_fx_classroom ON lessons USING btree (classroom);


--
-- TOC entry 4341 (class 0 OID 0)
-- Dependencies: 3349
-- Name: INDEX lessons_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lessons_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3350 (class 1259 OID 18472)
-- Name: lessons_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lessons_fx_subject ON lessons USING btree (subject);


--
-- TOC entry 4342 (class 0 OID 0)
-- Dependencies: 3350
-- Name: INDEX lessons_fx_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lessons_fx_subject IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3351 (class 1259 OID 18473)
-- Name: lessons_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lessons_fx_teacher ON lessons USING btree (teacher);


--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 3351
-- Name: INDEX lessons_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lessons_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3448 (class 1259 OID 18474)
-- Name: libretti_messages_read_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libretti_messages_read_fx_person ON messages_read USING btree (person);


--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 3448
-- Name: INDEX libretti_messages_read_fx_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messages_read_fx_person IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3449 (class 1259 OID 18475)
-- Name: libretti_messages_read_fx_school_record_mess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libretti_messages_read_fx_school_record_mess ON messages_read USING btree (message);


--
-- TOC entry 4345 (class 0 OID 0)
-- Dependencies: 3449
-- Name: INDEX libretti_messages_read_fx_school_record_mess; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messages_read_fx_school_record_mess IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3442 (class 1259 OID 18476)
-- Name: messages_fx_conversation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_fx_conversation ON messages USING btree (conversation);


--
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 3442
-- Name: INDEX messages_fx_conversation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messages_fx_conversation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3443 (class 1259 OID 18477)
-- Name: messages_fx_from_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_fx_from_time ON messages USING btree (from_time);


--
-- TOC entry 4347 (class 0 OID 0)
-- Dependencies: 3443
-- Name: INDEX messages_fx_from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messages_fx_from_time IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3454 (class 1259 OID 18478)
-- Name: metrics_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX metrics_fx_school ON metrics USING btree (school);


--
-- TOC entry 4348 (class 0 OID 0)
-- Dependencies: 3454
-- Name: INDEX metrics_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX metrics_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3289 (class 1259 OID 18479)
-- Name: notes_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_fx_classroom ON notes USING btree (classroom);


--
-- TOC entry 3290 (class 1259 OID 18480)
-- Name: notes_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_fx_classroom_student ON notes USING btree (classroom, student);


--
-- TOC entry 3291 (class 1259 OID 18481)
-- Name: notes_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_fx_teacher ON notes USING btree (teacher);


--
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 3291
-- Name: INDEX notes_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX notes_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3459 (class 1259 OID 18482)
-- Name: notes_signed_fx_note; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_signed_fx_note ON notes_signed USING btree (note);


--
-- TOC entry 3460 (class 1259 OID 18483)
-- Name: notes_signed_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_signed_fx_person ON notes_signed USING btree (person);


--
-- TOC entry 3296 (class 1259 OID 18484)
-- Name: out_of_classrooms_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX out_of_classrooms_fx_classroom_student ON out_of_classrooms USING btree (classroom_student);


--
-- TOC entry 3297 (class 1259 OID 18485)
-- Name: out_of_classrooms_fx_school_operator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX out_of_classrooms_fx_school_operator ON out_of_classrooms USING btree (school_operator);


--
-- TOC entry 4350 (class 0 OID 0)
-- Dependencies: 3297
-- Name: INDEX out_of_classrooms_fx_school_operator; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX out_of_classrooms_fx_school_operator IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3465 (class 1259 OID 18486)
-- Name: parents_meetings_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX parents_meetings_fx_person ON parents_meetings USING btree (person);


--
-- TOC entry 3466 (class 1259 OID 18487)
-- Name: parents_meetings_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX parents_meetings_fx_teacher ON parents_meetings USING btree (teacher);


--
-- TOC entry 3343 (class 1259 OID 18488)
-- Name: persons_addresses_fx_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_addresses_fx_city ON persons_addresses USING btree (city);


--
-- TOC entry 3344 (class 1259 OID 18489)
-- Name: persons_addresses_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_addresses_fx_person ON persons_addresses USING btree (person);


--
-- TOC entry 3302 (class 1259 OID 18490)
-- Name: persons_fx_city_of_birth; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_city_of_birth ON persons USING btree (city_of_birth);


--
-- TOC entry 3303 (class 1259 OID 18491)
-- Name: persons_fx_country_of_birth; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_country_of_birth ON persons USING btree (country_of_birth);


--
-- TOC entry 3304 (class 1259 OID 18492)
-- Name: persons_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_school ON persons USING btree (school);


--
-- TOC entry 3305 (class 1259 OID 18493)
-- Name: persons_fx_usename; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_usename ON persons USING btree (usename);


--
-- TOC entry 3471 (class 1259 OID 18494)
-- Name: persons_relations_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_relations_fx_person ON persons_relations USING btree (person);


--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 3471
-- Name: INDEX persons_relations_fx_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persons_relations_fx_person IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3472 (class 1259 OID 18495)
-- Name: persons_relations_fx_person_related_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_relations_fx_person_related_to ON persons_relations USING btree (person_related_to);


--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 3472
-- Name: INDEX persons_relations_fx_person_related_to; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persons_relations_fx_person_related_to IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3482 (class 1259 OID 18496)
-- Name: qualificationtions_fx_metric; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_fx_metric ON qualificationtions USING btree (metric);


--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 3482
-- Name: INDEX qualificationtions_fx_metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualificationtions_fx_metric IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3483 (class 1259 OID 18497)
-- Name: qualificationtions_fx_riferimento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_fx_riferimento ON qualificationtions USING btree (qualificationtion_parent);


--
-- TOC entry 3484 (class 1259 OID 18498)
-- Name: qualificationtions_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_fx_school ON qualificationtions USING btree (school);


--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 3484
-- Name: INDEX qualificationtions_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualificationtions_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3489 (class 1259 OID 18499)
-- Name: qualificationtions_plan_fx_degree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_plan_fx_degree ON qualificationtions_plan USING btree (degree);


--
-- TOC entry 3490 (class 1259 OID 18500)
-- Name: qualificationtions_plan_fx_qualification; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_plan_fx_qualification ON qualificationtions_plan USING btree (qualification);


--
-- TOC entry 3491 (class 1259 OID 18501)
-- Name: qualificationtions_plan_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_plan_fx_subject ON qualificationtions_plan USING btree (subject);


--
-- TOC entry 3244 (class 1259 OID 18502)
-- Name: school_years_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX school_years_fx_school ON school_years USING btree (school);


--
-- TOC entry 3249 (class 1259 OID 18503)
-- Name: schools_fk_behavior; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schools_fk_behavior ON schools USING btree (behavior);


--
-- TOC entry 3354 (class 1259 OID 18504)
-- Name: signatures_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX signatures_fx_classroom ON signatures USING btree (classroom);


--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 3354
-- Name: INDEX signatures_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX signatures_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3355 (class 1259 OID 18505)
-- Name: signatures_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX signatures_fx_teacher ON signatures USING btree (teacher);


--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 3355
-- Name: INDEX signatures_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX signatures_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3312 (class 1259 OID 18506)
-- Name: subjects_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX subjects_fx_school ON subjects USING btree (school);


--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 3312
-- Name: INDEX subjects_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX subjects_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3504 (class 1259 OID 18507)
-- Name: teachears_notes_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teachears_notes_fx_classroom ON teachears_notes USING btree (classroom);


--
-- TOC entry 3505 (class 1259 OID 18508)
-- Name: teachears_notes_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teachears_notes_fx_student ON teachears_notes USING btree (student);


--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 3505
-- Name: INDEX teachears_notes_fx_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX teachears_notes_fx_student IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3506 (class 1259 OID 18509)
-- Name: teachears_notes_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teachears_notes_fx_teacher ON teachears_notes USING btree (teacher);


--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 3506
-- Name: INDEX teachears_notes_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX teachears_notes_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3511 (class 1259 OID 18510)
-- Name: topics_fx_degree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topics_fx_degree ON topics USING btree (degree);


--
-- TOC entry 3512 (class 1259 OID 18511)
-- Name: topics_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topics_fx_subject ON topics USING btree (subject);


--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 3512
-- Name: INDEX topics_fx_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX topics_fx_subject IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3317 (class 1259 OID 18512)
-- Name: valutations_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_classroom ON valutations USING btree (classroom);


--
-- TOC entry 3318 (class 1259 OID 18513)
-- Name: valutations_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_grade ON valutations USING btree (grade);


--
-- TOC entry 3319 (class 1259 OID 18514)
-- Name: valutations_fx_grade_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_grade_type ON valutations USING btree (grade_type);


--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 3319
-- Name: INDEX valutations_fx_grade_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_fx_grade_type IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3320 (class 1259 OID 18515)
-- Name: valutations_fx_note; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_note ON valutations USING btree (note);


--
-- TOC entry 3321 (class 1259 OID 18516)
-- Name: valutations_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_student ON valutations USING btree (student);


--
-- TOC entry 3322 (class 1259 OID 18517)
-- Name: valutations_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_teacher ON valutations USING btree (teacher);


--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 3322
-- Name: INDEX valutations_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3323 (class 1259 OID 18518)
-- Name: valutations_fx_topic; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_topic ON valutations USING btree (topic);


--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 3323
-- Name: INDEX valutations_fx_topic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_fx_topic IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3521 (class 1259 OID 18519)
-- Name: valutations_qualificationtions_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_qualificationtions_fx_grade ON valutations_qualificationtions USING btree (grade);


--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 3521
-- Name: INDEX valutations_qualificationtions_fx_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_qualificationtions_fx_grade IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3522 (class 1259 OID 18520)
-- Name: valutations_qualificationtions_fx_qualification; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_qualificationtions_fx_qualification ON valutations_qualificationtions USING btree (qualification);


--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 3522
-- Name: INDEX valutations_qualificationtions_fx_qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_qualificationtions_fx_qualification IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3523 (class 1259 OID 18521)
-- Name: valutations_qualificationtions_fx_valutation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_qualificationtions_fx_valutation ON valutations_qualificationtions USING btree (valutation);


--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 3523
-- Name: INDEX valutations_qualificationtions_fx_valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_qualificationtions_fx_valutation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3326 (class 1259 OID 18522)
-- Name: weekly_timetable_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetable_fx_classroom ON weekly_timetable USING btree (classroom);


--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 3326
-- Name: INDEX weekly_timetable_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetable_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3331 (class 1259 OID 18523)
-- Name: weekly_timetables_days_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetables_days_fx_subject ON weekly_timetables_days USING btree (subject);


--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 3331
-- Name: INDEX weekly_timetables_days_fx_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetables_days_fx_subject IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3332 (class 1259 OID 18524)
-- Name: weekly_timetables_days_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetables_days_fx_teacher ON weekly_timetables_days USING btree (teacher);


--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 3332
-- Name: INDEX weekly_timetables_days_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetables_days_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3333 (class 1259 OID 18525)
-- Name: weekly_timetables_days_fx_weekly_timetable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetables_days_fx_weekly_timetable ON weekly_timetables_days USING btree (weekly_timetable);


--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 3333
-- Name: INDEX weekly_timetables_days_fx_weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetables_days_fx_weekly_timetable IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- TOC entry 3530 (class 1259 OID 18526)
-- Name: wikimedia_files_persons_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wikimedia_files_persons_fx_person ON wikimedia_files_persons USING btree (person);


--
-- TOC entry 3531 (class 1259 OID 18527)
-- Name: wikimedia_files_persons_fx_wikimedia_file; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wikimedia_files_persons_fx_wikimedia_file ON wikimedia_files_persons USING btree (wikimedia_file);


SET search_path = translate, pg_catalog;

--
-- TOC entry 3550 (class 1259 OID 18528)
-- Name: parameters_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX parameters_fx_language ON parameters USING btree (language);


--
-- TOC entry 3551 (class 1259 OID 18529)
-- Name: parameters_fx_procedure; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX parameters_fx_procedure ON parameters USING btree (procedure);


--
-- TOC entry 3558 (class 1259 OID 18530)
-- Name: procedures_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX procedures_fx_language ON procedures USING btree (language);


--
-- TOC entry 3542 (class 1259 OID 18531)
-- Name: relations_columns_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX relations_columns_fx_language ON columns USING btree (language);


--
-- TOC entry 3543 (class 1259 OID 18532)
-- Name: relations_columns_fx_relation; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX relations_columns_fx_relation ON columns USING btree (relation);


--
-- TOC entry 3565 (class 1259 OID 18533)
-- Name: relations_fx_language; Type: INDEX; Schema: translate; Owner: postgres
--

CREATE INDEX relations_fx_language ON relations USING btree (language);


SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 3572 (class 1259 OID 18534)
-- Name: dependencies_ix_all_but_dependency; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX dependencies_ix_all_but_dependency ON dependencies USING btree (dependent_schema_name, dependent_function_name, depends_on_schema_name, depends_on_function_name);


--
-- TOC entry 3573 (class 1259 OID 18535)
-- Name: dependencies_ix_dependent; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX dependencies_ix_dependent ON dependencies USING btree (dependent_schema_name, dependent_function_name);


--
-- TOC entry 3574 (class 1259 OID 18536)
-- Name: dependencies_ix_depends_on; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX dependencies_ix_depends_on ON dependencies USING btree (depends_on_schema_name, depends_on_function_name);


--
-- TOC entry 3591 (class 1259 OID 18537)
-- Name: unit_test_sets_details_fi_unit_test_set; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX unit_test_sets_details_fi_unit_test_set ON unit_test_sets_details USING btree (unit_test_set);


--
-- TOC entry 3592 (class 1259 OID 18538)
-- Name: unit_test_sets_details_ix_name_space_function_name; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX unit_test_sets_details_ix_name_space_function_name ON unit_test_sets_details USING btree (name_space, function_name);


--
-- TOC entry 3595 (class 1259 OID 18539)
-- Name: unit_test_sets_details_ui_all_but_unit_test_set_detail; Type: INDEX; Schema: unit_testing; Owner: postgres
--

CREATE INDEX unit_test_sets_details_ui_all_but_unit_test_set_detail ON unit_test_sets_details USING btree (unit_test_set, name_space, function_name);


SET search_path = public, pg_catalog;

--
-- TOC entry 3928 (class 2618 OID 18540)
-- Name: residence_grp_city _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO residence_grp_city DO INSTEAD  SELECT p.school,
    c.description,
    count(p.person) AS count
   FROM ((persons p
     JOIN persons_addresses pi ON ((pi.person = p.person)))
     JOIN cities c ON ((pi.city = c.city)))
  WHERE (pi.address_type = 'Residence'::address_type)
  GROUP BY p.school, c.city;


--
-- TOC entry 3715 (class 2620 OID 18542)
-- Name: absences absences_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER absences_iu AFTER INSERT OR UPDATE ON absences FOR EACH ROW EXECUTE PROCEDURE tr_absences_iu();


--
-- TOC entry 3713 (class 2620 OID 18543)
-- Name: classrooms classrooms_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classrooms_iu AFTER INSERT OR UPDATE ON classrooms FOR EACH ROW EXECUTE PROCEDURE tr_classrooms_iu();


--
-- TOC entry 3716 (class 2620 OID 18544)
-- Name: classrooms_students classrooms_students_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classrooms_students_iu AFTER INSERT OR UPDATE ON classrooms_students FOR EACH ROW EXECUTE PROCEDURE tr_classrooms_students_iu();


--
-- TOC entry 3725 (class 2620 OID 18545)
-- Name: communications_media communications_media_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER communications_media_iu AFTER INSERT OR UPDATE ON communications_media FOR EACH ROW EXECUTE PROCEDURE tr_communications_media_iu();


--
-- TOC entry 3726 (class 2620 OID 18546)
-- Name: conversations_invites conversations_invites_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER conversations_invites_iu AFTER INSERT OR UPDATE ON conversations_invites FOR EACH ROW EXECUTE PROCEDURE tr_conversations_invites_iu();


--
-- TOC entry 3739 (class 2620 OID 18547)
-- Name: usenames_ex db_users_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER db_users_iu AFTER INSERT OR UPDATE ON usenames_ex FOR EACH ROW EXECUTE PROCEDURE tr_db_users_iu();


--
-- TOC entry 3717 (class 2620 OID 18548)
-- Name: delays delays_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delays_iu AFTER INSERT OR UPDATE ON delays FOR EACH ROW EXECUTE PROCEDURE tr_delays_iu();


--
-- TOC entry 3722 (class 2620 OID 18549)
-- Name: explanations explanations_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER explanations_iu AFTER INSERT OR UPDATE ON explanations FOR EACH ROW EXECUTE PROCEDURE tr_explanations_iu();


--
-- TOC entry 3727 (class 2620 OID 18550)
-- Name: faults faults_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER faults_iu AFTER INSERT OR UPDATE ON faults FOR EACH ROW EXECUTE PROCEDURE tr_faults_iu();


--
-- TOC entry 3728 (class 2620 OID 18551)
-- Name: grading_meetings grading_meetings_i; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_i AFTER INSERT ON grading_meetings FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_i();


--
-- TOC entry 3729 (class 2620 OID 18552)
-- Name: grading_meetings_valutations grading_meetings_valutations_d; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_d AFTER DELETE ON grading_meetings_valutations FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_d();


--
-- TOC entry 3730 (class 2620 OID 18553)
-- Name: grading_meetings_valutations grading_meetings_valutations_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_iu AFTER INSERT OR UPDATE ON grading_meetings_valutations FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_iu();


--
-- TOC entry 3731 (class 2620 OID 18554)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_d; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_qua_d AFTER DELETE ON grading_meetings_valutations_qua FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_qua_d();


--
-- TOC entry 3732 (class 2620 OID 18555)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_qua_iu AFTER INSERT OR UPDATE ON grading_meetings_valutations_qua FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_qua_iu();


--
-- TOC entry 3718 (class 2620 OID 18556)
-- Name: leavings leavings_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER leavings_iu AFTER INSERT OR UPDATE ON leavings FOR EACH ROW EXECUTE PROCEDURE tr_leavings_iu();


--
-- TOC entry 3723 (class 2620 OID 18557)
-- Name: lessons lessons_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER lessons_iu AFTER INSERT OR UPDATE ON lessons FOR EACH ROW EXECUTE PROCEDURE tr_lessons_iu();


--
-- TOC entry 3733 (class 2620 OID 18558)
-- Name: messages messages_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER messages_iu AFTER INSERT OR UPDATE ON messages FOR EACH ROW EXECUTE PROCEDURE tr_messages_iu();


--
-- TOC entry 3734 (class 2620 OID 18559)
-- Name: messages_read messages_read_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER messages_read_iu AFTER INSERT OR UPDATE ON messages_read FOR EACH ROW EXECUTE PROCEDURE tr_messages_read_iu();


--
-- TOC entry 3719 (class 2620 OID 18560)
-- Name: notes notes_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notes_iu AFTER INSERT OR UPDATE ON notes FOR EACH ROW EXECUTE PROCEDURE tr_notes_iu();


--
-- TOC entry 3735 (class 2620 OID 18561)
-- Name: notes_signed notes_signed_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notes_signed_iu AFTER INSERT OR UPDATE ON notes_signed FOR EACH ROW EXECUTE PROCEDURE tr_notes_signed_iu();


--
-- TOC entry 3720 (class 2620 OID 18562)
-- Name: out_of_classrooms out_of_classrooms_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER out_of_classrooms_iu AFTER INSERT OR UPDATE ON out_of_classrooms FOR EACH ROW EXECUTE PROCEDURE tr_out_of_classrooms_iu();


--
-- TOC entry 3736 (class 2620 OID 18563)
-- Name: parents_meetings parents_meetings_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER parents_meetings_iu AFTER INSERT OR UPDATE ON parents_meetings FOR EACH ROW EXECUTE PROCEDURE tr_parents_meetings_iu();


--
-- TOC entry 3714 (class 2620 OID 18564)
-- Name: schools schools_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER schools_iu AFTER INSERT OR UPDATE ON schools FOR EACH ROW EXECUTE PROCEDURE tr_schools_iu();


--
-- TOC entry 3724 (class 2620 OID 18565)
-- Name: signatures signatures_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER signatures_iu AFTER INSERT OR UPDATE ON signatures FOR EACH ROW EXECUTE PROCEDURE tr_signatures_iu();


--
-- TOC entry 3737 (class 2620 OID 18566)
-- Name: teachears_notes teachears_notes_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER teachears_notes_iu AFTER INSERT OR UPDATE ON teachears_notes FOR EACH ROW EXECUTE PROCEDURE tr_teachears_notes_iu();


--
-- TOC entry 3738 (class 2620 OID 18567)
-- Name: topics topics_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER topics_iu AFTER INSERT OR UPDATE ON topics FOR EACH ROW EXECUTE PROCEDURE tr_topics_iu();


--
-- TOC entry 3721 (class 2620 OID 18568)
-- Name: valutations valutations_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutations_iu AFTER INSERT OR UPDATE ON valutations FOR EACH ROW EXECUTE PROCEDURE tr_valutations_iu();


--
-- TOC entry 3740 (class 2620 OID 18569)
-- Name: valutations_qualificationtions valutations_qualificationtions_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutations_qualificationtions_iu AFTER INSERT OR UPDATE ON valutations_qualificationtions FOR EACH ROW EXECUTE PROCEDURE tr_valutations_qualificationtions_iu();


SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 3741 (class 2620 OID 18570)
-- Name: dependencies dependencies_iu; Type: TRIGGER; Schema: unit_testing; Owner: postgres
--

CREATE TRIGGER dependencies_iu BEFORE INSERT OR UPDATE ON dependencies FOR EACH ROW EXECUTE PROCEDURE tr_dependencies_iu();


--
-- TOC entry 3742 (class 2620 OID 18571)
-- Name: unit_test_sets_details unit_test_sets_details_iu; Type: TRIGGER; Schema: unit_testing; Owner: postgres
--

CREATE TRIGGER unit_test_sets_details_iu BEFORE INSERT OR UPDATE ON unit_test_sets_details FOR EACH ROW EXECUTE PROCEDURE tr_unit_test_sets_details_iu();


SET search_path = public, pg_catalog;

--
-- TOC entry 3610 (class 2606 OID 18572)
-- Name: absences absences_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3611 (class 2606 OID 18577)
-- Name: absences absences_fk_explanation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_fk_explanation FOREIGN KEY (explanation) REFERENCES explanations(explanation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3612 (class 2606 OID 18582)
-- Name: absences absences_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3604 (class 2606 OID 18587)
-- Name: branches branches_fk_schools; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_fk_schools FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3615 (class 2606 OID 18592)
-- Name: cities cities_fk_district; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_fk_district FOREIGN KEY (district) REFERENCES districts(district);


--
-- TOC entry 3605 (class 2606 OID 18597)
-- Name: classrooms classrooms_fk_building; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_fk_building FOREIGN KEY (building) REFERENCES branches(branch) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3606 (class 2606 OID 18602)
-- Name: classrooms classrooms_fk_degree; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_fk_degree FOREIGN KEY (degree) REFERENCES degrees(degree) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3607 (class 2606 OID 18607)
-- Name: classrooms classrooms_fk_school_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_fk_school_year FOREIGN KEY (school_year) REFERENCES school_years(school_year) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3613 (class 2606 OID 18612)
-- Name: classrooms_students classrooms_students_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3614 (class 2606 OID 18617)
-- Name: classrooms_students classrooms_students_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3653 (class 2606 OID 18622)
-- Name: communication_types communication_types_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT communication_types_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3654 (class 2606 OID 18627)
-- Name: communications_media communications_media_fk_communication_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_fk_communication_type FOREIGN KEY (communication_type) REFERENCES communication_types(communication_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3655 (class 2606 OID 18632)
-- Name: communications_media communications_media_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3656 (class 2606 OID 18637)
-- Name: conversations conversations_fk_school_record; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_fk_school_record FOREIGN KEY (school_record) REFERENCES classrooms_students(classroom_student);


--
-- TOC entry 3657 (class 2606 OID 18642)
-- Name: conversations_invites conversations_invites_fk_conversation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_fk_conversation FOREIGN KEY (conversation) REFERENCES conversations(conversation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3658 (class 2606 OID 18647)
-- Name: conversations_invites conversations_invites_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_fk_person FOREIGN KEY (invited) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3659 (class 2606 OID 18652)
-- Name: degrees degrees_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3616 (class 2606 OID 18657)
-- Name: delays delays_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3617 (class 2606 OID 18662)
-- Name: delays delays_fk_explanation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_fk_explanation FOREIGN KEY (explanation) REFERENCES explanations(explanation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3618 (class 2606 OID 18667)
-- Name: delays delays_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3660 (class 2606 OID 18672)
-- Name: districts districts_fk_region; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_fk_region FOREIGN KEY (region) REFERENCES regions(region) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3643 (class 2606 OID 18677)
-- Name: explanations explanations_fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_fk_created_by FOREIGN KEY (created_by) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3644 (class 2606 OID 18682)
-- Name: explanations explanations_fk_registered_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_fk_registered_by FOREIGN KEY (registered_by) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3645 (class 2606 OID 18687)
-- Name: explanations explanations_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3661 (class 2606 OID 18692)
-- Name: faults faults_fk_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faults
    ADD CONSTRAINT faults_fk_lesson FOREIGN KEY (lesson) REFERENCES lessons(lesson) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3662 (class 2606 OID 18697)
-- Name: faults faults_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faults
    ADD CONSTRAINT faults_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3663 (class 2606 OID 18702)
-- Name: grade_types grade_types_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT grade_types_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3664 (class 2606 OID 18707)
-- Name: grades grades_fk_metric; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_fk_metric FOREIGN KEY (metric) REFERENCES metrics(metric) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3665 (class 2606 OID 18712)
-- Name: grading_meetings grading_meetings_fk_school_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_fk_school_year FOREIGN KEY (school_year) REFERENCES school_years(school_year) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3666 (class 2606 OID 18717)
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3667 (class 2606 OID 18722)
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3668 (class 2606 OID 18727)
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_grading_meeting; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_grading_meeting FOREIGN KEY (grading_meeting) REFERENCES grading_meetings(grading_meeting) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3669 (class 2606 OID 18732)
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3670 (class 2606 OID 18737)
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3671 (class 2606 OID 18742)
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3672 (class 2606 OID 18747)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3673 (class 2606 OID 18752)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_fk_grading_meeting_valutation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_fk_grading_meeting_valutation FOREIGN KEY (grading_meeting_valutation) REFERENCES grading_meetings_valutations(grading_meeting_valutation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3674 (class 2606 OID 18757)
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_fk_qualification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_fk_qualification FOREIGN KEY (qualification) REFERENCES qualificationtions(qualification) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3675 (class 2606 OID 18762)
-- Name: holydays holydays_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY holydays
    ADD CONSTRAINT holydays_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3619 (class 2606 OID 18767)
-- Name: leavings leavings_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3620 (class 2606 OID 18772)
-- Name: leavings leavings_fk_explanation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_fk_explanation FOREIGN KEY (explanation) REFERENCES explanations(explanation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3621 (class 2606 OID 18777)
-- Name: leavings leavings_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3648 (class 2606 OID 18782)
-- Name: lessons lessons_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3649 (class 2606 OID 18787)
-- Name: lessons lessons_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3650 (class 2606 OID 18792)
-- Name: lessons lessons_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3676 (class 2606 OID 18797)
-- Name: messages messages_fk_conversation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_fk_conversation FOREIGN KEY (conversation) REFERENCES conversations(conversation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3677 (class 2606 OID 18802)
-- Name: messages messages_fk_from_time; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_fk_from_time FOREIGN KEY (from_time) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3678 (class 2606 OID 18807)
-- Name: messages_read messages_read_fk_message; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_fk_message FOREIGN KEY (message) REFERENCES messages(message) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3679 (class 2606 OID 18812)
-- Name: messages_read messages_read_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3680 (class 2606 OID 18817)
-- Name: metrics metrics_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metrics
    ADD CONSTRAINT metrics_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3622 (class 2606 OID 18822)
-- Name: notes notes_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3623 (class 2606 OID 18827)
-- Name: notes notes_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_fk_classroom_student FOREIGN KEY (classroom, student) REFERENCES classrooms_students(classroom, student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3624 (class 2606 OID 18832)
-- Name: notes notes_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3681 (class 2606 OID 18837)
-- Name: notes_signed notes_signed_fk_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_fk_note FOREIGN KEY (note) REFERENCES notes(note) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3682 (class 2606 OID 18842)
-- Name: notes_signed notes_signed_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3625 (class 2606 OID 18847)
-- Name: out_of_classrooms out_of_classrooms_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3626 (class 2606 OID 18852)
-- Name: out_of_classrooms out_of_classrooms_fk_school_operator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_fk_school_operator FOREIGN KEY (school_operator) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3683 (class 2606 OID 18857)
-- Name: parents_meetings parents_meetings_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3684 (class 2606 OID 18862)
-- Name: parents_meetings parents_meetings_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3646 (class 2606 OID 18867)
-- Name: persons_addresses persons_addresses_fk_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_fk_city FOREIGN KEY (city) REFERENCES cities(city) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3647 (class 2606 OID 18872)
-- Name: persons_addresses persons_addresses_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3627 (class 2606 OID 18877)
-- Name: persons persons_fk_city_of_birth; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_city_of_birth FOREIGN KEY (city_of_birth) REFERENCES cities(city);


--
-- TOC entry 3628 (class 2606 OID 18882)
-- Name: persons persons_fk_country_of_birth; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_country_of_birth FOREIGN KEY (country_of_birth) REFERENCES countries(country);


--
-- TOC entry 3629 (class 2606 OID 18887)
-- Name: persons persons_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3630 (class 2606 OID 18892)
-- Name: persons persons_fk_usename; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_usename FOREIGN KEY (usename) REFERENCES usenames_ex(usename) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3685 (class 2606 OID 18897)
-- Name: persons_relations persons_relations_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3686 (class 2606 OID 18902)
-- Name: persons_relations persons_relations_fk_person_related_to; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_fk_person_related_to FOREIGN KEY (person_related_to) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3687 (class 2606 OID 18907)
-- Name: persons_roles persons_roles_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_roles
    ADD CONSTRAINT persons_roles_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3688 (class 2606 OID 18912)
-- Name: qualificationtions qualificationtions_fk_metric; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions
    ADD CONSTRAINT qualificationtions_fk_metric FOREIGN KEY (metric) REFERENCES metrics(metric) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3689 (class 2606 OID 18917)
-- Name: qualificationtions qualificationtions_fk_qualificationtion_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions
    ADD CONSTRAINT qualificationtions_fk_qualificationtion_parent FOREIGN KEY (qualificationtion_parent) REFERENCES qualificationtions(qualification) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3690 (class 2606 OID 18922)
-- Name: qualificationtions qualificationtions_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions
    ADD CONSTRAINT qualificationtions_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3691 (class 2606 OID 18927)
-- Name: qualificationtions_plan qualificationtions_plan_fk_degree; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions_plan
    ADD CONSTRAINT qualificationtions_plan_fk_degree FOREIGN KEY (degree) REFERENCES degrees(degree) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3692 (class 2606 OID 18932)
-- Name: qualificationtions_plan qualificationtions_plan_fk_qualification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions_plan
    ADD CONSTRAINT qualificationtions_plan_fk_qualification FOREIGN KEY (qualification) REFERENCES qualificationtions(qualification) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3693 (class 2606 OID 18937)
-- Name: qualificationtions_plan qualificationtions_plan_fk_subjects; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualificationtions_plan
    ADD CONSTRAINT qualificationtions_plan_fk_subjects FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3608 (class 2606 OID 18942)
-- Name: school_years school_years_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3609 (class 2606 OID 18947)
-- Name: schools schools_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_fk_subject FOREIGN KEY (behavior) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3651 (class 2606 OID 18952)
-- Name: signatures signatures_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3652 (class 2606 OID 18957)
-- Name: signatures signatures_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3631 (class 2606 OID 18962)
-- Name: subjects subjects_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3694 (class 2606 OID 18967)
-- Name: teachears_notes teachears_notes_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3695 (class 2606 OID 18972)
-- Name: teachears_notes teachears_notes_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3696 (class 2606 OID 18977)
-- Name: teachears_notes teachears_notes_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3697 (class 2606 OID 18982)
-- Name: topics topics_fk_degree; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_fk_degree FOREIGN KEY (degree) REFERENCES degrees(degree) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3698 (class 2606 OID 18987)
-- Name: topics topics_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3632 (class 2606 OID 18992)
-- Name: valutations valutations_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3633 (class 2606 OID 18997)
-- Name: valutations valutations_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3634 (class 2606 OID 19002)
-- Name: valutations valutations_fk_grade_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_grade_type FOREIGN KEY (grade_type) REFERENCES grade_types(grade_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3635 (class 2606 OID 19007)
-- Name: valutations valutations_fk_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_note FOREIGN KEY (note) REFERENCES notes(note) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3636 (class 2606 OID 19012)
-- Name: valutations valutations_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3637 (class 2606 OID 19017)
-- Name: valutations valutations_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person);


--
-- TOC entry 3638 (class 2606 OID 19022)
-- Name: valutations valutations_fk_topic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_topic FOREIGN KEY (topic) REFERENCES topics(topic) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3699 (class 2606 OID 19027)
-- Name: valutations_qualificationtions valutations_qualificationtions_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualificationtions
    ADD CONSTRAINT valutations_qualificationtions_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3700 (class 2606 OID 19032)
-- Name: valutations_qualificationtions valutations_qualificationtions_fk_qualification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualificationtions
    ADD CONSTRAINT valutations_qualificationtions_fk_qualification FOREIGN KEY (qualification) REFERENCES qualificationtions(qualification) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3701 (class 2606 OID 19037)
-- Name: valutations_qualificationtions valutations_qualificationtions_fk_valutation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualificationtions
    ADD CONSTRAINT valutations_qualificationtions_fk_valutation FOREIGN KEY (valutation) REFERENCES valutations(valutation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3639 (class 2606 OID 19042)
-- Name: weekly_timetable weekly_timetable_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetable
    ADD CONSTRAINT weekly_timetable_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3640 (class 2606 OID 19047)
-- Name: weekly_timetables_days weekly_timetables_days_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3641 (class 2606 OID 19052)
-- Name: weekly_timetables_days weekly_timetables_days_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3642 (class 2606 OID 19057)
-- Name: weekly_timetables_days weekly_timetables_days_fk_weekly_timetable; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_fk_weekly_timetable FOREIGN KEY (weekly_timetable) REFERENCES weekly_timetable(weekly_timetable) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3702 (class 2606 OID 19062)
-- Name: wikimedia_files_persons wikimedia_files_persons_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3703 (class 2606 OID 19067)
-- Name: wikimedia_files_persons wikimedia_files_persons_fk_wikimedia_file; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_fk_wikimedia_file FOREIGN KEY (wikimedia_file) REFERENCES wikimedia_files(wikimedia_file) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = translate, pg_catalog;

--
-- TOC entry 3704 (class 2606 OID 19072)
-- Name: columns columns_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_fk_language FOREIGN KEY (language) REFERENCES languages(language) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3705 (class 2606 OID 19077)
-- Name: columns columns_fk_relation; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY columns
    ADD CONSTRAINT columns_fk_relation FOREIGN KEY (relation) REFERENCES relations(relation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3706 (class 2606 OID 19082)
-- Name: parameters parameters_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY parameters
    ADD CONSTRAINT parameters_fk_language FOREIGN KEY (language) REFERENCES languages(language) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3707 (class 2606 OID 19087)
-- Name: parameters parameters_fk_procedure; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY parameters
    ADD CONSTRAINT parameters_fk_procedure FOREIGN KEY (procedure) REFERENCES procedures(procedure) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3708 (class 2606 OID 19092)
-- Name: procedures procedures_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY procedures
    ADD CONSTRAINT procedures_fk_language FOREIGN KEY (language) REFERENCES languages(language);


--
-- TOC entry 3709 (class 2606 OID 19097)
-- Name: relations relations_fk_language; Type: FK CONSTRAINT; Schema: translate; Owner: postgres
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_fk_language FOREIGN KEY (language) REFERENCES languages(language) ON UPDATE CASCADE ON DELETE RESTRICT;


SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 3710 (class 2606 OID 19102)
-- Name: tests_details test_detals_fk_tests; Type: FK CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY tests_details
    ADD CONSTRAINT test_detals_fk_tests FOREIGN KEY (test) REFERENCES tests(test) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3711 (class 2606 OID 19107)
-- Name: unit_test_sets_details test_fk_unit_test_set; Type: FK CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT test_fk_unit_test_set FOREIGN KEY (unit_test_set) REFERENCES unit_test_sets(unit_test_set) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3712 (class 2606 OID 19112)
-- Name: unit_test_sets_details unit_test_sets_details_fk_unit_test_set; Type: FK CONSTRAINT; Schema: unit_testing; Owner: postgres
--

ALTER TABLE ONLY unit_test_sets_details
    ADD CONSTRAINT unit_test_sets_details_fk_unit_test_set FOREIGN KEY (unit_test_set) REFERENCES unit_test_sets(unit_test_set) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3132 (class 3466 OID 19117)
-- Name: continuous_integration; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER continuous_integration ON ddl_command_end
         WHEN TAG IN ('ALTER AGGREGATE', 'ALTER COLLATION', 'ALTER CONVERSION', 'ALTER FOREIGN TABLE', 'ALTER FUNCTION', 'ALTER OPERATOR', 'ALTER OPERATOR CLASS', 'ALTER OPERATOR FAMILY', 'ALTER POLICY', 'ALTER SEQUENCE', 'ALTER TABLE', 'ALTER TEXT SEARCH CONFIGURATION', 'ALTER TEXT SEARCH DICTIONARY', 'ALTER TEXT SEARCH PARSER', 'ALTER TEXT SEARCH TEMPLATE', 'ALTER TRIGGER', 'ALTER TYPE', 'ALTER VIEW', 'CREATE AGGREGATE', 'CREATE CAST', 'CREATE COLLATION', 'CREATE CONVERSION', 'CREATE DOMAIN', 'CREATE FOREIGN TABLE', 'CREATE FUNCTION', 'CREATE INDEX', 'CREATE LANGUAGE', 'CREATE OPERATOR', 'CREATE OPERATOR CLASS', 'CREATE OPERATOR FAMILY', 'CREATE POLICY', 'CREATE RULE', 'CREATE SCHEMA', 'CREATE SEQUENCE', 'CREATE SERVER', 'CREATE TABLE', 'CREATE TABLE AS', 'CREATE TEXT SEARCH CONFIGURATION', 'CREATE TEXT SEARCH DICTIONARY', 'CREATE TEXT SEARCH PARSER', 'CREATE TEXT SEARCH TEMPLATE', 'CREATE TRIGGER', 'CREATE TYPE', 'CREATE VIEW', 'DROP AGGREGATE', 'DROP CAST', 'DROP COLLATION', 'DROP CONVERSION', 'DROP FOREIGN TABLE', 'DROP FUNCTION', 'DROP INDEX', 'DROP LANGUAGE', 'DROP OPERATOR', 'DROP OPERATOR CLASS', 'DROP OPERATOR FAMILY', 'DROP OWNED', 'DROP POLICY', 'DROP RULE', 'DROP SCHEMA', 'DROP SEQUENCE', 'DROP SERVER', 'DROP TABLE', 'DROP TEXT SEARCH CONFIGURATION', 'DROP TEXT SEARCH DICTIONARY', 'DROP TEXT SEARCH PARSER', 'DROP TEXT SEARCH TEMPLATE', 'DROP TRIGGER', 'DROP TYPE', 'DROP USER MAPPING', 'DROP VIEW', 'GRANT', 'IMPORT FOREIGN SCHEMA', 'REVOKE', 'SECURITY LABEL')
   EXECUTE PROCEDURE unit_testing.tr_continuous_integration();


SET search_path = public, pg_catalog;

--
-- TOC entry 3930 (class 3256 OID 19118)
-- Name: schools check_all; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY check_all ON schools FOR ALL TO PUBLIC USING ((school = ANY (schools_enabled())));


--
-- TOC entry 3929 (class 0 OID 17430)
-- Name: schools; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE schools ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 9
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO scuola247_user;
GRANT ALL ON SCHEMA public TO scuola247_manager;


--
-- TOC entry 3950 (class 0 OID 0)
-- Dependencies: 1586
-- Name: address_type; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE address_type FROM PUBLIC;
GRANT ALL ON TYPE address_type TO scuola247_manager;


--
-- TOC entry 3951 (class 0 OID 0)
-- Dependencies: 1587
-- Name: course_year; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE course_year FROM PUBLIC;
GRANT ALL ON TYPE course_year TO scuola247_manager;


--
-- TOC entry 3952 (class 0 OID 0)
-- Dependencies: 1589
-- Name: explanation_type; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE explanation_type FROM PUBLIC;
GRANT ALL ON TYPE explanation_type TO scuola247_manager;


--
-- TOC entry 3953 (class 0 OID 0)
-- Dependencies: 1590
-- Name: geographical_area; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE geographical_area FROM PUBLIC;
GRANT ALL ON TYPE geographical_area TO scuola247_manager;


--
-- TOC entry 3954 (class 0 OID 0)
-- Dependencies: 1591
-- Name: language; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE language FROM PUBLIC;
GRANT ALL ON TYPE language TO scuola247_manager;


--
-- TOC entry 3955 (class 0 OID 0)
-- Dependencies: 1592
-- Name: marital_status; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE marital_status FROM PUBLIC;
GRANT ALL ON TYPE marital_status TO scuola247_manager;


--
-- TOC entry 3956 (class 0 OID 0)
-- Dependencies: 1593
-- Name: period_lesson; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE period_lesson FROM PUBLIC;
GRANT ALL ON TYPE period_lesson TO scuola247_manager;


--
-- TOC entry 3957 (class 0 OID 0)
-- Dependencies: 1595
-- Name: qualificationtion_types; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE qualificationtion_types FROM PUBLIC;
GRANT ALL ON TYPE qualificationtion_types TO scuola247_manager;


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 1596
-- Name: relationships; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE relationships FROM PUBLIC;
GRANT ALL ON TYPE relationships TO scuola247_manager;


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 1597
-- Name: role; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE role FROM PUBLIC;
GRANT ALL ON TYPE role TO scuola247_manager;


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 1598
-- Name: sex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE sex FROM PUBLIC;
GRANT ALL ON TYPE sex TO scuola247_manager;


--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 1599
-- Name: week; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE week FROM PUBLIC;
GRANT ALL ON TYPE week TO scuola247_manager;


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 1601
-- Name: week_day; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE week_day FROM PUBLIC;
GRANT ALL ON TYPE week_day TO scuola247_manager;


--
-- TOC entry 3965 (class 0 OID 0)
-- Dependencies: 587
-- Name: classroom_students_ex(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classroom_students_ex(p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION classroom_students_ex(p_classroom bigint) TO scuola247_user;


--
-- TOC entry 3966 (class 0 OID 0)
-- Dependencies: 589
-- Name: classrooms_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classrooms_list(p_school_year bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION classrooms_list(p_school_year bigint) TO scuola247_user;


--
-- TOC entry 3967 (class 0 OID 0)
-- Dependencies: 590
-- Name: classrooms_students_addresses_ex_by_classroom(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classrooms_students_addresses_ex_by_classroom(p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION classrooms_students_addresses_ex_by_classroom(p_classroom bigint) TO scuola247_user;


--
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 588
-- Name: grade_types_by_subject(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION grade_types_by_subject(p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION grade_types_by_subject(p_subject bigint) TO scuola247_user;


--
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 591
-- Name: grades_by_metric(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION grades_by_metric(p_metric bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION grades_by_metric(p_metric bigint) TO scuola247_user;


--
-- TOC entry 3970 (class 0 OID 0)
-- Dependencies: 592
-- Name: grid_valutations_columns_by_classroom_teacher_subject(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION grid_valutations_columns_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION grid_valutations_columns_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) TO scuola247_user;


--
-- TOC entry 3971 (class 0 OID 0)
-- Dependencies: 593
-- Name: grid_valutations_rows_by_classroom_teacher_subject(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION grid_valutations_rows_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION grid_valutations_rows_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) TO scuola247_user;


--
-- TOC entry 3973 (class 0 OID 0)
-- Dependencies: 594
-- Name: in_rule(character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION in_rule(p_rule character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION in_rule(p_rule character varying) TO scuola247_user;


--
-- TOC entry 3975 (class 0 OID 0)
-- Dependencies: 595
-- Name: in_rule(character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION in_rule(p_rule character varying, p_person bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION in_rule(p_rule character varying, p_person bigint) TO scuola247_user;


--
-- TOC entry 3977 (class 0 OID 0)
-- Dependencies: 596
-- Name: in_rule(character varying, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION in_rule(p_rule character varying, p_usename character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION in_rule(p_rule character varying, p_usename character varying) TO scuola247_user;


--
-- TOC entry 3978 (class 0 OID 0)
-- Dependencies: 597
-- Name: is_person_enable_to_any(character varying[], bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION is_person_enable_to_any(p_ruoli character varying[], p_person bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION is_person_enable_to_any(p_ruoli character varying[], p_person bigint) TO scuola247_user;


--
-- TOC entry 3979 (class 0 OID 0)
-- Dependencies: 598
-- Name: is_session_user_enable_to_any(character varying[]); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION is_session_user_enable_to_any(p_ruoli character varying[]) FROM PUBLIC;
GRANT ALL ON FUNCTION is_session_user_enable_to_any(p_ruoli character varying[]) TO scuola247_user;


--
-- TOC entry 3981 (class 0 OID 0)
-- Dependencies: 599
-- Name: lessons_by_teacher_classroom_subject(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) TO scuola247_user;


--
-- TOC entry 3982 (class 0 OID 0)
-- Dependencies: 600
-- Name: metrics_by_school(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION metrics_by_school(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION metrics_by_school(p_school bigint) TO scuola247_user;


--
-- TOC entry 3983 (class 0 OID 0)
-- Dependencies: 601
-- Name: persons_sel_thumbnail(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persons_sel_thumbnail(p_person bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION persons_sel_thumbnail(p_person bigint) TO scuola247_user;


--
-- TOC entry 3984 (class 0 OID 0)
-- Dependencies: 602
-- Name: persons_surname_name(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persons_surname_name(p_person bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION persons_surname_name(p_person bigint) TO scuola247_user;


--
-- TOC entry 3986 (class 0 OID 0)
-- Dependencies: 603
-- Name: photo_default(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION photo_default() FROM PUBLIC;
GRANT ALL ON FUNCTION photo_default() TO scuola247_user;
GRANT ALL ON FUNCTION photo_default() TO scuola247_manager;


--
-- TOC entry 3987 (class 0 OID 0)
-- Dependencies: 604
-- Name: qualificationtions_tree(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION qualificationtions_tree() FROM PUBLIC;
GRANT ALL ON FUNCTION qualificationtions_tree() TO scuola247_user;


--
-- TOC entry 3988 (class 0 OID 0)
-- Dependencies: 605
-- Name: relatives_by_classroom(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION relatives_by_classroom(p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION relatives_by_classroom(p_classroom bigint) TO scuola247_user;


--
-- TOC entry 3989 (class 0 OID 0)
-- Dependencies: 606
-- Name: rs_columns_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION rs_columns_list() FROM PUBLIC;
GRANT ALL ON FUNCTION rs_columns_list() TO scuola247_user;


--
-- TOC entry 3990 (class 0 OID 0)
-- Dependencies: 607
-- Name: rs_rows_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION rs_rows_list() FROM PUBLIC;
GRANT ALL ON FUNCTION rs_rows_list() TO scuola247_user;


--
-- TOC entry 3991 (class 0 OID 0)
-- Dependencies: 608
-- Name: ruoli_by_session_user(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION ruoli_by_session_user() FROM PUBLIC;
GRANT ALL ON FUNCTION ruoli_by_session_user() TO scuola247_user;


--
-- TOC entry 3992 (class 0 OID 0)
-- Dependencies: 609
-- Name: school_years_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION school_years_list(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION school_years_list(p_school bigint) TO scuola247_user;


--
-- TOC entry 3993 (class 0 OID 0)
-- Dependencies: 611
-- Name: schools_by_description(character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_by_description(p_description character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_by_description(p_description character varying) TO scuola247_user;


--
-- TOC entry 3994 (class 0 OID 0)
-- Dependencies: 612
-- Name: schools_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_del(p_rv bigint, p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_del(p_rv bigint, p_school bigint) TO scuola247_user;


--
-- TOC entry 3996 (class 0 OID 0)
-- Dependencies: 610
-- Name: schools_del_cascade(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_del_cascade(school_da_cancellare bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_del_cascade(school_da_cancellare bigint) TO scuola247_user;


--
-- TOC entry 3997 (class 0 OID 0)
-- Dependencies: 613
-- Name: schools_enabled(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION schools_enabled() TO scuola247_user;


--
-- TOC entry 3998 (class 0 OID 0)
-- Dependencies: 614
-- Name: schools_ins(character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) TO scuola247_user;


--
-- TOC entry 3999 (class 0 OID 0)
-- Dependencies: 616
-- Name: schools_ins(character varying, character varying, character varying, boolean, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_ins(OUT p_rv bigint, OUT p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) TO scuola247_user;


--
-- TOC entry 4000 (class 0 OID 0)
-- Dependencies: 615
-- Name: schools_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_list() FROM PUBLIC;
GRANT ALL ON FUNCTION schools_list() TO scuola247_user;


--
-- TOC entry 4001 (class 0 OID 0)
-- Dependencies: 617
-- Name: schools_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_sel(OUT p_rv bigint, p_school bigint, OUT p_description character varying, OUT p_on_date_processing_code character varying, OUT p_mnemonic character varying, OUT p_example boolean, OUT p_logo bytea) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_sel(OUT p_rv bigint, p_school bigint, OUT p_description character varying, OUT p_on_date_processing_code character varying, OUT p_mnemonic character varying, OUT p_example boolean, OUT p_logo bytea) TO scuola247_user;


--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 618
-- Name: schools_sel_logo(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_sel_logo(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_sel_logo(p_school bigint) TO scuola247_user;


--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 619
-- Name: schools_upd(bigint, bigint, character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean) TO scuola247_user;


--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 621
-- Name: schools_upd(bigint, bigint, character varying, character varying, character varying, boolean, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_upd(p_rv bigint, p_school bigint, p_description character varying, p_on_date_processing_code character varying, p_mnemonic character varying, p_example boolean, p_logo bytea) TO scuola247_user;


--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 622
-- Name: schools_upd_logo(bigint, bigint, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_upd_logo(p_rv bigint, p_school bigint, p_logo bytea) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_upd_logo(p_rv bigint, p_school bigint, p_logo bytea) TO scuola247_user;


--
-- TOC entry 4007 (class 0 OID 0)
-- Dependencies: 623
-- Name: session_db_user(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION session_db_user() FROM PUBLIC;
GRANT ALL ON FUNCTION session_db_user() TO scuola247_user;


--
-- TOC entry 4009 (class 0 OID 0)
-- Dependencies: 620
-- Name: session_person(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION session_person(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION session_person(p_school bigint) TO scuola247_user;


--
-- TOC entry 4010 (class 0 OID 0)
-- Dependencies: 624
-- Name: set_work_space_default(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION set_work_space_default(p_work_space bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION set_work_space_default(p_work_space bigint) TO scuola247_user;


--
-- TOC entry 4011 (class 0 OID 0)
-- Dependencies: 625
-- Name: signatures_by_teacher_classroom(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION signatures_by_teacher_classroom(p_teacher bigint, p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION signatures_by_teacher_classroom(p_teacher bigint, p_classroom bigint) TO scuola247_user;


--
-- TOC entry 4012 (class 0 OID 0)
-- Dependencies: 626
-- Name: students_by_classroom(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION students_by_classroom(p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION students_by_classroom(p_classroom bigint) TO scuola247_user;


--
-- TOC entry 4013 (class 0 OID 0)
-- Dependencies: 627
-- Name: subjects_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_del(p_rv bigint, p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_del(p_rv bigint, p_subject bigint) TO scuola247_user;


--
-- TOC entry 4014 (class 0 OID 0)
-- Dependencies: 628
-- Name: subjects_ins(bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying) TO scuola247_user;


--
-- TOC entry 4015 (class 0 OID 0)
-- Dependencies: 630
-- Name: subjects_ins(bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_ins(OUT p_rv bigint, OUT p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) TO scuola247_user;


--
-- TOC entry 4016 (class 0 OID 0)
-- Dependencies: 629
-- Name: subjects_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_list(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_list(p_school bigint) TO scuola247_user;


--
-- TOC entry 4017 (class 0 OID 0)
-- Dependencies: 631
-- Name: subjects_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) TO scuola247_user;


--
-- TOC entry 4018 (class 0 OID 0)
-- Dependencies: 632
-- Name: subjects_upd(bigint, bigint, bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_upd(p_rv bigint, p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_upd(p_rv bigint, p_subject bigint, p_school bigint, p_description character varying, p_metric bigint) TO scuola247_user;


--
-- TOC entry 4019 (class 0 OID 0)
-- Dependencies: 633
-- Name: teachers_by_school(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION teachers_by_school(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION teachers_by_school(p_school bigint) TO scuola247_user;


--
-- TOC entry 4021 (class 0 OID 0)
-- Dependencies: 634
-- Name: thumbnail_default(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION thumbnail_default() FROM PUBLIC;
GRANT ALL ON FUNCTION thumbnail_default() TO scuola247_user;
GRANT ALL ON FUNCTION thumbnail_default() TO scuola247_manager;


--
-- TOC entry 4022 (class 0 OID 0)
-- Dependencies: 635
-- Name: topics_by_subject_classroom(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION topics_by_subject_classroom(p_subject bigint, p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION topics_by_subject_classroom(p_subject bigint, p_classroom bigint) TO scuola247_user;


--
-- TOC entry 4023 (class 0 OID 0)
-- Dependencies: 636
-- Name: topics_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION topics_del(p_rv bigint, p_topic bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION topics_del(p_rv bigint, p_topic bigint) TO scuola247_user;


--
-- TOC entry 4024 (class 0 OID 0)
-- Dependencies: 637
-- Name: topics_ins_rid(bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION topics_ins_rid(OUT p_rv bigint, OUT p_topic bigint, p_subject bigint, p_description character varying, p_classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION topics_ins_rid(OUT p_rv bigint, OUT p_topic bigint, p_subject bigint, p_description character varying, p_classroom bigint) TO scuola247_user;


--
-- TOC entry 4025 (class 0 OID 0)
-- Dependencies: 638
-- Name: topics_upd_rid(bigint, bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION topics_upd_rid(p_rv bigint, p_topic bigint, p_description character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION topics_upd_rid(p_rv bigint, p_topic bigint, p_description character varying) TO scuola247_user;


--
-- TOC entry 4026 (class 0 OID 0)
-- Dependencies: 639
-- Name: tr_absences_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_absences_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_absences_iu() TO scuola247_user;
GRANT ALL ON FUNCTION tr_absences_iu() TO scuola247_manager;


--
-- TOC entry 4027 (class 0 OID 0)
-- Dependencies: 640
-- Name: tr_classrooms_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_classrooms_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_classrooms_iu() TO scuola247_user;


--
-- TOC entry 4028 (class 0 OID 0)
-- Dependencies: 641
-- Name: tr_classrooms_students_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_classrooms_students_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_classrooms_students_iu() TO scuola247_user;


--
-- TOC entry 4029 (class 0 OID 0)
-- Dependencies: 642
-- Name: tr_communications_media_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_communications_media_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_communications_media_iu() TO scuola247_user;


--
-- TOC entry 4030 (class 0 OID 0)
-- Dependencies: 643
-- Name: tr_conversations_invites_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_conversations_invites_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_conversations_invites_iu() TO scuola247_user;


--
-- TOC entry 4031 (class 0 OID 0)
-- Dependencies: 644
-- Name: tr_db_users_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_db_users_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_db_users_iu() TO scuola247_user;


--
-- TOC entry 4032 (class 0 OID 0)
-- Dependencies: 646
-- Name: tr_delays_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_delays_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_delays_iu() TO scuola247_user;


--
-- TOC entry 4033 (class 0 OID 0)
-- Dependencies: 647
-- Name: tr_explanations_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_explanations_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_explanations_iu() TO scuola247_user;
GRANT ALL ON FUNCTION tr_explanations_iu() TO scuola247_manager;


--
-- TOC entry 4034 (class 0 OID 0)
-- Dependencies: 645
-- Name: tr_faults_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_faults_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_faults_iu() TO scuola247_user;
GRANT ALL ON FUNCTION tr_faults_iu() TO scuola247_manager;


--
-- TOC entry 4035 (class 0 OID 0)
-- Dependencies: 648
-- Name: tr_grading_meetings_i(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_i() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_i() TO scuola247_user;


--
-- TOC entry 4036 (class 0 OID 0)
-- Dependencies: 649
-- Name: tr_grading_meetings_valutations_d(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_d() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_d() TO scuola247_user;


--
-- TOC entry 4037 (class 0 OID 0)
-- Dependencies: 650
-- Name: tr_grading_meetings_valutations_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_iu() TO scuola247_user;


--
-- TOC entry 4038 (class 0 OID 0)
-- Dependencies: 651
-- Name: tr_grading_meetings_valutations_qua_d(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_qua_d() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_qua_d() TO scuola247_user;


--
-- TOC entry 4039 (class 0 OID 0)
-- Dependencies: 652
-- Name: tr_grading_meetings_valutations_qua_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_qua_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_qua_iu() TO scuola247_user;


--
-- TOC entry 4040 (class 0 OID 0)
-- Dependencies: 653
-- Name: tr_leavings_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_leavings_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_leavings_iu() TO scuola247_user;


--
-- TOC entry 4041 (class 0 OID 0)
-- Dependencies: 654
-- Name: tr_lessons_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_lessons_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_lessons_iu() TO scuola247_user;
GRANT ALL ON FUNCTION tr_lessons_iu() TO scuola247_manager;


--
-- TOC entry 4042 (class 0 OID 0)
-- Dependencies: 655
-- Name: tr_messages_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_messages_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_messages_iu() TO scuola247_user;


--
-- TOC entry 4043 (class 0 OID 0)
-- Dependencies: 656
-- Name: tr_messages_read_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_messages_read_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_messages_read_iu() TO scuola247_user;


--
-- TOC entry 4044 (class 0 OID 0)
-- Dependencies: 658
-- Name: tr_notes_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_notes_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_notes_iu() TO scuola247_user;


--
-- TOC entry 4045 (class 0 OID 0)
-- Dependencies: 660
-- Name: tr_notes_signed_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_notes_signed_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_notes_signed_iu() TO scuola247_user;


--
-- TOC entry 4046 (class 0 OID 0)
-- Dependencies: 657
-- Name: tr_out_of_classrooms_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_out_of_classrooms_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_out_of_classrooms_iu() TO scuola247_user;


--
-- TOC entry 4047 (class 0 OID 0)
-- Dependencies: 661
-- Name: tr_parents_meetings_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_parents_meetings_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_parents_meetings_iu() TO scuola247_user;


--
-- TOC entry 4048 (class 0 OID 0)
-- Dependencies: 662
-- Name: tr_schools_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_schools_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_schools_iu() TO scuola247_user;


--
-- TOC entry 4049 (class 0 OID 0)
-- Dependencies: 663
-- Name: tr_signatures_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_signatures_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_signatures_iu() TO scuola247_user;
GRANT ALL ON FUNCTION tr_signatures_iu() TO scuola247_manager;


--
-- TOC entry 4050 (class 0 OID 0)
-- Dependencies: 664
-- Name: tr_teachears_notes_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_teachears_notes_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_teachears_notes_iu() TO scuola247_user;


--
-- TOC entry 4051 (class 0 OID 0)
-- Dependencies: 665
-- Name: tr_topics_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_topics_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_topics_iu() TO scuola247_user;


--
-- TOC entry 4052 (class 0 OID 0)
-- Dependencies: 666
-- Name: tr_valutations_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_valutations_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_valutations_iu() TO scuola247_user;


--
-- TOC entry 4053 (class 0 OID 0)
-- Dependencies: 659
-- Name: tr_valutations_qualificationtions_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_valutations_qualificationtions_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_valutations_qualificationtions_iu() TO scuola247_user;


--
-- TOC entry 4054 (class 0 OID 0)
-- Dependencies: 667
-- Name: tr_weekly_timetables_days_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_weekly_timetables_days_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_weekly_timetables_days_iu() TO scuola247_user;


--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 668
-- Name: uno_nei_ruoli(character varying[]); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION uno_nei_ruoli(p_ruoli character varying[]) FROM PUBLIC;
GRANT ALL ON FUNCTION uno_nei_ruoli(p_ruoli character varying[]) TO scuola247_user;


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 669
-- Name: update_person_photo_and_thumbnail(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION update_person_photo_and_thumbnail() FROM PUBLIC;
GRANT ALL ON FUNCTION update_person_photo_and_thumbnail() TO scuola247_user;


--
-- TOC entry 4057 (class 0 OID 0)
-- Dependencies: 670
-- Name: valutations_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_del(p_rv bigint, p_valutation bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_del(p_rv bigint, p_valutation bigint) TO scuola247_user;


--
-- TOC entry 4058 (class 0 OID 0)
-- Dependencies: 671
-- Name: valutations_ex_by_classroom_teacher_subject(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_ex_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_ex_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) TO scuola247_user;


--
-- TOC entry 4059 (class 0 OID 0)
-- Dependencies: 672
-- Name: valutations_ins(bigint, bigint, bigint, bigint, bigint, bigint, character varying, boolean, bigint, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_ins(OUT p_rv bigint, OUT p_valutation bigint, p_classroom bigint, p_student bigint, p_subject bigint, p_grade_type bigint, p_topic bigint, p_grade bigint, p_evaluation character varying, p_private boolean, p_teacher bigint, p_on_date date) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_ins(OUT p_rv bigint, OUT p_valutation bigint, p_classroom bigint, p_student bigint, p_subject bigint, p_grade_type bigint, p_topic bigint, p_grade bigint, p_evaluation character varying, p_private boolean, p_teacher bigint, p_on_date date) TO scuola247_user;


--
-- TOC entry 4060 (class 0 OID 0)
-- Dependencies: 674
-- Name: valutations_ins_note(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_ins_note(OUT p_rv bigint, OUT p_note bigint, p_valutation bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_ins_note(OUT p_rv bigint, OUT p_note bigint, p_valutation bigint) TO scuola247_user;


--
-- TOC entry 4061 (class 0 OID 0)
-- Dependencies: 675
-- Name: valutations_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) TO scuola247_user;


--
-- TOC entry 4062 (class 0 OID 0)
-- Dependencies: 676
-- Name: valutations_upd(bigint, bigint, character varying, boolean, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_upd(p_rv bigint, p_valutation bigint, p_evaluation character varying, p_private boolean, p_note boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_upd(p_rv bigint, p_valutation bigint, p_evaluation character varying, p_private boolean, p_note boolean) TO scuola247_user;


--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 678
-- Name: valutations_upd_grade(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) TO scuola247_user;


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 204
-- Name: pk_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE pk_seq TO scuola247_manager;


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 205
-- Name: branches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE branches TO scuola247_manager;


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 206
-- Name: classrooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms TO scuola247_manager;


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 207
-- Name: school_years; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE school_years TO scuola247_manager;


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 208
-- Name: schools; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE schools FROM postgres;
GRANT ALL ON TABLE schools TO scuola247_manager;
GRANT ALL ON TABLE schools TO scuola247_user;


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 209
-- Name: classrooms_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_ex TO scuola247_user;
GRANT ALL ON TABLE classrooms_ex TO scuola247_manager;


--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 679
-- Name: w_classrooms_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classrooms_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_classrooms_ex() TO scuola247_user;


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 210
-- Name: absences; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences TO scuola247_manager;


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 211
-- Name: classrooms_students; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_students TO scuola247_manager;


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 212
-- Name: absences_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_grp TO scuola247_manager;


--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 213
-- Name: absences_not_explanated_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_not_explanated_grp TO scuola247_manager;


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 214
-- Name: cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE cities TO scuola247_manager;


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 215
-- Name: delays; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays TO scuola247_manager;


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 216
-- Name: delays_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_grp TO scuola247_manager;


--
-- TOC entry 4096 (class 0 OID 0)
-- Dependencies: 217
-- Name: delays_not_explained_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_not_explained_grp TO scuola247_manager;


--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 218
-- Name: leavings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings TO scuola247_manager;


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 219
-- Name: leavings_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_grp TO scuola247_manager;


--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 220
-- Name: leavings_not_explained_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_not_explained_grp TO scuola247_manager;


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 221
-- Name: notes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes TO scuola247_manager;


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 222
-- Name: notes_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_grp TO scuola247_manager;


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 223
-- Name: out_of_classrooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms TO scuola247_manager;


--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 224
-- Name: out_of_classrooms_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_grp TO scuola247_manager;


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 225
-- Name: persons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE persons TO scuola247_manager;


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 226
-- Name: classrooms_students_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_students_ex TO scuola247_manager;


--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 680
-- Name: w_classrooms_students_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classrooms_students_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_classrooms_students_ex() TO scuola247_user;


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 227
-- Name: subjects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE subjects TO scuola247_manager;


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 228
-- Name: valutations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations TO scuola247_manager;


--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 229
-- Name: classrooms_teachers_subjects_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers_subjects_ex TO scuola247_manager;


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 230
-- Name: weekly_timetable; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetable TO scuola247_manager;


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 231
-- Name: weekly_timetable_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetable_ex TO scuola247_manager;


--
-- TOC entry 4128 (class 0 OID 0)
-- Dependencies: 673
-- Name: w_weekly_timetable_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_weekly_timetable_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_weekly_timetable_ex() TO scuola247_user;


--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 232
-- Name: weekly_timetables_days; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetables_days TO scuola247_manager;


--
-- TOC entry 4132 (class 0 OID 0)
-- Dependencies: 233
-- Name: weekly_timetables_days_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetables_days_ex TO scuola247_manager;


--
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 677
-- Name: w_weekly_timetables_days_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_weekly_timetables_days_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_weekly_timetables_days_ex() TO scuola247_user;


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 681
-- Name: weekly_timetable_xt_subject(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION weekly_timetable_xt_subject(p_weekly_timetable bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION weekly_timetable_xt_subject(p_weekly_timetable bigint) TO scuola247_user;


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 682
-- Name: weekly_timetable_xt_teacher(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION weekly_timetable_xt_teacher(p_weekly_timetable bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION weekly_timetable_xt_teacher(p_weekly_timetable bigint) TO scuola247_user;


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 683
-- Name: where_sequence(text, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION where_sequence(name text, search_value bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION where_sequence(name text, search_value bigint) TO scuola247_user;


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 704
-- Name: work_spaces_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION work_spaces_del(p_rv bigint, p_work_space bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION work_spaces_del(p_rv bigint, p_work_space bigint) TO scuola247_user;


--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 705
-- Name: work_spaces_ins(character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION work_spaces_ins(OUT p_rv bigint, OUT p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION work_spaces_ins(OUT p_rv bigint, OUT p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) TO scuola247_user;


--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 706
-- Name: work_spaces_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION work_spaces_list() FROM PUBLIC;
GRANT ALL ON FUNCTION work_spaces_list() TO scuola247_user;


--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 707
-- Name: work_spaces_upd(bigint, bigint, character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION work_spaces_upd(p_rv bigint, p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION work_spaces_upd(p_rv bigint, p_work_space bigint, p_description character varying, p_school bigint, p_school_year bigint, p_classroom bigint, p_subject bigint, p_teacher bigint, p_family bigint, p_student bigint) TO scuola247_user;


SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 708
-- Name: tr_dependencies_iu(); Type: ACL; Schema: unit_testing; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_dependencies_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_dependencies_iu() TO scuola247_user;
GRANT ALL ON FUNCTION tr_dependencies_iu() TO scuola247_manager;


SET search_path = utility, pg_catalog;

--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 709
-- Name: count_value(text, text, text); Type: ACL; Schema: utility; Owner: postgres
--

REVOKE ALL ON FUNCTION count_value(search_db text, search_schema text, search_table text) FROM PUBLIC;
GRANT ALL ON FUNCTION count_value(search_db text, search_schema text, search_table text) TO scuola247_user;


SET search_path = public, pg_catalog;

--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 237
-- Name: absences_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_certified_grp TO scuola247_manager;


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 239
-- Name: explanations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE explanations TO scuola247_manager;


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 240
-- Name: absences_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_ex TO scuola247_manager;


--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 241
-- Name: absences_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_month_grp TO scuola247_manager;


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 242
-- Name: delays_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_month_grp TO scuola247_manager;


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 243
-- Name: leavings_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_month_grp TO scuola247_manager;


--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 244
-- Name: notes_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_month_grp TO scuola247_manager;


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 245
-- Name: out_of_classrooms_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_month_grp TO scuola247_manager;


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 246
-- Name: classbooks_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classbooks_month_grp TO scuola247_manager;


--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 247
-- Name: persons_addresses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE persons_addresses TO scuola247_manager;


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 248
-- Name: classrooms_students_addresses_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_students_addresses_ex TO scuola247_manager;


--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 249
-- Name: lessons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons TO scuola247_manager;


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 250
-- Name: classrooms_teachers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers TO scuola247_manager;


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 251
-- Name: delays_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_certified_grp TO scuola247_manager;


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 252
-- Name: leavings_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_certified_grp TO scuola247_manager;


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 253
-- Name: lessons_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons_grp TO scuola247_manager;


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 254
-- Name: notes_iussed_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_iussed_grp TO scuola247_manager;


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 255
-- Name: out_of_classrooms_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_certified_grp TO scuola247_manager;


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 256
-- Name: signatures; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE signatures TO scuola247_manager;


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 257
-- Name: signatures_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE signatures_grp TO scuola247_manager;


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 258
-- Name: classrooms_teachers_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers_ex TO scuola247_manager;


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 259
-- Name: classrooms_teachers_subject; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers_subject TO scuola247_manager;


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 260
-- Name: communication_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE communication_types TO scuola247_manager;


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 261
-- Name: communications_media; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE communications_media TO scuola247_manager;


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 262
-- Name: conversations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE conversations TO scuola247_manager;


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 263
-- Name: conversations_invites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE conversations_invites TO scuola247_manager;


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 264
-- Name: countries; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE countries TO scuola247_manager;


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 265
-- Name: degrees; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE degrees TO scuola247_manager;


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 266
-- Name: delays_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_ex TO scuola247_manager;


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 267
-- Name: districts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE districts TO scuola247_manager;


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 268
-- Name: faults; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE faults TO scuola247_manager;


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 269
-- Name: faults_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE faults_grp TO scuola247_manager;


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 270
-- Name: grade_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grade_types TO scuola247_manager;


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 271
-- Name: grades; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grades TO scuola247_manager;


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 272
-- Name: grading_meetings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grading_meetings TO scuola247_manager;


--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 273
-- Name: grading_meetings_valutations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grading_meetings_valutations TO scuola247_manager;


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 274
-- Name: grading_meetings_valutations_qua; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grading_meetings_valutations_qua TO scuola247_manager;


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 275
-- Name: holydays; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE holydays TO scuola247_manager;


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 276
-- Name: leavings_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_ex TO scuola247_manager;


--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 277
-- Name: lessons_days; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons_days TO scuola247_manager;


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 278
-- Name: lessons_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons_ex TO scuola247_manager;


--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 279
-- Name: messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE messages TO scuola247_manager;


--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 280
-- Name: messages_read; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE messages_read TO scuola247_manager;


--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 281
-- Name: metrics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE metrics TO scuola247_manager;


--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 282
-- Name: notes_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_ex TO scuola247_manager;


--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 283
-- Name: notes_signed; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_signed TO scuola247_manager;


--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 284
-- Name: notes_signed_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_signed_ex TO scuola247_manager;


--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 285
-- Name: out_of_classrooms_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_ex TO scuola247_manager;


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 286
-- Name: parents_meetings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE parents_meetings TO scuola247_manager;


--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 287
-- Name: persons_relations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE persons_relations TO scuola247_manager;


--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 289
-- Name: qualificationtions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE qualificationtions TO scuola247_manager;


--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 290
-- Name: qualificationtions_plan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE qualificationtions_plan TO scuola247_manager;


--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 291
-- Name: regions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE regions TO scuola247_manager;


--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 292
-- Name: residence_grp_city; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE residence_grp_city TO scuola247_manager;


--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 293
-- Name: schools_school_years_classrooms_weekly_timetable; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE schools_school_years_classrooms_weekly_timetable TO scuola247_manager;


--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 294
-- Name: signatures_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE signatures_ex TO scuola247_manager;


--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 295
-- Name: system_messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE system_messages TO scuola247_manager;


--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 296
-- Name: teachears_notes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE teachears_notes TO scuola247_manager;


--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 297
-- Name: teachers_classbooks_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE teachers_classbooks_ex TO scuola247_manager;


--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 298
-- Name: teachers_lessons_signatures_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE teachers_lessons_signatures_ex TO scuola247_manager;


--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 299
-- Name: topics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE topics TO scuola247_manager;


--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 300
-- Name: usenames_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE usenames_ex TO scuola247_manager;


--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 301
-- Name: usenames_rolnames; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE usenames_rolnames TO scuola247_manager;


--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 302
-- Name: valutations_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_ex TO scuola247_manager;


--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 303
-- Name: valutations_references; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_references TO scuola247_manager;


--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 304
-- Name: valutations_ex_references; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_ex_references TO scuola247_manager;


--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 305
-- Name: valutations_qualificationtions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_qualificationtions TO scuola247_manager;


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 306
-- Name: valutations_stats_classrooms_students_subjects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_students_subjects TO scuola247_manager;


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 307
-- Name: valutations_stats_classrooms_students_subjects_on_date; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_students_subjects_on_date TO scuola247_manager;


--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 308
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_students_subjects_on_date_ex TO scuola247_manager;


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 310
-- Name: valutations_stats_classrooms_subjects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_subjects TO scuola247_manager;


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 311
-- Name: valutations_stats_classrooms_subjects_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_subjects_ex TO scuola247_manager;


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 312
-- Name: weekly_timetable_teachers_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetable_teachers_ex TO scuola247_manager;


SET search_path = unit_testing, pg_catalog;

--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 324
-- Name: system_messages; Type: ACL; Schema: unit_testing; Owner: postgres
--

GRANT ALL ON TABLE system_messages TO scuola247_manager;


-- Completed on 2016-12-20 13:00:30 CET

--
-- PostgreSQL database dump complete
--

