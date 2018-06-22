﻿-- Function: unit_tests_security.absences(boolean)

-- DROP FUNCTION unit_tests_security.absences(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.absences(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.absences(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences(boolean) TO scuola247_user;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences(boolean) TO "jiahaodong@gmail.com" WITH GRANT OPTION;