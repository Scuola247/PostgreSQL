-- Function: public.absences_certified_grp_view()

-- DROP FUNCTION public.absences_certified_grp_view();

CREATE OR REPLACE FUNCTION public.absences_certified_grp_view()
  RETURNS TABLE(classroom bigint, teacher bigint, absences_certified bigint) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
 RETURN QUERY SELECT cs.classroom,
		     a.teacher,
		     count(1) AS absences_certified
		     FROM absences a
		     JOIN classrooms_students cs ON a.classroom_student = cs.classroom_student
		     GROUP BY cs.classroom, a.teacher;
		     
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.absences_certified_grp_view()
  OWNER TO postgres;
