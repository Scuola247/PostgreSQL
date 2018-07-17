-- Function: unit_tests_public.grading_meetings_valutations_trigger(boolean)

-- DROP FUNCTION unit_tests_public.grading_meetings_valutations_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.grading_meetings_valutations_trigger(
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

  --------------------------------------------------------------------------------------------
  test_name = 'UPDATE grading_meetings_valutations with a subject from a different classroom';
  --------------------------------------------------------------------------------------------

  BEGIN
    UPDATE public.grading_meetings_valutations SET subject = '166675000000000' where grading_meeting_valutation = '131709000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but subject is not in the school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04R5');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

 -------------------------------------------------------------------------------------------
  test_name = 'INSERT grading_meetings_valutations with subject from a different classroom';
  ------------------------------------------------------------------------------------------

BEGIN
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('1021130752000000000','119533000000000','166675000000000','11463000000000',NULL,'f','f',NULL,10395000000000);
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but subject is not in the school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04R6');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -------------------------------------------------------------------------------------
  test_name = 'UPDATE grading_meetings_valutations with grade from a different school';
  -------------------------------------------------------------------------------------
   BEGIN
    UPDATE public.grading_meetings_valutations SET grade = '29067000000000' where grading_meeting_valutation = '131709000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but grade is from a different school', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04R7');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -------------------------------------------------------------------------------------
  test_name = 'INSERT grading_meetings_valutations with grade from a different school';
  -------------------------------------------------------------------------------------
   BEGIN
      INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('1031130752000000000','119533000000000','32919000000000','29067000000000',NULL,'f','f',NULL,10395000000000);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but grade is from a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04R8');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------------------------------------------------
  test_name = 'UPDATE grading_meeting_valutation with closed grading meeting';
  ----------------------------------------------------------------------------
     BEGIN
    UPDATE public.grading_meetings_valutations SET grading_meeting = '119533000000000' where grading_meeting_valutation = '131709000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but grading_meeting is closed', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04R9');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------------------------------------------------
  test_name = 'INSERT grading_meeting_valutation with closed grading meeting';
  ----------------------------------------------------------------------------
     BEGIN
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('1041130752000000000', '119533000000000','32919000000000', '11463000000000', NULL, 'f', 'f', NULL,10395000000000);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but grading_meeting is closed', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04RA');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

    RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.grading_meetings_valutations_trigger(boolean)
  OWNER TO scuola247_supervisor;
