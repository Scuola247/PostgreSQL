-- Function: unit_tests_public.leavings_foreign_key(boolean)

-- DROP FUNCTION unit_tests_public.leavings_foreign_key(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.leavings_foreign_key(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.explanations',
                                                                                       'unit_tests_public.persons',
                                                                                       'unit_tests_public.classrooms_students',
                                                                                       'unit_tests_public.classrooms',
                                                                                       'unit_tests_public.school_years',
                                                                                       'unit_tests_public.absences',
                                                                                       'unit_tests_public.lessons');
    RETURN;
 END IF;
  --------------------------------------------------------------------------
  test_name = 'UPDATE schools set classroom_student to a non existence one';
  --------------------------------------------------------------------------
   BEGIN
     UPDATE leavings SET classroom_student = '9999' WHERE leaving = '58393000000000';
     _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but classroom_student set with non existence code', NULL::diagnostic.error);
     RETURN;
    /*EXCEPTION WHEN SQLSTATE '23503' THEN
       GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
       IF error.constraint_name = 'leavings_fk_classroom_student' THEN
         _results = _results || assert.pass(full_function_name, test_name);
       ELSE
         _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 1', error);
         RETURN;
       END IF;
       WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 2', error);
         RETURN;*/
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','leavings_fk_classroom_student');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;   END;
  ---------------------------------------------------------------------
  test_name = 'UPDATE leavings set explanation to a non existence one';
  ---------------------------------------------------------------------
  BEGIN
    UPDATE leavings SET explanation = '999999999' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but explanation set with non existence code', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE '23503' THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'leavings_fk_explanation' THEN
        _results = _results || assert.pass(full_function_name, test_name);
      ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 1', error);
        RETURN;
      END IF;
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 2', error);
        RETURN;*/
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','leavings_fk_explanation');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;
  -----------------------------------------------------------------
  test_name = 'UPDATE leavings set teacher to a non existence one';
  -----------------------------------------------------------------
  BEGIN
    UPDATE leavings SET teacher = '999999999' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but teacher set with non existence code', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE '23503' THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'leavings_fk_teacher' THEN
        _results = _results || assert.pass(full_function_name, test_name);
      ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 1', error);
        RETURN;
      END IF;
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception 2', error);
        RETURN;*/
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503','leavings_fk_teacher');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;

 RETURN;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.leavings_foreign_key(boolean)
  OWNER TO scuola247_supervisor;
