-- Function: unit_tests_public.parents_meetings_check(boolean)

-- DROP FUNCTION unit_tests_public.parents_meetings_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.parents_meetings_check(
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
  test_name = 'mandatory teacher';
  --------------------------------
  BEGIN
    UPDATE parents_meetings SET teacher= NULL WHERE parents_meeting = '33433000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but teacher was expected', NULL::diagnostic.error);
    RETURN;
    /*EXCEPTION WHEN SQLSTATE '23502' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;*/
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;  END;

/*
manca una combinazione sul check parents_meetings_uq
- duplicate teacher
*/

  ------------------------------------

  test_name = 'duplicate on_date';

  ------------------------------------

  BEGIN

    UPDATE parents_meetings SET on_date = '2013-10-29 00:00:00' WHERE parents_meeting = '33433000000000';
   _results =  _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate on_date was expected', NULL::diagnostic.error);

    RETURN;

   /*EXCEPTION WHEN SQLSTATE '23505' THEN

      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

      IF error.constraint_name = 'parents_meetings_uq' THEN

        _results =  _results || assert.pass(full_function_name, test_name);

      ELSE

	_results =  _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

	RETURN;

      END IF;

      WHEN OTHERS THEN

        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

	_results =  _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;*/
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','parents_meetings_uq');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;
  END;


  ------------------------------------

  test_name = 'duplicate teacher';

  ------------------------------------
  
  BEGIN

    UPDATE parents_meetings SET teacher = '32925000000000' WHERE parents_meeting = '133564000000000';
   _results =  _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate teacher was expected', NULL::diagnostic.error);

    RETURN;

   /*EXCEPTION WHEN SQLSTATE '23505' THEN

      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

      IF error.constraint_name = 'parents_meetings_uq' THEN

        _results =  _results || assert.pass(full_function_name, test_name);

      ELSE

	_results =  _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

	RETURN;

      END IF;

      WHEN OTHERS THEN

        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

	_results =  _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;*/
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','parents_meetings_uq');
		IF unit_testing.last_unit_test_failed(_results) THEN RETURN; END IF;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.parents_meetings_check(boolean)
  OWNER TO scuola247_supervisor;
