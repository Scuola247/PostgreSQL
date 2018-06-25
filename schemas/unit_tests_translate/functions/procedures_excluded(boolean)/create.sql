-- Function: unit_tests_translate.procedures_excluded(boolean)

-- DROP FUNCTION unit_tests_translate.procedures_excluded(boolean);

CREATE OR REPLACE FUNCTION unit_tests_translate.procedures_excluded(
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
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;  
  -----------------------------
  test_name = 'INSERT procedures_excluded';
  -----------------------------
  BEGIN
    INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('1000000000','gbt_bytea_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('2000000000','connectby');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('3000000000','gbt_numeric_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('4000000000','gbtreekey32_out');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('5000000000','gbt_float8_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('6000000000','gbt_bit_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('8000000000','pldbg_attach_to_port');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('10000000000','gbt_macad_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('13000000000','gbt_var_decompress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('14000000000','gbt_cash_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('15000000000','gbt_int4_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('16000000000','pldbg_set_breakpoint');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('17000000000','__plpgsql_check_function_tb');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('19000000000','plpgsql_check_function');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('20000000000','gbt_oid_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('21000000000','gbt_numeric_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('24000000000','gbt_int8_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('27000000000','gbt_date_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('28000000000','gbt_float4_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('29000000000','gbt_macad_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('30000000000','gbt_cash_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('31000000000','float4_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('33000000000','gbt_float4_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('34000000000','gbt_intv_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('35000000000','gbt_bytea_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('36000000000','http_delete');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('37000000000','gbt_oid_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('38000000000','gbt_cash_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('40000000000','gbt_macad_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('41000000000','gbt_date_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('42000000000','http_put');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('43000000000','pldbg_set_global_breakpoint');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('45000000000','gbt_macad_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('46000000000','gbtreekey16_in');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('47000000000','pldbg_continue');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('48000000000','gbt_int8_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('49000000000','gbt_timetz_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('50000000000','gbt_float8_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('51000000000','gbt_bit_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('53000000000','gbt_date_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('54000000000','gbt_text_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('58000000000','plpgsql_oid_debug');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('59000000000','__plpgsql_check_function');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('60000000000','gbt_numeric_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('64000000000','pldbg_step_over');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('65000000000','http_header');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('68000000000','gbt_var_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('69000000000','gbt_intv_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('70000000000','gbt_timetz_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('72000000000','gbt_int2_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('73000000000','gbt_tstz_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('74000000000','gbt_date_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('75000000000','gbtreekey8_in');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('76000000000','gbt_cash_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('78000000000','gbt_oid_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('80000000000','gbt_cash_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('82000000000','int8_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('83000000000','gbt_oid_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('84000000000','http_post');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('85000000000','gbt_tstz_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('86000000000','pldbg_drop_breakpoint');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('87000000000','gbt_float4_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('88000000000','http_get');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('90000000000','float8_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('91000000000','gbt_bytea_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('92000000000','gbt_text_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('95000000000','gbt_int4_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('96000000000','gbt_date_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('97000000000','gbt_intv_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('99000000000','gbt_tstz_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('100000000000','pldbg_oid_debug');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('101000000000','gbt_float4_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('102000000000','gbt_float8_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('104000000000','gbt_int8_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('105000000000','gbt_decompress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('106000000000','gbt_text_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('107000000000','pldbg_step_into');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('108000000000','pldbg_create_listener');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('109000000000','gbt_float4_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('110000000000','gbt_int4_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('111000000000','gbt_bytea_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('112000000000','gbt_ts_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('113000000000','gbt_float8_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('114000000000','gbt_time_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('116000000000','gbt_int2_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('117000000000','gbt_bytea_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('118000000000','pldbg_select_frame');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('119000000000','gbt_ts_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('120000000000','gbt_inet_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('123000000000','gbt_macad_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('124000000000','gbt_numeric_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('126000000000','gbt_time_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('127000000000','gbt_intv_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('130000000000','pldbg_get_source');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('131000000000','gbt_int2_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('132000000000','gbt_text_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('135000000000','gbt_float8_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('139000000000','gbt_int8_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('140000000000','pldbg_get_stack');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('141000000000','gbt_int8_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('142000000000','gbt_intv_decompress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('143000000000','oid_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('144000000000','gbt_intv_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('145000000000','gbt_intv_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('146000000000','gbt_float4_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('147000000000','gbt_ts_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('148000000000','gbt_int2_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('150000000000','gbt_time_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('151000000000','gbt_ts_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('154000000000','gbt_date_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('155000000000','gbtreekey4_in');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('156000000000','gbt_int8_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('158000000000','gbtreekey_var_out');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('159000000000','gbt_float4_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('160000000000','gbtreekey4_out');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('161000000000','gbt_bit_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('162000000000','pldbg_get_variables');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('163000000000','gbt_int4_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('164000000000','gbt_float8_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('167000000000','gbt_bit_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('169000000000','gbt_float8_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('170000000000','gbt_cash_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('171000000000','gbt_bit_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('172000000000','gbt_time_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('173000000000','gbt_inet_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('174000000000','gbt_cash_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('175000000000','http_head');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('176000000000','gbt_int8_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('177000000000','gbt_ts_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('178000000000','gbt_time_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('179000000000','gbt_text_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('180000000000','gbt_inet_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('181000000000','gbt_oid_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('182000000000','gbt_int2_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('183000000000','gbt_time_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('184000000000','plpgsql_check_function_tb');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('185000000000','gbt_int4_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('186000000000','crosstab4');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('188000000000','gbt_ts_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('189000000000','gbt_int8_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('191000000000','gbt_time_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('192000000000','http');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('193000000000','gbt_ts_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('194000000000','pldbg_abort_target');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('195000000000','pldbg_get_target_info');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('196000000000','gbtreekey16_out');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('197000000000','gbt_int2_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('198000000000','pldbg_wait_for_target');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('200000000000','int2_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('202000000000','gbt_cash_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('203000000000','gbt_ts_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('204000000000','pldbg_wait_for_breakpoint');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('206000000000','gbt_text_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('207000000000','gbt_inet_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('208000000000','gbt_bytea_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('210000000000','gbt_oid_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('215000000000','gbt_oid_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('216000000000','gbt_intv_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('217000000000','gbt_bpchar_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('218000000000','pldbg_deposit_value');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('220000000000','gbtreekey32_in');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('221000000000','gbt_oid_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('222000000000','gbt_int2_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('224000000000','gbt_time_fetch');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('225000000000','gbt_inet_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('226000000000','ts_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('227000000000','gbt_bit_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('229000000000','gbt_int2_picksplit');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('230000000000','gbt_float8_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('231000000000','pldbg_get_proxy_info');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('233000000000','gbt_numeric_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('234000000000','gbtreekey_var_in');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('235000000000','gbt_bpchar_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('236000000000','pldbg_get_breakpoints');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('238000000000','gbt_inet_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('239000000000','gbt_int4_same');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('240000000000','date_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('241000000000','gbt_macad_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('243000000000','gbt_date_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('244000000000','gbt_intv_penalty');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('247000000000','gbt_macad_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('249000000000','gbt_int4_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('250000000000','gbt_date_union');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('252000000000','gbt_float4_consistent');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('253000000000','gbt_numeric_compress');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('255000000000','gbtreekey8_out');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('257000000000','time_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('258000000000','int4_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('259000000000','gbt_int4_distance');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('261000000000','normal_rand');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('262000000000','cash_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('263000000000','crosstab');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('264000000000','crosstab3');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('265000000000','interval_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('266000000000','tstz_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('267000000000','tstz_dist');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('268000000000','crosstab2');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('269000000000','urlencode');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('7000000000','http_set_curlopt');
INSERT INTO translate.procedures_excluded(procedure_excluded,name) VALUES ('9000000000','http_reset_curlopt');


    _results =  _results || assert.pass(full_function_name, test_name);

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.procedures_excluded FAILED'::text, error);   
        RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_translate.procedures_excluded(boolean)
  OWNER TO postgres;
