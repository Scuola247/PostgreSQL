-- Function: unit_testing.build_function_dependencies(text, text[])

-- DROP FUNCTION unit_testing.build_function_dependencies(text, text[]);

CREATE OR REPLACE FUNCTION unit_testing.build_function_dependencies(
    IN _before_full_function_name text,
    VARIADIC _run_full_function_names text[] DEFAULT NULL::text[])
  RETURNS void AS
$BODY$
<<me>>
DECLARE
  context				text;
  full_function_name			text;

  before_full_function_name_matrix	text[];
  run_full_function_name_matrix	text[];
  schema_name_index 			integer = 1;
  function_name_index 			integer = 2;

  before_schema_name			text;
  before_function_name			text;
  run_schema_name			text;
  run_function_name			text;

  run_full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  before_full_function_name_matrix = parse_ident(_before_full_function_name);
  before_schema_name               = before_full_function_name_matrix[schema_name_index];
  before_function_name             = before_full_function_name_matrix[function_name_index];
--
-- delete all the currente dependencies
-- 
  DELETE FROM unit_testing.dependencies d WHERE d.before_schema_name = me.before_schema_name
                                            AND d.before_function_name = me.before_function_name;
  IF _run_full_function_names IS NULL THEN
  ELSE
    FOREACH run_full_function_name IN ARRAY _run_full_function_names
    LOOP
      run_full_function_name_matrix = parse_ident(run_full_function_name);
      run_schema_name               = run_full_function_name_matrix[schema_name_index];
      run_function_name             = run_full_function_name_matrix[function_name_index];
  
      INSERT INTO unit_testing.dependencies (before_schema_name, before_function_name, run_schema_name, run_function_name)
           SELECT me.before_schema_name, me.before_function_name, run_schema_name, run_function_name;
    END LOOP;
  END IF;
  RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_testing.build_function_dependencies(text, text[])
  OWNER TO postgres;
COMMENT ON FUNCTION unit_testing.build_function_dependencies(text, text[]) IS 'test';
