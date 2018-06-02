ALTER TABLE public.teachears_notes
  ADD CONSTRAINT teachears_notes_ck_description CHECK (length(btrim(description::text)) > 0);
