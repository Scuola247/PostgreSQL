-- Function: unit_tests_public.grade_types(boolean)

-- DROP FUNCTION unit_tests_public.grade_types(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.grade_types(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.subjects');
    RETURN;
  END IF;  
  ---------------------------------
  test_name = 'INSERT grade_types';
  ---------------------------------
  BEGIN
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46299000000000','Scritto','29107000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46300000000000','Scritto','29108000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46301000000000','Scritto','29110000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46302000000000','Scritto','29105000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46303000000000','Scritto','29111000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46304000000000','Laboratorio','29115000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46305000000000','Scritto','29117000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46306000000000','Laboratorio','29112000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46307000000000','Disegno','29106000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46308000000000','Laboratorio','29113000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46309000000000','Laboratorio','29114000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46312000000000','Orale ','29110000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46321000000000','Disegno','29107000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46322000000000','Disegno','29111000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46324000000000','Scritto','29112000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46327000000000','Scritto','29106000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98534000000000','Orale','32913000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98535000000000','Orale','32914000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98536000000000','Orale','32915000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98537000000000','Orale','32916000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98538000000000','Orale','32917000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98539000000000','Orale','32918000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98540000000000','Orale','32919000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98541000000000','Orale','32920000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98542000000000','Orale','32921000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98543000000000','Orale','32923000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98544000000000','Orale','32924000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98546000000000','Scritto','32912000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98547000000000','Scritto','32913000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98548000000000','Scritto','32914000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98549000000000','Scritto','32915000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46297000000000','Disegno','29114000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98550000000000','Scritto','32916000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98551000000000','Scritto','32917000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98552000000000','Scritto','32918000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98553000000000','Scritto','32919000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98554000000000','Scritto','32920000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98555000000000','Scritto','32921000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98556000000000','Scritto','32922000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98557000000000','Scritto','32923000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98558000000000','Laboratorio','32914000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98559000000000','Laboratorio','32915000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98560000000000','Laboratorio','32916000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98561000000000','Laboratorio','32918000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98562000000000','Laboratorio','32919000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98563000000000','Laboratorio','32921000000000','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98564000000000','Pratica','32919000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98565000000000','Pratica','32921000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98566000000000','Disegno','32918000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98567000000000','Disegno','32919000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166677000000000','Disegno','29105000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46313000000000','Orale','29105000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46318000000000','Orale','29106000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46310000000000','Orale','29107000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46311000000000','Orale','29108000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46314000000000','Orale','29111000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166680000000000','Disegno','29112000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46317000000000','Orale','29112000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46319000000000','Orale','29113000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46315000000000','Orale','29115000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46316000000000','Orale','29117000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166681000000000','Disegno','29113000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98545000000000','Scritto','32911000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98532000000000','Orale','32911000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('98533000000000','Orale','32912000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166682000000000','Scritto','29113000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166684000000000','Orale','166674000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166685000000000','Orale','166675000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166686000000000','Scritto','166675000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166687000000000','Orale','166676000000000','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166688000000000','Scritto','166676000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166689000000000','Disegno','29115000000000','D');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166690000000000','Scritto','29115000000000','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46298000000000','Pratica','29116000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46320000000000','Pratica','29114000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46323000000000','Pratica','29115000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46325000000000','Pratica','29106000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46326000000000','Pratica','29113000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('72745000000000','Pratica','29107000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166678000000000','Pratica','29105000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166679000000000','Pratica','29111000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166683000000000','Pratica','166675000000000','P');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('166691000000000','Pratica','166674000000000','P');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.grade_types FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.grade_types(boolean)
  OWNER TO postgres;
