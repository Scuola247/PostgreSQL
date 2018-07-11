-- Function: unit_tests_horizontal_security.check_usenames(boolean)

-- DROP FUNCTION unit_tests_horizontal_security.check_usenames(boolean);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.check_usenames(
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

  command 		text;
  current_user   	record;
  current_user_school	record;
  results 		unit_testing.unit_test_result[];
  sql			text;

BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role'); 
    RETURN;
  END IF;
  
  FOR me.current_user IN (SELECT usename, school
                            FROM usenames_schools
                           WHERE usename LIKE 'unit_testing%') LOOP
                   
    command = format('SELECT unit_tests_horizontal_security.check_user_enable_school(%L,%L)',me.current_user.usename,me.current_user.school);
    RAISE INFO 'command: %',command;
    EXECUTE me.command INTO me.results;
    _results = _results || me.results;
    
  END LOOP;

  IF NOT FOUND THEN
    RETURN;
  END IF;
  
  FOR me.current_user IN (SELECT DISTINCT trim(member::regrole::text,'"') as member
                            FROM pg_auth_members
                           WHERE roleid::regrole::text like 'scuola247_%'
                             AND member::regrole::text like 'unit_testing%') LOOP
                           
    me.sql =format('WITH my_usenames_schools AS (SELECT usename, school
                                                 FROM usenames_schools 
                                                 WHERE usename = %L)
                         SELECT s.school AS school, m.usename AS usename 
                           FROM my_usenames_schools m 
                     RIGHT JOIN schools s ON m.school = s.school 
                          WHERE s.school IN (2000000200, 2000000300)
                            AND m.school IS  NULL', me.current_user.member);                 
    RAISE INFO 'sql: %',me.sql;

    FOR me.current_user_school IN EXECUTE me.sql LOOP
      command = format('SELECT unit_tests_horizontal_security.check_user_disable_school(%L,%L)',me.current_user.member, me.current_user_school.school);
      RAISE INFO 'command: %',command;
      EXECUTE me.command INTO me.results;
      _results = _results || me.results;
    END LOOP;
  END LOOP;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.check_usenames(boolean)
  OWNER TO postgres;
