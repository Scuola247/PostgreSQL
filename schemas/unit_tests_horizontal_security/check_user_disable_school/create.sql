-- Function: unit_tests_horizontal_security.check_user_school_disable(text, text, bigint)

-- DROP FUNCTION unit_tests_horizontal_security.check_user_school_disable(text, text, bigint);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.check_user_school_disable(
    IN _group text,
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

    command = format('SET ROLE',_user);
    EXECUTE command;   
  --------------------------------------------------
  test_name= 'check user and school on table absence';
  --------------------------------------------------
  BEGIN 

    
    PERFORM 1  
       FROM public.absences
       JOIN public.persons on persons.person = absences.teacher
       WHERE person.school = _school;

       IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RESET ROLE;
           RETURN; 
       ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
       END IF;
        
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
/*
 BEGIN 
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table branches';
  --------------------------------------------------------
  
  PERFORM 1  
	FROM public.branches
	JOIN public.persons ON persons.school = branches.school
	WHERE branches.school = _school;
	
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RESET ROLE;
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table classrooms ';
  --------------------------------------------------------
  PERFORM 1  
	FROM public.classrooms 
	JOIN public.school_years ON classrooms.school_year = school_years.school_year
        JOIN public.persons ON school_years.school = persons.school
        WHERE persons.school = _school;
        
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RESET ROLE;
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table classrooms ';
  --------------------------------------------------------
  SET ROLE _user;
  PERFORM 1  
	FROM public.classrooms 
	JOIN public.school_years ON classrooms.school_year = school_years.school_year
        JOIN public.persons ON school_years.school = persons.school
        WHERE persons.school = _school;
        
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RESET ROLE;
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table classrooms ';
  --------------------------------------------------------
  SET ROLE _user;
  PERFORM 1
   FROM public.classrooms_students
   JOIN public.persons ON classrooms_students.student = persons.person
   WHERE persons.school = _school;
   
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RESET ROLE;
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table communication_type';
  ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1
   FROM public.classrooms_students
   JOIN public.persons ON classrooms_students.student = persons.person
   WHERE persons.school = _school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table communication_media';
  ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM
  public.communications_media
  JOIN  public.persons ON communications_media.person = persons.person  
  WHERE persons.school = school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table conversations';
  ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM
  public.conversations
  JOIN  public.classrooms_students ON conversations.classroom_student = classrooms_students.classroom_student
  JOIN  public.persons ON classrooms_students.student = persons.born
  WHERE persons.school = school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table conversation_invites';
  ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM
  public.conversations_invites 
  JOIN public.conversations ON conversations_invites.conversation = conversations.conversation
  JOIN public.classrooms_students ON conversations.classroom_student = classrooms_students.classroom_student 
  JOIN public.persons ON classrooms_students.student = persons.person
  WHERE persons.school = school;
  

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table conversations';
  ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM
  public.conversations
  JOIN  public.classrooms_students ON conversations.classroom_student = classrooms_students.classroom_student
  JOIN  public.persons ON classrooms_students.student = persons.born
  WHERE persons.school = school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table degrees';
 ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM 
        public.degrees 
  WHERE degrees.school = _school;
  

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table delays';
 ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM 
    public.delays
    JOIN public.explanations ON delays.explanation = explanations.explanation
    JOIN public.persons ON explanations.student = persons.person
  WHERE persons.school = school;
  

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table explenations';
 ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM 
    public.explanations 
    JOIN public.persons ON explanations.student = persons.person
    WHERE persons.school = school;


	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table faults';
 ---------------------------------------------------------------
  SET ROLE _user;
    PERFORM 1 FROM 
    public.faults
    JOIN public.persons ON faults.student = persons.person
    WHERE persons.school = school; 
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table grade_types';
 ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM 
      public.grade_types 
      JOIN public.subjects ON grade_types.subject = subjects.subject
      WHERE subjects.school = _school;
  
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table grades';
 ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM 
    public.grades
    JOIN public.metrics ON grades.metric = metrics.metric
    WHERE metrics.school = _school;
  
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table grading_meetings';
 ---------------------------------------------------------------
  SET ROLE _user;
    PERFORM 1 FROM 
      public.grade_types
      JOIN public.subjects ON grade_types.subject = subjects.subject
      WHERE subjects.school = _school;
  
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table grading_meetings_valutations';
 ---------------------------------------------------------------
  SET ROLE _user;
	PERFORM 1 FROM 
	  public.grading_meetings_valutations 
	  JOIN public.persons ON grading_meetings_valutations.student = persons.person
	  WHERE subjects.school = _school;
  
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  SET ROLE _user;
  PERFORM 1 FROM 
       public.grading_meetings_valutations
       JOIN public.persons ON grading_meetings_valutations.student = persons.person
       JOIN public.grading_meetings_valutations ON grading_meetings_valutations_qua.grading_meeting_valutation = grading_meetings_valutations.grading_meeting_valutation
       WHERE subjects.school = _school;
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
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
  test_name= 'check user and school on table holdays';
 ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1 FROM 
      public.holidays
      WHERE holidays.school = _school;
	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	RESET ROLE;
	RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	RESET ROLE;
        RETURN; 
    END IF;
  END;
  --BEGIN
*/

  
  RETURN;  
 
 END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.check_user_school_disable(text, text, bigint)
  OWNER TO postgres;
