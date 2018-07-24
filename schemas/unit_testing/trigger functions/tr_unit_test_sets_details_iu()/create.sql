-- Function: unit_testing.tr_unit_test_sets_details_iu()

-- DROP FUNCTION unit_testing.tr_unit_test_sets_details_iu();

CREATE OR REPLACE FUNCTION unit_testing.tr_unit_test_sets_details_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context	text;
  function_name text;
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'The dependent_schema and the dependent_function aren''t in ''unit_test_functions''.')::utility.system_message,
    ('en', 2, 'The schema: %L and the function: %L aren''t in the ''unit_test_functions''.')::utility.system_message,
    ('en', 3, 'Check the data inserted and try to insert them.')::utility.system_message,
    ('it', 1, 'Il dependent_schema e il dependent_function non si trovano in '' unit_test_functions''.')::utility.system_message,
    ('it', 2, 'Lo schema: %L e la funzione: %L non sono in ''unit_test_functions''.')::utility.system_message,
    ('it', 3, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message];
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.function_name = diagnostic.full_function_name(me.context);
--
-- check dependent_schema_name and dependent_function name are unit_test_functions
--
  PERFORM 1 
  FROM unit_testing.unit_tests_list utl
    WHERE utl.schema_name = new.schema_name
      AND utl.function_name  = new.function_name;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), new.schema_name, new.function_name),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_testing.tr_unit_test_sets_details_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_testing.tr_unit_test_sets_details_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_testing.tr_unit_test_sets_details_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION unit_testing.tr_unit_test_sets_details_iu() FROM public;
