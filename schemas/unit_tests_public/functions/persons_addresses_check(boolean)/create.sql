-- Function: unit_tests_public.persons_addresses_check(boolean)

-- DROP FUNCTION unit_tests_public.persons_addresses_check(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public.persons_addresses_check(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE
  context               text;
  full_function_name 	  text;
  test_name		          text = '';
  error			            diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public._after_data_insert');
    RETURN;
  END IF;

  --------------------------------
  test_name = 'duplicate address';
  --------------------------------
  BEGIN
     INSERT INTO scuola247.persons_addresses(person_address,person,address_type,street,zip_code,city_fiscal_code,city) VALUES ('116765000000000','3326000000000','Residence','Via G. Segantini 91','37069','L949','761559000000000');
    _results = _results || assert.fail(full_function_name, test_name, 'Insert was OK but duplicate address was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23505','persons_addresses_uq_indirizzo');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  -------------------------------
  test_name = 'person mandatory';
  -------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET person = NULL WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but person required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  -------------------------------------
  test_name = 'address_type mandatory';
  -------------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET address_type = NULL WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but address_type required was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  -------------------------------
  test_name = 'street mandatory';
  -------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET street = NULL WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but street required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  ---------------------------------
  test_name = 'zip_code mandatory';
  ---------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET zip_code = NULL WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but zip_code required was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;
  -----------------------------------------
  test_name = 'city_fiscal_code mandatory';
  -----------------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET city_fiscal_code = NULL WHERE person_address = '16765000000000';
    _results = _results || assert.fail(full_function_name, test_name, 'Update was OK but city required was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_equals(me.full_function_name, me.test_name, me.error, '23502');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  -----------------------------------
  test_name = 'street''s min length';
  -----------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET street = '  ' WHERE person_address = '16765000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty street was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514','persons_addresses_ck_street');
		IF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;  END;

  ---------------------------------------------
  test_name = 'city_fiscal_code''s min lenght';
  ---------------------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET city_fiscal_code = '  ' WHERE person_address = '16765000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty city_fiscal_code was expected', NULL::diagnostic.error);
    RETURN;
    EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514','persons_addresses_ck_city');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  -------------------------------------
  test_name = 'zip_code''s min lenght';
  -------------------------------------
  BEGIN
    UPDATE scuola247. persons_addresses SET zip_code = '  ' WHERE person_address = '16765000000000';
    _results = _results ||  assert.fail(full_function_name, test_name, 'Update was OK but empty zip_code was expected', NULL::diagnostic.error);
    RETURN;
     EXCEPTION WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     _results = _results || assert.sqlstate_constraint_equals(me.full_function_name, me.test_name, me.error, '23514','persons_addresses_ck_zip_code');
     IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;
  END;

  RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public.persons_addresses_check(boolean)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION unit_tests_public.persons_addresses_check(boolean) TO public;
GRANT EXECUTE ON FUNCTION unit_tests_public.persons_addresses_check(boolean) TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION unit_tests_public.persons_addresses_check(boolean) TO scuola247_user;
