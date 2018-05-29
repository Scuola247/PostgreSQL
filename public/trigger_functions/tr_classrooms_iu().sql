-- Function: public.tr_classrooms_iu()

-- DROP FUNCTION public.tr_classrooms_iu();

CREATE OR REPLACE FUNCTION public.tr_classrooms_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The''schools_years'' and ''degrees'' aren''t about the same school.')::utility.system_message,
    ('en', 2, 'In the classroom: %L , the ''schools_years'': %L and the ''degrees'': %L aren''t about the same school.')::utility.system_message,
    ('en', 3, 'Edit  the value of: ''school_year'' and ''degree'' and repeat the operation.')::utility.system_message,
    ('it', 1, 'L''anno scolastico e l''indirizzo scolastico non sono dello stesso istituto.')::utility.system_message,
    ('it', 2, 'Nella classe: %L l''anno_scolastico: %L e l''indirizzo_scolastico: %L non sono dello stesso istituto.')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''school_year'' e ''degree'' e riproporre l''operazione.')::utility.system_message];	
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that school_year and degree are of the same school
--
  PERFORM 1 
     FROM school_years a
     JOIN degrees i ON i.school = a.school
    WHERE a.school_year = new.school_year
      AND i.degree = new.degree;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.classroom, new.school_year, new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.classroom, new.school_year, new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	   
  END IF;
  
RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_classrooms_iu() SET search_path=public, utility, pg_temp;

ALTER FUNCTION public.tr_classrooms_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_classrooms_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_classrooms_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_classrooms_iu() FROM public;
