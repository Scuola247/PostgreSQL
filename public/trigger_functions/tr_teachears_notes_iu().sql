-- Function: public.tr_teachears_notes_iu()

-- DROP FUNCTION public.tr_teachears_notes_iu();

CREATE OR REPLACE FUNCTION public.tr_teachears_notes_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school			bigint;
-- variables for system tool 
  context			text;
  full_function_name		text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'There is no lesson on the day of the note')::utility.system_message,
    ('en', 2, 'In the day: %L of note: %L the classroom: %L had no lesson')::utility.system_message,
    ('en', 3, 'Before inserting a note you must enter the lessons provide therefore for the insertion of the requested data or check the values proposed and possibly correct')::utility.system_message,
    ('en', 4, 'In the day: %L of the note that you want to insert, the class: %L had no lesson')::utility.system_message,
    ('en', 5, 'The pupil does not belong to the same institute of class')::utility.system_message,
    ('en', 6, 'In the note: %L that you are upgrading the pupil: %L (a person of the people table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('en', 7, 'Check the pupil or the class indicated and retry the operation')::utility.system_message,
    ('en', 8, 'In the note that you are inserting the pupil: %L (a person of the people table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('en', 9, 'The teacher does not belong to the same institute of class')::utility.system_message,
    ('en', 10, 'In the note: %L that you are upgrading the teacher: %L (a person of the people table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('en', 11, 'Check the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 12, 'In the note that you are entering the teacher: %L (a person of the People table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('it', 1, 'Non c''è nessuna lezione nel giorno della nota')::utility.system_message,
    ('it', 2, 'Nel giorno: %L della nota: %L la classe: %L non ha avuto lezione')::utility.system_message,
    ('it', 3, 'Prima di inserire una nota è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli')::utility.system_message,
    ('it', 4, 'Nel giorno: %L della nota che si vuole inserire la classe: %L non ha avuto lezione')::utility.system_message,
    ('it', 5, 'L''alunno non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 6, 'Nella nota: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message,
    ('it', 7, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 8, 'Nella nota che si sta inserendo l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message,
    ('it', 9, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 10, 'Nella nota: %L che si sta aggiornando il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message,
    ('it', 11, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nella nota che si sta inserendo il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- I from_time a part of the school of classroom
--
  SELECT sy.school 
    INTO me.school 
    FROM classrooms c 
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE classroom = new.classroom;
--
-- control that in the on_dates of teacher_notes there is at least one lesson
--
  PERFORM 1 
     FROM lessons l
    WHERE l.classroom = new.classroom
      AND l.on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.teacher_notes,  new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- control that the school of the student is equal to that of classroom
--
  IF new.student IS NOT NULL THEN

    PERFORM 1 
       FROM persons p
      WHERE p.person = new.student 
        AND p.school = me.school;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.teacher_notes, new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;    
    END IF;
  END IF;
--
-- control that the school of the teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.teacher_notes, new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;       
  END IF;   
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_teachears_notes_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_teachears_notes_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_teachears_notes_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_teachears_notes_iu() FROM public;
