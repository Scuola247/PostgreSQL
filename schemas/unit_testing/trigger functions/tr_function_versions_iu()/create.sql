-- Function: unit_testing.tr_function_versions_iu()

-- DROP FUNCTION unit_testing.tr_function_versions_iu();

CREATE OR REPLACE FUNCTION unit_testing.tr_function_versions_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context	text;
  function_name text;
  system_messages utility.system_message[] = ARRAY[
    ('en', 1, 'The schema and the before_function aren''t in the unit_test_functions')::utility.system_message,
    ('en', 2, 'The schema: %L and the before_function:L aren''t in the unit_test_functions')::utility.system_message,
    ('en', 3, 'Check the inserted data and try re-insert them')::utility.system_message,
    ('it', 1, 'Lo schema e la before_function non si trovano in unit_test_functions')::utility.system_message,
    ('it', 2, 'Lo schema: %L e la before_function: %L non si trovano in unit_test_functions')::utility.system_message,
    ('it', 3, 'Controllare i dati inseriti e provare a re-inserirli.')::utility.system_message];
BEGIN
-- imposto il nome della funzione
  get diagnostics me.context = pg_context;
  me.function_name = diagnostic.full_function_name(me.context);
--
-- check schema_name and before_function name are unit_test_functions
--
  PERFORM 1 FROM unit_testing.unit_tests_list utl
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
ALTER FUNCTION unit_testing.tr_function_versions_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_testing.tr_function_versions_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_testing.tr_function_versions_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION unit_testing.tr_function_versions_iu() FROM public;
