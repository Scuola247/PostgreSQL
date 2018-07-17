-- Function: unit_tests_public.grading_meetings_valutations_foreign_key(boolean)

-- DROP FUNCTION unit_tests_public.grading_meetings_valutations_foreign_key(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.grading_meetings_valutations_foreign_key(
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
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;
  ----------------------------------------------------------------------------------------
  test_name = 'update grading_meetings_valutations set classroom with a non existing one';
  ----------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.grading_meetings_valutations SET classroom_student = '9999999999999' WHERE grading_meeting_valutation= '130752000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but classroom does not exist', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','grading_meetings_valutations_fk_classroom');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ------------------------------------------------------------------------------------
  test_name = 'update grading_meetings_valutations set grade with a non existing one';
  ------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.grading_meetings_valutations SET grade = '9999999999999' WHERE grading_meeting_valutation= '130752000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but grade does not exist', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','grading_meetings_valutations_fk_grade');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -----------------------------------------------------------------------------------------------
   test_name = 'update grading_meetings_valutations set grading_meeting with a non existing one';
  -----------------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.grading_meetings_valutations SET grading_meeting = '9999999999999' WHERE grading_meeting_valutation= '130752000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but grading_meeting does not exist', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','grading_meetings_valutations_fk_grading_meeting');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ---------------------------------------------------------------------------------------
   test_name = 'update grading_meetings_valutations set subject with a non existing one';
  ---------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.grading_meetings_valutations SET subject = '9999999999999' WHERE grading_meeting_valutation= '130752000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but subject does not exist', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','grading_meetings_valutations_fk_subject');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.grading_meetings_valutations_foreign_key(boolean)
  OWNER TO scuola247_supervisor;
