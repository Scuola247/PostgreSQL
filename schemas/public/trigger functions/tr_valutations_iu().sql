-- Function: public.tr_valutations_iu()

-- DROP FUNCTION public.tr_valutations_iu();

CREATE OR REPLACE FUNCTION public.tr_valutations_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  school		bigint;
  classroom		BIGINT;
  student		BIGINT;
  metric		bigint;
-- variables for system tools  
  context		text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The pupil does not belong to the same institute of the class.')::utility.system_message,
    ('en', 2, 'In the evaluation: ''%L'' who is updating the pupil: ''%L ''(a person in the person table) does not belong to the same institute: ''%L'' of the class: ''%L''')::utility.system_message,
    ('en', 3, 'Check the student or subject matter and retry the operation.')::utility.system_message,
    ('en', 4, 'Material does not belong to the same institute of the class.')::utility.system_message,
    ('en', 5, 'In the evaluation: %L that is being updated, the matter: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 6, 'Check the matter or class indicated and retry the operation.')::utility.system_message,
    ('en', 7, 'Voting type is not the same as evaluation.')::utility.system_message,
    ('en', 8, 'In the evaluation: %L being updated, the vote type: %L is not the same: %L.')::utility.system_message,
    ('en', 9, 'Check the voting type or matter and retry the operation.')::utility.system_message,
    ('en', 10, 'The argument is not of the same subject as the evaluation.')::utility.system_message,
    ('en', 11, 'In the evaluation: %L that is being updated, the argument  L is not the same subject: %L.')::utility.system_message,
    ('en', 12, 'Check the topic or matter and retry the operation.')::utility.system_message,
    ('en', 13, 'The year of course and the school address of the subject are not the same as the class..')::utility.system_message,
    ('en', 14, 'In the evaluation: %L being updated, the course year and school address of the argument% L are not the same as the class: %L.')::utility.system_message,
    ('en', 15, 'Check the course year and the school address of the subject or subject matter and retry the operation.')::utility.system_message,
    ('en', 16, 'The voting metric does not belong to the same institute of the class.')::utility.system_message,
    ('en', 17, 'In the evaluation: %L that is being updated, the voting metric: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 18, 'Check the vote or matter and retry the operation.')::utility.system_message,
    ('en', 19, 'The person indicated as a pupil is not.')::utility.system_message,
    ('en', 20, 'In evaluation: %L who is updating the person: %L indicated as pupil does not have the role = ''Student''.')::utility.system_message,
    ('en', 21, 'Check the person listed as a pupil or rule the role in the people table.')::utility.system_message,
    ('en', 22, 'The note is not about this pupil and this teacher.')::utility.system_message,
    ('en', 23, 'In the evaluation: %L who is updating the note: %L is not pupil: %L and not even the teacher: %L.')::utility.system_message,
    ('en', 24, 'Check the note indicated or the person indicated as pupil and teacher and retry the operation.')::utility.system_message,
    ('en', 25, 'The teacher does not belong to the same class institute.')::utility.system_message,
    ('en', 26, 'In the evaluation: %L who is updating the teacher: %L (one person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 27, 'Check the instructor or subject matter and retry the operation.')::utility.system_message,
    ('en', 28, 'The person indicated as a teacher is not.')::utility.system_message,
    ('en', 29, 'Nella valutazione: %L che si sta aggiornando, la persona: %L indicata come docente non ha il ruolo=''Teacher''.')::utility.system_message,
    ('en', 30, 'Check the person named as a teacher or correct the role in the people table.')::utility.system_message,
    ('en', 31, 'Evaluation date is not valid.')::utility.system_message,
    ('en', 32, 'In evaluation: %L being updated, evaluation date: %L is not between the beginning and end of classroom lessons: %L.')::utility.system_message,
    ('en', 33, 'check the evaluation date and retry the operation.')::utility.system_message,
    ('en', 34, 'In the evaluation you are entering the pupil: %L (a person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 35, 'In the evaluation you are entering, the matter: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 36, 'In the rating you are entering, the rating type: %L is not the same: %L.')::utility.system_message,
    ('en', 37, 'In the evaluation you are entering, the argument% L is not the same: %L.')::utility.system_message,
    ('en', 38, 'In the evaluation you are entering, the course year and the school address of the argument% L are not the same as the class: %L.')::utility.system_message ,
    ('en', 39, 'In the evaluation you are entering, the voting metric: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 40, 'In the evaluation you are entering, the person: %L indicated as pupil does not have the role = '' Student ''.')::utility.system_message,
    ('en', 41, 'In the evaluation you are entering, note: %L is not pupil: %L and teacher: %L.')::utility.system_message,
    ('en', 42, 'In the evaluation you are entering, the teacher: %L (a person in the person table) does not belong to the same institution: %L of the class: %L.')::utility.system_message,
    ('en', 43, 'In the evaluation you are entering, the person: %L indicated as a teacher does not have the role = ''teacher'' .')::utility.system_message,
    ('en', 44, 'In the evaluation you are entering, the date of evaluation: %L is not between the beginning and end of class class lessons: %L.')::utility .system_message,
    ('en', 45, 'The evaluation duplicates the following data: class, subject, teacher, pupil, day, type_quote, argument, metric.')::utility.system_message,
    ('en', 46, 'The mark: %L has the metric: %L that is already present in the class database: %L, subject: %L, teacher: %L, pupil: %L, day: %L, % L and topic: %L.')::utility.system_message,
    ('en', 47, 'Check the values ​​of: class, subject, teacher, day, type_type, topic, vote and replay the operation.')::utility.system_message,
    ('en', 48, 'The% L of the evaluation you are entering has the metric: %L already in the class database: %L, subject: %L, teacher: %L, pupil: %L, day: %L, : %L and argument: %L.')::utility.system_message,
    ('en', 49, 'If evaluation is indicated as private can not have an associated note.')::utility.system_message,
    ('en', 50, 'Evaluation: %L was shown as private but has been associated with the note: %L.')::utility.system_message,
    ('en', 51, 'Check the ''private'' and ''note'' and repeat the operation.')::utility.system_message,
    ('en', 52, 'The rating you are entering has been shown as private but has been associated with the note: %L.')::utility.system_message,
    ('it', 1, 'L''alunno non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 2, 'Nella valutazione: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 3, 'Controllare l''alunno o la materia indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 4, 'La materia non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 5, 'Nella valutazione: %L che si sta aggiornando, la materia: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 6, 'Controllare la materia o la classe indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 7, 'Il tipo voto non è della stessa materia della valutazione.')::utility.system_message,
    ('it', 8, 'Nella valutazione: %L che si sta aggiornando, il tipo voto: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 9, 'Controllare il tipo voto oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 10, 'L''argomento non è della stessa materia della valutazione.')::utility.system_message,
    ('it', 11, 'Nella valutazione: %L  che si sta aggiornando, l''argomento: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 12, 'Controllare l''argomento oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 13, 'L''anno di corso e l''indirizzo scolastico dell''argomento non sono gli stessi della classe..')::utility.system_message,
    ('it', 14, 'Nella valutazione: %L che si sta aggiornando,  l''anno di corso e l''indirizzo scolastico dell'' argomento: %L non sono gli stessi della classe: %L.')::utility.system_message,
    ('it', 15, 'Controllare l''anno di corso e l''indirizzo scolastico dell''argomento indicato oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 16, 'La metrica del voto non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 17, 'Nella valutazione: %L che si sta aggiornado, la metrica del voto: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 18, 'Controllare il voto oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 19, 'La persona indicata come alunno non lo è.')::utility.system_message,
    ('it', 20, 'Nella valutazione: %L che si sta aggiornando la persona: %L indicata come alunno non ha il ruolo=''Student''.')::utility.system_message,
    ('it', 21, 'Controllare la persona indicata come alunno oppure coreggere il ruolo nella tabella persone.')::utility.system_message,
    ('it', 22, 'La nota non è di questo alunno e di questo docente.')::utility.system_message,
    ('it', 23, 'Nella valutazione: %L che si sta aggiornando la nota: %L non è dell''alunno: %L e nemmeno del docente: %L.')::utility.system_message,
    ('it', 24, 'Controlla la nota indicata oppure le persona indicata come alunno e docente e ritenta l''operazione.')::utility.system_message,
    ('it', 25, 'Il docente non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 26, 'Nella valutazione: %L che si sta aggiornando il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 27, 'Controllare il docente o la materia indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 28, 'La persona indicata come docente non lo è.')::utility.system_message,
    ('it', 29, 'Nella valutazione: %L che si sta aggiornando, la persona: %L indicata come docente non ha il ruolo=''Teacher''.')::utility.system_message,
    ('it', 30, 'Controllare la persona indicata come docente oppure correggere il ruolo nella tabella persone.')::utility.system_message,
    ('it', 31, 'La data della valutazione non è valida.')::utility.system_message,
    ('it', 32, 'Nella valutazione: %L che si sta aggiornando, la data della valutazione: %L non è compresa fra l''inizio e la fine delle lezioni dell''anno scolastico della classe: %L.')::utility.system_message,
    ('it', 33, 'controllare la data della valutazione e ritentare l''operazione.')::utility.system_message,
    ('it', 34, 'Nella valutazione che si sta inserendo l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 35, 'Nella valutazione che si sta inserendo, la materia: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 36, 'Nella valutazione che si sta inserendo, il tipo voto: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 37, 'Nella valutazione che si sta inserendo, l''argomento: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 38, 'Nella valutazione che si sta inserendo, l''anno di corso e l''indirizzo scolastico dell'' argomento: %L non sono gli stessi della classe: %L.')::utility.system_message,
    ('it', 39, 'Nella valutazione che si sta inserendo, la metrica del voto: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 40, 'Nella valutazione che si sta inserendo, la persona: %L indicata come alunno non ha il ruolo=''Student''.')::utility.system_message,
    ('it', 41, 'Nella valutazione che si sta inserendo, la nota: %L non è dell''alunno: %L e del docente: %L.')::utility.system_message,
    ('it', 42, 'Nella valutazione che si sta inserendo, il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 43, 'Nella valutazione che si sta inserendo, la persona: %L indicata come docente non ha il ruolo=''Teacher''.')::utility.system_message,
    ('it', 44, 'Nella valutazione che si sta inserendo, la data della valutazione: %L non è compresa fra l''inizio e la fine delle lezioni dell''anno scolastico della classe: %L.')::utility.system_message,
    ('it', 45, 'La valutazione duplica i seguenti dati: classe,materia,docente,alunno,giorno,tipo_voto,argomento,metrica.')::utility.system_message,
    ('it', 46, 'Il voto: %L della valutazione: %L ha la metrica: %L che è già presente nel database con classe: %L, materia: %L, docente: %L, alunno: %L, giorno: %L, tipo_voto: %L e argomento: %L.')::utility.system_message,
    ('it', 47, 'Controllare i valori di: classe,materia,docente,giorno,tipo_voto,argomento,voto e riproporre l''operazione.')::utility.system_message,
    ('it', 48, 'Il voto: %L della valutazione che si sta inserendo ha la metrica: %L che è già presente nel database con classe: %L, materia: %L, docente: %L, alunno: %L, giorno: %L, tipo_voto: %L e argomento: %L.')::utility.system_message,
    ('it', 49, 'Se la valutazione viene indicata come privata non può avere una nota associata.')::utility.system_message,
    ('it', 50, 'La valutazione: %L è stata indicata come privata ma gli è stata associata la nota: %L.')::utility.system_message,
    ('it', 51, 'Controllare i valori di ''privata'' e ''nota'' e riproporre l''operazione.')::utility.system_message,
    ('it', 52, 'La valutazione che si sta inserendo è stata indicata come privata ma gli è stata associata la nota: %L.')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- Retrieve the school and the classroom
--
  SELECT sy.school, c.classroom, cs.student INTO me.school, me.classroom, me.student
    FROM classrooms_students cs
    JOIN classrooms c ON c.classroom = cs.classroom
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- check that the school of student is equal to school of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = me.student 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.valutation, me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,34), me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the school of subject is equal to school of the classroom
--
  PERFORM 1 
     FROM subjects s
    WHERE subject = new.subject 
      AND s.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,4),
        DETAIL = format(utility.system_messages_locale(system_messages,5), new.valutation, new.subject, me.school,me.classroom),
        HINT = utility.system_messages_locale(system_messages,6);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,4),
        DETAIL = format(utility.system_messages_locale(system_messages,35), new.valutation, new.subject, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,6);
    END IF;       
  END IF;
--
-- check that the type grade is equals to subject of the valutation
--
  PERFORM 1 FROM grade_types WHERE grade_type = new.grade_type AND subject = new.subject;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,7),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.valutation, new.grade_type, new.subject),
        HINT = utility.system_messages_locale(system_messages,9);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,7),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.grade_type, new.subject),
        HINT = utility.system_messages_locale(system_messages,9);
    END IF;       
  END IF;
--
-- check that the topic is the same subject of the valutation
--
  IF new.topic IS NOT NULL THEN
    PERFORM 1 FROM topics WHERE topic = new.topic AND subject = new.subject;
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,10),
          DETAIL = format(utility.system_messages_locale(system_messages,11), new.valutation, new.topic, new.subject),
          HINT = utility.system_messages_locale(system_messages,12);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,10),
          DETAIL = format(utility.system_messages_locale(system_messages,37), new.topic, new.subject),
          HINT = utility.system_messages_locale(system_messages,12);
      END IF;     
    END IF;
  END IF;
--
-- check that the course_year and degree of topic are the same of the classroom
--
  IF new.topic IS NOT NULL THEN
    PERFORM 1 FROM classrooms c
              JOIN topics a ON (     a.degree = c.degree 
                                AND  a.course_year = c.course_year)
             WHERE c.classroom = me.classroom 
               AND a.topic = new.topic;
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,14), new.valutation, new.topic, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,38), new.topic, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      END IF;     
    END IF;
  END IF;
--
-- check that the school of metric of grade is the same of the classroom
--
  PERFORM 1 
     FROM metrics m
     JOIN grades v ON (m.metric = v.metric)
    WHERE v.grade = new.grade 
      AND m.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,16),
        DETAIL = format(utility.system_messages_locale(system_messages,17), new.valutation, new.grade, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,18);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,16),
        DETAIL = format(utility.system_messages_locale(system_messages,39), new.grade, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,18);
    END IF;       
  END IF;
--
-- check that the student is a person in rule 'Student'
--
  IF NOT in_any_roles(me.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'D'),
      MESSAGE = utility.system_messages_locale(system_messages,19),
      DETAIL = format(utility.system_messages_locale(system_messages,20), new.valutation, me.student),
      HINT = utility.system_messages_locale(system_messages,21);
    ELSE
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'E'),
      MESSAGE = utility.system_messages_locale(system_messages,19),
      DETAIL = format(utility.system_messages_locale(system_messages,40), me.student),
      HINT = utility.system_messages_locale(system_messages,21);
    END IF;    
  END IF;
--
-- check that the note refer to the same student and at the same teacher
--
  IF new.note IS NOT NULL THEN
    PERFORM 1 FROM notes n
      WHERE n.note = new.note
        AND n.student = me.student
        AND n.teacher = new.teacher;
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'F'),
          MESSAGE = utility.system_messages_locale(system_messages,22),
          DETAIL = format(utility.system_messages_locale(system_messages,23), new.valutation, new.note, me.student, new.teacher),
          HINT = utility.system_messages_locale(system_messages,24);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'G'),
          MESSAGE = utility.system_messages_locale(system_messages,22),
          DETAIL = format(utility.system_messages_locale(system_messages,41), new.note, me.student, new.teacher),
          HINT = utility.system_messages_locale(system_messages,24);
      END IF;     
    END IF;
  END IF;
--
-- check that teacher's school is equals to teacher's classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'H'),
        MESSAGE = utility.system_messages_locale(system_messages,25),
        DETAIL = format(utility.system_messages_locale(system_messages,26), new.valutation, new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,27);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'I'),
        MESSAGE = utility.system_messages_locale(system_messages,25),
        DETAIL = format(utility.system_messages_locale(system_messages,42), new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,27);
    END IF;    
  END IF;
--
-- check that the teacher is a person in rule 'Teacher'
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'L'),
        MESSAGE = utility.system_messages_locale(system_messages,28),
        DETAIL = format(utility.system_messages_locale(system_messages,29), new.valutation, new.teacher),
        HINT = utility.system_messages_locale(system_messages,30);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'M'),
        MESSAGE = utility.system_messages_locale(system_messages,28),
        DETAIL = format(utility.system_messages_locale(system_messages,43), new.teacher),
        HINT = utility.system_messages_locale(system_messages,30);
    END IF;    
  END IF;
--
-- Check that the on_dates of valutation is between the begin_on and end_on the school year
--
  PERFORM 1 
     FROM school_years a
     JOIN classrooms c ON a.school_year = c.school_year
    WHERE c.classroom = me.classroom 
      AND a.lessons_duration @> new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'N'),
        MESSAGE = utility.system_messages_locale(system_messages,31),
        DETAIL = format(utility.system_messages_locale(system_messages,32), new.valutation, new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,33);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'O'),
        MESSAGE = utility.system_messages_locale(system_messages,31),
        DETAIL = format(utility.system_messages_locale(system_messages,44), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,33);
    END IF;    
  END IF;
--
-- Check that the classroom, subject, teacher, on_dates, grade_type, topic there is a single metric
--
  SELECT g.metric 
    INTO me.metric 
    FROM grades g 
   WHERE g.grade = new.grade;
    
  PERFORM 1 
     FROM valutations va
     JOIN grades vo ON va.grade = vo.grade
    WHERE va.classroom_student = new.classroom_student
      AND va.subject = new.subject
      AND va.teacher = new.teacher
      AND va.on_date = new.on_date
      AND va.grade_type = new.grade_type
      AND va.topic = new.topic
      AND vo.metric = me.metric
      AND va.valutation <> new.valutation;
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'P'),
        MESSAGE = diagnostic.my_sqlcode(me.full_function_name,'P') || ' ' || utility.system_messages_locale(system_messages,45),
        DETAIL = format(utility.system_messages_locale(system_messages,46), new.grade, new.valutation, me.metric, me.classroom, new.subject, new.teacher, me.student, new.on_date, new.grade_type, new.topic),
        HINT = utility.system_messages_locale(system_messages,47);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'Q'),
        MESSAGE = diagnostic.my_sqlcode(me.full_function_name,'Q') || ' ' || utility.system_messages_locale(system_messages,45),
        DETAIL = format(utility.system_messages_locale(system_messages,48), new.grade, me.metric, me.classroom, new.subject, new.teacher, me.student, new.on_date, new.grade_type, new.topic),
        HINT = utility.system_messages_locale(system_messages,47);
    END IF;    
  END IF;        
--
-- If the valutation is private cannot be assigned a notes
--
  IF  new.private = true AND new.note IS NOT NULL THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'R'),
        MESSAGE = utility.system_messages_locale(system_messages,49),
        DETAIL = format(utility.system_messages_locale(system_messages,50), new.valutation, new.private, new.note),
        HINT = utility.system_messages_locale(system_messages,51);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'S'),
        MESSAGE = utility.system_messages_locale(system_messages,49),
        DETAIL = format(utility.system_messages_locale(system_messages,52), new.private, new.note),
        HINT = utility.system_messages_locale(system_messages,51);
    END IF;    
  END IF;
    
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_valutations_iu()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_valutations_iu() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_valutations_iu() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_valutations_iu() FROM public;
