-- Function: public.tr_messages_iu()

-- DROP FUNCTION public.tr_messages_iu();

CREATE OR REPLACE FUNCTION public.tr_messages_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school      		bigint;
-- variables for system tools
  context      		text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute who wrote the message (from) is not the same as the pupil of the personal report card')::utility.system_message,
    ('en', 2, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message: ''%s'' is not the same as the pupil holder of the personal report card to which leads the conversation: ''%s''')::utility.system_message,
    ('en', 3, 'Check the values of the person ''da'' and the conversation and repeat the operation')::utility.system_message,
    ('en', 4, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message that you are inserting is not the same as the pupil holder of the personal report card to which fa'' chapter the conversation: ''%s''')::utility.system_message,
    ('it', 1, 'L''istituto di chi ha scritto il messaggio (da) non è lo stesso dell''alunno del libretto della conversazione')::utility.system_message,
    ('it', 2, 'L''istituo: ''%s'' della persona (da): ''%s'' che ha scritto il messaggio: ''%s'' non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare i valori della persona ''da'' e della conversazione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'L''istituo: ''%s'' della persona (da): ''%s'' che ha scritto il messaggio che si sta inserendo non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione: ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read person's school who wrote the message
--
  SELECT p.school INTO me.school 
    FROM persons p
   WHERE p.person = new.person;
--
-- Check that the person who wrote the message (from_time) is of the same school of student to which make zip codeo_the school_record of the conversation
--
  PERFORM 1 
     FROM classrooms_students cs
     JOIN conversations c ON c.classroom_student = cs.classroom_student
     JOIN persons p ON p.person = cs.student
    WHERE c.conversation = new.conversation
      AND p.school = me.school;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), me.school, new.person, new.message, new.conversation),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), me.school, new.person, new.conversation),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    

  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_messages_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_messages_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_messages_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_messages_iu() FROM public;
