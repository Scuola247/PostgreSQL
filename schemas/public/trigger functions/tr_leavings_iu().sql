-- Function: public.tr_leavings_iu()

-- DROP FUNCTION public.tr_leavings_iu();

CREATE OR REPLACE FUNCTION public.tr_leavings_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school      		bigint;
  classroom		bigint;
  student		bigint;
-- variables for system tool
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'There is not any lesson in the day of the exit')::utility.system_message,
    ('en', 2, 'In the day : ''%s'' of the exit: ''%s'' the class: ''%s'' has not had lesson')::utility.system_message,
    ('en', 3, 'Before inserting an exit it is necessary to insert the lessons to provide therefore to the insertion of the in demand data or to check the proposed values and eventually to correct them')::utility.system_message,
    ('en', 4, 'In the day: ''%s'' of the exit than is wanted to insert the class: ''%s'' has not had lesson')::utility.system_message,
    ('en', 5, 'The justification is not valid')::utility.system_message,
    ('en', 6, 'The exit: ''%s'' has justification: ''%s'' then is not valid because: is not refer to the student: ''%s'' or the day of the exit: ''%s'' it is not great or equal to that of creation of the justification or still the day of the exit is not inclusive in the data ''from'' and ''to'' of the justification')::utility.system_message,
    ('en', 7, 'To check that justification has the correct values for the fields: ''created_on'', ''from'' e ''to''')::utility.system_message,
    ('en', 8, 'The exit that he is inserting has the justification: ''%s'' than is not valid because: is not refer to the student: ''%s'' or the day of exit: ''%s'' it is not great or equal to that of creation of the justification or still the day of the exit is not inclusive in the data ''from'' and ''to'' of the justification')::utility.system_message,
    ('en', 9, 'The pupil does not belong to the same institute of the class')::utility.system_message,
    ('en', 10, 'To the exit: ''%s'' that is update the student: ''%s'' (a person of the people table) it does not belong to the same istitute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 11, 'Check the student or class indicated and retry the operation')::utility.system_message,
    ('en', 12, 'In the exit that you are inserting the pupil: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 13, 'The teacher does not belong to the same institute of the class')::utility.system_message,
    ('en', 14, 'In the exit: ''%s'' that you are upgrading the teacher: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 15, 'Check the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 16, 'In the exit that you are entering the teacher: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 17, 'The pupil can not be reported as missing in the same day')::utility.system_message,
    ('en', 18, 'In the exit: ''%s'' than are updating the pupil: ''%s'' in the day: ''%s'' is also entered as absent')::utility.system_message,
    ('en', 19, 'Correct the pupil or the day and retry the operation')::utility.system_message,
    ('en', 20, 'In the exit that you are inserting the pupil: ''%s'' in the day: ''%s''  is also entered as absent')::utility.system_message,
    ('en', 33, 'The teacher indicated is not in the role of ''docenti''')::utility.system_message,
    ('en', 34, 'In the absence of: ''%s'' that you are upgrading the teacher stated: ''%s'' not has assigned your role ''teacher''')::utility.system_message,
    ('en', 35, 'Check the value of the teacher and repeat the operation')::utility.system_message,
    ('en', 36, 'In the absence which you are inserting the teacher stated: ''%s'' not has assigned your role ''teacher''')::utility.system_message, 
    ('it', 1, 'Non c''è nessuna lezione nel giorno dell''uscita')::utility.system_message,
    ('it', 2, 'Nel giorno: ''%s'' dell''uscita: ''%s'' la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 3, 'Prima di inserire un''uscita è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli')::utility.system_message,
    ('it', 4, 'Nel giorno: ''%s'' dell''uscita che si vuole inserire la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 5, 'La giustificazione indicata non è valida')::utility.system_message,
    ('it', 6, 'L''uscita: ''%s'' ha la giustificazione: ''%s'' che non è valida perchè: non è relativa all''alunno: ''%s'' oppure il gorno dell''uscita: ''%s'' non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''uscita non è compreso nei dati ''dal'' e ''al'' della giustificazione')::utility.system_message,
    ('it', 7, 'Controllare che la giustificazione abbia i corretti valori per i campi: ''creata_il'', ''dal'' e ''al''')::utility.system_message,
    ('it', 8, 'L''uscita che si sta inserendo ha la giustificazione: ''%s'' che non è valida perchè: non è relativa all''alunno: ''%s'' oppure il gorno dell''uscita: ''%s'' non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''uscita non è compreso nei dati ''dal'' e ''al'' della giustificazione')::utility.system_message,
    ('it', 9, 'L''alunno non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 10, 'Nell'' uscita: ''%s'' che si sta aggiornando l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 11, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nell'' uscita che si sta inserendo l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 13, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 14, 'Nell'' uscita: ''%s'' che si sta aggiornando il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 15, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 16, 'Nell'' uscita che si sta inserendo il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 17, 'L''alunno non può essere segnalato come assente nello stesso giorno')::utility.system_message,
    ('it', 18, 'Nell''uscita: ''%s'' che si sta aggiornando l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message,
    ('it', 19, 'Correggere l''alunno o il giorno e ritentare l''operazione')::utility.system_message,
    ('it', 20, 'Nell''uscita che si sta inserendo l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message,
    ('it', 33, 'Il docente indicato non è nel ruolo ''docenti''')::utility.system_message,
    ('it', 34, 'Nell''assenza: ''%s'' che si sta aggiornando, il docente indicato: ''%s'' non ha assegnato il ruolo ''Teacher''')::utility.system_message,
    ('it', 35, 'Controllare il valore del docente e riproporre l''operazione')::utility.system_message,
    ('it', 36, 'Nell''assenza che si sta inserendo, il docente indicato: ''%s'' non ha assegnato il ruolo ''Teacher''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of the classroom
--
  SELECT sy.school, cs.classroom, cs.student
    INTO me.school, me.classroom, me.student
    FROM classrooms_students cs
    JOIN classrooms c ON c.classroom = cs.classroom 
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- check that in the on_date of leaving there is least one lesson
--
  PERFORM 1 
     FROM lessons l
     JOIN classrooms c ON c.classroom = l.classroom
     JOIN classrooms_students cs ON cs.classroom = c.classroom
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.leaving,  me.classroom),
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
-- check that the explanation, if indicated, both related to that student, at that on_date of leaving amd created after or to_time maximun on_date same of leaving
--   
  IF new.explanation IS NOT NULL THEN
  
    PERFORM 1 
       FROM explanations e
       JOIN classrooms_students cs ON cs.student = e.student
      WHERE e.explanation=new.explanation 
        AND cs.classroom_student = new.classroom_student 
        AND e.created_on >= new.on_date 
        AND new.on_date BETWEEN e.from_time AND e.to_time ;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.leaving, new.explanation, me.student, new.on_date),
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
-- Checking that the student's school equals that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = me.student 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.leaving, me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;       
  END IF;
--
-- Check that the school of the teacher is equal to that of the classroom
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
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.leaving, new.teacher, me.school, me.classroom),
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
-- The student that leaving_at cannot be absent
--  
  PERFORM 1 
     FROM absences a
     JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student
    WHERE a.on_date = new.on_date 
      AND cs.classroom_student = new.classroom_student;
      
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.leaving, me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;    
  END IF;   
--
-- Check that the teacher is in rule 'teacher'
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.leaving, new.teacher),
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
ALTER FUNCTION public.tr_leavings_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_leavings_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_leavings_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_leavings_iu() FROM public;
