-- Function: unit_tests_security.check_user_group_role(text, text)

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

-- absences
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.absences WHERE absence = ''33312000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES (''1133312000000000'',''2013-10-04'',''32936000000000'',NULL,''10372000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.absences SET on_date = ''2013-10-17'' WHERE absence = ''1133312000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.absences WHERE absence = ''1133312000000000'';');

-- branches
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.branches WHERE branch = 9948000000000;');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO branches (branch, school, description) VALUES (119948000000000, 1000000000, ''Sede (test)'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.branches SET description = ''sede non esistente'' WHERE branch = 119948000000000;');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.branches WHERE branch = 119948000000000;');

-- cities 
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.cities WHERE city = ''758438000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.cities(fiscal_code,description,district,city) VALUES (''01'',''Airasca (test) (test)'',''758321000000000'',''11758438000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.cities SET description = ''descrizione non esistente'' WHERE city = ''11758438000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.cities WHERE city = ''11758438000000000'';');

-- classrooms
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.classrooms WHERE classroom = ''10062000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES (''1110062000000000'',''243000000000'',''9942000000000'',''C'',''1'',''Infanzia 1C'',''9952000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.classrooms SET description = ''sede non esistente'' WHERE classroom = ''1110062000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.classrooms WHERE classroom = ''1110062000000000'';');

-- classrooms_students
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.classrooms_students WHERE classroom_student = ''1024600000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES (''10306000000000'',''10025000000000'',''6057000000000'',NULL,NULL);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.classrooms_students SET classroom = ''1002700000000'' WHERE classroom_student = ''1024600000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.classrooms_students WHERE classroom_student = ''1024600000000'';');

-- communication_types
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.communication_types WHERE communication_type = 138012000000000;');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO communication_types (communication_type, description, notification_management, school) VALUES (11138012000000000,''Skype'',FALSE,1000000000);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.communication_types SET description = ''descrizione non esistente'' WHERE communication_type = 11138012000000000;');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.communication_types WHERE communication_type = 11138012000000000;');

-- communications_media
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.communications_media WHERE communication_media = ''1120270000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES (''11112027000000000'',''3959000000000'',''138027000000000'',''casa'',''Lara.Lupini@example.org'',''t'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.communications_media SET description = ''descrizione non esistente'' WHERE communication_media = ''11112027000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.communications_media WHERE communication_media = ''11112027000000000'';');

-- conversations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.conversations WHERE conversation = ''3367000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES (''1133670000000000'',''10685000000000'',''Compiti in classe.'',''f'',NULL,NULL);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.conversations SET subject = ''subject non esistente'' WHERE conversation = ''1133670000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.conversations WHERE c onversation = ''1133670000000000'';');

-- countries
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.countries WHERE country = ''201000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.countries(country,description,existing,processing_code) VALUES (''11201000000000'',''BELGIO (test)'',''t'',''1201'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.countries SET description = ''descrizione non esistente'' WHERE country =''11201000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.countries WHERE country = ''11201000000000'';');

-- degrees
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.degrees WHERE degree = 994200000000;');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO degrees (degree, school, description, course_years) VALUES (119942000000000, 1000000000, ''test'', 3);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.degrees SET description = ''sede non esistente'' WHERE degree = 119942000000000;');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.degrees WHERE degree = 119942000000000;');

-- delays
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.delays WHERE delay = ''48854000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES (''1148872000000000'',''32927000000000'',''47612000000000'',''2013-09-18'',''08:30:05'',''10690000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.absences SET on_date = ''2013-10-17'' WHERE absence = ''1133312000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.absences WHERE absence = ''1133312000000000'';');

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.check_user_group_role(text, text)
  OWNER TO scuola247_supervisor;
