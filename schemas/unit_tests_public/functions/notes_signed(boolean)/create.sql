-- Function: unit_tests_public.notes_signed(boolean)

-- DROP FUNCTION unit_tests_public.notes_signed(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.notes_signed(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	  text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.school_years',
                                                                                       'unit_tests_public.classrooms',
                                                                                       'unit_tests_public.persons',
                                                                                       'unit_tests_public.notes');
    RETURN;
  END IF;
  ----------------------------------
  test_name = 'INSERT notes_signed';
  ----------------------------------
  -- remember that the rows in this
  -- table are inserted from the
  -- trigger tr_notes_iu we have
  -- only to update the date when
  -- the person signed
  ----------------------------------
  BEGIN
  
    UPDATE public.notes_signed SET on_date = '2014-06-09 10:39:00' WHERE note= '104925000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-21 10:57:37' WHERE note= '119211000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-20 11:18:57' WHERE note= '119214000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-26 14:12:37' WHERE note= '119216000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-27 11:27:52' WHERE note= '119218000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-03 11:59:15' WHERE note= '119221000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-09 13:39:00' WHERE note= '105054000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-10 12:39:00' WHERE note= '105071000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-08 12:39:00' WHERE note= '105066000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-29 13:27:43' WHERE note= '119223000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-01 11:26:27' WHERE note= '119225000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-04 14:32:40' WHERE note= '119227000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-01 14:32:40' WHERE note= '119227000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-08 12:02:52' WHERE note= '119232000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-08 14:32:22' WHERE note= '119234000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-18 14:35:40' WHERE note= '119236000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-13 14:22:14' WHERE note= '119238000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-09 13:30:28' WHERE note= '119240000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-16 13:07:33' WHERE note= '119242000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-19 11:56:21' WHERE note= '119245000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-22 11:36:56' WHERE note= '119247000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-22 14:31:51' WHERE note= '119249000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-28 11:50:39' WHERE note= '119251000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-28 14:19:27' WHERE note= '119253000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-27 10:04:40' WHERE note= '119255000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-27 14:15:45' WHERE note= '119257000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-05 14:19:26' WHERE note= '119259000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-31 10:32:58' WHERE note= '119261000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-05 13:22:33' WHERE note= '119263000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-09 09:59:38' WHERE note= '119265000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-12 14:09:53' WHERE note= '119267000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-20 14:29:49' WHERE note= '119271000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-22 11:00:44' WHERE note= '119275000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-27 10:09:46' WHERE note= '119277000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-29 10:24:32' WHERE note= '119279000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-25 12:34:45' WHERE note= '119281000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-30 12:36:30' WHERE note= '119283000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-03 14:14:20' WHERE note= '119285000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-05 11:09:34' WHERE note= '119287000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-29 11:28:50' WHERE note= '119289000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-03 13:32:26' WHERE note= '119291000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-09 13:16:40' WHERE note= '119293000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-10 12:56:40' WHERE note= '119295000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-12 12:33:36' WHERE note= '119297000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-08 12:33:36' WHERE note= '119297000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-13 13:03:17' WHERE note= '119300000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-23 10:29:50' WHERE note= '119303000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-25 10:54:52' WHERE note= '119307000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-14 12:39:00' WHERE note= '105091000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-26 10:19:52' WHERE note= '119309000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-28 14:31:32' WHERE note= '119311000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-16 11:38:18' WHERE note= '119313000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-21 11:03:25' WHERE note= '119315000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-23 11:15:20' WHERE note= '119317000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-21 10:07:13' WHERE note= '119319000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-20 10:12:13' WHERE note= '119321000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-28 13:07:46' WHERE note= '119325000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-29 11:59:11' WHERE note= '119328000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-10 09:39:00' WHERE note= '105093000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-11 12:39:00' WHERE note= '105077000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-12 12:39:00' WHERE note= '105077000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-22 12:52:27' WHERE note= '119330000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-31 14:38:10' WHERE note= '119332000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-03 11:13:55' WHERE note= '119334000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-06 11:30:51' WHERE note= '119336000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-03 14:07:15' WHERE note= '119338000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-06 10:52:45' WHERE note= '119340000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-04 11:14:47' WHERE note= '119344000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-08 11:17:24' WHERE note= '119346000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-09 14:21:59' WHERE note= '119348000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-09 12:01:39' WHERE note= '119350000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-08 13:35:20' WHERE note= '119352000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-11 10:39:00' WHERE note= '104939000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-10 13:35:20' WHERE note= '119352000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-09 09:39:00' WHERE note= '104929000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-09 10:38:47' WHERE note= '119355000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-11 10:38:47' WHERE note= '119355000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-10 11:27:26' WHERE note= '119358000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-12 13:28:56' WHERE note= '119363000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-21 12:58:11' WHERE note= '119365000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-24 14:10:44' WHERE note= '119367000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-26 11:57:33' WHERE note= '119369000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-25 11:57:33' WHERE note= '119369000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-20 10:16:22' WHERE note= '119372000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-07 14:31:12' WHERE note= '119377000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-02 10:27:58' WHERE note= '119379000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-12 10:02:19' WHERE note= '119381000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-12 10:02:19' WHERE note= '119381000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-11 10:20:25' WHERE note= '119384000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-04 12:18:13' WHERE note= '119387000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-28 09:59:35' WHERE note= '119390000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-07 12:39:00' WHERE note= '105057000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-02 09:59:35' WHERE note= '119390000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-03 14:10:14' WHERE note= '119393000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-01 14:10:14' WHERE note= '119393000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-28 10:33:31' WHERE note= '119396000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-13 13:39:00' WHERE note= '104938000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-11 11:17:41' WHERE note= '119398000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-11 11:17:41' WHERE note= '119398000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-06 10:55:40' WHERE note= '119401000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-10 11:27:18' WHERE note= '119403000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-16 14:38:54' WHERE note= '119405000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-13 11:01:26' WHERE note= '119407000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-18 12:57:24' WHERE note= '119409000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-11 13:31:21' WHERE note= '119411000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-18 11:21:57' WHERE note= '119413000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-20 10:13:53' WHERE note= '119415000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-20 11:58:16' WHERE note= '119417000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-21 13:03:46' WHERE note= '119422000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-29 12:01:30' WHERE note= '119424000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-02 12:01:30' WHERE note= '119424000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-30 14:17:22' WHERE note= '119427000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-03 14:17:22' WHERE note= '119427000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-27 13:55:48' WHERE note= '119430000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-28 11:18:47' WHERE note= '119432000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-27 09:49:43' WHERE note= '119434000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-29 13:19:38' WHERE note= '119438000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-07 12:59:21' WHERE note= '119440000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-04 11:07:51' WHERE note= '119442000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-09 11:07:51' WHERE note= '119442000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-05 10:19:57' WHERE note= '119445000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-09 13:59:29' WHERE note= '119447000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-12 10:34:44' WHERE note= '119449000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-15 11:27:49' WHERE note= '119452000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-10 13:55:55' WHERE note= '119454000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-17 10:19:23' WHERE note= '119459000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-21 13:03:51' WHERE note= '119461000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-19 11:36:35' WHERE note= '119463000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-23 13:51:19' WHERE note= '119465000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-30 14:37:10' WHERE note= '119467000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-26 10:06:48' WHERE note= '119469000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-24 12:59:35' WHERE note= '119471000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-30 14:11:35' WHERE note= '119474000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-06 10:32:43' WHERE note= '119476000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-21 12:44:00' WHERE note= '113279000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-13 12:16:45' WHERE note= '119481000000000';


    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
      WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.notes_signed FAILED'::text, error);
      RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.notes_signed(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_public.notes_signed(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_public.notes_signed(boolean) TO scuola247_user;
REVOKE ALL ON FUNCTION unit_tests_public.notes_signed(boolean) FROM public;
