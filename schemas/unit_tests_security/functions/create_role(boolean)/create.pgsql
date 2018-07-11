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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.insert_data');
    RETURN;
  END IF;

  BEGIN
    ---------------------------
    test_name = 'CREATE ROLES';
    ---------------------------
    PERFORM special.scuola247_create_user('u_testing_supervisor@scuola.it', 'scuola247_supervisor'::special.scuola247_groups,'it'::utility.language,1000000000,2000000000,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_executive_a@scuola_1.it', 'scuola247_executive'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_executive_b@scuola_1.it', 'scuola247_executive'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_executive_c@scuola_2.it', 'scuola247_executive'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_executive_d@scuola_2.it', 'scuola247_executive'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_executive_e@scuola_28961.it', 'scuola247_executive'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_executive_f@scuola_28961.it', 'scuola247_executive'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_employee_a@scuola_1.it', 'scuola247_employee'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_employee_b@scuola_1.it', 'scuola247_employee'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_employee_c@scuola_2.it', 'scuola247_employee'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_employee_d@scuola_2.it', 'scuola247_employee'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_employee_e@scuola_28961.it', 'scuola247_employee'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_employee_f@scuola_28961.it', 'scuola247_employee'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_teacher_a@scuola_1.it', 'scuola247_teacher'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_teacher_b@scuola_1.it', 'scuola247_teacher'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_teacher_c@scuola_2.it', 'scuola247_teacher'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_teacher_d@scuola_2.it', 'scuola247_teacher'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_teacher_e@scuola_28961.it', 'scuola247_teacher'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_teacher_f@scuola_28961.it', 'scuola247_teacher'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_relative_a@scuola_1.it', 'scuola247_relative'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_relative_b@scuola_1.it', 'scuola247_relative'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_relative_c@scuola_2.it', 'scuola247_relative'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_relative_d@scuola_2.it', 'scuola247_relative'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_relative_e@scuola_28961.it', 'scuola247_relative'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_relative_f@scuola_28961.it', 'scuola247_relative'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_student_a@scuola_1.it', 'scuola247_student'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_student_b@scuola_1.it', 'scuola247_student'::special.scuola247_groups,'it'::utility.language,1000000000);
    PERFORM special.scuola247_create_user('u_testing_student_c@scuola_2.it', 'scuola247_student'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_student_d@scuola_2.it', 'scuola247_student'::special.scuola247_groups,'it'::utility.language,2000000000);
    PERFORM special.scuola247_create_user('u_testing_student_e@scuola_28961.it', 'scuola247_student'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_student_f@scuola_28961.it', 'scuola247_student'::special.scuola247_groups,'it'::utility.language,28961000000000);
    PERFORM special.scuola247_create_user('u_testing_user@scuola.it', 'scuola247_user'::special.scuola247_groups,'it'::utility.language,NULL);

    -- utente per el prove di SELECT, INSERT, UPDATE, DELETE delle tabelle usenames_schools e usename_ex
    PERFORM special.scuola247_create_user('test_unit_special_testing_user@scuola-200000200.it', 'scuola247_user'::special.scuola247_groups, 'it'::utility.language,NULL); 

    PERFORM special.scuola247_create_user('unit_testing_supervisor@scuola.it', 'scuola247_supervisor'::special.scuola247_groups, 'it'::utility.language,2000000200,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_executive_g@scuola_2000000200.it', 'scuola247_executive'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_executive_h@scuola_2000000200.it', 'scuola247_executive'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_executive_m@scuola_2000000300.it', 'scuola247_executive'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_executive_n@scuola_2000000300.it', 'scuola247_executive'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_employee_g@scuola_2000000200.it', 'scuola247_employee'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_employee_h@scuola_2000000200.it', 'scuola247_employee'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_employee_m@scuola_2000000300.it', 'scuola247_employee'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_employee_n@scuola_2000000300.it', 'scuola247_employee'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_teacher_g@scuola_2000000200.it', 'scuola247_teacher'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_teacher_h@scuola_2000000200.it', 'scuola247_teacher'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_teacher_m@scuola_2000000300.it', 'scuola247_teacher'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_teacher_n@scuola_2000000300.it', 'scuola247_teacher'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_relative_g@scuola_2000000200.it', 'scuola247_relative'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_relative_h@scuola_2000000200.it', 'scuola247_relative'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_relative_m@scuola_2000000300.it', 'scuola247_relative'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_relative_n@scuola_2000000300.it', 'scuola247_relative'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_student_g@scuola_2000000200.it', 'scuola247_student'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_student_h@scuola_2000000200.it', 'scuola247_student'::special.scuola247_groups, 'it'::utility.language,2000000200);
    PERFORM special.scuola247_create_user('unit_testing_student_m@scuola_2000000300.it', 'scuola247_student'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_student_n@scuola_2000000300.it', 'scuola247_student'::special.scuola247_groups, 'it'::utility.language,2000000300);
    PERFORM special.scuola247_create_user('unit_testing_user@scuola.it', 'scuola247_user'::special.scuola247_groups, 'it'::utility.language, NULL);

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
