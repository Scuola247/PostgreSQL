ALTER TABLE public.degrees
  ADD CONSTRAINT degrees_ck_description CHECK (length(btrim(description::text)) > 0);
