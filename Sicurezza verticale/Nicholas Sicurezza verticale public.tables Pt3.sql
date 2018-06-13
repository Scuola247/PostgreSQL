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


/* date grant alla sola colonna person */

GRANT SELECT ON TABLE public.parents_meetings TO scuola247_student;
GRANT SELECT,UPDATE ON TABLE public.parents_meetings TO scuola247_relative;

REVOKE ALL ON TABLE public.parents_meetings FROM public;
----------------------------------------------------------------
----------------------------------------------------------------
GRANT ALL ON TABLE public.persons TO scuola247_supervisor;
GRANT ALL ON TABLE public.persons TO scuola247_executive;
GRANT ALL ON TABLE public.persons TO scuola247_employee;


/* possono variare solo: photo, thumbnail */

--GRANT SELECT ON TABLE public.persons TO scuola247_teacher;
--GRANT SELECT ON TABLE public.persons TO scuola247_student;
--GRANT SELECT ON TABLE public.persons TO scuola247_relative;

REVOKE ALL ON TABLE public.persons FROM public;
----------------------------------------------------------------
---------------------------------------------------------------
GRANT ALL ON TABLE public.persons_addresses TO scuola247_supervisor;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_executive;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_employee;

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
