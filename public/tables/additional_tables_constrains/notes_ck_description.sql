-- Check: public.notes_ck_description

-- ALTER TABLE public.notes DROP CONSTRAINT notes_ck_description;

ALTER TABLE public.notes
  ADD CONSTRAINT notes_ck_description CHECK (length(btrim(description::text)) > 0);
