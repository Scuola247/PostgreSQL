-- Function: unit_tests_public.classrooms_trigger(boolean)

-- DROP FUNCTION unit_tests_public.classrooms_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.classrooms_trigger(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.school_years',
										       										       										               'unit_tests_public.degrees',
														       										              						       'unit_tests_public.branches');
    RETURN;
  END IF;
  ---------------------------------------------------------------------
  test_name = 'UPDATE classrooms school_year from a different school ';
  ---------------------------------------------------------------------
  BEGIN
    UPDATE classrooms SET school_year='28969000000000' WHERE classroom = '10062000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the school_year is not from the same school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04G1');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;


 ----------------------------------------------------------------------
  test_name = 'INSERT classrooms school_year from a different school ';
  ---------------------------------------------------------------------
  BEGIN
      INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10010062000000000','28969000000000','9942000000000','C','1','Infanzia 1C','9952000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the school_year is not from the same school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04G2');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  -----------------------------------------------------------------------------
  test_name = 'UPDATE classrooms degree from a different school ';
  -----------------------------------------------------------------------------
  BEGIN
    UPDATE classrooms SET degree='28970000000000' WHERE classroom = '10062000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the degree is not from the same school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04G1');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  -----------------------------------------------------------------------------
  test_name = 'INSERT classrooms degree from a different school ';
  -----------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10110062000000000','243000000000','28970000000000','C','5','Infanzia 5C','9952000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the degree is not from the same school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04G2');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;




  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.classrooms_trigger(boolean)
  OWNER TO postgres;
