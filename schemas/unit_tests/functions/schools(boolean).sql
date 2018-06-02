-- Function: unit_tests.schools(boolean)

-- DROP FUNCTION unit_tests.schools(boolean);

CREATE OR REPLACE FUNCTION unit_tests.schools(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;  
  -----------------------------
  test_name = 'INSERT schools';
  -----------------------------
  BEGIN
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (2000000000, 'Istituto Tecnico Tecnologico "Leonardo da Vinci2"', 'AZITT0000Z', 'ITT DAVINCI2', true, NULL, NULL);
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (1000000000, 'Istituto comprensivo "Andromeda2"', 'AZIC00000Z', 'IC ANDROMEDA2', true, NULL, NULL); -- behavior = 166129000000
    INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (28961000000000, 'Istituto comprensivo "Voyager2"', 'AZIC00001Z', 'IC VOYAGER2', false, NULL, NULL); -- behavior =  166130000000

    _results =  _results || assert.pass(full_function_name, test_name);

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.schools FAILED'::text, error);   
        RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.schools(boolean)
  OWNER TO postgres;
