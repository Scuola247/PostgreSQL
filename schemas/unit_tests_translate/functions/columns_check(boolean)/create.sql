-- Function: unit_tests_translate.columns_check(boolean)

-- DROP FUNCTION unit_tests_translate.columns_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_translate.columns_check(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;

  ----------------------------------
  test_name = ' mandatory relation';
  ----------------------------------
  BEGIN
    UPDATE translate.columns c SET relation = NULL WHERE c.column = '299999000000000';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but relation mandatory was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------
  test_name = ' mandatory position';
  ----------------------------------
  BEGIN
    UPDATE translate.columns c SET position = NULL WHERE c.column = '299999000000000';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but position mandatory was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;
  
  ------------------------------
  test_name = ' mandatory name';
  ------------------------------
  BEGIN
    UPDATE translate.columns c SET name = NULL WHERE c.column = '299999000000000';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but name mandatory was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------
  test_name = ' mandatory language';
  ----------------------------------
  BEGIN
    UPDATE translate.columns c SET language = NULL WHERE c.column = '299999000000000';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but language mandatory was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------------------------
  test_name = 'DUPLICATE relation name and language';
  ---------------------------------------------------
  BEGIN
    INSERT INTO translate.columns("column",relation,position,name,language,translation,comment) VALUES ('1299999000000000','299117000000000','2','student','297479000000000','alunn','Studente con le assenze non giustificate');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate relation name and language was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'columns_uq_relation_name_language');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF; 
  END;
  
  ---------------------------------------------------------------
  test_name = 'DUPLICATE relation name language and translation'; -- da vedere con Andrea perchè non si riesce a farlo scattare, intercettato da columns_uq_relation_name_language
  ---------------------------------------------------------------
  BEGIN
    INSERT INTO translate.columns("column",relation,position,name,language,translation,comment) VALUES ('1299999000000000','299117000000000','2','studen','297479000000000','alunno','Studente con le assenze non giustificat');
    UPDATE translate.columns c SET name = 'student', translation = 'Studente con le assenze non giustificate' WHERE c.column = 1299999000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate relation name language and translation was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'columns_uq_relation_name_language_translation');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF; 
  END;
  
  RETURN;
END

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_translate.columns_check(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_translate.columns_check(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_translate.columns_check(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_translate.columns_check(boolean) TO scuola247_user;
