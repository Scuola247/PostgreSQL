-- Check: public.persons_ck_city_of_birth_fiscal_code

-- ALTER TABLE public.persons DROP CONSTRAINT persons_ck_city_of_birth_fiscal_code;

ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_city_of_birth_fiscal_code CHECK (length(btrim(city_of_birth_fiscal_code::text)) > 0);
