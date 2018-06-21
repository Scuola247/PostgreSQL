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

-- GRANT su pg_catalog
GRANT ALL ON TABLE pg_shadow TO scuola247_supervisor; -- forse dovrebbe essere SELECT oppure USAGE


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

GRANT ALL ON ALL TABLES IN SCHEMA datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT SELECT ON ALL TABLES IN SCHEMA datasets TO scuola247_user;

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

GRANT ALL ON ALL TABLES IN SCHEMA git TO scuola247_supervisor WITH GRANT OPTION;

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

GRANT ALL ON ALL TABLES IN SCHEMA public TO scuola247_supervisor WITH GRANT OPTION;

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
GRANT ALL ON ALL TABLES IN SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;

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

GRANT ALL ON ALL TABLES IN SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT SELECT ON ALL TABLES IN SCHEMA unit_testing TO scuola247_user;

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

GRANT ALL ON ALL TABLES IN SCHEMA unit_tests_translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT SELECT ON ALL TABLES IN SCHEMA unit_tests_translate TO scuola247_user;

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


SELECT utility.execute_command_query('SELECT command FROM utility.objects_set_owner'::text);
