-- Function: unit_tests_public.lessons_trigger(boolean)

-- DROP FUNCTION unit_tests_public.lessons_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.lessons_trigger(
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
  ------------------------------------------------------------------
  test_name = 'UPDATE lessons with subject from a different school';
  ------------------------------------------------------------------
  BEGIN
    UPDATE lessons SET subject ='96334000000000'  WHERE lesson = '98608000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the subject is not from the same school ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04V1');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ----------------------------------------------------------------------
  test_name = 'INSERT OF lessons with subjects from a different school';
  ----------------------------------------------------------------------
  BEGIN
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('10098608000000000','10033000000000','2013-09-21','96334000000000','32938000000000','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    _results = _results || assert.fail(full_function_name, test_name,' the subject is not from the same school ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04V2');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ------------------------------------------------------------------
  test_name = 'UPDATE lessons with teacher from a different school';
  ------------------------------------------------------------------
  BEGIN
    UPDATE lessons SET teacher='29120000000000' WHERE lesson='98581000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the teacher is from a different school ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04V3');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ------------------------------------------------------------------
  test_name = 'INSERT lessons with teacher from a different school';
  ------------------------------------------------------------------
  BEGIN
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('10098581000000000','10033000000000','2013-09-16','32911000000000','29120000000000','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the teacher is not from the same school ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04V4');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ------------------------------------------------
  test_name = 'UPDATE teacher with a non teacher';
  ------------------------------------------------
  BEGIN
    UPDATE lessons SET teacher='5662000000000' WHERE lesson='98581000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the person is not a teacher', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04V5');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;
  ------------------------------------------------
  test_name = 'INSERT teacher with a non teacher';
  ------------------------------------------------
  BEGIN
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('10198581000000000','10033000000000','2013-09-16','32911000000000','5662000000000','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the person is not in role teacher ', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04V6');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.lessons_trigger(boolean)
  OWNER TO scuola247_supervisor;
