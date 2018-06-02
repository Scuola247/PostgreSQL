-- Function: public.tr_explanations_iu()

-- DROP FUNCTION public.tr_explanations_iu();

CREATE OR REPLACE FUNCTION public.tr_explanations_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school		bigint;
  born			date;
-- variables for system tools
  context		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The pupil is not in the ''pupils'' role')::utility.system_message,
    ('en', 2, 'In justification: %L who is updating the pupil: %L (one person in the people table) does not have a linked user entered in the pupils role')::utility.system_message,
    ('en', 3, 'Check that the student user is included in the pupil role and retry the operation')::utility.system_message,
    ('en', 4, 'In justification you are entering the pupil: %L (a person in the person table) does not have a linked user inserted in the pupils role')::utility.system_message,
    ('en', 5, 'The student institution is not the same as the person indicated by the field: ''created_by ''')::utility.system_message,
    ('en', 6, 'In justification: %L that is being updated, pupil %L does not belong to the same institution: %L of the person: %L indicated in the ''created_from''field')::utility.system_message,
    ('en', 7, 'Controller ''pupil''and the person indicated in ''created_by'' and retry the operation')::utility.system_message,
    ('en', 8, 'In justification that you are entering, the pupil%L does not belong to the same institute: %L of the person: %L indicated in the ''created_by'' field')::utility.system_message ,
    ('en', 9, 'The pupil is not of age and therefore can not include justifications')::utility.system_message,
    ('en', 10, 'In justification: %L being updated,''pupil'': %L is no age and therefore can not enter justifications')::utility.system_message,
    ('en', 11, 'Check the value of ''created_by'' and retry the operation')::utility.system_message,
    ('en', 12, 'In justification that is being inserted, ''pupil:'' %L is no age and therefore can not include justifications')::utility.system_message,
    ('en', 13, 'The person indicated in ''created_by'' is not authorized')::utility.system_message,
    ('en', 14, 'In justification: %L being updated, the person: %L indicated in the ''created_from'' field is not a family member enabled and majority and is not even in the roles of:''leaders'', ''employees'', ''teachers'' ')::utility.system_message,
    ('en', 15, 'Check the person indicated in the column ''created_by ''and retry the operation')::utility.system_message,
    ('en', 16, 'In the justification that is being entered, the person: %L indicated in the field ''created_by ''is not a qualified family and is not even in the roles of ''managers'', ''leaders'', ''employees'', ''teachers'' ')::utility.system_message,
    ('en', 17, 'The person who filed the justification is not the same institution as the pupil')::utility.system_message,
    ('it', 18, 'In justification: %L that is being updated, pupil: %L does not belong to the same institution: %L of the person: %L indicated in the ''registered_from'' field')::utility.system_message,
    ('en', 19, 'Check the person indicated in the column: ''registered_from'' and repeat the operation')::utility.system_message,
    ('en', 20, 'In justification that is being entered, the pupil: %L does not belong to the same institute: %L of the person: %L indicated in the field ''registered_by ''')::utility.system_message ,
    ('en', 21, 'The person indicated in the ''registered'' column is not a member of any of the following roles: ''managers'', ''executives '', ''employees'' ')::utility.system_message,
    ('en', 22, 'In justification: %L being updated, the person indicated in the column: ''registered_from'' does not belong to any of the following roles: ''managers'', ''executives'', ''employees'', ''teachers'' ')::utility.system_message,
    ('en', 23, 'Check the value of the column: ''registered_by ''and re-propose the operation')::utility.system_message,
    ('en', 24, 'In the justification that is being entered, the person indicated in the column: ''registered_from'' does not belong to any of the following roles: ''managers'', '' executives'', ''teachers'' ')::utility.system_message,
    ('it', 1, 'L''alunno non è inserito nel ruolo ''alunni''')::utility.system_message,
    ('it', 2, 'Nella giustificazione: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non ha un utente collegato inserito nel ruolo alunni')::utility.system_message,
    ('it', 3, 'Controllare che l''utente dell''alunno sia inserito nel ruolo alunni e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Nella giustificazione si sta inserendo l''alunno: %L (una persona della tabella persone) non ha un utente collegato inserito nel ruolo alunni')::utility.system_message,
    ('it', 5, 'L''istituto dell''alunno no è lo stesso della persona indicata dal campo: ''creato_da''')::utility.system_message,
    ('it', 6, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''')::utility.system_message,
    ('it', 7, 'Controllare l'' ''alunno'' e la persona indicata in ''creata_da'' e ritentare l''operazione')::utility.system_message,
    ('it', 8, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''')::utility.system_message,
    ('it', 9, 'L''alunno non è maggiorenne e quindi non può inserire giustificazioni')::utility.system_message,
    ('it', 10, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni')::utility.system_message,
    ('it', 11, 'Controllare il valore di ''creato_da'' e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nella giustificazione che si sta inserendo, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni')::utility.system_message,
    ('it', 13, 'La persona indicata in ''creata_da'' non è autorizzata')::utility.system_message,
    ('it', 14, 'Nella giustificazione: %L che si sta aggiornando, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 15, 'Controllare la persona indicata nella colonna ''creata_da'' e ritentare l''operazione')::utility.system_message,
    ('it', 16, 'Nella giustificazione che si sta inserendo, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 17, 'La persona che ha registrato la giustificazione non è dello stesso istituto dell''alunno')::utility.system_message,
    ('it', 18, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registrato_da''')::utility.system_message,
    ('it', 19, 'Controllare la persona indicata nella colonna ''registrata:_da'' e riproporre l''operazione')::utility.system_message,
    ('it', 20, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registrato_da''')::utility.system_message,
    ('it', 21, 'La persona indicata nella colonna ''registrato_da'' non è membro di nessuno dei seguenti ruoli: ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 22, 'Nella giustificazione: %L che si sta aggiornando, la persona indicata nella colonna: ''registrato_da'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 23, 'Controllare il valore della colonna: ''registrato_da'' e riproporre l''operazione')::utility.system_message,
    ('it', 24, 'Nella giustificazione che si sta inserendo, la persona indicata nella colonna: ''registrato_da'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the funcion
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  --
  -- Checking that the student role is student
  --
  IF NOT in_any_roles(new.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),   
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.explanation, new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;       
  END IF;
  --
  -- Recovery the school and the on_dates of birth of the student
  --
  SELECT p.school, p.born 
    INTO me.school, me.born
    FROM persons p
   WHERE p.person = new.student;
  --
  -- Checking that the school of student is equal to that of the person who created the explanation
  --
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.created_by 
      AND p.school = me.school;
  
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.explanation, new.student, me.school, new.created_by),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.student, me.school, new.created_by),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  --
  -- Check that if the explanation has been made from a student and this is an adult
  --
  IF new.created_by = new.student THEN
    IF (SELECT extract('year' from age(new.created_on, me.born)) < 18) THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.explanation, new.student),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.student),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;
    END IF;
  END IF;
  
    --
    -- Otherwise control if the person who created the explanation is in rule of
    -- managers, executives, employees or teachers
    --
  IF in_any_roles(new.created_by,'Supervisor','Executive','Employee','Teacher') THEN
  ELSE
    PERFORM 1 
       FROM persons_relations pr
       JOIN persons p ON pr.person_related_to = p.person
      WHERE pr.person = new.student
        AND pr.person_related_to = new.created_by
        AND pr.can_do_explanation = true
        AND extract('year' from age(new.registered_on, p.born)) >= 18;
  --
  -- control that if the explanation has been made from_time a family
  -- explicitly permitted to justify and adult
  --
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,14), new.explanation, new.created_by),
          HINT = utility.system_messages_locale(system_messages,15);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,16), new.created_by),
          HINT = utility.system_messages_locale(system_messages,15);
      END IF;   
    END IF;         
  END IF;
--  
-- Check that the school of student is equal to that of the person who has registered the explanation
--
  IF new.registered_by IS NOT NULL THEN

    PERFORM 1 
       FROM persons p
      WHERE p.person = new.registered_by 
        AND p.school = me.school;
        
      IF NOT FOUND THEN
        IF (TG_OP = 'UPDATE') THEN
          RAISE EXCEPTION USING
            ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
            MESSAGE = utility.system_messages_locale(system_messages,17),
            DETAIL = format(utility.system_messages_locale(system_messages,18), new.explanation, new.student, me.school, new.registered_by),
            HINT = utility.system_messages_locale(system_messages,19);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
          MESSAGE = utility.system_messages_locale(system_messages,17),
          DETAIL = format(utility.system_messages_locale(system_messages,20), new.student, me.school, new.registered_by),
          HINT = utility.system_messages_locale(system_messages,19);
      END IF;    
    END IF;
--
-- Checking that the person who registered the explanation is a teacher, a clerk, a manager or a manager
--
    IF NOT in_any_roles(new.registered_by, 'Supervisor','Executive','Employee','Teacher')  THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
          MESSAGE = utility.system_messages_locale(system_messages,21),
          DETAIL = format(utility.system_messages_locale(system_messages,22), new.explanation, new.registered_by),
          HINT = utility.system_messages_locale(system_messages,23);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
          MESSAGE = utility.system_messages_locale(system_messages,21),
          DETAIL = format(utility.system_messages_locale(system_messages,24), new.registered_by),
          HINT = utility.system_messages_locale(system_messages,23);
      END IF;      
    END IF;         
  END IF;
    
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_explanations_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_explanations_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_explanations_iu() TO scuola247_executive;
GRANT EXECUTE ON FUNCTION public.tr_explanations_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_explanations_iu() FROM public;
