-- Function: unit_tests_public.leavings_check(boolean)

-- DROP FUNCTION unit_tests_public.leavings_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.leavings_check(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.explanations',
                                                                                       'unit_tests_public.persons',
                                                                                       'unit_tests_public.classrooms_students',
                                                                                       'unit_tests_public.classrooms',
                                                                                       'unit_tests_public.school_years',
                                                                                       'unit_tests_public.absences',
                                                                                       'unit_tests_public.lessons');
    RETURN;
 END IF;
  ------------------------------------------
  test_name = 'duplicate classroom_student';
  ------------------------------------------
  BEGIN
     INSERT INTO scuola247.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('10658393000000000','32932000000000','1057135000000000','2013-09-19','11:52:54','10685000000000');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate classroom_student was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','leavings_uq_classroom_student');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
    END;

  -----------------------------------
  test_name = 'teacher''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE scuola247.leavings SET teacher = NULL WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but teacher required was expected', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------------
  test_name = 'explanation''s mandatory';
  ---------------------------------------
  BEGIN
    UPDATE scuola247.leavings SET explanation = NULL WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but explanation required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -----------------------------------
  test_name = 'on_date''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE scuola247.leavings SET on_date = NULL WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but on_date required was expected', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  -----------------------------------
  test_name = 'at_time''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE scuola247.leavings SET at_time = NULL WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but at_time required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;


 RETURN;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.leavings_check(boolean)
  OWNER TO scuola247_supervisor;
