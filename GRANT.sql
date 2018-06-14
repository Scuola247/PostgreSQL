
-- IMMETTERE LA EMAIL E LA password
-- TOGLIERE LA COMMENTAZIONE PER FAR PARTIRE IL COMANDO

-- Immetere la propria email
/* -- <-- da togliere
CREATE ROLE " *email*  " LOGIN
  ENCRYPTED PASSWORD ' *password*  '
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_supervisor TO " *email* ";
*/ -- <--da togliere


/* GRANT SINGOLI */

GRANT scuola247_user TO scuola247_employee;
GRANT scuola247_user TO scuola247_executive;
GRANT scuola247_user TO scuola247_relative;
GRANT scuola247_user TO scuola247_student;
GRANT scuola247_employee TO scuola247_supervisor;
GRANT scuola247_executive TO scuola247_supervisor;
GRANT scuola247_relative TO scuola247_supervisor;
GRANT scuola247_student TO scuola247_supervisor;
GRANT scuola247_teacher TO scuola247_supervisor;
GRANT scuola247_user TO scuola247_supervisor;
GRANT scuola247_user TO scuola247_teacher;

/* GRANT SU TUTTI I SCHEMA */
-- ASSERT
GRANT ALL ON SCHEMA assert TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA assert TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA assert TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA assert TO scuola247_user;

-- DATASETS
GRANT ALL ON SCHEMA datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA datasets TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA datasets TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA datasets TO scuola247_user;

-- DIAGNOSTIC
GRANT ALL ON SCHEMA diagnostic TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA diagnostic TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA diagnostic TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA diagnostic TO scuola247_user;

-- PUBLIC
GRANT ALL ON SCHEMA public TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA public TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO scuola247_user;

-- TRANSLATE
GRANT ALL ON SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA translate TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA translate TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA translate TO scuola247_user;

-- UNIT_TESTING
GRANT ALL ON SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_testing TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_testing TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_testing TO scuola247_user;

-- UNIT_TESTS_PUBLIC
GRANT ALL ON SCHEMA unit_tests_public TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_public TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_public TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_public TO scuola247_user;

-- UNIT_TESTS_SECURITY
GRANT ALL ON SCHEMA unit_tests_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA unit_tests_security TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_security TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA unit_tests_security TO scuola247_user;

-- UTILITY
GRANT ALL ON SCHEMA utility TO scuola247_supervisor WITH GRANT OPTION;
GRANT USAGE ON SCHEMA utility TO scuola247_user;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA utility TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA utility TO scuola247_user;


/* DROP DELLA FUNZIONE create_role(boolean) */

DROP FUNCTION unit_tests_security.create_role(boolean);


/* SISTEMAZIONE RUOLI */

-- scuola247_student

REVOKE scuola247_relative FROM "student-a@scuola-1.it";
GRANT scuola247_student TO "student-a@scuola-1.it";

REVOKE scuola247_relative FROM "student-b@scuola-1.it";
GRANT scuola247_student TO "student-b@scuola-1.it";

REVOKE scuola247_relative FROM "student-c@scuola-2.it";
GRANT scuola247_student TO "student-c@scuola-2.it";

REVOKE scuola247_relative FROM "student-d@scuola-2.it";
GRANT scuola247_student TO "student-d@scuola-2.it";

REVOKE scuola247_relative FROM "student-e@scuola-28961.it";
GRANT scuola247_student TO "student-e@scuola-28961.it";

REVOKE scuola247_relative FROM "student-f@scuola-28961.it";
GRANT scuola247_student TO "student-f@scuola-28961.it";

-- scuola247_teacher


REVOKE scuola247_relative FROM "teacher-a@scuola-1.it";
GRANT scuola247_teacher TO "teacher-a@scuola-1.it";

REVOKE scuola247_relative FROM "teacher-b@scuola-1.it";
GRANT scuola247_teacher TO "teacher-b@scuola-1.it";

REVOKE scuola247_relative FROM "teacher-c@scuola-2.it";
GRANT scuola247_teacher TO "teacher-c@scuola-2.it";

REVOKE scuola247_relative FROM "teacher-d@scuola-2.it";
GRANT scuola247_teacher TO "teacher-d@scuola-2.it";

REVOKE scuola247_relative FROM "teacher-e@scuola-28961.it";
GRANT scuola247_teacher TO "teacher-e@scuola-28961.it";

REVOKE scuola247_relative FROM "teacher-f@scuola-28961.it";
GRANT scuola247_teacher TO "teacher-f@scuola-28961.it";

/* CREAZIONE DI RUOLI MANCANTI */

-- scuola247_employee

CREATE ROLE "employee-a@scuola-1.it" LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_employee TO "employee-a@scuola-1.it";

CREATE ROLE "employee-b@scuola-1.it" LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_employee TO "employee-b@scuola-1.it";

CREATE ROLE "employee-c@scuola-2.it" LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_employee TO "employee-c@scuola-2.it";

CREATE ROLE "employee-d@scuola-2.it" LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_employee TO "employee-d@scuola-2.it";

CREATE ROLE "employee-e@scuola-28961.it" LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_employee TO "employee-e@scuola-28961.it";

CREATE ROLE "employee-f@scuola-28961.it" LOGIN
  ENCRYPTED PASSWORD 'password'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
GRANT scuola247_employee TO "employee-f@scuola-28961.it";
