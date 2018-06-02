ALTER TABLE public.school_years
  ADD CONSTRAINT school_years_ck_description CHECK (length(btrim(description::text)) > 0);
