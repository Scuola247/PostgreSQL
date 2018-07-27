CREATE OR REPLACE FUNCTION unit_tests_special.scuola247_create_user(
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
  test_user text = 'test_user_123_sa_sa_sa';
  user_name_retrieved text;
  test_user_school bigint;
  expected_school bigint = 1000000000; 
  test_user_language utility.language;
  expected_language utility.language = 'it';
  command text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;
  ------------------------------------------
  test_name = 'CHECK scuola247_create_user';
  ------------------------------------------
  BEGIN
    PERFORM special.scuola247_create_user(test_user, 'scuola247_student'::special.scuola247_groups,'it'::utility.language,1000000000);
    
    /*
    PERFORM 1 FROM pg_authid WHERE rolname = test_user;
    
    IF FOUND THEN 
      _results = _results || assert.pass(full_function_name, test_name);
    ELSE
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
      RESET ROLE;
      RETURN
    END IF
    */


    EXECUTE format('SELECT rolname FROM pg_authid WHERE rolname = %L',test_user) INTO user_name_retrieved;
    _results = _results || assert.are_equals(full_function_name,test_name,user_name_retrieved::text,test_user);
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN  RETURN; END IF;

    EXECUTE format('SELECT school FROM usenames_schools WHERE usename = %L;',test_user) INTO test_user_school;
    _results = _results || assert.are_equals(full_function_name,test_name,test_user_school,expected_school);
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;

    EXECUTE format('SELECT language FROM usenames_ex WHERE usename = %L;',test_user) INTO test_user_language;
    _results = _results || assert.are_equals(full_function_name,test_name,test_user_language,expected_language);
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
ALTER FUNCTION unit_tests_special.scuola247_create_user(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_special.scuola247_create_user(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_special.scuola247_create_user(boolean) TO scuola247_user;
REVOKE ALL ON FUNCTION unit_tests_special.scuola247_create_user(boolean) FROM public;
