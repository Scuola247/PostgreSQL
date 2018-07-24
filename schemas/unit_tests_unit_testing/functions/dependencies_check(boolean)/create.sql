-- Function: unit_tests_unit_testing.dependencies_check(boolean)

-- DROP FUNCTION unit_tests_unit_testing.dependencies_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_unit_testing.dependencies_check(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               	  text;
  full_function_name 	          text;
  test_name		          text = '';
  error			          diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;
  -------------------------------------------
  test_name = 'before_schema_name mandatory';
  -------------------------------------------
  BEGIN
    UPDATE unit_testing.dependencies SET before_schema_name = NULL WHERE before_function_name = 'nothing_function';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but before_schema_name mandatory was expected', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ---------------------------------------------
  test_name = 'before_function_name mandatory';
  ---------------------------------------------
  BEGIN
    UPDATE unit_testing.dependencies SET before_function_name = NULL WHERE before_function_name = 'nothing_function';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but before_function_name mandatory was expected', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------------
  test_name = 'run_schema_name mandatory';
  ----------------------------------------
  BEGIN
    UPDATE unit_testing.dependencies SET run_schema_name = NULL WHERE before_function_name = 'nothing_function';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but function_name mandatory was expected', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ------------------------------------------
  test_name = 'run_function_name mandatory';
  ------------------------------------------
  BEGIN
    UPDATE unit_testing.dependencies SET run_function_name = NULL WHERE before_function_name = 'nothing_function';
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but function_name mandatory was expected', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  --------------------------------------------------------------------------------------------------------
  test_name = 'duplicate before_schema_name, before_function_name, run_schema_name and run_function_name';
  --------------------------------------------------------------------------------------------------------
  BEGIN
    INSERT INTO unit_testing.dependencies(dependency,before_schema_name,before_function_name,run_schema_name,run_function_name) VALUES ('1643292000000000','unit_tests_public','absences','unit_tests_public','persons');
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but duplicate before_schema_name, before_function_name, run_schema_name and run_function_name was expected', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505', 'dependencies_uq_all_but_dependency');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  ----------------------------------------------------------------------------------------------------------------------
  test_name = 'check (before_schema_name, before_function_name) and (run_schema_name, run_function_name) are different';
  ----------------------------------------------------------------------------------------------------------------------
  BEGIN
    INSERT INTO unit_testing.dependencies(dependency,before_schema_name,before_function_name,run_schema_name,run_function_name) VALUES ('1643292000000000','unit_tests_public','absences','unit_tests_public','absences');
    _results =  _results || assert.fail(full_function_name, test_name, 'Update was OK but (before_schema_name, before_function_name) different from (run_schema_name and run_function_name) was expected', NULL::diagnostic.error);
    RETURN;

    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514', 'dependencies_ck_schema_function');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_unit_testing.dependencies_check(boolean)
  OWNER TO postgres;
