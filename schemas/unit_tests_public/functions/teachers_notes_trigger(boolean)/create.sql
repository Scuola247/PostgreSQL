-- Function: unit_tests_public.teachears_notes_trigger(boolean)

-- DROP FUNCTION unit_tests_public.teachears_notes_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.teachears_notes_trigger(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.persons',
										                                                                   'unit_tests_public.classrooms',
										                                                                   'unit_tests_public.school_years',
										                                                                   'unit_tests_public.lessons');
    RETURN;
  END IF;

  ------------------------------------------------------
  test_name = 'UPDATE on_date to a day without lessons';
  ------------------------------------------------------
 BEGIN
    UPDATE public.teachears_notes SET on_date = '2013-09-22' WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but on_date there is no lessons', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0541' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
        END;

  ------------------------------------------------------
  test_name = 'INSERT on_date to a day without lessons';
  ------------------------------------------------------
 BEGIN
     INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('10061764000000000','6617000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2013-09-22',NULL,'10033000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Inser was OK but on_date there is no lessons', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0542' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
        END;


  ----------------------------------------------------------------
  test_name = 'UPDATE student with a student from another school';
  ----------------------------------------------------------------
 BEGIN
    UPDATE public.teachears_notes SET student = '9804000000000' WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but student is from another school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0543' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
        END;

  ----------------------------------------------------------------
  test_name = 'INSERT student with a student from another school';
  ----------------------------------------------------------------
 BEGIN
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('10061764000000000','9804000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-02-13',NULL,'10033000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but student is from another school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0544' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
        END;

  ----------------------------------------------------------------
  test_name = 'UPDATE teacher with a teacher from another school';
  ----------------------------------------------------------------
 BEGIN
      UPDATE public.teachears_notes SET teacher = '4207000000000' WHERE teacher_notes = '61764000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but teacher is from another school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0545' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
        END;

  ----------------------------------------------------------------
  test_name = 'INSERT teacher with a teacher from another school';
  ----------------------------------------------------------------
 BEGIN
      INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('10061764000000000','6617000000000','alunno con difficoltÃ  nell''apprendimento','4207000000000','2014-02-13',NULL,'10033000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but teacher is from another school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0546' THEN
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
ALTER FUNCTION unit_tests_public.teachears_notes_trigger(boolean)
  OWNER TO postgres;
