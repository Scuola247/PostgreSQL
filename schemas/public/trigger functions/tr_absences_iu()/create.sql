-- Function: public.tr_absences_iu()

-- DROP FUNCTION public.tr_absences_iu();

CREATE OR REPLACE FUNCTION public.tr_absences_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school		bigint;
  classroom		bigint;
  student		bigint;

  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The absence was marked in a day where there are no lessons.')::utility.system_message,
    ('en', 2, 'On date: %L, was marked the absence: %L, day when class: %L has no lesson')::utility.system_message,
    ('en', 3, 'Try to re-insert the absent date you want to insert.')::utility.system_message,
    ('en', 4, 'On date:%L the class: %L has no lesson, so the absence can not be entered.')::utility.system_message,
    ('en', 5, 'On the absent day the pupil is already marked as '' delay ''.')::utility.system_message,
    ('en', 6, 'In absence: %L with description: %L of the student: %L in date %L, the student is already marked as '' delay''.')::utility.system_message,
    ('en', 7, 'Try re-entering the absence date or the name of the pupil.')::utility.system_message,
    ('en', 8, 'In absence:  L with description: %L of the student: %L in date %L, the student is already marked as '' delay ''.')::utility.system_message,
    ('en', 9, 'The school assigned to the pupil marked in absentia is not equivalent to the school of the class')::utility.system_message,
    ('en', 10, 'In absence: %L of the student: %L. School: %L does not match class: %L.')::utility.system_message,
    ('en', 11, 'Try re-inserting a pupil assigned to absent.')::utility.system_message,
    ('en', 12, 'In the absence of the student: %L, the School %L does not match school''s class:% L.')::utility.system_message,
    ('en', 13, 'The school assigned to the absent teacher. Does not match the class assigned to the class.')::utility.system_message,
    ('en', 14, 'In absence: %L entered by the teacher: %L, does not match school: %L with class assigned: %L.')::utility.system_message,
    ('en', 15, 'Try re-enter the data.')::utility.system_message,
    ('en', 16, 'In the teacher''s absence: %L, does not match school: %L with class assigned: %L.')::utility.system_message,
    ('en', 17, 'On the absent day the pupil is already marked as '' delay ''.')::utility.system_message,
    ('en', 18, 'In absence: %L with description: %L of the student: %L in date %L, the student is already marked as '' delay''.')::utility.system_message,
    ('en', 19, 'Try re-entering the absence date or the name of the pupil.')::utility.system_message,
    ('en', 20, 'With description: %L of the student: %L in date %L, the student is already marked as '' delay ''.')::utility.system_message,
    ('en', 21, 'On the absent day the student entered is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 22, 'In the absence. %L of the student: %L of the class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 23, 'Try and re-enter the absence date.')::utility.system_message,
    ('en', 24, 'In the absence of the student: %L of the class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 25, 'On the absent day, the entered student is already registered as '' Leaving''.')::utility.system_message,
    ('en', 26, 'In the absence. %L of the student: %L of the class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 27, 'Try and re-enter the absence date.')::utility.system_message,
    ('en', 28, 'In absence of student: %L of class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 29, 'The student entered in the absences is not recognized as a ''student''.')::utility.system_message,
    ('en', 30, 'In absence: %L, the student %L entered is not recognized as the ''student'' role.')::utility.system_message,
    ('en', 31, 'Try and re-enter the data.')::utility.system_message,
    ('en', 32, 'In the absence of student %L assignment is not recognized with the role of '' student ''.')::utility.system_message,
    ('en', 33, 'The teacher who entered the absence is not recognized as a ''teacher''.')::utility.system_message,
    ('en', 34, 'In absence: %L, entered by the teacher %L is not recognized as the ''teacher'' role.')::utility.system_message,
    ('en', 35, 'Try and re-enter the data.')::utility.system_message,
    ('en', 36, 'In the absence of the teacher %L is not recognized as the '' teacher '' role.')::utility.system_message,
    ('it', 1, 'L''assenza è stata segnata in un giorno dove non vi sono lezioni.')::utility.system_message,
    ('it', 2, 'In data: %L, e stata segnata l''assenza: %L, giornata in cui la classe: %L non ha lezione')::utility.system_message,
    ('it', 3, 'Riprovare a riinserire la data dell''assenza che si vuole inserire.')::utility.system_message,
    ('it', 4, 'In data: %L la classe: %L non ha lezione, perciò l''assenza non può essere inserita.')::utility.system_message,
    ('it', 5, 'Nel giorno dell''assenza inserita l''alunno è gia segnato come ''in ritardo''.')::utility.system_message,
    ('it', 6, 'Nell''assenza: %L con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritartdo''.')::utility.system_message,
    ('it', 7, 'Provare a re-inserire la data dell''assenza oppure il nome dell''alunno.')::utility.system_message,
    ('it', 8, 'Nell''assenza: %L con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritartdo''.')::utility.system_message,
    ('it', 9, 'La scuola assegnata all''alunno contrassegnato nell''assenza non equivale alla scuola della classe ')::utility.system_message,
    ('it', 10, 'Nell''assenza: %L dello studente: %L. la scuola: %L non corrisponde a quella della classe: %L.')::utility.system_message,
    ('it', 11, 'Provare a re-inserire l''alunno assegnato all''assenza.')::utility.system_message,
    ('it', 12, 'Nell''assenza inserita dello studente: %L . la scuola %L non corrisponde alla scuola segnata alla classe: %L.')::utility.system_message,
    ('it', 13, 'La scuola assegnata all''insegnante dell''assenza. Non corrisponde alla scuola assegnata alla classe.')::utility.system_message,
    ('it', 14, 'Nell''assenza: %L inserita dall''insegnante: %L, non corrisponde la scuola: %L con quella assegnata alla classe: %L.')::utility.system_message,
    ('it', 15, 'Provare a re-inserire i dati.')::utility.system_message,
    ('it', 16, 'Nell''assenza inserita dall''insegnante: %L, non corrisponde la scuola: %L con quella assegnata alla classe: %L.')::utility.system_message,
    ('it', 17, 'Nel giorno dell''assenza inserita l''alunno è gia segnato come ''in ritardo''.')::utility.system_message,
    ('it', 18, 'Nell''assenza: %L con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritardo''.')::utility.system_message,
    ('it', 19, 'Provare a re-inserire la data dell''assenza oppure il nome dell''alunno.')::utility.system_message,
    ('it', 20, 'Nell''assenza con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritardo''.')::utility.system_message,
    ('it', 21, 'Nel giorno inserito dell''assenza lo studente inserito è già registrato come ''Uscito in anticipo''.')::utility.system_message,
    ('it', 22, 'Nell''assenza. %L dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito in anticipo''.')::utility.system_message,
    ('it', 23, 'Provare e re-inserire la data dell''assenza.')::utility.system_message,
    ('it', 24, 'Nell''assenza dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito in anticipo''.')::utility.system_message,
    ('it', 25, 'Nel giorno inserito dell''assenza lo studente inserito è già registrato come ''Uscito dalla classe''.')::utility.system_message,
    ('it', 26, 'Nell''assenza. %L dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito dalla classe''.')::utility.system_message,
    ('it', 27, 'Provare e re-inserire la data dell''assenza.')::utility.system_message,
    ('it', 28, 'Nell''assenza dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito dalla classe''.')::utility.system_message,
    ('it', 29, 'Lo studente inserito nell''assenza non è riconosciuto come ''studente''.')::utility.system_message,
    ('it', 30, 'Nell''assenza: %L, lo studente %L inserito non è riconosciuto con il ruolo di ''studente''.')::utility.system_message,
    ('it', 31, 'Provare e re-inserire i dati.')::utility.system_message,
    ('it', 32, 'Nell''assenza inserita dello studente %L assegnato non è riconosciuto con il ruolo di ''studente''.')::utility.system_message,
    ('it', 33, 'L''insengnante che ha inserito l''assenza non è riconosciuto come ''insegnante''.')::utility.system_message,
    ('it', 34, 'Nell''assenza: %L, inserita dall''insegnante %L  non è riconosciuto con il ruolo di ''insegnante''.')::utility.system_message,
    ('it', 35, 'Provare e re-inserire i dati.')::utility.system_message,
    ('it', 36, 'Nell''assenza inserita dall''insegnante %L  non è riconosciuto con il ruolo di ''insengnate''.')::utility.system_message];
BEGIN
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of the classroom
--
  SELECT s.school, cs.classroom , cs.student
    INTO me.school , me.classroom, me.student
    FROM classrooms_students cs
    JOIN classrooms c ON c.classroom = cs.classroom
    JOIN school_years s ON s.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- check that in the on_date of absence there is at least one lesson
--
  PERFORM DISTINCT 1
     FROM lessons l
     JOIN classrooms_students cs ON cs.classroom = l.classroom
    WHERE cs.classroom_student = new.classroom_student
      AND l.on_date = new.on_date;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.absence,  me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
--
-- Check that the student, in the on_date, has not already been recorded as delay
--
  IF new.explanation IS NOT NULL THEN

    PERFORM 1
       FROM explanations e
      WHERE e.explanation=new.explanation
        AND e.student = me.student
        AND e.created_on >= new.on_date
        AND new.on_date BETWEEN from_time AND to_time ;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
	RAISE EXCEPTION USING
	  ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
	  MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.absence, new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
	  ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
	  MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.absence, new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;
    END IF;
  END IF;
--
-- Check that the school of the student equals that of the classroom
--
  PERFORM 1
     FROM persons p
    WHERE p.person = me.student
      AND p.school = me.school;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.absence, me.student, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), me.student, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;
    END IF;
--
-- Checking that the school of the teacher is equal to that of the classroom
--
  PERFORM 1
     FROM persons p
    WHERE p.person = new.teacher
      AND p.school = me.school;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,14), new.absence, new.teacher, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      END IF;
    END IF;
--
-- Checking that the student, in the on_date, has not already been recorded as delay
--
  PERFORM 1
     FROM delays d
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;

  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.absence, me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;
  END IF;
--
-- Checking that the student, in the on_date, has not already been recorded as exit
--
  PERFORM 1
     FROM leavings
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;

  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,22),new.absence, me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,23);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,24),me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,23);
    END IF;
  END IF;
--
-- Checking that the student, in the on_date, has not already been recorded as exit of class
--
  PERFORM 1
     FROM out_of_classrooms
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;

      IF FOUND THEN
        IF (TG_OP = 'UPDATE') THEN
          RAISE EXCEPTION USING
            ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'D'),
            MESSAGE = utility.system_messages_locale(system_messages,25),
	    DETAIL = format(utility.system_messages_locale(system_messages,26), new.absence, me.student, me.classroom, new.on_date),
	    HINT = utility.system_messages_locale(system_messages,27);
        ELSE
          RAISE EXCEPTION USING
            ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'E'),
            MESSAGE = utility.system_messages_locale(system_messages,25),
            DETAIL = format(utility.system_messages_locale(system_messages,28), me.student, me.classroom, new.on_date),
            HINT = utility.system_messages_locale(system_messages,27);
        END IF;
      END IF;
--
-- Check that the student is in rule students
--
  IF NOT in_any_roles(me.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'F'),
        MESSAGE = utility.system_messages_locale(system_messages,29),
        DETAIL = format(utility.system_messages_locale(system_messages,30), new.absence, me.student),
        HINT = utility.system_messages_locale(system_messages,31);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'G'),
        MESSAGE = utility.system_messages_locale(system_messages,29),
        DETAIL = format(utility.system_messages_locale(system_messages,32), me.student),
        HINT = utility.system_messages_locale(system_messages,31);
      END IF;
    END IF;
--
-- Check that the teachers is in rule teachers
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'H'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.absence, new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'L'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;
  END IF;

  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_absences_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_absences_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_absences_iu() TO scuola247_executive;
GRANT EXECUTE ON FUNCTION public.tr_absences_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_absences_iu() FROM public;
