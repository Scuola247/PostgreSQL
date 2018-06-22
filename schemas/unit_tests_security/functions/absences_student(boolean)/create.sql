-- Function: unit_tests_security.absences_student(boolean)

-- DROP FUNCTION unit_tests_security.absences_student(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.absences_student(
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
  _current_user         name;
  command               text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role',
											   'unit_tests_public.absences');
    RETURN;
  END IF;

  SELECT current_user INTO _current_user;

  -------------------------------------------------
  test_name = 'UPDATE absences with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    UPDATE public.absences set teacher = '32933000000000' WHERE absence = '33312000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE '42501' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;
  
  -------------------------------------------------
  test_name = 'INSERT absences with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('1133312000000000','2013-10-05','32936000000000',NULL,'10372000000000');

    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE '42501' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  -------------------------------------------------
  test_name = 'DELETE absences with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    DELETE FROM public.absences WHERE absence = '33312000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
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
  test_name = 'SELECT absences with permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-student-a@scuola-1.it';  
    PERFORM 1 FROM public.absences WHERE absence = '33322';        
    _results = _results || assert.pass(full_function_name, test_name);
    EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name, 'SELECT was not ok but the student should be able to', NULL::diagnostic.error); 
    RETURN;  
     WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
     RESET ROLE;
  END;

  command = format('SET ROLE %L', _current_user);
  EXECUTE command;
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
ALTER FUNCTION unit_tests_security.absences_student(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences_student(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences_student(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.absences_student(boolean) TO scuola247_user;
