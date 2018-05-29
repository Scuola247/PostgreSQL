-- Function: public.tr_lessons_iu()

-- DROP FUNCTION public.tr_lessons_iu();

CREATE OR REPLACE FUNCTION public.tr_lessons_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school      bigint;
-- variables manged by tools
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The material does not belong to the same institute of class')::utility.system_message,
    ('en', 2, 'In lesson: ''%s'' that you are upgrading the matter: ''%s'' does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 3, 'Control matter the class indicated and retry the operation')::utility.system_message,
    ('en', 4, 'In the lesson that you are by inserting the matter: ''%s'' does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 5, 'The teacher does not belong to the same institute of class')::utility.system_message,
    ('en', 6, 'In lesson: ''%s'' that you are upgrading the teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 7, 'Checking the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 8, 'In the lesson that you are inserting The teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 9, 'The Teacher indicated is not in the role of ''docenti''')::utility.system_message,
    ('en', 10, 'In lesson: ''%s'' that you are updating, the person indicated as teacher indicated: ''%s'' is not enabled the role teachers')::utility.system_message,
    ('en', 11, 'Check the value of the teacher and repeat the operation')::utility.system_message,
    ('en', 12, 'In the lesson that you are inserting, the suitable person as teacher indicated: ''%s'' is not enabled the role teachers')::utility.system_message,
    ('it', 1, 'La materia non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 2, 'Nella lezione: ''%s'' che si sta aggiornando la materia: ''%s'' non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare la materia la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Nella lezione che si sta'' inserendo la materia: ''%s'' non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 5, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 6, 'Nella lezione: ''%s'' che si sta aggiornando il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 7, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 8, 'Nella lezione che si sta inserendo il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 9, 'Il docente indicato non è nel ruolo ''docenti''')::utility.system_message,
    ('it', 10, 'Nella lezione: ''%s'' che si sta aggiornando, la persona indicata come docente indicato: ''%s'' non è abilitato al ruolo docenti')::utility.system_message,
    ('it', 11, 'Controllare il valore del docente e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'Nella lezione che si sta inserendo, la persona indicata come docente indicato: ''%s'' non è abilitato al ruolo docenti')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of classroom
--
  SELECT s.school 
    INTO me.school 
    FROM classrooms c
    JOIN school_years s ON s.school_year = c.school_year
   WHERE c.classroom = new.classroom;
--
-- control that the school of subject is equal to that of classroom
--
  PERFORM 1 
     FROM subjects s 
    WHERE s.subject = new.subject 
      AND s.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.lesson, new.subject, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.subject, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;       
  END IF;
--
-- control that the school of teacher is equal to that of classroom
--
  PERFORM 1 
     FROM persons p 
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.lesson, new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;   
--
-- control that the teacher is in rule teachers
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.lesson, new.teacher),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.teacher),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_lessons_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_lessons_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_lessons_iu() TO scuola247_executive;
GRANT EXECUTE ON FUNCTION public.tr_lessons_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_lessons_iu() FROM public;
