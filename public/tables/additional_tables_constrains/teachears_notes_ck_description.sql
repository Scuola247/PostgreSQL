-- Check: public.teachears_notes_ck_description

-- ALTER TABLE public.teachears_notes DROP CONSTRAINT teachears_notes_ck_description;

ALTER TABLE public.teachears_notes
  ADD CONSTRAINT teachears_notes_ck_description CHECK (length(btrim(description::text)) > 0);
