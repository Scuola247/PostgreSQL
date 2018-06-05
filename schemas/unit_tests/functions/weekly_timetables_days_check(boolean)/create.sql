-- Function: unit_tests.weekly_timetables_days_check(boolean)

-- DROP FUNCTION unit_tests.weekly_timetables_days_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests.weekly_timetables_days_check(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'_after_data_insert');
    RETURN;
  END IF;  
  ---------------------------------------------
  test_name = 'weekly_timetable_day mandatory';
  ---------------------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET weekly_timetable_day = NULL WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but weekly_timetable_day mandatory was expected', NULL::diagnostic.error);      
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    
        RETURN;
  END; 
  -----------------------------------------
  test_name = 'weekly_timetable mandatory';
  -----------------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET weekly_timetable = NULL WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but weekly_timetable_day mandatory was expected', NULL::diagnostic.error);      
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    
        RETURN;
  END; 
  --------------------------------
  test_name = 'weekday mandatory';
  --------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET weekday = NULL WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but weekday  mandatory was expected', NULL::diagnostic.error);      
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    
        RETURN;
  END; 
  --------------------------------------
  test_name = 'team_teaching mandatory';
  --------------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET team_teaching = NULL WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but team_teaching mandatory was expected', NULL::diagnostic.error);      
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    
        RETURN;
  END; 
  --------------------------------------------
  test_name = 'teacher AND subject mandatory';
  --------------------------------------------
  BEGIN
    UPDATE weekly_timetables_days SET(teacher,subject)=(NULL,NULL) WHERE weekly_timetable_day = '33008000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but teacher and subject cannot set to null', NULL::diagnostic.error);      
    RETURN;
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    
        RETURN;
  END; 


  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.weekly_timetables_days_check(boolean)
  OWNER TO postgres;
