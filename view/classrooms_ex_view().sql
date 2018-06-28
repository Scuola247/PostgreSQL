-- Function: public.classrooms_ex_view()

-- DROP FUNCTION public.classrooms_ex_view();

CREATE OR REPLACE FUNCTION public.classrooms_ex_view()
  RETURNS TABLE(school bigint, school_description character varying, logo image, schoool_year bigint, school_year_description character varying, building_description character varying, classroom bigint, classroom_description character varying) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY SELECT   s.school,
			s.description AS school_description,
			s.logo,
			sy.school_year,
			sy.description AS school_year_description,
			b.description AS building_description,
			c.classroom,
			c.description AS classrom_description
		       FROM schools s
			JOIN school_years sy ON sy.school = s.school
			JOIN classrooms c ON c.school_year = sy.school_year
			JOIN branches b ON b.branch = c.branch
			WHERE s.school = ANY (schools_enabled());
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.classrooms_ex_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.classrooms_ex_view() IS 'Exctract info of every class for all schools';
