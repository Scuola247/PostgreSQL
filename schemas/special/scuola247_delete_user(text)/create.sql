-- Function: assert.are_equals(text, text, anyarray)

-- DROP FUNCTION assert.are_equals(text, text, anyarray);

CREATE OR REPLACE FUNCTION special.scuola247_delete_user(
    IN _usename text)
  RETURNS void AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;

  error			diagnostic.error;
  school		bigint;
  command		text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  BEGIN

    UPDATE persons SET usename = NULL WHERE usename = _usename;

    DELETE FROM public.usename_ex WHERE usename = _usename;

    DELETE FROM usenames_schools WHERE usename = _usename;

    command = format('DROP ROLE %L', _usename);
    EXECUTE command;

    RETURN;

  EXCEPTION WHEN OTHERS THEN
      -- trap exception only to show it and rethrow it
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
      RAISE EXCEPTION USING
        ERRCODE = error.returned_sqlstate,
        MESSAGE = error.message_text,
        DETAIL = error.pg_exception_detail,
        HINT = error.pg_exception_hint;
  END;
RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION special.scuola247_delete_user(text)
  OWNER TO postgres;  
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO scuola247_executive;
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO scuola247_employee;
