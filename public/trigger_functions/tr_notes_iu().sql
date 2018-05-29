-- Function: public.tr_notes_iu()

-- DROP FUNCTION public.tr_notes_iu();

CREATE OR REPLACE FUNCTION public.tr_notes_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school		bigint;
  delete_signed		boolean := FALSE;
  insert_signed		boolean := FALSE;
-- variables for system tools
  context       	text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'There is no lesson on the day of the note')::utility.system_message,
    ('en', 2, 'In the day: ''%s'' of note: ''%s'' the class: ''%s'' had no lesson')::utility.system_message,
    ('en', 3, 'Before inserting a note you must enter the lessons provide therefore for the insertion of the requested data or check the values proposed and possibly correct')::utility.system_message,
    ('en', 4, 'In the day: ''%s'' of the note that you want to insert the class: ''%s'' had no lesson')::utility.system_message,
    ('en', 9, 'The pupil does not belong to the same institute of class')::utility.system_message,
    ('en', 10, 'In Note: ''%s'' that you are upgrading the pupil: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 11, 'Check the pupil or the class indicated and retry the operation')::utility.system_message,
    ('en', 12, 'In Note that you are inserting the pupil: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 13, 'The teacher does not belong to the same institute of class')::utility.system_message,
    ('en', 14, 'In note: ''%s'' that you are upgrading the teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 15, 'Check the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 16, 'In the note that you are entering the teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 17, 'The pupil may not be reported as missing in the same day')::utility.system_message,
    ('en', 18, 'In "Notae: ''%s'' that you are upgrading the pupil: ''%s'' in the day: ''%s'' is Also inserted as absent')::utility.system_message,
    ('en', 19, 'Correct the pupil or the day and retry the operation')::utility.system_message,
    ('en', 20, 'In the note that you are inserting the pupil: ''%s'' in the day: ''%s'' is also entered as absent')::utility.system_message,
    ('it', 1, 'Non c''è nessuna lezione nel giorno della nota')::utility.system_message,
    ('it', 2, 'Nel giorno: ''%s'' della nota: ''%s'' la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 3, 'Prima di inserire una nota è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli')::utility.system_message,
    ('it', 4, 'Nel giorno: ''%s'' della nota che si vuole inserire la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 9, 'L''alunno non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 10, 'Nella nota: ''%s'' che si sta aggiornando l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 11, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nella nota che si sta inserendo l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 13, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 14, 'Nella nota: ''%s'' che si sta aggiornando il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 15, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 16, 'Nella nota che si sta inserendo il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 17, 'L''alunno non può essere segnalato come assente nello stesso giorno')::utility.system_message,
    ('it', 18, 'Nella notae: ''%s'' che si sta aggiornando l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message,
    ('it', 19, 'Correggere l''alunno o il giorno e ritentare l''operazione')::utility.system_message,
    ('it', 20, 'Nella nota che si sta inserendo l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- recovery the school of classroom
--
  SELECT sy.school 
    INTO me.school 
    FROM classrooms c
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE c.classroom = new.classroom;
--
-- control that in the on_dates of the notes there is at least one lesson
--
  PERFORM 1 FROM lessons l
     WHERE classroom = new.classroom
       AND on_date = new.on_date;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.note,  new.classroom),
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
-- If the student has been specified
--
  IF new.student IS NOT NULL THEN
    --
    -- control that the school of the student is equal to that of the classroom
    --
    PERFORM 1 
       FROM persons p 
      WHERE p.person = new.student 
        AND p.school = me.school;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.note, new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;    
    END IF;
    --
    -- Student in note cannot be absent
    --
    PERFORM 1 
       FROM absences a
       JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student 
      WHERE a.on_date = new.on_date 
        AND cs.student = new.student;
        
    IF FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,17),
          DETAIL = format(utility.system_messages_locale(system_messages,18), new.note, new.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,19);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,17),
          DETAIL = format(utility.system_messages_locale(system_messages,20), new.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,19);
      END IF;       
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
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.note, new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    
  END IF;   
--
-- Handling of visas 
--
  IF TG_OP = 'INSERT' THEN
    IF new.to_approve = TRUE THEN
      me.insert_signed := TRUE;
    END IF;
  END IF;
  
  IF TG_OP = 'UPDATE' THEN
    --
    -- if are required visas control that they were even before
    --
    IF new.to_approve = TRUE THEN
      --
      -- if were required visas checking if changed the classroom, student or description
      -- in quto_time if you need to delete the old visas and insert the new
      -- paying attention that the'student may be null
      --
      IF old.to_approve = TRUE THEN
        IF new.description != old.description THEN
          me.delete_signed := TRUE;
          me.insert_signed := TRUE;
        END IF;
        IF new.classroom != old.classroom THEN
          me.delete_signed := TRUE;
          me.insert_signed := TRUE;
        END IF;
        IF new.student IS NULL THEN
          IF old.student IS NULL THEN
          ELSE
            me.delete_signed := TRUE;
          END IF;
          ELSE
            IF old.student IS NULL THEN
              me.insert_signed := TRUE;
            ELSE
              IF new.student != old.student THEN
                me.delete_signed := TRUE;
                me.insert_signed := TRUE;
              END IF;
            END IF;
          END IF ;
        END IF;
        --
        -- If you were not required visas allat_time I put them
        --
        IF old.to_approve = FALSE THEN
            me.insert_signed := TRUE;
        END IF;
    END IF;
    --
    -- if they are not required visas control if it were
    --
    IF new.to_approve = FALSE THEN
      --
      -- If they were required visas allat_time i have to delete the old
      --
      IF old.to_approve = TRUE THEN
        me.delete_signed := TRUE;
      END IF;
    END IF;
  END IF;
--
-- gate physically the old visas if was determiborn erasing
--
  IF me.delete_signed THEN 
    DELETE FROM notes_signed WHERE note = old.note;
  END IF;
--
-- insert the new visas if was determiborn them
--
  IF me.insert_signed THEN
    IF new.student IS NULL THEN
      INSERT INTO notes_signed (note, person) 
        SELECT new.note, person_related_to
          FROM persons_relations 
         WHERE sign_request = TRUE 
           AND person IN (SELECT student
                            FROM classrooms_students
                           WHERE classroom = new.classroom 
                             AND student NOT IN (SELECT student
                                                   FROM absences 
                                                   WHERE on_date = new.on_date));
    ELSE
      INSERT INTO notes_signed (note, person) 
        SELECT new.note, person_related_to
          FROM persons_relations 
         WHERE sign_request = TRUE 
           AND person = new.student;
    END IF;
  END IF;
  
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_notes_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_notes_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_notes_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_notes_iu() FROM public;
