-- Function: unit_tests_public.out_of_classrooms_check(boolean)

-- DROP FUNCTION unit_tests_public.out_of_classrooms_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.out_of_classrooms_check(
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

  --------------------------------
  test_name = 'duplicate on_date';
  --------------------------------
  BEGIN
    INSERT INTO scuola247.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES ('198577000000000','32937000000000','per selezioni sportive','2013-09-21','08:00:00','12:00:00','10379000000000');
   _results =  _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate on_date was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','out_of_classrooms_uq_classroom_student_on_date');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -------------------------------------------
  test_name = 'school_operator''s mandatory';
  -------------------------------------------
  BEGIN
    UPDATE scuola247.out_of_classrooms SET school_operator = NULL WHERE out_of_classroom = '98577000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but school_operator required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------------
  test_name = 'description''s mandatory';
  ---------------------------------------
  BEGIN
    UPDATE scuola247.out_of_classrooms SET description = NULL WHERE out_of_classroom = '98577000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description required was expected', NULL::diagnostic.error);
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
    UPDATE scuola247.out_of_classrooms SET on_date = NULL WHERE out_of_classroom = '98577000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but on_date required was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;


  -------------------------------------
  test_name = 'from_time''s mandatory';
  -------------------------------------
  BEGIN
    UPDATE scuola247.out_of_classrooms SET from_time = NULL WHERE out_of_classroom = '98577000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but from_time required was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -----------------------------------
  test_name = 'to_time''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE scuola247.out_of_classrooms SET to_time = NULL WHERE out_of_classroom = '98577000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but to_time required was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------------------
  test_name = 'to_time greater than from_time';
  ---------------------------------------------
  BEGIN
    UPDATE scuola247.out_of_classrooms SET to_time = '07:00:00' WHERE out_of_classroom = '98577000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but to_time must be greater than from_time', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23514');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
   ----------------------------------------
  test_name = 'description''s min lenght';
  ----------------------------------------
  BEGIN
    UPDATE scuola247.out_of_classrooms SET description = '  ' WHERE out_of_classroom = '98577000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but description min lenght was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514','out_of_classrooms_ck_description');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.out_of_classrooms_check(boolean)
  OWNER TO scuola247_supervisor;
