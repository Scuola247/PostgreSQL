-- Function: unit_tests_public.degrees(boolean)

-- DROP FUNCTION unit_tests_public.degrees(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.degrees(
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
  ----------------------------
  test_name = 'INSERT degree';
  ----------------------------
  BEGIN
    INSERT INTO degrees (degree, school, description, course_years) VALUES (9942000000000, 1000000000, 'Scuola dell''infanzia', 3);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (9943000000000, 1000000000, 'Scuola primaria', 5);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (9944000000000, 1000000000, 'Scuola secondaria di primo grado', 3);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (9945000000000, 2000000000, 'Elettronica', 5);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (9947000000000, 2000000000, 'Informatica', 5);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (28970000000000, 28961000000000, 'scuola dell''infanzia', 3);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (28971000000000, 28961000000000, 'scuola primaria', 5);
    INSERT INTO degrees (degree, school, description, course_years) VALUES (28972000000000, 28961000000000, 'scuola secondaria di I grado', 3);
   
    _results = _results || assert.pass(full_function_name, test_name);    

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.degrees FAILED', error);
        RETURN;
  END;
RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.degrees(boolean)
  OWNER TO postgres;
