-- Function: unit_tests_public.holidays(boolean)

-- DROP FUNCTION unit_tests_public.holidays(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.holidays(
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
  test_name = 'INSERT holidays';
  ------------------------------
  BEGIN
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11335000000000','1000000000','2013-01-01','Capodanno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11336000000000','1000000000','2013-01-06','Epifania');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11337000000000','1000000000','2013-03-01','Lunedì dell''angelo (pasquetta)');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11338000000000','1000000000','2013-04-25','Liberazione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11339000000000','1000000000','2013-05-01','Festa del lavoro');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11340000000000','1000000000','2013-05-21','San Zeno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11341000000000','1000000000','2013-06-02','Festa della Repubblica d''Italia');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11342000000000','1000000000','2013-08-15','Assunzione di Maria in cielo / Ferragosto');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11343000000000','1000000000','2013-11-01','Ognisanti');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11344000000000','1000000000','2013-12-08','Immacolata concezione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11345000000000','1000000000','2013-12-25','Natale');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11346000000000','1000000000','2013-12-26','Santo Stefano');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11347000000000','1000000000','2014-01-01','Capodanno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11348000000000','1000000000','2014-01-06','Epifania');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11349000000000','1000000000','2014-04-21','Lunedì dell''angelo (pasquetta)');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11350000000000','1000000000','2014-04-25','Liberazione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11351000000000','1000000000','2014-05-01','Festa del lavoro');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11352000000000','1000000000','2014-05-21','San Zeno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11353000000000','1000000000','2014-06-02','Festa della Repubblica d''Italia');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11354000000000','1000000000','2014-08-15','Assunzione di Maria in cielo / Ferragosto');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11355000000000','1000000000','2014-11-01','Ognisanti');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11356000000000','1000000000','2014-12-08','Immacolata concezione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11357000000000','1000000000','2014-12-25','Natale');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11358000000000','1000000000','2014-12-26','Santo Stefano');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11359000000000','2000000000','2013-01-01','Capodanno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11360000000000','2000000000','2013-01-06','Epifania');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11361000000000','2000000000','2013-03-01','Lunedì dell''angelo (pasquetta)');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11362000000000','2000000000','2013-04-25','Liberazione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11363000000000','2000000000','2013-05-01','Festa del lavoro');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11364000000000','2000000000','2013-05-21','San Zeno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11365000000000','2000000000','2013-06-02','Festa della Repubblica d''Italia');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11366000000000','2000000000','2013-08-15','Assunzione di Maria in cielo / Ferragosto');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11367000000000','2000000000','2013-11-01','Ognisanti');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11368000000000','2000000000','2013-12-08','Immacolata concezione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11369000000000','2000000000','2013-12-25','Natale');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11370000000000','2000000000','2013-12-26','Santo Stefano');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11371000000000','2000000000','2014-01-01','Capodanno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11372000000000','2000000000','2014-01-06','Epifania');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11373000000000','2000000000','2014-04-21','Lunedì dell''angelo (pasquetta)');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11374000000000','2000000000','2014-04-25','Liberazione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11375000000000','2000000000','2014-05-01','Festa del lavoro');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11376000000000','2000000000','2014-05-21','San Zeno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11377000000000','2000000000','2014-06-02','Festa della Repubblica d''Italia');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11378000000000','2000000000','2014-08-15','Assunzione di Maria in cielo / Ferragosto');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11379000000000','2000000000','2014-11-01','Ognisanti');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11380000000000','2000000000','2014-12-08','Immacolata concezione');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11381000000000','2000000000','2014-12-25','Natale');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11382000000000','2000000000','2014-12-26','Santo Stefano');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.holidays FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.holidays(boolean)
  OWNER TO postgres;
