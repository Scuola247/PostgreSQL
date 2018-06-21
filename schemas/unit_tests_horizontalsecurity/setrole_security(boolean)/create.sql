-- Function: unit_tests_horizontalsecurity.setrole_security(boolean)

-- DROP FUNCTION unit_tests_horizontalsecurity.setrole_security(boolean);

CREATE OR REPLACE FUNCTION unit_tests_horizontalsecurity.setrole_security(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name		text = '';
  error		        diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert','unit_tests_security.create_role');
    RETURN;
  END IF;

------------------------------------------MANAGER---------------------------------------------

----------------------------------------------------------------------------------------------------
  test_name = 'check permission user: manager-a@scuola-1.it school: 1';
----------------------------------------------------------------------------------------------------
  _results = _results || unit_tests_horizontalsecurity.check_user_school('test-supervisor-d@scuola-1.it' ,1);
/*
----------------------------------------------------------------------------------------------------
  test_name = 'check permission user: manager-b@scuola-1.it school: 1';
-----------------------------------------------------------------------------------------------------
  _results = _results || unit_tests_horizontalsecurity.check_user_school('manager-b@scuola-1.it' ,1);

----------------------------------------------------------------------------------------------------
  test_name = 'check permission user: manager-c@scuola-1.it school: 2';
------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('manager-c@scuola-2.it' ,2);

----------------------------------------------------------------------------------------------------
  test_name = 'check permission user: manager-d@scuola-1.it school: 2';
--------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('manager-d@scuola-2.it' ,2);

----------------------------------------------------------------------------------------------------
  test_name = 'check permission user: manager-e@scuola-1.it school: 28961';
-------------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('manager-e@scuola-28961.it' ,28961);

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: manager-f@scuola-1.it school: 28961';
-------------------------------------------------------------------------------------------------------------  
  _results= _results || unit_tests_horizontalsecurity.check_user_school('manager-f@scuola-28961.it' ,28961);

--------------------------------------------STUDENT----------------------------------------

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: student-a@scuola-1.it school: 1';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('student-a@scuola-1.it' ,1);

  ----------------------------------------------------------------------------------------------------
test_name = 'check permission user: student-b@scuola-1.it school: 1';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('student-b@scuola-1.it' ,1);

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: student-c@scuola-1.it school: 2';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('student-c@scuola-2.it' ,2);

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: student-d@scuola-1.it school: 2';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('student-d@scuola-2.it' ,2);

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: student-e@scuola-1.it school: 28961';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('student-e@scuola-28961.it' ,28961);

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: student-f@scuola-1.it school: 28961';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('student-f@scuola-28961.it' ,28961);

-------------------------------------TEACHER---------------------------------------------------------------

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: teacher-a@scuola-1.it school: 1';
------------------------------------------------------------------------------------------------------------- 
  _results= _results || unit_tests_horizontalsecurity.check_user_school('teacher-a@scuola-1.it' ,1);

  ----------------------------------------------------------------------------------------------------
test_name = 'check permission user: teacher-b@scuola-1.it school: 1';
-------------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('teacher-b@scuola-1.it' ,1);
----------------------------------------------------------------------------------------------------
test_name = 'check permission user: teacher-c@scuola-1.it school: 2';
-------------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('teacher-c@scuola-2.it' ,2);

  ----------------------------------------------------------------------------------------------------
test_name = 'check permission user: teacher-d@scuola-1.it school: 2';
-------------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('teacher-d@scuola-2.it' ,2);

----------------------------------------------------------------------------------------------------
test_name = 'check permission user: teacher-e@scuola-1.it school: 28961';
-------------------------------------------------------------------------------------------------------------
  _results= _results || unit_tests_horizontalsecurity.check_user_school('teacher-e@scuola-28961.it' ,28961);
  ----------------------------------------------------------------------------------------------------
test_name = 'check permission user: teacher-f@scuola-1.it school: 28961';
-------------------------------------------------------------------------------------------------------------*/
  _results= _results || unit_tests_horizontalsecurity.check_user_school('teacher-f@scuola-28961.it' ,28961);

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontalsecurity.setrole_security(boolean)
  OWNER TO scuola247_supervisor;
