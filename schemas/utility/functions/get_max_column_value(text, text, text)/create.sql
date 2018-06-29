-- Function: utility.get_max_column_value(text, text, text)

-- DROP FUNCTION utility.get_max_column_value(text, text, text);

CREATE OR REPLACE FUNCTION utility.get_max_column_value(
    IN schema_name text,
    IN table_name text,
    IN column_name text,
    OUT max_value bigint)
  RETURNS bigint AS
$BODY$

DECLARE

BEGIN 

  IF schema_name = ''
  OR table_name = ''
  OR column_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: get_max_column_value(''schema'', ''table'', ''column'')'; 
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
 EXECUTE 'SELECT MAX(' || quote_ident(column_name) || ') FROM ' || quote_ident(schema_name) || '.' || quote_ident(table_name) INTO STRICT max_value;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION utility.get_max_column_value(text, text, text)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION utility.get_max_column_value(text, text, text) TO public;
GRANT EXECUTE ON FUNCTION utility.get_max_column_value(text, text, text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION utility.get_max_column_value(text, text, text) TO scuola247_user;
COMMENT ON FUNCTION utility.get_max_column_value(text, text, text) IS '<utility>
given the name of the schema, table, and column, it returns the maximum value of the column';
