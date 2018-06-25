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
