-- Function: unit_tests_public.classrooms(boolean)

-- DROP FUNCTION unit_tests_public.classrooms(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.classrooms(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.school_years',
										       'unit_tests_public.degrees',
										       'unit_tests_public.branches');
    RETURN;
  END IF;  
  --------------------------------
  test_name = 'INSERT classrooms';
  --------------------------------
  BEGIN
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10062000000000','243000000000','9942000000000','C','1','Infanzia 1C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10063000000000','243000000000','9942000000000','C','2','Infanzia 2C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10064000000000','243000000000','9942000000000','C','3','Infanzia 3C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29050000000000','28969000000000','28970000000000','E','2','2E Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29049000000000','28969000000000','28970000000000','E','1','1E Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29047000000000','28969000000000','28970000000000','D','2','2D Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29045000000000','28969000000000','28970000000000','C','3','3C Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29043000000000','28969000000000','28970000000000','C','1','1C Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29051000000000','28969000000000','28970000000000','E','3','3E Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29053000000000','28969000000000','28972000000000','A','2','2A Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29052000000000','28969000000000','28972000000000','A','1','1A Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29054000000000','28969000000000','28972000000000','A','3','3A Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29056000000000','28969000000000','28972000000000','B','2','2B Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29055000000000','28969000000000','28972000000000','B','1','1B Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29057000000000','28969000000000','28972000000000','B','3','3B Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10017000000000','243000000000','9942000000000','A','1','Infanzia 1A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10018000000000','243000000000','9942000000000','A','2','Infanzia 2A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10019000000000','243000000000','9942000000000','A','3','Infanzia 3A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10020000000000','243000000000','9942000000000','B','1','Infanzia 1B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10021000000000','243000000000','9942000000000','B','2','Infanzia 2B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10022000000000','243000000000','9942000000000','B','3','Infanzia 3B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10023000000000','243000000000','9943000000000','A','1','Scuola primaria 1A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10024000000000','243000000000','9943000000000','A','2','Scuola primaria 2A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10025000000000','243000000000','9943000000000','A','3','Scuola primaria 3A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10026000000000','243000000000','9943000000000','A','4','Scuola primaria 4A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10027000000000','243000000000','9943000000000','A','5','Scuola primaria 5A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10028000000000','243000000000','9943000000000','B','1','Scuola primaria 1B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10029000000000','243000000000','9943000000000','B','2','Scuola primaria 2B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10030000000000','243000000000','9943000000000','B','3','Scuola primaria 3B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10031000000000','243000000000','9943000000000','B','4','Scuola primaria 4B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10032000000000','243000000000','9943000000000','B','5','Scuola primaria 5B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10033000000000','243000000000','9944000000000','A','1','Scuola secondaria 1Â° 1A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10034000000000','243000000000','9944000000000','A','2','Scuola secondaria 1Â° 2A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10035000000000','243000000000','9944000000000','A','3','Scuola secondaria 1Â° 3A','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10036000000000','243000000000','9944000000000','B','1','Scuola secondaria 1Â° 1B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10037000000000','243000000000','9944000000000','B','2','Scuola secondaria 1Â° 2B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10038000000000','243000000000','9944000000000','B','3','Scuola secondaria 1Â° 3B','9948000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10039000000000','243000000000','9943000000000','C','1','Scuola primaria 1C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10040000000000','243000000000','9943000000000','C','2','Scuola primaria 2C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10041000000000','243000000000','9943000000000','C','3','Scuola primaria 3C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10042000000000','243000000000','9943000000000','C','4','Scuola primaria 4C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10043000000000','243000000000','9943000000000','C','5','Scuola primaria 5C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29059000000000','28969000000000','28972000000000','C','2','2C Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29058000000000','28969000000000','28972000000000','C','1','1C Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29060000000000','28969000000000','28972000000000','C','3','3C Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29061000000000','28969000000000','28972000000000','D','3','3D Simeoni','28966000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29019000000000','28969000000000','28971000000000','A','2','2A Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29020000000000','28969000000000','28971000000000','A','3','3A Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29018000000000','28969000000000','28971000000000','A','1','1A Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10044000000000','243000000000','9944000000000','C','1','Scuola secondaria 1Â° 1C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10045000000000','243000000000','9944000000000','C','2','Scuola secondaria 1Â° 2C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10046000000000','243000000000','9944000000000','C','3','Scuola secondaria 1Â° 3C','9952000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10047000000000','244000000000','9945000000000','A','1','Elettronica 1A','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10048000000000','244000000000','9945000000000','A','2','Elettronica 2A','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10049000000000','244000000000','9945000000000','A','3','Elettronica 3A','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10050000000000','244000000000','9945000000000','A','4','Elettronica 4A','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10051000000000','244000000000','9945000000000','A','5','Elettronica 5A','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10052000000000','244000000000','9945000000000','B','1','Elettronica 1B','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10053000000000','244000000000','9945000000000','B','2','Elettronica 2B','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10054000000000','244000000000','9945000000000','B','3','Elettronica 3B','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10055000000000','244000000000','9945000000000','B','4','Elettronica 4B','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10056000000000','244000000000','9945000000000','B','5','Elettronica 5B','9953000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10057000000000','244000000000','9947000000000','A','1','Informatica 1A','9954000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10058000000000','244000000000','9947000000000','A','2','Informatica 2A','9954000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10059000000000','244000000000','9947000000000','A','3','Informatica 3A','9954000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10060000000000','244000000000','9947000000000','A','4','Informatica 4A','9954000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10061000000000','244000000000','9947000000000','A','5','Informatica 5A','9954000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29022000000000','28969000000000','28971000000000','A','5','5A Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29021000000000','28969000000000','28971000000000','A','4','4A Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29025000000000','28969000000000','28971000000000','B','3','3B Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29024000000000','28969000000000','28971000000000','B','2','2B Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29026000000000','28969000000000','28971000000000','B','4','4B Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29037000000000','28969000000000','28970000000000','A','1','1A Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29038000000000','28969000000000','28970000000000','A','2','2A Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29040000000000','28969000000000','28970000000000','B','1','1B Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29039000000000','28969000000000','28970000000000','A','3','3A Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29041000000000','28969000000000','28970000000000','B','2','2B Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29042000000000','28969000000000','28970000000000','B','3','3B Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29044000000000','28969000000000','28970000000000','C','2','2C Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29046000000000','28969000000000','28970000000000','D','1','1D Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29048000000000','28969000000000','28970000000000','D','3','3D Monte d''oro','28965000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29029000000000','28969000000000','28970000000000','A','1','1A Agazzi','28963000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29031000000000','28969000000000','28970000000000','A','3','3A Agazzi','28963000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29030000000000','28969000000000','28970000000000','A','2','2A Agazzi ','28963000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29027000000000','28969000000000','28971000000000','B','5','5B Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29034000000000','28969000000000','28971000000000','A','3','3A Mizzole','28964000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29028000000000','28969000000000','28971000000000','C','4','4C Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29033000000000','28969000000000','28971000000000','A','2','2A Mizzole','28964000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29036000000000','28969000000000','28971000000000','A','5','5A Mizzole','28964000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29023000000000','28969000000000','28971000000000','B','1','1B Bettelloni','28962000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29032000000000','28969000000000','28971000000000','A','1','1A Mizzole','28964000000000');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('29035000000000','28969000000000','28971000000000','A','4','4A Mizzole','28964000000000');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.classrooms FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.classrooms(boolean)
  OWNER TO postgres;
