-- Function: unit_tests_horizontal_security.setrole_security(boolean)

-- DROP FUNCTION unit_tests_horizontal_security.setrole_security(boolean);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.setrole_security(
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

------------------------------------------SUPERVISOR---------------------------------------------

----------------------------------------------------------------------------------------------------
  test_name = 'check permission user: SUPERVISOR school: 1';
----------------------------------------------------------------------------------------------------
  _results = _results || unit_tests_horizontal_security.check_group('jiahaodong@gmail.com');



  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.setrole_security(boolean)
  OWNER TO scuola247_supervisor;
