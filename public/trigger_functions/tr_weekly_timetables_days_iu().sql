-- Function: public.tr_weekly_timetables_days_iu()

-- DROP FUNCTION public.tr_weekly_timetables_days_iu();

CREATE OR REPLACE FUNCTION public.tr_weekly_timetables_days_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  v_school      bigint;
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute who wrote the message (from) is not the same as the pupil of the personal report card')::utility.system_message,
    ('en', 2, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message: ''%s'' is not the same as the pupil holder of the personal report card to which leads the conversation: ''%s''')::utility.system_message,
    ('en', 3, 'Check the values of the person ''da'' and the conversation and repeat the operation')::utility.system_message,
    ('en', 4, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message that you are inserting is not the same as the pupil holder of the personal report card to which leads the conversation: ''%s''')::utility.system_message,
    ('it', 1, 'la scuola della persona no è la stessa di quella della classroom della note')::utility.system_message,
    ('it', 2, 'in data:''%s''')::utility.system_message,
    ('it', 3, 'Controllare i valori della persona ''da'' e della conversazione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'L''istituo: ''%s'' della persona (da): ''%s'' che ha scritto il messaggio che si sta inserendo non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione: ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- metto da una parte l'school della classroom
--
  SELECT s.school INTO v_school 
    FROM schools s
    JOIN school_years sy ON sy.school = s.school
    JOIN classrooms c ON c.school_year = sy.school_year
    JOIN weekly_timetables wt ON wt.classroom = c.classroom
    JOIN weekly_timetables_days wtd ON wtd.weekly_timetable = wt.weekly_timetable
   WHERE wt.weekly_timetable_day = new.weekly_timetable_day;
--
-- controllo che l'school della person sia lo stesso di quello della classroom del calendario settimanale
--
  PERFORM 1 FROM persons
    WHERE person = new.person
      AND school = v_school;
           
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.at_timerio_weekli_on_date, new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  
--
-- controllo che l'school della subject sia lo stesso di quello della classroom del calendario settimanale
-- Exeption Code modificati 
  PERFORM 1 FROM subjects
    WHERE subject = new.subject
      AND school = v_school;
           
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'), -- cambiato valore da 1 a 3
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.at_timerio_weekli_on_date, new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'), -- cambiato valore da 2 a 4
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_weekly_timetables_days_iu()
  OWNER TO postgres;
