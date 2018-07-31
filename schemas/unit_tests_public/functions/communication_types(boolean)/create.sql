-- Function: unit_tests_public.communication_types(boolean)

-- DROP FUNCTION unit_tests_public.communication_types(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.communication_types(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE 
  context               text;
  full_function_name 	text;
  test_name		text = '';
  error			diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.schools');
    RETURN;
  END IF;  
  ---------------------------------------------------
  test_name = 'INSERT scuola247.communication_types';
  ---------------------------------------------------
  BEGIN
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138012000000000,'Skype',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138013000000000,'MSN messenger',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138014000000000,'Yahoo! messenger',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138015000000000,'Google talk',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138016000000000,'email',TRUE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138017000000000,'SMS',TRUE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138018000000000,'Telefono fisso',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138019000000000,'Cellulare',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138020000000000,'WhatsApp',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138021000000000,'Facebook',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138022000000000,'Viber',FALSE,1000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138023000000000,'Skype',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138024000000000,'MSN messenger',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138025000000000,'Yahoo! messenger',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138026000000000,'Google talk',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138027000000000,'email',TRUE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138028000000000,'SMS',TRUE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138029000000000,'Telefono fisso',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138030000000000,'Cellulare',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138031000000000,'WhatsApp',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138032000000000,'Facebook',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138033000000000,'Viber',FALSE,2000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138034000000000,'Skype',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138035000000000,'MSN messenger',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138036000000000,'Yahoo! messenger',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138037000000000,'Google talk',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138038000000000,'email',TRUE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138039000000000,'SMS',TRUE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138040000000000,'Telefono fisso',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138041000000000,'Cellulare',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138042000000000,'WhatsApp',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138043000000000,'Facebook',FALSE,28961000000000);
    INSERT INTO scuola247.communication_types (communication_type, description, notification_management, school) VALUES (138044000000000,'Viber',FALSE,28961000000000);
 
    _results = _results || assert.pass(full_function_name, test_name);
 
    EXCEPTION
       WHEN OTHERS THEN 
         GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
         _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.communication_types FAILED'::text, error);   
       RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.communication_types(boolean)
  OWNER TO postgres;
