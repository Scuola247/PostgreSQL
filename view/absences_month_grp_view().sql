-- Function: public.absences_month_grp_view()

-- DROP FUNCTION public.absences_month_grp_view();

CREATE OR REPLACE FUNCTION public.absences_month_grp_view()
  RETURNS TABLE(classroom bigint, month integer, absences bigint) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY WITH cmg AS (
			     SELECT cs.classroom,
			     date_part('month'::text, a.on_date) AS month,
			     count(1) AS absences
			     FROM absences a
			     JOIN classrooms_students cs ON a.classroom_student = cs.classroom_student
			     GROUP BY cs.classroom, (date_part('month'::text, a.on_date))
			   )
		SELECT c.classroom,
		    month.month,
		    COALESCE(cmg.absences, 0::bigint) AS absences
		FROM classrooms c
		    CROSS JOIN generate_series(1, 12) month(month)
		    LEFT JOIN cmg ON cmg.classroom = c.classroom AND month.month::double precision = cmg.month;
    
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.absences_month_grp_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.absences_month_grp_view() IS 'Regroup the absences for classroom (also for school year) and month
it''s used a crossjoin to create a list of all classrooms person for every month at zero for join them to persons the absences of the table for having all absences for every month of the year. also those at zero. otherwise, looking only table of absences, there will not';
