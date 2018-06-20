-- Function: unit_tests_public.notes_signed_trigger(boolean)

-- DROP FUNCTION unit_tests_public.notes_signed_trigger(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.notes_signed_trigger(
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

  ------------------------------------------------------------------------
  test_name = 'UPDATE notes_signed with a person from a different school'; -- da controllare se si possono usare i codici moltiplicati per 1000000000
  ------------------------------------------------------------------------
  BEGIN
    UPDATE public.notes_signed SET person = '9589' WHERE note = '104925';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the person is from another school', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04Z1');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  ------------------------------------------------------------------------
  test_name = 'INSERT notes_signed with a person from a different school'; -- da controllare se si possono usare i codici moltiplicati per 1000000000
  ------------------------------------------------------------------------
  BEGIN
    INSERT INTO public.notes_signed(note_signed,person,on_date,note) VALUES ('100113134000000000','31226000000000','2014-06-09 10:39:00','104925000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the person is from another school', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, 'U04Z2');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.notes_signed_trigger(boolean)
  OWNER TO scuola247_supervisor;
