-- Function: unit_tests_public.leavings_trigger(boolean)

-- DROP FUNCTION unit_tests_public.leavings_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.leavings_trigger(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.explanations',
                                                                                       'unit_tests_public.persons',
                                                                                       'unit_tests_public.classrooms_students',
                                                                                       'unit_tests_public.classrooms',
                                                                                       'unit_tests_public.school_years',
                                                                                       'unit_tests_public.absences',
                                                                                       'unit_tests_public.lessons');
    RETURN;
  END IF;
  --------------------------------------------------------------------
  test_name = 'UPDATE leavings with a date where there''s no lessons';
  --------------------------------------------------------------------
 BEGIN
    UPDATE leavings SET on_date = '2013-09-22' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but there''s no lessons on that date', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U1');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
    END;

  --------------------------------------------------------------------
  test_name = 'INSERT leavings with a date where there''s no lessons';
  --------------------------------------------------------------------
 BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('10058393000000000','32932000000000','57133000000000','2013-09-22','11:52:52','10685000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but there''s no lessons on that date', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U2');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
   END;
/*
  ------------------------------ 
  test_name = 'UPDATE leavings change the classroom_student from different school '; -- trigger U04U5 U04U6 non funzionante, motivazione: introduzione della chiave classroom_student  
  ------------------------------
 BEGIN
    UPDATE leavings SET classroom_student= '31551000000000' WHERE leaving = '59294000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the classroom is from a different school ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U04U5' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
        END;
*/
  -----------------------------------------------------------------
  test_name = 'UPDATE leavings with a teacher from another school';
  -----------------------------------------------------------------
 BEGIN
    UPDATE leavings SET teacher='4036000000000' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the teacher is from another school', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U7');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
    END;
  -----------------------------------------------------------------
  test_name = 'INSERT leavings with a teacher from another school';
  -----------------------------------------------------------------
 BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1058394000000000','4036000000000','1057134000000000','2013-09-17','11:52:50','10685000000000');
   _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the teacher is from another school', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U8');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
    END;

  -----------------------------------------------------
  test_name = 'UPDATE leavings with an absent student';
  -----------------------------------------------------
 BEGIN
    UPDATE leavings SET classroom_student = '10372000000000', explanation='157189000000000' WHERE leaving = '58449000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the student is absent', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U9');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  -----------------------------------------------------
  test_name = 'INSERT leavings with an absent student';
  -----------------------------------------------------
 BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1058449000000000','32936000000000','157189000000000','2013-10-05','11:38:38','10372000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the student is absent', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04UA');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  ---------------------------------------------------
  test_name = 'UPDATE leavings set to a non teacher';
  ---------------------------------------------------
  BEGIN
    UPDATE leavings SET teacher = '6659000000000' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the teacher is not a teacher', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04UB');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  ---------------------------------------------------------
  test_name = 'INSERT leavings set to a non teacher code ';
  ---------------------------------------------------------
 BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1058393000000000','6659000000000','1057133000000000','2013-09-16','11:52:50','10685000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the teacher is not a teacher', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04UC');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  ----------------------------------------------------------
  test_name = 'UPDATE leavings set to a wrong explanations';
  ----------------------------------------------------------
  BEGIN
    UPDATE leavings SET explanation = '57134000000000' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the explanation is wrong', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U3');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  ----------------------------------------------------------
  test_name = 'INSERT leavings set to a wrong explanations';
  ----------------------------------------------------------
  BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1158393000000000','32932000000000','57134000000000','2013-09-16','11:52:50','10685000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the explanation is wrong', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U4');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  -----------------------------------------------------
  test_name = 'UPDATE leavings set to a wrong student';
  -----------------------------------------------------
  BEGIN
    UPDATE leavings SET classroom_student = '10724000000000' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the classroom_student is wrong', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U3');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  -----------------------------------------------------
  test_name = 'INSERT leavings set to a wrong student';
  -----------------------------------------------------
  BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1258393000000000','32932000000000','57133000000000','2013-09-16','11:52:50','10724000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the classroom_student is wrong', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U4');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  -----------------------------------------------------
  test_name = 'UPDATE leavings set to a wrong on_date';
  -----------------------------------------------------
  BEGIN
    UPDATE leavings SET on_date = '2013-09-20' WHERE leaving = '58393000000000';
    _results = _results || assert.fail(full_function_name, test_name,'Update was OK but the on_date is wrong', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U3');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  -----------------------------------------------------
  test_name = 'INSERT leavings set to a wrong on_date';
  -----------------------------------------------------
  BEGIN
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1258393000000000','32932000000000','57133000000000','2013-09-20','11:52:50','10685000000000');
    _results = _results || assert.fail(full_function_name, test_name,'Insert was OK but the on_date is wrong', NULL::diagnostic.error);
    RETURN;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04U4');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

 RETURN;


END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.leavings_trigger(boolean)
  OWNER TO scuola247_supervisor;
