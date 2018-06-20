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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_insert');
    RETURN;
  END IF;

  BEGIN
    ----------------------------------------------
    test_name = 'CREATE ROLE Supervisor school';
    ----------------------------------------------
    CREATE ROLE "test-supervisor-d@scuola.it" LOGIN
      ENCRYPTED PASSWORD 'md5password'
      NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT scuola247_supervisor TO "test-supervisor-d@scuola.it";

    INSERT INTO public.usename_school(usename, school) VALUES ('test-supervisor-d@scuola.it', 1000000000);
    INSERT INTO public.usename_school(usename, school) VALUES ('test-supervisor-d@scuola.it', 2000000000); 
    INSERT INTO public.usename_school(usename, school) VALUES ('test-supervisor-d@scuola.it', 28961000000000);

    ----------------------------------------------
    test_name = 'CREATE ROLE Executive  school 1';
    ----------------------------------------------
    CREATE ROLE "test-executive-d@scuola-1.it" LOGIN
      ENCRYPTED PASSWORD 'md5password'
      NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT scuola247_executive TO "test-executive-d@scuola-1.it";

    INSERT INTO public.usename_school(usename, school) VALUES ('test-executive-d@scuola-1.it', 1000000000);

    ----------------------------------------------
    test_name = 'CREATE ROLE Executive  school 2';
    ----------------------------------------------
    CREATE ROLE "test-executive-d@scuola-2.it" LOGIN
      ENCRYPTED PASSWORD 'md5password'
      NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT scuola247_executive TO "test-executive-d@scuola-2.it";

    --------------------------------------------------
    test_name = 'CREATE ROLE Executive  school 28961';
    --------------------------------------------------
    CREATE ROLE "test-executive-d@scuola-28961.it" LOGIN
      ENCRYPTED PASSWORD 'md5password'
      NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
    GRANT scuola247_executive TO "test-executive-d@scuola-28961.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Employee  school 1';
  ----------------------------------------------
  CREATE ROLE "test-employee-d@scuola-1.it" LOGIN
    ENCRYPTED PASSWORD 'md5password'
    NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_employee TO "test-employee-d@scuola-1.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Employee  school 2';
  ----------------------------------------------
  CREATE ROLE "test-employee-d@scuola-2.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_employee TO "test-employee-d@scuola-2.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Employee  school 28961';
  ----------------------------------------------
  CREATE ROLE "test-employee-d@scuola-28961.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_employee TO "test-employee-d@scuola-28961.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Teacher   school 1';
  ----------------------------------------------
  CREATE ROLE "test-teacher-d@scuola-1.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_teacher TO "test-teacher-d@scuola-1.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Teacher   school 2';
  ----------------------------------------------

  CREATE ROLE "test-teacher-d@scuola-2.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_teacher TO "test-teacher-d@scuola-2.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Teacher   school 28961';
  ----------------------------------------------

  CREATE ROLE "test-teacher-d@scuola-28961.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_teacher TO "test-teacher-d@scuola-28961.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Relative  school 1';
  ----------------------------------------------

  CREATE ROLE "test-relative-d@scuola-1.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_relative TO "test-relative-d@scuola-1.it";
  ----------------------------------------------
  test_name = 'CREATE ROLE Relative  school 2';
  ----------------------------------------------

  CREATE ROLE "test-relative-d@scuola-2.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_relative TO "test-relative-d@scuola-2.it";
  
  ----------------------------------------------
  test_name = 'CREATE ROLE Relative  school 28961';
  ----------------------------------------------

  CREATE ROLE "test-relative-d@scuola-28961.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_relative TO "test-relative-d@scuola-28961.it";

  ----------------------------------------------
  test_name = 'CREATE ROLE Student  school 1';
  ----------------------------------------------

  CREATE ROLE "test-student-d@scuola-1.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_student TO "test-student-d@scuola-1.it";
  
  ----------------------------------------------
  test_name = 'CREATE ROLE Student  school 2';
  ----------------------------------------------

  CREATE ROLE "test-student-d@scuola-2.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_student TO "test-student-d@scuola-2.it";
  
  ----------------------------------------------
  test_name = 'CREATE ROLE Student  school 28961';
  ----------------------------------------------

  CREATE ROLE "test-student-d@scuola-28961.it" LOGIN
  ENCRYPTED PASSWORD 'md5password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
  GRANT scuola247_student TO "test-student-d@scuola-28961.it";

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
  OWNER TO postgres;
