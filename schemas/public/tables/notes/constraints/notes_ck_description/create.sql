ALTER TABLE public.notes
  ADD CONSTRAINT notes_ck_description CHECK (length(btrim(description::text)) > 0);
