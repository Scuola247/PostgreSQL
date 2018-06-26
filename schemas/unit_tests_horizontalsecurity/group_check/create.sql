-- Function: unit_tests_horizontal_security.group_check(text)

-- DROP FUNCTION unit_tests_horizontal_security.group_check(text);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.group_check(
    IN _user text,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name		text = '';
  error		        diagnostic.error;
  _group 		text;
 
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
FOR _user IN (
SELECT pg_roles.rolname FROM pg_user
JOIN pg_auth_members ON pg_user.usesysid=pg_auth_members.member
JOIN pg_roles ON pg_roles.oid=pg_auth_members.roleid ) LOOP 

IF _group = 'supervisor_247' THEN 
	SELECT unit_tests_horizontal_security.check_user_school_able(_group,_user,1);
	SELECT unit_tests_horizontal_security.check_user_school_able(_group,_user,2);
	SELECT unit_tests_horizontal_security.check_user_school_able(_group,_user,28961);
	
 ELSIF _group = 'executive_247' AND _school = 1 THEN
	SELECT unit_tests_horizontal_security.check_user_school_able(_group,_user,1);
	SELECT unit_tests_horizontal_security.check_user_school_disable(_group,_user,2);
	SELECT unit_tests_horizontal_security.check_user_school_disable(_group,_user,28961);

 ELSIF _group = 'executive_247' AND _school = 2 THEN
	SELECT unit_tests_horizontal_security.check_user_school_disable(_group,_user,1);
	SELECT unit_tests_horizontal_security.check_user_school_able(_group,_user,2);
	SELECT unit_tests_horizontal_security.check_user_school_disable(_group,_user,28961);

 ELSIF _group = 'executive_247' AND _school = 28961 THEN
	SELECT unit_tests_horizontal_security.check_user_school_disable(_group,_user,1);
	SELECT unit_tests_horizontal_security.check_user_school_disable(_group,_user,2);
	SELECT unit_tests_horizontal_security.check_user_school_able(_group,_user,28961);

 /*ELSIF _group = 'teacher_247' THEN
	SELECT unit_tests_horizontal_security.check_user_school_able(text,text,bigint);
	SELECT unit_tests_horizontal_security.check_user_school_disable(text,text,bigint);
	
 ELSIF _group = 'student_247' THEN
	SELECT unit_tests_horizontal_security.check_user_school_able(text,text,bigint);
	SELECT unit_tests_horizontal_security.check_user_school_disable(text,text,bigint);

 ELSIF _group = 'parent_247' THEN 
        SELECT unit_tests_horizontal_security.check_user_school_able(text,text,bigint);
	SELECT unit_tests_horizontal_security.check_user_school_disable(text,text,bigint);
*/
END IF;
END LOOP;


  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.group_check(text)
  OWNER TO postgres;
