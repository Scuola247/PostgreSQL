-- Function: public.tr_schools_iu()

-- DROP FUNCTION public.tr_schools_iu();

CREATE OR REPLACE FUNCTION public.tr_schools_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context text;
  full_function_name text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The conduct indicated does not belong to the same institute of class')::utility.system_message,
    ('en', 2, 'In the school indicated: %L the behavior: %L related to another school')::utility.system_message,
    ('en', 3, 'Correct values of school and conduct and repeat the operation')::utility.system_message,
    ('en', 4, 'It is not possible to enter the school and at the same time the conduct')::utility.system_message,
    ('en', 5, 'Since conduct depends on the school cannot be inserted simultaneously')::utility.system_message,
    ('en', 6, 'Before you enter the school without the conduct, then enters the conduct taking note of the code number assigned to the first occasion you update the table schools with the code detected before')::utility.system_message,
    ('it', 1, 'La condotta indicata non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 2, 'Nella scuola indicata: %L la condotta: %L appartiena ad un''altra scuola')::utility.system_message,
    ('it', 3, 'Correggere i valori di scuola e condotta e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Non è possibile inserire la scuola e contemporaneamente la condotta')::utility.system_message,
    ('it', 5, 'Siccome la condatta dipende dalla scuola non è possibile inserirla contemporanemente')::utility.system_message,
    ('it', 6, 'Prima si inserisce la scuola senza la condotta, poi si inserisce la condotta prendendo nota del codice assegnato, alla prima occasione si aggionra la tabella scuole con il codice rilevato prima')::utility.system_message]; 
BEGIN
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check behavior
--  
  IF new.behavior IS NOT NULL THEN
    IF (TG_OP = 'UPDATE') THEN
      --
      -- check that subject's school as equal as school
      --
      PERFORM 1 
         FROM subjects 
        WHERE subject = new.behavior 
          AND school = new.school;
          
      IF NOT FOUND THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.school, new.behavior),
          HINT = utility.system_messages_locale(system_messages,3);      
      END IF;
    ELSE
      --
      -- cannot set the behavior because it needs school. You must:
      -- 1) insert school
      -- 2) insert subject 
      -- 3) update school with the subject
      --
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,4),
        DETAIL = format(utility.system_messages_locale(system_messages,5)),
        HINT = utility.system_messages_locale(system_messages,6);
    END IF;
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_schools_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_schools_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_schools_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_schools_iu() FROM public;
