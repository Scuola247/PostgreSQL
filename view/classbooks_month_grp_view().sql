-- Function: public.classbooks_month_grp_view()

-- DROP FUNCTION public.classbooks_month_grp_view();

CREATE OR REPLACE FUNCTION public.classbooks_month_grp_view()
  RETURNS TABLE(evento text, classroom bigint, month integer, numero bigint) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY SELECT  'absences'::text AS evento,
			absences_month_grp.classroom,
			absences_month_grp.month,
			absences_month_grp.absences AS numero
		  FROM absences_month_grp
		UNION ALL
		 SELECT 'delays'::text AS evento,
			delays_month_grp.classroom,
			delays_month_grp.month,
			delays_month_grp.delays AS numero
		 FROM delays_month_grp
		UNION ALL
		 SELECT 'leavings'::text AS evento,
			leavings_month_grp.classroom,
			leavings_month_grp.month,
			leavings_month_grp.leavings AS numero
		 FROM leavings_month_grp
		UNION ALL
		 SELECT 'fuori classrooms'::text AS evento,
			out_of_classrooms_month_grp.classroom,
			out_of_classrooms_month_grp.month,
			out_of_classrooms_month_grp.out_of_classrooms AS numero
		 FROM out_of_classrooms_month_grp
		UNION ALL
		 SELECT 'notes'::text AS evento,
			notes_month_grp.classroom,
			notes_month_grp.month,
			notes_month_grp.notes AS numero
		 FROM notes_month_grp;     
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.classbooks_month_grp_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.classbooks_month_grp_view() IS 'Regroup the classbooks of the month';
