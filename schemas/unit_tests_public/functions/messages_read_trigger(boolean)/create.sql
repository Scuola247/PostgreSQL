-- Function: unit_tests_public.messages_read_trigger(boolean)

-- DROP FUNCTION unit_tests_public.messages_read_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.messages_read_trigger(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	  text;
  test_name		          text = '';
  error		            	diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;


  -------------------------------------------------------------------------
  test_name = 'UPDATE messages_read with a person from a different school';
  -------------------------------------------------------------------------
  BEGIN
    UPDATE public.messages_read set person = '29120000000000' WHERE message_read = '60304000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the person is from a different school ', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE 'U04X1' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;*/
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04X1');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;

  -------------------------------------------------------------------------
  test_name = 'INSERT messages_read with a person from a different school';
  -------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.messages_read(message_read,message,person,read_on) VALUES ('161560000000000','51368000000000','29120000000000','2014-06-01 16:55:12');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the person is from a different school ', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE 'U04X2' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;*/
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04X2');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;

    RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.messages_read_trigger(boolean)
  OWNER TO scuola247_supervisor;
