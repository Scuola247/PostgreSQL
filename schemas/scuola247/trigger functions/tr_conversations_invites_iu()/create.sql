-- Function: scuola247.tr_conversations_invites_iu()

-- DROP FUNCTION scuola247.tr_conversations_invites_iu();

CREATE OR REPLACE FUNCTION scuola247.tr_conversations_invites_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'In ''conversations_invites'': %L the conversations student: %L and the invites: %L aren'' form the same school ')::utility.system_message,
    ('en', 2, 'In ''conversations_invites'': %L the conversations student: %L and the invites: %L aren'' form the same school ')::utility.system_message,
    ('en', 3, 'Correct the value of: ''conversation'' and ''invites'' and repeat the operation. ')::utility.system_message,
    ('en', 4, 'In ''conversation_invite'' or is being the insert of ''conversation'': %L and ''invite'': %L aren''t from the same school  ')::utility.system_message,
    ('it', 1, 'Nella ''conversazione_invitato'': %L l''alunno della conversazione: %L e l''invitato: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nella ''conversazione_invitato'': %L l''alunno della conversazione: %L e l''invitato: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''conversazione'' e ''invitato'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nella ''conversazione_invitato'' o che si sta inserendo la ''conversazione'': %L e ''invitato'': %L non sono dello stesso istituto')::utility.system_message];	
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that the person invited both of the same institute of student 
--
  PERFORM 1 
     FROM scuola247.conversations c
     JOIN scuola247.classrooms_students cs ON c.classroom_student = cs.classroom_student
     JOIN scuola247.persons s ON s.person = cs.student 
     JOIN scuola247.persons i ON i.person = new.invited
    WHERE c.conversation = new.conversation
      AND i.school = s.school;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.conversation_invite, new.conversation, new.invited),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.conversation, new.invited),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	   
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION scuola247.tr_conversations_invites_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION scuola247.tr_conversations_invites_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION scuola247.tr_conversations_invites_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION scuola247.tr_conversations_invites_iu() FROM public;
