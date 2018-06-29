-- Function: utility.set_all_sequences_2_the_max()

-- DROP FUNCTION utility.set_all_sequences_2_the_max();

CREATE OR REPLACE FUNCTION utility.set_all_sequences_2_the_max()
  RETURNS TABLE(sequence_namespace name, sequence_name name, sequence_value bigint) AS
$BODY$
DECLARE
BEGIN 
  RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
  FROM utility.sequence_references t
  GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION utility.set_all_sequences_2_the_max()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION utility.set_all_sequences_2_the_max() TO public;
GRANT EXECUTE ON FUNCTION utility.set_all_sequences_2_the_max() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION utility.set_all_sequences_2_the_max() TO scuola247_user;
COMMENT ON FUNCTION utility.set_all_sequences_2_the_max() IS '<utility>
sets all database sequences to the highest value found in the database';
