-- Function: unit_tests.grading_meetings_valutations_qua_trigger(boolean)

-- DROP FUNCTION unit_tests.grading_meetings_valutations_qua_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests.grading_meetings_valutations_qua_trigger(
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
  
  -------------------------------------------------------------------------------------------------------------------------
  test_name = 'UPDATE grading_meetings_valutations_qua qualification in a different school';
  -------------------------------------------------------------------------------------------------------------------------
  BEGIN
    UPDATE public.grading_meetings_valutations_qua set qualification = '195977000000000' WHERE grading_meeting_valutation = '124388000000000' ;
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but qualification is in a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04T1' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  --------------------------------------------------------------
  test_name = 'INSERT delays with date on sunday';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('1126109000000000','124388000000000','195977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the date is a delay on sunday', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04T2' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  ---------------------------------------------------------------------------
  test_name = 'UPDATE delays date before explanation date';
  ---------------------------------------------------------------------------
  BEGIN
    UPDATE public.grading_meetings_valutations_qua set grade = '11501000000000' WHERE qualification = '95977000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the date is before than the explanation date', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04T5' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  --------------------------------------------------------------
  test_name = 'INSERT delays date before explanation date';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('1126109000000000','124388000000000','96103000000000','11501000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the date is is before than the explanation date', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04T6' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; /*
  ---------------------------------------------------------------------------
  test_name = 'UPDATE teachers out of the classroom';
  ---------------------------------------------------------------------------
  BEGIN
    UPDATE public.delays set teacher = '4112000000000' WHERE delay = '48854000000000';
    
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the teacher is not from the same school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04L7' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  --------------------------------------------------------------
  test_name = 'INSERT teachers out of the classroom';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1048854000000000','29144000000000','158348000000000','2014-02-07','10:10:31','10404000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the teacher is not from the same school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04L8' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  ---------------------------------------------------------------------------
  test_name = 'UPDATE delays date in an absent date';
  ---------------------------------------------------------------------------
  BEGIN
    UPDATE public.delays set classroom_student = '10705000000000' , explanation = '157481000000000', on_date = '2014-01-21'  WHERE delay = '49176000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student is late even when he is absent', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04L9' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;
  --------------------------------------------------------------
  test_name = 'INSERT delays date in an absent date';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('10049176000000000','32933000000000','157481000000000','2014-01-21','08:07:28','10705000000000');
    
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student is late even when he is absent', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04LA' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
 */
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.grading_meetings_valutations_qua_trigger(boolean)
  OWNER TO postgres;
