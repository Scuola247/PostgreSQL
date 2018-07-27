-- Function: unit_tests_diagnostic.function_name(boolean)

-- DROP FUNCTION unit_tests_diagnostic.function_name(boolean);

CREATE OR REPLACE FUNCTION unit_tests_diagnostic.function_name(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	  text;
  test_name		          text = '';
  error			            diagnostic.error;
  context_example text = 'PL/pgSQL function unit_tests_public.function_name_example_for_testing(boolean) line 9 at GET DIAGNOSTICS SQL statement "SELECT unit_tests_public.absences_foreign_key();" PL/pgSQL function unit_testing.run(text,boolean,boolean,boolean,bigint,oid,text) line 207 at EXECUTE';
  expected_function_name text = 'unit_tests_public.function_name_example_for_testing';
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;
  ----------------------------------
  test_name = 'CHECK function_name';
  ----------------------------------
  BEGIN
    _results = _results || assert.are_equals(full_function_name, test_name, diagnostic.function_name(context_example), expected_function_name);
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;

    EXCEPTION
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_diagnostic.function_name(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_diagnostic.function_name(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_diagnostic.function_name(boolean) TO scuola247_user;
REVOKE ALL ON FUNCTION unit_tests_diagnostic.function_name (boolean) FROM public;
