-- Function: public.classrooms_teachers_view()

-- DROP FUNCTION public.classrooms_teachers_view();

CREATE OR REPLACE FUNCTION public.classrooms_teachers_view()
  RETURNS TABLE(classroom bigint, teacher bigint) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY SELECT DISTINCT l.classroom,
				l.teacher
				FROM lessons l
			       UNION
				SELECT DISTINCT cs.classroom,
				 v.teacher
				FROM valutations v
				 JOIN classrooms_students cs ON cs.classroom_student = v.classroom_student;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.classrooms_teachers_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.classrooms_teachers_view() IS 'Shows all teachers with their assigned classroom';
