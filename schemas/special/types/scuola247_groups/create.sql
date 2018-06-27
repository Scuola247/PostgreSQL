-- Type: special.scuola247_groups

-- DROP TYPE special.scuola247_groups;

CREATE TYPE special.scuola247_groups AS ENUM
   ('scuola247_supervisor',
    'scuola247_executive',
    'scuola247_employee',
    'scuola247_teacher',
    'scuola247_relative',
    'scuola247_student',
    'scuola247_user');
ALTER TYPE special.scuola247_groups
  OWNER TO postgres;
