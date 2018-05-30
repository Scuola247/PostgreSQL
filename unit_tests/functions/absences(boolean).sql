-- Function: unit_tests.absences(boolean)

-- DROP FUNCTION unit_tests.absences(boolean);

CREATE OR REPLACE FUNCTION unit_tests.absences(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'persons',
										       'classrooms',
										       'school_years',
										       'lessons',
					                                               -- to avoide generation of circular references
					                                               -- 'delays',
					                                               -- to avoide generation of circular references
										       -- 'leavings',
					                                               -- to avoide generation of circular references
										       -- 'out_of_classrooms',
										       'classrooms_students',
										       'explanations'); 
    RETURN;
  END IF;  
  ------------------------------
  test_name = 'INSERT absences';
  ------------------------------
  BEGIN
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33311000000000','2014-02-22','32935000000000',NULL,'10373000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33310000000000','2014-02-21','32925000000000',NULL,'10374000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33309000000000','2014-02-20','32933000000000',NULL,'10375000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33308000000000','2014-02-19','32932000000000',NULL,'10376000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33307000000000','2014-01-18','32931000000000',NULL,'10377000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33306000000000','2014-02-17','32930000000000',NULL,'10378000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33305000000000','2013-10-02','32929000000000',NULL,'10379000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33304000000000','2014-02-15','32928000000000',NULL,'10380000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33303000000000','2014-02-14','32927000000000',NULL,'10381000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98580000000000','2013-09-16','32925000000000',NULL,'10381000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33302000000000','2014-02-13','32926000000000',NULL,'10382000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98571000000000','2014-02-13','32926000000000',NULL,'10383000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33301000000000','2014-02-12','32925000000000',NULL,'10383000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33322000000000','2014-03-05','32932000000000',NULL,'10362000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33333000000000','2013-10-22','32929000000000',NULL,'10395000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33332000000000','2014-03-15','32928000000000',NULL,'10396000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33331000000000','2014-03-14','32927000000000',NULL,'10397000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33330000000000','2014-03-13','32926000000000',NULL,'10398000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33329000000000','2014-03-12','32925000000000',NULL,'10399000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33328000000000','2014-03-11','32938000000000',NULL,'10400000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33327000000000','2014-03-10','32937000000000',NULL,'10401000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33326000000000','2013-12-05','32936000000000',NULL,'10402000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33325000000000','2014-03-08','32935000000000',NULL,'10403000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33324000000000','2014-03-07','32934000000000',NULL,'10404000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33323000000000','2014-03-06','32933000000000',NULL,'10405000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33344000000000','2014-03-27','32926000000000',NULL,'10384000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33343000000000','2014-03-26','32925000000000',NULL,'10385000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33342000000000','2014-03-25','32938000000000',NULL,'10386000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33341000000000','2014-03-24','32937000000000',NULL,'10387000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33334000000000','2014-03-17','32930000000000',NULL,'10394000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33340000000000','2013-11-29','32931000000000',NULL,'10388000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33339000000000','2014-03-22','32935000000000',NULL,'10389000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33338000000000','2014-03-21','32934000000000',NULL,'10390000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33337000000000','2014-03-20','32925000000000',NULL,'10391000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33336000000000','2014-03-19','32932000000000',NULL,'10392000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33335000000000','2014-03-18','32931000000000',NULL,'10393000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33357000000000','2014-04-09','32925000000000',NULL,'10415000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33356000000000','2014-04-08','32938000000000',NULL,'10416000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33355000000000','2014-04-07','32937000000000',NULL,'10417000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33354000000000','2013-10-05','32936000000000',NULL,'10418000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33353000000000','2014-04-05','32935000000000',NULL,'10419000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33352000000000','2014-02-04','32934000000000',NULL,'10420000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33351000000000','2014-04-03','32925000000000',NULL,'10421000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33350000000000','2014-04-02','32932000000000',NULL,'10422000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33349000000000','2014-04-01','32931000000000',NULL,'10423000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33348000000000','2014-03-31','32930000000000',NULL,'10424000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33347000000000','2013-11-13','32929000000000',NULL,'10425000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33346000000000','2014-03-29','32928000000000',NULL,'10426000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33345000000000','2014-03-28','32927000000000',NULL,'10427000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33366000000000','2014-04-18','32934000000000',NULL,'10406000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33365000000000','2014-04-17','32933000000000',NULL,'10407000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33364000000000','2014-04-16','32932000000000',NULL,'10408000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33358000000000','2014-04-10','32926000000000',NULL,'10414000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33363000000000','2014-04-15','32931000000000',NULL,'10409000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33362000000000','2014-04-14','32930000000000',NULL,'10410000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33361000000000','2013-10-05','32929000000000',NULL,'10411000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33360000000000','2014-04-12','32928000000000',NULL,'10412000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33359000000000','2014-04-11','32927000000000',NULL,'10413000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33387000000000','2014-05-09','32927000000000',NULL,'10661000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33386000000000','2014-05-08','32926000000000',NULL,'10662000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33385000000000','2014-05-07','32925000000000',NULL,'10663000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33384000000000','2014-05-06','32938000000000',NULL,'10664000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33383000000000','2014-05-05','32937000000000',NULL,'10665000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33382000000000','2013-10-05','32936000000000',NULL,'10666000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33381000000000','2014-05-03','32935000000000',NULL,'10667000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33380000000000','2014-05-02','32934000000000',NULL,'10668000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33379000000000','2013-10-05','32933000000000',NULL,'10669000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33378000000000','2014-04-30','32932000000000',NULL,'10670000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33377000000000','2014-04-29','32931000000000',NULL,'10671000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33376000000000','2014-04-28','32930000000000',NULL,'10672000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33375000000000','2013-10-05','32929000000000',NULL,'10673000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33374000000000','2014-04-26','32928000000000',NULL,'10674000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33373000000000','2014-04-25','32927000000000',NULL,'10675000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33388000000000','2014-05-10','32925000000000',NULL,'10660000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33429000000000','2014-01-20','32927000000000',NULL,'10706000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33428000000000','2014-01-20','32926000000000',NULL,'10707000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33427000000000','2014-01-18','32925000000000',NULL,'10708000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33426000000000','2014-01-17','32938000000000',NULL,'10709000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33425000000000','2014-01-16','32937000000000',NULL,'10710000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33424000000000','2013-12-02','32925000000000',NULL,'10711000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33321000000000','2014-03-04','32931000000000',NULL,'10363000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98575000000000','2014-03-13','32926000000000',NULL,'10364000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33320000000000','2014-03-03','32930000000000',NULL,'10364000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33319000000000','2013-12-09','32929000000000',NULL,'10365000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98572000000000','2014-03-03','32930000000000',NULL,'10365000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33318000000000','2014-03-01','32928000000000',NULL,'10366000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98573000000000','2014-03-03','32930000000000',NULL,'10366000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33317000000000','2014-02-28','32927000000000',NULL,'10367000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33316000000000','2014-02-27','32926000000000',NULL,'10368000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98574000000000','2014-03-03','32930000000000',NULL,'10368000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33315000000000','2014-02-26','32925000000000',NULL,'10369000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98579000000000','2013-09-16','32925000000000',NULL,'10370000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33314000000000','2014-02-25','32925000000000',NULL,'10370000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33313000000000','2014-02-24','32937000000000',NULL,'10371000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33372000000000','2014-04-24','32926000000000',NULL,'10676000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33371000000000','2014-04-23','32925000000000',NULL,'10677000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33370000000000','2014-04-22','32938000000000',NULL,'10678000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33369000000000','2014-04-21','32937000000000',NULL,'10679000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33368000000000','2013-10-05','32936000000000',NULL,'10680000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33367000000000','2014-04-19','32925000000000',NULL,'10681000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33399000000000','2014-05-21','32925000000000',NULL,'10692000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33398000000000','2014-05-20','32938000000000',NULL,'10693000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33397000000000','2014-05-19','32937000000000',NULL,'10694000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33396000000000','2013-10-05','32936000000000',NULL,'10695000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33395000000000','2014-05-17','32935000000000',NULL,'10696000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33394000000000','2014-05-16','32925000000000',NULL,'10697000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33393000000000','2014-05-15','32933000000000',NULL,'10698000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33392000000000','2014-02-14','32932000000000',NULL,'10699000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33391000000000','2014-05-13','32931000000000',NULL,'10700000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33390000000000','2014-05-12','32930000000000',NULL,'10701000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33389000000000','2013-10-05','32929000000000',NULL,'10702000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33409000000000','2014-05-31','32935000000000',NULL,'10682000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33408000000000','2014-05-30','32934000000000',NULL,'10683000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33407000000000','2014-05-29','32931000000000',NULL,'10684000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33406000000000','2014-05-28','32932000000000',NULL,'10685000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33405000000000','2014-05-27','32931000000000',NULL,'10686000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33404000000000','2014-05-26','32930000000000',NULL,'10687000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33403000000000','2013-12-13','32929000000000',NULL,'10688000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33402000000000','2014-05-24','32928000000000',NULL,'10689000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33401000000000','2014-05-23','32927000000000',NULL,'10690000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33400000000000','2014-05-22','32926000000000',NULL,'10691000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33422000000000','2014-01-13','32934000000000',NULL,'10713000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33421000000000','2014-02-12','32933000000000',NULL,'10714000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33420000000000','2014-02-11','32932000000000',NULL,'10715000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33419000000000','2014-02-10','32931000000000',NULL,'10716000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33418000000000','2014-04-02','32925000000000',NULL,'10717000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33417000000000','2013-12-13','32929000000000',NULL,'10718000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33416000000000','2014-02-07','32928000000000',NULL,'10719000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33415000000000','2014-03-06','32927000000000',NULL,'10720000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33414000000000','2014-03-05','32926000000000',NULL,'10721000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33413000000000','2014-02-13','32925000000000',NULL,'10722000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('98576000000000','2014-03-13','32926000000000',NULL,'10723000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33412000000000','2014-03-03','32930000000000',NULL,'10723000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33411000000000','2014-02-13','32937000000000',NULL,'10724000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33410000000000','2013-12-13','32936000000000',NULL,'10725000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33432000000000','2014-01-23','32930000000000',NULL,'10703000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33431000000000','2013-12-10','32929000000000',NULL,'10704000000000');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33430000000000','2014-01-21','32928000000000',NULL,'10705000000000');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.absences FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.absences(boolean)
  OWNER TO postgres;
