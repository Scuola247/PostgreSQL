-- Function: public.classrooms_students_ex_view()

-- DROP FUNCTION public.classrooms_students_ex_view();

CREATE OR REPLACE FUNCTION public.classrooms_students_ex_view()
  RETURNS TABLE(classroom bigint, student bigint, thumbnail image, tax_code character, name character varying, surname character varying, sex sex, born date, city_of_birth_description character varying, absences bigint, absences_not_explained bigint, delays bigint, delays_not_explained bigint, leavings bigint, leavings_not_explained bigint, out_of_classrooms bigint, notes bigint) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY SELECT       ca.classroom,
			    ca.student,
			    p.thumbnail,
			    p.tax_code,
			    p.name,
			    p.surname,
			    p.sex,
			    p.born,
			    co.description AS city_of_birth_description,
			    COALESCE(agrp.absences, 0::bigint) AS absences,
			    COALESCE(anggrp.absences, 0::bigint) AS absences_not_explained,
			    COALESCE(rgrp.delays, 0::bigint) AS delays,
			    COALESCE(rnggrp.delays, 0::bigint) AS delays_not_explained,
			    COALESCE(ugrp.leavings, 0::bigint) AS leavings,
			    COALESCE(unggrp.leavings, 0::bigint) AS leavings_not_explained,
			    COALESCE(fcgrp.out_of_classrooms, 0::bigint) AS out_of_classrooms,
			    COALESCE(ngrp.notes, 0::bigint) AS notes
			   FROM classrooms_students ca
			     JOIN persons p ON p.person = ca.student
			     LEFT JOIN cities co ON co.fiscal_code = p.city_of_birth_fiscal_code
			     LEFT JOIN absences_grp agrp ON agrp.student = ca.student
			     LEFT JOIN absences_not_explanated_grp anggrp ON anggrp.student = ca.student
			     LEFT JOIN delays_grp rgrp ON rgrp.student = ca.student
			     LEFT JOIN delays_not_explained_grp rnggrp ON rnggrp.student = ca.student
			     LEFT JOIN leavings_grp ugrp ON ugrp.student = ca.student
			     LEFT JOIN leavings_not_explained_grp unggrp ON unggrp.student = ca.student
			     LEFT JOIN out_of_classrooms_grp fcgrp ON fcgrp.student = ca.student
			     LEFT JOIN notes_grp ngrp ON ngrp.student = ca.student
			  WHERE p.school = ANY (schools_enabled());
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.classrooms_students_ex_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.classrooms_students_ex_view() IS 'Excract info of every student for classroom and for all schools';
