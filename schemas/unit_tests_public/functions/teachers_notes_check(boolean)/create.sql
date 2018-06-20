-- Function: unit_tests_public.teachears_notes_check(boolean)

-- DROP FUNCTION unit_tests_public.teachears_notes_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.teachears_notes_check(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.persons',
										                                                                   'unit_tests_public.classrooms',
										                                                                   'unit_tests_public.school_years',
										                                                                   'unit_tests_public.lessons');
    RETURN;
  END IF;
  ----------------------------------------
  test_name = 'duplicate on_date_at_time';
  ----------------------------------------
  BEGIN
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('10361764000000000','6617000000000','alunno con molta difficoltÃ  nell''apprendimento','8863000000000','2014-02-13','11:50:52','10033000000000');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate on_date_at_time was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','teachears_notes_uq_on_date_at_time');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;	
        END;

  ---------------------------------------
  test_name = 'description''s mandatory';
  ---------------------------------------
  BEGIN
    UPDATE public.teachears_notes SET description = NULL WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description required was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;	
  END;

  -------------------------------------
  test_name = 'description min length';
  -------------------------------------
  BEGIN
    UPDATE public.teachears_notes SET description = ' '  WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but empty description was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23514');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;	
  END;
  -----------------------------------
  test_name = 'teacher''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE public.teachears_notes SET teacher = NULL WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but teacher required was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;		
  END;
  -----------------------------------
  test_name = 'on_date''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE public.teachears_notes SET on_date = NULL WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but on_date required was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;	
  END;
  -------------------------------------
  test_name = 'classroom''s mandatory';
  -------------------------------------
  BEGIN
    UPDATE public.teachears_notes SET classroom = NULL WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but classroom required was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
		IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;	
  END;


RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.teachears_notes_check(boolean)
  OWNER TO postgres;
