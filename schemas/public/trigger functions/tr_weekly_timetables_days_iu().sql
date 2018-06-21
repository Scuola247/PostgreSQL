-- Function: public.tr_weekly_timetables_days_iu()

-- DROP FUNCTION public.tr_weekly_timetables_days_iu(); 

CREATE OR REPLACE FUNCTION public.tr_weekly_timetables_days_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school      bigint;
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The teacher''s school and weekly timetable''s school are different')::utility.system_message,
    ('en', 2, 'The teacher''s: %L school and weekly timetable''s school: %L are different')::utility.system_message,
    ('en', 3, 'Check the values: teacher and weekly timetable and repeat the operation')::utility.system_message,
    ('en', 4, 'The subject''s school and weekly timetable''s school are different')::utility.system_message,
    ('en', 5, 'The subject''s: %L school and weekly timetable''s school: %L are different')::utility.system_message,
    ('en', 6, 'Check the values: subject and weekly timetable and repeat the operation')::utility.system_message,
    ('it', 1, 'La scuola dell''insegnante e dell''orario scolastico settimanale è diversa')::utility.system_message,
    ('it', 2, 'La scuola dell''insegnante: %L e dell''orario scolastico settimanale: %L è diversa')::utility.system_message,
    ('it', 3, 'Controlla i valori di: Insegnante e Orario settimanale e ripeti l''operazione')::utility.system_message,
    ('it', 4, 'La scuola della materia e dell''orario scolastico settimanale è diversa')::utility.system_message,
    ('it', 5, 'La scuola della materia: %L e dell''orario scolastico settimanale: %L è diversa')::utility.system_message,
    ('it', 6, 'Controlla i valori di: Materia e Orario settimanale e ripeti l''operazione')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- metto da una parte l'school della classroom
--
  SELECT s.school INTO me.school 
    FROM schools s
    JOIN school_years sy ON sy.school = s.school
    JOIN classrooms c ON c.school_year = sy.school_year
    JOIN weekly_timetables wt ON wt.classroom = c.classroom
    JOIN weekly_timetables_days wtd ON wtd.weekly_timetable = wt.weekly_timetable
   WHERE wtd.weekly_timetable_day = new.weekly_timetable_day;
--
-- controllo che l'school della person sia lo stesso di quello della classroom del calendario settimanale
--
  IF new.teacher IS NULL THEN
  ELSE
    PERFORM 1 
        FROM persons p
      WHERE p.person = new.teacher   
        AND p.school = me.school;
           
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.teacher, new.weekly_timetable),
          HINT = utility.system_messages_locale(system_messages,3);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.teacher, new.weekly_timetable), 
          HINT = utility.system_messages_locale(system_messages,3);
      END IF;    
    END IF;
  END IF;
  
--
-- controllo che l'school della subject sia lo stesso di quello della classroom del calendario settimanale
--
  IF new.subject IS NULL THEN
  ELSE 
    PERFORM 1 
    FROM subjects s
    WHERE s.subject = new.subject
      AND s.school = me.school;
           
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'), 
          MESSAGE = utility.system_messages_locale(system_messages,4),
          DETAIL = format(utility.system_messages_locale(system_messages,5), new.subject, new.weekly_timetable),
          HINT = utility.system_messages_locale(system_messages,6);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,4),
          DETAIL = format(utility.system_messages_locale(system_messages,5), new.subject, new.weekly_timetable),
          HINT = utility.system_messages_locale(system_messages,6);
      END IF;    
    END IF;
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_weekly_timetables_days_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION public.tr_weekly_timetables_days_iu() TO public;
GRANT EXECUTE ON FUNCTION public.tr_weekly_timetables_days_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION public.tr_weekly_timetables_days_iu() TO scuola247_user;
