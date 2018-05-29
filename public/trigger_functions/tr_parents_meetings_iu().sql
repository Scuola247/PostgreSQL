-- Function: public.tr_parents_meetings_iu()

-- DROP FUNCTION public.tr_parents_meetings_iu();

CREATE OR REPLACE FUNCTION public.tr_parents_meetings_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The teacher and the person with whom was fixed the interview are not of the same institute')::utility.system_message,
    ('en', 2, 'In the interview: ''%s'' the teacher: ''%s'' and the person (column ''with''): ''%s'' are not of the same institute')::utility.system_message,
    ('en', 3, 'Correct values: ''teacher'' and ''with'' and repeat the operation')::utility.system_message,
    ('en', 4, 'In the interview that you are entering the teacher: ''%s'' and the person (column ''with''): ''%s'' are not of the same institute')::utility.system_message,
    ('it', 1, 'Il docente e la persona con cui è stato fissato il colloquio non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nel colloquio: ''%s'' il docente: ''%s'' e al persona (colonna ''con''): ''%s'' non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''docente'' e ''con'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nel colloquio che si sta inserendo il docente: ''%s'' e la persona (colonna ''con''): ''%s'' non sono dello stesso istituto')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- control that the teacher and the person who has fixed the parents_meetings are of the same school
--
  IF new.person IS NOT NULL THEN
  
    PERFORM 1 
       FROM persons doc
       JOIN persons con ON doc.school = con.school
      WHERE doc.person = new.teacher
        AND con.person = new.person;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.parents_meeting, new.teacher, new.person),
          HINT = utility.system_messages_locale(system_messages,3);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,4), new.teacher, new.person),
          HINT = utility.system_messages_locale(system_messages,3);
      END IF;    
    END IF;
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_parents_meetings_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_parents_meetings_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_parents_meetings_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_parents_meetings_iu() FROM public;
