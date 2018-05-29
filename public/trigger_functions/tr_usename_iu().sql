-- Function: public.tr_usename_iu()

-- DROP FUNCTION public.tr_usename_iu();

CREATE OR REPLACE FUNCTION public.tr_usename_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'Attempts have been made to update a username that it isn''t exist in the system''s table_ pg_shadow')::utility.system_message,
    ('en', 2, 'Attempts have been made to insert a username that it isn''t exist in the system''s table_ pg_shadow')::utility.system_message,
    ('en', 3, 'To verify that the username indicated exists in the the system''s table pg_shadow and retry the operation')::utility.system_message,
    ('en', 4, 'Attempts have been made to enter a user with a non-existent system username (username)')::utility.system_message,
    ('en', 5, 'Attempts have been made to insert a user pointing out as ''usename'' (name consumer of system) the value: ''%s'' that it doesn''t exist in the sight of system pg_user')::utility.system_message,
    ('it', 1, 'Si è cercato di aggiornare un nome utente che non esiste nella vista di sistema pg_shadow')::utility.system_message,
    ('it', 2, 'Si è cercato di inserire un nome utente che non esiste nella vista di sistema pg_shadow')::utility.system_message,
    ('it', 3, 'Verificare che il nome utente indicato esista nella vista di sistema pg_shadow e riprovare l''operazione')::utility.system_message,
    ('it', 4, 'Si è cercato di inserire un utente con un nome utente di sistema (usename) inesistente')::utility.system_message,
    ('it', 5, 'Si è cercato di inserire un utente indicando come ''usename'' (nome utente di sistema) il valore: ''%s'' che non esiste nella vista di sistema pg_shadow')::utility.system_message];	
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check user name
--
  PERFORM 1 FROM pg_shadow WHERE usename = new.usename;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), new.usename),
      HINT = utility.system_messages_locale(system_messages,3);
  ELSE
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
      MESSAGE = utility.system_messages_locale(system_messages,4),
      DETAIL = format(utility.system_messages_locale(system_messages,5) ,new.usename),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END IF;
RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_usename_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_usename_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_usename_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_usename_iu() FROM public;
