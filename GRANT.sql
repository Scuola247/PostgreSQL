/*
 SCUOLA247 SICUREZZA VERTICALE
*/;
REVOKE scuola247_employee FROM scuola247_user;
REVOKE scuola247_executive FROM scuola247_user;
REVOKE scuola247_relative FROM scuola247_user;
REVOKE scuola247_student FROM scuola247_user;
REVOKE scuola247_teacher FROM scuola247_user;
REVOKE scuola247_supervisor FROM scuola247_user;

REVOKE scuola247_user FROM scuola247_employee;
REVOKE scuola247_executive FROM scuola247_employee;
REVOKE scuola247_relative FROM scuola247_employee;
REVOKE scuola247_student FROM scuola247_employee;
REVOKE scuola247_teacher FROM scuola247_employee;
REVOKE scuola247_supervisor FROM scuola247_employee;

REVOKE scuola247_user FROM scuola247_executive;
REVOKE scuola247_employee FROM scuola247_executive;
REVOKE scuola247_relative FROM scuola247_executive;
REVOKE scuola247_student FROM scuola247_executive;
REVOKE scuola247_teacher FROM scuola247_executive;
REVOKE scuola247_supervisor FROM scuola247_executive;

REVOKE scuola247_user FROM scuola247_relative;
REVOKE scuola247_employee FROM scuola247_relative;
REVOKE scuola247_executive FROM scuola247_relative;
REVOKE scuola247_student FROM scuola247_relative;
REVOKE scuola247_teacher FROM scuola247_relative;
REVOKE scuola247_supervisor FROM scuola247_relative;

REVOKE scuola247_user FROM scuola247_student;
REVOKE scuola247_employee FROM scuola247_student;
REVOKE scuola247_executive FROM scuola247_student;
REVOKE scuola247_relative FROM scuola247_student;
REVOKE scuola247_teacher FROM scuola247_student;
REVOKE scuola247_supervisor FROM scuola247_student;

REVOKE scuola247_user FROM scuola247_teacher;
REVOKE scuola247_employee FROM scuola247_teacher;
REVOKE scuola247_executive FROM scuola247_teacher;
REVOKE scuola247_relative FROM scuola247_teacher;
REVOKE scuola247_student FROM scuola247_teacher;
REVOKE scuola247_supervisor FROM scuola247_teacher;

REVOKE scuola247_user FROM scuola247_supervisor;
REVOKE scuola247_employee FROM scuola247_supervisor;
REVOKE scuola247_executive FROM scuola247_supervisor;
REVOKE scuola247_relative FROM scuola247_supervisor;
REVOKE scuola247_student FROM scuola247_supervisor;
REVOKE scuola247_teacher FROM scuola247_supervisor;
REVOKE scuola247_supervisor FROM scuola247_supervisor;

GRANT scuola247_user TO scuola247_employee;
GRANT scuola247_user TO scuola247_executive;
GRANT scuola247_user TO scuola247_teacher;
GRANT scuola247_user TO scuola247_relative;
GRANT scuola247_user TO scuola247_student;
GRANT scuola247_employee TO scuola247_supervisor;
GRANT scuola247_executive TO scuola247_supervisor;
GRANT scuola247_relative TO scuola247_supervisor;
GRANT scuola247_student TO scuola247_supervisor;
GRANT scuola247_teacher TO scuola247_supervisor;
GRANT scuola247_user TO scuola247_supervisor;

REVOKE ALL ON DATABASE scuola247 FROM public;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_supervisor;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_executive;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_employee;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_teacher;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_relative;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_student;
REVOKE ALL ON DATABASE scuola247 FROM scuola247_user;

GRANT ALL ON DATABASE scuola247 TO scuola247_supervisor WITH GRANT OPTION;
GRANT CONNECT ON DATABASE scuola247 TO scuola247_user;

GRANT ALL ON LANGUAGE plpgsql TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON LANGUAGE plpgsql TO scuola247_user;

/* GRANT SU TUTTI I SCHEMA */;
-- ASSERT;
REVOKE ALL ON SCHEMA assert FROM public;
REVOKE ALL ON SCHEMA assert FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA assert FROM scuola247_executive;
REVOKE ALL ON SCHEMA assert FROM scuola247_employee;
REVOKE ALL ON SCHEMA assert FROM scuola247_teacher;
REVOKE ALL ON SCHEMA assert FROM scuola247_relative;
REVOKE ALL ON SCHEMA assert FROM scuola247_student;
REVOKE ALL ON SCHEMA assert FROM scuola247_user;

GRANT ALL ON SCHEMA assert TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA assert TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA assert TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA assert TO scuola247_user;

-- DATASETS;
REVOKE ALL ON SCHEMA datasets FROM public;
REVOKE ALL ON SCHEMA datasets FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA datasets FROM scuola247_executive;
REVOKE ALL ON SCHEMA datasets FROM scuola247_employee;
REVOKE ALL ON SCHEMA datasets FROM scuola247_teacher;
REVOKE ALL ON SCHEMA datasets FROM scuola247_relative;
REVOKE ALL ON SCHEMA datasets FROM scuola247_student;
REVOKE ALL ON SCHEMA datasets FROM scuola247_user;

GRANT ALL ON SCHEMA datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA datasets TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA datasets TO scuola247_user;

GRANT ALL ON ALL SEQUENCES IN SCHEMA datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA datasets TO scuola247_user;

-- DIAGNOSTIC;
REVOKE ALL ON SCHEMA diagnostic FROM public;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_executive;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_employee;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_teacher;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_relative;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_student;
REVOKE ALL ON SCHEMA diagnostic FROM scuola247_user;

GRANT ALL ON SCHEMA diagnostic TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA diagnostic TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA diagnostic TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA diagnostic TO scuola247_user;

GRANT ALL ON TYPE diagnostic.error TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON TYPE diagnostic.error TO scuola247_user;

GRANT ALL ON TYPE diagnostic.verbosities TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON TYPE diagnostic.verbosities TO scuola247_user;

-- GIT;
REVOKE ALL ON SCHEMA git FROM public;
REVOKE ALL ON SCHEMA git FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA git FROM scuola247_executive;
REVOKE ALL ON SCHEMA git FROM scuola247_employee;
REVOKE ALL ON SCHEMA git FROM scuola247_teacher;
REVOKE ALL ON SCHEMA git FROM scuola247_relative;
REVOKE ALL ON SCHEMA git FROM scuola247_student;
REVOKE ALL ON SCHEMA git FROM scuola247_user;

GRANT ALL ON SCHEMA git TO scuola247_supervisor WITH GRANT OPTION;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA git TO scuola247_supervisor WITH GRANT OPTION;

GRANT ALL ON TYPE git.options TO scuola247_supervisor WITH GRANT OPTION;

-- PUBLIC;
REVOKE ALL ON SCHEMA public FROM public;
REVOKE ALL ON SCHEMA public FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA public FROM scuola247_executive;
REVOKE ALL ON SCHEMA public FROM scuola247_employee;
REVOKE ALL ON SCHEMA public FROM scuola247_teacher;
REVOKE ALL ON SCHEMA public FROM scuola247_relative;
REVOKE ALL ON SCHEMA public FROM scuola247_student;
REVOKE ALL ON SCHEMA public FROM scuola247_user;

GRANT ALL ON SCHEMA public TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA public TO scuola247_user;

GRANT ALL ON DOMAIN public.course_year TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN public.mime_type_image TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN public.period_lesson TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN public.week TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN public.week_day TO scuola247_supervisor WITH GRANT OPTION;

GRANT USAGE ON DOMAIN public.course_year TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN public.mime_type_image TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN public.period_lesson TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN public.week TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN public.week_day TO scuola247_user WITH GRANT OPTION;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO scuola247_user;

GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO scuola247_user;

REVOKE ALL ON TABLE public.cities FROM scuola247_executive;
GRANT SELECT ON TABLE public.cities TO scuola247_executive;

GRANT ALL ON TYPE public.address_type TO scuola247_supervisor;
GRANT ALL ON TYPE public.explanation_type TO scuola247_supervisor;
GRANT ALL ON TYPE public.file_extension TO scuola247_supervisor;
GRANT ALL ON TYPE public.gbtreekey16 TO scuola247_supervisor;
GRANT ALL ON TYPE public.gbtreekey32 TO scuola247_supervisor;
GRANT ALL ON TYPE public.gbtreekey4 TO scuola247_supervisor;
GRANT ALL ON TYPE public.gbtreekey8 TO scuola247_supervisor;
GRANT ALL ON TYPE public.gbtreekey_var TO scuola247_supervisor;
GRANT ALL ON TYPE public.geographical_area TO scuola247_supervisor;
GRANT ALL ON TYPE public.image TO scuola247_supervisor;
GRANT ALL ON TYPE public.language TO scuola247_supervisor;
GRANT ALL ON TYPE public.marital_status TO scuola247_supervisor;
GRANT ALL ON TYPE public.mime_type TO scuola247_supervisor;
GRANT ALL ON TYPE public.relationships TO scuola247_supervisor;
GRANT ALL ON TYPE public.role TO scuola247_supervisor;
GRANT ALL ON TYPE public.sex TO scuola247_supervisor;
GRANT ALL ON TYPE public.wikimedia_type TO scuola247_supervisor;

GRANT USAGE ON TYPE public.address_type TO scuola247_user;
GRANT USAGE ON TYPE public.explanation_type TO scuola247_user;
GRANT USAGE ON TYPE public.file_extension TO scuola247_user;
GRANT USAGE ON TYPE public.gbtreekey16 TO scuola247_user;
GRANT USAGE ON TYPE public.gbtreekey32 TO scuola247_user;
GRANT USAGE ON TYPE public.gbtreekey4 TO scuola247_user;
GRANT USAGE ON TYPE public.gbtreekey8 TO scuola247_user;
GRANT USAGE ON TYPE public.gbtreekey_var TO scuola247_user;
GRANT USAGE ON TYPE public.geographical_area TO scuola247_user;
GRANT USAGE ON TYPE public.image TO scuola247_user;
GRANT USAGE ON TYPE public.language TO scuola247_user;
GRANT USAGE ON TYPE public.marital_status TO scuola247_user;
GRANT USAGE ON TYPE public.mime_type TO scuola247_user;
GRANT USAGE ON TYPE public.relationships TO scuola247_user;
GRANT USAGE ON TYPE public.role TO scuola247_user;
GRANT USAGE ON TYPE public.sex TO scuola247_user;
GRANT USAGE ON TYPE public.wikimedia_type TO scuola247_user;

-- absences
GRANT ALL ON TABLE public.absences TO scuola247_supervisor;
GRANT ALL ON TABLE public.absences TO scuola247_executive;
GRANT ALL ON TABLE public.absences TO scuola247_teacher;

GRANT SELECT ON TABLE public.absences TO scuola247_employee;
GRANT SELECT ON TABLE public.absences TO scuola247_student;
GRANT SELECT ON TABLE public.absences TO scuola247_relative;

REVOKE ALL ON TABLE public.absences FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- branches
GRANT ALL ON TABLE public.branches TO scuola247_supervisor;
GRANT ALL ON TABLE public.branches TO scuola247_executive;
GRANT ALL ON TABLE public.branches TO scuola247_employee;

GRANT SELECT ON TABLE public.branches TO scuola247_teacher;
GRANT SELECT ON TABLE public.branches TO scuola247_student;
GRANT SELECT ON TABLE public.branches TO scuola247_relative;

REVOKE ALL ON TABLE public.branches FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- cities
GRANT ALL ON TABLE public.cities TO scuola247_supervisor;

GRANT SELECT ON TABLE public.cities TO scuola247_executive;
GRANT SELECT ON TABLE public.cities TO scuola247_employee;
GRANT SELECT ON TABLE public.cities TO scuola247_teacher;
GRANT SELECT ON TABLE public.cities TO scuola247_student;
GRANT SELECT ON TABLE public.cities TO scuola247_relative;

REVOKE ALL ON TABLE public.cities FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- classrooms
GRANT ALL ON TABLE public.classrooms TO scuola247_supervisor;
GRANT ALL ON TABLE public.classrooms TO scuola247_executive;
GRANT ALL ON TABLE public.classrooms TO scuola247_employee;

GRANT SELECT ON TABLE public.classrooms TO scuola247_teacher;
GRANT SELECT ON TABLE public.classrooms TO scuola247_student;
GRANT SELECT ON TABLE public.classrooms TO scuola247_relative;

REVOKE ALL ON TABLE public.classrooms FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- classrooms_students
GRANT ALL ON TABLE public.classrooms_students TO scuola247_supervisor;
GRANT ALL ON TABLE public.classrooms_students TO scuola247_executive;
GRANT ALL ON TABLE public.classrooms_students TO scuola247_employee;

GRANT SELECT ON TABLE public.classrooms_students TO scuola247_teacher;
GRANT SELECT ON TABLE public.classrooms_students TO scuola247_student;
GRANT SELECT ON TABLE public.classrooms_students TO scuola247_relative;

REVOKE ALL ON TABLE public.classrooms_students FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- communication_types
GRANT ALL ON TABLE public.communication_types TO scuola247_supervisor;
GRANT ALL ON TABLE public.communication_types TO scuola247_executive;
GRANT ALL ON TABLE public.communication_types TO scuola247_employee;

GRANT SELECT ON TABLE public.communication_types TO scuola247_teacher;
GRANT SELECT ON TABLE public.communication_types TO scuola247_student;
GRANT SELECT ON TABLE public.communication_types TO scuola247_relative;

REVOKE ALL ON TABLE public.communication_types FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- communications_media
GRANT ALL ON TABLE public.communications_media TO scuola247_supervisor;
GRANT ALL ON TABLE public.communications_media TO scuola247_executive;
GRANT ALL ON TABLE public.communications_media TO scuola247_employee;
GRANT ALL ON TABLE public.communications_media TO scuola247_teacher;
GRANT ALL ON TABLE public.communications_media TO scuola247_student;
GRANT ALL ON TABLE public.communications_media TO scuola247_relative;

REVOKE ALL ON TABLE public.communications_media FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- conversations
GRANT ALL ON TABLE public.conversations TO scuola247_supervisor;
GRANT ALL ON TABLE public.conversations TO scuola247_executive;
GRANT ALL ON TABLE public.conversations TO scuola247_employee;
GRANT ALL ON TABLE public.conversations TO scuola247_teacher;
GRANT ALL ON TABLE public.conversations TO scuola247_student;
GRANT ALL ON TABLE public.conversations TO scuola247_relative;

REVOKE ALL ON TABLE public.conversations FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- conversations_invites
GRANT ALL ON TABLE public.conversations_invites TO scuola247_supervisor;
GRANT ALL ON TABLE public.conversations_invites TO scuola247_executive;
GRANT ALL ON TABLE public.conversations_invites TO scuola247_employee;
GRANT ALL ON TABLE public.conversations_invites TO scuola247_teacher;
GRANT ALL ON TABLE public.conversations_invites TO scuola247_student;
GRANT ALL ON TABLE public.conversations_invites TO scuola247_relative;

REVOKE ALL ON TABLE public.conversations_invites FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- countries
GRANT ALL ON TABLE public.countries TO scuola247_supervisor;

GRANT SELECT ON TABLE public.countries TO scuola247_executive;
GRANT SELECT ON TABLE public.countries TO scuola247_employee;
GRANT SELECT ON TABLE public.countries TO scuola247_teacher;
GRANT SELECT ON TABLE public.countries TO scuola247_student;
GRANT SELECT ON TABLE public.countries TO scuola247_relative;

REVOKE ALL ON TABLE public.countries FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- degrees
GRANT ALL ON TABLE public.degrees TO scuola247_supervisor;
GRANT ALL ON TABLE public.degrees TO scuola247_executive;
GRANT ALL ON TABLE public.degrees TO scuola247_employee;

GRANT SELECT ON TABLE public.degrees TO scuola247_teacher;
GRANT SELECT ON TABLE public.degrees TO scuola247_student;
GRANT SELECT ON TABLE public.degrees TO scuola247_relative;

REVOKE ALL ON TABLE public.degrees FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- delays
GRANT ALL ON TABLE public.delays TO scuola247_supervisor;
GRANT ALL ON TABLE public.delays TO scuola247_executive;
GRANT ALL ON TABLE public.delays TO scuola247_employee;
GRANT ALL ON TABLE public.delays TO scuola247_teacher;

GRANT SELECT ON TABLE public.delays TO scuola247_student;
GRANT SELECT ON TABLE public.delays TO scuola247_relative;

REVOKE ALL ON TABLE public.delays FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- districts
GRANT ALL ON TABLE public.districts TO scuola247_supervisor;

GRANT SELECT ON TABLE public.districts TO scuola247_executive;
GRANT SELECT ON TABLE public.districts TO scuola247_employee;
GRANT SELECT ON TABLE public.districts TO scuola247_teacher;
GRANT SELECT ON TABLE public.districts TO scuola247_student;
GRANT SELECT ON TABLE public.districts TO scuola247_relative;

REVOKE ALL ON TABLE public.districts FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

GRANT ALL ON TABLE public.explanations TO scuola247_supervisor;
GRANT ALL ON TABLE public.explanations TO scuola247_executive;
GRANT ALL ON TABLE public.explanations TO scuola247_employee;
GRANT ALL ON TABLE public.explanations TO scuola247_teacher;

GRANT SELECT ON TABLE public.explanations TO scuola247_relative;
GRANT SELECT ON TABLE public.explanations TO scuola247_student;

REVOKE ALL ON TABLE public.explanations FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.faults TO scuola247_supervisor;
GRANT ALL ON TABLE public.faults TO scuola247_executive;
GRANT ALL ON TABLE public.faults TO scuola247_employee;
GRANT ALL ON TABLE public.faults TO scuola247_teacher;

GRANT SELECT ON TABLE public.faults TO scuola247_student;
GRANT SELECT ON TABLE public.faults TO scuola247_relative;

REVOKE ALL ON TABLE public.faults FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.grade_types TO scuola247_supervisor;
GRANT ALL ON TABLE public.grade_types TO scuola247_executive;
GRANT ALL ON TABLE public.grade_types TO scuola247_teacher;
GRANT ALL ON TABLE public.grade_types TO scuola247_employee;

GRANT SELECT ON TABLE public.grade_types TO scuola247_relative;
GRANT SELECT ON TABLE public.grade_types TO scuola247_student;

REVOKE ALL ON TABLE public.grade_types FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.grades TO scuola247_supervisor;
GRANT ALL ON TABLE public.grades TO scuola247_executive;
GRANT ALL ON TABLE public.grades TO scuola247_teacher;

GRANT SELECT ON TABLE public.grades TO scuola247_employee;
GRANT SELECT ON TABLE public.grades TO scuola247_student;
GRANT SELECT ON TABLE public.grades TO scuola247_relative;

REVOKE ALL ON TABLE public.grades FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.grading_meetings TO scuola247_supervisor;
GRANT ALL ON TABLE public.grading_meetings TO scuola247_executive;
GRANT ALL ON TABLE public.grading_meetings TO scuola247_employee;

GRANT SELECT ON TABLE public.grading_meetings TO scuola247_teacher;
GRANT SELECT ON TABLE public.grading_meetings TO scuola247_student;
GRANT SELECT ON TABLE public.grading_meetings TO scuola247_relative;

REVOKE ALL ON TABLE public.grading_meetings FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.grading_meetings_valutations TO scuola247_supervisor;
GRANT ALL ON TABLE public.grading_meetings_valutations TO scuola247_executive;
GRANT ALL ON TABLE public.grading_meetings_valutations TO scuola247_teacher;
GRANT ALL ON TABLE public.grading_meetings_valutations TO scuola247_employee;


GRANT SELECT ON TABLE public.grading_meetings_valutations TO scuola247_relative;
GRANT SELECT ON TABLE public.grading_meetings_valutations TO scuola247_student;

REVOKE ALL ON TABLE public.grading_meetings_valutations FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.grading_meetings_valutations_qua TO scuola247_supervisor;
GRANT ALL ON TABLE public.grading_meetings_valutations_qua TO scuola247_executive;
GRANT ALL ON TABLE public.grading_meetings_valutations_qua TO scuola247_teacher;

GRANT SELECT ON TABLE public.grading_meetings_valutations_qua TO scuola247_employee;
GRANT SELECT ON TABLE public.grading_meetings_valutations_qua TO scuola247_relative;
GRANT SELECT ON TABLE public.grading_meetings_valutations_qua TO scuola247_student;

REVOKE ALL ON TABLE public.grading_meetings_valutations_qua FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.holidays TO scuola247_supervisor;
GRANT ALL ON TABLE public.holidays TO scuola247_executive;
GRANT ALL ON TABLE public.holidays TO scuola247_employee;

GRANT SELECT ON TABLE public.holidays TO scuola247_teacher;
GRANT SELECT ON TABLE public.holidays TO scuola247_relative;
GRANT SELECT ON TABLE public.holidays TO scuola247_student;

REVOKE ALL ON TABLE public.holidays FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.leavings TO scuola247_supervisor;
GRANT ALL ON TABLE public.leavings TO scuola247_executive;
GRANT ALL ON TABLE public.leavings TO scuola247_employee;
GRANT ALL ON TABLE public.leavings TO scuola247_teacher;

GRANT SELECT ON TABLE public.leavings TO scuola247_student;
GRANT SELECT ON TABLE public.leavings TO scuola247_relative;

REVOKE ALL ON TABLE public.leavings FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.lessons TO scuola247_supervisor;
GRANT ALL ON TABLE public.lessons TO scuola247_executive;
GRANT ALL ON TABLE public.lessons TO scuola247_teacher;

GRANT SELECT ON TABLE public.lessons TO scuola247_employee;
GRANT SELECT ON TABLE public.lessons TO scuola247_student;
GRANT SELECT ON TABLE public.lessons TO scuola247_relative;

REVOKE ALL ON TABLE public.lessons FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.messages TO scuola247_supervisor;
GRANT ALL ON TABLE public.messages TO scuola247_executive;
GRANT ALL ON TABLE public.messages TO scuola247_employee;
GRANT ALL ON TABLE public.messages TO scuola247_teacher;
GRANT ALL ON TABLE public.messages TO scuola247_student;
GRANT ALL ON TABLE public.messages TO scuola247_relative;

REVOKE ALL ON TABLE public.messages FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.messages_read TO scuola247_supervisor;

GRANT SELECT, INSERT ON TABLE public.messages_read TO scuola247_executive;
GRANT SELECT, INSERT ON TABLE public.messages_read TO scuola247_employee;
GRANT SELECT, INSERT ON TABLE public.messages_read TO scuola247_teacher;
GRANT SELECT, INSERT ON TABLE public.messages_read TO scuola247_student;
GRANT SELECT, INSERT ON TABLE public.messages_read TO scuola247_relative;

REVOKE ALL ON TABLE public.messages_read FROM public;
------------------------------------------------------
------------------------------------------------------
GRANT ALL ON TABLE public.metrics TO scuola247_supervisor;
GRANT ALL ON TABLE public.metrics TO scuola247_executive;
GRANT ALL ON TABLE public.metrics TO scuola247_employee;

GRANT SELECT ON TABLE public.metrics TO scuola247_teacher;
GRANT SELECT ON TABLE public.metrics TO scuola247_student;
GRANT SELECT ON TABLE public.metrics TO scuola247_relative;

REVOKE ALL ON TABLE public.metrics FROM public;

--Vertical security
GRANT ALL ON TABLE public.notes TO scuola247_supervisor;
GRANT ALL ON TABLE public.notes TO scuola247_executive;
GRANT ALL ON TABLE public.notes TO scuola247_employee;
GRANT ALL ON TABLE public.notes TO scuola247_teacher;

GRANT SELECT ON TABLE public.notes TO scuola247_student;
GRANT SELECT ON TABLE public.notes TO scuola247_relative;

REVOKE ALL ON TABLE public.notes FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.notes_signed TO scuola247_supervisor;
GRANT ALL ON TABLE public.notes_signed TO scuola247_executive;
GRANT ALL ON TABLE public.notes_signed TO scuola247_employee;
GRANT ALL ON TABLE public.notes_signed TO scuola247_relative;
GRANT ALL ON TABLE public.notes_signed TO scuola247_teacher;
GRANT ALL ON TABLE public.notes_signed TO scuola247_student;

REVOKE ALL ON TABLE public.notes_signed FROM public;
----------------------------------------------------------------
----------------------------------------------------------------

GRANT ALL ON TABLE public.out_of_classrooms TO scuola247_supervisor;
GRANT ALL ON TABLE public.out_of_classrooms TO scuola247_executive;
GRANT ALL ON TABLE public.out_of_classrooms TO scuola247_employee;
GRANT ALL ON TABLE public.out_of_classrooms TO scuola247_teacher;

GRANT SELECT ON TABLE public.out_of_classrooms TO scuola247_student;
GRANT SELECT ON TABLE public.out_of_classrooms TO scuola247_relative;

REVOKE ALL ON TABLE public.out_of_classrooms FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.parents_meetings TO scuola247_supervisor;
GRANT ALL ON TABLE public.parents_meetings TO scuola247_executive;
GRANT ALL ON TABLE public.parents_meetings TO scuola247_employee;
GRANT ALL ON TABLE public.parents_meetings TO scuola247_teacher;
GRANT ALL ON TABLE public.parents_meetings TO scuola247_relative;

/* date grant alla sola colonna person */
GRANT SELECT ON TABLE public.parents_meetings TO scuola247_student;

REVOKE ALL ON TABLE public.parents_meetings FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.persons TO scuola247_supervisor;
GRANT ALL ON TABLE public.persons TO scuola247_executive;
GRANT ALL ON TABLE public.persons TO scuola247_employee;
GRANT ALL ON TABLE public.persons TO scuola247_teacher;

GRANT SELECT ON TABLE public.persons TO scuola247_student;
GRANT SELECT ON TABLE public.persons TO scuola247_relative;

REVOKE ALL ON TABLE public.persons FROM public;
----------------------------------------------------------------
---------------------------------------------------------------
GRANT ALL ON TABLE public.persons_addresses TO scuola247_supervisor;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_executive;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_employee;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_student;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_relative;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_student;

REVOKE ALL ON TABLE public.persons_addresses FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.persons_relations TO scuola247_supervisor;
GRANT ALL ON TABLE public.persons_relations TO scuola247_executive;
GRANT ALL ON TABLE public.persons_relations TO scuola247_employee;

GRANT SELECT ON TABLE public.persons_relations TO scuola247_teacher;
GRANT SELECT ON TABLE public.persons_relations TO scuola247_student;
GRANT SELECT ON TABLE public.persons_relations TO scuola247_relative;

REVOKE ALL ON TABLE public.persons_relations FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.persons_roles TO scuola247_supervisor;
GRANT ALL ON TABLE public.persons_roles TO scuola247_executive;
GRANT ALL ON TABLE public.persons_roles TO scuola247_employee;

GRANT SELECT ON TABLE public.persons_roles TO scuola247_teacher;
GRANT SELECT ON TABLE public.persons_roles TO scuola247_student;
GRANT SELECT ON TABLE public.persons_roles TO scuola247_relative;

REVOKE ALL ON TABLE public.persons_roles FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.qualifications TO scuola247_supervisor;
GRANT ALL ON TABLE public.qualifications TO scuola247_executive;
GRANT ALL ON TABLE public.qualifications TO scuola247_employee;

GRANT SELECT ON TABLE public.qualifications TO scuola247_teacher;
GRANT SELECT ON TABLE public.qualifications TO scuola247_student;
GRANT SELECT ON TABLE public.qualifications TO scuola247_relative;

REVOKE ALL ON TABLE public.qualifications FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.qualifications_plan TO scuola247_supervisor;
GRANT ALL ON TABLE public.qualifications_plan TO scuola247_executive;
GRANT ALL ON TABLE public.qualifications_plan TO scuola247_employee;

GRANT SELECT ON TABLE public.qualifications_plan TO scuola247_teacher;
GRANT SELECT ON TABLE public.qualifications_plan TO scuola247_student;
GRANT SELECT ON TABLE public.qualifications_plan TO scuola247_relative;

REVOKE ALL ON TABLE public.qualifications_plan FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.regions TO scuola247_supervisor;

GRANT SELECT ON TABLE public.regions TO scuola247_executive;
GRANT SELECT ON TABLE public.regions TO scuola247_employee;
GRANT SELECT ON TABLE public.regions TO scuola247_teacher;
GRANT SELECT ON TABLE public.regions TO scuola247_student;
GRANT SELECT ON TABLE public.regions TO scuola247_relative;

REVOKE ALL ON TABLE public.regions FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.school_years TO scuola247_supervisor;
GRANT ALL ON TABLE public.school_years TO scuola247_executive;
GRANT ALL ON TABLE public.school_years TO scuola247_employee;

GRANT SELECT ON TABLE public.school_years TO scuola247_teacher;
GRANT SELECT ON TABLE public.school_years TO scuola247_student;
GRANT SELECT ON TABLE public.school_years TO scuola247_relative;

REVOKE ALL ON TABLE public.school_years FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.schools TO scuola247_supervisor;

GRANT SELECT ON TABLE public.schools TO scuola247_executive;
GRANT SELECT ON TABLE public.schools TO scuola247_employee;
GRANT SELECT ON TABLE public.schools TO scuola247_teacher;
GRANT SELECT ON TABLE public.schools TO scuola247_student;
GRANT SELECT ON TABLE public.schools TO scuola247_relative;

REVOKE ALL ON TABLE public.schools FROM public;
----------------------------------------------------------------
----------------------------------------------------------------

-- signatures
GRANT ALL ON TABLE public.signatures TO scuola247_supervisor;
GRANT ALL ON TABLE public.signatures TO scuola247_executive;
GRANT ALL ON TABLE public.signatures TO scuola247_employee;
GRANT ALL ON TABLE public.signatures TO scuola247_teacher;

GRANT SELECT ON TABLE public.signatures TO scuola247_student;
GRANT SELECT ON TABLE public.signatures TO scuola247_relative;

REVOKE ALL ON TABLE public.signatures FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- subjects
GRANT ALL ON TABLE public.subjects TO scuola247_supervisor;
GRANT ALL ON TABLE public.subjects TO scuola247_executive;
GRANT ALL ON TABLE public.subjects TO scuola247_employee;

GRANT SELECT ON TABLE public.subjects TO scuola247_teacher;
GRANT SELECT ON TABLE public.subjects TO scuola247_student;
GRANT SELECT ON TABLE public.subjects TO scuola247_relative;

REVOKE ALL ON TABLE public.subjects FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- teachears_notes
GRANT ALL ON TABLE public.teachears_notes TO scuola247_supervisor;
GRANT ALL ON TABLE public.teachears_notes TO scuola247_executive;
GRANT ALL ON TABLE public.teachears_notes TO scuola247_teacher;

GRANT SELECT ON TABLE public.teachears_notes TO scuola247_employee;
GRANT SELECT ON TABLE public.teachears_notes TO scuola247_student;
GRANT SELECT ON TABLE public.teachears_notes TO scuola247_relative;

REVOKE ALL ON TABLE public.teachears_notes FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- topics
GRANT ALL ON TABLE public.topics TO scuola247_supervisor;
GRANT ALL ON TABLE public.topics TO scuola247_executive;
GRANT ALL ON TABLE public.topics TO scuola247_teacher;

GRANT SELECT ON TABLE public.topics TO scuola247_employee;
GRANT SELECT ON TABLE public.topics TO scuola247_student;
GRANT SELECT ON TABLE public.topics TO scuola247_relative;

REVOKE ALL ON TABLE public.topics FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- usenames_ex
GRANT ALL ON TABLE public.usenames_ex TO scuola247_supervisor;
GRANT ALL ON TABLE public.usenames_ex TO scuola247_executive;
GRANT ALL ON TABLE public.usenames_ex TO scuola247_employee;

/* possono fare l'update della lingua */
/* il token non può essere visto da nessuno*/
GRANT SELECT ON TABLE public.usenames_ex TO scuola247_teacher;
GRANT SELECT ON TABLE public.usenames_ex TO scuola247_student;
GRANT SELECT ON TABLE public.usenames_ex TO scuola247_relative;

REVOKE ALL ON TABLE public.usenames_ex FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- usenames_schools
GRANT ALL ON TABLE public.usenames_schools TO scuola247_supervisor;
GRANT ALL ON TABLE public.usenames_schools TO scuola247_executive;
GRANT ALL ON TABLE public.usenames_schools TO scuola247_employee;

GRANT SELECT ON TABLE public.usenames_schools TO scuola247_teacher;
GRANT SELECT ON TABLE public.usenames_schools TO scuola247_student;
GRANT SELECT ON TABLE public.usenames_schools TO scuola247_relative;

REVOKE ALL ON TABLE public.usenames_schools FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- valutations
GRANT ALL ON TABLE public.valutations TO scuola247_supervisor;
GRANT ALL ON TABLE public.valutations TO scuola247_executive;
GRANT ALL ON TABLE public.valutations TO scuola247_teacher;

GRANT SELECT ON TABLE public.valutations TO scuola247_employee;
GRANT SELECT ON TABLE public.valutations TO scuola247_student;
GRANT SELECT ON TABLE public.valutations TO scuola247_relative;

REVOKE ALL ON TABLE public.valutations FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- valutations_qualifications
GRANT ALL ON TABLE public.valutations_qualifications TO scuola247_supervisor;
GRANT ALL ON TABLE public.valutations_qualifications TO scuola247_executive;
GRANT ALL ON TABLE public.valutations_qualifications TO scuola247_teacher;

GRANT SELECT ON TABLE public.valutations_qualifications TO scuola247_employee;
GRANT SELECT ON TABLE public.valutations_qualifications TO scuola247_student;
GRANT SELECT ON TABLE public.valutations_qualifications TO scuola247_relative;

REVOKE ALL ON TABLE public.valutations_qualifications FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- weekly_timetables
GRANT ALL ON TABLE public.weekly_timetables TO scuola247_supervisor;
GRANT ALL ON TABLE public.weekly_timetables TO scuola247_executive;
GRANT ALL ON TABLE public.weekly_timetables TO scuola247_employee;

GRANT SELECT ON TABLE public.weekly_timetables TO scuola247_teacher;
GRANT SELECT ON TABLE public.weekly_timetables TO scuola247_student;
GRANT SELECT ON TABLE public.weekly_timetables TO scuola247_relative;

REVOKE ALL ON TABLE public.weekly_timetables FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- weekly_timetables_days
GRANT ALL ON TABLE public.weekly_timetables_days TO scuola247_supervisor;
GRANT ALL ON TABLE public.weekly_timetables_days TO scuola247_executive;
GRANT ALL ON TABLE public.weekly_timetables_days TO scuola247_employee;

GRANT SELECT ON TABLE public.weekly_timetables_days TO scuola247_teacher;
GRANT SELECT ON TABLE public.weekly_timetables_days TO scuola247_student;
GRANT SELECT ON TABLE public.weekly_timetables_days TO scuola247_relative;

REVOKE ALL ON TABLE public.weekly_timetables_days FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- wikimedia_files
GRANT ALL ON TABLE public.wikimedia_files TO scuola247_supervisor;

GRANT SELECT ON TABLE public.wikimedia_files TO scuola247_executive;
GRANT SELECT ON TABLE public.wikimedia_files TO scuola247_employee;
GRANT SELECT ON TABLE public.wikimedia_files TO scuola247_teacher;
GRANT SELECT ON TABLE public.wikimedia_files TO scuola247_student;
GRANT SELECT ON TABLE public.wikimedia_files TO scuola247_relative;

REVOKE ALL ON TABLE public.wikimedia_files FROM public;
-------------------------------------------------------------
-------------------------------------------------------------


-- wikimedia_files_persons

GRANT ALL ON TABLE public.wikimedia_files_persons TO scuola247_supervisor;

GRANT SELECT ON TABLE public.wikimedia_files_persons TO scuola247_executive;
GRANT SELECT ON TABLE public.wikimedia_files_persons TO scuola247_employee;
GRANT SELECT ON TABLE public.wikimedia_files_persons TO scuola247_teacher;
GRANT SELECT ON TABLE public.wikimedia_files_persons TO scuola247_student;
GRANT SELECT ON TABLE public.wikimedia_files_persons TO scuola247_relative;

REVOKE ALL ON TABLE public.wikimedia_files_persons FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- SPECIAL
REVOKE ALL ON SCHEMA special FROM public;
REVOKE ALL ON SCHEMA special FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA special FROM scuola247_executive;
REVOKE ALL ON SCHEMA special FROM scuola247_employee;
REVOKE ALL ON SCHEMA special FROM scuola247_teacher;
REVOKE ALL ON SCHEMA special FROM scuola247_relative;
REVOKE ALL ON SCHEMA special FROM scuola247_student;
REVOKE ALL ON SCHEMA special FROM scuola247_user;

GRANT USAGE ON SCHEMA special TO scuola247_supervisor;

GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA special TO scuola247_supervisor;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA special TO scuola247_executive;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA special TO scuola247_employee;

-- TRANSLATE;
REVOKE ALL ON SCHEMA translate FROM public;
REVOKE ALL ON SCHEMA translate FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA translate FROM scuola247_executive;
REVOKE ALL ON SCHEMA translate FROM scuola247_employee;
REVOKE ALL ON SCHEMA translate FROM scuola247_teacher;
REVOKE ALL ON SCHEMA translate FROM scuola247_relative;
REVOKE ALL ON SCHEMA translate FROM scuola247_student;
REVOKE ALL ON SCHEMA translate FROM scuola247_user;

GRANT ALL ON SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON ALL SEQUENCES IN SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;

-- UNIT_TESTING;
REVOKE ALL ON SCHEMA unit_testing FROM public;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_testing FROM scuola247_user;

GRANT ALL ON SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_testing TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_testing TO scuola247_user;

GRANT ALL ON ALL SEQUENCES IN SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA unit_testing TO scuola247_user;

GRANT ALL ON TYPE unit_testing.check_point TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE unit_testing.check_point_status TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE unit_testing.unit_test_result TO scuola247_supervisor WITH GRANT OPTION;

GRANT USAGE ON TYPE unit_testing.check_point TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON TYPE unit_testing.check_point_status TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON TYPE unit_testing.unit_test_result TO scuola247_user WITH GRANT OPTION;

-- UNIT_TESTS_DATASETS;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM public;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_datasets FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_datasets TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets TO scuola247_user;

-- UNIT_TESTS_PUBLIC;
REVOKE ALL ON SCHEMA unit_tests_public FROM public;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_public FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_public TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_public TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_public TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_public TO scuola247_user;

-- UNIT_TESTS_SECURITY;
REVOKE ALL ON SCHEMA unit_tests_security FROM public;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_security TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_security TO scuola247_user;

-- UNIT_TESTS_TRANSLATE;
REVOKE ALL ON SCHEMA unit_tests_translate FROM public;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_translate TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_translate TO scuola247_user;

-- UTILITY;
REVOKE ALL ON SCHEMA utility FROM public;
REVOKE ALL ON SCHEMA utility FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA utility FROM scuola247_executive;
REVOKE ALL ON SCHEMA utility FROM scuola247_employee;
REVOKE ALL ON SCHEMA utility FROM scuola247_teacher;
REVOKE ALL ON SCHEMA utility FROM scuola247_relative;
REVOKE ALL ON SCHEMA utility FROM scuola247_student;
REVOKE ALL ON SCHEMA utility FROM scuola247_user;

GRANT ALL ON SCHEMA utility TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA utility TO scuola247_user;

GRANT ALL ON DOMAIN utility.number_base34 TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN utility.week_day TO scuola247_supervisor WITH GRANT OPTION;

GRANT USAGE ON DOMAIN utility.number_base34 TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN utility.week_day TO scuola247_user WITH GRANT OPTION;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA utility TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA utility TO scuola247_user;

GRANT ALL ON TYPE utility.language TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON TYPE utility.system_message TO scuola247_supervisor WITH GRANT OPTION;

GRANT USAGE ON TYPE utility.language TO scuola247_user;
GRANT USAGE ON TYPE utility.system_message TO scuola247_user;

GRANT SELECT ON ALL TABLES IN SCHEMA utility TO scuola247_supervisor;

SELECT utility.execute_command_query('SELECT command FROM utility.objects_set_owner'::text);
