-- Function: unit_tests_public.persons_addresses_foreign_key(boolean)

-- DROP FUNCTION unit_tests_public.persons_addresses_foreign_key(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.persons_addresses_foreign_key(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	  text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;
  ----------------------------------------------------
  test_name = 'UPDATE person with a non existing one';
  ----------------------------------------------------
  BEGIN
    UPDATE persons_addresses SET person = 999999999 WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but person set with a non existing one', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE '23503' THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'persons_addresses_fk_person' THEN
        _results = _results || assert.pass(full_function_name, test_name);
      ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 1', error);
        RETURN;
      END IF;
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 2', error);
        RETURN;
  END;
  --------------------------------------------------
  test_name = 'UPDATE city with a non existing one';
  --------------------------------------------------
  BEGIN
    UPDATE persons_addresses SET city = 9999 WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but city set with a non existing one', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE '23503' THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'persons_addresses_fk_city' THEN
        _results = _results || assert.pass(full_function_name, test_name);
      ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 1', error);
        RETURN;
      END IF;
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 2', error);
        RETURN;
  END;
RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.persons_addresses_foreign_key(boolean)
  OWNER TO postgres;
