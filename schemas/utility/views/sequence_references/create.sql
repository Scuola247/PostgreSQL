-- View: utility.sequence_references

-- DROP VIEW utility.sequence_references;

CREATE OR REPLACE VIEW utility.sequence_references AS 
 SELECT sns.nspname AS sequence_schema_name,
    s.relname AS sequence_name,
    tns.nspname AS reference_schema_name,
    t.relname AS reference_table_name,
    a.attname AS reference_column_name,
    utility.get_max_column_value(tns.nspname::text, t.relname::text, a.attname::text) AS max_value
   FROM pg_class s
     JOIN pg_namespace sns ON sns.oid = s.relnamespace
     JOIN pg_depend d ON d.refobjid = s.oid
     JOIN pg_attrdef ad ON ad.oid = d.objid
     JOIN pg_class t ON t.oid = ad.adrelid
     JOIN pg_attribute a ON a.attrelid = ad.adrelid AND a.attnum = ad.adnum
     JOIN pg_namespace tns ON tns.oid = t.relnamespace
  WHERE sns.nspname <> 'pgagent'::name AND s.relkind = 'S'::"char";

ALTER TABLE utility.sequence_references
  OWNER TO scuola247_supervisor;
COMMENT ON VIEW utility.sequence_references
  IS 'List tables and columns where sequences are refererred and his max value';
