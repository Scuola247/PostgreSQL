-- Function: unit_tests_public.persons_check(boolean)

-- DROP FUNCTION unit_tests_public.persons_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.persons_check(
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
  result text;
  result_1 text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;
  ----------------------------------------
  test_name = 'duplicate school tax_code';
  ----------------------------------------
  BEGIN
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('130962000000000','Barbara','Licci','2004-11-07',NULL,NULL,'LCCBBR04S47L781Z','F','28961000000000','3590457000000000','L781',NULL,NULL,NULL,NULL,'761554000000000');
   _results =  _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate tax_code was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'persons_uq_school_tax_code');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  --------------------------------
  test_name = 'duplicate usename'; -- controllato che il primo update viene annullato quando viene fatto il secondo
  --------------------------------
  BEGIN
    UPDATE persons SET usename = 'student-f@scuola-28961.it' WHERE person = '31185000000000';
    UPDATE persons SET usename = 'student-f@scuola-28961.it' WHERE person = '29130000000000';

   _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but duplicate usename was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'persons_uq_usename');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;

  END;

  --------------------------------
  test_name = 'name''s mandatory';
  --------------------------------
  BEGIN
    UPDATE persons SET name = NULL WHERE person = '30962000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but name mandatory was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -----------------------------------
  test_name = 'surname''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE persons SET surname = NULL WHERE person = '30962000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but surname mandatory was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -------------------------------
  test_name = 'sex''s mandatory';
  -------------------------------
  BEGIN
    UPDATE persons SET sex = NULL WHERE person = '30962000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but sex mandatory was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ------------------------------------------------------
  test_name = 'city_of_birth_fiscal_code''s min length';
  ------------------------------------------------------
  BEGIN
    UPDATE persons SET city_of_birth_fiscal_code = '  ' WHERE person = '30962000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty city of birth was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'persons_ck_city_of_birth_fiscal_code');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------
  test_name = 'name''s min length';
  ---------------------------------
  BEGIN
    UPDATE persons SET name = '  ' WHERE person = '30962000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty name was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'persons_ck_name');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------
  test_name = 'note''s min length';
  ---------------------------------
  BEGIN
    UPDATE persons SET note = '  ' WHERE person = '30962000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty note was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'persons_ck_note');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ------------------------------------
  test_name = 'surname''s min length';
  ------------------------------------
  BEGIN
    UPDATE persons SET surname = '  ' WHERE person = '30962000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty surname was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'persons_ck_surname');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  -------------------------------------
  test_name = 'tax_code''s min length';
  -------------------------------------
  BEGIN
    UPDATE persons SET tax_code = '  ' WHERE person = '30962000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty tax code was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'persons_ck_tax_code');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ------------------------------------
  test_name = 'usename''s min length';
  ------------------------------------
  BEGIN
    UPDATE persons SET usename = '  ' WHERE person = '30962000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty usename was expected', NULL::diagnostic.error);
    RETURN;
	EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'persons_ck_usename');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.persons_check(boolean)
  OWNER TO postgres;
