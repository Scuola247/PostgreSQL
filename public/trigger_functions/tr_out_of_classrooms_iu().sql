-- Function: public.tr_out_of_classrooms_iu()

-- DROP FUNCTION public.tr_out_of_classrooms_iu();

CREATE OR REPLACE FUNCTION public.tr_out_of_classrooms_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school     	bigint;
  student	bigint;
  classroom	bigint;
-- variables for system tools
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The pupil is not in the ''pupils'' role.')::utility.system_message,
    ('en', 2, 'On ''on_date'': %L of ''out_of_classroom'': %L there isn''t any lessons.')::utility.system_message,
    ('en', 3, 'Check that the student user is included in the pupil role and retry the operation.')::utility.system_message,
    ('en', 4, 'On ''on_date'': %L there isn''t any lessons.')::utility.system_message,
    ('en', 5, 'The student institution is not the same as the person indicated by the field: ''created_by'' .')::utility.system_message,
    ('en', 6, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''.')::utility.system_message,
    ('en', 7, 'Control  ''pupil'' and the person indicated in ''created_by'' and retry the operation.')::utility.system_message,
    ('en', 8, 'In justification that you are entering, the pupil %L does not belong to the same institute: %L of the person: %L indicated in the ''created_by'' field .')::utility.system_message ,
    ('en', 9, 'The pupil is not of age and therefore can not include justifications.')::utility.system_message,
    ('en', 10, 'In justification: %L being updated, ''pupil'': %L is no age and therefore can not enter justifications.')::utility.system_message,
    ('en', 11, 'Check the value of ''created_by'' and retry the operation.')::utility.system_message,
    ('en', 12, 'In justification that is being inserted, ''pupil'': %L is no age and therefore can not include justifications.')::utility.system_message,
    ('en', 13, 'The person indicated in ''created_by'' is not authorized.')::utility.system_message,
    ('en', 14, 'In justification: %L being updated, the person: %L indicated in the ''created_by'' field is not a family member enabled and majority and is not even in the roles of: ''leaders'', ''employees'', ''teachers'' .')::utility.system_message,
    ('en', 15, 'Check the person indicated in the column ''created_by'' and retry the operation.')::utility.system_message,
    ('en', 16, 'In the justification that is being entered, the person: %L indicated in the field ''created_by'' is not a qualified family and is not even in the roles of ''managers'', ''leaders'', ''employees'', ''teachers'' .')::utility.system_message,
    ('en', 17, 'The person who filed the justification is not the same institution as the pupil.')::utility.system_message,
    ('en', 18, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registered_by''.')::utility.system_message,
    ('en', 19, 'Check the person indicated in the column ''registered_by'' and repeat the operation.')::utility.system_message,
    ('en', 20, 'In justification that is being entered, the pupil: %L does not belong to the same institute: %L of the person: %L indicated in the field ''registered_by'' .')::utility.system_message ,
    ('en', 21, 'The person indicated in the ''registered_by'' column is not a member of any of the following roles: ''managers'', ''executives'',  ''employees'' .')::utility.system_message,
    ('en', 22, 'In justification: %L being updated, the person indicated in the column: '' registered_by'' does not belong to any of the following roles: ''managers'', ''executives'', ''employees'', ''teachers''.')::utility.system_message,
    ('en', 23, 'Check the value of the column: ''registered_by'' and re-propose the operation.')::utility.system_message,
    ('en', 24, 'In the justification that is being entered, the person indicated in the column: ''registered_by'' does not belong to any of the following roles: ''managers'', ''executives'', ''teachers'' .')::utility.system_message,
    ('it', 1, 'L''alunno non è inserito nel ruolo ''alunni''.')::utility.system_message,
    ('it', 2, 'Nella ''on_date'': %L della ''out_of_classroom'': %L non esiste alcuna lezione.')::utility.system_message,
    ('it', 3, 'Controllare che l''utente dell''alunno sia inserito nel ruolo alunni e ritentare l''operazione.')::utility.system_message,
    ('it', 4, 'Nella ''on_date'': %L non esiste alcuna lezione.')::utility.system_message,
    ('it', 5, 'L''istituto dell''alunno no è lo stesso della persona indicata dal campo: ''creato_da''.')::utility.system_message,
    ('it', 6, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''.')::utility.system_message,
    ('it', 7, 'Controllare l'' ''alunno'' e la persona indicata in ''creata_da'' e ritentare l''operazione.')::utility.system_message,
    ('it', 8, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''.')::utility.system_message,
    ('it', 9, 'L''alunno non è maggiorenne e quindi non può inserire giustificazioni.')::utility.system_message,
    ('it', 10, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni.')::utility.system_message,
    ('it', 11, 'Controllare il valore di ''creato_da'' e ritentare l''operazione.')::utility.system_message,
    ('it', 12, 'Nella giustificazione che si sta inserendo, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni.')::utility.system_message,
    ('it', 13, 'La persona indicata in ''creata_da'' non è autorizzata.')::utility.system_message,
    ('it', 14, 'Nella giustificazione: %L che si sta aggiornando, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 15, 'Controllare la persona indicata nella colonna ''creata_da'' e ritentare l''operazione.')::utility.system_message,
    ('it', 16, 'Nella giustificazione che si sta inserendo, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 17, 'La persona che ha registrato la giustificazione non è dello stesso istituto dell''alunno.')::utility.system_message,
    ('it', 18, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registered_by''.')::utility.system_message,
    ('it', 19, 'Controllare la persona indicata nella colonna ''registrata:_da'' e riproporre l''operazione.')::utility.system_message,
    ('it', 20, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registered_by''.')::utility.system_message,
    ('it', 21, 'La persona indicata nella colonna ''registered_by'' non è membro di nessuno dei seguenti ruoli: ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 22, 'Nella giustificazione: %L che si sta aggiornando, la persona indicata nella colonna: ''registered_by'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 23, 'Controllare il valore della colonna: ''registered_by'' e riproporre l''operazione.')::utility.system_message,
    ('it', 24, 'Nella giustificazione che si sta inserendo, la persona indicata nella colonna: ''registered_by'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message];
BEGIN 
--
-- Retrieve the name of funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that the on_dates of out_of_classroom there is at least one lesson
--
  PERFORM 1 FROM lessons l
            JOIN classrooms_students cs ON cs.classroom=l.classroom
           WHERE cs.classroom_student = new.classroom_student
             AND on_date = new.on_date;
             
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.out_of_classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- Recovery the school of classroom
--
  SELECT a.school, cs.student, cs.classroom
    INTO me.school, me.student, me.classroom
    FROM school_years a
    JOIN classrooms c ON c.school_year = a.school_year
    JOIN classrooms_students cs ON cs.classroom = c.classroom 
   WHERE cs.classroom_student = new.classroom_student;
--
-- Check that the school of the student is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
     JOIN classrooms_students cs ON cs.student = p.person
    WHERE cs.classroom_student = new.classroom_student
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.out_of_classroom, me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;     
  END IF;
--
-- Check that the school of the school staff is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p 
    WHERE p.person = new.school_operator 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.out_of_classroom, new.school_operator, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.school_operator, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,10);
    END IF;     
  END IF;
--
-- The student that leaving_at cannot be absent
--
  PERFORM 1 
     FROM absences a
     JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student
    WHERE a.on_date = new.on_date 
      AND a.classroom_student = new.classroom_student;
      
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.out_of_classroom, me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    
  END IF;   
--
-- Checking that the school_operator has one of the required roles
--
  IF NOT in_any_roles(new.school_operator,'Supervisor','Executive','Teacher','Employee') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'H'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.out_of_classroom, new.school_operator),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'I'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.school_operator),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_out_of_classrooms_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_out_of_classrooms_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_out_of_classrooms_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_out_of_classrooms_iu() FROM public;
