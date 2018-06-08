/*
scuola247_employee      = SEGRETARI AMMINISTRATIVI
scuola247_executive     = PRESIDE
scuola247_relative      = GENITORE
scuola247_student       = STUDENTE
scuola247_supervisor    = COLUI CHE PUO' TUTTO
scuola247_teacher       = INSEGNANTE
scuola247_user          = UTENTE MEDIO
*/
---Vertical Security

/* MODEL

-- nome_table
GRANT ALL ON TABLE public.nome_table TO scuola247_supervisor;
GRANT ALL ON TABLE public.nome_table TO scuola247_executive;
GRANT ALL ON TABLE public.nome_table TO scuola247_employee;
GRANT ALL ON TABLE public.nome_table TO scuola247_teacher;
GRANT ALL ON TABLE public.nome_table TO scuola247_student;
GRANT ALL ON TABLE public.nome_table TO scuola247_relative;

REVOKE ALL ON TABLE public.nome_table FROM public;
-------------------------------------------------------------
-------------------------------------------------------------
*/

-- absences
GRANT ALL ON TABLE public.absences TO scuola247_supervisor;
GRANT ALL ON TABLE public.absences TO scuola247_executive;
GRANT SELECT ON TABLE public.absences TO scuola247_employee;
GRANT ALL ON TABLE public.absences TO scuola247_teacher;
GRANT SELECT ON TABLE public.absences TO scuola247_student;
GRANT SELECT ON TABLE public.absences TO scuola247_relative;

REVOKE ALL ON TABLE public.absences FROM public;
-------------------------------------------------------------
-------------------------------------------------------------

-- branches
GRANT ALL ON TABLE public.branches TO scuola247_supervisor;
GRANT ALL ON TABLE public.branches TO scuola247_executive;
GRANT ALL ON TABLE public.branches TO scuola247_employee;
--GRANT ALL ON TABLE public.branches TO scuola247_teacher;
--GRANT ALL ON TABLE public.branches TO scuola247_student;
--GRANT ALL ON TABLE public.branches TO scuola247_relative;

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
GRANT SELECT ON TABLE public.degrees TO scuola247_executive;
GRANT SELECT ON TABLE public.degrees TO scuola247_employee;
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
