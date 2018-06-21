-- Function: unit_tests_security.create_role(boolean)

-- DROP FUNCTION unit_tests_security.create_role(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.create_role(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;

  BEGIN
    ---------------------------
    test_name = 'CREATE ROLES';
    ---------------------------
    PERFORM special.scuola247_create_user('test-supervisor@scuola.it', 'password', 'scuola247_supervisor', 'it', 1000000000, 2000000000, 28961000000000);
    PERFORM special.scuola247_create_user('test-manager-a@scuola-1.it', 'password', 'scuola247_executive', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-manager-b@scuola-1.it', 'password', 'scuola247_executive', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-manager-c@scuola-2.it', 'password', 'scuola247_executive', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-manager-d@scuola-2.it', 'password', 'scuola247_executive', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-manager-e@scuola-28961.it', 'password', 'scuola247_executive', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-manager-f@scuola-28961.it', 'password', 'scuola247_executive', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-employee-a@scuola-1.it', 'password', 'scuola247_employee', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-employee-b@scuola-1.it', 'password', 'scuola247_employee', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-employee-c@scuola-2.it', 'password', 'scuola247_employee', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-employee-d@scuola-2.it', 'password', 'scuola247_employee', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-employee-e@scuola-28961.it', 'password', 'scuola247_employee', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-employee-f@scuola-28961.it', 'password', 'scuola247_employee', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-teacher-a@scuola-1.it', 'password', 'scuola247_teacher', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-teacher-b@scuola-1.it', 'password', 'scuola247_teacher', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-teacher-c@scuola-2.it', 'password', 'scuola247_teacher', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-teacher-d@scuola-2.it', 'password', 'scuola247_teacher', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-teacher-e@scuola-28961.it', 'password', 'scuola247_teacher', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-teacher-f@scuola-28961.it', 'password', 'scuola247_teacher', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-relative-a@scuola-1.it', 'password', 'scuola247_relative', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-relative-b@scuola-1.it', 'password', 'scuola247_relative', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-relative-c@scuola-2.it', 'password', 'scuola247_relative', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-relative-d@scuola-2.it', 'password', 'scuola247_relative', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-relative-e@scuola-28961.it', 'password', 'scuola247_relative', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-relative-f@scuola-28961.it', 'password', 'scuola247_relative', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-student-a@scuola-1.it', 'password', 'scuola247_student', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-student-b@scuola-1.it', 'password', 'scuola247_student', 'it', 1000000000);
    PERFORM special.scuola247_create_user('test-student-c@scuola-2.it', 'password', 'scuola247_student', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-student-d@scuola-2.it', 'password', 'scuola247_student', 'it', 2000000000);
    PERFORM special.scuola247_create_user('test-student-e@scuola-28961.it', 'password', 'scuola247_student', 'it', 28961000000000);
    PERFORM special.scuola247_create_user('test-student-f@scuola-28961.it', 'password', 'scuola247_student', 'it', 28961000000000);  
    PERFORM special.scuola247_create_user('test-user@scuola.it', 'password', 'scuola247_user', 'it', NULL);  
    
    _results = _results || assert.pass(full_function_name, test_name);

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.fail(full_function_name, test_name, 'CREATE ROLE FAILED'::text, error);
    RETURN;
  END;

RETURN;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.create_role(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.create_role(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.create_role(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.create_role(boolean) TO scuola247_user;
