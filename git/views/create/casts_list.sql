-- View: git.casts_list

-- DROP VIEW git.casts_list;

CREATE OR REPLACE VIEW git.casts_list AS 
 SELECT format_type(st.oid, NULL::integer) AS source,
    format_type(tt.oid, NULL::integer) AS target,
        CASE np.nspname
            WHEN 'public'::name THEN pr.proname::text
            WHEN 'pg_catalog'::name THEN pr.proname::text
            ELSE (np.nspname::text || '.'::text) || pr.proname::text
        END AS procedure_name,
    ca.castcontext,
    ca.castmethod,
    des.description
   FROM pg_cast ca
     JOIN pg_type st ON st.oid = ca.castsource
     JOIN pg_namespace ns ON ns.oid = st.typnamespace
     JOIN pg_type tt ON tt.oid = ca.casttarget
     JOIN pg_namespace nt ON nt.oid = tt.typnamespace
     LEFT JOIN pg_proc pr ON pr.oid = ca.castfunc
     LEFT JOIN pg_namespace np ON np.oid = pr.pronamespace
     LEFT JOIN pg_description des ON des.objoid = ca.oid AND des.objsubid = 0 AND des.classoid = 'pg_cast'::regclass::oid
  WHERE ns.nspname <> 'pg_catalog'::name OR nt.nspname <> 'pg_catalog'::name;

ALTER TABLE git.casts_list
  OWNER TO postgres;

