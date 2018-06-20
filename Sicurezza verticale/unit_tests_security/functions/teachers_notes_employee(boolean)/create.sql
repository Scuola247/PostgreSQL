-- Function: unit_tests_security.teachers_notes_employee(boolean)

-- DROP FUNCTION unit_tests_security.teachers_notes_employee(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.teachers_notes_employee(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.persons',
										              'unit_tests_public.classrooms',
										              'unit_tests_public.school_years',
										              'unit_tests_public.lessons');
    RETURN;
  END IF;

  -------------------------------------------------
  test_name = 'UPDATE teacher_notes with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-employee-d@scuola-1.it';
    UPDATE public.teachears_notes set teacher = '32933000000000' WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the supervisor shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE '42501' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
     RESET ROLE;
  END;
  
  -------------------------------------------------
  test_name = 'INSERT teacher_notes with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-employee-d@scuola-1.it';
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('10061764000000000','6617000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-02-13',NULL,'10033000000000');

    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the supervisor shouldn''t be able to', NULL::diagnostic.error);
    RETURN;  
    EXCEPTION WHEN SQLSTATE '42501' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
    RESET ROLE;
  END;

  -------------------------------------------------
  test_name = 'DELETE teacher_notes with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-employee-d@scuola-1.it';
    DELETE FROM public.teachears_notes WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the supervisor shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE '42501' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
     RESET ROLE;
  END;

 /*
  -------------------------------------------------
  test_name = 'SELECT sgnature with permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-student-d@scuola-1.it';
    PERFORM 1 FROM public.absences WHERE absence = '33322';         
      _results = _results || assert.pass(full_function_name, test_name);
    RETURN;
    EXCEPTION WHEN SQLSTATE '42501' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
     RESET ROLE;
  END;*/
    /*
     EXCEPTION WHEN OTHERS THEN
       GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;           
     IF error.returned_sqlstate = '42501' THEN 
	_results = _results || assert.fail(full_function_name, test_name,'INSERT was OK the student should be able to', NULL::diagnostic.error);
     ELSIF error.returned_sqlstate = '42601' THEN
        _results = _results || assert.pass(full_function_name, test_name);
     ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
     END IF;
     

     
        RETURN;
    RESET ROLE;
  END;
*/

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.teachers_notes_employee(boolean)
  OWNER TO postgres;
