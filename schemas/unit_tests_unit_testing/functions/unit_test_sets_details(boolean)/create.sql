-- Function: unit_tests_unit_testing.unit_test_sets_details(boolean)

-- DROP FUNCTION unit_tests_unit_testing.unit_test_sets_details(boolean);

CREATE OR REPLACE FUNCTION unit_tests_unit_testing.unit_test_sets_details(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               	  text;
  full_function_name 	          text;
  test_name		          text = '';
  error			          diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;
  --------------------------------------
  test_name = 'INSERT unit_test_sets_details';
  --------------------------------------
  BEGIN
    INSERT INTO unit_testing.unit_test_sets_details(unit_test_set_detail,unit_test_set,schema_name,function_name) VALUES ('59000000000','56000000000','unit_tests_public','schools');
    INSERT INTO unit_testing.unit_test_sets_details(unit_test_set_detail,unit_test_set,schema_name,function_name) VALUES ('1388000000000','1365000000000','unit_tests_public','schools');

------------------Non funzionanti presi dalla unit_testing.export ---------------
/*
    INSERT INTO unit_testing.unit_test_sets_details(unit_test_set_detail,unit_test_set,schema_name,function_name) VALUES ('59000000000','56000000000','unit_tests','schools');
    INSERT INTO unit_testing.unit_test_sets_details(unit_test_set_detail,unit_test_set,schema_name,function_name) VALUES ('1386000000000','1379000000000','unit_tests','_school_years');
    INSERT INTO unit_testing.unit_test_sets_details(unit_test_set_detail,unit_test_set,schema_name,function_name) VALUES ('1388000000000','1365000000000','unit_tests','schools');
*/
    _results =  _results || assert.pass(full_function_name, test_name);

    EXCEPTION
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT unit_tests_unit_testing.unit_test_sets_details FAILED'::text, error);
        RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_unit_testing.unit_test_sets_details(boolean)
  OWNER TO postgres;
