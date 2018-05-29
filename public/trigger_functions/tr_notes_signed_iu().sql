-- Function: public.tr_notes_signed_iu()

-- DROP FUNCTION public.tr_notes_signed_iu();

CREATE OR REPLACE FUNCTION public.tr_notes_signed_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school		bigint;
-- variables for system tools
  context		text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The person who has seen the note has not the same institute of class of note')::utility.system_message,
    ('en', 2, 'In nota_visto: ''%s'' that you are upgrading the person: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of class of note: ''%s''')::utility.system_message,
    ('en', 3, 'Check the pupil or the class indicated and retry the operation')::utility.system_message,
    ('en', 4, 'In nota_visto that you are inserting the person: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of class of note: ''%s''')::utility.system_message,
    ('it', 1, 'La persona che ha visto la nota non ha lo stesso istituto della classe della nota')::utility.system_message,
    ('it', 2, 'Nella nota_visto: ''%s'' che si sta aggiornando la persona: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe della nota: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Nella nota_visto che si sta inserendo la persona: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe della nota: ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- I from_time a part of the school of classroom
--
  SELECT sy.school INTO me.school 
    FROM notes n
    JOIN classrooms c ON c.classroom = n.classroom
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE n.note = new.note;
--
-- control that person's school is the same as that of the classroom of notes
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.person
      AND p.school = me.school;
           
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.note_signed, new.person, me.school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person, me.school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_notes_signed_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_notes_signed_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_notes_signed_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_notes_signed_iu() FROM public;
