-- Check: public.cities_ck_fiscal_code

-- ALTER TABLE public.cities DROP CONSTRAINT cities_ck_fiscal_code;

ALTER TABLE public.cities
  ADD CONSTRAINT cities_ck_fiscal_code CHECK (length(btrim(fiscal_code::text)) > 0);
