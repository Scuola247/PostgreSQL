-- Function: unit_tests_security.cities(boolean)

-- DROP FUNCTION unit_tests_security.cities(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.cities(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_security.create_role','unit_tests_public.cities');
    RETURN;
  END IF;

 -- STUDENT

 -------------------------------------
 test_name = 'SELECT in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'INSERT in student role';
 -------------------------------------
 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('1','Airasca (test)','758321000000000','11758438000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'UPDATE in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'DELETE in student role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-student-a@scuola-1.it';
    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;

    
END;
RESET ROLE;

-- SUPERVISOR

 -------------------------------------
 test_name = 'SELECT in supervisor role';
 -------------------------------------


 BEGIN
    SET ROLE 'test-supervisor@scuola.it';
    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'INSERT in supervisor role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-supervisor@scuola.it';
  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('1','Airasca (test)','758321000000000','11758438000000000');
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'UPDATE in supervisor role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-supervisor@scuola.it';
    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'DELETE in supervisor role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-supervisor@scuola.it';
    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the supervisor should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;


--EXECUTIVE

 -------------------------------------
 test_name = 'SELECT in executive role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the executive should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'INSERT in executive role';
 -------------------------------------
 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('1','Airasca (test)','758321000000000','11758438000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the executive shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'UPDATE in executive role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the executive shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'DELETE in executive role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-executive-a@scuola-1.it';
    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the executive shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;

    
END;
RESET ROLE;

-- EMPLOYEE

 -------------------------------------
 test_name = 'SELECT in employee role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the employee should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'INSERT in employee role';
 -------------------------------------
 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('1','Airasca (test)','758321000000000','11758438000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the employee shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'UPDATE in employee role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the employee shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'DELETE in employee role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-employee-a@scuola-1.it';
    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the employee shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;

    
END;
RESET ROLE;


-- teacher

 -------------------------------------
 test_name = 'SELECT in teacher role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the teacher should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'INSERT in teacher role';
 -------------------------------------
 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('1','Airasca (test)','758321000000000','11758438000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the teacher shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'UPDATE in teacher role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the teacher shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'DELETE in teacher role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-teacher-a@scuola-1.it';
    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the teacher shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;

    
END;
RESET ROLE;

-- relative

 -------------------------------------
 test_name = 'SELECT in relative role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the relative should be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'INSERT in relative role';
 -------------------------------------
 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('1','Airasca (test)','758321000000000','11758438000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the relative shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;

 -------------------------------------
 test_name = 'UPDATE in relative role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the relative shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;
    
END;
RESET ROLE;
 -------------------------------------
 test_name = 'DELETE in relative role';
 -------------------------------------

 BEGIN
    SET ROLE 'test-relative-a@scuola-1.it';
    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the relative shouldn''t be able to', NULL::diagnostic.error);
    RESET ROLE;
    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;

    
END;
RESET ROLE;


END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.cities(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.cities(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.cities(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.cities(boolean) TO scuola247_user;
