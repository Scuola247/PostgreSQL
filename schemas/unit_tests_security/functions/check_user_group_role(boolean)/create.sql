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

-- districts
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.districts WHERE district = ''75832100000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.districts(mnemonic,description,region,district) VALUES (''01'',''Torino (test)'',''1000000000'',''11758321000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.districts SET description = ''descrizione non esistente'' WHERE district = ''11758321000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.districts WHERE district = ''11758321000000000'';');

-- explanations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.explanations WHERE explanation = ''47600000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES (''1157313000000000'',''1214000000000'',''uscita in anticipo per motivi personali'',''2013-10-24 10:44:59'',''3512000000000'',''2013-10-25 10:44:59'',''32933000000000'',''2013-10-24'',''2013-10-24'',NULL,''11:30:30'',''Leave'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.explanations SET description = ''ritardoo'' WHERE explanation = ''1157313000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.explanations WHERE explanation = ''1157313000000000'';');

-- faults
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.faults WHERE fault = ''59632000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.faults(fault,student,description,lesson,note) VALUES (''159632000000000'',''1172000000000'',''ha dimenticato il libro di testo'',''102279000000000'',NULL);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.faults SET description = ''non ha il quaderno'' WHERE fault = ''159632000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.faults WHERE fault = ''159632000000000'';');

-- grade_types
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grade_types WHERE grade_type = ''46299000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES (''146299000000000'',''descrizione'',''29107000000000'',''D'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.grade_types SET description = ''descrizione'' WHERE grade_type = ''146299000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.grade_types WHERE grade_type = ''146299000000000'';');

-- grades
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grades WHERE grade = ''29066000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES (''129066000000000'',''29062000000000'',''Non classificabile'',''0'',''N/C'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.grades SET description = ''descrizione'' WHERE grade = ''129066000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.grades WHERE grade = ''129066000000000'';');

-- grading_meetings
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grading_meetings WHERE grading_meeting = ''119537000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES (''1119537000000000'',''244000000000'',''2014-06-15'',''Scrutinio secondo quadrimestre'',''f'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.grading_meetings SET closed = ''t'' WHERE grading_meeting = ''1119537000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.grading_meetings WHERE grading_meeting = ''1119537000000000'';');

-- grading_meetings_valutations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grading_meetings_valutations WHERE grading_meeting_valutation = ''130813000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,classroom,student,subject,grade,notes,lack_of_training,council_vote,teacher) VALUES (''1130752000000000'',''119533000000000'',''10034000000000'',''1465000000000'',''32919000000000'',''11463000000000'',NULL,''f'',''f'',NULL);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.grading_meetings_valutations SET lack_of_training = ''t'' WHERE grading_meeting_valutation = ''1130752000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.grading_meetings_valutations WHERE grading_meeting_valutation = ''1130752000000000'';');

-- grading_meetings_valutations_qua
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = ''126109000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES (''126110000000000'',''124388000000000'',''95977000000000'',''11478000000000'',''Esempio di una nota testuale a commento della valutazione della qualifica'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.grading_meetings_valutations_qua SET notes = ''nota'' WHERE grading_meeting_valutation_qua = ''126110000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = ''126110000000000'';');
 
-- holidays
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.holidays WHERE holiday = ''11335000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.holidays(holiday,school,on_date,description) VALUES (''111335000000000'',''2000000000'',''2013-01-03'',''Capodanno'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.holidays SET description = ''descrizione'' WHERE holiday = ''111335000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.holidays WHERE holiday = ''111335000000000'';');

-- leavings
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.leavings WHERE leaving = ''58393000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.leavings(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES (''1157313000000000'',''1214000000000'',''uscita in anticipo per motivi personali'',''2013-10-24 10:44:59'',''3512000000000'',''2013-10-25 10:44:59'',''32933000000000'',''2013-10-24'',''2013-10-24'',NULL,''11:30:30'',''Leave'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.leavings SET teacher = ''32937000000000'' WHERE leaving = ''1157313000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.leavings WHERE leaving = ''1157313000000000'';');

-- lessons
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.lessons WHERE lesson = ''98581000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES (''1198581000000000'',''10033000000000'',''2013-09-16'',''32911000000000'',''32925000000000'',''descrizione di esempio della lezione tenuta'',''t'',''08:00:00'',''09:00:00'',NULL,NULL);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.lessons SET description = ''descrizione non esistente'' WHERE lesson = ''1198581000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.lessons WHERE lesson = ''1198581000000000'';');

-- messages
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.messages WHERE message = ''50112000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.messages(message,conversation,written_on,message_text,person) VALUES (''1150112000000000'',''46328000000000'',''2013-09-16 08:26:43'',''Giustifico il ritardo di mio figlio.'',''5719000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.messages SET message_text = ''text non esistente'' WHERE message = ''1150112000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.messages WHERE message = ''1150112000000000'';');

-- messages_read
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.messages_read WHERE message_read = ''60304000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.districts(mnemonic,description,region,district) VALUES (''01'',''Torino (test)'',''1000000000'',''11758321000000000'');INSERT INTO public.messages_read(message_read,message,person,read_on) VALUES (''1160304000000000'',''50112000000000'',''32925000000000'',''2013-09-16 16:26:43'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.messages_read SET message = ''50113000000000'' WHERE message_read = ''1160304000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.messages_read WHERE message_read = ''1160304000000000'';');

-- metrics
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.metrics WHERE metric = ''11433000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.metrics(metric,school,description,sufficiency) VALUES (''1111433000000000'',''1000000000'',''Decimale'',''600'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.metrics SET description = ''descrizione non esistente'' WHERE metric = ''1111433000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.holidays WHERE holiday = ''111335000000000'';');

-- notes
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.notes WHERE note = ''104925000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES (''11104925000000000'',''6617000000000'',''Esempio di una nota disciplinare.'',''32927000000000'',''t'',''2014-06-05'',''09:00:00'',''t'',''10033000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.notes SET description = ''descrizione non esistente'' WHERE note = ''11104925000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.notes WHERE note = ''11104925000000000'';');

-- notes_signed
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.notes_signed WHERE note_signed = ''113134000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.notes_signed(note_signed,person,on_date,note) VALUES (''100113134000000000'',''8579000000000'',''2014-06-10 10:39:00'',''104925000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.notes_signed SET on_date = ''2014-04-19 11:39:00'' WHERE note_signed = ''100113134000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.notes_signed WHERE note_signed = ''100113134000000000'';');

-- out_of_classrooms
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.out_of_classrooms WHERE out_of_classroom = ''98577000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES (''1198577000000000'',''32937000000000'',''per selezioni sportive'',''2013-09-21'',''08:00:00'',''12:00:00'',''10379000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.out_of_classrooms SET description = ''descrizione non esistente'' WHERE out_of_classroom = ''1198577000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.out_of_classrooms WHERE out_of_classroom = ''1198577000000000'';');

-- parents_meetings
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.parents_meetings WHERE parents_meeting = ''33433000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee','scuola247_relative'], 'INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES (''1133433000000000'',''32925000000000'',''6603000000000'',''2013-10-01 00:00:00'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee','scuola247_relative'], 'UPDATE public.parents_meetings SET on_date = ''2013-11-11 00:00:00'' WHERE parents_meeting = ''1133433000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee','scuola247_relative'], 'DELETE FROM public.parents_meetings WHERE parents_meeting = ''1133433000000000'';');

-- persons
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons WHERE person = ''31185000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES (''1131185000000000'',''Alvise'',''Bertani'',''1999-05-05'',NULL,''252000000000'',''BRTLVS99E05Z252G'',''M'',''28961000000000'',''11660973000000000'',NULL,NULL,NULL,NULL,NULL,NULL);');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.persons SET name = ''nome non esistente'' WHERE person = ''1131185000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.persons WHERE person = ''1131185000000000'';');

-- persons_addresses
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons_addresses WHERE person_address = ''16765000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES (''1116765000000000'',''3326000000000'',''Residence'',''Via G. Segantini 91'',''37069'',''L949'',''761559000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.persons_addresses SET street = ''Via non esistente'' WHERE person_address = ''1116765000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.persons_addresses WHERE person_address = ''1116765000000000'';');

-- persons_relations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons_relations WHERE person_relation = ''27915000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.persons_relations(person_relation,person,person_related_to,sign_request,relationship,can_do_explanation) VALUES (''1127915000000000'',''6722000000000'',''8684000000000'',''f'',''Tutor'',''t'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.persons_relations SET relationship = ''Parent'' WHERE person_relation = ''1127915000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.persons_relations WHERE person_relation = ''1127915000000000'';');

-- persons_roles
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons_roles WHERE person_role = ''15623900000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.persons_roles(person_role,person,role) VALUES (''11156239000000000'',''4008000000000'',''Relative'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.persons_roles SET role = ''ruolo non esistente'' WHERE person_role = ''11156239000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.persons_roles WHERE person_role = ''11156239000000000'';');

-- qualifications
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.qualifications WHERE qualification = ''95977000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES (''1195977000000000'',''1000000000'',''Padroneggiare gli strumenti espressivi','Padroneggiare gli strumenti espressivi ed argomentativi indispensabili per gestire l’interazione comunicativa verbale in vari contesti'',''11435000000000'',''Expertise'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.qualifications SET description = ''descrizione non esistente'' WHERE qualification = ''1195977000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.qualifications WHERE qualification = ''1195977000000000'';');

-- qualifications_plan
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.qualifications_plan WHERE qualification_plan = ''128989000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.qualifications_plan(qualificationtion_plan,qualification,degree,course_year,subject) VALUES (''11128989000000000'',''96108000000000'',''9944000000000'',''1'',''32911000000000'');');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.qualifications_plan SET course_year = ''0'' WHERE qualification_plan = ''11128989000000000'';');
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.qualifications_plan WHERE qualification_plan = ''11128989000000000'';');

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.check_user_group_role(text, text)
  OWNER TO scuola247_supervisor;
