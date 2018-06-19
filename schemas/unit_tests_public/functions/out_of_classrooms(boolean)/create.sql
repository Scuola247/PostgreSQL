-- Function: unit_tests_public.out_of_classrooms(boolean)

-- DROP FUNCTION unit_tests_public.out_of_classrooms(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.out_of_classrooms(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	  text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.classrooms_students',
                                                                                       'unit_tests_public.persons',
                                                                                       'unit_tests_public.lessons',
                                                                                       'unit_tests_public.school_years',
                                                                                       'unit_tests_public.absences',
                                                                                       'unit_tests_public.classrooms');
    RETURN;
  END IF;
  ---------------------------------------
  test_name = 'INSERT out_of_classrooms';
  ---------------------------------------
  BEGIN
    INSERT INTO public.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES ('98577000000000','32937000000000','per selezioni sportive','2013-09-21','08:00:00','12:00:00','10379000000000');
    INSERT INTO public.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES ('98578000000000','32937000000000','per selezioni sportive','2013-09-21','08:00:00','12:00:00','10380000000000');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.out_of_classrooms FAILED'::text, error);
       RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.out_of_classrooms(boolean)
  OWNER TO postgres;
