-- Function: public.tr_grading_meetings_iu()

-- DROP FUNCTION public.tr_grading_meetings_iu();

CREATE OR REPLACE FUNCTION public.tr_grading_meetings_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context text;
  full_function_name text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The grading meeting has a date not covered by the beginning and end of the school year')::utility.system_message,
    ('en', 2, 'Date of the grading meeting: %L is not included in the school year: %L')::utility.system_message,
    ('en', 3, 'To correct the ''date'' of the grading meeting or the '' school_year '' to which he does reference and resubmit the operation')::utility.system_message,
    ('en', 4, 'Date: %L of the grading meeting: %L is not included in the school year: %L')::utility.system_message,
    ('it', 1, 'Lo scrutinio ha una data non compresa fra l''inizio e fine dell''anno scolastico')::utility.system_message,
    ('it', 2, 'La data dello scrutinio: %L non è compresa nella durata dell''anno scolastico: %L')::utility.system_message,
    ('it', 3, 'Correggere la ''data'' dello scrutinio oppure l'' ''anno_scolastico'' a cui si fa'' riferimento e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'La data: %L dello scrutinio: %L non è compresa nella durata dell''anno scolastico: %L')::utility.system_message];
BEGIN
  --
  -- Retrieve the name of the funcion
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  --
  -- the meeting of evaluation "on_date" you must be inclusive in the days of lesson of the school
  --
  PERFORM 1 FROM grading_meetings s
     JOIN school_years a ON a.school_year = s.school_year
    WHERE s.school_year = new.school_year
      AND new.on_date <@ a.duration;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.school_year),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, new.grading_meeting, new.school_year),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN new;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_grading_meetings_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_grading_meetings_iu() FROM public;
