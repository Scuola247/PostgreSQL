-- Function: public.tr_topics_iu()

-- DROP FUNCTION public.tr_topics_iu();

CREATE OR REPLACE FUNCTION public.tr_topics_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  v_course_years    course_year;
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The matter and the school address are not of the same institute')::utility.system_message,
    ('en', 2, 'In the topic: ''%s'' matter: ''%s'' and the course_year: ''%s'' are not of the same institute')::utility.system_message,
    ('en', 3, 'Correct values of subject and course_year and repeat the operation')::utility.system_message,
    ('en', 4, 'In the topic that you are entering the field: ''%s'' and the course_year: ''%s'' are not of the same institute')::utility.system_message,
    ('en', 5, 'The year is greater than the years envisaged for the school address in the subject')::utility.system_message,
    ('en', 6, 'In the topic: ''%s'' the year: ''%s'' is greater than the years of course: ''%s'' provided by the address: ''%s'' in the subject')::utility.system_message,
    ('en', 7, 'Correct the value of the year or of the subject and to repeat the operation')::utility.system_message,
    ('en', 8, 'In the topic that you are inserting the year: ''%s'' Is greater than the years of course: ''%s'' provided by the address: ''%s'' in the subject')::utility.system_message,
    ('it', 1, 'La materia e l''indirizzo scolastico non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nell''argomento: ''%s'' la materia: ''%s'' e l''anno_scolastico: ''%s'' non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di materia e anno_scolastico e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nell''argomento che si sta inserendo la materia: ''%s'' e l''anno_scolastico: ''%s'' non sono dello stesso istituto')::utility.system_message,
    ('it', 5, 'L''anno di corso è superiore agli anni di corso previsti per l''indirizzo scolastico in oggetto')::utility.system_message,
    ('it', 6, 'Nell''argomento: ''%s'' l''anno di corso: ''%s'' è maggiore agli anni di corso: ''%s'' previsti dall''indirizzo: ''%s'' in oggetto')::utility.system_message,
    ('it', 7, 'Correggere il valore dell'' anno di corso o della materia e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Nell''argomento che si sta inserendo l''anno di corso: ''%s'' è maggiore agli anni di corso: ''%s'' previsti dall''indirizzo: ''%s'' in oggetto')::utility.system_message]; 
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that the subject and the address at school are of the same school
--
  SELECT i.course_years INTO v_course_years
    FROM subjects m
    JOIN degrees i ON i.school = m.school
   WHERE m.subject = new.subject
     AND i.degree = new.degree;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.topic, new.subject,  new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.subject,  new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  IF new.course_year > v_course_years THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.topic, new.course_year, v_course_years, new.degree),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.course_year, v_course_years, new.degree),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_topics_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_topics_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_topics_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_topics_iu() FROM public;
