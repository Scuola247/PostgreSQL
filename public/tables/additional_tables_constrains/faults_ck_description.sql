-- Check: public.faults_ck_description

-- ALTER TABLE public.faults DROP CONSTRAINT faults_ck_description;

ALTER TABLE public.faults
  ADD CONSTRAINT faults_ck_description CHECK (length(btrim(description::text)) > 0);
