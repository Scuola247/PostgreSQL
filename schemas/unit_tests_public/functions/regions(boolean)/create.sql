-- Function: unit_tests_public.regions(boolean)

-- DROP FUNCTION unit_tests_public.regions(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.regions(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	text;
  test_name		text = '';
  error			diagnostic.error;
BEGIN

  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;
  -----------------------------
  test_name = 'INSERT regions';
  -----------------------------
  BEGIN

    INSERT INTO public.regions(region,description,geographical_area) VALUES ('1000000000','Piemonte_test','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('2000000000','Valle d''Aosta/Vallée d''Aoste_test','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('3000000000','Lombardia_test','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('4000000000','Trentino-Alto Adige/Südtirol_test','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('5000000000','Veneto_test','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('6000000000','Friuli-Venezia Giulia_test','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('7000000000','Liguria_test','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('8000000000','Emilia-Romagna_test','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('9000000000','Toscana_test','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('10000000000','Umbria_test','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('11000000000','Marche_test','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('12000000000','Lazio_test','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('13000000000','Abruzzo_test','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('14000000000','Molise_test','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('15000000000','Campania_test','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('16000000000','Puglia_test','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('17000000000','Basilicata_test','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('18000000000','Calabria_test','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('19000000000','Sicilia_test','Islands');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('20000000000','Sardegna_test','Islands');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.regions FAILED'::text, error);
       RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.regions(boolean)
  OWNER TO postgres;
