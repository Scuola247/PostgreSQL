-- Function: unit_tests_public.weekly_timetables_days_trigger(boolean)

-- DROP FUNCTION unit_tests_public.weekly_timetables_days_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.weekly_timetables_days_trigger(
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

  ------------------------------------------------------------------------------
  test_name = 'UPDATE weekly_timetables_days set teacher with different school'; -- fallisce, permette l'operazione
  ------------------------------------------------------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET  teacher='29122000000000'  WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the teacher is from different school', NULL::diagnostic.error);
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0591');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;

  END;

  ------------------------------------------------------------------------------
  test_name = 'INSERT weekly_timetables_days set teacher with different school'; -- fallisce, pemette l'operatione
  ------------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('133008000000000','51386000000000','1','29122000000000','32911000000000','1','08:00:00','09:00:00');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the teacher is from different school', NULL::diagnostic.error);
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0592');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;

  END;
  ------------------------------------------------------------------------------
  test_name = 'UPDATE weekly_timetables_days set subject with different school'; -- fallisce, permette l'operazione
  ------------------------------------------------------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET  subject='29105000000000'  WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but the subject is not from the same school ', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0593');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  ------------------------------------------------------------------------------
  test_name = 'INSERT weekly_timetables_days set subject with different school'; -- fallisce, permette l'operazione
  ------------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('133008000000000','51386000000000','1','32925000000000','29105000000000','1','08:00:00','09:00:00');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the subject is from different school', NULL::diagnostic.error);
    RETURN;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0594');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.weekly_timetables_days_trigger(boolean)
  OWNER TO postgres;
