-- Function: unit_tests_public.grade_types_check(boolean)

-- DROP FUNCTION unit_tests_public.grade_types_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.grade_types_check(
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

  ---------------------------------
  test_name = 'duplicate mnemonic';
  ---------------------------------
  BEGIN
    INSERT INTO scuola247.grade_types(grade_type,description,subject,mnemonic) VALUES ('146300000000000','Scritto','29108000000000','S');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate mnemonic was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'grade_types_uq_mnemonic');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ------------------------------------
  test_name = 'duplicate description';
  ------------------------------------
  BEGIN
    INSERT INTO scuola247.grade_types(grade_type,description,subject,mnemonic) VALUES ('1146299000000000','Scritto','29107000000000','SS');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate description was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'tipi_grades_uq_description');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  --------------------------------
  test_name = 'subject mandatory';
  --------------------------------
  BEGIN
    UPDATE scuola247.grade_types SET subject = NULL WHERE grade_type = '46299000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but subject required was expected', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  ------------------------------------
  test_name = 'description mandatory';
  ------------------------------------
  BEGIN
    UPDATE scuola247.grade_types SET description = NULL WHERE grade_type = '46299000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------------
  test_name = 'description''s min lenght';
  ----------------------------------------
  BEGIN
    UPDATE scuola247.grade_types SET description = '' WHERE grade_type = '46299000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but description min lenght was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'grade_types_ck_description');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------------
  test_name = 'mnemonic''s min lenght';
  ----------------------------------------
  BEGIN
    UPDATE scuola247.grade_types SET mnemonic = '' WHERE grade_type = '46299000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but description min lenght was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'grade_types_ck_mnemonic');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.grade_types_check(boolean)
  OWNER TO scuola247_supervisor;
