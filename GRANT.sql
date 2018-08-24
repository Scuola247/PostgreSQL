/*
 SCUOLA247 SICUREZZA VERTICALE
*/
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

REVOKE ALL ON DATABASE fulcro FROM public;
REVOKE ALL ON DATABASE fulcro FROM scuola247_supervisor;
REVOKE ALL ON DATABASE fulcro FROM scuola247_executive;
REVOKE ALL ON DATABASE fulcro FROM scuola247_employee;
REVOKE ALL ON DATABASE fulcro FROM scuola247_teacher;
REVOKE ALL ON DATABASE fulcro FROM scuola247_relative;
REVOKE ALL ON DATABASE fulcro FROM scuola247_student;
REVOKE ALL ON DATABASE fulcro FROM scuola247_user;

GRANT ALL ON DATABASE fulcro TO scuola247_supervisor WITH GRANT OPTION;
GRANT CONNECT ON DATABASE fulcro TO scuola247_user;

GRANT ALL ON LANGUAGE plpgsql TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON LANGUAGE plpgsql TO scuola247_user;

-- pg_shadow
GRANT SELECT ON TABLE pg_shadow TO scuola247_supervisor;
GRANT SELECT ON TABLE pg_shadow TO scuola247_executive;
GRANT SELECT ON TABLE pg_shadow TO scuola247_employee;
GRANT SELECT ON TABLE pg_shadow TO scuola247_teacher;
GRANT SELECT ON TABLE pg_shadow TO scuola247_student;
GRANT SELECT ON TABLE pg_shadow TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA assert FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA assert FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA assert FROM scuola247_user;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA datasets FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA datasets FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA datasets FROM scuola247_user;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA diagnostic FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA diagnostic FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA diagnostic FROM scuola247_user;

REVOKE ALL ON TYPE diagnostic.error FROM public;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_supervisor;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_executive;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_employee;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_teacher;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_relative;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_student;
REVOKE ALL ON TYPE diagnostic.error FROM scuola247_user;

REVOKE ALL ON TYPE diagnostic.verbosities FROM public;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_supervisor;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_executive;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_employee;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_teacher;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_relative;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_student;
REVOKE ALL ON TYPE diagnostic.verbosities FROM scuola247_user;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA git FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA git FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA git FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA git FROM scuola247_user;

GRANT ALL ON SCHEMA git TO scuola247_supervisor WITH GRANT OPTION;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA git TO scuola247_supervisor WITH GRANT OPTION;

-- scuol247;
REVOKE ALL ON SCHEMA scuola247 FROM public;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_executive;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_employee;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_teacher;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_relative;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_student;
REVOKE ALL ON SCHEMA scuola247 FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA scuola247 FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA scuola247 FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM public;
-- REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_supervisor; -- da problemi di dipendenze
REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA scuola247 FROM scuola247_user;

REVOKE ALL ON DOMAIN scuola247.course_year FROM public;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_executive;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_employee;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_teacher;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_relative;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_student;
REVOKE ALL ON DOMAIN scuola247.course_year FROM scuola247_user;

REVOKE ALL ON DOMAIN utility.mime_type_image FROM public;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_executive;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_employee;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_teacher;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_relative;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_student;
REVOKE ALL ON DOMAIN utility.mime_type_image FROM scuola247_user;

REVOKE ALL ON DOMAIN scuola247.period_lesson FROM public;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_executive;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_employee;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_teacher;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_relative;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_student;
REVOKE ALL ON DOMAIN scuola247.period_lesson FROM scuola247_user;

REVOKE ALL ON DOMAIN utility.week FROM public;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_executive;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_employee;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_teacher;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_relative;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_student;
REVOKE ALL ON DOMAIN utility.week FROM scuola247_user;

REVOKE ALL ON DOMAIN utility.week_day FROM public;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_executive;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_employee;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_teacher;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_relative;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_student;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.address_type FROM public;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.address_type FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.explanation_type FROM public;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.explanation_type FROM scuola247_user;

REVOKE ALL ON TYPE utility.file_extension FROM public;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_supervisor;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_executive;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_employee;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_teacher;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_relative;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_student;
REVOKE ALL ON TYPE utility.file_extension FROM scuola247_user;

REVOKE ALL ON TYPE shared.geographical_area FROM public;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_supervisor;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_executive;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_employee;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_teacher;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_relative;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_student;
REVOKE ALL ON TYPE shared.geographical_area FROM scuola247_user;

REVOKE ALL ON TYPE utility.image FROM public;
REVOKE ALL ON TYPE utility.image FROM scuola247_supervisor;
REVOKE ALL ON TYPE utility.image FROM scuola247_executive;
REVOKE ALL ON TYPE utility.image FROM scuola247_employee;
REVOKE ALL ON TYPE utility.image FROM scuola247_teacher;
REVOKE ALL ON TYPE utility.image FROM scuola247_relative;
REVOKE ALL ON TYPE utility.image FROM scuola247_student;
REVOKE ALL ON TYPE utility.image FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.language FROM public;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.language FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.marital_status FROM public;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.marital_status FROM scuola247_user;

REVOKE ALL ON TYPE utility.mime_type FROM public;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_supervisor;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_executive;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_employee;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_teacher;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_relative;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_student;
REVOKE ALL ON TYPE utility.mime_type FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.relationships FROM public;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.relationships FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.role FROM public;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.role FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.sex FROM public;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.sex FROM scuola247_user;

REVOKE ALL ON TYPE scuola247.wikimedia_type FROM public;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_supervisor;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_executive;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_employee;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_teacher;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_relative;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_student;
REVOKE ALL ON TYPE scuola247.wikimedia_type FROM scuola247_user;

GRANT ALL ON SCHEMA scuola247 TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA scuola247 TO scuola247_user;

GRANT ALL ON DOMAIN scuola247.course_year TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN utility.mime_type_image TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN scuola247.period_lesson TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN utility.week TO scuola247_supervisor WITH GRANT OPTION;
GRANT ALL ON DOMAIN utility.week_day TO scuola247_supervisor WITH GRANT OPTION;

GRANT USAGE ON DOMAIN scuola247.course_year TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN utility.mime_type_image TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN scuola247.period_lesson TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN utility.week TO scuola247_user WITH GRANT OPTION;
GRANT USAGE ON DOMAIN utility.week_day TO scuola247_user WITH GRANT OPTION;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA scuola247 TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA scuola247 TO scuola247_user;

GRANT ALL ON ALL SEQUENCES IN SCHEMA scuola247 TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA scuola247 TO scuola247_user;

GRANT ALL ON TYPE scuola247.address_type TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.explanation_type TO scuola247_supervisor;
GRANT ALL ON TYPE utility.file_extension TO scuola247_supervisor;
GRANT ALL ON TYPE shared.geographical_area TO scuola247_supervisor;
GRANT ALL ON TYPE utility.image TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.language TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.marital_status TO scuola247_supervisor;
GRANT ALL ON TYPE utility.mime_type TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.relationships TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.role TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.sex TO scuola247_supervisor;
GRANT ALL ON TYPE scuola247.wikimedia_type TO scuola247_supervisor;

GRANT USAGE ON TYPE scuola247.address_type TO scuola247_user;
GRANT USAGE ON TYPE scuola247.explanation_type TO scuola247_user;
GRANT USAGE ON TYPE utility.file_extension TO scuola247_user;
GRANT USAGE ON TYPE shared.geographical_area TO scuola247_user;
GRANT USAGE ON TYPE utility.image TO scuola247_user;
GRANT USAGE ON TYPE scuola247.language TO scuola247_user;
GRANT USAGE ON TYPE scuola247.marital_status TO scuola247_user;
GRANT USAGE ON TYPE utility.mime_type TO scuola247_user;
GRANT USAGE ON TYPE scuola247.relationships TO scuola247_user;
GRANT USAGE ON TYPE scuola247.role TO scuola247_user;
GRANT USAGE ON TYPE scuola247.sex TO scuola247_user;
GRANT USAGE ON TYPE scuola247.wikimedia_type TO scuola247_user;

-- absences
GRANT ALL ON TABLE scuola247.absences TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.absences TO scuola247_executive;
GRANT ALL ON TABLE scuola247.absences TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.absences TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.absences TO scuola247_student;
GRANT SELECT ON TABLE scuola247.absences TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- branches
GRANT ALL ON TABLE scuola247.branches TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.branches TO scuola247_executive;
GRANT ALL ON TABLE scuola247.branches TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.branches TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.branches TO scuola247_student;
GRANT SELECT ON TABLE scuola247.branches TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- cities
GRANT ALL ON TABLE shared.cities TO scuola247_supervisor;

GRANT SELECT ON TABLE shared.cities TO scuola247_executive;
GRANT SELECT ON TABLE shared.cities TO scuola247_employee;
GRANT SELECT ON TABLE shared.cities TO scuola247_teacher;
GRANT SELECT ON TABLE shared.cities TO scuola247_student;
GRANT SELECT ON TABLE shared.cities TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- classrooms
GRANT ALL ON TABLE scuola247.classrooms TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.classrooms TO scuola247_executive;
GRANT ALL ON TABLE scuola247.classrooms TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.classrooms TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.classrooms TO scuola247_student;
GRANT SELECT ON TABLE scuola247.classrooms TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- classrooms_students
GRANT ALL ON TABLE scuola247.classrooms_students TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.classrooms_students TO scuola247_executive;
GRANT ALL ON TABLE scuola247.classrooms_students TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.classrooms_students TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.classrooms_students TO scuola247_student;
GRANT SELECT ON TABLE scuola247.classrooms_students TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- communication_types
GRANT ALL ON TABLE scuola247.communication_types TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.communication_types TO scuola247_executive;
GRANT ALL ON TABLE scuola247.communication_types TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.communication_types TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.communication_types TO scuola247_student;
GRANT SELECT ON TABLE scuola247.communication_types TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- communications_media
GRANT ALL ON TABLE scuola247.communications_media TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.communications_media TO scuola247_executive;
GRANT ALL ON TABLE scuola247.communications_media TO scuola247_employee;
GRANT ALL ON TABLE scuola247.communications_media TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.communications_media TO scuola247_student;
GRANT ALL ON TABLE scuola247.communications_media TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- conversations
GRANT ALL ON TABLE scuola247.conversations TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.conversations TO scuola247_executive;
GRANT ALL ON TABLE scuola247.conversations TO scuola247_employee;
GRANT ALL ON TABLE scuola247.conversations TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.conversations TO scuola247_student;
GRANT ALL ON TABLE scuola247.conversations TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- conversations_invites
GRANT ALL ON TABLE scuola247.conversations_invites TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.conversations_invites TO scuola247_executive;
GRANT ALL ON TABLE scuola247.conversations_invites TO scuola247_employee;
GRANT ALL ON TABLE scuola247.conversations_invites TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.conversations_invites TO scuola247_student;
GRANT ALL ON TABLE scuola247.conversations_invites TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- countries
GRANT ALL ON TABLE shared.countries TO scuola247_supervisor;

GRANT SELECT ON TABLE shared.countries TO scuola247_executive;
GRANT SELECT ON TABLE shared.countries TO scuola247_employee;
GRANT SELECT ON TABLE shared.countries TO scuola247_teacher;
GRANT SELECT ON TABLE shared.countries TO scuola247_student;
GRANT SELECT ON TABLE shared.countries TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- degrees
GRANT ALL ON TABLE scuola247.degrees TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.degrees TO scuola247_executive;
GRANT ALL ON TABLE scuola247.degrees TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.degrees TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.degrees TO scuola247_student;
GRANT SELECT ON TABLE scuola247.degrees TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- delays
GRANT ALL ON TABLE scuola247.delays TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.delays TO scuola247_executive;
GRANT ALL ON TABLE scuola247.delays TO scuola247_employee;
GRANT ALL ON TABLE scuola247.delays TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.delays TO scuola247_student;
GRANT SELECT ON TABLE scuola247.delays TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- districts
GRANT ALL ON TABLE shared.districts TO scuola247_supervisor;

GRANT SELECT ON TABLE shared.districts TO scuola247_executive;
GRANT SELECT ON TABLE shared.districts TO scuola247_employee;
GRANT SELECT ON TABLE shared.districts TO scuola247_teacher;
GRANT SELECT ON TABLE shared.districts TO scuola247_student;
GRANT SELECT ON TABLE shared.districts TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- explanations
GRANT ALL ON TABLE scuola247.explanations TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.explanations TO scuola247_executive;
GRANT ALL ON TABLE scuola247.explanations TO scuola247_employee;
GRANT ALL ON TABLE scuola247.explanations TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.explanations TO scuola247_relative;
GRANT SELECT ON TABLE scuola247.explanations TO scuola247_student;
------------------------------------------------------
------------------------------------------------------

-- faults
GRANT ALL ON TABLE scuola247.faults TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.faults TO scuola247_executive;
GRANT ALL ON TABLE scuola247.faults TO scuola247_employee;
GRANT ALL ON TABLE scuola247.faults TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.faults TO scuola247_student;
GRANT SELECT ON TABLE scuola247.faults TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- grade_types
GRANT ALL ON TABLE scuola247.grade_types TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.grade_types TO scuola247_executive;
GRANT ALL ON TABLE scuola247.grade_types TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.grade_types TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.grade_types TO scuola247_relative;
GRANT SELECT ON TABLE scuola247.grade_types TO scuola247_student;
------------------------------------------------------
------------------------------------------------------

-- grades
GRANT ALL ON TABLE scuola247.grades TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.grades TO scuola247_executive;
GRANT ALL ON TABLE scuola247.grades TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.grades TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.grades TO scuola247_student;
GRANT SELECT ON TABLE scuola247.grades TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- grading_meetings
GRANT ALL ON TABLE scuola247.grading_meetings TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.grading_meetings TO scuola247_executive;
GRANT ALL ON TABLE scuola247.grading_meetings TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.grading_meetings TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.grading_meetings TO scuola247_student;
GRANT SELECT ON TABLE scuola247.grading_meetings TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- grading_meetings_valutations
GRANT ALL ON TABLE scuola247.grading_meetings_valutations TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.grading_meetings_valutations TO scuola247_executive;
GRANT ALL ON TABLE scuola247.grading_meetings_valutations TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.grading_meetings_valutations TO scuola247_employee;


GRANT SELECT ON TABLE scuola247.grading_meetings_valutations TO scuola247_relative;
GRANT SELECT ON TABLE scuola247.grading_meetings_valutations TO scuola247_student;
------------------------------------------------------
------------------------------------------------------

-- grading_meetings_valutations_qua
GRANT ALL ON TABLE scuola247.grading_meetings_valutations_qua TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.grading_meetings_valutations_qua TO scuola247_executive;
GRANT ALL ON TABLE scuola247.grading_meetings_valutations_qua TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.grading_meetings_valutations_qua TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.grading_meetings_valutations_qua TO scuola247_relative;
GRANT SELECT ON TABLE scuola247.grading_meetings_valutations_qua TO scuola247_student;
------------------------------------------------------
------------------------------------------------------

-- holidays
GRANT ALL ON TABLE scuola247.holidays TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.holidays TO scuola247_executive;
GRANT ALL ON TABLE scuola247.holidays TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.holidays TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.holidays TO scuola247_relative;
GRANT SELECT ON TABLE scuola247.holidays TO scuola247_student;
------------------------------------------------------
------------------------------------------------------

-- leavings
GRANT ALL ON TABLE scuola247.leavings TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.leavings TO scuola247_executive;
GRANT ALL ON TABLE scuola247.leavings TO scuola247_employee;
GRANT ALL ON TABLE scuola247.leavings TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.leavings TO scuola247_student;
GRANT SELECT ON TABLE scuola247.leavings TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- lessons
GRANT ALL ON TABLE scuola247.lessons TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.lessons TO scuola247_executive;
GRANT ALL ON TABLE scuola247.lessons TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.lessons TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.lessons TO scuola247_student;
GRANT SELECT ON TABLE scuola247.lessons TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- messages
GRANT ALL ON TABLE scuola247.messages TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.messages TO scuola247_executive;
GRANT ALL ON TABLE scuola247.messages TO scuola247_employee;
GRANT ALL ON TABLE scuola247.messages TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.messages TO scuola247_student;
GRANT ALL ON TABLE scuola247.messages TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- messages_read
GRANT ALL ON TABLE scuola247.messages_read TO scuola247_supervisor;

GRANT SELECT, INSERT ON TABLE scuola247.messages_read TO scuola247_executive;
GRANT SELECT, INSERT ON TABLE scuola247.messages_read TO scuola247_employee;
GRANT SELECT, INSERT ON TABLE scuola247.messages_read TO scuola247_teacher;
GRANT SELECT, INSERT ON TABLE scuola247.messages_read TO scuola247_student;
GRANT SELECT, INSERT ON TABLE scuola247.messages_read TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- metrics
GRANT ALL ON TABLE scuola247.metrics TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.metrics TO scuola247_executive;
GRANT ALL ON TABLE scuola247.metrics TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.metrics TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.metrics TO scuola247_student;
GRANT SELECT ON TABLE scuola247.metrics TO scuola247_relative;
------------------------------------------------------
------------------------------------------------------

-- notes
GRANT ALL ON TABLE scuola247.notes TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.notes TO scuola247_executive;
GRANT ALL ON TABLE scuola247.notes TO scuola247_employee;
GRANT ALL ON TABLE scuola247.notes TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.notes TO scuola247_student;
GRANT SELECT ON TABLE scuola247.notes TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- notes_signed
GRANT ALL ON TABLE scuola247.notes_signed TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.notes_signed TO scuola247_executive;
GRANT ALL ON TABLE scuola247.notes_signed TO scuola247_employee;
GRANT ALL ON TABLE scuola247.notes_signed TO scuola247_relative;
GRANT ALL ON TABLE scuola247.notes_signed TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.notes_signed TO scuola247_student;
----------------------------------------------------------------
----------------------------------------------------------------

-- out_of_classrooms
GRANT ALL ON TABLE scuola247.out_of_classrooms TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.out_of_classrooms TO scuola247_executive;
GRANT ALL ON TABLE scuola247.out_of_classrooms TO scuola247_employee;
GRANT ALL ON TABLE scuola247.out_of_classrooms TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.out_of_classrooms TO scuola247_student;
GRANT SELECT ON TABLE scuola247.out_of_classrooms TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- parents_meetings
GRANT ALL ON TABLE scuola247.parents_meetings TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.parents_meetings TO scuola247_executive;
GRANT ALL ON TABLE scuola247.parents_meetings TO scuola247_employee;
GRANT ALL ON TABLE scuola247.parents_meetings TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.parents_meetings TO scuola247_relative;

/* date grant alla sola colonna person */
GRANT SELECT(parents_meeting, person) ON TABLE scuola247.parents_meetings TO scuola247_student;
----------------------------------------------------------------
----------------------------------------------------------------

-- persons
GRANT ALL ON TABLE scuola247.persons TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.persons TO scuola247_executive;
GRANT ALL ON TABLE scuola247.persons TO scuola247_employee;
GRANT ALL ON TABLE scuola247.persons TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.persons TO scuola247_student;
GRANT SELECT ON TABLE scuola247.persons TO scuola247_relative;
---------------------------------------------------------------
---------------------------------------------------------------

-- persons_addresses
GRANT ALL ON TABLE scuola247.persons_addresses TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.persons_addresses TO scuola247_executive;
GRANT ALL ON TABLE scuola247.persons_addresses TO scuola247_employee;
GRANT ALL ON TABLE scuola247.persons_addresses TO scuola247_teacher;
GRANT ALL ON TABLE scuola247.persons_addresses TO scuola247_student;
GRANT ALL ON TABLE scuola247.persons_addresses TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- persons_relations
GRANT ALL ON TABLE scuola247.persons_relations TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.persons_relations TO scuola247_executive;
GRANT ALL ON TABLE scuola247.persons_relations TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.persons_relations TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.persons_relations TO scuola247_student;
GRANT SELECT ON TABLE scuola247.persons_relations TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- persons_roles
GRANT ALL ON TABLE scuola247.persons_roles TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.persons_roles TO scuola247_executive;
GRANT ALL ON TABLE scuola247.persons_roles TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.persons_roles TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.persons_roles TO scuola247_student;
GRANT SELECT ON TABLE scuola247.persons_roles TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- qualifications
GRANT ALL ON TABLE scuola247.qualifications TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.qualifications TO scuola247_executive;
GRANT ALL ON TABLE scuola247.qualifications TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.qualifications TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.qualifications TO scuola247_student;
GRANT SELECT ON TABLE scuola247.qualifications TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- qualifications_plan
GRANT ALL ON TABLE scuola247.qualifications_plan TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.qualifications_plan TO scuola247_executive;
GRANT ALL ON TABLE scuola247.qualifications_plan TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.qualifications_plan TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.qualifications_plan TO scuola247_student;
GRANT SELECT ON TABLE scuola247.qualifications_plan TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- regions
GRANT ALL ON TABLE shared.regions TO scuola247_supervisor;

GRANT SELECT ON TABLE shared.regions TO scuola247_executive;
GRANT SELECT ON TABLE shared.regions TO scuola247_employee;
GRANT SELECT ON TABLE shared.regions TO scuola247_teacher;
GRANT SELECT ON TABLE shared.regions TO scuola247_student;
GRANT SELECT ON TABLE shared.regions TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- school_years
GRANT ALL ON TABLE scuola247.school_years TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.school_years TO scuola247_executive;
GRANT ALL ON TABLE scuola247.school_years TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.school_years TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.school_years TO scuola247_student;
GRANT SELECT ON TABLE scuola247.school_years TO scuola247_relative;

REVOKE ALL ON TABLE scuola247.school_years FROM public;
----------------------------------------------------------------
----------------------------------------------------------------

-- schools
GRANT ALL ON TABLE scuola247.schools TO scuola247_supervisor;

GRANT SELECT ON TABLE scuola247.schools TO scuola247_executive;
GRANT SELECT ON TABLE scuola247.schools TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.schools TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.schools TO scuola247_student;
GRANT SELECT ON TABLE scuola247.schools TO scuola247_relative;
----------------------------------------------------------------
----------------------------------------------------------------

-- signatures
GRANT ALL ON TABLE scuola247.signatures TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.signatures TO scuola247_executive;
GRANT ALL ON TABLE scuola247.signatures TO scuola247_employee;
GRANT ALL ON TABLE scuola247.signatures TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.signatures TO scuola247_student;
GRANT SELECT ON TABLE scuola247.signatures TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- subjects
GRANT ALL ON TABLE scuola247.subjects TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.subjects TO scuola247_executive;
GRANT ALL ON TABLE scuola247.subjects TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.subjects TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.subjects TO scuola247_student;
GRANT SELECT ON TABLE scuola247.subjects TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- teachears_notes
GRANT ALL ON TABLE scuola247.teachears_notes TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.teachears_notes TO scuola247_executive;
GRANT ALL ON TABLE scuola247.teachears_notes TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.teachears_notes TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.teachears_notes TO scuola247_student;
GRANT SELECT ON TABLE scuola247.teachears_notes TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- topics
GRANT ALL ON TABLE scuola247.topics TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.topics TO scuola247_executive;
GRANT ALL ON TABLE scuola247.topics TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.topics TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.topics TO scuola247_student;
GRANT SELECT ON TABLE scuola247.topics TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- usenames_ex
GRANT ALL ON TABLE scuola247.usenames_ex TO scuola247_supervisor;

/* possono fare l'update della lingua */
/* il token non può essere visto da nessuno*/
GRANT SELECT(usename, language), UPDATE(language) ON TABLE scuola247.usenames_ex TO scuola247_executive;
GRANT SELECT(usename, language), UPDATE(language) ON TABLE scuola247.usenames_ex TO scuola247_employee;
GRANT SELECT(usename, language), UPDATE(language) ON TABLE scuola247.usenames_ex TO scuola247_teacher;
GRANT SELECT(usename, language), UPDATE(language) ON TABLE scuola247.usenames_ex TO scuola247_student;
GRANT SELECT(usename, language), UPDATE(language) ON TABLE scuola247.usenames_ex TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- usenames_schools
GRANT ALL ON TABLE scuola247.usenames_schools TO scuola247_supervisor;

GRANT SELECT ON TABLE scuola247.usenames_schools TO scuola247_executive;
GRANT SELECT ON TABLE scuola247.usenames_schools TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.usenames_schools TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.usenames_schools TO scuola247_student;
GRANT SELECT ON TABLE scuola247.usenames_schools TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- valutations
GRANT ALL ON TABLE scuola247.valutations TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.valutations TO scuola247_executive;
GRANT ALL ON TABLE scuola247.valutations TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.valutations TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.valutations TO scuola247_student;
GRANT SELECT ON TABLE scuola247.valutations TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- valutations_qualifications
GRANT ALL ON TABLE scuola247.valutations_qualifications TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.valutations_qualifications TO scuola247_executive;
GRANT ALL ON TABLE scuola247.valutations_qualifications TO scuola247_teacher;

GRANT SELECT ON TABLE scuola247.valutations_qualifications TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.valutations_qualifications TO scuola247_student;
GRANT SELECT ON TABLE scuola247.valutations_qualifications TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- weekly_timetables
GRANT ALL ON TABLE scuola247.weekly_timetables TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.weekly_timetables TO scuola247_executive;
GRANT ALL ON TABLE scuola247.weekly_timetables TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.weekly_timetables TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.weekly_timetables TO scuola247_student;
GRANT SELECT ON TABLE scuola247.weekly_timetables TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- weekly_timetables_days
GRANT ALL ON TABLE scuola247.weekly_timetables_days TO scuola247_supervisor;
GRANT ALL ON TABLE scuola247.weekly_timetables_days TO scuola247_executive;
GRANT ALL ON TABLE scuola247.weekly_timetables_days TO scuola247_employee;

GRANT SELECT ON TABLE scuola247.weekly_timetables_days TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.weekly_timetables_days TO scuola247_student;
GRANT SELECT ON TABLE scuola247.weekly_timetables_days TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- wikimedia_files
GRANT ALL ON TABLE scuola247.wikimedia_files TO scuola247_supervisor;

GRANT SELECT ON TABLE scuola247.wikimedia_files TO scuola247_executive;
GRANT SELECT ON TABLE scuola247.wikimedia_files TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.wikimedia_files TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.wikimedia_files TO scuola247_student;
GRANT SELECT ON TABLE scuola247.wikimedia_files TO scuola247_relative;
-------------------------------------------------------------
-------------------------------------------------------------

-- wikimedia_files_persons

GRANT ALL ON TABLE scuola247.wikimedia_files_persons TO scuola247_supervisor;

GRANT SELECT ON TABLE scuola247.wikimedia_files_persons TO scuola247_executive;
GRANT SELECT ON TABLE scuola247.wikimedia_files_persons TO scuola247_employee;
GRANT SELECT ON TABLE scuola247.wikimedia_files_persons TO scuola247_teacher;
GRANT SELECT ON TABLE scuola247.wikimedia_files_persons TO scuola247_student;
GRANT SELECT ON TABLE scuola247.wikimedia_files_persons TO scuola247_relative;
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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA special FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA special FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA special FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA special FROM scuola247_user;

REVOKE ALL ON TYPE special.scuola247_groups FROM public;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_supervisor;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_executive;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_employee;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_teacher;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_relative;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_student;
REVOKE ALL ON TYPE special.scuola247_groups FROM scuola247_user;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA translate FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA translate FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA translate FROM scuola247_user;

GRANT ALL ON SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA translate TO scuola247_user;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_testing FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_testing FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_testing FROM scuola247_user;

REVOKE ALL ON TYPE unit_testing.check_point FROM public;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_supervisor;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_executive;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_employee;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_teacher;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_relative;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_student;
REVOKE ALL ON TYPE unit_testing.check_point FROM scuola247_user;

REVOKE ALL ON TYPE unit_testing.check_point_status FROM public;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_supervisor;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_executive;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_employee;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_teacher;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_relative;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_student;
REVOKE ALL ON TYPE unit_testing.check_point_status FROM scuola247_user;

REVOKE ALL ON TYPE unit_testing.unit_test_result FROM public;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_supervisor;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_executive;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_employee;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_teacher;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_relative;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_student;
REVOKE ALL ON TYPE unit_testing.unit_test_result FROM scuola247_user;

GRANT ALL ON SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_testing TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_testing TO scuola247_user;

GRANT ALL ON ALL SEQUENCES IN SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA unit_testing TO scuola247_user;

GRANT ALL ON ALL TABLES IN SCHEMA unit_testing TO public;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_datasets FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_datasets FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_datasets TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_datasets TO scuola247_user;

-- UNIT_TESTS_DIAGNOSTIC;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM public;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_diagnostic FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_diagnostic FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_diagnostic FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_diagnostic TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_diagnostic TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_diagnostic TO scuola247_user;

-- UNIT_TESTS_HORIZONTAL_SECURITY;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM public;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_horizontal_security FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_horizontal_security FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_horizontal_security FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_horizontal_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_horizontal_security TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_horizontal_security TO scuola247_user;

-- unit_tests_scuola247;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM public;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_scuola247 FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_scuola247 FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_scuola247 FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_scuola247 TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_scuola247 TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_scuola247 TO scuola247_user;

-- UNIT_TESTS_SECURITY;
REVOKE ALL ON SCHEMA unit_tests_security FROM public;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_security FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_security FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_security FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_security TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_security TO scuola247_user;

-- UNIT_TESTS_SPECIAL;
REVOKE ALL ON SCHEMA unit_tests_special FROM public;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_supervisor;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_special FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_special FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_special FROM scuola247_user;

GRANT ALL ON SCHEMA unit_tests_special TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_special TO scuola247_user;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_special TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_special TO scuola247_user;

-- UNIT_TESTS_TRANSLATE;
REVOKE ALL ON SCHEMA unit_tests_translate FROM public; 
-- REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_supervisor; -- da problemi di dipendenze
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_executive;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_employee;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_teacher;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_relative;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_student;
REVOKE ALL ON SCHEMA unit_tests_translate FROM scuola247_user;

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_supervisor; -- da problemi di dipendenze
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA unit_tests_translate FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA unit_tests_translate FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA unit_tests_translate FROM scuola247_user;

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

REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM public;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_supervisor;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_executive;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_employee;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_teacher;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_relative;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_student;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA utility FROM scuola247_user;

REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM public;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_supervisor;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_executive;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_employee;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_teacher;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_relative;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_student;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA utility FROM scuola247_user;

REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM public;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_supervisor;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_executive;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_employee;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_teacher;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_relative;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_student;
REVOKE ALL ON ALL TABLES IN SCHEMA utility FROM scuola247_user;

REVOKE ALL ON DOMAIN utility.number_base34 FROM public;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_executive;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_employee;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_teacher;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_relative;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_student;
REVOKE ALL ON DOMAIN utility.number_base34 FROM scuola247_user;

REVOKE ALL ON DOMAIN utility.week_day FROM public;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_supervisor;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_executive;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_employee;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_teacher;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_relative;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_student;
REVOKE ALL ON DOMAIN utility.week_day FROM scuola247_user;

REVOKE ALL ON TYPE utility.language FROM public;
REVOKE ALL ON TYPE utility.language FROM scuola247_supervisor;
REVOKE ALL ON TYPE utility.language FROM scuola247_executive;
REVOKE ALL ON TYPE utility.language FROM scuola247_employee;
REVOKE ALL ON TYPE utility.language FROM scuola247_teacher;
REVOKE ALL ON TYPE utility.language FROM scuola247_relative;
REVOKE ALL ON TYPE utility.language FROM scuola247_student;
REVOKE ALL ON TYPE utility.language FROM scuola247_user;

REVOKE ALL ON TYPE utility.objects_type FROM public;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_supervisor;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_executive;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_employee;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_teacher;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_relative;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_student;
REVOKE ALL ON TYPE utility.objects_type FROM scuola247_user;

REVOKE ALL ON TYPE utility.system_message FROM public;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_supervisor;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_executive;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_employee;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_teacher;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_relative;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_student;
REVOKE ALL ON TYPE utility.system_message FROM scuola247_user;

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
