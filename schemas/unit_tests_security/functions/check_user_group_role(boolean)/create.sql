﻿-- Function: unit_tests_security.check_user_group_role(text, text)

-- DROP FUNCTION unit_tests_security.check_user_group_role(text, text);

CREATE OR REPLACE FUNCTION unit_tests_security.check_user_group_role(
    IN _usename text DEFAULT NULL::text,
    IN _group text DEFAULT 'scuola247_supervisor'::text,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

-- Absences
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.absences WHERE absence = ''33312000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES (''1133312000000000'',''2013-10-04'',''32936000000000'',NULL,''10372000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.absences SET on_date = ''2013-10-17'' WHERE absence = ''1133312000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.absences WHERE absence = ''1133312000000000'';');

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.check_user_group_role(text, text)
  OWNER TO scuola247_supervisor;
