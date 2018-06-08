-- Check: public.districts_ck_district

-- ALTER TABLE public.districts DROP CONSTRAINT districts_ck_district;

ALTER TABLE public.districts
  ADD CONSTRAINT districts_ck_mnemonic CHECK (length(btrim(mnemonic::text)) > 0);
