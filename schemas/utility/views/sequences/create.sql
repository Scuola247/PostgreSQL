-- View: utility.sequences

-- DROP VIEW utility.sequences;

CREATE OR REPLACE VIEW utility.sequences AS 
 SELECT sequences.sequence_schema::text AS schema_name,
    sequences.sequence_name::text AS object_name
   FROM information_schema.sequences;

ALTER TABLE utility.sequences
  OWNER TO scuola247_supervisor;
GRANT ALL ON TABLE utility.sequences TO scuola247_supervisor;
COMMENT ON VIEW utility.sequences
  IS 'List all sequences';
