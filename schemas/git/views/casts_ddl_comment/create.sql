-- View: git.casts_ddl_comment

-- DROP VIEW git.casts_ddl_comment;

CREATE OR REPLACE VIEW git.casts_ddl_comment AS 
 SELECT format('%s AS %s'::text, casts_list.source, casts_list.target) AS cast_name,
    format('COMMENT ON CAST (%s AS %s) IS %L;'::text, casts_list.source, casts_list.target, casts_list.description) AS cast_ddl_comment
   FROM git.casts_list
  WHERE casts_list.description IS NOT NULL;


