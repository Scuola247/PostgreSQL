-- script pgbench

BEGIN;
  SELECT * FROM persons; 
  SELECT * FROM absences; 
END;
