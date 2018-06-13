-- Function: assert.sqlstate_constraint_equals(text, text, diagnostic.error, text, text)

-- DROP FUNCTION assert.sqlstate_constraint_equals(text, text, diagnostic.error, text, text);

CREATE OR REPLACE FUNCTION assert.sqlstate_constraint_equals(
    IN _function_name text,
    IN _test_name text,
    IN _error diagnostic.error,
    IN _sqlstate text,
    IN _constraint_name text,
    OUT _result unit_testing.unit_test_result)
  RETURNS unit_testing.unit_test_result AS
$BODY$
<<me>>
DECLARE
  context         text;
  full_function_name    text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _error.returned_sqlstate = _sqlstate AND _error.constraint_name = _constraint_name THEN
    _result = assert.pass(_function_name, _test_name, format('The sqlstate:%L on constraint_name:%L were expected', _error.returned_sqlstate, _error.constraint_name));
  ELSE
    _result = assert.fail(_function_name, _test_name, format('The sqlstate:%L on constraint_name:%L were NOT expected', _error.returned_sqlstate, _error.constraint_name), _error);
  END IF;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql IMMUTABLE
  COST 1;
ALTER FUNCTION assert.sqlstate_constraint_equals(text, text, diagnostic.error, text, text)
  OWNER TO postgres;
