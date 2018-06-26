-- Function: unit_tests_horizontal_security.check_user_school_able(text, text, bigint)

-- DROP FUNCTION unit_tests_horizontal_security.check_user_school_able(text, text, bigint);

CREATE OR REPLACE FUNCTION unit_tests_horizontal_security.check_user_school_able(
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

  
  --------------------------------------------------
  test_name='check user and school on table absence';
  --------------------------------------------------
  BEGIN 
    command = format('SET ROLE %I', _user);
    EXECUTE command; 
    
    PERFORM 1  
       FROM public.absences
       JOIN public.persons on persons.person = absences.teacher
       WHERE person.school <> _school;

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
 /*BEGIN 
  SET ROLE _user;
  --------------------------------------------------------
  test_name= 'check user and school on table branches';
  --------------------------------------------------------
  
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
     RESET ROLE;

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
   RESET ROLE;

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
   RESET ROLE;

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
   RESET ROLE;
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
   RESET ROLE;
*/
  RETURN;  
 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_horizontal_security.check_user_school_able(text, text, bigint)
  OWNER TO postgres;
