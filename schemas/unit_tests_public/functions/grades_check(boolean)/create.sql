-- Function: unit_tests_public.grades_check(boolean)

-- DROP FUNCTION unit_tests_public.grades_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.grades_check(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.metrics');
    RETURN;
  END IF;
  --------------------------------------------------------------------
  test_name = 'duplicate grades_uq_description (metric, description)';
  --------------------------------------------------------------------
  BEGIN
    INSERT INTO scuola247.grades(grade,metric,description,thousandths,mnemonic) VALUES ('10029066000000000','29062000000000','0/1','60','3Â½');
    _results = _results || assert.fail(full_function_name, test_name, 'INSERT was OK but duplicate description was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','grades_uq_description');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  --------------------------------------------------------------
  test_name = 'duplicate grades_uq_mnemonic (metric, mnemonic)';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO scuola247.grades(grade,metric,description,thousandths,mnemonic) VALUES ('10129066000000000','29062000000000','1/5','60','0Â½');
    _results = _results || assert.fail(full_function_name, test_name, 'INSERT was OK but duplicate mnemonic was expected', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','grades_uq_mnemonic');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
   END;

  ------------------------------------
  test_name = 'description not empty';
  ------------------------------------
  BEGIN
    UPDATE scuola247.grades SET description = ' ' WHERE grade = '29066000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description was empty', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23514');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------
  test_name = 'mnemonic not empty';
  ---------------------------------
  BEGIN
    UPDATE scuola247.grades SET mnemonic = ' ' WHERE grade = '29066000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but mnemonic was empty', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23514');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ----------------------------------
  test_name = 'metric''s mandatory';
  ----------------------------------
  BEGIN
    UPDATE scuola247.grades SET metric = NULL WHERE grade = '29066000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but metric was null', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ------------------------------------
  test_name = 'mnemonic''s mandatory';
  ------------------------------------
  BEGIN
    UPDATE scuola247.grades SET mnemonic = NULL WHERE grade = '29066000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but mnemonic was null', NULL::diagnostic.error);
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
    UPDATE scuola247.grades SET description = NULL WHERE grade = '29066000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description was null', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ---------------------------------------
  test_name = 'thousandths''s mandatory';
  ---------------------------------------
  BEGIN
    UPDATE scuola247.grades SET thousandths = NULL WHERE grade = '29066000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but thousandths was null', NULL::diagnostic.error);
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
ALTER FUNCTION unit_tests_public.grades_check(boolean)
  OWNER TO scuola247_supervisor;
