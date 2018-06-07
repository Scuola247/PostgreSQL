-- Function: unit_tests_public.schools_check(boolean)

-- DROP FUNCTION unit_tests_public.schools_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.schools_check(
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
  ------------------------------------
  test_name = 'duplicate description';
  ------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (28961000000001, 'Istituto comprensivo "Voyager2"', 'BZIC00001Z', 'IC VOYAGER3', false, NULL, NULL);
   _results =  _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate description was expected', NULL::diagnostic.error);      
    RETURN;      

    EXCEPTION WHEN SQLSTATE '23505' THEN 
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;	
      IF error.constraint_name = 'schools_uq_description' THEN
        _results =  _results || assert.pass(full_function_name, test_name);
      ELSE
	_results =  _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);      
	RETURN; 
      END IF; 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
	_results =  _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);       
        RETURN; 
  END;
  ---------------------------------
  test_name = 'duplicate mnemonic';
  ---------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (28961000000001, 'Istituto comprensivo "Voyager3"', 'BZIC00001Z', 'IC VOYAGER2', false, NULL, NULL);
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate mnemonic was expected', NULL::diagnostic.error);   
    RETURN;        
    EXCEPTION WHEN SQLSTATE '23505' THEN 
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'schools_uq_mnemonic' THEN
        _results = _results || assert.pass(full_function_name, test_name); 
      ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN;
      END IF; 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN; 
  END;
  ----------------------------------------
  test_name = 'duplicate processing code';
  ----------------------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (28961000000001, 'Istituto comprensivo "Voyager3"', 'AZIC00001Z', 'IC VOYAGER3', false, NULL, NULL);
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate processing code was expected', NULL::diagnostic.error);   
    RETURN;       
    EXCEPTION WHEN SQLSTATE '23505' THEN 
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;	
      IF error.constraint_name = 'schools_uq_processing_code' THEN
        _results = _results || assert.pass(full_function_name, test_name);
      ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN;
      END IF; 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN; 
  END;
  ---------------------------------------
  test_name = 'description''s mandatory';
  ---------------------------------------
  BEGIN
    UPDATE schools SET description = NULL WHERE school = 28961000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description required was expected', NULL::diagnostic.error);     
    RETURN;    
    EXCEPTION WHEN SQLSTATE '23502' THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
	_results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);         
        RETURN;
  END; 
  ----------------------------------------
  test_name = 'description''s min lenght';
  ----------------------------------------
  BEGIN
    UPDATE schools SET description = '' WHERE school = 28961000000000;
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but description min lenght was expected', NULL::diagnostic.error);    
    RETURN;   
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'schools_min_description' THEN
        _results = _results || assert.pass(full_function_name, test_name);
     ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);       
        RETURN;
      END IF;    
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN;
  END; 
  -------------------------------------------
  test_name = 'processing_code''s mandatory';
  -------------------------------------------
  BEGIN
    UPDATE schools SET processing_code = NULL WHERE school = 28961000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but processing_code mandatory was expected', NULL::diagnostic.error);    
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
      _results = _results || assert.pass(full_function_name, test_name); 
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);      
        RETURN;
  END; 
  --------------------------------------------
  test_name = 'processing_code''s min lenght';
  --------------------------------------------
  BEGIN
    UPDATE schools SET processing_code = '' WHERE school = 28961000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but processing_code min lenght was expected', NULL::diagnostic.error);   
    RETURN;   
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'schools_min_processing_code' THEN
        _results = _results || assert.pass(full_function_name, test_name);
     ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);     
        RETURN;
      END IF;    
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);      
        RETURN;
  END;  
  ------------------------------------
  test_name = 'mnemonic''s mandatory';
  ------------------------------------
  BEGIN
    UPDATE schools SET mnemonic = NULL WHERE school = 28961000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but mnemonic mandatory was expected', NULL::diagnostic.error);   
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
      _results = _results || assert.pass(full_function_name, test_name);  
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  -------------------------------------
  test_name = 'mnemonic''s min lenght';
  -------------------------------------
  BEGIN
    UPDATE schools SET mnemonic = '' WHERE school = 28961000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but mnemonic min lenght was expected', NULL::diagnostic.error);   
    RETURN;   
    EXCEPTION WHEN SQLSTATE '23514' THEN 
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      IF error.constraint_name = 'schools_min_mnemonic' THEN
        _results = _results || assert.pass(full_function_name, test_name);
     ELSE
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN;
      END IF;    
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);   
        RETURN;
  END; 
  -----------------------------------
  test_name = 'example''s mandatory';
  -----------------------------------
  BEGIN
    UPDATE schools SET example = NULL WHERE school = 28961000000000;
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but example mandatory was expected', NULL::diagnostic.error);      
    RETURN;
    EXCEPTION WHEN SQLSTATE '23502' THEN 
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
ALTER FUNCTION unit_tests_public.schools_check(boolean)
  OWNER TO postgres;
