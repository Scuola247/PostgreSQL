-- Function: unit_tests_public.qualifications_plan(boolean)

-- DROP FUNCTION unit_tests_public.qualifications_plan(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.qualifications_plan(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.degrees',
                                                                                       'unit_tests_public.qualifications',
                                                                                       'unit_tests_public.subjects');
    RETURN;
  END IF;
  -----------------------------------------
  test_name = 'INSERT qualifications_plan';
  -----------------------------------------
  BEGIN
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128989000000000','96108000000000','9944000000000','1','32911000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128990000000000','96109000000000','9944000000000','2','32911000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128991000000000','96110000000000','9944000000000','3','32911000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128992000000000','95991000000000','9944000000000','1','32912000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128993000000000','96093000000000','9944000000000','2','32912000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128994000000000','96094000000000','9944000000000','3','32912000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128995000000000','96108000000000','9944000000000','1','32914000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128996000000000','96109000000000','9944000000000','2','32914000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128997000000000','96110000000000','9944000000000','3','32914000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128998000000000','96111000000000','9944000000000','1','32915000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('128999000000000','96108000000000','9944000000000','2','32915000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129000000000000','96109000000000','9944000000000','3','32915000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129001000000000','96110000000000','9944000000000','1','32916000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129002000000000','96111000000000','9944000000000','2','32916000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129003000000000','96112000000000','9944000000000','3','32916000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129004000000000','96136000000000','9944000000000','1','32917000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129005000000000','96137000000000','9944000000000','2','32917000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129006000000000','96138000000000','9944000000000','3','32917000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129007000000000','96164000000000','9944000000000','1','32918000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129008000000000','96165000000000','9944000000000','2','32918000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129009000000000','96166000000000','9944000000000','3','32918000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129010000000000','96167000000000','9944000000000','1','32919000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129011000000000','96168000000000','9944000000000','2','32919000000000');
	INSERT INTO scuola247.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES ('129012000000000','96169000000000','9944000000000','3','32919000000000');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT scuola247.qualifications_plan FAILED'::text, error);
       RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.qualifications_plan(boolean)
  OWNER TO postgres;
