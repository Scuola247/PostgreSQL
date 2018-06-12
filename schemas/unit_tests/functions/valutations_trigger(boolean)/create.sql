
-- Function: unit_tests_public.grading_meetings_valutations_trigger(boolean)

-- DROP FUNCTION unit_tests_public.valutations_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.valutations_trigger(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;


 /* NON TESTABILE.
  --------------------------------------------------------------
  test_name = 'UPDATE valutations with student of different school';
  --------------------------------------------------------------
  BEGIN
    --UPDATE public.valutations set classroom_student = '10872000000000', subject = '32911000000000' WHERE valutation = '86813000000000';
    UPDATE public.valutations set classroom_student = '10872000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the classroom doesnt have the same_year of the grading meeting ', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057P' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;
  */

  ------------------------------------------------------------------
  test_name = 'UPDATE valutations with subject of different school';
  ------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations set subject = '32913000000000'  WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the subject has a different school from the student', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0573' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ------------------------------------------------------------------
  test_name = 'INSERT valutations with subject of different school';
  ------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','32913000000000','72745000000000','62012000000000','29096000000000',NULL,'f','29148000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the subject has a different school from the student', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0574' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ----------------------------------------------------------------------
  test_name = 'UPDATE valutations with grade_type of different subject';
  ----------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET grade_type = '46302000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the grade_type has a different subject', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0575' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ----------------------------------------------------------------------
  test_name = 'INSERT valutations with grade_type of different subject';
  ----------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','46302000000000','62012000000000','29096000000000',NULL,'f','29148000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the grade_type has a different subject', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0576' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  -----------------------------------------------------------------
  test_name = 'UPDATE valutations with topic of different subject';
  -----------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET topic = '61967000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the topic has a different subject', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0577' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  -----------------------------------------------------------------
  test_name = 'INSERT valutations with topic of different subject';
  -----------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','61967000000000','29096000000000',NULL,'f','29148000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the topic has a different subject', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0578' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ----------------------------------------------------------------
  test_name = 'UPDATE valutations with topic of different degree';
  ----------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET topic = '62002000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the grade_type has a different degree', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U0579' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ----------------------------------------------------------------
  test_name = 'INSERT valutations with topic of different degree';
  ----------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62002000000000','29096000000000',NULL,'f','29148000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,' was OK but the grade_type has a different degree', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057A' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;


  -----------------------------------------------------------------
  test_name = 'UPDATE valutations with metric of different school';
  -----------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET grade = '11439000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the metric of grade has a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057B' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  -----------------------------------------------------------------
  test_name = 'INSERT valutations with metric of different school';
  -----------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62012000000000','11439000000000',NULL,'f','29148000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the metric has a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057C' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  /*
  TRIGGER CHE NON SI RIESCONO A FAR SCATTARE CODICI: U057D, U057E
  */

  ----------------------------------------------------------------
  test_name = 'UPDATE valutations with note of different student';
  ----------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET note = '104925000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the note has a different student', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057F' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ---------------------------------------------------------------
  test_name = 'INSERT valutations with note of different school';
  ---------------------------------------------------------------
  BEGIN
      INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62012000000000','29096000000000',NULL,'f','29148000000000','2013-12-06','104925000000000','31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the note has a different student', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057G' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  --------------------------------------------------------------------
  test_name = 'UPDATE valutations with teacher of a different school';
  --------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET teacher = '287713000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the teacher is from a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057H' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  --------------------------------------------------------------------
  test_name = 'INSERT valutations with teacher of a different school';
  --------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62012000000000','29096000000000',NULL,'f','287713000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the teacher is from a different school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057I' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;


  ------------------------------------------------------------------------
  test_name = 'UPDATE valutations with teacher that has different role';
  ------------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET teacher = '30900000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the teacher is not a teacher', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057L' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  ----------------------------------------------------------------------
  test_name = 'INSERT valutations with teacher that has different role';
  ----------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62012000000000','29096000000000',NULL,'f','30900000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the teacher is not a teacher', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057M' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  --------------------------------------------------------------------------
  test_name = 'UPDATE valutations with on_date of out school''s year range';
  --------------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET on_date = '2014-09-14' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the valutation''s date is out of the school year duration', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057N' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  --------------------------------------------------------------------------
  test_name = 'INSERT valutations with on_date of out school''s year range';
  --------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62012000000000','29096000000000',NULL,'f','29148000000000','2014-09-14',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the valutation''s date is out of the school year duration', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057O' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

  --------------------------------------------------------------------------
  test_name = 'UPDATE valutations with on_date of out school''s year range';
  --------------------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET grade = '29096000000000',
				  evaluation = NULL,
				  private = 'f',
				  on_date = '2013-12-06',
				  note = NULL,
			          classroom_student =  '31458000000000',
				  subject = '29107000000000',
				  teacher = '29148000000000',
				  grade_type = '72745000000000',
				  topic = '62012000000000'
			          WHERE valutation = '86814000000000';

    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the valutation''s has duplicated values', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057P' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;
  --------------------------------------------------------------
  test_name = 'INSERT valutations with duplicated values';
  --------------------------------------------------------------
  BEGIN
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('186813000000000','29107000000000','72745000000000','62012000000000','29096000000000',NULL,'f','29148000000000','2013-12-06',NULL,'31458000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the valutation''s has duplicated values', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057Q' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

/* -- NON TESTATO
   -- Come mai?
  --------------------------------------------------------------
  test_name = 'INSERT valutations with duplicated values';
  --------------------------------------------------------------
  BEGIN
    UPDATE public.valutations SET private = 't', note = '1119481000000000' WHERE valutation = '86813000000000';
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the valutation''s has duplicated values', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN SQLSTATE 'U057Q' THEN
      _results = _results || assert.pass(full_function_name, test_name);
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
  END;

 */

    RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.valutations_trigger(boolean)
  OWNER TO postgres;
