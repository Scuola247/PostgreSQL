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
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.absences WHERE absence = ''33312000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES (''133312000000200'',''2013-10-22'',''2362000000200'',NULL,''10246000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.absences SET on_date = ''2013-10-21'' WHERE absence = ''133312000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.absences WHERE absence = ''133312000000200'';', 1);

-- branches
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.branches WHERE branch = 9954000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO branches (branch, school, description) VALUES (19954000000200, 2000000200, ''Sede (test)'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.branches SET description = ''sede non esistente'' WHERE branch = 19954000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.branches WHERE branch = 19954000000200;', 1);

-- cities 
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.cities WHERE city = ''758438000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.cities(fiscal_code,description,district,city) VALUES (''01'',''Airasca (test) (test)'',''758321000000100'',''1758438000000100'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.cities SET description = ''descrizione non esistente'' WHERE city = ''1758438000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.cities WHERE city = ''1758438000000100'';', 1);

-- classrooms
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.classrooms WHERE classroom = ''10062000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES (''110062000000200'',''244000000200'',''9947000000200'',''C'',''3'',''Infanzia 3C'',''9954000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.classrooms SET description = ''sede non esistente'' WHERE classroom = ''110062000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.classrooms WHERE classroom = ''110062000000200'';', 1);

-- classrooms_students
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.classrooms_students WHERE classroom_student = ''10246000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES (''110246000000200'',''10062000000200'',''1032000000200'',NULL,NULL);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.classrooms_students SET classroom = ''10063000000200'' WHERE classroom_student = ''110246000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.classrooms_students WHERE classroom_student = ''110246000000200'';', 1);

-- communication_types
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.communication_types WHERE communication_type = 138016000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO communication_types (communication_type, description, notification_management, school) VALUES (11138012000000200,''Skype'',FALSE,2000000200);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.communication_types SET description = ''descrizione non esistente'' WHERE communication_type = 11138012000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.communication_types WHERE communication_type = 11138012000000200;', 1);

-- communications_media
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.communications_media WHERE communication_media = ''112027000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES (''1112027000000200'',''2360000000200'',''138016000000200'',''casa (test)'',''Lara.Lupini@example.org'',''t'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.communications_media SET description = ''descrizione non esistente'' WHERE communication_media = ''1112027000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.communications_media WHERE communication_media = ''1112027000000200'';', 1);

-- conversations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.conversations WHERE conversation = ''33670000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES (''133670000000200'',''10246000000200'',''Compiti in classe.'',''f'',NULL,NULL);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.conversations SET subject = ''subject non esistente'' WHERE conversation = ''133670000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.conversations WHERE conversation = ''133670000000200'';', 1);

-- countries
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.countries WHERE country = ''201000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.countries(country,description,existing,processing_code) VALUES (''1201000000100'',''BELGIUM (test)'',''t'',''9202'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.countries SET description = ''descrizione non esistente'' WHERE country =''1201000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.countries WHERE country = ''1201000000100'';', 1);

-- degrees
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.degrees WHERE degree = 9947000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO degrees (degree, school, description, course_years) VALUES (19947000000200, 2000000200, ''test'', 3);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.degrees SET description = ''sede non esistente'' WHERE degree = 19947000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.degrees WHERE degree = 19947000000200;', 1);

-- delays
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.delays WHERE delay = ''48854000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES (''148854000000200'',''3836000000200'',NULL,''2013-10-21'',''08:30:05'',''10246000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.delays SET on_date = ''2013-10-22'' WHERE delay = ''148854000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.delays WHERE delay = ''148854000000200'';', 1);

-- districts
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.districts WHERE district = ''758321000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.districts(mnemonic,description,region,district) VALUES (''Z2'',''Turin (test)'',''1000000100'',''1758321000000100'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.districts SET description = ''descrizione non esistente'' WHERE district = ''1758321000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.districts WHERE district = ''1758321000000100'';', 1);

-- explanations 
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.explanations WHERE explanation = ''57313000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES (''157313000000200'',''2358000000200'',''uscita in anticipo per motivi personali'',''2013-10-24 10:44:59'',''2362000000200'',''2013-10-25 10:44:59'',''2363000000200'',''2013-10-24'',''2013-10-24'',NULL,''11:30:30'',''Leave'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.explanations SET description = ''ritardoo'' WHERE explanation = ''157313000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.explanations WHERE explanation = ''157313000000200'';', 1);

-- faults
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.faults WHERE fault = ''59632000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.faults(fault,student,description,lesson,note) VALUES (''159632000000200'',''2358000000200'',''ha dimenticato il libro di testo a casa'',''98605000000200'',NULL);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.faults SET description = ''non ha il quaderno'' WHERE fault = ''159632000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.faults WHERE fault = ''159632000000200'';', 1);

-- grade_types
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grade_types WHERE grade_type = ''46299000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES (''146299000000200'',''descrizione'',''29105000000200'',''D'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.grade_types SET description = ''descrizione'' WHERE grade_type = ''146299000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.grade_types WHERE grade_type = ''146299000000200'';', 1);

-- grades
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grades WHERE grade = ''29078000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES (''129078000000200'',''11436000000200'',''Non classificabile'',''0'',''N/C'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.grades SET description = ''descrizione'' WHERE grade = ''129078000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.grades WHERE grade = ''129078000000200'';', 1);

-- grading_meetings
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grading_meetings WHERE grading_meeting = ''119537000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES (''1119537000000200'',''244000000200'',''2014-05-15'',''Scrutinio secondo quadrimestre (test)'',''f'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.grading_meetings SET closed = ''t'' WHERE grading_meeting = ''1119537000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.grading_meetings WHERE grading_meeting = ''1119537000000200'';', 1);

-- grading_meetings_valutations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grading_meetings_valutations WHERE grading_meeting_valutation = ''130752000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES (''1130752000000200'',''119537000000200'',''29105000000200'',''29086000000200'',NULL,''f'',''f'',NULL,10247000000200);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.grading_meetings_valutations SET lack_of_training = ''t'' WHERE grading_meeting_valutation = ''1130752000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.grading_meetings_valutations WHERE grading_meeting_valutation = ''1130752000000200'';', 1);

-- grading_meetings_valutations_qua
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = ''126109000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES (''1126109000000200'',''130754000000200'',''95979000000200'',''29094000000200'',''Esempio di una nota testuale a commento della valutazione della qualifica'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.grading_meetings_valutations_qua SET notes = ''nota'' WHERE grading_meeting_valutation_qua = ''1126109000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = ''1126109000000200'';', 1);
 
-- holidays 
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.holidays WHERE holiday = ''11335000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.holidays(holiday,school,on_date,description) VALUES (''111335000000200'',''2000000200'',''2013-01-03'',''Capodanno Cinese'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.holidays SET description = ''descrizione'' WHERE holiday = ''111335000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.holidays WHERE holiday = ''111335000000200'';', 1);

-- leavings
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.leavings WHERE leaving = ''58393000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES (''158393000000200'',''3836000000200'',''57318000000200'',''2013-10-21'',''10:44:59'',''10246000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.leavings SET at_time = ''10:33:59'' WHERE leaving = ''158393000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.leavings WHERE leaving = ''158393000000200'';', 1);

-- lessons
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.lessons WHERE lesson = ''98581000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES (''198581000000200'',''10062000000200'',''2013-09-16'',''29105000000200'',''2362000000200'',''descrizione di esempio della lezione tenuta'',''t'',''08:00:00'',''09:00:00'',NULL,NULL);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.lessons SET description = ''descrizione non esistente'' WHERE lesson = ''198581000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.lessons WHERE lesson = ''198581000000200'';', 1);

-- messages
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.messages WHERE message = ''50112000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.messages(message,conversation,written_on,message_text,person) VALUES (''150112000000200'',''33670000000200'',''2013-09-18 08:26:43'',''Giustifico il ritardo di mio figlio 2 - la vendetta.'',''2360000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.messages SET message_text = ''text non esistente'' WHERE message = ''150112000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.messages WHERE message = ''150112000000200'';', 1);

-- messages_read
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.messages_read WHERE message_read = ''60304000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.messages_read(message_read,message,person,read_on) VALUES (''160304000000200'',''50113000000200'',''2363000000200'',''2013-09-17 09:26:43'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.messages_read SET read_on = ''2013-09-19 09:11:43'' WHERE message_read = ''160304000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.messages_read WHERE message_read = ''160304000000200'';', 1);

-- serve per eliminare il record inserito dagli altri utenti
  IF _group = ANY(ARRAY['scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative']) THEN
    _results = _results || unit_tests_security.check_statement_enabled('unit_testing_supervisor@scuola.it','scuola247_supervisor', ARRAY['scuola247_supervisor'], 'DELETE FROM public.messages_read WHERE message_read = ''160304000000200'';', 1);
  END IF;

-- metrics
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.metrics WHERE metric = ''11436000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.metrics(metric,school,description,sufficiency) VALUES (''111436000000200'',''2000000200'',''Esadecimale'',''360'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.metrics SET description = ''descrizione non esistente'' WHERE metric = ''111436000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.metrics WHERE metric = ''111436000000200'';', 1);

-- notes
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.notes WHERE note = ''104925000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES (''1104925000000200'',''2358000000200'',''Esempio di una nota disciplinare 2.'',''2362000000200'',''t'',''2013-10-21'',''09:00:00'',''t'',''10062000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.notes SET description = ''descrizione non esistente'' WHERE note = ''1104925000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.notes WHERE note = ''1104925000000200'';', 1);

-- notes_signed  -- sequenza diversa
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.notes_signed(person,note) VALUES (''2361000000200'',''119211000000200'');', 1); -- inserite automaticamente dal trigger quando una nota viene creata
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.notes_signed WHERE note = ''119211000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.notes_signed SET on_date = ''2013-10-25 11:39:00'' WHERE note = ''119211000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.notes_signed WHERE note = ''119211000000200'';', 1); 

-- out_of_classrooms
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.out_of_classrooms WHERE out_of_classroom = ''98577000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES (''198577000000200'',''2362000000200'',''per selezioni sportive calcio'',''2013-10-21'',''08:00:00'',''12:00:00'',''10246000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.out_of_classrooms SET description = ''descrizione non esistente'' WHERE out_of_classroom = ''198577000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.out_of_classrooms WHERE out_of_classroom = ''198577000000200'';', 1);

-- parents_meetings
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT person FROM public.parents_meetings WHERE parents_meeting = ''33433000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee','scuola247_relative'], 'INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES (''133433000000200'',''2362000000200'',''2361000000200'',''2013-10-21 00:00:00'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee','scuola247_relative'], 'UPDATE public.parents_meetings SET on_date = ''2013-11-11 00:00:00'' WHERE parents_meeting = ''133433000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee','scuola247_relative'], 'DELETE FROM public.parents_meetings WHERE parents_meeting = ''133433000000200'';', 1);

-- persons
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons WHERE person = ''2358000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES (''12358000000200'',''Alvise'',''Bertani'',''1999-05-05'',NULL,''201000000100'',''BRTLVS99E05Z252G'',''M'',''2000000200'',NULL,''L781'',NULL,NULL,NULL,NULL,''758438000000100'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.persons SET name = ''nome non esistente'' WHERE person = ''12358000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.persons WHERE person = ''12358000000200'';', 1);

-- persons_addresses
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons_addresses WHERE person_address = ''16765000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'INSERT INTO public.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES (''116765000000200'',''2358000000200'',''Domicile'',''Via G. Segantini 86'',''37069'',''L949'',''758438000000100'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'UPDATE public.persons_addresses SET street = ''Via non esistente'' WHERE person_address = ''116765000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'DELETE FROM public.persons_addresses WHERE person_address = ''116765000000200'';', 1);

-- persons_relations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons_relations WHERE person_relation = ''27915000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.persons_relations(person_relation,person,person_related_to,sign_request,relationship,can_do_explanation) VALUES (''127915000000200'',''1032000000200'',''2360000000200'',''f'',''Tutor'',''t'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.persons_relations SET relationship = ''Parent'' WHERE person_relation = ''127915000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.persons_relations WHERE person_relation = ''127915000000200'';', 1);

-- persons_roles
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.persons_roles WHERE person_role = ''156239000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.persons_roles(person_role,person,role) VALUES (''1156239000000200'',''2361000000200'',''Teacher'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.persons_roles SET role = ''Executive'' WHERE person_role = ''1156239000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.persons_roles WHERE person_role = ''1156239000000200'';', 1);

-- qualifications
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.qualifications WHERE qualification = ''95977000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES (''195977000000200'',''2000000200'',''Padroneggiare gli strumenti espressivi 2'',''Padroneggiare gli strumenti espressivi ed argomentativi necessari per gestire l’interazione comunicativa verbale in vari contesti'',''11436000000200'',''Expertise'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.qualifications SET description = ''descrizione non esistente'' WHERE qualification = ''195977000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.qualifications WHERE qualification = ''195977000000200'';', 1);

-- qualifications_plan
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.qualifications_plan WHERE  qualification_plan = ''128989000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.qualifications_plan(qualification_plan,qualification,degree,course_year,subject) VALUES (''1128989000000200'',''95978000000200'',''9947000000200'',''1'',''29107000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.qualifications_plan SET course_year = ''2'' WHERE  qualification_plan = ''1128989000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.qualifications_plan WHERE  qualification_plan = ''1128989000000200'';', 1);

  -- regions
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.regions WHERE region = ''1000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.regions(region,description,geographical_area) VALUES (''11000000100'',''Piemont test'',''North-west'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.regions SET description = ''descrizione non esistente'' WHERE region = ''11000000100'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.regions WHERE region = ''11000000100'';', 1);

-- school_years
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.school_years WHERE school_year = 244000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO school_years (school_year, school, description, duration, lessons_duration) VALUES (1244000000200, 2000000200, ''2014/2015'', ''[2014-09-11,2015-09-11)'', ''[2014-09-11,2015-06-08)'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.school_years SET description = ''sede non esistente'' WHERE school_year = 1244000000200;', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.school_years WHERE school_year = 1244000000200;', 1);

-- schools
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.schools WHERE school = ''2000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (12000000200, ''Istituto Tecnico Tecnologico "Leonardo da Vinci21"'', ''AZITT00001'', ''ITT DAVINCI21'', true, NULL, NULL);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.schools SET description = ''descrizione non esistente'' WHERE school = ''12000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.schools WHERE school = ''12000000200'';', 1);

-- signatures
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.signatures WHERE signature = ''33773000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'INSERT INTO public.signatures(signature,classroom,teacher,on_date,at_time) VALUES (''133773000000200'',''10062000000200'',''2362000000200'',''2013-10-25'',''09:43:57'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'UPDATE public.signatures SET at_time = ''09:45:57'' WHERE signature = ''133773000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher','scuola247_employee'], 'DELETE FROM public.signatures WHERE signature = ''133773000000200'';', 1);

-- subjects
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.subjects WHERE subject = ''29105000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.subjects(subject,school,description) VALUES (''129105000000200'',''2000000200'',''materia'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.subjects SET description = ''materia 2 - la vendetta'' WHERE subject = ''129105000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.subjects WHERE subject = ''129105000000200'';', 1);

-- teachears_notes
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.teachears_notes WHERE teacher_notes = ''61764000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES (''161764000000200'',''2358000000200'',''alunno con difficoltÃ  nello apprendimento 2'',''2362000000200'',''2013-10-25'',NULL,''10062000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.teachears_notes SET description = ''descrizione'' WHERE teacher_notes = ''161764000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.teachears_notes WHERE teacher_notes = ''161764000000200'';', 1);

-- topics
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.topics WHERE topic = ''33242000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES (''133242000000200'',''29105000000200'',''descrizione'',''1'',''9947000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.topics SET description = ''descrizione 2'' WHERE topic = ''133242000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.topics WHERE topic = ''133242000000200'';', 1);


-- usenames_schools -- sequenza diversa
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.usenames_schools(usename,school) VALUES (''test_unit_special_testing_user@scuola_2000000200.it'',''2000000200'');', 1);
  
  IF _group = ANY(ARRAY['scuola247_supervisor']) THEN
    _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], format('SELECT 1 from public.usenames_schools WHERE usename = %L;', _usename), 2);
  ELSEIF _group = ANY(ARRAY['scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative']) THEN
    _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], format('SELECT 1 from public.usenames_schools WHERE usename = %L;', _usename), 1);
  ELSE
    RAISE WARNING 'role %I non ha eseguito SELECT 1 from public.usenames_schools WHERE usename = %L;',_usename,_usename;
  END IF;  
  
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.usenames_schools SET school = ''2000000300'' WHERE usename = ''test_unit_special_testing_user@scuola_2000000200.it'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.usenames_schools WHERE usename = ''test_unit_special_testing_user@scuola_2000000200.it'';', 1);

-- serve ad inserire il record eliminato dagli altri utenti per table usenames_schools
  IF _group = ANY(ARRAY['scuola247_supervisor']) THEN
    _results = _results || unit_tests_security.check_statement_enabled('unit_testing_supervisor@scuola.it','scuola247_supervisor', ARRAY['scuola247_supervisor'], 'INSERT INTO public.usenames_schools(usename,school) VALUES (''test_unit_special_testing_user@scuola_2000000200.it'',''2000000200'');', 1);
  END IF;  


-- usenames_ex  -- sequenza diversa
  -- controllo colonna non token
    -- utente uguale a _usename
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], format('SELECT 1 from public.usenames_ex WHERE usename = %L;', _usename), 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], format('UPDATE public.usenames_ex SET language = ''de'' WHERE usename = %L;', _usename), 1);

  -- controllo colonna token
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'SELECT token FROM public.usenames_ex WHERE usename = ''test_unit_special_testing_user@scuola_2000000200.it'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.usenames_ex SET token = ''999999999999999999999'' WHERE usename = ''test_unit_special_testing_user@scuola_2000000200.it'';', 1);

  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.usenames_ex WHERE usename = ''test_unit_special_testing_user@scuola_2000000200.it'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.usenames_ex(usename,token,language) VALUES (''test_unit_special_testing_user@scuola_2000000200.it'',''888888888888888888888888'',''it'');', 1);


-- valutations
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.valutations WHERE valutation = ''86813000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES (''186813000000200'',''29105000000200'',''46299000000200'',''33242000000200'',''29094000000200'',NULL,''f'',''3836000000200'',''2013-12-04'',NULL,''10246000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.valutations SET on_date = ''2013-10-17'' WHERE valutation = ''186813000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.valutations WHERE valutation = ''186813000000200'';', 1);

-- valutations_qualifications
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.valutations_qualifications WHERE valutation_qualificationtion = ''107038000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES (''1107038000000200'',''86814000000200'',''95977000000200'',''29086000000200'',''Esempio di nota associata ad una qualifica'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'UPDATE public.valutations_qualifications SET note = ''nota non esistente'' WHERE valutation_qualificationtion = ''1107038000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_teacher'], 'DELETE FROM public.valutations_qualifications WHERE valutation_qualificationtion = ''1107038000000200'';', 1);

-- weekly_timetables
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.weekly_timetables WHERE weekly_timetable = ''51386000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.weekly_timetables(weekly_timetable,classroom,description) VALUES (''151386000000200'',''10062000000200'',''descrizione'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.weekly_timetables SET description = ''descrizione modificata'' WHERE weekly_timetable = ''151386000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.weekly_timetables WHERE weekly_timetable = ''151386000000200'';', 1);

-- weekly_timetables_days
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.weekly_timetables_days WHERE weekly_timetable_day = ''33008000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES (''133008000000200'',''51386000000200'',''2'',''2362000000200'',''29105000000200'',''1'',''08:00:00'',''09:00:00'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'UPDATE public.weekly_timetables_days SET to_time = ''10:00:00'' WHERE weekly_timetable_day = ''133008000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee'], 'DELETE FROM public.weekly_timetables_days WHERE weekly_timetable_day = ''133008000000200'';', 1);

-- wikimedia_files -- mancante
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.wikimedia_files WHERE wikimedia_file = ''301735000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.wikimedia_files(name, type, wikimedia_file, info) VALUES (''Photo_portrait'', ''Male portrait'', ''1301735000000200'', NULL);', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.wikimedia_files SET type = ''Female portrait'' WHERE wikimedia_file = ''1301735000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.wikimedia_files WHERE wikimedia_file = ''1301735000000200'';', 1);

-- wikimedia_files_persons
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor', 'scuola247_executive','scuola247_employee', 'scuola247_teacher', 'scuola247_student','scuola247_relative'], 'SELECT 1 from public.wikimedia_files_persons WHERE wikimedia_file_person = ''329668000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'INSERT INTO public.wikimedia_files_persons(wikimedia_file_person, wikimedia_file, person) VALUES (''1329668000000200'', ''301735000000200'', ''2359000000200'');', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'UPDATE public.wikimedia_files_persons SET person = ''1032000000200'' WHERE wikimedia_file_person = ''1329668000000200'';', 1);
  _results = _results || unit_tests_security.check_statement_enabled(_usename,_group, ARRAY['scuola247_supervisor'], 'DELETE FROM public.wikimedia_files_persons WHERE wikimedia_file_person = ''1329668000000200'';', 1);

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.check_user_group_role(text, text)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_user_group_role(text, text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_user_group_role(text, text) TO scuola247_user;
REVOKE ALL ON FUNCTION unit_tests_security.check_user_group_role(text, text) FROM public;
