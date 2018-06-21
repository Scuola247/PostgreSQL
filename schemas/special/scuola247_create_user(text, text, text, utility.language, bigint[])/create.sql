-- Function: special.scuola247_create_user(text, text, text, utility.language, bigint[])

-- DROP FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[]);

CREATE OR REPLACE FUNCTION special.scuola247_create_user(
    IN _usename text,
    IN _password text,
    IN _group text,
    IN _language utility.language,
    VARIADIC _schools bigint[])
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
    command = format('CREATE ROLE %L LOGIN PASSWORD %L IN ROLE %L', _usename, _password, _group);
    EXECUTE command;
  
    INSERT INTO public.usename_ex(usename, language) VALUES (_usename, _language);

    FOREACH school IN ARRAY _schools LOOP
      INSERT INTO usenames_schools(usename, school) VALUES (_usename, school);
    END LOOP;
    
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
ALTER FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[])
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[]) TO public;
GRANT EXECUTE ON FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[]) TO postgres;
GRANT EXECUTE ON FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[]) TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[]) TO scuola247_executive;
GRANT EXECUTE ON FUNCTION special.scuola247_create_user(text, text, text, utility.language, bigint[]) TO scuola247_employee;
