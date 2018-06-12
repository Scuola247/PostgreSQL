-- Function: unit_tests_public.branches(boolean)

-- DROP FUNCTION unit_tests_public.branches(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.branches(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.schools');
    RETURN;
  END IF;
  ------------------------------
  test_name = 'INSERT branches';
  ------------------------------
  BEGIN
    INSERT INTO branches (branch, school, description) VALUES (9948000000000, 1000000000, 'Sede');
    INSERT INTO branches (branch, school, description) VALUES (9953000000000, 2000000000, 'Sede');
    INSERT INTO branches (branch, school, description) VALUES (9952000000000, 1000000000, 'Filiale Borgo Trento');
    INSERT INTO branches (branch, school, description) VALUES (9954000000000, 2000000000, 'Filiale Borgo Roma');
    INSERT INTO branches (branch, school, description) VALUES (28962000000000, 28961000000000, 'Primaria Borgo Trento');
    INSERT INTO branches (branch, school, description) VALUES (28965000000000, 28961000000000, 'Infanzia frazione Quinzano');
    INSERT INTO branches (branch, school, description) VALUES (28963000000000, 28961000000000, 'Infanzia frazione Avesa');
    INSERT INTO branches (branch, school, description) VALUES (28964000000000, 28961000000000, 'Primaria Borgo Nuovo');
    INSERT INTO branches (branch, school, description) VALUES (28966000000000, 28961000000000, 'Secondaria di I grado frazione Borgo Milano');       
   
    _results = _results || assert.pass(full_function_name, test_name);    

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.branches FAILED', error);
        RETURN;
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.branches(boolean)
  OWNER TO postgres;
