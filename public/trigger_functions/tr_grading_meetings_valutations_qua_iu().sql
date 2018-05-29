-- Function: public.tr_grading_meetings_valutations_qua_iu()

-- DROP FUNCTION public.tr_grading_meetings_valutations_qua_iu();

CREATE OR REPLACE FUNCTION public.tr_grading_meetings_valutations_qua_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The istitute of the ''qualifica'' it is not the same of that of the ''alunno'' of the''valutazione''')::utility.system_message,
    ('en', 2, 'The ''scrutinio_valutazione_qualifica'': ''%s'' specific a ''qualifica'': ''%s'' with a different istitute from that the ''alunno'' of the ''valutazione'': ''%s''')::utility.system_message,
    ('en', 3, 'To correct the values of: ''qualifica'' and ''valutazione'' and repeat the operation')::utility.system_message,
    ('en', 4, 'The ''scrutinio_valutazione_qualifica''that he is inserting specification a ''qualifica'': ''%s'' with a different institute from that of the ''alunno'' of the ''valutazione'': ''%s''')::utility.system_message,
    ('en', 9, 'The istitute of the ''qualifica'' it is not the same of that of the ''metrica'' of the ''voto''')::utility.system_message,
    ('en', 10, 'The ''scrutinio_valutazione_qualifica'': ''%s'' specific a ''qualifica'': ''%s'' with a different institute from that of the ''metrica'' of the ''voto'': ''%s''')::utility.system_message,
    ('en', 11, 'To correct the values of: ''qualifica'' and ''voto'' and repeat the operation')::utility.system_message,
    ('en', 12, 'The ''scrutinio_valutazione_qualifica'' that he is inserting specification a ''qualifica'': ''%s''with a different institute from that of the ''metrica'' of the ''voto'': ''%s''')::utility.system_message,
    ('en', 13, 'The ''scrutinio_valutazione_qualifica'': ''%s'' make reference to the ''scrutinio_valutazione'': ''%s'' that indicating a closed poll')::utility.system_message,
    ('en', 14, 'The poll is closed')::utility.system_message,
    ('en', 15, 'To correct the values of: ''scrutinio_valutazione'' and repeat the operation')::utility.system_message,
    ('en', 16, 'The ''scrutinio_valutazione_qualifica'' that he is inserting make reference to the ''scrutinio_valutazione'': ''%s''  that indicating a closed poll')::utility.system_message,
    ('it', 1, 'L''istituto della ''qualifica'' non è lo stesso di quello dell'' ''alunno'' della ''valutazione''')::utility.system_message,
    ('it', 2, 'La ''scrutinio_valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''qualifica'' e ''valutazione'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'La ''scrutinio_valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 9, 'L''istituto della ''qualifica'' non è lo stesso di quello della ''metrica'' del ''voto''')::utility.system_message,
    ('it', 10, 'La ''scrutinio_valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message,
    ('it', 11, 'Correggere i valori di: ''qualifica'' e ''voto'' e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'La ''scrutinio_valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message,
    ('it', 13, 'La ''scrutinio_valutazione_qualifica'': ''%s fa'' riferimento allo ''scrutinio_valutazione'': ''%s'' che indica uno scrutinio chiuso')::utility.system_message,
    ('it', 14, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 15, 'Correggere il valore di ''scrutinio_valutazione'' e riproporre l''operazione')::utility.system_message,
    ('it', 16, 'La ''scrutinio_valutazione_qualifica'' che si sta'' inserendo fa'' riferimento ad uno ''scrutinio_valutazione'': ''%s''  che indica uno scrutinio chiuso')::utility.system_message];
BEGIN 
--
-- Recover the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the school of the qualification both the same of that of the student of the grading_meeting_valutation
--
  PERFORM 1 
     FROM grading_meetings_valutations v
     JOIN persons p ON v.student = p.person
     JOIN qualifications q ON p.school = q.school
    WHERE v.grading_meeting_valutation = new.grading_meeting_valutation
      AND q.qualification = new.qualification;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.grading_meeting_valutation_qua, new.qualification,  new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.qualification, new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the school of the qualification both the same of that of the metric of the subject of the grade
--
  IF new.grade IS NOT NULL THEN
    PERFORM 1 FROM grades g
       JOIN metrics m ON g.metric = m.metric
       JOIN qualifications q ON m.school = q.school
      WHERE g.grade = new.grade
        AND q.qualification = new.qualification;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.grading_meeting_valutation_qua, new.qualification,  new.grade),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.qualification,  new.grade),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;    
    END IF;
  END IF;
--
-- check the grading_meeting is open
--
  PERFORM 1 
     FROM grading_meetings_valutations v
     JOIN grading_meetings m ON m.grading_meeting = v.grading_meeting
    WHERE v.grading_meeting_valutation = new.grading_meeting_valutation
      AND m.closed = false;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.grading_meeting_valutation_qua, new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    

  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_grading_meetings_valutations_qua_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_qua_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_qua_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_grading_meetings_valutations_qua_iu() FROM public;
