-- Function: unit_tests_security.grading_meeting_valutations_qua(boolean)

-- DROP FUNCTION unit_tests_security.grading_meetings_valutations_qua(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.grading_meetings_valutations_qua(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role','unit_tests_public._after_data_insert');
    RETURN;
  END IF;

 -- STUDENT

 -------------------------------------
 test_name = 'SELECT in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;

    
END;

-- SUPERVISOR 

 -------------------------------------
 test_name = 'SELECT in supervisor role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-supervisor-a@scuola.it';
    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE in supervisor role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-supervisor-a@scuola.it';
    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126109000000000';    
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT in supervisor role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-supervisor-a@scuola.it';
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE in supervisor role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-supervisor-a@scuola.it';
    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;


--EXECUTIVE 

 -------------------------------------
 test_name = 'SELECT in executive role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the executive should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE in executive role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126109000000000';    
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE wasn''t OK but the executive should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT in executive role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the executive should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE in executive role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the executive should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END; 

-- EMPLOYEE
 -------------------------------------
 test_name = 'SELECT in employee role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the employee should be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE in employee role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126109000000000';   
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the employee should be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT in employee role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the employee should be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE in employee role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the employee should be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the employee should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END; 

-- teacher

 -------------------------------------
 test_name = 'SELECT in teacher role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the teacher should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE in teacher role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126109000000000';    
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE wasn''t OK but the teacher should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT in teacher role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the teacher should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE in teacher role';
 -------------------------------------
 
 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the teacher should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END; 


-- relative 

 -------------------------------------
 test_name = 'SELECT in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;

    
END;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.grading_meetings_valutations_qua(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.grading_meetings_valutations_qua(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.grading_meetings_valutations_qua(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.grading_meetings_valutations_qua(boolean) TO scuola247_user;
GRANT EXECUTE ON FUNCTION unit_tests_security.grading_meetings_valutations_qua(boolean) TO "jiahaodong@gmail.com" WITH GRANT OPTION;
