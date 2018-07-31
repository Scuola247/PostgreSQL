-- Function: unit_tests_public.weekly_timetables(boolean)

-- DROP FUNCTION unit_tests_public.weekly_timetables(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.weekly_timetables(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.classrooms');
    RETURN;
  END IF;
  ---------------------------------------
  test_name = 'INSERT weekly_timetables';
  ---------------------------------------
  BEGIN
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51386000000000','10033000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51378000000000','10034000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51384000000000','10035000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51379000000000','10036000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51375000000000','10037000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51377000000000','10038000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51385000000000','29023000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51381000000000','29024000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51380000000000','29025000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51383000000000','29026000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('55856000000000','29027000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51382000000000','29028000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51373000000000','29018000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51376000000000','29019000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51372000000000','29020000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51387000000000','29021000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51374000000000','29022000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('55878000000000','29018000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('55879000000000','29019000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('55880000000000','29020000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('55881000000000','29021000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('55882000000000','29022000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96208000000000','29052000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96209000000000','29053000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96210000000000','29054000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96211000000000','29055000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96212000000000','29056000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96213000000000','29057000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96214000000000','29058000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96215000000000','29059000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96216000000000','29060000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96217000000000','29061000000000','Settimana standard');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96218000000000','29032000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96219000000000','29033000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96220000000000','29034000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96221000000000','29035000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96222000000000','29036000000000','Settimana 1');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96993000000000','29032000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96994000000000','29033000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96995000000000','29034000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96996000000000','29035000000000','Settimana 2');
    INSERT INTO scuola247.weekly_timetables(weekly_timetable,classroom,description) VALUES ('96997000000000','29036000000000','Settimana 2');

    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT scuola247.weekly_timetable FAILED'::text, error);
       RETURN;
  END;
  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.weekly_timetables(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_public.weekly_timetables(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_public.weekly_timetables(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_public.weekly_timetables(boolean) TO scuola247_user;
