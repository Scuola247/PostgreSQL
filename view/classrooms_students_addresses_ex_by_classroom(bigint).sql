-- Function: public.classrooms_students_addresses_ex_by_classroom(bigint)

-- DROP FUNCTION public.classrooms_students_addresses_ex_by_classroom(bigint);

CREATE OR REPLACE FUNCTION public.classrooms_students_addresses_ex_by_classroom(p_classroom bigint)
  RETURNS refcursor AS
$BODY$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT classroom,
                      student,
                      name,
                      surname,
                      tax_code,
                      sex,
                      born,
                      city_of_birth,
                      street,
                      zip_code,
                      city,
                      province,
                      absences
		 FROM classrooms_students_addresses_ex
		WHERE classroom = p_classroom
	     ORDER BY surname, name, tax_code;
 RETURN cur;	            
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;
ALTER FUNCTION public.classrooms_students_addresses_ex_by_classroom(bigint) SET search_path=public, pg_temp;

ALTER FUNCTION public.classrooms_students_addresses_ex_by_classroom(bigint)
  OWNER TO postgres;
