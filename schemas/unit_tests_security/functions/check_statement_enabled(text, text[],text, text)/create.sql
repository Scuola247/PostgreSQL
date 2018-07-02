﻿-- Function: unit_tests_security.check_statement_enabled(text, text, text[], text)

-- DROP FUNCTION unit_tests_security.check_statement_enabled(text, text, text[], text);

CREATE OR REPLACE FUNCTION unit_tests_security.check_statement_enabled(
    IN _usename text,
    IN _group text,
    IN _groups_enabled text[],
    IN _sql text,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name   	text;
  test_name	        text = '';
  error			diagnostic.error;
  command 		text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  -----------------------------------------------------------------------------------------------------------------------------------
  test_name = format('Check Statement for user: %s, group:%s, groups enabled: %s, sql: %s', _usename, _group, _groups_enabled, _sql);
  -----------------------------------------------------------------------------------------------------------------------------------

  BEGIN

    command = format('SET ROLE %I;',_usename);
    
    EXECUTE command;
    EXECUTE _sql;

    IF (_group = ANY(_groups_enabled)) THEN
	      _results = _results || assert.pass(full_function_name, test_name);
    ELSE
        _results = _results || assert.fail(full_function_name, test_name,format('Command OK but the group %s shouldn''t be able to SQL: %s', _group, _sql), NULL::diagnostic.error);
        RESET ROLE;
	RETURN;
    END IF;

  EXCEPTION WHEN SQLSTATE '42501' THEN
  
     IF (_group = ANY(_groups_enabled)) THEN
        _results = _results || assert.fail(full_function_name, test_name,format('Command OK but the group %s shouldn''t be able to SQL: %s', _group, _sql), NULL::diagnostic.error);
        RESET ROLE;
	RETURN;
    ELSE
	_results = _results || assert.pass(full_function_name, test_name);
    END IF;
    
    WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'Unexpected exception', error);
        RESET ROLE;
        RETURN;

  RESET ROLE;
  END;
  
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_security.check_statement_enabled(text, text, text[], text)
  OWNER TO "aimenhammou@gmail.com";
GRANT EXECUTE ON FUNCTION unit_tests_security.check_statement_enabled(text, text, text[], text) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_statement_enabled(text, text, text[], text) TO "aimenhammou@gmail.com";
GRANT EXECUTE ON FUNCTION unit_tests_security.check_statement_enabled(text, text, text[], text) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_security.check_statement_enabled(text, text, text[], text) TO scuola247_user;
