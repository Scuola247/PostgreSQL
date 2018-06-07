-- Function: unit_tests_public.notes_trigger(boolean)

-- DROP FUNCTION unit_tests_public.notes_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.notes_trigger(
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
  --------------------------------------------------------------
  test_name = 'UPDATE notes with date on sunday';
  --------------------------------------------------------------
  BEGIN
    UPDATE public.notes set on_date = '2013-09-22' WHERE note = '104925000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the date is on sunday', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y1' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  --------------------------------------------------------------
  test_name = 'INSERT notes with date on sunday';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('1104925000000000','6617000000000','Esempio di una nota disciplinare.','32927000000000','t','2013-09-22','09:00:00','t','10033000000000');
    
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the date is on sunday', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y2' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  /* Già controllato nel trigger di classrooms_students
  ---------------------------------------------------------------------------
  test_name = 'UPDATE notes student in a different school';
  ---------------------------------------------------------------------------
  BEGIN
    UPDATE public.notes set student = '1971000000000' WHERE note = '119289000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student is in a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y3' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  --------------------------------------------------------------
  test_name = 'INSERT notes student in a different school';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('1104925000000000','6617000000000','Esempio di una nota disciplinare.','32927000000000','t','2013-09-22','09:00:00','t','10033000000000');
    
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student is in a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y4' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; */
  ------------------------------------
  test_name = 'UPDATE student absent';
  ------------------------------------
  BEGIN
    UPDATE public.notes set student = '6800000000000' , classroom = '10038000000000' , on_date = '2014-01-21' WHERE note = '104925000000000';
    
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student is absent', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y7' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  ------------------------------------
  test_name = 'INSERT student absent';
  ------------------------------------
  BEGIN
    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('1104925000000000','6800000000000','Esempio di una nota disciplinare.','32927000000000','t','2014-01-21','09:00:00','t','10038000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student is absent', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y8' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  -------------------------------------------------------
  test_name = 'UPDATE notes teacher in different school';
  -------------------------------------------------------
  BEGIN
    UPDATE public.notes set teacher = '4112000000000'  WHERE note = '104925000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the teacher is in a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y5' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;
  -------------------------------------------------------
  test_name = 'INSERT notes teacher in different school';
  -------------------------------------------------------
  BEGIN
    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('1104925000000000','6617000000000','Esempio di una nota disciplinare.','4112000000000','t','2014-06-06','09:01:00','t','10033000000000');
    
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the teacher is in a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04Y6' THEN
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
ALTER FUNCTION unit_tests_public.notes_trigger(boolean)
  OWNER TO postgres;
