-- Function: assert.check_update_done(text, bigint)

-- DROP FUNCTION assert.check_update_done(text, bigint);

CREATE OR REPLACE FUNCTION assert.check_update_done(
    IN _sql text,
    IN _expected_rows bigint,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name	        text = '';
  error			diagnostic.error;
  command 		text;
  row_count   bigint;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  ---------------------------------------------
  test_name = format('Check UPDATE: %s', _sql);
  ---------------------------------------------
  BEGIN
    EXECUTE _sql;

    GET DIAGNOSTICS row_count = ROW_COUNT;
    
    IF row_count = _expected_rows THEN
	    _results = _results || assert.pass(full_function_name, test_name);
    ELSE
        _results = _results || assert.fail(full_function_name, test_name,format('Command EXECUTED WITHOUT EXCEPTION SQL: %s', _sql), NULL::diagnostic.error);
	    RETURN;
    END IF;

    EXCEPTION
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;
  
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION assert.check_update_done(text, bigint)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION assert.check_update_done(text, bigint) TO public;
GRANT EXECUTE ON FUNCTION assert.check_update_done(text, bigint) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION assert.check_update_done(text, bigint) TO scuola247_user;
