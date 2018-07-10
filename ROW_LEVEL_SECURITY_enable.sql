  ALTER TABLE schools ENABLE ROW LEVEL SECURITY;
--ALTER TABLE schools DISABLE ROW LEVEL SECURITY;

  ALTER TABLE school_years ENABLE ROW LEVEL SECURITY;
--ALTER TABLE school_years DISABLE ROW LEVEL SECURITY;

  ALTER TABLE branches ENABLE ROW LEVEL SECURITY;
--ALTER TABLE branches DISABLE ROW LEVEL SECURITY;

  ALTER TABLE classrooms ENABLE ROW LEVEL SECURITY;
--ALTER TABLE classrooms DISABLE ROW LEVEL SECURITY;

  ALTER TABLE classrooms_students ENABLE ROW LEVEL SECURITY;
--ALTER TABLE classrooms_students DISABLE ROW LEVEL SECURITY;

  ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
--ALTER TABLE lessons DISABLE ROW LEVEL SECURITY;

  ALTER TABLE absences ENABLE ROW LEVEL SECURITY;
--ALTER TABLE absences DISABLE ROW LEVEL SECURITY;

  ALTER TABLE delays ENABLE ROW LEVEL SECURITY;
--ALTER TABLE delays DISABLE ROW LEVEL SECURITY;

  ALTER TABLE valutations ENABLE ROW LEVEL SECURITY;
--ALTER TABLE valutations DISABLE ROW LEVEL SECURITY;

  ALTER TABLE communication_types ENABLE ROW LEVEL SECURITY;
--ALTER TABLE communication_types DISABLE ROW LEVEL SECURITY;

  ALTER TABLE communications_media ENABLE ROW LEVEL SECURITY;
--ALTER TABLE communications_media DISABLE ROW LEVEL SECURITY;

  ALTER TABLE conversations ENABLE ROW LEVEL SECURITY;
--ALTER TABLE conversations DISABLE ROW LEVEL SECURITY;

  ALTER TABLE degrees ENABLE ROW LEVEL SECURITY;
--ALTER TABLE degrees DISABLE ROW LEVEL SECURITY;

  ALTER TABLE explanations ENABLE ROW LEVEL SECURITY;
--ALTER TABLE explanations DISABLE ROW LEVEL SECURITY;

  ALTER TABLE faults ENABLE ROW LEVEL SECURITY;
--ALTER TABLE faults DISABLE ROW LEVEL SECURITY;

  ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
--ALTER TABLE subjects DISABLE ROW LEVEL SECURITY;

  ALTER TABLE grade_types ENABLE ROW LEVEL SECURITY;
--ALTER TABLE grade_types DISABLE ROW LEVEL SECURITY;

  ALTER TABLE grades ENABLE ROW LEVEL SECURITY;
--ALTER TABLE grades DISABLE ROW LEVEL SECURITY;

  ALTER TABLE metrics ENABLE ROW LEVEL SECURITY;
--ALTER TABLE metrics DISABLE ROW LEVEL SECURITY;

  ALTER TABLE grading_meetings ENABLE ROW LEVEL SECURITY;
--ALTER TABLE grading_meetings DISABLE ROW LEVEL SECURITY;

  ALTER TABLE grading_meetings_valutations ENABLE ROW LEVEL SECURITY;
--ALTER TABLE grading_meetings_valutations DISABLE ROW LEVEL SECURITY;

  ALTER TABLE grading_meetings_valutations_qua ENABLE ROW LEVEL SECURITY;
--ALTER TABLE grading_meetings_valutations_qua DISABLE ROW LEVEL SECURITY;

  ALTER TABLE holidays ENABLE ROW LEVEL SECURITY;
--ALTER TABLE holidays DISABLE ROW LEVEL SECURITY;

  ALTER TABLE leavings ENABLE ROW LEVEL SECURITY;
--ALTER TABLE leavings DISABLE ROW LEVEL SECURITY;

  ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
--ALTER TABLE messages DISABLE ROW LEVEL SECURITY;

  ALTER TABLE messages_read ENABLE ROW LEVEL SECURITY;
--ALTER TABLE messages_read DISABLE ROW LEVEL SECURITY;

  ALTER TABLE notes ENABLE ROW LEVEL SECURITY;
--ALTER TABLE notes DISABLE ROW LEVEL SECURITY;

  ALTER TABLE notes_signed ENABLE ROW LEVEL SECURITY;
--ALTER TABLE notes_signed DISABLE ROW LEVEL SECURITY;

  ALTER TABLE out_of_classrooms ENABLE ROW LEVEL SECURITY;
--ALTER TABLE out_of_classrooms DISABLE ROW LEVEL SECURITY;

 ALTER TABLE parents_meetings ENABLE ROW LEVEL SECURITY;
--ALTER TABLE parents_meetings DISABLE ROW LEVEL SECURITY;

  ALTER TABLE persons_addresses ENABLE ROW LEVEL SECURITY;
--ALTER TABLE persons_addresses DISABLE ROW LEVEL SECURITY;

  ALTER TABLE persons_relations ENABLE ROW LEVEL SECURITY;
--ALTER TABLE persons_relations DISABLE ROW LEVEL SECURITY;

  ALTER TABLE persons_roles ENABLE ROW LEVEL SECURITY;
--ALTER TABLE persons_roles DISABLE ROW LEVEL SECURITY;

  ALTER TABLE qualifications ENABLE ROW LEVEL SECURITY;
--ALTER TABLE qualifications DISABLE ROW LEVEL SECURITY;

  ALTER TABLE qualifications_plan ENABLE ROW LEVEL SECURITY;
--ALTER TABLE qualifications_plan DISABLE ROW LEVEL SECURITY;

  ALTER TABLE signatures ENABLE ROW LEVEL SECURITY;
--ALTER TABLE signatures DISABLE ROW LEVEL SECURITY;

  ALTER TABLE teachears_notes ENABLE ROW LEVEL SECURITY;
--ALTER TABLE teachears_notes DISABLE ROW LEVEL SECURITY;

  ALTER TABLE topics ENABLE ROW LEVEL SECURITY;
--ALTER TABLE topics DISABLE ROW LEVEL SECURITY;

  ALTER TABLE valutations_qualifications ENABLE ROW LEVEL SECURITY;
--ALTER TABLE valutations_qualifications DISABLE ROW LEVEL SECURITY;

  ALTER TABLE weekly_timetables ENABLE ROW LEVEL SECURITY;
--ALTER TABLE weekly_timetables DISABLE ROW LEVEL SECURITY;

  ALTER TABLE weekly_timetables_days ENABLE ROW LEVEL SECURITY;
--ALTER TABLE weekly_timetables_days DISABLE ROW LEVEL SECURITY;

  ALTER TABLE usenames_ex ENABLE ROW LEVEL SECURITY;
--ALTER TABLE usenames_ex DISABLE ROW LEVEL SECURITY;

  ALTER TABLE usenames_schools ENABLE ROW LEVEL SECURITY;
--ALTER TABLE usenames_schools DISABLE ROW LEVEL SECURITY;

  DROP POLICY usenames_ex_pl_usename ON usenames_ex;
CREATE POLICY usenames_ex_pl_usename ON usenames_ex TO public 
 USING (usename = current_user)
  WITH CHECK (usename = current_user);

  DROP POLICY usenames_ex_pl_supervisor ON usenames_ex;
CREATE POLICY usenames_ex_pl_supervisor ON usenames_ex TO scuola247_supervisor 
 USING (TRUE)
  WITH CHECK (TRUE);

  DROP POLICY usenames_schools_pl_usename ON usenames_schools;
CREATE POLICY usenames_schools_pl_usename ON usenames_schools TO public 
 USING (usename = current_user)
  WITH CHECK (usename = current_user);

  DROP POLICY schools_pl_school ON schools; 
CREATE POLICY schools_pl_school ON schools TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));
 
 DROP POLICY branches_pl_school ON branches; 
CREATE POLICY branches_pl_school ON branches TO public  
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));
  
  DROP POLICY school_years_pl_school ON school_years;
CREATE POLICY school_years_pl_school ON school_years TO public
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY communication_types_pl_school ON communication_types;
CREATE POLICY communication_types_pl_school ON communication_types TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY degrees_pl_school ON degrees;
CREATE POLICY degrees_pl_school ON degrees TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));
  
  DROP POLICY communications_media_pl_communication_type ON communications_media;
CREATE POLICY communications_media_pl_communication_type ON communications_media TO public 
 USING (communication_type IN (SELECT communication_type FROM communication_types))
  WITH CHECK (communication_type IN ( SELECT communication_type FROM communication_types ) );
  
  DROP POLICY classrooms_pl_school_year ON classrooms; 
CREATE POLICY classrooms_pl_school_year ON classrooms TO public 
 USING (school_year IN (SELECT school_year FROM school_years))
  WITH CHECK (school_year IN (SELECT school_year FROM school_years));

  DROP POLICY classrooms_students_pl_classroom ON classrooms_students; 
CREATE POLICY classrooms_students_pl_classroom ON classrooms_students TO public 
 USING (classroom IN (SELECT classroom FROM classrooms))
  WITH CHECK (classroom IN (SELECT classroom FROM classrooms));

  DROP POLICY lessons_pl_classroom ON lessons; 
CREATE POLICY lessons_pl_classroom ON lessons TO public 
 USING (classroom IN (SELECT classroom FROM classrooms))
  WITH CHECK (classroom IN (SELECT classroom FROM classrooms));

  DROP POLICY absences_pl_classroom_student ON absences ;
CREATE POLICY absences_pl_classroom_student ON absences TO public 
 USING (classroom_student IN (SELECT classroom_student FROM classrooms_students))
  WITH CHECK (classroom_student IN (SELECT classroom_student FROM classrooms_students)); 

  DROP POLICY delays_pl_classroom_student ON delays; 
CREATE POLICY delays_pl_classroom_student ON delays TO public 
 USING (classroom_student IN (SELECT classroom_student FROM classrooms_students))
  WITH CHECK (classroom_student IN (SELECT classroom_student FROM classrooms_students)); 

  DROP POLICY valutations_pl_classroom_student ON valutations; 
CREATE POLICY valutations_pl_classroom_student ON valutations TO public 
 USING (classroom_student IN (SELECT classroom_student FROM classrooms_students))
  WITH CHECK (classroom_student IN (SELECT classroom_student FROM classrooms_students)); 

  DROP POLICY conversations_pl_classroom_student ON conversations; 
CREATE POLICY conversations_pl_classroom_student ON conversations TO public 
 USING (classroom_student IN (SELECT classroom_student FROM classrooms_students))
  WITH CHECK (classroom_student IN (SELECT classroom_student FROM classrooms_students)); 

  DROP POLICY conversations_invites_pl_conversationt ON conversations_invites; 
CREATE POLICY conversations_invites_pl_conversationt ON conversations_invites TO public 
 USING (conversation IN (SELECT conversation FROM conversations))
  WITH CHECK (conversation IN (SELECT conversation FROM conversations)); 

  DROP POLICY explanations_pl_student ON explanations;
CREATE POLICY explanations_pl_student ON explanations TO public 
 USING (student IN (SELECT person FROM persons))
  WITH CHECK (student IN (SELECT person FROM persons)); 
  
  DROP POLICY persons_pl_school ON persons; 
CREATE POLICY persons_pl_school ON persons TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY faults_pl_lessons ON faults; 
CREATE POLICY faults_pl_lessons ON faults TO public 
 USING (lesson IN (SELECT lesson FROM lessons))
  WITH CHECK (lesson IN (SELECT lesson FROM lessons));

  DROP POLICY subjects_pl_school ON subjects; 
CREATE POLICY subjects_pl_school ON subjects TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY grade_types_pl_subject ON grade_types;
CREATE POLICY grade_types_pl_subject ON grade_types TO public 
 USING (subject IN (SELECT subject FROM subjects))
  WITH CHECK (subject IN (SELECT subject FROM subjects));

  DROP POLICY grades_pl_metric ON grades;
CREATE POLICY grades_pl_metric ON grades TO public 
 USING (metric IN (SELECT metric FROM metrics))
  WITH CHECK (metric IN (SELECT metric FROM metrics));
  
  DROP POLICY metrics_pl_school ON metrics; 
CREATE POLICY metrics_pl_school ON metrics TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY grading_meetings_pl_school_year ON grading_meetings; 
CREATE POLICY grading_meetings_pl_school_year ON grading_meetings TO public 
 USING (school_year IN (SELECT school_year FROM school_years))
  WITH CHECK (school_year IN (SELECT school_year FROM school_years));

  DROP POLICY grading_meetings_valutations_pl_grading_meeting ON grading_meetings_valutations;
CREATE POLICY grading_meetings_valutations_pl_grading_meeting ON grading_meetings_valutations TO public 
 USING (grading_meeting IN (SELECT grading_meeting FROM grading_meetings))
  WITH CHECK (grading_meeting IN (SELECT grading_meeting FROM grading_meetings));

  DROP POLICY grading_meetings_valutations_qua_pl_grading_meeting_valutation ON grading_meetings_valutations_qua; 
CREATE POLICY grading_meetings_valutations_qua_pl_grading_meeting_valutation ON grading_meetings_valutations_qua TO public 
 USING (grading_meeting_valutation IN (SELECT grading_meeting_valutation FROM grading_meetings_valutations))
  WITH CHECK (grading_meeting_valutation IN (SELECT grading_meeting_valutation FROM grading_meetings_valutations));

  DROP POLICY holidays_pl_school ON holidays; 
CREATE POLICY holidays_pl_school ON holidays TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY leavings_pl_classroom_student ON leavings; 
CREATE POLICY leavings_pl_classroom_student ON leavings TO public 
 USING (classroom_student IN (SELECT classroom_student FROM classrooms_students))
  WITH CHECK (classroom_student IN (SELECT classroom_student FROM classrooms_students)); 

  DROP POLICY messages_pl_conversation ON messages; 
CREATE POLICY messages_pl_conversation ON messages TO public 
 USING (conversation IN (SELECT conversation FROM conversations))
  WITH CHECK (conversation IN (SELECT conversation FROM conversations)); 
  
  DROP POLICY messages_read_pl_conversation ON messages_read; 
CREATE POLICY messages_read_pl_conversation ON messages_read TO public 
 USING (message IN (SELECT message FROM messages))
  WITH CHECK (message IN (SELECT message FROM messages)); 

  DROP POLICY notes_pl_teacher ON notes; 
CREATE POLICY notes_pl_teacher ON notes TO public 
 USING (teacher IN (SELECT person FROM persons))
  WITH CHECK (teacher IN (SELECT person FROM persons)); 

  DROP POLICY notes_signed_pl_note ON notes_signed;
CREATE POLICY notes_signed_pl_note ON notes_signed TO public 
 USING (note IN (SELECT note FROM notes))
  WITH CHECK (note IN (SELECT note FROM notes)); 

  DROP POLICY out_of_classrooms_pl_classroom_student ON out_of_classrooms;
CREATE POLICY out_of_classrooms_pl_classroom_student ON out_of_classrooms TO public 
 USING (classroom_student IN (SELECT classroom_student FROM classrooms_students))
  WITH CHECK (classroom_student IN (SELECT classroom_student FROM classrooms_students)); 

  DROP POLICY parents_meetings_pl_teacher ON parents_meetings;
CREATE POLICY parents_meetings_pl_teacher ON parents_meetings TO public 
 USING (teacher IN (SELECT person FROM persons))
  WITH CHECK (teacher IN (SELECT person FROM persons)); 

  DROP POLICY persons_addresses_pl_person ON persons_addresses;
CREATE POLICY persons_addresses_pl_person ON persons_addresses TO public 
 USING (person IN (SELECT person FROM persons))
  WITH CHECK (person IN (SELECT person FROM persons)); 

  DROP POLICY persons_relations_pl_person ON persons_relations;
CREATE POLICY persons_relations_pl_person ON persons_relations TO public 
 USING (person IN ( SELECT person FROM persons ) )
  WITH CHECK (person IN ( SELECT person FROM persons ) ); 

  DROP POLICY persons_roles_pl_person ON persons_roles;
CREATE POLICY persons_roles_pl_person ON persons_roles TO public 
 USING (person IN (SELECT person FROM persons))
  WITH CHECK (person IN (SELECT person FROM persons)); 

  DROP POLICY qualifications_pl_school ON qualifications;
CREATE POLICY qualifications_pl_school ON qualifications TO public 
 USING (school IN (SELECT school FROM usenames_schools))
  WITH CHECK (school IN (SELECT school FROM usenames_schools));

  DROP POLICY qualifications_plan_pl_qualification ON qualifications_plan;
CREATE POLICY qualifications_plan_pl_qualification ON qualifications_plan TO public 
 USING (qualification IN (SELECT qualification FROM qualifications))
  WITH CHECK (qualification IN (SELECT qualification FROM qualifications));  

  DROP POLICY signatures_pl_classroom ON signatures; 
CREATE POLICY signatures_pl_classroom ON signatures TO public 
 USING (classroom IN (SELECT classroom FROM classrooms))
  WITH CHECK (classroom IN (SELECT classroom FROM classrooms));  

  DROP POLICY teachears_notes_pl_teacher ON teachears_notes; 
CREATE POLICY teachears_notes_pl_teacher ON teachears_notes TO public 
 USING (teacher IN (SELECT person FROM persons))
  WITH CHECK (teacher IN (SELECT person FROM persons));   

  DROP POLICY topics_pl_subject ON topics;
CREATE POLICY topics_pl_subject ON topics TO public 
 USING (subject IN (SELECT subject FROM subjects))
  WITH CHECK (subject IN (SELECT subject FROM subjects));  

  DROP POLICY valutations_qualifications_pl_valutation ON valutations_qualifications;
CREATE POLICY valutations_qualifications_pl_valutation ON valutations_qualifications TO public 
 USING (valutation IN (SELECT valutation FROM valutations))
  WITH CHECK (valutation IN (SELECT valutation FROM valutations));   

  DROP POLICY weekly_timetables_pl_classroom ON weekly_timetables;
CREATE POLICY weekly_timetables_pl_classroom ON weekly_timetables TO public 
 USING (classroom IN (SELECT classroom FROM classrooms))
  WITH CHECK (classroom IN (SELECT classroom FROM classrooms));

  DROP POLICY weekly_timetables_days_pl_weekly_timetable ON weekly_timetables_days;
CREATE POLICY weekly_timetables_days_pl_weekly_timetable ON weekly_timetables_days TO public 
 USING (weekly_timetable IN ( SELECT weekly_timetable FROM weekly_timetables ) )
  WITH CHECK (weekly_timetable IN ( SELECT weekly_timetable FROM weekly_timetables ) );
