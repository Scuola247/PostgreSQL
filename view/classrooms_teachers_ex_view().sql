-- Function: public.classrooms_teachers_ex_view()

-- DROP FUNCTION public.classrooms_teachers_ex_view();

CREATE OR REPLACE FUNCTION public.classrooms_teachers_ex_view()
  RETURNS TABLE(classroom bigint, teacher bigint, thumbnail image, tax_code character, surname character varying, name character varying, sex sex, born date, city_of_birth_description character varying, lessons bigint, signatures bigint, absences_certified bigint, delays_certified bigint, leavings_certified bigint, out_of_classroom_certified bigint, notes_iussed bigint) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY SELECT       cd.classroom,
			    cd.teacher,
			    p.thumbnail,
			    p.tax_code,
			    p.surname,
			    p.name,
			    p.sex,
			    p.born,
			    co.description AS city_of_birth_description,
			    COALESCE(lgrp.lessons, 0::bigint) AS lessons,
			    COALESCE(fgrp.signatures, 0::bigint) AS signatures,
			    COALESCE(acgrp.absences_certified, 0::bigint) AS absences_certified,
			    COALESCE(rcgrp.delays_certified, 0::bigint) AS delays_certified,
			    COALESCE(ucgrp.leavings_certified, 0::bigint) AS leavings_certified,
			    COALESCE(fccgrp.out_of_classrooms_certified, 0::bigint) AS out_of_classroom_certified,
			    COALESCE(negrp.notes_iussed, 0::bigint) AS notes_iussed
			   FROM classrooms_teachers cd
			     JOIN persons p ON p.person = cd.teacher
			     LEFT JOIN lessons_grp lgrp ON lgrp.classroom = cd.classroom AND lgrp.teacher = cd.teacher
			     LEFT JOIN cities co ON co.fiscal_code = p.city_of_birth_fiscal_code
			     LEFT JOIN signatures_grp fgrp ON fgrp.classroom = cd.classroom AND fgrp.teacher = cd.teacher
			     LEFT JOIN absences_certified_grp acgrp ON acgrp.classroom = cd.classroom AND acgrp.teacher = cd.teacher
			     LEFT JOIN delays_certified_grp rcgrp ON rcgrp.classroom = cd.classroom AND rcgrp.teacher = cd.teacher
			     LEFT JOIN leavings_certified_grp ucgrp ON ucgrp.classroom = cd.classroom AND ucgrp.teacher = cd.teacher
			     LEFT JOIN out_of_classrooms_certified_grp fccgrp ON fccgrp.classroom = cd.classroom AND fccgrp.school_operator = cd.teacher
			     LEFT JOIN notes_iussed_grp negrp ON negrp.classroom = cd.classroom AND negrp.teacher = cd.teacher;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION public.classrooms_teachers_ex_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.classrooms_teachers_ex_view() IS 'Exctract all teachers for classroom';
