-- Function: unit_tests_security.signatures_supervisor(boolean)

-- DROP FUNCTION unit_tests_security.signatures_supervisor(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.signatures_supervisor(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role',
											   'unit_tests_public.absences');
    RETURN;
  END IF;

  -------------------------------------------------
  test_name = 'UPDATE signature with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-supervisor-d@scuola.it';
    UPDATE public.signatures set teacher = '32933000000000' WHERE signature = '33773000000000';
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
  test_name = 'INSERT signature with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-supervisor-d@scuola.it';
    INSERT INTO public.signatures(signature,classroom,teacher,on_date,at_time) VALUES ('10133773000000000','10035000000000','32936000000000','2013-09-19','09:47:57');

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
  test_name = 'DELETE absences with no permission';
  -------------------------------------------------
  BEGIN
    SET ROLE 'test-supervisor-d@scuola.it';
    DELETE FROM public.signatures WHERE signature = '33773000000000';
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
ALTER FUNCTION unit_tests_security.signatures_supervisor(boolean)
  OWNER TO postgres;
