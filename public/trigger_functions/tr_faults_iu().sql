-- Function: public.tr_faults_iu()

-- DROP FUNCTION public.tr_faults_iu();

CREATE OR REPLACE FUNCTION public.tr_faults_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
-- variables for system tool
  context       	text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'the pupil is not part of the class indicated in lesson')::utility.system_message,
    ('en', 2, 'In the absence of: ''%s'' the pupil: ''%s'' is not part of the class of the lesson: ''%s''')::utility.system_message,
    ('en', 3, 'Check the values of the pupil and lesson and repeat the operation')::utility.system_message,
    ('en', 4, 'In lack that you are inserting the pupil: ''%s'' is not part of the class of the lesson: ''%s''')::utility.system_message,
    ('en', 5, 'The note indicated is not related to the pupil and the class indicated by the lesson')::utility.system_message,
    ('en', 6, 'In the absence of: ''%s'' Note: ''%s'' is not related to the pupil: ''%s'' or to the class indicated by the lesson: ''%s''')::utility.system_message,
    ('en', 7, 'Check the values of the pupil and lesson and repeat the operation')::utility.system_message,
    ('en', 8, 'In lack that you are inserting the note: ''%s'' is not related to the pupil: ''%s'' or The class indicated by the lesson: ''%s''')::utility.system_message,
    ('en', 9, 'the pupil indicated is not in the role the ''alunni''')::utility.system_message,
    ('en', 10, 'In the absence of: ''%s'' that you are updating, the pupil indicated: ''%s'' is not present in the role pupils (the user connected to the person is not authorised for the role the ''alunni''')::utility.system_message,
    ('en', 11, 'Check the value of the pupil and repeat the operation')::utility.system_message,
    ('en', 12, 'In lack that you are inserting the pupil indicated: ''%s'' is not present in the role pupils (the user connected to the person is not authorised for the role the ''alunni''')::utility.system_message,
    ('it', 1, 'L''alunno non fa'' parte della classe indicata nella lezione')::utility.system_message,
    ('it', 2, 'Nella mancanza: ''%s'' l''alunno: ''%s'' non fa'' parte della classe della lezione: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare i valori di alunno e lezione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nella mancanza che si sta'' inserendo l''alunno: ''%s'' non fa'' parte della classe della lezione: ''%s''')::utility.system_message,
    ('it', 5, 'La nota indicata non è relativa all''alunno ed alla classe indicata dalla lezione')::utility.system_message,
    ('it', 6, 'Nella mancanza: ''%s'' la nota: ''%s'' non è relativa all''alunno: ''%s'' oppure alla classe indicata dalla lezione: ''%s''')::utility.system_message,
    ('it', 7, 'Controllare i valori di alunno e lezione e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Nella mancanza che si sta inserendo la nota: ''%s'' non è relativa all''alunno: ''%s'' oppure alla classe indicata dalla lezione: ''%s''')::utility.system_message,
    ('it', 9, 'L''alunno indicato non è nel ruolo ''alunni''')::utility.system_message,
    ('it', 10, 'Nella mancanza: ''%s'' che si sta aggiornando, l''alunno indicato: ''%s'' non è presente nel ruolo alunni (l''utente collegato alla persona non è autorizzato al ruolo ''alunni'')')::utility.system_message,
    ('it', 11, 'Controllare il valore dell''alunno e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'Nella mancanza che si sta inserendo, l''alunno indicato: ''%s'' non è presente nel ruolo alunni (l''utente collegato alla persona non è autorizzato al ruolo ''alunni'')')::utility.system_message];
BEGIN 
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the student is part of the classroom of the lesson
--
  PERFORM 1 
     FROM lessons l
     JOIN classrooms_students ca ON  ca.classroom = l.classroom
    WHERE l.lesson = new.lesson
      AND ca.student = new.student;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.fault, new.student,  new.lesson),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4),  new.student,  new.lesson),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- Check that the the studen on the note is the same that in fault
-- and the classroom of the note is the same that in the lesson 
--
  IF new.note IS NOT NULL THEN
    PERFORM 1 
       FROM notes n
       JOIN faults f ON f.note = n.note
       JOIN lessons l ON l.lesson = f.lesson
      WHERE n.note = new.note
        AND n.student = new.student
        AND l.lesson = new.lesson
        AND n.classroom = l.classroom;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.fault, new.note, new.student, new.lesson),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.note, new.student, new.lesson),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;      
    END IF;
  END IF;
--
-- check that the student is in the rule students
--
  IF NOT in_any_roles(new.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'F'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.fault, new.student),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'G'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.student),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;
  END IF;
RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_faults_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_faults_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_faults_iu() TO scuola247_executive;
GRANT EXECUTE ON FUNCTION public.tr_faults_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_faults_iu() FROM public;
