-- Function: unit_tests_horizontalsecurity.check_user_school(text, bigint)

-- DROP FUNCTION unit_tests_horizontalsecurity.check_user_school(text, bigint);

CREATE OR REPLACE FUNCTION unit_tests_horizontalsecurity.check_user_school(
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
	-- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;

  ----------------------------------------------------
  test_name= 'check user and school on table absence';
  ----------------------------------------------------
  BEGIN
    command = format('SET ROLE %L', _user);
    EXECUTE command; 

    PERFORM 1
       FROM public.absences
       JOIN public.persons on persons.person = absences.teacher
       WHERE person.school <> _school;

       IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RETURN;
       ELSE
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
       END IF;

  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
 BEGIN
  SET ROLE _user;
  -----------------------------------------------------
  test_name= 'check user and school on table branches';
  -----------------------------------------------------

  PERFORM 1
	FROM public.branches
	JOIN public.persons ON persons.school = branches.school
	WHERE branches.school <> _school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RETURN;
        ELSE
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
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
        WHERE persons.school <> _school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RETURN;
        ELSE
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
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
        WHERE persons.school <> _school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RETURN;
        ELSE
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  BEGIN
  --------------------------------------------------------
  test_name= 'check user and school on table classrooms ';
  --------------------------------------------------------
  SET ROLE _user;
  PERFORM 1
   FROM public.classrooms_students
   JOIN public.persons ON classrooms_students.student = persons.person
   WHERE persons.school <> _school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RETURN;
        ELSE
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  BEGIN

  ---------------------------------------------------------------
  test_name= 'check user and school on table communication_type';
  ---------------------------------------------------------------
  SET ROLE _user;
  PERFORM 1
   FROM public.classrooms_students
   JOIN public.persons ON classrooms_students.student = persons.person
   WHERE persons.school <> _school;

	IF FOUND THEN
           _results = _results || fail(full_function_name, test_name, format('User:%s, School:%s', _user, _school), NULL::diagnostic.error);
           RETURN;
        ELSE
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table notes';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.notes
     JOIN public.persons on persons.person = notes.teacher
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table notes_signed';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.notes_signed
     JOIN public.persons on persons.person = note_sigends.person
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
    
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table out_of_classrooms';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.out_of_classrooms
     JOIN public.classroom_students on classrooms_students.classroom_student = out_of_classrooms.classroom_student
     JOIN public.persons on persons.person = classroom_students.student
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
    EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table parents_meetings';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.parents_meetings
     JOIN public.persons on persons.person = parents_meetings.person
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table persons';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table persons_address';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons_address
     JOIN public.persons on persons.person = persons_address.person
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table persons_rolations';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons_address
     JOIN public.persons on persons.person = persons_relations.person
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table persons_roles';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.persons_roles
     JOIN public.persons on persons.person = persons_roles.person
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table qualifications';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.qualifications
    WHERE qualifications.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table qualifications_plan';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.qualifications_plan
     JOIN public.degrees on degrees.degree = qualifications_plan.degree
    WHERE degrees.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;

  ------------------------ DA FARE TABELA REGIONS------------------------------
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table school_years';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.school_years
    WHERE school_years.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table schools';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.schools
    WHERE schools.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table signatures';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.signatures
     JOIN public.persons on persons.person = signatures.teacher
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table subjects';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.subjects
    WHERE subjects.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table teacher_notes';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.teachears_notes
     JOIN public.persons on persons.person = teachears_notes.student
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
    
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table topics';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.topics
     JOIN public.degrees on degrees.degree = topics.degree
    WHERE degrees.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;

  ----------------------------- DA FARE TABELLA USENAMES_EX --------------------------------
    
 BEGIN
  SET ROLE _user;
  -------------------------------------------------------------
  test_name= 'check user and school on table usenames_schools';
  -------------------------------------------------------------
  
  PERFORM 1  
     FROM public.usenames_schools
    WHERE usenames_schools.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table valutations';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.valutations
     JOIN public.persons on persons.person = valutations.teacher
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  -----------------------------------------------------------------------
  test_name= 'check user and school on table valutations_qualifications';
  -----------------------------------------------------------------------
  
  PERFORM 1  
     FROM public.valutations_qualifications
     JOIN public.valutations on valutations.valutation = valutations_qualifications.valutation
     JOIN public.persons on persons.person = valutations.teacher
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
   EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  -----------------------------------------------------------------------
  test_name= 'check user and school on table weekly_timetables';
  -----------------------------------------------------------------------
  
  PERFORM 1  
     FROM public.weekly_timetables
     JOIN public.classrooms on classrooms.classroom = weekly_timetables.classroom
     JOIN public.degrees on degrees.degree = classrooms.degree
    WHERE degrees.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
  
 BEGIN
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table valutations';
  --------------------------------------------------------
  
  PERFORM 1  
     FROM public.weekly_timetables_days
     JOIN public.persons on persons.person = weekly_timetables_days.teacher
    WHERE persons.school <> _school;

        IF FOUND THEN
           _results = _results || fail(full_function_name, test_name,error, format('User:%s, School:%s', _user, _school));
           RETURN; 
        ELSE 
          _results = _results || pass(full_function_name, test_name, format('User:%s, School:%s', _user, _school));
        END IF;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
    IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
    END;
------------------------ DA FARE TABELLA WIKIMEDIA_FILES--------------------------
------------------------ DA FARE TABELLA WIKIMEDIA_FILES_PERSONS------------------


  RETURN;

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontalsecurity.check_user_school(text, bigint)
  OWNER TO scuola247_supervisor;
