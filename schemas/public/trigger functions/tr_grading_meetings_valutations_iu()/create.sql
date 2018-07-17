-- Function: public.tr_grading_meetings_valutations_iu()

-- DROP FUNCTION public.tr_grading_meetings_valutations_iu();

CREATE OR REPLACE FUNCTION public.tr_grading_meetings_valutations_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The ''grading_meeting'' is not of the same ''school_years'' of the ''class''')::utility.system_message,
    ('en', 2, 'The ''grading_meeting_valutation'': ''%s'' refer to the ''grading_meeting'': ''%s'' and a ''classroom_student'': ''%s'' that does not belong to ''school_years''')::utility.system_message,
    ('en', 3, 'To correct the values of: ''grading_meeting'' and ''school_years'' and repeat the operation')::utility.system_message,
    ('en', 4, 'In the ''grading_meeting_valutation'' that you are inserting they are suitable the ''grading_meeting'': ''%s'' and a ''classroom_student'': ''%s'' that does not belong to ''school_years''')::utility.system_message,
    ('en', 5, 'The student does not bolong to the ''class''')::utility.system_message,
    ('en', 6, 'The ''grading_meeting_valutation'': ''%s'' indicates a ''student'': ''%s'' that does not belong to''class'': ''%s''')::utility.system_message,
    ('en', 7, 'To correct the values of: ''student'' and ''class'' and repeat the operation')::utility.system_message,
    ('en', 8, 'In the ''grading_meeting_valutation'' that are inserting ''student'': ''%s'' that does not belong to ''class'': ''%s''')::utility.system_message,
    ('en', 9, 'The ''materia'' does not belong to the same institute of the ''school_years'' of the ''grading_meeting''')::utility.system_message,
    ('en', 10, 'The ''grading_meeting_valutation'': ''%s''indicates a ''materia'': ''%s'' that does not belong to the same istitute of the ''school_years'' of the ''grading_meeting'': ''%s''')::utility.system_message,
    ('en', 11, 'To correct the values of: ''materia'' and ''grading_meeting'' and repeat the operation')::utility.system_message,
    ('en', 12, 'The ''grading_meeting_valutation'' that are inserting indica una ''materia'': ''%s'' that does not belong to the same istitute of the ''school_years'' of the ''grading_meeting'': ''%s''')::utility.system_message,
    ('en', 17, 'The istitute of the ''metrica'' of the ''voto'' are not the same of ''school_years'' of the ''grading_meeting''')::utility.system_message,
    ('en', 18, 'The ''grading_meeting_valutation'': ''%s'' indicates a ''voto'': ''%s'' with a different subject from that of the ''school_years'' of the grading_meeting: ''%s''')::utility.system_message,
    ('en', 19, 'To correct the values of: ''voto'' and ''grading_meeting'' and repeat the operation')::utility.system_message,
    ('en', 20, 'The ''grading_meeting_valutation'' that are inserting indicates a ''voto'': ''%s''  with a metric that have the different istitute from that of the ''school_years'' of the grading_meeting: ''%s''')::utility.system_message,
    ('en', 21, 'The grading_meeting is closed')::utility.system_message,
    ('en', 22, 'The ''grading_meeting_valutation'': ''%s refer to the ''grading_meeting'': ''%s'' that is closed')::utility.system_message,
    ('en', 23, 'To correct the values of: ''grading_meeting '' and repeat the operation')::utility.system_message,
    ('en', 24, 'The ''grading_meeting_valutation'' that are inserting indicates a ''grading_meeting'': ''%s''  that is closed')::utility.system_message,
    ('it', 1, 'Lo ''scrutinio'' non è dello stesso ''anno_scolastico'' della ''classe''')::utility.system_message,
    ('it', 2, 'La ''scrutinio_valutazione'': ''%s'' indica uno ''scrutinio'': ''%s'' e una ''classroom_student'': ''%s'' che non appartengono allo stesso ''anno_scolastico''')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''scrutinio'' e ''anno_scolastico'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nella ''scrutinio_valutazione'' che si sta inserendo sono indicati uno ''scrutinio'': ''%s'' e una ''classroom_student'': ''%s'' che non appartengono allo stesso ''anno_scolastico''')::utility.system_message,
    ('it', 5, 'L''alunno non fa'' parte della ''classe''')::utility.system_message,
    ('it', 6, 'La ''scrutinio_valutazione'': ''%s'' indica un ''alunno'': ''%s'' che non appartiene all ''classe'': ''%s''')::utility.system_message,
    ('it', 7, 'Correggere i valori di: ''alunno'' e ''classe'' e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Nella ''scrutinio_valutazione'' che si sta inserendo l''alunno'': ''%s'' non appartiene alla ''classe'': ''%s''')::utility.system_message,
    ('it', 9, 'La ''materia'' non appartiene allo stesso istituto dell'' ''anno_scolastico'' dello ''scrutinio''')::utility.system_message,
    ('it', 10, 'La ''scrutinio_valutazione'': ''%s'' indica una ''materia'': ''%s'' che non appartiene allo stesso istituto dell'' ''anno_scolastico'' dello ''scrutinio'': ''%s''')::utility.system_message,
    ('it', 11, 'Correggere i valori di: ''materia'' e ''scrutinio'' e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'La ''scrutinio_valutazione'' che si sta inserendo indica una ''materia'': ''%s'' che non appartiene allo stesso istituto dell'' ''anno_scolastico'' dello ''scrutinio'': ''%s''')::utility.system_message,
    ('it', 17, 'L''istituto della ''metrica'' del ''voto'' non è lo stesso dell'' ''anno_scolastico'' dello ''scrutinio''')::utility.system_message,
    ('it', 18, 'La ''scrutinio_valutazione'': ''%s'' indica un ''voto'': ''%s'' con una metrica che ha un istituto diverso da quello dell'' ''anno_scolastico'' dello scrutinio: ''%s''')::utility.system_message,
    ('it', 19, 'Correggere i valori di: ''voto'' e ''scrutinio'' e riproporre l''operazione')::utility.system_message,
    ('it', 20, 'La ''scrutinio_valutazione'' che si sta'' inserendo indica un ''voto'': ''%s'' con una metrica che ha un istituto diverso da quello dell'' ''anno_scolastico'' dello scrutinio: ''%s''')::utility.system_message,
    ('it', 21, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 22, 'La ''scrutinio_valutazione'': ''%s fa'' riferimento allo ''scrutinio'': ''%s'' che è chiuso')::utility.system_message,
    ('it', 23, 'Correggere il valore di ''scrutinio '' e riproporre l''operazione')::utility.system_message,
    ('it', 24, 'La ''scrutinio_valutazione'' che si sta'' inserendo indica uno ''scrutinio'': ''%s''  che è chiuso')::utility.system_message];  
BEGIN 
  --
  -- recover the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the classroom is of the same school_year of the grading_meeting
--
  PERFORM 1 FROM grading_meetings s
     JOIN classrooms c ON s.school_year = c.school_year
    WHERE s.grading_meeting = new.grading_meeting
      AND c.classroom = new.classroom;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.grading_meeting_valutation, new.grading_meeting,  new.classroom_student),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.grading_meeting,  new.classroom_student),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the student belongs to the classroom
--
  PERFORM 1 FROM classrooms_students ca
    WHERE ca.classroom = new.classroom
      AND ca.student = new.student;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.grading_meeting_valutation, new.classroom,  new.student),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.classroom, new.student),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
--
-- check that the subject belongs to the same school of the school_year of the grading_meeting
--
  PERFORM 1 FROM grading_meetings s
    JOIN school_years a ON s.school_year = a.school_year
    JOIN subjects m ON a.school = m.school
   WHERE s.grading_meeting = new.grading_meeting
     AND m.subject = new.subject;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.grading_meeting_valutation, new.subject,  new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.subject, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;    
  END IF;
--
-- check the school of the metric of the grade both the same of the school_year of the grading_meeting
--
  PERFORM 1 FROM grades v
     JOIN metrics m ON v.metric = m.metric
     JOIN school_years a ON m.school = a.school
     JOIN grading_meetings s ON a.school_year = s.school_year
    WHERE v.grade =  new.grade
      AND s.grading_meeting = new.grading_meeting;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.grading_meeting_valutation, new.grade, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), new.grade, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;    
  END IF;   
--
-- check that the grading_meeting is open
--
  PERFORM 1 
     FROM grading_meetings gm
    WHERE gm.grading_meeting = new.grading_meeting
      AND gm.closed = false;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,22), new.grading_meeting_valutation, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,23);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,24), new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,23);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_grading_meetings_valutations_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_iu() TO scuola247_relative;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION public.tr_grading_meetings_valutations_iu() FROM public;
