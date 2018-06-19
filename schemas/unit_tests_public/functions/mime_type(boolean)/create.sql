-- Function: unit_tests_public.mime_type(boolean)

-- DROP FUNCTION unit_tests_public.mime_type(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.mime_type(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	text;
  test_name		text = '';
  error			diagnostic.error;
  file_extension        file_extension;
  mime_type	        mime_type;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
    -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;
  -------------------------------------------------
  test_name = 'CONVERSION .json to file_extension';
  -------------------------------------------------
  BEGIN
    SELECT '.json'::file_extension INTO me.file_extension;
    _results = _results || assert.pass(full_function_name, test_name);
  EXCEPTION
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results ||  assert.fail(full_function_name, test_name, 'conversione non riuscita'::text, error);
        RETURN;
  END;
  --------------------------------------------------------------
  test_name = 'CONVERSION .json to file_extension to mime_type';
  --------------------------------------------------------------
  BEGIN
    SELECT '.json'::file_extension::mime_type INTO me.mime_type;
    _results = _results || assert.are_equals(full_function_name, test_name, mime_type::text,  'application/json'::text);
  EXCEPTION
    WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.fail(full_function_name, test_name, 'conversione non riuscita'::text, error);
      RETURN;
  END;
  ------------------------------------------------
  test_name = 'CONVERSION .pdf to file_extension';
  ------------------------------------------------
  BEGIN
    SELECT '.pdf'::file_extension INTO me.file_extension;
    _results = _results || assert.pass(full_function_name, test_name);

  EXCEPTION
    WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.fail(full_function_name, test_name, 'conversione non riuscita'::text, error);
      RETURN;
  END;
  -------------------------------------------------------------
  test_name = 'CONVERSION .pdf to file_extension to mime_type';
  -------------------------------------------------------------
  BEGIN
    SELECT '.pdf'::file_extension::mime_type INTO me.mime_type;
    _results = _results || assert.are_equals(full_function_name, test_name, mime_type::text,  'application/pdf'::text);
  EXCEPTION
    WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.fail(full_function_name, test_name, 'conversione non riuscita'::text, error);
      RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.mime_type(boolean)
  OWNER TO postgres;
