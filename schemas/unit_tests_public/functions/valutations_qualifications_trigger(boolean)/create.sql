-- Function: unit_tests_public.valutations_qualifications_trigger(boolean)

-- DROP FUNCTION unit_tests_public.valutations_qualifications_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.valutations_qualifications_trigger(
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
  ------------------------------------------------------------------------------------------------------
  test_name = 'UPDATE valutations_qualifications with qualification in a different school from student';
  ------------------------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations_qualifications set qualification = '195977000000000' WHERE valutation_qualificationtion = '107038000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student is in a different school', NULL::diagnostic.error);
    RETURN;
	/*
    EXCEPTION WHEN SQLSTATE 'U0581' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
	*/
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0581');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;  ------------------------------------------------------------------------------------------------------
  test_name = 'INSERT valutations_qualifications with qualification in a different school from student';
  ------------------------------------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES ('1107038000000000','105226000000000','195977000000000','11478000000000','Esempio di nota associata ad una qualifica');
	
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student is in a different school', NULL::diagnostic.error);
    RETURN;
	/*
    EXCEPTION WHEN SQLSTATE 'U0582' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
	*/
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0582');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;

	 --NON SI RIESCE A SCATTARE QUESTO TRIGGER Risultato : <NULL> in tutto; Forse trovato errore nel trigger Sottoporre ad Andrea

  ----------------------------------------------------------------------------------------------------
  test_name = 'UPDATE valutations_qualifications with grade in a different school from qualification';
  ----------------------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations_qualifications set grade = '30420000000000' WHERE valutation_qualificationtion = '107137000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the grade is in a different school', NULL::diagnostic.error);
    RETURN;
	/*
    EXCEPTION WHEN SQLSTATE 'U0583' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
	*/
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0583');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;  ---------------------------------------------------------------------------------------------
  test_name = 'INSERT valutations_qualifications with grade in a different from qualification';
  ---------------------------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES ('1107038000000000','105226000000000','95985000000000','30421000000000','Esempio di nota associata ad una qualifica');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the grade is in a different school', NULL::diagnostic.error);
    RETURN;
	/*
    EXCEPTION WHEN SQLSTATE 'U0584' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
	*/
	EXCEPTION WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
		_results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U0584');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.valutations_qualifications_trigger(boolean)
  OWNER TO postgres;
