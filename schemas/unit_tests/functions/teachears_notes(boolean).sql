-- Function: unit_tests.teachears_notes(boolean)

-- DROP FUNCTION unit_tests.teachears_notes(boolean);

CREATE OR REPLACE FUNCTION unit_tests.teachears_notes(
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
										       'lessons');
    RETURN;
  END IF;  
  -------------------------------------
  test_name = 'INSERT teachears_notes';
  -------------------------------------
  BEGIN
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61764000000000','6617000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-02-13',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61776000000000','1143000000000','alunno con difficoltÃ  nell''apprendimento','32925000000000','2014-02-25',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61769000000000','1157000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-01-18',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61782000000000','1171000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-03-03',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61770000000000','1185000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-02-19',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61773000000000','1199000000000','esempio di nota interna del docente sull''alunno','32935000000000','2014-02-22',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61772000000000','1213000000000','alunno con difficoltÃ  nell''apprendimento','32925000000000','2014-02-21',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61774000000000','1227000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2013-10-05',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61766000000000','1241000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-02-15',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61779000000000','1255000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-02-28',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61771000000000','1269000000000','esempio di nota interna del docente sull''alunno','32933000000000','2014-02-20',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61780000000000','1283000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-03-01',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61777000000000','1297000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-02-26',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61783000000000','1311000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-03-04',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61762000000000','6505000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-04-18',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61775000000000','6519000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-02-24',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61763000000000','6533000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-02-12',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61765000000000','6547000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-02-14',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61767000000000','6561000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-10-02',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61778000000000','6575000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-02-27',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61781000000000','6589000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-12-09',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61768000000000','6603000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-02-17',NULL,'10033000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61835000000000','6631000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-04-25',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61828000000000','6645000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-04-18',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61847000000000','6659000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-05-07',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61839000000000','6673000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-04-29',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61833000000000','6701000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-04-23',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61832000000000','6715000000000','alunno con difficoltÃ  nell''apprendimento','32938000000000','2014-04-22',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61830000000000','6729000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2013-10-05',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61848000000000','6743000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-05-08',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61836000000000','6757000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-04-26',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61831000000000','6771000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-04-21',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61849000000000','6687000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-05-09',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61846000000000','1325000000000','alunno con difficoltÃ  nell''apprendimento','32938000000000','2014-05-06',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61845000000000','1339000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-05-05',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61844000000000','1353000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2013-10-05',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61842000000000','1367000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-05-02',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61838000000000','1381000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-04-28',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61840000000000','1395000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-04-30',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61841000000000','1409000000000','esempio di nota interna del docente sull''alunno','32933000000000','2013-10-05',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61843000000000','1423000000000','esempio di nota interna del docente sull''alunno','32935000000000','2014-05-03',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61837000000000','1437000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-10-05',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61834000000000','1451000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-04-24',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61829000000000','1465000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-04-19',NULL,'10034000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61896000000000','6785000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-02-13',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61902000000000','6799000000000','alunno con difficoltÃ  nell''apprendimento','32931000000000','2014-02-19',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61892000000000','6813000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-01-21',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61900000000000','6841000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2014-02-17',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61903000000000','6855000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-02-20',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61898000000000','6869000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-02-15',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61906000000000','6883000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2013-10-05',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61909000000000','6897000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-02-26',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61899000000000','6827000000000','esempio di nota interna del docente sull''alunno','32935000000000','2013-10-02',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61894000000000','1479000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-01-23',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61895000000000','1493000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-02-12',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61911000000000','1507000000000','esempio di nota interna del docente sull''alunno','32933000000000','2014-02-28',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61913000000000','1521000000000','esempio di nota interna del docente sull''alunno','32935000000000','2013-12-09',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61912000000000','1535000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-03-01',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61901000000000','1549000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-01-18',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61893000000000','1563000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-12-10',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61907000000000','1577000000000','esempio di nota interna del docente sull''alunno','32929000000000','2014-02-24',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61910000000000','1591000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-02-27',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61905000000000','1605000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-02-22',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61897000000000','1619000000000','esempio di nota interna del docente sull''alunno','32933000000000','2014-02-14',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61904000000000','1633000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-02-21',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61908000000000','1647000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-02-25',NULL,'10035000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61784000000000','6618000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-03-05',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61801000000000','1144000000000','esempio di nota interna del docente sull''alunno','32935000000000','2014-03-22',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61788000000000','1158000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2013-12-05',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61789000000000','1172000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-03-10',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61787000000000','1186000000000','esempio di nota interna del docente sull''alunno','32935000000000','2014-03-08',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61786000000000','1200000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-03-07',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61802000000000','1214000000000','alunno con difficoltÃ  nell''apprendimento','32931000000000','2013-11-29',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61796000000000','1228000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-03-17',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61790000000000','1242000000000','alunno con difficoltÃ  nell''apprendimento','32938000000000','2014-03-11',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61791000000000','1256000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-03-12',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61792000000000','1270000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-03-13',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61793000000000','1284000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-03-14',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61794000000000','1298000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-03-15',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61795000000000','1312000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-10-22',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61785000000000','6506000000000','esempio di nota interna del docente sull''alunno','32933000000000','2014-03-06',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61805000000000','6520000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-03-26',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61800000000000','6534000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-03-21',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61804000000000','6548000000000','alunno con difficoltÃ  nell''apprendimento','32938000000000','2014-03-25',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61799000000000','6562000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-03-20',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61803000000000','6576000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-03-24',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61798000000000','6590000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-03-19',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61797000000000','6604000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-03-18',NULL,'10036000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61862000000000','6632000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-05-22',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61857000000000','6646000000000','esempio di nota interna del docente sull''alunno','32935000000000','2014-05-17',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61856000000000','6660000000000','alunno con difficoltÃ  nell''apprendimento','32925000000000','2014-05-16',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61863000000000','6674000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-05-23',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61855000000000','6688000000000','esempio di nota interna del docente sull''alunno','32933000000000','2014-05-15',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61854000000000','6702000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-02-14',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61864000000000','6716000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2014-05-24',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61853000000000','6730000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-05-13',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61852000000000','6744000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-05-12',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61851000000000','6758000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-10-05',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61850000000000','1326000000000','alunno con difficoltÃ  nell''apprendimento','32925000000000','2014-05-10',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61870000000000','1340000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-05-30',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61869000000000','1354000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-05-29',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61868000000000','1368000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-05-28',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61858000000000','1382000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2013-10-05',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61867000000000','1396000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-05-27',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61866000000000','1410000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-05-26',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61859000000000','1424000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-05-19',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61860000000000','1438000000000','alunno con difficoltÃ  nell''apprendimento','32938000000000','2014-05-20',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61861000000000','1452000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-05-21',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61865000000000','1466000000000','esempio di nota interna del docente sull''alunno','32929000000000','2013-12-13',NULL,'10037000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61914000000000','6772000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2014-03-03',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61920000000000','6786000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2013-12-05',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61928000000000','6800000000000','alunno con difficoltÃ  nell''apprendimento','32936000000000','2014-03-17',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61921000000000','6814000000000','esempio di nota interna del docente sull''alunno','32929000000000','2014-03-10',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61929000000000','6828000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-03-18',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61930000000000','6842000000000','alunno con difficoltÃ  nell''apprendimento','32938000000000','2014-03-19',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61922000000000','6856000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-03-11',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61931000000000','6870000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-03-20',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61923000000000','6884000000000','esempio di nota interna del docente sull''alunno','32931000000000','2014-03-12',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61924000000000','6898000000000','alunno con difficoltÃ  nell''apprendimento','32932000000000','2014-03-13',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61926000000000','1480000000000','alunno con difficoltÃ  nell''apprendimento','32934000000000','2014-03-15',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61934000000000','1494000000000','alunno con difficoltÃ  nell''apprendimento','32928000000000','2013-11-29',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61918000000000','1508000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-03-07',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61925000000000','1522000000000','esempio di nota interna del docente sull''alunno','32933000000000','2014-03-14',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61935000000000','1536000000000','esempio di nota interna del docente sull''alunno','32929000000000','2014-03-24',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61936000000000','1550000000000','alunno con difficoltÃ  nell''apprendimento','32930000000000','2014-03-25',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61933000000000','1564000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-03-22',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61917000000000','1578000000000','esempio di nota interna del docente sull''alunno','32925000000000','2014-03-06',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61919000000000','1592000000000','esempio di nota interna del docente sull''alunno','32927000000000','2014-03-08',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61927000000000','1606000000000','esempio di nota interna del docente sull''alunno','32935000000000','2013-10-22',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61915000000000','1620000000000','esempio di nota interna del docente sull''alunno','32937000000000','2014-03-04',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61932000000000','1634000000000','alunno con difficoltÃ  nell''apprendimento','32926000000000','2014-03-21',NULL,'10038000000000');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61916000000000','1648000000000','alunno con difficoltÃ  nell''apprendimento','32925000000000','2014-03-05',NULL,'10038000000000');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT teachears_notes FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.teachears_notes(boolean)
  OWNER TO postgres;
