ALTER TABLE public.holidays
  ADD CONSTRAINT holidays_ck_description CHECK (length(btrim(description::text)) > 0);
