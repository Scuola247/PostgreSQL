-- Function: unit_tests_public.usenames_schools_check(boolean)

-- DROP FUNCTION unit_tests_public.usenames_schools_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.usenames_schools_check(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.schools');
    RETURN;
  END IF;

/*
futuri lavori cambiare i codici ed utilizzare quelli dello unit tests
*/

  ---------------------------------
  test_name = 'duplicate usenamme';
  ---------------------------------
  BEGIN
    INSERT INTO public.usenames_schools(usename_school,usename,school) VALUES ('726619','teacher-e@scuola-28961.it','28961');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate usename was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','usenames_schools_uq_usename_school');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -----------------------------------
  test_name = 'usename''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE usenames_schools SET usename = NULL WHERE usename_school = '726620';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but usename required was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------
  test_name = 'school''s mandatory';
  ----------------------------------
  BEGIN
    UPDATE usenames_schools SET school = NULL WHERE usename_school = '726620';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but school required was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ---------------------------------
  test_name = 'usename min length';
  ---------------------------------
  BEGIN
    UPDATE usenames_schools SET usename = ' ' WHERE usename_school = '726620';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but usename required was empty', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23514');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.usenames_schools_check(boolean)
  OWNER TO postgres;
