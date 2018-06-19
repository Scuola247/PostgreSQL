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
    UPDATE public.notes_signed SET on_date = '2014-06-09 10:39:00' WHERE note_signed = '113134000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-21 10:57:37' WHERE note_signed = '119212000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-20 11:18:57' WHERE note_signed = '119215000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-26 14:12:37' WHERE note_signed = '119217000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-27 11:27:52' WHERE note_signed = '119219000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-03 11:59:15' WHERE note_signed = '119222000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-09 13:39:00' WHERE note_signed = '113140000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-10 12:39:00' WHERE note_signed = '113141000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-08 12:39:00' WHERE note_signed = '113142000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-29 13:27:43' WHERE note_signed = '119224000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-01 11:26:27' WHERE note_signed = '119226000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-04 14:32:40' WHERE note_signed = '119228000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-01 14:32:40' WHERE note_signed = '119229000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-08 12:02:52' WHERE note_signed = '119233000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-08 14:32:22' WHERE note_signed = '119235000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-18 14:35:40' WHERE note_signed = '119237000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-13 14:22:14' WHERE note_signed = '119239000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-09 13:30:28' WHERE note_signed = '119241000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-16 13:07:33' WHERE note_signed = '119243000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-19 11:56:21' WHERE note_signed = '119246000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-22 11:36:56' WHERE note_signed = '119248000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-22 14:31:51' WHERE note_signed = '119250000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-28 11:50:39' WHERE note_signed = '119252000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-28 14:19:27' WHERE note_signed = '119254000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-27 10:04:40' WHERE note_signed = '119256000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-27 14:15:45' WHERE note_signed = '119258000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-05 14:19:26' WHERE note_signed = '119260000000000';
    UPDATE public.notes_signed SET on_date = '2013-10-31 10:32:58' WHERE note_signed = '119262000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-05 13:22:33' WHERE note_signed = '119264000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-09 09:59:38' WHERE note_signed = '119266000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-12 14:09:53' WHERE note_signed = '119268000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-20 14:29:49' WHERE note_signed = '119272000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-22 11:00:44' WHERE note_signed = '119276000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-27 10:09:46' WHERE note_signed = '119278000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-29 10:24:32' WHERE note_signed = '119280000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-25 12:34:45' WHERE note_signed = '119282000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-30 12:36:30' WHERE note_signed = '119284000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-03 14:14:20' WHERE note_signed = '119286000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-05 11:09:34' WHERE note_signed = '119288000000000';
    UPDATE public.notes_signed SET on_date = '2013-11-29 11:28:50' WHERE note_signed = '119290000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-03 13:32:26' WHERE note_signed = '119292000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-09 13:16:40' WHERE note_signed = '119294000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-10 12:56:40' WHERE note_signed = '119296000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-12 12:33:36' WHERE note_signed = '119298000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-08 12:33:36' WHERE note_signed = '119299000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-13 13:03:17' WHERE note_signed = '119301000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-23 10:29:50' WHERE note_signed = '119304000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-25 10:54:52' WHERE note_signed = '119308000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-14 12:39:00' WHERE note_signed = '113185000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-26 10:19:52' WHERE note_signed = '119310000000000';
    UPDATE public.notes_signed SET on_date = '2013-12-28 14:31:32' WHERE note_signed = '119312000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-16 11:38:18' WHERE note_signed = '119314000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-21 11:03:25' WHERE note_signed = '119316000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-23 11:15:20' WHERE note_signed = '119318000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-21 10:07:13' WHERE note_signed = '119320000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-20 10:12:13' WHERE note_signed = '119322000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-28 13:07:46' WHERE note_signed = '119326000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-29 11:59:11' WHERE note_signed = '119329000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-10 09:39:00' WHERE note_signed = '113195000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-11 12:39:00' WHERE note_signed = '113196000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-12 12:39:00' WHERE note_signed = '113197000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-22 12:52:27' WHERE note_signed = '119331000000000';
    UPDATE public.notes_signed SET on_date = '2014-01-31 14:38:10' WHERE note_signed = '119333000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-03 11:13:55' WHERE note_signed = '119335000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-06 11:30:51' WHERE note_signed = '119337000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-03 14:07:15' WHERE note_signed = '119339000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-06 10:52:45' WHERE note_signed = '119341000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-04 11:14:47' WHERE note_signed = '119345000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-08 11:17:24' WHERE note_signed = '119347000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-09 14:21:59' WHERE note_signed = '119349000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-09 12:01:39' WHERE note_signed = '119351000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-08 13:35:20' WHERE note_signed = '119353000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-11 10:39:00' WHERE note_signed = '113211000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-10 13:35:20' WHERE note_signed = '119354000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-09 09:39:00' WHERE note_signed = '113213000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-09 10:38:47' WHERE note_signed = '119356000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-11 10:38:47' WHERE note_signed = '119357000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-10 11:27:26' WHERE note_signed = '119359000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-12 13:28:56' WHERE note_signed = '119364000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-21 12:58:11' WHERE note_signed = '119366000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-24 14:10:44' WHERE note_signed = '119368000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-26 11:57:33' WHERE note_signed = '119370000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-25 11:57:33' WHERE note_signed = '119371000000000';
    UPDATE public.notes_signed SET on_date = '2014-02-20 10:16:22' WHERE note_signed = '119373000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-07 14:31:12' WHERE note_signed = '119378000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-02 10:27:58' WHERE note_signed = '119380000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-12 10:02:19' WHERE note_signed = '119382000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-12 10:02:19' WHERE note_signed = '119383000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-11 10:20:25' WHERE note_signed = '119385000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-04 12:18:13' WHERE note_signed = '119389000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-28 09:59:35' WHERE note_signed = '119391000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-07 12:39:00' WHERE note_signed = '113232000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-02 09:59:35' WHERE note_signed = '119392000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-03 14:10:14' WHERE note_signed = '119394000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-01 14:10:14' WHERE note_signed = '119395000000000';
    UPDATE public.notes_signed SET on_date = '2014-03-28 10:33:31' WHERE note_signed = '119397000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-13 13:39:00' WHERE note_signed = '113237000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-11 11:17:41' WHERE note_signed = '119399000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-11 11:17:41' WHERE note_signed = '119400000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-06 10:55:40' WHERE note_signed = '119402000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-10 11:27:18' WHERE note_signed = '119404000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-16 14:38:54' WHERE note_signed = '119406000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-13 11:01:26' WHERE note_signed = '119408000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-18 12:57:24' WHERE note_signed = '119410000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-11 13:31:21' WHERE note_signed = '119412000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-18 11:21:57' WHERE note_signed = '119414000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-20 10:13:53' WHERE note_signed = '119416000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-20 11:58:16' WHERE note_signed = '119418000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-21 13:03:46' WHERE note_signed = '119423000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-29 12:01:30' WHERE note_signed = '119425000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-02 12:01:30' WHERE note_signed = '119426000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-30 14:17:22' WHERE note_signed = '119428000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-03 14:17:22' WHERE note_signed = '119429000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-27 13:55:48' WHERE note_signed = '119431000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-28 11:18:47' WHERE note_signed = '119433000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-27 09:49:43' WHERE note_signed = '119435000000000';
    UPDATE public.notes_signed SET on_date = '2014-04-29 13:19:38' WHERE note_signed = '119439000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-07 12:59:21' WHERE note_signed = '119441000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-04 11:07:51' WHERE note_signed = '119443000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-09 11:07:51' WHERE note_signed = '119444000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-05 10:19:57' WHERE note_signed = '119446000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-09 13:59:29' WHERE note_signed = '119448000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-12 10:34:44' WHERE note_signed = '119450000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-15 11:27:49' WHERE note_signed = '119453000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-10 13:55:55' WHERE note_signed = '119455000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-17 10:19:23' WHERE note_signed = '119460000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-21 13:03:51' WHERE note_signed = '119462000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-19 11:36:35' WHERE note_signed = '119464000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-23 13:51:19' WHERE note_signed = '119466000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-30 14:37:10' WHERE note_signed = '119468000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-26 10:06:48' WHERE note_signed = '119470000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-24 12:59:35' WHERE note_signed = '119472000000000';
    UPDATE public.notes_signed SET on_date = '2014-05-30 14:11:35' WHERE note_signed = '119475000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-06 10:32:43' WHERE note_signed = '119477000000000';
    UPDATE public.notes_signed SET on_date = '2013-09-21 12:44:00' WHERE note_signed = '113303000000000';
    UPDATE public.notes_signed SET on_date = '2014-06-13 12:16:45' WHERE note_signed = '119482000000000';

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
  OWNER TO postgres;
