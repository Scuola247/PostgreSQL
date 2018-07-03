-- Function: unit_tests_security.check_all(boolean)

-- DROP FUNCTION unit_tests_security.check_all(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.check_all(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role');
    RETURN;
  END IF;

  BEGIN
    ---------------------------
    test_name = 'SET ROLES';
    ---------------------------
    
    _results = _results || unit_tests_security.check_user_group_role('unit_testing_supervisor_security@scuola.it','scuola247_supervisor');   
    _results = _results || unit_tests_security.check_user_group_role('unit_testing_executive_g@scuola_2000000200.it','scuola247_executive');   
    _results = _results || unit_tests_security.check_user_group_role('unit_testing_employee_g@scuola_2000000200.it','scuola247_employee');   
    _results = _results || unit_tests_security.check_user_group_role('unit_testing_teacher_g@scuola_2000000200.it', 'scuola247_teacher');  
    _results = _results || unit_tests_security.check_user_group_role('unit_testing_student_g@scuola_2000000200.it','scuola247_student');
    _results = _results || unit_tests_security.check_user_group_role('unit_testing_relative_g@scuola_2000000200.it','scuola247_relative');

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
ALTER FUNCTION unit_tests_security.check_all(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_all(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_all(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_all(boolean) TO scuola247_user;
