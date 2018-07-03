-- Function: unit_tests_horizontal_security.check_user_enable_school(text, bigint)

-- DROP FUNCTION unit_tests_horizontal_security.check_user_enable_school(text, bigint);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.check_user_enable_school(
    IN _user text,
    IN _school bigint,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name	        text = '';
  error			diagnostic.error;
  school                bigint;
  command               text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);


  
  --------------------------------------------------
  test_name='check user and school on table absence';
  --------------------------------------------------
  BEGIN 
    command = format('SET ROLE %I', _user);
    EXECUTE command; 
    
    PERFORM 1  
       FROM public.absences
       JOIN public.persons on persons.person = absences.teacher
       WHERE person.school = _school;

       IF FOUND THEN
         _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
          RESET ROLE;
          RETURN; 
       ELSE 
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
       END IF;
       
  /* se si rileva una exception dovuta ai GRANT il testo viene considerato PASS perchè è compito degli unit test 
     della sicurezza verticale verificare le autorizzazioni dei GRANT e REVOKE */        
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
            RESET ROLE;
         RETURN; 
     END IF;
  END;
 BEGIN 
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table branches';
  --------------------------------------------------------
  
  PERFORM 1  
	FROM public.branches
	JOIN public.persons ON persons.school = branches.school
	WHERE branches.school = _school;
	
	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END;
     

BEGIN
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table classrooms ';
  --------------------------------------------------------
  PERFORM 1  
	FROM public.classrooms 
	JOIN public.school_years ON classrooms.school_year = school_years.school_year
        JOIN public.persons ON school_years.school = persons.school
        WHERE classrooms.school = _school;
        
	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
  END;
  BEGIN
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  -----------------------------------------
  test_name= ' table classrooms_students ';
  -----------------------------------------
  PERFORM 1  
	FROM public.classrooms_students
	JOIN public.persons ON classrooms_students.student = persons.person
	WHERE persons.school = _school;
        
	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
  END;

  BEGIN
       command = format('SET ROLE %I', _user);
      EXECUTE command;
  ---------------------------------------------------------------
  test_name= ' table communication_type';
  ---------------------------------------------------------------

  PERFORM 1
   FROM public.communication_types
   WHERE communication_types.school = _school;

	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END;

 BEGIN
  
  ---------------------------------------------------------------
  test_name= ' table communication_media';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
    FROM public.communications_media
    JOIN public.persons ON communications_media.person = persons.person
    WHERE persons.school = _school;

	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END; 
 BEGIN
  
  ---------------------------------------------------------------
  test_name= 'Table conversations ';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.conversations
	JOIN public.classrooms_students ON conversations.classroom_student = classrooms_students.classroom_student
	JOIN public.persons ON persons.person = classrooms_students.student
	WHERE persons.school = _school;

	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END; 
    
 BEGIN
  
  ---------------------------------------------------------------
  test_name= 'Table conversations_invites ';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.conversations_invites
	JOIN public.conversations ON conversations_invites.conversation = conversations.conversation
	JOIN public.classrooms_students ON conversations.classroom_student = classrooms_students.classroom_student
	JOIN public.persons ON classrooms_students.student = persons.person
	WHERE persons.school = _school;

	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END; 
 BEGIN
  
  ---------------------------------------------------------------
  test_name= 'Table degrees';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.degrees
	WHERE degrees.school = _school;

	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END;
 BEGIN
   ---------------------------------------------------------------
  test_name= 'Table delays';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1 
	FROM public.persons
	JOIN public.delays ON delays.teacher = persons.person
	WHERE persons.school = _school;
 
	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END;
 BEGIN
   ---------------------------------------------------------------
  test_name= 'Table explanations';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.explanations
	JOIN public.persons ON  explanations.student = persons.person
	WHERE persons.school = _school;
	
	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END;
 BEGIN
   ---------------------------------------------------------------
  test_name= 'Table faults';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.faults
	JOIN public.persons ON faults.student = persons.person
	WHERE persons.school = _school;
	
	IF FOUND THEN
	 _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));     
           RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;    
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
          RESET ROLE;
    RETURN; END IF;
 END;
 BEGIN
  ---------------------------------------------------------------
  test_name= 'Table grades_types';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.grade_types
	JOIN public.subjects ON grade_types.subject = subjects.subject
	WHERE public.subject = _school;
	
	IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN
  ---------------------------------------------------------------
  test_name= 'Table grades';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.grades
	JOIN public.schools ON grades.mnemonic = schools.mnemonic
	WHERE schools.school = _school;
  
	IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  ---------------------------------------------------------------
  test_name= 'Table grading_meetings';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
	FROM public.grading_meetings
	JOIN public.school_years ON grading_meetings.school_year = school_years.school_year
	WHERE school_years.school = _school;
		
	IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  ---------------------------------------------------------------
  test_name= 'Table grading_meetings_valutations';
  ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1
  	FROM 
	  public.grading_meetings_valutations 
	  JOIN public.persons ON grading_meetings_valutations.student = persons.person
	  WHERE persons.school=_school;
		
	IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN
---------------------------------------------------------------
  test_name= 'check user and school on table grading_meeting_valutation_qua';
 ---------------------------------------------------------------
      command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1 FROM 
       public.grading_meetings_valutations
       JOIN public.grading_meetings_valutations ON grading_meetings_valutations_qua.grading_meeting_valutation = grading_meetings_valutations.grading_meeting_valutation
       JOIN public.persons ON grading_meetings_valutations.student = persons.person
       WHERE person.school = _school;
	IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN


 ---------------------------------------------------------------
  test_name= 'check user and school on table holidays';
 ---------------------------------------------------------------
     command = format('SET ROLE %I', _user);
      EXECUTE command;  PERFORM 1 FROM 
      public.holidays
      WHERE holidays.school = _school;
	IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN

  ---------------------------------------------------------------
  test_name= 'check user and school on table leavings';
 ---------------------------------------------------------------
     command = format('SET ROLE %I', _user);
      EXECUTE command;
  SELECT 1 FROM 
    public.leavings
    JOIN public.persons ON leavings.teacher = persons.person
    WHERE persons.school = _school;

  
    IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN


 ---------------------------------------------------------------
  test_name= 'check user and school on table lessons';
 ---------------------------------------------------------------
     command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1 FROM 
    public.lessons
    JOIN public.persons ON lessons.teacher = persons.person
    WHERE persons.school = _school; 
    IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN 


  
 ---------------------------------------------------------------
  test_name= 'check user and school on table messages';
 ---------------------------------------------------------------
     command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1 FROM 
    public.messages 
    JOIN public.persons ON messages.person = persons.person
    WHERE persons.school = _school;
    IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN 

 ---------------------------------------------------------------
  test_name= 'check user and school on table messages_read';
 ---------------------------------------------------------------
     command = format('SET ROLE %I', _user);
      EXECUTE command;
  PERFORM 1 FROM 
    public.messages_read
    JOIN public.persons ON messages_read.person = persons.person
    WHERE persons.school = _school;
  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN 
 ---------------------------------------------------------------
  test_name= 'check user and school on table metrics';
 ---------------------------------------------------------------
     command = format('SET ROLE %I', _user);EXECUTE command;
  PERFORM 1 
	  FROM public.metrics
	  WHERE metrics.school = _school;
  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN
   --------------------------------------------------------
  test_name= 'check user and school on table notes';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.notes
     JOIN public.persons on persons.person = notes.teacher
    WHERE persons.school = _school;

          IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table notes_signed';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.notes_signed
     JOIN public.persons on persons.person = note_sigends.person
    WHERE persons.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
    
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table out_of_classrooms';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.out_of_classrooms
     JOIN public.classroom_students on classrooms_students.classroom_student = out_of_classrooms.classroom_student
     JOIN public.persons on persons.person = classroom_students.student
    WHERE persons.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table parents_meetings';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.parents_meetings
     JOIN public.persons on persons.person = parents_meetings.person
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table persons';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table persons_address';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons_address
     JOIN public.persons on persons.person = persons_address.person
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table persons_rolations';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons_address
     JOIN public.persons on persons.person = persons_relations.person
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table persons_roles';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons_roles
     JOIN public.persons on persons.person = persons_roles.person
    WHERE persons.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table qualifications';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.qualifications
    WHERE qualifications.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table qualifications_plan';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.qualifications_plan
     JOIN public.degrees on degrees.degree = qualifications_plan.degree
    WHERE degrees.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;

  ------------------------ DA FARE TABELA REGIONS------------------------------
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table school_years';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.school_years
    WHERE school_years.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table schools';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.schools
    WHERE schools.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table signatures';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.signatures
     JOIN public.persons on persons.person = signatures.teacher
    WHERE persons.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table subjects';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.subjects
    WHERE subjects.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table teacher_notes';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.teachears_notes
     JOIN public.persons on persons.person = teachears_notes.student
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
    
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table topics';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.topics
     JOIN public.degrees on degrees.degree = topics.degree
    WHERE degrees.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;

  ----------------------------- DA FARE TABELLA USENAMES_EX --------------------------------
    
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  -------------------------------------------------------------
  test_name= 'check user and school on table usenames_schools';
  -------------------------------------------------------------
  
  PERFORM 1  
     FROM public.usenames_schools
    WHERE usenames_schools.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table valutations';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.valutations
     JOIN public.persons on persons.person = valutations.teacher
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  -----------------------------------------------------------------------
  test_name= 'check user and school on table valutations_qualifications';
  -----------------------------------------------------------------------
  
  PERFORM 1  
     FROM public.valutations_qualifications
     JOIN public.valutations on valutations.valutation = valutations_qualifications.valutation
     JOIN public.persons on persons.person = valutations.teacher
    WHERE persons.school = _school;

  IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  -----------------------------------------------------------------------
  test_name= 'check user and school on table weekly_timetables';
  -----------------------------------------------------------------------
  
  PERFORM 1  
     FROM public.weekly_timetables
     JOIN public.classrooms on classrooms.classroom = weekly_timetables.classroom
     JOIN public.degrees on degrees.degree = classrooms.degree
    WHERE degrees.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  
 BEGIN
  command = format('SET ROLE %I', _user);EXECUTE command;
  --------------------------------------------------------
  test_name= 'check user and school on table valutations';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.weekly_timetables_days
     JOIN public.persons on persons.person = weekly_timetables_days.teacher
    WHERE persons.school = _school;

   IF FOUND THEN
	   _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
	RESET ROLE;
	RETURN; 
        ELSE 
         _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
------------------------ DA FARE TABELLA WIKIMEDIA_FILES--------------------------
------------------------ DA FARE TABELLA WIKIMEDIA_FILES_PERSONS------------------

 
  RETURN;  
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.check_user_enable_school(text, bigint)
  OWNER TO postgres;
