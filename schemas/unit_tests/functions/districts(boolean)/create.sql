-- Function: unit_tests_public.districts(boolean)

-- DROP FUNCTION unit_tests_public.districts(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.districts(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.full_function_name(context),'unit_tests_public.regions');
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
    
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TO','Torino_test','1000000000','758321000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VC','Vercelli_test','1000000000','758322000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('NO','Novara_test','1000000000','758323000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CN','Cuneo_test','1000000000','758324000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AT','Asti_test','1000000000','758325000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AL','Alessandria_test','1000000000','758326000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BI','Biella_test','1000000000','758327000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VB','Verbano-Cusio-Ossola_test','1000000000','758328000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AO','Valle d''Aosta/Vallée d''Aoste_test','2000000000','758329000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VA','Varese_test','3000000000','758330000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CO','Como_test','3000000000','758331000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SO','Sondrio_test','3000000000','758332000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MI','Milano_test','3000000000','758333000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BG','Bergamo_test','3000000000','758334000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BS','Brescia_test','3000000000','758335000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PV','Pavia_test','3000000000','758336000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CR','Cremona_test','3000000000','758337000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MN','Mantova_test','3000000000','758338000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('LC','Lecco_test','3000000000','758339000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('LO','Lodi_test','3000000000','758340000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MB','Monza e della Brianza_test','3000000000','758341000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BZ','Bolzano/Bozen_test','4000000000','758342000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TN','Trento_test','4000000000','758343000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VR','Verona_test','5000000000','758344000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VI','Vicenza_test','5000000000','758345000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BL','Belluno_test','5000000000','758346000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TV','Treviso_test','5000000000','758347000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VE','Venezia_test','5000000000','758348000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PD','Padova_test','5000000000','758349000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RO','Rovigo_test','5000000000','758350000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('UD','Udine_test','6000000000','758351000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('GO','Gorizia_test','6000000000','758352000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TS','Trieste_test','6000000000','758353000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PN','Pordenone_test','6000000000','758354000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('IM','Imperia_test','7000000000','758355000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SV','Savona_test','7000000000','758356000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('GE','Genova_test','7000000000','758357000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SP','La Spezia_test','7000000000','758358000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PC','Piacenza_test','8000000000','758359000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PR','Parma_test','8000000000','758360000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RE','Reggio nell''Emilia_test','8000000000','758361000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MO','Modena_test','8000000000','758362000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BO','Bologna_test','8000000000','758363000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('FE','Ferrara_test','8000000000','758364000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RA','Ravenna_test','8000000000','758365000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('FC','Forlì-Cesena_test','8000000000','758366000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RN','Rimini_test','8000000000','758367000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MS','Massa-Carrara_test','9000000000','758368000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('LU','Lucca_test','9000000000','758369000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PT','Pistoia_test','9000000000','758370000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('FI','Firenze_test','9000000000','758371000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('LI','Livorno_test','9000000000','758372000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PI','Pisa_test','9000000000','758373000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AR','Arezzo_test','9000000000','758374000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SI','Siena_test','9000000000','758375000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('GR','Grosseto_test','9000000000','758376000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PO','Prato_test','9000000000','758377000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PG','Perugia_test','10000000000','758378000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TR','Terni_test','10000000000','758379000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PU','Pesaro e Urbino_test','11000000000','758380000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AN','Ancona_test','11000000000','758381000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MC','Macerata_test','11000000000','758382000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AP','Ascoli Piceno_test','11000000000','758383000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('FM','Fermo_test','11000000000','758384000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VT','Viterbo_test','12000000000','758385000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RI','Rieti_test','12000000000','758386000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RM','Roma_test','12000000000','758387000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('LT','Latina_test','12000000000','758388000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('FR','Frosinone_test','12000000000','758389000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AQ','L''Aquila_test','13000000000','758390000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TE','Teramo_test','13000000000','758391000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PE','Pescara_test','13000000000','758392000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CH','Chieti_test','13000000000','758393000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CB','Campobasso_test','14000000000','758394000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('IS','Isernia_test','14000000000','758395000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CE','Caserta_test','15000000000','758396000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BN','Benevento_test','15000000000','758397000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('NA','Napoli_test','15000000000','758398000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AV','Avellino_test','15000000000','758399000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SA','Salerno_test','15000000000','758400000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('FG','Foggia_test','16000000000','758401000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BA','Bari_test','16000000000','758402000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TA','Taranto_test','16000000000','758403000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BR','Brindisi_test','16000000000','758404000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('LE','Lecce_test','16000000000','758405000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('BT','Barletta-Andria-Trani_test','16000000000','758406000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PZ','Potenza_test','17000000000','758407000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('MT','Matera_test','17000000000','758408000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CS','Cosenza_test','18000000000','758409000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CZ','Catanzaro_test','18000000000','758410000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RC','Reggio di Calabria_test','18000000000','758411000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('KR','Crotone_test','18000000000','758412000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VV','Vibo Valentia_test','18000000000','758413000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('TP','Trapani_test','19000000000','758414000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('PA','Palermo_test','19000000000','758415000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('ME','Messina_test','19000000000','758416000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('AG','Agrigento_test','19000000000','758417000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CL','Caltanissetta_test','19000000000','758418000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('EN','Enna_test','19000000000','758419000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CT','Catania_test','19000000000','758420000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('RG','Ragusa_test','19000000000','758421000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SR','Siracusa_test','19000000000','758422000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('SS','Sassari_test','20000000000','758423000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('NU','Nuoro_test','20000000000','758424000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CA','Cagliari_test','20000000000','758425000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('OR','Oristano_test','20000000000','758426000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('OT','Olbia-Tempio_test','20000000000','758427000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('OG','Ogliastra_test','20000000000','758428000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('VS','Medio Campidano_test','20000000000','758429000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('CI','Carbonia-Iglesias_test','20000000000','758430000000000');
INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('EE','Provincia ***ERRATA***_test','1000000000','758431000000000');

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
ALTER FUNCTION unit_tests_public.districts(boolean)
  OWNER TO postgres;
