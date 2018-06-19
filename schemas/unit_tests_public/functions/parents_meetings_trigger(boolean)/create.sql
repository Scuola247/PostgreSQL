-- Function: unit_tests_public.parents_meetings_trigger(boolean)

-- DROP FUNCTION unit_tests_public.parents_meetings_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.parents_meetings_trigger(
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
  -------------------------------------------------------------------------
  test_name = 'UPDATE parents_meetings with teacher from different school';
  -------------------------------------------------------------------------
  BEGIN
    UPDATE parents_meetings SET teacher = '29122000000000' WHERE  parents_meeting = '33433000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the teacher is not from the same school', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE 'U0511' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;*/
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0511');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;
  -------------------------------------------------------------------------
  test_name = 'INSERT parents_meetings with teacher from different school';
  -------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('10033433000000000','29122000000000','6603000000000','2013-10-01 00:00:00');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the teacher is not from the same school', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE 'U0512' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;*/
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0512');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.parents_meetings_trigger(boolean)
  OWNER TO scuola247_supervisor;
