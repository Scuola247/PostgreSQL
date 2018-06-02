-- Function: unit_tests.regions(boolean)

-- DROP FUNCTION unit_tests.regions(boolean);

CREATE OR REPLACE FUNCTION unit_tests.regions(
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
    /*
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('2','Valle d''Aosta/Vallée d''Aoste','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('3','Lombardia','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('4','Trentino-Alto Adige/Südtirol','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('5','Veneto','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('6','Friuli-Venezia Giulia','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('7','Liguria','North-west');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('8','Emilia-Romagna','North-east');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('9','Toscana','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('10','Umbria','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('11','Marche','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('12','Lazio','Center');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('13','Abruzzo','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('14','Molise','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('15','Campania','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('16','Puglia','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('17','Basilicata','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('18','Calabria','South');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('19','Sicilia','Islands');
    INSERT INTO public.regions(region,description,geographical_area) VALUES ('20','Sardegna','Islands');
    */

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
ALTER FUNCTION unit_tests.regions(boolean)
  OWNER TO postgres;
