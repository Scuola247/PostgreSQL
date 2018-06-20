-- Function: public.tr_messages_read_iu()

-- DROP FUNCTION public.tr_messages_read_iu();

CREATE OR REPLACE FUNCTION public.tr_messages_read_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
-- variables for system tools
  context       	text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute who wrote the message (from) is not the same as the pupil of the personal report card')::utility.system_message,
    ('en', 2, 'The Institute of the person (from): ''%s'' that read the message: ''%s'' is not the same as the pupil holder of the personal report card to which leads the conversation')::utility.system_message,
    ('en', 3, 'Check the values of the person ''from'' and the conversation and repeat the operation')::utility.system_message,
    ('en', 4, 'The Institute of the person (from): ''%s'' that read the message that you are inserting is not the same as the pupil holder of the personal report card to which leads the conversation')::utility.system_message,
    ('it', 1, 'L''istituto di chi ha scritto il messaggio (da) non è lo stesso dell''alunno del libretto della conversazione')::utility.system_message,
    ('it', 2, 'L''istituo della persona (da): %L che ha letto il messaggio: %L non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione')::utility.system_message,
    ('it', 3, 'Controllare i valori della persona ''da'' e della conversazione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'L''istituo: della persona (da): %L che ha letto il messaggio che si sta inserendo non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione')::utility.system_message];
BEGIN 
--
-- Retrieve the name of function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- control that the person who read the messages (message_read.person)
-- is of the same school of the student of the conversation
--
  PERFORM 1 
     FROM persons p
     JOIN messages_read mr ON mr.person = p.person 
     JOIN messages m on m.message = mr.message 
     JOIN conversations c ON c.conversation = m.conversation
     JOIN classrooms_students cs ON cs.classroom_student = c.classroom_student
     JOIN classrooms cl ON cl.classroom = cs.classroom 
     JOIN school_years sy ON sy.school_year = cl.school_year 
    WHERE mr.message_read = new.message_read 
      AND p.school = sy.school;
       
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2),new.person, new.message),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_messages_read_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION public.tr_messages_read_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION public.tr_messages_read_iu() TO scuola247_relative;
GRANT EXECUTE ON FUNCTION public.tr_messages_read_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION public.tr_messages_read_iu() FROM public;
