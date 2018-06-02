-- Function: unit_tests.districts(boolean)

-- DROP FUNCTION unit_tests.districts(boolean);

CREATE OR REPLACE FUNCTION unit_tests.districts(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'regions');
    RETURN;
  END IF;  
  -------------------------------
  test_name = 'INSERT districts';
  -------------------------------
  BEGIN
    /*
    INSERT INTO public.districts(district,description,region) VALUES ('TO','Torino','1');
    INSERT INTO public.districts(district,description,region) VALUES ('VC','Vercelli','1');
    INSERT INTO public.districts(district,description,region) VALUES ('NO','Novara','1');
    INSERT INTO public.districts(district,description,region) VALUES ('CN','Cuneo','1');
    INSERT INTO public.districts(district,description,region) VALUES ('AT','Asti','1');
    INSERT INTO public.districts(district,description,region) VALUES ('AL','Alessandria','1');
    INSERT INTO public.districts(district,description,region) VALUES ('BI','Biella','1');
    INSERT INTO public.districts(district,description,region) VALUES ('VB','Verbano-Cusio-Ossola','1');
    INSERT INTO public.districts(district,description,region) VALUES ('AO','Valle d''Aosta/VallÃ©e d''Aoste','2');
    INSERT INTO public.districts(district,description,region) VALUES ('VA','Varese','3');
    INSERT INTO public.districts(district,description,region) VALUES ('CO','Como','3');
    INSERT INTO public.districts(district,description,region) VALUES ('SO','Sondrio','3');
    INSERT INTO public.districts(district,description,region) VALUES ('MI','Milano','3');
    INSERT INTO public.districts(district,description,region) VALUES ('BG','Bergamo','3');
    INSERT INTO public.districts(district,description,region) VALUES ('BS','Brescia','3');
    INSERT INTO public.districts(district,description,region) VALUES ('PV','Pavia','3');
    INSERT INTO public.districts(district,description,region) VALUES ('CR','Cremona','3');
    INSERT INTO public.districts(district,description,region) VALUES ('MN','Mantova','3');
    INSERT INTO public.districts(district,description,region) VALUES ('LC','Lecco','3');
    INSERT INTO public.districts(district,description,region) VALUES ('LO','Lodi','3');
    INSERT INTO public.districts(district,description,region) VALUES ('MB','Monza e della Brianza','3');
    INSERT INTO public.districts(district,description,region) VALUES ('BZ','Bolzano/Bozen','4');
    INSERT INTO public.districts(district,description,region) VALUES ('TN','Trento','4');
    INSERT INTO public.districts(district,description,region) VALUES ('VR','Verona','5');
    INSERT INTO public.districts(district,description,region) VALUES ('VI','Vicenza','5');
    INSERT INTO public.districts(district,description,region) VALUES ('BL','Belluno','5');
    INSERT INTO public.districts(district,description,region) VALUES ('TV','Treviso','5');
    INSERT INTO public.districts(district,description,region) VALUES ('VE','Venezia','5');
    INSERT INTO public.districts(district,description,region) VALUES ('PD','Padova','5');
    INSERT INTO public.districts(district,description,region) VALUES ('RO','Rovigo','5');
    INSERT INTO public.districts(district,description,region) VALUES ('UD','Udine','6');
    INSERT INTO public.districts(district,description,region) VALUES ('GO','Gorizia','6');
    INSERT INTO public.districts(district,description,region) VALUES ('TS','Trieste','6');
    INSERT INTO public.districts(district,description,region) VALUES ('PN','Pordenone','6');
    INSERT INTO public.districts(district,description,region) VALUES ('IM','Imperia','7');
    INSERT INTO public.districts(district,description,region) VALUES ('SV','Savona','7');
    INSERT INTO public.districts(district,description,region) VALUES ('GE','Genova','7');
    INSERT INTO public.districts(district,description,region) VALUES ('SP','La Spezia','7');
    INSERT INTO public.districts(district,description,region) VALUES ('PC','Piacenza','8');
    INSERT INTO public.districts(district,description,region) VALUES ('PR','Parma','8');
    INSERT INTO public.districts(district,description,region) VALUES ('RE','Reggio nell''Emilia','8');
    INSERT INTO public.districts(district,description,region) VALUES ('MO','Modena','8');
    INSERT INTO public.districts(district,description,region) VALUES ('BO','Bologna','8');
    INSERT INTO public.districts(district,description,region) VALUES ('FE','Ferrara','8');
    INSERT INTO public.districts(district,description,region) VALUES ('RA','Ravenna','8');
    INSERT INTO public.districts(district,description,region) VALUES ('FC','ForlÃ¬-Cesena','8');
    INSERT INTO public.districts(district,description,region) VALUES ('RN','Rimini','8');
    INSERT INTO public.districts(district,description,region) VALUES ('MS','Massa-Carrara','9');
    INSERT INTO public.districts(district,description,region) VALUES ('LU','Lucca','9');
    INSERT INTO public.districts(district,description,region) VALUES ('PT','Pistoia','9');
    INSERT INTO public.districts(district,description,region) VALUES ('FI','Firenze','9');
    INSERT INTO public.districts(district,description,region) VALUES ('LI','Livorno','9');
    INSERT INTO public.districts(district,description,region) VALUES ('PI','Pisa','9');
    INSERT INTO public.districts(district,description,region) VALUES ('AR','Arezzo','9');
    INSERT INTO public.districts(district,description,region) VALUES ('SI','Siena','9');
    INSERT INTO public.districts(district,description,region) VALUES ('GR','Grosseto','9');
    INSERT INTO public.districts(district,description,region) VALUES ('PO','Prato','9');
    INSERT INTO public.districts(district,description,region) VALUES ('PG','Perugia','10');
    INSERT INTO public.districts(district,description,region) VALUES ('TR','Terni','10');
    INSERT INTO public.districts(district,description,region) VALUES ('PU','Pesaro e Urbino','11');
    INSERT INTO public.districts(district,description,region) VALUES ('AN','Ancona','11');
    INSERT INTO public.districts(district,description,region) VALUES ('MC','Macerata','11');
    INSERT INTO public.districts(district,description,region) VALUES ('AP','Ascoli Piceno','11');
    INSERT INTO public.districts(district,description,region) VALUES ('FM','Fermo','11');
    INSERT INTO public.districts(district,description,region) VALUES ('VT','Viterbo','12');
    INSERT INTO public.districts(district,description,region) VALUES ('RI','Rieti','12');
    INSERT INTO public.districts(district,description,region) VALUES ('RM','Roma','12');
    INSERT INTO public.districts(district,description,region) VALUES ('LT','Latina','12');
    INSERT INTO public.districts(district,description,region) VALUES ('FR','Frosinone','12');
    INSERT INTO public.districts(district,description,region) VALUES ('AQ','L''Aquila','13');
    INSERT INTO public.districts(district,description,region) VALUES ('TE','Teramo','13');
    INSERT INTO public.districts(district,description,region) VALUES ('PE','Pescara','13');
    INSERT INTO public.districts(district,description,region) VALUES ('CH','Chieti','13');
    INSERT INTO public.districts(district,description,region) VALUES ('CB','Campobasso','14');
    INSERT INTO public.districts(district,description,region) VALUES ('IS','Isernia','14');
    INSERT INTO public.districts(district,description,region) VALUES ('CE','Caserta','15');
    INSERT INTO public.districts(district,description,region) VALUES ('BN','Benevento','15');
    INSERT INTO public.districts(district,description,region) VALUES ('NA','Napoli','15');
    INSERT INTO public.districts(district,description,region) VALUES ('AV','Avellino','15');
    INSERT INTO public.districts(district,description,region) VALUES ('SA','Salerno','15');
    INSERT INTO public.districts(district,description,region) VALUES ('FG','Foggia','16');
    INSERT INTO public.districts(district,description,region) VALUES ('BA','Bari','16');
    INSERT INTO public.districts(district,description,region) VALUES ('TA','Taranto','16');
    INSERT INTO public.districts(district,description,region) VALUES ('BR','Brindisi','16');
    INSERT INTO public.districts(district,description,region) VALUES ('LE','Lecce','16');
    INSERT INTO public.districts(district,description,region) VALUES ('BT','Barletta-Andria-Trani','16');
    INSERT INTO public.districts(district,description,region) VALUES ('PZ','Potenza','17');
    INSERT INTO public.districts(district,description,region) VALUES ('MT','Matera','17');
    INSERT INTO public.districts(district,description,region) VALUES ('CS','Cosenza','18');
    INSERT INTO public.districts(district,description,region) VALUES ('CZ','Catanzaro','18');
    INSERT INTO public.districts(district,description,region) VALUES ('RC','Reggio di Calabria','18');
    INSERT INTO public.districts(district,description,region) VALUES ('KR','Crotone','18');
    INSERT INTO public.districts(district,description,region) VALUES ('VV','Vibo Valentia','18');
    INSERT INTO public.districts(district,description,region) VALUES ('TP','Trapani','19');
    INSERT INTO public.districts(district,description,region) VALUES ('PA','Palermo','19');
    INSERT INTO public.districts(district,description,region) VALUES ('ME','Messina','19');
    INSERT INTO public.districts(district,description,region) VALUES ('AG','Agrigento','19');
    INSERT INTO public.districts(district,description,region) VALUES ('CL','Caltanissetta','19');
    INSERT INTO public.districts(district,description,region) VALUES ('EN','Enna','19');
    INSERT INTO public.districts(district,description,region) VALUES ('CT','Catania','19');
    INSERT INTO public.districts(district,description,region) VALUES ('RG','Ragusa','19');
    INSERT INTO public.districts(district,description,region) VALUES ('SR','Siracusa','19');
    INSERT INTO public.districts(district,description,region) VALUES ('SS','Sassari','20');
    INSERT INTO public.districts(district,description,region) VALUES ('NU','Nuoro','20');
    INSERT INTO public.districts(district,description,region) VALUES ('CA','Cagliari','20');
    INSERT INTO public.districts(district,description,region) VALUES ('OR','Oristano','20');
    INSERT INTO public.districts(district,description,region) VALUES ('OT','Olbia-Tempio','20');
    INSERT INTO public.districts(district,description,region) VALUES ('OG','Ogliastra','20');
    INSERT INTO public.districts(district,description,region) VALUES ('VS','Medio Campidano','20');
    INSERT INTO public.districts(district,description,region) VALUES ('CI','Carbonia-Iglesias','20');
    INSERT INTO public.districts(district,description,region) VALUES ('EE','Provincia ***ERRATA***','1');
    */
    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.districts FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.districts(boolean)
  OWNER TO postgres;
