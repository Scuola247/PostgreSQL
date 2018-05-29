-- Function: public.tr_delays_iu()

-- DROP FUNCTION public.tr_delays_iu();

CREATE OR REPLACE FUNCTION public.tr_delays_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school		bigint;
  classroom		bigint;
  student		bigint;
-- variables for system tool
  context		text;
  full_function_name    text;
  system_messages    utility.system_message[] = ARRAY [
    ('en', 1, 'There is no lesson on the day of the delay.')::utility.system_message,
    ('en', 2, 'In day: %L delay: %L class: %L did not have lesson.')::utility.system_message,
    ('en', 3, 'Before inserting a delay you need to enter the lessons then enter the required data or check the proposed values ​​and, if necessary, correct them.')::utility.system_message,
    ('en', 4, 'In day: %L of delay that you want to enter class: %L has no lesson.')::utility.system_message,
    ('en', 5, 'The justification indicated is invalid.')::utility.system_message,
    ('en', 6, 'Delay: %L has the justification: %L which is not valid because it is not relative to the student: %L or the margin of the criterion: %L is not greater than or equal To the creation of justification or even the day of the criterion is not included in the data '' from '' and '' to the justification .')::utility.system_message,
    ('en', 7, 'Check that justifications have the correct values ​​for the fields: ''created at'', ''from'' and ''to'' .')::utility.system_message,
    ('en', 8, 'The delay you are entering has the justification: %L which is not valid because it is not relative to the student: %L or the margin of the criterion: %L is not greater than Equal to that of creating justifications, or even the day of judgment is not included in data '' from '' and '' to justification .')::utility.system_message,
    ('en', 9, 'The student does not belong to the same institute of the class.')::utility.system_message,
    ('en', 10, 'Late: %L who is updating the student: %L (one person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 11, 'Check the student or class indicated and retry the operation.')::utility.system_message,
    ('en', 12, 'In the delay you are entering the student: %L (a person in the person table) does not belong to the same institution: %L of the class: %L.')::utility.system_message,
    ('en', 13, 'The teacher does not belong to the same class institute.')::utility.system_message,
    ('en', 14, 'In Late: %L who is updating the teacher: %L (one person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 15, 'Check the instructor or class indicated and retry the operation.')::utility.system_message,
    ('en', 16, 'In the delay you are entering the teacher: %L (a person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 17, 'It is not possible to enter a delay if, on the day indicated, the student has already been reported as absent.')::utility.system_message,
    ('en', 18, 'In delay: %L who is updating the classroom_student: %L in day: %L is also entered as absent.')::utility.system_message,
    ('en', 19, 'Correct the classroom_student or the day and retry the operation.')::utility.system_message,
    ('en', 20, 'In the delay that you are entering the classroom_student: %L in the day: %L is also entered as absent.')::utility.system_message,
    ('en', 33, 'The instructor indicated is not in the ''teachers'' role.')::utility.system_message,
    ('en', 34, 'In absence: %L is updating, the instructor indicated: %L did not assign the ''Teacher'' role.')::utility.system_message,
    ('en', 35, 'Checking the teacher''s value and reproposing the'' operation'' .')::utility.system_message,
    ('en', 36, 'In the absence that is being entered, the instructor indicated: %L did not assign the ''Teacher'' role.')::utility.system_message,
    ('it', 1, 'Non c''è nessuna lezione nel giorno del ritardo.')::utility.system_message,
    ('it', 2, 'Nel giorno: %L del ritardo: %L la classe: %L non ha avuto lezione.')::utility.system_message,
    ('it', 3, 'Prima di inserire un ritardo è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli.')::utility.system_message,
    ('it', 4, 'Nel giorno: %L del ritardo che si vuole inserire la classe: %L non ha avuto lezione.')::utility.system_message,
    ('it', 5, 'La giustificazione indicata non è valida.')::utility.system_message,
    ('it', 6, 'Il ritardo: %L ha la giustificazione: %L che non è valida perchè: non è relativa all''alunno: %L oppure il gorno dell''ritardo: %L non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''ritardo non è compreso nei dati ''dal'' e ''al'' della giustificazione.')::utility.system_message,
    ('it', 7, 'Controllare che la giustificazione abbia i corretti valori per i campi: ''creata_il'', ''dal'' e ''al''.')::utility.system_message,
    ('it', 8, 'Il ritardo che si sta inserendo ha la giustificazione: %L che non è valida perchè: non è relativa all''alunno: %L oppure il gorno dell''ritardo: %L non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''ritardo non è compreso nei dati ''dal'' e ''al'' della giustificazione.')::utility.system_message,
    ('it', 9, 'L''alunno non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 10, 'Nel ritardo: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 11, 'Controllare l''alunno o la classe indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 12, 'Nel ritardo che si sta inserendo l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 13, 'Il docente non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 14, 'Nel ritardo: %L che si sta aggiornando il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 15, 'Controllare il docente o la classe indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 16, 'Nel ritardo che si sta inserendo il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 17, 'Non è possibile inserire un ritardo se, nel giorno indicato, l''alunno è già stato segnalato come assente.')::utility.system_message,
    ('it', 18, 'Nel ritardo: %L che si sta aggiornando il classroom_student: %L nel giorno: %L è anche inserito come assente.')::utility.system_message,
    ('it', 19, 'Correggere l''alunno o il giorno e ritentare l''operazione.')::utility.system_message,
    ('it', 20, 'Nel ritardo che si sta inserendo il classroom_student: %L nel giorno: %L è anche inserito come assente.')::utility.system_message,
    ('it', 33, 'Il docente indicato non è nel ruolo ''docenti''.')::utility.system_message,
    ('it', 34, 'Nell''assenza: %L che si sta aggiornando, il docente indicato: %L non ha assegnato il ruolo ''Teacher''.')::utility.system_message,
    ('it', 35, 'Controllare il valore del docente e riproporre l''operazione.')::utility.system_message,
    ('it', 36, 'Nell''assenza che si sta inserendo, il docente indicato: %L non ha assegnato il ruolo ''Teacher''.')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of the classroom
--
  SELECT s.school, cs.classroom , cs.student
    INTO me.school , me.classroom, me.student
    FROM delays d
    JOIN classrooms_students cs ON cs.classroom_student = d.classroom_student
    JOIN classrooms c ON c.classroom = cs.classroom
    JOIN school_years s ON s.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- Check that the on_dates of delay there is at least one lesson
--
  PERFORM 1 
     FROM lessons l
    WHERE l.classroom = me.classroom
      AND on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.delay,  me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- control that the explanation, if indicated, both related to that student, at that on_dates of delay and created after or to_time maximum on_dates same as delay
--
  IF new.explanation IS NOT NULL THEN

    PERFORM 1 
       FROM explanations e
      WHERE e.explanation = new.explanation 
        AND e.student = me.student 
        AND created_on >= new.on_date 
        AND new.on_date BETWEEN from_time AND to_time ;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.delay, new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;    
    END IF;
  END IF;
--
-- Check that the school's teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.delay, new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    
  END IF;   
--
-- Student in delay cannot be absent
--
  PERFORM 1 
     FROM absences
    WHERE on_date = new.on_date 
      AND classroom_student = new.classroom_student;
      
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.delay, new.classroom_student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), new.classroom_student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;    
  END IF;   
--
-- Check that the teacher is in rule 'teacher'
--
  IF NOT in_any_roles(new.teacher,'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.delay, new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_delays_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_delays_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_delays_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_delays_iu() FROM public;
