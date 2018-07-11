-- Function: unit_tests_horizontal_security.check_user_disable_school(text, text, bigint)

-- DROP FUNCTION unit_tests_horizontal_security.check_user_disable_school(text, text, bigint);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.check_user_disable_school(
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
--  school                bigint;
  command               text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  command = format('SET ROLE',_user);
  EXECUTE command;     
  -----------------------------------------------------
  test_name= 'CHECK user and school on table absences';
  -----------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.absences a
      JOIN public.persons p on p.person = a.teacher
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
     
  -----------------------------------------------------
  test_name= 'CHECK user and school on table branches';
  -----------------------------------------------------
  BEGIN
    PERFORM 1  
	    FROM public.branches b 
	    WHERE b.school = _school;
	
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;      
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
      
  --------------------------------------------------------
  test_name= 'CHECK user and school on table classrooms ';
  --------------------------------------------------------
  BEGIN
    PERFORM 1  
	    FROM public.classrooms c
	    JOIN public.school_years sy ON c.school_year = sy.school_year
      JOIN public.persons p ON sy.school = p.school
      WHERE p.school = _school;
        
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  -----------------------------------------------------------------
  test_name= 'CHECK user and school on table classrooms_students ';
  -----------------------------------------------------------------
  BEGIN   
    PERFORM 1
      FROM public.classrooms_students cs
      JOIN public.persons p ON cs.student = p.person
      WHERE p.school = _school;
   
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ----------------------------------------------------------------
  test_name= 'CHECK user and school on table communication_types';
  ----------------------------------------------------------------
  BEGIN    
    PERFORM 1
      FROM public.comunication_types ct
      WHERE ct.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  -----------------------------------------------------------------
  test_name= 'CHECK user and school on table communications_media';
  -----------------------------------------------------------------
  BEGIN
    PERFORM 1 FROM
      public.communications_media cm
      JOIN  public.persons p ON cm.person = p.person  
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ----------------------------------------------------------
  test_name= 'CHECK user and school on table conversations';
  ----------------------------------------------------------
  BEGIN
    PERFORM 1 FROM
      public.conversations c
      JOIN  public.classrooms_students cs ON c.classroom_student = cs.classroom_student
      JOIN  public.persons p ON cs.student = p.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  -----------------------------------------------------------------
  test_name= 'CHECK user and school on table conversation_invites';
  -----------------------------------------------------------------
  BEGIN   
    PERFORM 1 FROM
      public.conversations_invites ci
      JOIN public.conversations c ON ci.conversation = c.conversation
      JOIN public.classrooms_students cs ON c.classroom_student = cs.classroom_student 
      JOIN public.persons p ON cs.student = p.person
      WHERE p.school = _school;
  
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ----------------------------------------------------
  test_name= 'CHECK user and school on table degrees';
  ----------------------------------------------------
  BEGIN   
    PERFORM 1 FROM 
      public.degrees d 
      WHERE d.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

 ----------------------------------------------------
  test_name= 'CHECK user and school on table delays';
 ----------------------------------------------------
  BEGIN   
    PERFORM 1 FROM 
      public.delays d
      JOIN public.explanations e ON d.explanation = e.explanation
      JOIN public.persons p ON e.student = p.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ---------------------------------------------------------
  test_name= 'CHECK user and school on table explenations';
  ---------------------------------------------------------
  BEGIN    
    PERFORM 1 FROM 
      public.explanations e
      JOIN public.persons p ON e.student = p.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ---------------------------------------------------
  test_name= 'CHECK user and school on table faults';
  ---------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.faults f
      JOIN public.persons p ON f.student = p.person
      WHERE p.school = _school; 

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  --------------------------------------------------------
  test_name= 'CHECK user and school on table grade_types';
  --------------------------------------------------------
  BEGIN  
    PERFORM 1 FROM 
      public.grade_types gt 
      JOIN public.subjects s ON gt.subject = s.subject
      WHERE s.school = _school;
  
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
  


  ---------------------------------------------------
  test_name= 'CHECK user and school on table grades';
  ---------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.grades g
      JOIN public.metrics m ON g.metric = m.metric
      WHERE m.school = _school;
  
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
  
  -------------------------------------------------------------
  test_name= 'CHECK user and school on table grading_meetings';
  -------------------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.grade_meetings gm
      JOIN public.school_years sy ON gm.school_year = sy.school_year
      WHERE sy.school = _school;
  
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  -------------------------------------------------------------------------
  test_name= 'CHECK user and school on table grading_meetings_valutations';
  -------------------------------------------------------------------------
  BEGIN     
	  PERFORM 1 FROM 
	    public.grading_meetings_valutations gmv
	    JOIN public.persons p ON gmv.student = p.person
	    WHERE p.school = _school;
  
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ---------------------------------------------------------------------------
  test_name= 'CHECK user and school on table grading_meeting_valutation_qua';
  ---------------------------------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.grading_meetings_valutations_qua gmvq
      JOIN public.grading_meetings_valutations gmv ON gmvq.grading_meeting_valutation = gmv.grading_meeting_valutation
      JOIN public.persons p ON gmv.student = p.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

 ---------------------------------------------------------------
  test_name= 'CHECK user and school on table holidays';
 ---------------------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.holidays h
      WHERE h.school = _school;
	
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	    RESET ROLE;
	    RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  -----------------------------------------------------
  test_name= 'CHECK user and school on table leavings';
  -----------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.leavings l
      JOIN public.persons p ON l.teacher = p.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	    RESET ROLE;
	    RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ----------------------------------------------------
  test_name= 'CHECK user and school on table lessons';
  ----------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.lessons le
      JOIN public.persons p ON le.teacher = p.person
      WHERE p.school = _school; 

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	    RESET ROLE;
	    RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
 	      RESET ROLE;
        RETURN; 
      END IF;
  END;
  
  -----------------------------------------------------
  test_name= 'CHECK user and school on table messages';
  -----------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.messages me
      JOIN public.persons p ON me.person = p.person
      WHERE p.school = _school;

      IF FOUND THEN
        _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	      RESET ROLE;
	      RETURN; 
      ELSE 
        _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
      END IF;
      EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
        IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	        RESET ROLE;
          RETURN; 
        END IF;
  END;
 
  ----------------------------------------------------------
  test_name= 'CHECK user and school on table messages_read';
  ----------------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.messages_read mr
      JOIN public.persons p ON mr.person = p.person
      WHERE p.school = _school;
 
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	    RESET ROLE;
	    RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
  
  ----------------------------------------------------
  test_name= 'CHECK user and school on table metrics';
  ----------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.metrics m
      WHERE m.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
	    RESET ROLE;
	    RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
    
  --------------------------------------------------
  test_name= 'CHECK user and school on table notes';
  --------------------------------------------------
  BEGIN     
    PERFORM 1 FROM 
      public.notes n
      JOIN public.persons p ON n.student = p.person
      WHERE p.school = _school;
  
    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  --------------------------------------------------------
  test_name= 'CHECK user and school on table notes_signed';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.notes_signed ns
      JOIN public.persons p ON p.person = ns.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
      
  --------------------------------------------------------------
  test_name= 'CHECK user and school on table out_of_classrooms';
  --------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.out_of_classrooms ooc 
      JOIN public.classroom_students cs on cs.classroom_student = ooc.classroom_student
      JOIN public.persons p on p.person = classroom_students.student
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
  
  -------------------------------------------------------------
  test_name= 'CHECK user and school on table parents_meetings';
  -------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.parents_meetings pm
      JOIN public.persons p ON p.person = pm.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
   
  ----------------------------------------------------
  test_name= 'CHECK user and school on table persons';
  ----------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.persons p
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
  
  ------------------------------------------------------------
  test_name= 'CHECK user and school on table persons_address';
  ------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.persons_address pa
      JOIN public.persons p ON p.person = pa.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
   
  --------------------------------------------------------------
  test_name= 'CHECK user and school on table persons_relations';
  --------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.persons_relations pre
      JOIN public.persons p on p.person = pre.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
 
  ---------------------------------------------------------
  test_name= 'CHECK user and school on table persons_roles';
  ---------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.persons_roles pr
      JOIN public.persons p ON p.person = pr.person
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
   
  -----------------------------------------------------------
  test_name= 'CHECK user and school on table qualifications';
  -----------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.qualifications q
      WHERE q.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
 
  ----------------------------------------------------------------
  test_name= 'CHECK user and school on table qualifications_plan';
  ----------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.qualifications_plan qualifications_plan
      JOIN public.degrees d on d.degree = qp.degree
      WHERE d.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  ---------------------------------------------------------
  test_name= 'CHECK user and school on table school_years';
  ---------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.school_years sy
      WHERE sy.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
   
  --------------------------------------------------------
  test_name= 'CHECK user and school on table schools';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.schools sc
      WHERE sc.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
    
  -------------------------------------------------------
  test_name= 'CHECK user and school on table signatures';
  -------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.signatures si
      JOIN public.persons p on p.person = si.teacher
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
    
  -----------------------------------------------------
  test_name= 'CHECK user and school on table subjects';
  -----------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.subjects s
      WHERE s.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
    
  --------------------------------------------------------
  test_name= 'CHECK user and school on table teacher_notes';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.teachears_notes tn
      JOIN public.persons p on p.person = tn.student
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
        
  --------------------------------------------------------
  test_name= 'CHECK user and school on table topics';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.topics t
      JOIN public.degrees d on d.degree = t.degree
      WHERE d.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  --------------------------------------------------------
  test_name= 'CHECK user and school on table usenames_ex';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.usenames_ex ue
      JOIN public.usenames_schools us ON ue.usename = us.usename
      WHERE us.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  -------------------------------------------------------------
  test_name= 'CHECK user and school on table usenames_schools';
  -------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.usenames_schools us
      WHERE us.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
   
  --------------------------------------------------------
  test_name= 'CHECK user and school on table valutations';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.valutations v
      JOIN public.persons p on p.person = v.teacher
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
    
  -----------------------------------------------------------------------
  test_name= 'CHECK user and school on table valutations_qualifications';
  -----------------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.valutations_qualifications vq
      JOIN public.valutations v ON v.valutation = vq.valutation
      JOIN public.persons p ON p.person = v.teacher
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  --------------------------------------------------------------
  test_name= 'CHECK user and school on table weekly_timetables';
  --------------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.weekly_timetables wt
      JOIN public.classrooms c ON c.classroom = wt.classroom
      JOIN public.degrees d ON d.degree = c.degree
      WHERE d.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;
   
  --------------------------------------------------------
  test_name= 'CHECK user and school on table valutations';
  --------------------------------------------------------
  BEGIN 
    PERFORM 1  
      FROM public.weekly_timetables_days wtd
      JOIN public.persons p on p.person = wtd.teacher
      WHERE p.school = _school;

    IF FOUND THEN
      _results = _results ||assert.fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
      RESET ROLE;
      RETURN; 
    ELSE 
      _results = _results ||assert.pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
    END IF;     
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
      IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN 
	      RESET ROLE;
        RETURN; 
      END IF;
  END;

  RETURN;  
END
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.check_user_disable_school(text, text, bigint)
  OWNER TO postgres;
