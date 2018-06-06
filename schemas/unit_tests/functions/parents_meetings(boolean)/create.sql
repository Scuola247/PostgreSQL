-- Function: unit_tests_public.parents_meetings(boolean)

-- DROP FUNCTION unit_tests_public.parents_meetings(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.parents_meetings(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.full_function_name(context),'unit_tests_public.persons');
    RETURN;
  END IF;  
  --------------------------------------
  test_name = 'INSERT parents_meetings';
  --------------------------------------
  BEGIN
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33433000000000','32925000000000','6603000000000','2013-10-01 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33434000000000','32926000000000','6589000000000','2013-10-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33435000000000','32927000000000','6575000000000','2013-10-05 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33436000000000','32928000000000','6561000000000','2013-10-07 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33437000000000','32929000000000','6547000000000','2013-10-09 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33438000000000','32930000000000','6533000000000','2013-10-11 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33439000000000','32931000000000','6519000000000','2013-10-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33440000000000','32932000000000','6505000000000','2013-10-15 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33441000000000','32933000000000','1311000000000','2013-10-17 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33442000000000','32934000000000','1297000000000','2013-10-19 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33443000000000','32935000000000','1283000000000','2013-10-21 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33444000000000','32936000000000','1269000000000','2013-10-23 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33445000000000','32937000000000','1255000000000','2013-10-25 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33446000000000','32938000000000','1241000000000','2013-10-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33447000000000','32925000000000','1227000000000','2013-10-29 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33448000000000','32926000000000','1213000000000','2013-10-31 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33449000000000','32927000000000','1199000000000','2013-11-02 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33450000000000','32928000000000','1185000000000','2013-11-04 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33451000000000','32929000000000','1171000000000','2013-11-06 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33452000000000','32930000000000','1157000000000','2013-11-08 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33453000000000','32931000000000','1143000000000','2013-11-11 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33454000000000','32932000000000','6617000000000','2013-11-12 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33455000000000','32933000000000','1465000000000','2013-11-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33456000000000','32934000000000','1451000000000','2013-11-16 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33457000000000','32935000000000','1437000000000','2013-11-18 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33458000000000','32936000000000','1423000000000','2013-11-20 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33459000000000','32937000000000','1409000000000','2013-11-22 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33460000000000','32938000000000','1395000000000','2013-11-25 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33461000000000','32925000000000','1381000000000','2013-11-26 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33462000000000','32926000000000','1367000000000','2013-11-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33463000000000','32927000000000','1353000000000','2013-11-30 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33464000000000','32928000000000','1339000000000','2013-12-02 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33465000000000','32929000000000','1325000000000','2013-12-04 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33466000000000','32930000000000','6687000000000','2013-12-06 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33467000000000','32931000000000','6771000000000','2013-12-09 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33468000000000','32932000000000','6757000000000','2013-12-10 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33469000000000','32933000000000','6743000000000','2013-12-12 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33470000000000','32934000000000','6729000000000','2013-12-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33471000000000','32935000000000','6715000000000','2013-12-16 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33472000000000','32936000000000','6701000000000','2013-12-18 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33473000000000','32937000000000','6673000000000','2013-12-20 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33474000000000','32938000000000','6659000000000','2013-12-23 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33475000000000','32925000000000','6645000000000','2013-12-24 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33476000000000','32926000000000','6631000000000','2013-12-24 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33477000000000','32927000000000','1647000000000','2013-12-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33478000000000','32928000000000','1633000000000','2013-12-30 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33479000000000','32929000000000','1619000000000','2014-01-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33480000000000','32930000000000','1605000000000','2014-01-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33481000000000','32931000000000','1591000000000','2014-01-07 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33482000000000','32932000000000','1577000000000','2014-01-07 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33483000000000','32933000000000','1563000000000','2014-01-09 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33484000000000','32934000000000','1549000000000','2014-01-11 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33485000000000','32935000000000','1535000000000','2014-01-13 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33486000000000','32936000000000','1521000000000','2014-01-15 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33487000000000','32937000000000','1507000000000','2014-01-17 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33488000000000','32938000000000','1493000000000','2014-01-20 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33489000000000','32925000000000','1479000000000','2014-01-21 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33490000000000','32926000000000','6827000000000','2014-01-23 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33491000000000','32927000000000','6897000000000','2014-01-25 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33492000000000','32928000000000','6883000000000','2014-01-27 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33493000000000','32929000000000','6869000000000','2014-01-29 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33494000000000','32930000000000','6855000000000','2014-01-31 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33495000000000','32931000000000','6841000000000','2014-02-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33496000000000','32932000000000','6813000000000','2014-02-04 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33497000000000','32933000000000','6799000000000','2014-02-06 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33498000000000','32934000000000','6785000000000','2014-02-08 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33499000000000','32935000000000','6604000000000','2014-02-10 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33500000000000','32936000000000','6590000000000','2014-02-12 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33501000000000','32937000000000','6576000000000','2014-02-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33502000000000','32938000000000','6562000000000','2014-02-17 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33503000000000','32925000000000','6548000000000','2014-02-18 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33504000000000','32926000000000','6534000000000','2014-02-20 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33505000000000','32927000000000','6520000000000','2014-02-22 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33506000000000','32928000000000','6506000000000','2014-02-24 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33507000000000','32929000000000','1312000000000','2014-02-26 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33508000000000','32930000000000','1298000000000','2014-02-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33509000000000','32931000000000','1284000000000','2014-03-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33510000000000','32932000000000','1270000000000','2014-03-04 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33511000000000','32933000000000','1256000000000','2014-03-06 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33512000000000','32934000000000','1242000000000','2014-03-08 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33513000000000','32935000000000','1228000000000','2014-03-10 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33514000000000','32936000000000','1214000000000','2014-03-12 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33515000000000','32937000000000','1200000000000','2014-03-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33516000000000','32938000000000','1186000000000','2014-03-17 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33517000000000','32925000000000','1172000000000','2014-03-18 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33518000000000','32926000000000','1158000000000','2014-03-20 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33519000000000','32927000000000','1144000000000','2014-03-22 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33520000000000','32928000000000','6618000000000','2014-03-24 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33521000000000','32929000000000','1466000000000','2014-03-26 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33522000000000','32930000000000','1452000000000','2014-03-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33523000000000','32931000000000','1438000000000','2014-03-31 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33524000000000','32932000000000','1424000000000','2014-04-01 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33525000000000','32933000000000','1410000000000','2014-04-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33526000000000','32934000000000','1396000000000','2014-04-05 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33527000000000','32935000000000','1382000000000','2014-04-07 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33528000000000','32936000000000','1368000000000','2014-04-09 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33529000000000','32937000000000','1354000000000','2014-04-11 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33530000000000','32938000000000','1340000000000','2014-04-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33531000000000','32925000000000','1326000000000','2014-04-15 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33532000000000','32926000000000','6758000000000','2014-04-17 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33533000000000','32927000000000','6744000000000','2014-04-19 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33534000000000','32928000000000','6730000000000','2014-04-22 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33535000000000','32929000000000','6716000000000','2014-04-22 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33536000000000','32930000000000','6702000000000','2014-04-23 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33537000000000','32931000000000','6688000000000','2014-04-24 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33538000000000','32932000000000','6674000000000','2014-04-26 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33539000000000','32933000000000','6660000000000','2014-04-26 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33540000000000','32934000000000','6646000000000','2014-04-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33541000000000','32935000000000','6632000000000','2014-04-28 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33542000000000','32936000000000','1648000000000','2014-04-29 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33543000000000','32937000000000','1634000000000','2014-04-30 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33544000000000','32938000000000','1620000000000','2014-05-02 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33545000000000','32925000000000','1606000000000','2014-05-02 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33546000000000','32926000000000','1592000000000','2014-05-03 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33547000000000','32927000000000','1578000000000','2014-05-05 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33548000000000','32928000000000','1564000000000','2014-05-05 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33549000000000','32929000000000','1550000000000','2014-05-06 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33550000000000','32930000000000','1536000000000','2014-05-07 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33551000000000','32931000000000','1522000000000','2014-05-08 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33552000000000','32932000000000','1508000000000','2014-05-09 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33553000000000','32933000000000','1494000000000','2014-05-10 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33554000000000','32934000000000','1480000000000','2014-05-12 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33555000000000','32935000000000','6898000000000','2014-05-12 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33556000000000','32936000000000','6884000000000','2014-05-13 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33557000000000','32937000000000','6870000000000','2014-05-14 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33558000000000','32938000000000','6856000000000','2014-05-15 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33559000000000','32925000000000','6842000000000','2014-05-16 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33560000000000','32926000000000','6828000000000','2014-05-17 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33561000000000','32927000000000','6814000000000','2014-05-19 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33562000000000','32928000000000','6800000000000','2014-05-19 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33563000000000','32929000000000','6786000000000','2014-05-20 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33564000000000','32930000000000','6772000000000','2014-05-20 00:00:00');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.parents_meetings FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.parents_meetings(boolean)
  OWNER TO postgres;
