-- Function: unit_tests.explanations_trigger(boolean)

-- DROP FUNCTION unit_tests.explanations_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests.explanations_trigger(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'persons_relations',
										       'persons',
										       'persons_roles');
    RETURN;
  END IF; 

 
 -----------------------------------------------------------------------------
  test_name = 'UPDATE student explanation with no student ';
 -----------------------------------------------------------------------------
  BEGIN
    UPDATE explanations SET student='32926000000000' WHERE explanation = '57313000000000';  
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the person is not a student', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M1' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;   
    -----------------------------------------------------------------------------
    test_name = 'insert explanation with no student  ';
  -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO  public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('10057313000000000','32926000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','3512000000000','2013-10-25 10:44:59','32933000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
    _results = _results || assert.fail(full_function_name, test_name,'the person is not a student', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M2' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  
  -----------------------------------------------------------------------------
    test_name = 'the school of student is different by school of who created it   ';
  -----------------------------------------------------------------------------
  BEGIN
    UPDATE explanations SET created_by='29146000000000'  WHERE explanation = '57313000000000';  
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the the school of student is different by school of who created it', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M3' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  -----------------------------------------------------------------------------
    test_name = 'INSERT of the school of student is different by school of who created it   ';
  -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('10057313000000000','1214000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','29146000000000','2013-10-25 10:44:59','32933000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
    _results = _results || assert.fail(full_function_name, test_name,' The school of student is different by school of who created it', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M4' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  -----------------------------------------------------------------------------
    test_name = 'Update the year is not <18 ';
  -----------------------------------------------------------------------------
  BEGIN
    UPDATE explanations SET created_by='6743000000000' WHERE explanation='48840000000000';
        _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student is not an adult', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M5' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  -----------------------------------------------------------------------------
    test_name = 'INSERT of the year is not <18 ';
  -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('10057313000000000','6743000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','6743000000000','2013-10-25 10:44:59','32933000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
        _results = _results || assert.fail(full_function_name, test_name,'The student is not an adult', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M6' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
 -----------------------------------------------------------------------------
    test_name = ' update with  no permited to justify ';
 -----------------------------------------------------------------------------
  BEGIN
    UPDATE explanations SET created_by='6739000000000' WHERE explanation='57313000000000';
        _results = _results || assert.fail(full_function_name, test_name,'Update was OK but is not permited to justify the explanation ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M7' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 

 -----------------------------------------------------------------------------
    test_name = ' INSERT with no explicity adult ';
 -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('10057313000000000','6743000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','6739000000000','2013-10-25 10:44:59','32933000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
        _results = _results || assert.fail(full_function_name, test_name,'Is not permited to justify the explanation ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M8' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
 -----------------------------------------------------------------------------
    test_name = ' registered_by with no equals schools ';
 -----------------------------------------------------------------------------
  BEGIN
    UPDATE explanations SET registered_by='29146000000000' WHERE explanation='57313000000000';
        _results = _results || assert.fail(full_function_name, test_name,'Update was OK but who registered the explanation is from different school  ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04M9' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 

  -----------------------------------------------------------------------------
    test_name = 'insert of  registered_by with no equals schools ';
 -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('100457313000000000','1214000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','3512000000000','2013-10-25 10:44:59','29146000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
        _results = _results || assert.fail(full_function_name, test_name,' who registered the explanation is from different school  ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04MA' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
   -----------------------------------------------------------------------------
    test_name = ' registered_by with no teacher,executive,supervisor,employee ';
 -----------------------------------------------------------------------------
  BEGIN
    UPDATE explanations SET registered_by='3512000000000' WHERE explanation='57313000000000';
        _results = _results || assert.fail(full_function_name, test_name,'Update was OK but who registered the explanation is not a teacher,employee,supervisor,executive  ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04MB' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
 -----------------------------------------------------------------------------
    test_name = ' registered_by with no teacher,executive,supervisor,employee ';
 -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('10557313000000000','1214000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','3512000000000','2013-10-25 10:44:59','3512000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
        _results = _results || assert.fail(full_function_name, test_name,'Who registered the explanation is not a teacher,employee,supervisor or executive  ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04MC' THEN
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
ALTER FUNCTION unit_tests.explanations_trigger(boolean)
  OWNER TO postgres;
