-- Function: unit_tests_security.set_role_vertical(boolean)

-- DROP FUNCTION unit_tests_security.set_role_vertical(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.set_role_vertical(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

    -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role', 'unit_tests_public._after_data_insert');
    RETURN;
  END IF;

  BEGIN
    ---------------------------
    test_name = 'SET ROLES';
    ---------------------------

    -- 'test-supervisor@scuola.it';
    _results = _results || unit_tests_security.test_current_role('scuola247_supervisor','test-supervisor@scuola.it');
  

    -- 'test-executive-a@scuola-1.it';
    _results = _results || unit_tests_security.test_current_role('scuola247_executive','test-executive-a@scuola-1.it');
    

    -- 'test-employee-a@scuola-1.it';
    _results = _results || unit_tests_security.test_current_role('scuola247_employee','test-employee-a@scuola-1.it');
    

    -- 'test-teacher-a@scuola-1.it';
    _results = _results || unit_tests_security.test_current_role('scuola247_teacher','test-teacher-a@scuola-1.it');
    

    -- 'test-student-a@scuola-1.it';
    _results = _results || unit_tests_security.test_current_role('scuola247_student','test-student-a@scuola-1.it');
    

    -- 'test-relative-a@scuola-1.it';
    _results = _results || unit_tests_security.test_current_role('scuola247_relative','test-relative-a@scuola-1.it');
   

    _results = _results || assert.pass(full_function_name, test_name);

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.fail(full_function_name, test_name, format('SET ROLE %s FAILED'::text, current_user) , error);
    
    RETURN;
END;

RETURN;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.set_role_vertical(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.set_role_vertical(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.set_role_vertical(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.set_role_vertical(boolean) TO scuola247_user;
