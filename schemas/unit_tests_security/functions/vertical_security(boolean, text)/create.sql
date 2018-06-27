-- Function: unit_tests_security.vertical_security(boolean, text)

-- DROP FUNCTION unit_tests_security.vertical_security(boolean, text);

CREATE OR REPLACE FUNCTION unit_tests_security.test_current_role(
    IN _test_group text DEFAULT 'scuola247_supervisor'::text,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name		          text = '';
  error			            diagnostic.error;

  groups_enabled text[];
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

-- Absences
 ------------------------------
 test_name = 'SELECT Absences';
 ------------------------------

 BEGIN

    PERFORM 1 from public.absences WHERE absence = '33312000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);
    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
END;

 ------------------------------
 test_name = 'INSERT Absences';
 ------------------------------


 BEGIN

    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('1133312000000000','2013-10-04','32936000000000',NULL,'10372000000000');
    IF _group = 'scuola247_supervisor' OR _group = 'scuola247_executive' OR _group = 'scuola247_teacher' THEN
	_results = _results || assert.pass(full_function_name, test_name);
    ELSE
        _results = _results || assert.fail(full_function_name, test_name,format('SELECT was OK but the group %s shouldn''t be able to',_group), NULL::diagnostic.error);
	RETURN;
    END IF;
 EXCEPTION WHEN SQLSTATE '42501' THEN
        IF _group = 'scuola247_employee' OR _group = 'scuola247_student' OR _group = 'scuola247_relative' THEN
	_results = _results || assert.pass(full_function_name, test_name);
    ELSE
        _results = _results || assert.fail(full_function_name, test_name,format('SELECT wasn''t OK but the group %s should be able to',_group), NULL::diagnostic.error);
	RETURN;
    END IF;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
END;


 BEGIN
    groups_enabled = ARRAY['scuola247_supervisor', 'scuola247_executive']
    
    INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('1133312000000000','2013-10-04','32936000000000',NULL,'10372000000000');

    IF _group ANY groups_enabled THEN
	_results = _results || assert.pass(full_function_name, test_name);
    ELSE
        _results = _results || assert.fail(full_function_name, test_name,format('SELECT was OK but the group %s shouldn''t be able to',_group), NULL::diagnostic.error);
	RETURN;
    END IF;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    IF _group ANY groups_enabled THEN
        _results = _results || assert.fail(full_function_name, test_name,format('SELECT wasn''t OK but the group %s should be able to',_group), NULL::diagnostic.error);
	RETURN;
    ELSE
	_results = _results || assert.pass(full_function_name, test_name);
    END IF;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;
END;

     PERFORM unit_tests_security.statement_enabled(groups_enabled, sql);
     PERFORM unit_tests_security.check_statement_enabled(_test_group, ARRAY['scuola247_supervisor', 'scuola247_executive'], 'INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('1133312000000000','2013-10-04','32936000000000',NULL,'10372000000000');');
     PERFORM unit_tests_security.check_statement_enabled(_test_group, ARRAY['scuola247_supervisor', 'scuola247_executive'], 'INSERT INTO public.absences(absence,on_date,teacher,explanation,classroom_student) VALUES ('1133312000000000','2013-10-04','32936000000000',NULL,'10372000000000');');
--------------------------------------------------------------
-----------unit_tests_security.statement_enabled(text[], text)
--------------------------------------------------------------

BEGIN
    EXECUTE _sql;

    IF _group ANY groups_enabled THEN
	_results = _results || assert.pass(full_function_name, test_name);
    ELSE
        _results = _results || assert.fail(full_function_name, test_name,format('SELECT was OK but the group %s shouldn''t be able to',_group), NULL::diagnostic.error);
	RETURN;
    END IF;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    IF _group ANY groups_enabled THEN
        _results = _results || assert.fail(full_function_name, test_name,format('SELECT wasn''t OK but the group %s should be able to',_group), NULL::diagnostic.error);
	RETURN;
    ELSE
	_results = _results || assert.pass(full_function_name, test_name);
    END IF;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RETURN;


--------------------------------------------------------------
-----------unit_tests_security.statement_enabled(text[], text)
--------------------------------------------------------------





 -------------------------------------
 test_name = 'UPDATE Absences';
 -------------------------------------

 BEGIN

    UPDATE public.absences SET on_date = '2013-10-17' WHERE absence = '1133312000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
END;

 -------------------------------------
 test_name = 'DELETE Absences';
 -------------------------------------

 BEGIN

    DELETE FROM public.absences WHERE absence = '1133312000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
END;

-- Branches

 -------------------------------------
 test_name = 'SELECT Branches';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.branches WHERE branch = 9948000000000;
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
END;


 -------------------------------------
 test_name = 'INSERT Branches';
 -------------------------------------
 BEGIN

    INSERT INTO branches (branch, school, description) VALUES (119948000000000, 1000000000, 'Sede (test)');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
END;


 -------------------------------------
 test_name = 'UPDATE Branches';
 -------------------------------------

 BEGIN

    UPDATE public.branches SET description = 'sede non esistente' WHERE branch = 119948000000000;
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
END;


 -------------------------------------
 test_name = 'DELETE Branches';
 -------------------------------------

 BEGIN

    DELETE FROM public.branches WHERE branch = 119948000000000;
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
END;


-- Cities

 -------------------------------------
 test_name = 'SELECT Cities';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.cities WHERE city = '758438000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT Cities';
 -------------------------------------
 BEGIN

  INSERT INTO public.cities(fiscal_code,description,district,city) VALUES ('01','Airasca (test) (test)','758321000000000','11758438000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE Cities';
 -------------------------------------

 BEGIN

    UPDATE public.cities SET description = 'descrizione non esistente' WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE Cities';
 -------------------------------------

 BEGIN

    DELETE FROM public.cities WHERE city = '11758438000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- classrooms_students

 -------------------------------------
 test_name = 'SELECT classrooms_students';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.classrooms_students WHERE classroom_student = '1024600000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT classrooms_students';
 -------------------------------------
 BEGIN

    INSERT INTO public.classrooms_students(classroom_student,classroom,student,retreat_on,classroom_destination) VALUES ('10306000000000','10025000000000','6057000000000',NULL,NULL);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE classrooms_students';
 -------------------------------------

 BEGIN

    UPDATE public.classrooms_students SET classroom = '1002700000000' WHERE classroom_student = '1024600000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE classrooms_students';
 -------------------------------------

 BEGIN

    DELETE FROM public.classrooms_students WHERE classroom_student = '1024600000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- classrooms

 -------------------------------------
 test_name = 'SELECT classrooms';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.classrooms WHERE classroom = '10062000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT classrooms';
 -------------------------------------
 BEGIN

    INSERT INTO public.classrooms(classroom,school_year,degree,section,course_year,description,branch) VALUES ('1110062000000000','243000000000','9942000000000','C','1','Infanzia 1C','9952000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE classrooms';
 -------------------------------------

 BEGIN

    UPDATE public.classrooms SET description = 'sede non esistente' WHERE classroom = '1110062000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE classrooms';
 -------------------------------------

 BEGIN

    DELETE FROM public.classrooms WHERE classroom = '1110062000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- communication_types

 -------------------------------------
 test_name = 'SELECT communication_types';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.communication_types WHERE communication_type = 138012000000000;
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT communication_types';
 -------------------------------------
 BEGIN

    INSERT INTO communication_types (communication_type, description, notification_management, school) VALUES (11138012000000000,'Skype',FALSE,1000000000);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE communication_types';
 -------------------------------------

 BEGIN

    UPDATE public.communication_types SET description = 'descrizione non esistente' WHERE communication_type = 11138012000000000;
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE communication_types';
 -------------------------------------

 BEGIN

    DELETE FROM public.communication_types WHERE communication_type = 11138012000000000;
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- communications_media


 -------------------------------------
 test_name = 'SELECT communications_media';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.communications_media WHERE communication_media = '1120270000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT communications_media';
 -------------------------------------
 BEGIN

    INSERT INTO public.communications_media(communication_media,person,communication_type,description,uri,notification) VALUES ('11112027000000000','3959000000000','138027000000000','casa','Lara.Lupini@example.org','t');
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'UPDATE communications_media';
 -------------------------------------

 BEGIN

    UPDATE public.communications_media SET description = 'descrizione non esistente' WHERE communication_media = '11112027000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE communications_media';
 -------------------------------------

 BEGIN

    DELETE FROM public.communications_media WHERE communication_media = '11112027000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- conversations

 -------------------------------------
 test_name = 'SELECT conversations';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.conversations WHERE conversation = '3367000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT conversations';
 -------------------------------------
 BEGIN

    INSERT INTO public.conversations(conversation,classroom_student,subject,confidential,begin_on,end_on) VALUES ('1133670000000000','10685000000000','Compiti in classe.','f',NULL,NULL);
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'INSERT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE conversations';
 -------------------------------------

 BEGIN

    UPDATE public.conversations SET subject = 'subject non esistente' WHERE conversation = '1133670000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE conversations';
 -------------------------------------

 BEGIN

    DELETE FROM public.conversations WHERE conversation = '1133670000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'DELETE wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- countries

 -------------------------------------
 test_name = 'SELECT countries';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.countries WHERE country = '201000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT countries';
 -------------------------------------
 BEGIN

  INSERT INTO public.countries(country,description,existing,processing_code) VALUES ('11201000000000','BELGIO (test)','t','1201');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE countries';
 -------------------------------------

 BEGIN

    UPDATE public.countries SET description = 'descrizione non esistente' WHERE country = '11201000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE countries';
 -------------------------------------

 BEGIN

    DELETE FROM public.countries WHERE country = '11201000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- degrees

 -------------------------------------
 test_name = 'SELECT degrees';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.degrees WHERE degree = 994200000000;
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT degrees';
 -------------------------------------
 BEGIN

    INSERT INTO degrees (degree, school, description, course_years) VALUES (119942000000000, 1000000000, 'Scuola dell''infanzia', 3);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE degrees';
 -------------------------------------

 BEGIN

    UPDATE public.degrees SET description = 'sede non esistente' WHERE degree = 119942000000000;
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE degrees';
 -------------------------------------

 BEGIN

    DELETE FROM public.degrees WHERE degree = 119942000000000;
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- delays

 -------------------------------------
 test_name = 'SELECT delays';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.delays WHERE delay = '48854000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT delays';
 -------------------------------------
 BEGIN

	INSERT INTO public.delays(delay,teacher,explanation,on_date,at_time,classroom_student) VALUES ('1148854000000000','32935000000000','47594000000000','2013-09-18','08:16:21','10373000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE delays';
 -------------------------------------

 BEGIN

    UPDATE public.delays SET on_date = '2013-10-17' WHERE delay = '1148854000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE delays';
 -------------------------------------

 BEGIN

    DELETE FROM public.delays WHERE delay = '1148854000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- districts

 -------------------------------------
 test_name = 'SELECT districts';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.districts WHERE district = '75832100000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'INSERT districts';
 -------------------------------------
 BEGIN

	INSERT INTO public.districts(mnemonic,description,region,district) VALUES ('01','Torino (test)','1000000000','11758321000000000');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'UPDATE districts';
 -------------------------------------

 BEGIN

    UPDATE public.districts SET description = 'descrizione non esistente' WHERE district = '11758321000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE districts';
 -------------------------------------

 BEGIN

    DELETE FROM public.districts WHERE district = '11758321000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- explanations

 -------------------------------------
 test_name = 'SELECT explanations';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.explanations WHERE explanation = '47600000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;




 -------------------------------------
 test_name = 'INSERT explanations';
 -------------------------------------
 BEGIN

    INSERT INTO public.explanations(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('1157313000000000','1214000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','3512000000000','2013-10-25 10:44:59','32933000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE explanations';
 -------------------------------------

 BEGIN

    UPDATE public.explanations SET description = 'ritardoo' WHERE explanation = '1157313000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE explanations';
 -------------------------------------

 BEGIN

    DELETE FROM public.explanations WHERE explanation = '1157313000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- faults


 -------------------------------------
 test_name = 'SELECT faults';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.faults WHERE fault = '59632000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'INSERT faults';
 -------------------------------------

 BEGIN

    INSERT INTO public.faults(fault,student,description,lesson,note) VALUES ('159632000000000','1172000000000','ha dimenticato il libro di testo','102279000000000',NULL);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'UPDATE faults';
 -------------------------------------

 BEGIN

    UPDATE public.faults SET description = 'non ha il quaderno' WHERE fault = '159632000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE faults';
 -------------------------------------

 BEGIN

    DELETE FROM public.faults WHERE fault = '159632000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;



-- grade_types

 -------------------------------------
 test_name = 'SELECT grade_types';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.grade_types WHERE grade_type = '46299000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT grade_types';
 -------------------------------------

 BEGIN

    INSERT INTO public.grade_types(grade_type,description,subject,mnemonic) VALUES ('146299000000000','descrizione','29107000000000','D');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE grade_types';
 -------------------------------------

 BEGIN

    UPDATE public.grade_types SET description = 'descrizione' WHERE grade_type = '146299000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE grade_types';
 -------------------------------------

 BEGIN

    DELETE FROM public.grade_types WHERE grade_type = '146299000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;



-- grades

 -------------------------------------
 test_name = 'SELECT grades';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.grades WHERE grade = '29066000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT grades';
 -------------------------------------

 BEGIN

    INSERT INTO public.grades(grade,metric,description,thousandths,mnemonic) VALUES ('129066000000000','29062000000000','Non classificabile','0','N/C');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE grades';
 -------------------------------------

 BEGIN

    UPDATE public.grades SET description = 'descrizione' WHERE grade = '129066000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;

 -------------------------------------
 test_name = 'DELETE grades';
 -------------------------------------

 BEGIN

    DELETE FROM public.grades WHERE grade = '129066000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- grading_meetings_valutations_qua

 -------------------------------------
 test_name = 'SELECT grading_meetings_valutations_qua';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126109000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT grading_meetings_valutations_qua';
 -------------------------------------

 BEGIN

    INSERT INTO public.grading_meetings_valutations_qua(grading_meeting_valutation_qua,grading_meeting_valutation,qualification,grade,notes) VALUES ('126110000000000','124388000000000','95977000000000','11478000000000','Esempio di una nota testuale a commento della valutazione della qualifica');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE grading_meetings_valutations_qua';
 -------------------------------------

 BEGIN

    UPDATE public.grading_meetings_valutations_qua SET notes = 'nota' WHERE grading_meeting_valutation_qua = '126110000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'DELETE grading_meetings_valutations_qua';
 -------------------------------------

 BEGIN

    DELETE FROM public.grading_meetings_valutations_qua WHERE grading_meeting_valutation_qua = '126110000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- grading_meetings_valutations

 -------------------------------------
 test_name = 'SELECT grading_meetings_valutations';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.grading_meetings_valutations WHERE grading_meeting_valutation = '130813000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT grading_meetings_valutations';
 -------------------------------------

 BEGIN

    INSERT INTO public.grading_meetings_valutations(grading_meeting_valutation,grading_meeting,classroom,student,subject,grade,notes,lack_of_training,council_vote,teacher) VALUES ('1130752000000000','119533000000000','10034000000000','1465000000000','32919000000000','11463000000000',NULL,'f','f',NULL);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE grading_meetings_valutations';
 -------------------------------------

 BEGIN

    UPDATE public.grading_meetings_valutations SET lack_of_training = 't' WHERE grading_meeting_valutation = '1130752000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'DELETE grading_meetings_valutations';
 -------------------------------------

 BEGIN

    DELETE FROM public.grading_meetings_valutations WHERE grading_meeting_valutation = '1130752000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- grading_meetings

 -------------------------------------
 test_name = 'SELECT grading_meetings';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.grading_meetings WHERE grading_meeting = '119537000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT grading_meetings';
 -------------------------------------

 BEGIN

    INSERT INTO public.grading_meetings(grading_meeting,school_year,on_date,description,closed) VALUES ('1119537000000000','244000000000','2014-06-15','Scrutinio secondo quadrimestre','f');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE grading_meetings';
 -------------------------------------

 BEGIN

    UPDATE public.grading_meetings SET closed = 't' WHERE grading_meeting = '1119537000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'DELETE grading_meetings';
 -------------------------------------

 BEGIN

    DELETE FROM public.grading_meetings WHERE grading_meeting = '1119537000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- holidays

 -------------------------------------
 test_name = 'SELECT holidays';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.holidays WHERE holiday = '11335000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT holidays';
 -------------------------------------

 BEGIN

    INSERT INTO public.holidays(holiday,school,on_date,description) VALUES ('111335000000000','2000000000','2013-01-03','Capodanno');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE holidays';
 -------------------------------------

 BEGIN

    UPDATE public.holidays SET description = 'descrizione' WHERE holiday = '111335000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE holidays';
 -------------------------------------

 BEGIN

    DELETE FROM public.holidays WHERE holiday = '111335000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- leavings

 -------------------------------------
 test_name = 'SELECT leavings';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.leavings WHERE leaving = '58393000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT leavings';
 -------------------------------------

 BEGIN

    INSERT INTO public.leavings(explanation,student,description,created_on,created_by,registered_on,registered_by,from_time,to_time,coming_at,leaving_at,type) VALUES ('1157313000000000','1214000000000','uscita in anticipo per motivi personali','2013-10-24 10:44:59','3512000000000','2013-10-25 10:44:59','32933000000000','2013-10-24','2013-10-24',NULL,'11:30:30','Leave');
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;



 -------------------------------------
 test_name = 'UPDATE leavings';
 -------------------------------------

 BEGIN

    UPDATE public.leavings SET teacher = '32937000000000' WHERE leaving = '1157313000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;




 -------------------------------------
 test_name = 'DELETE leavings';
 -------------------------------------

 BEGIN

    DELETE FROM public.leavings WHERE leaving = '1157313000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN 
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;


-- lessons


 -------------------------------------
 test_name = 'SELECT lessons';
 -------------------------------------

 BEGIN

    PERFORM 1 from public.lessons WHERE lesson = '98581000000000';
    _results = _results || assert.pass(full_function_name, test_name);
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.fail(full_function_name, test_name,'SELECT wasn''t OK but the student should be able to', NULL::diagnostic.error);

    RETURN;
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'INSERT lessons';
 -------------------------------------
 BEGIN

    INSERT INTO public.lessons(lesson,classroom,on_date,subject,teacher,description,substitute,from_time,to_time,assignment,period) VALUES ('1198581000000000','10033000000000','2013-09-16','32911000000000','32925000000000','descrizione di esempio della lezione tenuta','t','08:00:00','09:00:00',NULL,NULL);
    _results = _results || assert.fail(full_function_name, test_name,'INSERT was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'UPDATE lessons';
 -------------------------------------

 BEGIN

    UPDATE public.lessons SET description = 'descrizione non esistente' WHERE lesson = '1198581000000000';
    _results = _results || assert.fail(full_function_name, test_name,'UPDATE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;
    
END;


 -------------------------------------
 test_name = 'DELETE lessons';
 -------------------------------------

 BEGIN

    DELETE FROM public.lessons WHERE lesson = '1198581000000000';
    _results = _results || assert.fail(full_function_name, test_name,'DELETE was OK but the student shouldn''t be able to', NULL::diagnostic.error);

    RETURN;
 EXCEPTION WHEN SQLSTATE '42501' THEN
    _results = _results || assert.pass(full_function_name, test_name);
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);

        RETURN;

    
END;




END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.vertical_security(boolean, text)
  OWNER TO "jiahaodong@gmail.com";
