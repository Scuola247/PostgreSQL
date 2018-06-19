COPY (SELECT * FROM public.usenames_schools) TO '/tmp/usenames_schoosl.csv' WITH CSV;
COPY public.usenames_schools FROM '/tmp/usenames_schoosl.csv'  WITH CSV;
COPY (SELECT usename FROM pg_user) TO '/tmp/usenames.csv';
VACUUM FULL VERBOSE ANALYZE absences