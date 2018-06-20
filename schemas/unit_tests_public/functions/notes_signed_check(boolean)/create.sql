-- Function: unit_tests_public.notes_signed_check(boolean)

-- DROP FUNCTION unit_tests_public.notes_signed_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.notes_signed_check(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.school_years',
                                                                                       'unit_tests_public.classrooms',
                                                                                       'unit_tests_public.persons',
                                                                                       'unit_tests_public.notes');
    RETURN;
  END IF;

  -----------------------------
  test_name = 'duplicate note';
  -----------------------------
  BEGIN
    INSERT INTO public.notes_signed(note_signed,person,on_date,note) VALUES ('100113134000000000','8579000000000','2014-06-10 10:39:00','104925000000000');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate note was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','notes_signed_uq_note_person');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
        END;

  ----------------------------------
  test_name = 'person''s mandatory'; -- da controllare se si può aver lo stesso risultato mettendo codice moltiplicato per 1000000000
  ----------------------------------
  BEGIN
    UPDATE notes_signed SET person = NULL WHERE note = '104925';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but person required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;

  --------------------------------
  test_name = 'note''s mandatory'; -- da controllare se si può aver lo stesso risultato mettendo codice moltiplicato per 1000000000
  --------------------------------
   BEGIN
    UPDATE notes_signed SET note = NULL WHERE note = '105054';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but note required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
	IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;
  END;


  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.notes_signed_check(boolean)
  OWNER TO scuola247_supervisor;
