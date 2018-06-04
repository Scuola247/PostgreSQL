-- Function: unit_tests.topics_trigger(boolean)

-- DROP FUNCTION unit_tests.topics_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests.topics_trigger(
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
  -----------------------------------------------------------------------------
  test_name = 'UPDATE topics set subject  with different school';
  -----------------------------------------------------------------------------
  BEGIN
    UPDATE topics SET subject='29117000000000' WHERE topic = '33242000000000';  
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the subject set has different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0551' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
    BEGIN
      INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES ('10033242000000000','29117000000000','I congiuntivi, gli imperativi, i condizionali','1','9944000000000');
    _results = _results || assert.fail(full_function_name, test_name,'the subject set has different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0552' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
    -----------------------------------------------------------------------------
  test_name = 'UPDATE topics set subject  with different school';
  -----------------------------------------------------------------------------
  BEGIN
    UPDATE topics SET subject='29117000000000' WHERE topic = '33242000000000';  
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the subject set has different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0551' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
      -----------------------------------------------------------------------------
  test_name = 'UPDATE topics set with course year biggest than that permited ';
  -----------------------------------------------------------------------------
    BEGIN
      Update topics SET course_year='6' WHERE topic='33242000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the course_year set is major than course_year permitted', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0553' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
      -----------------------------------------------------------------------------
  test_name = 'Insert topics set with course year biggest than that permited';
  -----------------------------------------------------------------------------
      BEGIN
      INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES ('10033242000000000','32911000000000','I congiuntivi, gli imperativi, i condizionali','6','9944000000000');
    _results = _results || assert.fail(full_function_name, test_name,'the course_year set is major than course_year permitted', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0554' THEN
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
ALTER FUNCTION unit_tests.topics_trigger(boolean)
  OWNER TO postgres;
