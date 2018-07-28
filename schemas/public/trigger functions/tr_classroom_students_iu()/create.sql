-- Function: public.tr_classrooms_students_iu()

-- DROP FUNCTION public.tr_classrooms_students_iu();

CREATE OR REPLACE FUNCTION public.tr_classrooms_students_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  full_function_name 	varchar; 
  context 		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The classroom and the student aren''t about the same school')::utility.system_message,
    ('en', 2, 'On the association classrooms_students: %L , the classroom: %L and the student: %L aren''t about the same school')::utility.system_message,
    ('en', 3, 'Correct the values of: ''classrooms'' and ''students'' and repeat the operation ')::utility.system_message,
    ('en', 4, 'On the association classrooms_students which is being inserted, the classroom: %L and the student: %L aren''t about the same school.')::utility.system_message,
    ('en', 5, 'The student entered in the table: ''classrooms_students'' has not a ''Student'' role.')::utility.system_message,
    ('en', 6, 'In table classrooms_students: %L, the student %L entered has not a ''Student'' role.')::utility.system_message,
    ('en', 7, 'Try and re-enter the data.')::utility.system_message,
    ('en', 8, 'In the classrooms_students row inserted the student: %L has not a ''Student'' role.')::utility.system_message,
    ('it', 1, 'La classe e alunno non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nell''associazione classi_alunni: %L , la classe: %L e l''alunno: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''classe'' e ''alunno'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nell''associazione classi_alunni che si sta inserendo la classe: %L e l''alunno: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 5, 'Lo studente inserito nella tabella: ''classrooms_students'' non ha un ruolo: ''Student''.')::utility.system_message,
    ('it', 6, 'Nella tabella classrooms_students: %L, lo studente %L inserito non ha un ruolo: ''Student''.')::utility.system_message,
    ('it', 7, 'Provare e re-inserire i dati.')::utility.system_message,
    ('it', 8, 'Nella riga della tabella classrooms_students inserita lo studente: %L  non ha un ruolo: ''Student''.')::utility.system_message];
    
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that classroom and student are of the same school
--
  PERFORM 1 
     FROM classrooms c
     JOIN school_years a ON a.school_year = c.school_year
     JOIN persons p ON a.school = p.school
    WHERE c.classroom = new.classroom
      AND p.person = new.student;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.classroom_student, new.classroom, new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.classroom, new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	   
  END IF;
  --
-- Check that the student is in rule students
--

  IF NOT in_any_roles(new.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.classroom_student, new.student),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.student),
        HINT = utility.system_messages_locale(system_messages,7);
      END IF;	   
    END IF;
    
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_classrooms_students_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION public.tr_classrooms_students_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION public.tr_classrooms_students_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION public.tr_classrooms_students_iu() FROM public;
