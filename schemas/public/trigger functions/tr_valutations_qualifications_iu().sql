-- Function: public.tr_valutations_qualifications_iu()

-- DROP FUNCTION public.tr_valutations_qualifications_iu();

CREATE OR REPLACE FUNCTION public.tr_valutations_qualifications_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute of the ''qualification'' is not the same as that of the ''student'' of ''valutation''')::utility.system_message,
    ('en', 2, 'The ''valutation_qualification'': ''%s'' specifies a ''qualification'': ''%s'' with an institution different from that of the ''student'' of ''valutation'': ''%s''')::utility.system_message,
    ('en', 3, 'Correct values of: the ''qualification'' and ''valutation'' and repeat the operation')::utility.system_message,
    ('en', 4, 'The ''valutation_qualification'' that you are inserting specifies a ''qualification'': ''%s'' with an institution different from that of the ''student'' of ''valutation'': ''%s''')::utility.system_message,
    ('en', 5, 'The Institute of the ''qualification'' is not the same as that of the ''metric'' of ''grade''')::utility.system_message,
    ('en', 6, 'The ''valutation_qualification'': ''%s'' specifies a ''qualification'': ''%s'' with an institute which is different from that of the ''metric'' of ''grade'': ''%s''')::utility.system_message,
    ('en', 7, 'Correct values of: the ''qualification'' and ''grade'' and repeat the operation')::utility.system_message,
    ('en', 8, 'The ''valutation_qualification'' that you are inserting specifies a ''qualification'': ''%s'' with an institute which is different from that of the ''metric'' of ''grade'': ''%s''')::utility.system_message,
    ('it', 1, 'L''istituto della ''qualifica'' non è lo stesso di quello dell'' ''alunno'' della ''valutazione''')::utility.system_message,
    ('it', 2, 'La ''valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''qualifica'' e ''valutazione'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'La ''valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 5, 'L''istituto della ''qualifica'' non è lo stesso di quello della ''metrica'' del ''voto''')::utility.system_message,
    ('it', 6, 'La ''valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message,
    ('it', 7, 'Correggere i valori di: ''qualifica'' e ''voto'' e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'La ''valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message];
BEGIN
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

--
-- check that the school of the qualification both the same of that of the student of the valutation
--
  PERFORM 1
     FROM valutations v
     JOIN classrooms_students cs ON cs.classroom_student = v.classroom_student
     JOIN persons p ON p.person = cs.student
     JOIN qualifications q ON p.school = q.school
    WHERE v.valutation = new.valutation
      AND q.qualification = new.qualification;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.valutation_qualificationtion, new.qualification,  new.valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.qualification,  new.valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
--
-- check that the school of the qualification both the same of that of the metric of the grade
--
PERFORM 1 FROM grades v
   JOIN metrics m ON m.metric = v.metric 
   JOIN qualifications q ON m.school = q.school
  WHERE v.grade = new.grade
    AND q.qualification = new.qualification;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.valutation_qualificationtion, new.qualification,  new.grade),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.qualification,  new.grade),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_valutations_qualifications_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_valutations_qualifications_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_valutations_qualifications_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_valutations_qualifications_iu() FROM public;
