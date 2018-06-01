-- View: git.casts_ddl_create

-- DROP VIEW git.casts_ddl_create;

CREATE OR REPLACE VIEW git.casts_ddl_create AS 
 SELECT format('%s AS %s'::text, casts_list.source, casts_list.target) AS cast_name,
    (format('CREATE CAST (%s AS %s)'::text, casts_list.source, casts_list.target) ||
        CASE casts_list.castmethod
            WHEN 'b'::"char" THEN ' WITHOUT FUNCTION'::text
            WHEN 'i'::"char" THEN ' WITH INOUT'::text
            ELSE format(' WITH FUNCTION %s(%s)'::text, casts_list.procedure_name, casts_list.source)
        END) ||
        CASE casts_list.castcontext
            WHEN 'a'::"char" THEN ' AS ASSIGNMENT'::text
            WHEN 'i'::"char" THEN ' AS IMPLICIT'::text
            ELSE NULL::text
        END AS cast_ddl_create
   FROM git.casts_list;

ALTER TABLE git.casts_ddl_create
  OWNER TO postgres;

