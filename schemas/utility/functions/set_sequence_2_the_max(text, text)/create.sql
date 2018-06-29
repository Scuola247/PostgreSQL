-- Function: utility.set_sequence_2_the_max(text, text)

-- DROP FUNCTION utility.set_sequence_2_the_max(text, text);

CREATE OR REPLACE FUNCTION utility.set_sequence_2_the_max(
    IN _sequence_schema_name text,
    IN _sequence_name text)
  RETURNS TABLE(sequence_schema_name name, sequence_name name, sequence_value bigint) AS
$BODY$

DECLARE
 
BEGIN 

  IF _sequence_schema_name = ''
  OR _sequence_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: set_sequence_2_the_max(sequence_namespace, sequence_name)';
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
               FROM utility.sequence_references t
              WHERE t.sequence_schema_name = _sequence_schema_name
                AND t.sequence_name = _sequence_name
           GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION utility.set_sequence_2_the_max(text, text)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION utility.set_sequence_2_the_max(text, text) TO public;
GRANT EXECUTE ON FUNCTION utility.set_sequence_2_the_max(text, text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION utility.set_sequence_2_the_max(text, text) TO scuola247_user;
COMMENT ON FUNCTION utility.set_sequence_2_the_max(text, text) IS '<utility>
sets the sequences in input to the highest value found in the database';
