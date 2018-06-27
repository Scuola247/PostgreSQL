-- Function: special.scuola247_create_user(text, special.scuola247_groups, utility.language, bigint[])

-- DROP FUNCTION special.scuola247_create_user(text, special.scuola247_groups, utility.language, bigint[]);

CREATE OR REPLACE FUNCTION special.scuola247_create_user(
    IN _usename text,
    IN _group special.scuola247_groups,
    IN _language utility.language,
    VARIADIC _schools bigint[],
    OUT _password text)
  RETURNS text AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;

  error			diagnostic.error;
  school		bigint;
  message_text		text;
  command		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  BEGIN

    _password = utility.generate_password();
    command = format('CREATE ROLE %I LOGIN PASSWORD %L IN ROLE %I', _usename, _password, _group);
    EXECUTE command;
  
    INSERT INTO public.usenames_ex(usename, language) VALUES (_usename, _language);
    
    FOREACH school IN ARRAY _schools LOOP
      IF school IS NULL THEN
      ELSE
	INSERT INTO usenames_schools(usename, school) VALUES (_usename, school);
      END IF;
    END LOOP;
    
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
ALTER FUNCTION special.scuola247_create_user(text, special.scuola247_groups, utility.language, bigint[])
  OWNER TO postgres;
