-- Function: public.tr_signatures_iu()

-- DROP FUNCTION public.tr_signatures_iu();

CREATE OR REPLACE FUNCTION public.tr_signatures_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The teacher can''t sign for a classroom of another school..')::utility.system_message,
    ('en', 2, 'The ''signature'': %L made by the ''teacher'': %L indicates a ''class'': %L of another institute .')::utility.system_message,
    ('en', 3, 'Correct the values of: teacher and class, then retry..')::utility.system_message,
    ('en', 4, 'In signature that the ''teacher'' is inserting.')::utility.system_message,
    ('en', 5, 'The person named as a teacher has not been authorized to serve as a teacher.')::utility.system_message,
    ('en', 6, 'The ''signature'': %L can not be updated by the ''teacher'': %L because the same is not allowed for the ''teacher'' role.')::utility.system_message,
    ('en', 7, 'Authorize the person referred to as ''teachers'' or indicate as an instructor an authorized person and repeat the operation.')::utility.system_message,
    ('en', 8, 'The person named as ''teacher'': %L can not enter the signature because he is not authorized to the ''faculty'' role.')::utility.system_message,
    ('it', 1, 'Il docente non può firmare per una classe di un altro istituto.')::utility.system_message,
    ('it', 2, 'La ''firma'': %L fatta dal ''docente'': %L indica una ''classe'': %L di un altro istituto.')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''docente'' e ''classe'' e riproporre l''operazione.')::utility.system_message,
    ('it', 4, 'Nella firma che si sta inserendo il ''docente'': %L indica una ''classe'': %L di un altro istituto.')::utility.system_message,
    ('it', 5, 'La persona indicata come docente non è stata autorizzata al ruolo di docente.')::utility.system_message,
    ('it', 6, 'La ''firma'': %L non può essere aggiornata dal ''docente'': %L perchè lo stesso non è autorizzato al ruolo ''docenti'' .')::utility.system_message,
    ('it', 7, 'Autorizare la persona indicato al ruolo ''docenti'' oppure indicare come docente una persona autorizzata e riproporre l''operazione.')::utility.system_message,
    ('it', 8, 'La persona indicata come ''docente'': %L non può inserire la firma perchè non è autorizzato al ruolo ''docenti''.')::utility.system_message];
  context       text;
  full_function_name    text;
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- Checking that the teacher is of the same institute of classroom
--
  PERFORM 1 FROM classrooms c
     JOIN school_years a ON c.school_year = a.school_year
     JOIN persons doc ON a.school = doc.school
    WHERE doc.person = new.teacher
      AND c.classroom = new.classroom;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.signature, new.teacher, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.teacher, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- Checking that the person designated as teacher has the rule of teacher or director
--
  IF NOT in_any_roles(new.teacher,'Executive','Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.signature, new.teacher),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,6),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.teacher),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_signatures_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_signatures_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_signatures_iu() TO scuola247_executive;
GRANT EXECUTE ON FUNCTION public.tr_signatures_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_signatures_iu() FROM public;
