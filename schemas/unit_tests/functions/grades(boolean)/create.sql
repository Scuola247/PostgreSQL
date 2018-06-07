-- Function: unit_tests_public.grades(boolean)

-- DROP FUNCTION unit_tests_public.grades(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.grades(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.metrics');
    RETURN;
  END IF;  
  ----------------------------
  test_name = 'INSERT grades';
  ----------------------------
  BEGIN
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29066000000000','29062000000000','0/1','50','0Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29070000000000','29062000000000','1/2','150','1Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29074000000000','29062000000000','2/3','250','2Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29064000000000','29062000000000','0','0','0');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29084000000000','29062000000000','5','500','5');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29078000000000','29062000000000','3/4','350','3Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29082000000000','29062000000000','4/5','450','4Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29086000000000','29062000000000','5/6','550','5Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29090000000000','29062000000000','6/7','650','6Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29094000000000','29062000000000','7/8','750','7Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29088000000000','29062000000000','6','600','6');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29092000000000','29062000000000','7','700','7');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29096000000000','29062000000000','8','800','8');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11472000000000','11434000000000','Non classificabile','0','N/C');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11439000000000','11433000000000','2','200','2');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11442000000000','11433000000000','3-','275','3-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11443000000000','11433000000000','3','300','3');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11444000000000','11433000000000','3+','325','3+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11445000000000','11433000000000','3Â½','350','3Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11446000000000','11433000000000','4-','375','4-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11447000000000','11433000000000','4','400','4');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11448000000000','11433000000000','4+','425','4+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11449000000000','11433000000000','4Â½','450','4Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11450000000000','11433000000000','5-','475','5-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11451000000000','11433000000000','5','500','5');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11452000000000','11433000000000','5+','525','5+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11453000000000','11433000000000','5Â½','550','5Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11454000000000','11433000000000','6-','575','6-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11455000000000','11433000000000','6','600','6');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11456000000000','11433000000000','6+','625','6+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11457000000000','11433000000000','6Â½','650','6Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11458000000000','11433000000000','7-','675','7-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11459000000000','11433000000000','7','700','7');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11460000000000','11433000000000','7+','725','7+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11461000000000','11433000000000','7Â½','750','7Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11462000000000','11433000000000','8-','775','8-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11463000000000','11433000000000','8','800','8');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11464000000000','11433000000000','8+','825','8+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11465000000000','11433000000000','8Â½','850','8Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11466000000000','11433000000000','9-','875','9-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11467000000000','11433000000000','9','900','9');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11468000000000','11433000000000','9+','925','9+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11469000000000','11433000000000','9Â½','950','9Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11470000000000','11433000000000','10-','975','10-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11471000000000','11433000000000','10','1000','10');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11480000000000','11436000000000','2','200','2');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11481000000000','11436000000000','2+','225','2+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11482000000000','11436000000000','2Â½','250','2Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11483000000000','11436000000000','3-','275','3-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11484000000000','11436000000000','3','300','3');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11485000000000','11436000000000','3+','325','3+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11486000000000','11436000000000','3Â½','350','3Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11487000000000','11436000000000','4-','375','4-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11488000000000','11436000000000','4','400','4');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11489000000000','11436000000000','4+','425','4+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11490000000000','11436000000000','4Â½','450','4Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11491000000000','11436000000000','5-','475','5-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11492000000000','11436000000000','5','500','5');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11493000000000','11436000000000','5+','525','5+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11494000000000','11436000000000','5Â½','550','5Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11495000000000','11436000000000','6-','575','6-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11496000000000','11436000000000','6','600','6');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11497000000000','11436000000000','6+','625','6+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11498000000000','11436000000000','6Â½','650','6Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11499000000000','11436000000000','7-','675','7-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11500000000000','11436000000000','7','700','7');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11501000000000','11436000000000','7+','725','7+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11502000000000','11436000000000','7Â½','750','7Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11503000000000','11436000000000','8-','775','8-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11504000000000','11436000000000','8','800','8');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11505000000000','11436000000000','8+','825','8+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11506000000000','11436000000000','8Â½','850','8Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11507000000000','11436000000000','9-','875','9-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11508000000000','11436000000000','9','900','9');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11509000000000','11436000000000','9+','925','9+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11510000000000','11436000000000','9Â½','950','9Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11511000000000','11436000000000','10-','975','10-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11512000000000','11436000000000','10','1000','10');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29065000000000','29062000000000','0+','25','0+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29067000000000','29062000000000','1-','75','1-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29068000000000','29062000000000','1','100','1');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29069000000000','29062000000000','1+','125','1+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29071000000000','29062000000000','2-','175','2-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29072000000000','29062000000000','2','200','2');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29073000000000','29062000000000','2+','225','2+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29075000000000','29062000000000','3-','275','3-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29076000000000','29062000000000','3','300','3');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29077000000000','29062000000000','3+','325','3+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29079000000000','29062000000000','4-','375','4-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29080000000000','29062000000000','4','400','4');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29081000000000','29062000000000','4+','425','4+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29083000000000','29062000000000','5-','475','5-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29085000000000','29062000000000','5+','525','5+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29087000000000','29062000000000','6-','575','6-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29089000000000','29062000000000','6+','625','6+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29091000000000','29062000000000','7-','675','7-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29093000000000','29062000000000','7+','725','7+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29095000000000','29062000000000','8-','775','8-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11440000000000','11433000000000','2+','225','2+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11441000000000','11433000000000','2Â½','250','2Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30420000000000','29063000000000','Ottimo','1000','Ott');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30417000000000','29063000000000','Sufficente','600','Suf');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29103000000000','29062000000000','10-','975','10-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30416000000000','29063000000000','Insufficente','500','Ins');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30418000000000','29063000000000','Buono','750','Buo');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30419000000000','29063000000000','Distinto','900','Dis');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30421000000000','30414000000000','Livello raggiunto','0','Si');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30415000000000','29063000000000','Non classificabile','0','N/C');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29104000000000','29062000000000','10','1000','10');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('30422000000000','30414000000000','Livello non raggiunto','1000','No');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11478000000000','11435000000000','Positivo','1000','Si');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29097000000000','29062000000000','8+','825','8+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29099000000000','29062000000000','9-','875','9-');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29101000000000','29062000000000','9+','925','9+');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11477000000000','11434000000000','Ottimo','1000','Ott');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11473000000000','11434000000000','Insufficente','500','Ins');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11515000000000','11437000000000','Sufficente','600','Suf');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11516000000000','11437000000000','Buono','750','Buo');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11518000000000','11437000000000','Ottimo','1000','Ott');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11474000000000','11434000000000','Sufficente','600','Suf');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11475000000000','11434000000000','Buono','750','Buo');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11476000000000','11434000000000','Distinto','900','Dis');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11513000000000','11437000000000','Non classificabile','0','N/C');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11514000000000','11437000000000','Insufficente','500','Ins');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11517000000000','11437000000000','Distinto','900','Dis');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29100000000000','29062000000000','9','900','9');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11479000000000','11435000000000','Negativo','0','No');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11519000000000','11438000000000','Positivo','1000','Si');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('11520000000000','11438000000000','Negativo','0','No');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29098000000000','29062000000000','8/9','850','8Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29102000000000','29062000000000','9/10','950','9Â½');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.grades FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.grades(boolean)
  OWNER TO postgres;
