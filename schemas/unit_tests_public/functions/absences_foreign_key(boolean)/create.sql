-- Function: unit_tests_public.absences_foreign_key(boolean)

-- DROP FUNCTION unit_tests_public.absences_foreign_key(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.absences_foreign_key(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.persons',
										       										              										       'unit_tests_public.classrooms',
												       										       				        				       'unit_tests_public.school_years',
										              										       										       'unit_tests_public.lessons',
					              										                                           -- to avoide generation of circular references
					          										                                               -- 'delays',
					         										                                                 -- to avoide generation of circular references
													       										              							       -- 'leavings',
											          				                                               -- to avoide generation of circular references
										       										              										       -- 'out_of_classrooms',
	  										       										             									       'unit_tests_public.classrooms_students',
														       										              						       'unit_tests_public.explanations'); 
    RETURN;
  END IF;

  -------------------------------------------------------------------------------
  test_name = 'Update absences set classroom_student with non existence subject';
  -------------------------------------------------------------------------------
  BEGIN
    UPDATE absences SET classroom_student = 999999999 WHERE absence = 33311000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but classroom_student set with non existence subject', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503', 'absences_fk_classroom_student');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  -------------------------------------------------------------------------
  test_name = 'Update absences set explanation with non existence subject';
  -------------------------------------------------------------------------
  BEGIN
    UPDATE absences SET explanation = 999999999 WHERE absence = 33311000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but explanation set with non existence subject', NULL::diagnostic.error);
    RETURN;

   
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503', 'absences_fk_explanation');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  ---------------------------------------------------------------------
  test_name = 'Update absences set teacher with non existence subject';
  ---------------------------------------------------------------------
  BEGIN
    UPDATE absences SET teacher = 999999999 WHERE absence = 33311000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but teacher set with non existence subject', NULL::diagnostic.error);
    RETURN;


    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23503', 'absences_fk_teacher');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.absences_foreign_key(boolean)
  OWNER TO postgres;
