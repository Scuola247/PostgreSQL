-- Function: unit_tests_translate.languages_check(boolean)

-- DROP FUNCTION unit_tests_translate.languages_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_translate.languages_check(
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


  -----------------------------------

  test_name = 'description mandatory';

  -----------------------------------

  BEGIN

    UPDATE languages SET descrption = NULL WHERE language = '297479000000000';

    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but description mandatory was expected', NULL::diagnostic.error);      

    RETURN;

    EXCEPTION WHEN SQLSTATE '23502' THEN 

      _results = _results || assert.pass(full_function_name, test_name);

      WHEN OTHERS THEN 

        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    

        RETURN;

  END; 

 -----------------------------------

  test_name = 'schema mandatory';

  -----------------------------------

  BEGIN

    UPDATE languages SET schema = NULL WHERE language = '297479000000000';

    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but schema mandatory was expected', NULL::diagnostic.error);      

    RETURN;

    EXCEPTION WHEN SQLSTATE '23502' THEN 

      _results = _results || assert.pass(full_function_name, test_name);

      WHEN OTHERS THEN 

        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);    

        RETURN;

  END; 
  ---------------------------------

  test_name = 'duplicate descrpition';

  ---------------------------------

  BEGIN

    INSERT INTO translate.languages(language,description,schema) VALUES ('1297479000000000','Italian','uk');

    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate description was expected', NULL::diagnostic.error);   

    RETURN;        

    EXCEPTION WHEN SQLSTATE '23505' THEN 

      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

      IF error.constraint_name = 'languages_uq_description' THEN

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
    BEGIN

    INSERT INTO translate.languages(language,description,schema) VALUES ('2297479000000000','England','it');

    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate schema was expected', NULL::diagnostic.error);   

    RETURN;        

    EXCEPTION WHEN SQLSTATE '23505' THEN 

      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;

      IF error.constraint_name = 'languages_uq_schema' THEN

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
  

  RETURN; 

END

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_translate.languages_check(boolean)
  OWNER TO postgres;
