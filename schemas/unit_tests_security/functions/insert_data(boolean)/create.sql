-- Function: unit_tests_public.absences(boolean)

-- DROP FUNCTION unit_tests_public.absences(boolean);

CREATE OR REPLACE FUNCTION unit_tests_security.insert_data(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name    text;
  test_name     text = '';
  error         diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert'); 
    RETURN;
  END IF;

  -----------------------------------
  test_name = 'INSERT security data';
  -----------------------------------
  BEGIN
    -- comuni a tutti gli istituti per le prove
    INSERT INTO public.countries(country,description,existing,processing_code) VALUES ('201000000100','(test) BELGIO (test)','t','9201');

    INSERT INTO public.regions(region,description,geographical_area) VALUES ('1000000100','Piemonte (test)','North-west');

    INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('Z1','(test) Torino (test)','1000000100','758321000000100');

    INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('001','(test) Airasca (test)','758321000000100','758438000000100');


    -- primo istituto
    INSERT INTO public.schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (2000000200, 'Istituto Tecnico Tecnologico "Leonardo da Vinci22"', 'AZITT2000Z', 'ITT DAVINCI22', true, NULL, NULL);

    INSERT INTO public.branches (branch, school, description) VALUES (9954000000200, 2000000200, 'Filiale Borgo Roma');

    INSERT INTO public.degrees (degree, school, description, course_years) VALUES (9947000000200, 2000000200, 'Informatica', 5);

    -- Student
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2358000000200','Gabriel','Tiberi','1996-05-18',NULL,201000000100,'TBRGBR96E58L781M','F','2000000200',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2359000000200','Iris','Micillo','1997-08-22',NULL,201000000100,'MCLRSI70C64L781E','F','2000000200',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('1032000000200','Zaccaria','Firenze','2003-02-19',NULL,201000000100,'FRNZCC03B59L781A','F','2000000200',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');

    -- Relative
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2360000000200','Angelo','Cunego','1970-03-24',NULL,201000000100,'CNGNGL05M22L781J','M','2000000200','3590542000000200','L781',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2361000000200','Filippo','Bragantini','1951-07-11',NULL,201000000100,'BRGFPP51L11M018D','M','2000000200',NULL,'M018',NULL,NULL,NULL,NULL,'758438000000100');
    -- Teacher
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2362000000200','Enrico','Bonometti','1951-01-25',NULL,201000000100,'BNMNRC51A25H703L','M','2000000200',NULL,'H703',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('3836000000200','Sandra','Iorillo','1977-02-03',NULL,201000000100,'RLLSND77B43L781F','F','2000000200',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    -- Employee
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2363000000200','Anthea','Bortolasi','1974-08-14',NULL,201000000100,'BRTNTH74M54L781Y','F','2000000200',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    -- Executive
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2364000000200','Giuseppe Lorenzo','Braga','1953-07-09',NULL,201000000100,'BRGGPP53L09I594G','M','2000000200',NULL,'I594',NULL,NULL,NULL,NULL,'758438000000100');

    INSERT INTO public.school_years (school_year, school, description, duration, lessons_duration) VALUES (244000000200, 2000000200, '2013/2014', '[2013-09-11,2014-09-11)', '[2013-09-11,2014-06-08)');

    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10062000000200','244000000200','9947000000200','C','1','Superiori 1C','9954000000200');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10063000000200','244000000200','9947000000200','C','2','Superiori 2C','9954000000200');


    INSERT INTO public.persons_relations(person_relation,person,person_related_to,sign_request,relationship,can_do_explanation) VALUES ('27915000000200','2358000000200','2360000000200','f','Tutor','t');
    INSERT INTO public.persons_relations(person_relation,person,person_related_to,sign_request,relationship,can_do_explanation) VALUES ('27932000000200','2359000000200','2361000000200','f','Tutor','t');

    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156239000000200','2358000000200','Student');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156240000000200','2359000000200','Student');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156247000000200','1032000000200','Student');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156241000000200','2360000000200','Relative');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156242000000200','2361000000200','Relative');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156243000000200','2362000000200','Teacher');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156244000000200','2363000000200','Employee');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156245000000200','2364000000200','Executive');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156246000000200','3836000000200','Teacher');

    INSERT INTO public.subjects(subject,school,description) VALUES ('29105000000200','2000000200','Italiano');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29106000000200','2000000200','Informatica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29107000000200','2000000200','Condotta');    

    INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES ('10246000000200','10062000000200','2358000000200',NULL,NULL);
    INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES ('10247000000200','10062000000200','2359000000200',NULL,NULL);

    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57313000000200','2358000000200','uscita in anticipo per motivi personali','2013-10-23 10:44:59','2362000000200','2013-10-23 10:44:59','2363000000200','2013-10-23','2013-10-23',NULL,'11:30:30','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57319000000200','2358000000200','entrata in ritardo per traffico','2013-10-24 10:32:08','2362000000200','2013-10-25 10:32:08','2363000000200','2013-10-24','2013-10-24',NULL,'11:48:48','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57325000000200','2358000000200','assenza per motivi familiari','2013-10-25 10:05:08','2362000000200','2013-10-25 10:05:08','2363000000200','2013-10-25','2013-10-25',NULL,'11:51:51','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57318000000200','2358000000200','entrata in ritardo per malessere','2013-10-21 10:32:08','2362000000200','2013-10-25 10:32:08','2363000000200','2013-10-21','2013-10-21',NULL,'11:48:00','Leave'); -- da rimuovere
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57315000000200','2359000000200','uscita in anticipo per epistassi','2013-10-23 10:09:05','3836000000200','2013-10-24 10:09:05','2363000000200','2013-10-23','2013-10-23',NULL,'11:24:24','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57321000000200','2359000000200','entrata in ritardo per motivi personali','2013-10-25 10:03:21','3836000000200','2013-10-25 10:03:21','2363000000200','2013-10-25','2013-10-25',NULL,'11:38:38','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57327000000200','2359000000200','assenza per traffico','2013-10-24 10:26:08','3836000000200','2013-10-25 10:26:08','2363000000200','2013-10-24','2013-10-24',NULL,'11:39:39','Leave');

    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98581000000200','10062000000200','2013-10-23','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98582000000200','10062000000200','2013-10-23','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98583000000200','10062000000200','2013-10-23','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98584000000200','10062000000200','2013-10-23','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98585000000200','10062000000200','2013-10-23','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98586000000200','10062000000200','2013-10-24','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98587000000200','10062000000200','2013-10-24','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98588000000200','10062000000200','2013-10-24','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98589000000200','10062000000200','2013-10-24','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98590000000200','10062000000200','2013-10-24','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98591000000200','10062000000200','2013-10-25','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98592000000200','10062000000200','2013-10-25','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98593000000200','10062000000200','2013-10-25','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98594000000200','10062000000200','2013-10-25','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98595000000200','10062000000200','2013-10-25','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98596000000200','10062000000200','2013-10-22','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98597000000200','10062000000200','2013-10-22','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98598000000200','10062000000200','2013-10-22','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98599000000200','10062000000200','2013-10-22','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98600000000200','10062000000200','2013-10-22','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98601000000200','10062000000200','2013-10-21','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98602000000200','10062000000200','2013-10-21','29105000000200','2362000000200','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98603000000200','10062000000200','2013-10-21','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98604000000200','10062000000200','2013-10-21','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98605000000200','10062000000200','2013-10-21','29106000000200','3836000000200','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);

    INSERT INTO public.metrics(metric,school,description,sufficiency) VALUES ('11436000000200','2000000200','Decimale','600');

    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33312000000200','2013-10-25','2362000000200',NULL,'10246000000200');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33311000000200','2013-10-24','3836000000200',NULL,'10247000000200');

    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29078000000200','11436000000200','3/4','350','3Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29082000000200','11436000000200','4/5','450','4Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29086000000200','11436000000200','5/6','550','5Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29090000000200','11436000000200','6/7','650','6Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29094000000200','11436000000200','7/8','750','7Â½');

    INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES ('119537000000200','244000000200','2014-06-16','Scrutinio secondo quadrimestre','f');
    INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES ('119533000000200','244000000200','2014-01-16','Scrutinio primo quadrimestre','f');

    INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES ('33670000000200','10246000000200','Compiti in classe.','f',NULL,NULL);
    INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES ('33680000000200','10247000000200','Lezione di Oggi.','f',NULL,NULL);

    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46299000000200','Scritto','29105000000200','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46312000000200','Orale ','29105000000200','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46304000000200','Laboratorio','29106000000200','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46313000000200','Orale ','29106000000200','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46298000000200','Scritto','29106000000200','S');

    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130752000000200','119537000000200','29105000000200','29086000000200',NULL,'f','f',NULL,10246000000200);
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130753000000200','119533000000200','29106000000200','29090000000200','Esempio di una nota associata ad un voto di scrutinio','f','f',NULL,10246000000200);
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130754000000200','119537000000200','29105000000200','29090000000200',NULL,'f','f',NULL,10247000000200);
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130755000000200','119533000000200','29106000000200','29094000000200','Esempio di una nota associata ad un voto di scrutinio','f','f',NULL,10247000000200);

    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('104925000000200','2358000000200','Esempio di una nota disciplinare.','2362000000200','t','2013-10-24','09:00:00','t','10062000000200');
    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('119211000000200','2359000000200','Ha risposto in modo sgarbato alle domande dell''interrogazione','3836000000200','t','2013-10-23','09:18:37','t','10062000000200');

    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95977000000200','2000000200','Padroneggiare gli strumenti espressivi','Padroneggiare gli strumenti espressivi ed argomentativi indispensabili per gestire l’interazione comunicativa verbale in vari contesti','11436000000200','Expertise');
    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95978000000200','2000000200','Leggere, comprendere ed interpretare','Leggere, comprendere ed interpretare testi scritti di vario tipo','11436000000200','Expertise');
    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95979000000200','2000000200','Produrre testi di vario tipo in relazione','Produrre testi di vario tipo in relazione ai differenti scopi comunicativi','11436000000200','Expertise');
    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95980000000200','2000000200','Utilizzare una lingua straniera per','Utilizzare una lingua straniera per i principali scopi comunicativi ed operativi','11436000000200','Expertise');

    INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES ('33242000000200','29105000000200','Ugo Foscolo','1','9947000000200');
    INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES ('33243000000200','29106000000200','Database','1','9947000000200');

    INSERT INTO public.communication_types (communication_type, description, notification_management, school) VALUES (138016000000200,'email',TRUE,2000000200);
    INSERT INTO public.communication_types (communication_type, description, notification_management, school) VALUES (138017000000200,'SMS',TRUE,2000000200);

    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126109000000200','130752000000200','95977000000200','29078000000200','Esempio di una nota testuale a commento della valutazione della qualifica');
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000200','130753000000200','95978000000200','29090000000200',NULL);
--    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126111000000200','130754000000200','95979000000200','29094000000200','Esempio di una nota testuale a commento della valutazione della qualifica');
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126112000000200','130755000000200','95980000000200','29086000000200',NULL);

    INSERT INTO public.messages(message,conversation,written_on,message_text,person) VALUES ('50112000000200','33670000000200','2013-09-16 08:26:43','Giustifico il ritardo di mio figlio.','2360000000200');
    INSERT INTO public.messages(message,conversation,written_on,message_text,person) VALUES ('50113000000200','33680000000200','2013-09-17 08:24:52','Giustifico il ritardo di mio figlio.','2361000000200');

    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('86813000000200','29105000000200','46299000000200','33242000000200','29086000000200',NULL,'f','3836000000200','2013-12-06',NULL,'10246000000200');
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('86814000000200','29106000000200','46313000000200','33243000000200','29094000000200',NULL,'f','2362000000200','2013-12-16',NULL,'10247000000200');

    INSERT INTO public.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51386000000200','10062000000200','Settimana standard');

    INSERT INTO public.wikimedia_files(name,type,wikimedia_file,info) VALUES ('Portrait_photograph_of_a_man_in_academic_gown_n.d._(3197423872).jpg','Male portrait','301735000000200',NULL);
    INSERT INTO public.wikimedia_files(name,type,wikimedia_file,info) VALUES ('Gottlieb-Portrait_of_a_Man.jpg','Male portrait','301739000000200',NULL);

    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112027000000200','2358000000200','138016000000200','casa','Gabriel.Tiberi@example.org','t');
    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112028000000200','2359000000200','138017000000200','lavoro','+39 373 361165','t');
    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112029000000200','2360000000200','138016000000200','casa','Angelo.Cunego@example.org','t');
    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112030000000200','2361000000200','138017000000200','lavoro','+39 380 817057','t');

    INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('48854000000200','3836000000200','57319000000200','2013-10-24','08:16:21','10246000000200');
    INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('48855000000200','2362000000200','57321000000200','2013-10-25','08:42:35','10247000000200');

    INSERT INTO public.faults(fault,student,description,lesson,note) VALUES ('59632000000200','2358000000200','ha dimenticato il libro di testo','98581000000200',NULL);
    INSERT INTO public.faults(fault,student,description,lesson,note) VALUES ('59633000000200','2359000000200','non ha portato il quaderno','98583000000200',NULL);

    -- grading_meetings_close
    UPDATE public.grading_meetings gm SET closed = 't' WHERE gm.grading_meeting = '119533000000200';

    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11335000000200','2000000200','2013-01-01','Capodanno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11336000000200','2000000200','2013-01-06','Epifania');

    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('58393000000200','3836000000200','57313000000200','2013-10-23','11:52:52','10246000000200');
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('58394000000200','2362000000200','57315000000200','2013-10-23','11:59:59','10247000000200');

    INSERT INTO public.messages_read(message_read,message,person,read_on) VALUES ('60304000000200','50112000000200','2363000000200','2013-09-17 09:26:43');

    -- notes_signed
    UPDATE public.notes_signed ns SET on_date = '2014-06-09 10:39:00' WHERE ns.note = '104925000000200';

    INSERT INTO public.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES ('98577000000200','2362000000200','Olimpiadi di Informatica','2013-10-22','08:00:00','12:00:00','10247000000200');

    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33433000000200','2362000000200','2360000000200','2013-10-01 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33434000000200','3836000000200','2361000000200','2013-10-03 00:00:00');

    INSERT INTO public.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES ('16765000000200','2358000000200','Residence','Via G. Segantini 91','37069','L949','758438000000100');
    INSERT INTO public.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES ('52292000000200','2359000000200','Residence','Loc. Lener 51','37132','L781','758438000000100');

    -- schools_behavior
    UPDATE public.schools SET behavior = 29107000000200 WHERE school = 2000000200;

    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61764000000200','2358000000200','alunno con difficoltÃ  nell''apprendimento','2362000000200','2013-10-23',NULL,'10062000000200');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61776000000200','2359000000200','alunno con difficoltÃ  nell''apprendimento','3836000000200','2013-10-24',NULL,'10062000000200');

 --   INSERT INTO public.usenames_schools(usename_school, usename, school) VALUES (61889000000200, 'unit_testing_student_c@scuola_2.it', 2000000200);

    INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES ('107038000000200','86813000000200','95980000000200','29086000000200','Esempio di nota associata ad una qualifica');
 --   INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES ('107057000000200','86814000000200','95977000000200','29094000000200','Testo di esempio di una nota associabile alla qualifica');

    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33008000000200','51386000000200','1','2362000000200','29105000000200','1','08:00:00','09:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33009000000200','51386000000200','1','2362000000200','29105000000200','1','09:00:00','10:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33010000000200','51386000000200','1','3836000000200','29106000000200','1','10:00:00','11:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33011000000200','51386000000200','1','3836000000200','29106000000200','1','11:00:00','12:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33012000000200','51386000000200','1','3836000000200','29106000000200','1','12:00:00','13:00:00');

    INSERT INTO public.wikimedia_files_persons(wikimedia_file_person, wikimedia_file, person) VALUES ('329668000000200', '301735000000200', '2358000000200');

    INSERT INTO public.qualifications_plan(qualificationtion_plan,qualification,degree,course_year,subject) VALUES ('128989000000200','95977000000200','9947000000200','1','29105000000200');

    INSERT INTO public.signatures(signature,classroom,teacher,on_date,at_time) VALUES ('33773000000200','10062000000200','2362000000200','2013-10-22','09:47:57');


    -- secondo istituto
    INSERT INTO public.schools (school, description, processing_code, mnemonic, example, logo, behavior) VALUES (2000000300, 'Istituto Tecnico Tecnologico "Leonardo da Vinci23"', 'AZITT3000Z', 'ITT DAVINCI23', true, NULL, NULL);

    INSERT INTO public.branches (branch, school, description) VALUES (9954000000300, 2000000300, 'Filiale Borgo Roma');

    INSERT INTO public.degrees (degree, school, description, course_years) VALUES (9947000000300, 2000000300, 'Informatica', 5);

    -- Student
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2358000000300','Gabriel','Tiberi','1996-05-18',NULL,NULL,'TBRGBR96E58L781M','F','2000000300',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2359000000300','Iris','Micillo','1997-08-22',NULL,NULL,'MCLRSI70C64L781E','F','2000000300',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('1032000000300','Zaccaria','Firenze','2003-02-19',NULL,NULL,'FRNZCC03B59L781A','F','2000000300',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');

    -- Relative
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2360000000300','Angelo','Cunego','1970-03-24',NULL,NULL,'CNGNGL05M22L781J','M','2000000300','3590542000000300','L781',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2361000000300','Filippo','Bragantini','1951-07-11',NULL,NULL,'BRGFPP51L11M018D','M','2000000300',NULL,'M018',NULL,NULL,NULL,NULL,'758438000000100');
    -- Teacher
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2362000000300','Enrico','Bonometti','1951-01-25',NULL,NULL,'BNMNRC51A25H703L','M','2000000300',NULL,'H703',NULL,NULL,NULL,NULL,'758438000000100');
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('3836000000300','Sandra','Iorillo','1977-02-03',NULL,NULL,'RLLSND77B43L781F','F','2000000300',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    -- Employee
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2363000000300','Anthea','Bortolasi','1974-08-14',NULL,NULL,'BRTNTH74M54L781Y','F','2000000300',NULL,'L781',NULL,NULL,NULL,NULL,'758438000000100');
    -- Executive
    INSERT INTO public.persons(person,name,surname,born,deceased,country_of_birth,tax_code,sex,school,sidi,city_of_birth_fiscal_code,thumbnail,note,usename,photo,city_of_birth) VALUES ('2364000000300','Giuseppe Lorenzo','Braga','1953-07-09',NULL,NULL,'BRGGPP53L09I594G','M','2000000300',NULL,'I594',NULL,NULL,NULL,NULL,'758438000000100');

    INSERT INTO public.school_years (school_year, school, description, duration, lessons_duration) VALUES (244000000300, 2000000300, '2013/2014', '[2013-09-11,2014-09-11)', '[2013-09-11,2014-06-08)');

    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10062000000300','244000000300','9947000000300','C','1','Superiori 1C','9954000000300');
    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('10063000000300','244000000300','9947000000300','C','2','Superiori 2C','9954000000300');


    INSERT INTO public.persons_relations(person_relation,person,person_related_to,sign_request,relationship,can_do_explanation) VALUES ('27915000000300','2358000000300','2360000000300','f','Tutor','t');
    INSERT INTO public.persons_relations(person_relation,person,person_related_to,sign_request,relationship,can_do_explanation) VALUES ('27932000000300','2359000000300','2361000000300','f','Tutor','t');

    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156239000000300','2358000000300','Student');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156240000000300','2359000000300','Student');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156247000000300','1032000000300','Student');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156241000000300','2360000000300','Relative');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156242000000300','2361000000300','Relative');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156243000000300','2362000000300','Teacher');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156244000000300','2363000000300','Employee');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156245000000300','2364000000300','Executive');
    INSERT INTO public.persons_roles(person_role,person,role) VALUES ('156246000000300','3836000000300','Teacher');

    INSERT INTO public.subjects(subject,school,description) VALUES ('29105000000300','2000000300','Italiano');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29106000000300','2000000300','Informatica');
    INSERT INTO public.subjects(subject,school,description) VALUES ('29107000000300','2000000300','Condotta');    

    INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES ('10246000000300','10062000000300','2358000000300',NULL,NULL);
    INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES ('10247000000300','10062000000300','2359000000300',NULL,NULL);

    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57313000000300','2358000000300','uscita in anticipo per motivi personali','2013-10-23 10:44:59','2362000000300','2013-10-23 10:44:59','2363000000300','2013-10-23','2013-10-23',NULL,'11:30:30','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57319000000300','2358000000300','entrata in ritardo per traffico','2013-10-24 10:32:08','2362000000300','2013-10-25 10:32:08','2363000000300','2013-10-24','2013-10-24',NULL,'11:48:48','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57325000000300','2358000000300','assenza per motivi familiari','2013-10-25 10:05:08','2362000000300','2013-10-25 10:05:08','2363000000300','2013-10-25','2013-10-25',NULL,'11:51:51','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57318000000300','2358000000300','entrata in ritardo per malessere','2013-10-21 10:32:08','2362000000300','2013-10-25 10:32:08','2363000000300','2013-10-21','2013-10-21',NULL,'11:48:00','Leave'); -- da rimuovere
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57315000000300','2359000000300','uscita in anticipo per epistassi','2013-10-23 10:09:05','3836000000300','2013-10-24 10:09:05','2363000000300','2013-10-23','2013-10-23',NULL,'11:24:24','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57321000000300','2359000000300','entrata in ritardo per motivi personali','2013-10-25 10:03:21','3836000000300','2013-10-25 10:03:21','2363000000300','2013-10-25','2013-10-25',NULL,'11:38:38','Leave');
    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('57327000000300','2359000000300','assenza per traffico','2013-10-24 10:26:08','3836000000300','2013-10-25 10:26:08','2363000000300','2013-10-24','2013-10-24',NULL,'11:39:39','Leave');

    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98581000000300','10062000000300','2013-10-23','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98582000000300','10062000000300','2013-10-23','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98583000000300','10062000000300','2013-10-23','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98584000000300','10062000000300','2013-10-23','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98585000000300','10062000000300','2013-10-23','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98586000000300','10062000000300','2013-10-24','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98587000000300','10062000000300','2013-10-24','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98588000000300','10062000000300','2013-10-24','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98589000000300','10062000000300','2013-10-24','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98590000000300','10062000000300','2013-10-24','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98591000000300','10062000000300','2013-10-25','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98592000000300','10062000000300','2013-10-25','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98593000000300','10062000000300','2013-10-25','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98594000000300','10062000000300','2013-10-25','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98595000000300','10062000000300','2013-10-25','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98596000000300','10062000000300','2013-10-22','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98597000000300','10062000000300','2013-10-22','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98598000000300','10062000000300','2013-10-22','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98599000000300','10062000000300','2013-10-22','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98600000000300','10062000000300','2013-10-22','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98601000000300','10062000000300','2013-10-21','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98602000000300','10062000000300','2013-10-21','29105000000300','2362000000300','descrizione di esempio della lezione tenuta','f','09:00:00','10:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98603000000300','10062000000300','2013-10-21','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','10:00:00','11:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98604000000300','10062000000300','2013-10-21','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','11:00:00','12:00:00',NULL,NULL);
    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('98605000000300','10062000000300','2013-10-21','29106000000300','3836000000300','descrizione di esempio della lezione tenuta','f','12:00:00','13:00:00',NULL,NULL);


    INSERT INTO public.metrics(metric,school,description,sufficiency) VALUES ('11436000000300','2000000300','Decimale','600');

    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33312000000300','2013-10-25','2362000000300',NULL,'10246000000300');
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('33311000000300','2013-10-24','3836000000300',NULL,'10247000000300');

    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29078000000300','11436000000300','3/4','350','3Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29082000000300','11436000000300','4/5','450','4Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29086000000300','11436000000300','5/6','550','5Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29090000000300','11436000000300','6/7','650','6Â½');
    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('29094000000300','11436000000300','7/8','750','7Â½');

    INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES ('119537000000300','244000000300','2014-06-16','Scrutinio secondo quadrimestre','f');
    INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES ('119533000000300','244000000300','2014-01-16','Scrutinio primo quadrimestre','f');

    INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES ('33670000000300','10246000000300','Compiti in classe.','f',NULL,NULL);
    INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES ('33680000000300','10247000000300','Lezione di Oggi.','f',NULL,NULL);

    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46299000000300','Scritto','29105000000300','S');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46312000000300','Orale ','29105000000300','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46304000000300','Laboratorio','29106000000300','L');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46313000000300','Orale ','29106000000300','O');
    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('46298000000300','Scritto','29106000000300','S');

    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130752000000300','119537000000300','29105000000300','29086000000300',NULL,'f','f',NULL,10246000000300);
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130753000000300','119533000000300','29106000000300','29090000000300','Esempio di una nota associata ad un voto di scrutinio','f','f',NULL,10246000000300);
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130754000000300','119537000000300','29105000000300','29090000000300',NULL,'f','f',NULL,10247000000300);
    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,subject,grade,notes,lack_of_training,council_vote,teacher,classroom_student) VALUES ('130755000000300','119533000000300','29106000000300','29094000000300','Esempio di una nota associata ad un voto di scrutinio','f','f',NULL,10247000000300);

    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('104925000000300','2358000000300','Esempio di una nota disciplinare.','2362000000300','t','2013-10-24','09:00:00','t','10062000000300');
    INSERT INTO public.notes(note,student,description,teacher,disciplinary,on_date,at_time,to_approve,classroom) VALUES ('119211000000300','2359000000300','Ha risposto in modo sgarbato alle domande dell''interrogazione','3836000000300','t','2013-10-23','09:18:37','t','10062000000300');

    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95977000000300','2000000300','Padroneggiare gli strumenti espressivi','Padroneggiare gli strumenti espressivi ed argomentativi indispensabili per gestire l’interazione comunicativa verbale in vari contesti','11436000000300','Expertise');
    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95978000000300','2000000300','Leggere, comprendere ed interpretare','Leggere, comprendere ed interpretare testi scritti di vario tipo','11436000000300','Expertise');
    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95979000000300','2000000300','Produrre testi di vario tipo in relazione','Produrre testi di vario tipo in relazione ai differenti scopi comunicativi','11436000000300','Expertise');
    INSERT INTO public.qualifications(qualification,school,"name",description,metric,"type") VALUES ('95980000000300','2000000300','Utilizzare una lingua straniera per','Utilizzare una lingua straniera per i principali scopi comunicativi ed operativi','11436000000300','Expertise');

    INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES ('33242000000300','29105000000300','Ugo Foscolo','1','9947000000300');
    INSERT INTO public.topics(topic,subject,description,course_year,degree) VALUES ('33243000000300','29106000000300','Database','1','9947000000300');

    INSERT INTO public.communication_types(communication_type, description, notification_management, school) VALUES (138016000000300,'email',TRUE,2000000300);
    INSERT INTO public.communication_types(communication_type, description, notification_management, school) VALUES (138017000000300,'SMS',TRUE,2000000300);

    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126109000000300','130752000000300','95977000000300','29078000000300','Esempio di una nota testuale a commento della valutazione della qualifica');
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000300','130753000000300','95978000000300','29090000000300',NULL);
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126111000000300','130754000000300','95979000000300','29094000000300','Esempio di una nota testuale a commento della valutazione della qualifica');
    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126112000000300','130755000000300','95980000000300','29086000000300',NULL);

    INSERT INTO public.messages(message,conversation,written_on,message_text,person) VALUES ('50112000000300','33670000000300','2013-09-16 08:26:43','Giustifico il ritardo di mio figlio.','2360000000300');
    INSERT INTO public.messages(message,conversation,written_on,message_text,person) VALUES ('50113000000300','33680000000300','2013-09-17 08:24:52','Giustifico il ritardo di mio figlio.','2361000000300');

    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('86813000000300','29105000000300','46299000000300','33242000000300','29086000000300',NULL,'f','3836000000300','2013-12-06',NULL,'10246000000300');
    INSERT INTO public.valutations(valutation,subject,grade_type,topic,grade,evaluation,private,teacher,on_date,note,classroom_student) VALUES ('86814000000300','29106000000300','46313000000300','33243000000300','29094000000300',NULL,'f','2362000000300','2013-12-16',NULL,'10247000000300');

    INSERT INTO public.weekly_timetables(weekly_timetable,classroom,description) VALUES ('51386000000300','10062000000300','Settimana standard');

    INSERT INTO public.wikimedia_files(name,type,wikimedia_file,info) VALUES ('Portrait_photograph_of_a_man_in_academic_gown_n.d._(3197423872).jpg','Male portrait','301735000000300',NULL);
    INSERT INTO public.wikimedia_files(name,type,wikimedia_file,info) VALUES ('Gottlieb-Portrait_of_a_Man.jpg','Male portrait','301739000000300',NULL);

    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112027000000300','2358000000300','138016000000300','casa','Gabriel.Tiberi@example.org','t');
    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112028000000300','2359000000300','138017000000300','lavoro','+39 373 361165','t');
    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112029000000300','2360000000300','138016000000300','casa','Angelo.Cunego@example.org','t');
    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('112030000000300','2361000000300','138017000000300','lavoro','+39 380 817057','t');

    INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('48854000000300','3836000000300','57319000000300','2013-10-24','08:16:21','10246000000300');
    INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('48855000000300','2362000000300','57321000000300','2013-10-25','08:42:35','10247000000300');

    INSERT INTO public.faults(fault,student,description,lesson,note) VALUES ('59632000000300','2358000000300','ha dimenticato il libro di testo','98581000000300',NULL);
    INSERT INTO public.faults(fault,student,description,lesson,note) VALUES ('59633000000300','2359000000300','non ha portato il quaderno','98583000000300',NULL);

    -- grading_meetings_close
    UPDATE public.grading_meetings gm SET closed = 't' WHERE gm.grading_meeting = '119533000000300';

    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11335000000300','2000000300','2013-01-01','Capodanno');
    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('11336000000300','2000000300','2013-01-06','Epifania');

    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('58393000000300','3836000000300','57313000000300','2013-10-23','11:52:52','10246000000300');
    INSERT INTO public.leavings(leaving,teacher,explanation,on_date,at_time,classroom_student) VALUES ('58394000000300','2362000000300','57315000000300','2013-10-23','11:59:59','10247000000300');

    INSERT INTO public.messages_read(message_read,message,person,read_on) VALUES ('60304000000300','50112000000300','2363000000300','2013-09-17 09:26:43');

    -- notes_signed
    UPDATE public.notes_signed ns SET on_date = '2014-06-09 10:39:00' WHERE ns.note = '104925000000300';

    INSERT INTO public.out_of_classrooms(out_of_classroom,school_operator,description,on_date,from_time,to_time,classroom_student) VALUES ('98577000000300','2362000000300','Olimpiadi di Informatica','2013-10-22','08:00:00','12:00:00','10247000000300');

    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33433000000300','2362000000300','2360000000300','2013-10-01 00:00:00');
    INSERT INTO public.parents_meetings(parents_meeting,teacher,person,on_date) VALUES ('33434000000300','3836000000300','2361000000300','2013-10-03 00:00:00');

    INSERT INTO public.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES ('16765000000300','2358000000300','Residence','Via G. Segantini 91','37069','L949','758438000000100');
    INSERT INTO public.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES ('52292000000300','2359000000300','Residence','Loc. Lener 51','37132','L781','758438000000100');

    -- schools_behavior
    UPDATE public.schools SET behavior = 29107000000300 WHERE school = 2000000300;

    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61764000000300','2358000000300','alunno con difficoltÃ  nell''apprendimento','2362000000300','2013-10-23',NULL,'10062000000300');
    INSERT INTO public.teachears_notes(teacher_notes,student,description,teacher,on_date,at_time,classroom) VALUES ('61776000000300','2359000000300','alunno con difficoltÃ  nell''apprendimento','3836000000300','2013-10-24',NULL,'10062000000300');

 --   INSERT INTO public.usenames_schools(usename_school, usename, school) VALUES (61889000000300, 'unit_testing_student_d@scuola_2.it', 2000000300);

    INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES ('107038000000300','86813000000300','95980000000300','29086000000300','Esempio di nota associata ad una qualifica');
    INSERT INTO public.valutations_qualifications(valutation_qualificationtion,valutation,qualification,grade,note) VALUES ('107057000000300','86814000000300','95977000000300','29094000000300','Testo di esempio di una nota associabile alla qualifica');

    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33008000000300','51386000000300','1','2362000000300','29105000000300','1','08:00:00','09:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33009000000300','51386000000300','1','2362000000300','29105000000300','1','09:00:00','10:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33010000000300','51386000000300','1','3836000000300','29106000000300','1','10:00:00','11:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33011000000300','51386000000300','1','3836000000300','29106000000300','1','11:00:00','12:00:00');
    INSERT INTO public.weekly_timetables_days(weekly_timetable_day,weekly_timetable,weekday,teacher,subject,team_teaching,from_time,to_time) VALUES ('33012000000300','51386000000300','1','3836000000300','29106000000300','1','12:00:00','13:00:00');

    INSERT INTO public.wikimedia_files_persons(wikimedia_file_person, wikimedia_file, person) VALUES ('329668000000300', '301735000000300', '2358000000300');

    INSERT INTO public.qualifications_plan(qualificationtion_plan,qualification,degree,course_year,subject) VALUES ('128989000000300','95977000000300','9947000000300','1','29105000000300');

    INSERT INTO public.signatures(signature,classroom,teacher,on_date,at_time) VALUES ('33773000000300','10062000000300','2362000000300','2013-10-22','09:47:57');


    _results = _results || assert.pass(full_function_name, test_name);

    EXCEPTION
       WHEN OTHERS THEN
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.absences FAILED'::text, error);
       RETURN;
  END;
  RETURN;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.insert_data(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_security.insert_data(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.insert_data(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.insert_data(boolean) TO scuola247_user;
