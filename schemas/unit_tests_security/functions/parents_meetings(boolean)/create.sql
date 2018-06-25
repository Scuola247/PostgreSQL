﻿-- Function: unit_tests_security.parents_meetings(boolean)

-- DROP FUNCTION unit_tests_security.parents_meetings(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.parents_meetings(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.parents_meetings(boolean)
  OWNER TO "jiahaodong@gmail.com";