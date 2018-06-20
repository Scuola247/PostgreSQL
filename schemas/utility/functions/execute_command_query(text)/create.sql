-- Function: utility.execute_command_query(text)

-- DROP FUNCTION utility.execute_command_query(text);

CREATE OR REPLACE FUNCTION utility.execute_command_query(_query text)
  RETURNS void AS
$BODY$
<<me>>
DECLARE 
  context 			text;
  full_function_name		text;
     
  command			text;
  error				diagnostic.error;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  BEGIN
    FOR me.command IN EXECUTE _query LOOP
      RAISE NOTICE 'EXECUTE IMMEDIATE: %', me.command;
      EXECUTE command;
    END LOOP;
  EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
  END;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION utility.execute_command_query(text)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION utility.execute_command_query(text) TO public;
GRANT EXECUTE ON FUNCTION utility.execute_command_query(text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION utility.execute_command_query(text) TO scuola247_user;
COMMENT ON FUNCTION utility.execute_command_query(text) IS 'Exec the command in the unique column retrieve from input query';
