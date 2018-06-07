-- Function: unit_tests_public.subjects(boolean)

-- DROP FUNCTION unit_tests_public.subjects(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.subjects(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.schools');
    RETURN;
  END IF;  
  ------------------------------
  test_name = 'INSERT subjects';
  ------------------------------
  BEGIN
    INSERT INTO public.subjects(subject,school,description) VALUES ('29105000000000','28961000000000','Italiano');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29106000000000','28961000000000','Storia');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29107000000000','28961000000000','Geografia');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29108000000000','28961000000000','I lingua str. Inglese');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29109000000000','28961000000000','II lingua str. Tedesco');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29110000000000','28961000000000','II lingua str. Spagnolo');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29111000000000','28961000000000','Matematica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29112000000000','28961000000000','Scienze');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29113000000000','28961000000000','Tecnologia');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29114000000000','28961000000000','Arte e Immagine');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29115000000000','28961000000000','Musica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29116000000000','28961000000000','Educazione Fisica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29117000000000','28961000000000','Religione');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29118000000000','28961000000000','Sostegno');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32911000000000','1000000000','Italiano');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32912000000000','1000000000','Storia');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32913000000000','1000000000','Geografia');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32914000000000','1000000000','I lingua str. Inglese');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32915000000000','1000000000','II lingua str. Tedesco');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32916000000000','1000000000','II lingua str. Spagnolo');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32917000000000','1000000000','Matematica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32918000000000','1000000000','Scienze');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32919000000000','1000000000','Tecnologia');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32920000000000','1000000000','Arte e Immagine');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32921000000000','1000000000','Musica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32922000000000','1000000000','Educazione Fisica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32923000000000','1000000000','Religione');
    INSERT INTO public.subjects(subject,school,description) VALUES ('32924000000000','1000000000','Sostegno');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96332000000000','28961000000000','Approfondimento Letterario');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96333000000000','28961000000000','Arte');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96334000000000','28961000000000','Fisica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96335000000000','28961000000000','Inglese');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96336000000000','28961000000000','Lettere');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96337000000000','28961000000000','Spagnolo');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96338000000000','28961000000000','Tedesco');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96339000000000','28961000000000','Tecnica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96340000000000','28961000000000','Alternativa Religione');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96998000000000','28961000000000','IRC');
    INSERT INTO public.subjects(subject,school,description) VALUES ('96999000000000','28961000000000','Palestra');
    INSERT INTO public.subjects(subject,school,description) VALUES ('97000000000000','28961000000000','Pranzo');
    INSERT INTO public.subjects(subject,school,description) VALUES ('97001000000000','28961000000000','Ricreazione');
    INSERT INTO public.subjects(subject,school,description) VALUES ('166129000000000','1000000000','Condotta');
    INSERT INTO public.subjects(subject,school,description) VALUES ('166130000000000','28961000000000','Condotta');
    INSERT INTO public.subjects(subject,school,description) VALUES ('166674000000000','28961000000000','Area Storico-Geografica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('166675000000000','28961000000000','Area Linguistica-Espressiva');
    INSERT INTO public.subjects(subject,school,description) VALUES ('166676000000000','28961000000000','Area Matematica-Scientifica');


    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.subjects FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.subjects(boolean)
  OWNER TO postgres;
