-- Function: unit_testing.last_checkpoint_failed(unit_testing.unit_test_result[])

-- DROP FUNCTION unit_testing.last_checkpoint_failed(unit_testing.unit_test_result[]);

CREATE OR REPLACE FUNCTION unit_testing.last_checkpoint_failed(_results unit_testing.unit_test_result[])
  RETURNS boolean AS
$BODY$
<<me>>
DECLARE
  context		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _results IS NULL THEN
    RETURN FALSE;
  END IF;

  IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_testing.last_checkpoint_failed(unit_testing.unit_test_result[])
  OWNER TO scuola247_supervisor;
COMMENT ON FUNCTION unit_testing.last_checkpoint_failed(unit_testing.unit_test_result[]) IS 'Check the last element of the _result parameter array and test the status member variable of check_point structure returning TRUE is the value is ''Failed'' FALSE otherwise.';
