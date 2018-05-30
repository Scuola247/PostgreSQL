﻿-- Function: unit_tests.absences_triggers(boolean)

-- DROP FUNCTION unit_tests.absences_triggers(boolean);

CREATE OR REPLACE FUNCTION unit_tests.absences_triggers(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'persons',
										       'classrooms',
										       'school_years',
										       'lessons',
					                                               -- to avoide generation of circular references
					                                               -- 'delays',
					                                               -- to avoide generation of circular references
										       -- 'leavings',
					                                               -- to avoide generation of circular references
										       -- 'out_of_classrooms',
										       'classrooms_students',
										       'explanations'); 
    RETURN;
  END IF;  
  -------------------------------------------------------
  test_name = 'INSERT absence on a date without lessons';
  -------------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033312000000000','2013-11-10','32936000000000',NULL,'10372000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the date has no lessons', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F2' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  --------------------------------------------------------------
  test_name = 'UPDATE date absence with a date without lessons';
  --------------------------------------------------------------
  BEGIN
    UPDATE absences SET on_date = '2013-11-10' WHERE absence = '33312000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the date has no lessons', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F1' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  ------------------------------------------------------
  test_name = 'INSERT absence with a wrong explanation';
  ------------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033311000000000','2013-09-18','32935000000000','57673000000000','10373000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the student was delay', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F4' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  -----------------------------------------------------
  test_name = 'UPDATE absence with a wrong explanation';
  -----------------------------------------------------
  BEGIN
    UPDATE absences SET explanation = '57673000000000' WHERE absence = '33311000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student was delay', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F3' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  ----------------------------------------------------------------
  test_name = 'INSERT absence as a teacher of a different school';
  ----------------------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033311000000000','2013-09-18','287713000000000',NULL,'10373000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but teacher is not a school teacher', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F8' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  ------------------------------------------------------------------------------
  test_name = 'UPDATE absence teacher with another one from a different school';
  ------------------------------------------------------------------------------
  BEGIN
    UPDATE absences SET teacher = '287713000000000' WHERE absence = '33311000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the teacher doesn''t belong to this school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F7' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  --------------------------------------------------------------
  test_name = 'INSERT absence on a date where the student left';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033311000000000','2014-06-06','32926000000000',NULL,'10666000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but student left the school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FC' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  --------------------------------------------------------------------
  test_name = 'UPDATE absence with a date where the the student left';
  --------------------------------------------------------------------
  BEGIN
    UPDATE absences SET on_date = '2014-06-06' WHERE absence = '33382000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student left the school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FB' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;
  -------------------------------------------------------------------
  test_name = 'INSERT absence in a date where the student was delay';
  -------------------------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033311000000000','2013-09-18','32935000000000',NULL,'10373000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the student was delay', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FA' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  -----------------------------------------------------------------------
  test_name = 'UPDATE absence date with one where the student was delay';
  -----------------------------------------------------------------------
  BEGIN
    UPDATE absences SET on_date = '2013-09-18' WHERE absence = '33311000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student was delay', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04F9' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END; 
  ------------------------------------------------------------------------------
  test_name = 'INSERT absence in a date where the student was out of classroom';
  ------------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033311000000000','2013-09-21','32935000000000',NULL,'10379000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the student was out of classroom', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FE' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  ----------------------------------------------------------------------------------
  test_name = 'UPDATE absence date with one where the student was out of classroom';
  ----------------------------------------------------------------------------------
  BEGIN
    UPDATE absences SET on_date = '2013-09-21' WHERE absence = '33305000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student was out of classroom', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FD' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;
  
  -----------------------------------------------------
  test_name = 'INSERT absence with a non teacher role';
  -----------------------------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('10033311000000000','2013-09-18','9898000000000',NULL,'10379000000000'); 
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the student was out of classroom', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FL' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error); 
        RETURN;
  END;  
  ------------------------------------------------------------------
  test_name = 'UPDATE absence teacher field witha non teacher role';
  ------------------------------------------------------------------
  BEGIN
    UPDATE absences SET teacher = '9898000000000' WHERE absence = '33305000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student was out of classroom', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04FH' THEN
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
ALTER FUNCTION unit_tests.absences_triggers(boolean)
  OWNER TO postgres;