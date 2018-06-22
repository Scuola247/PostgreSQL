--Vertical security
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
