-- Function: public.absences_ex_view()

-- DROP FUNCTION public.absences_ex_view();

CREATE OR REPLACE FUNCTION public.absences_ex_view()
  RETURNS TABLE(classroom bigint, on_date date, teacher_thumbnail image, teacher_surname character varying, teacher_name character varying, teacher_tax_code character, student_thumbnail image, student_surname character varying, student_name character varying, student_tax_code character, explanation_description character varying, explanation_created_on timestamp without time zone, created_by_surname character varying, created_by_name character varying, created_by_thumbnail image, explanation_registered_on timestamp without time zone, registered_on_surname character varying, registered_on_name character varying, registered_on_thumbnail image) AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
   
  RETURN QUERY SELECT   cs.classroom,
			a.on_date,
			doc.thumbnail AS teacher_thumbnail,
			doc.surname AS teacher_surname,
			doc.name AS teacher_name,
			doc.tax_code AS teacher_tax_code,
			alu.thumbnail AS student_thumbnail,
			alu.surname AS student_surname,
			alu.name AS student_name,
			alu.tax_code AS student_tax_code,
			g.description AS explanation_description,
			g.created_on AS explanation_created_on,
			pcre.surname AS created_by_surname,
			pcre.name AS created_by_name,
			pcre.thumbnail AS created_by_thumbnail,
			g.registered_on AS explanation_registered_on,
			preg.surname AS registered_on_surname,
			preg.name AS registered_on_name,
			preg.thumbnail AS registered_on_thumbnail
			FROM absences a
			 JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student
			 JOIN classrooms c ON c.classroom = cs.classroom
			 JOIN persons alu ON cs.student = alu.person
			 JOIN persons doc ON a.teacher = doc.person
			 LEFT JOIN explanations g ON g.explanation = a.explanation
			 LEFT JOIN persons pcre ON pcre.person = g.created_by
			 LEFT JOIN persons preg ON preg.person = g.registered_by;
		     
 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1000
  ROWS 100;
ALTER FUNCTION public.absences_ex_view()
  OWNER TO postgres;
COMMENT ON FUNCTION public.absences_ex_view() IS 'Extract every absence for student and other infos';
