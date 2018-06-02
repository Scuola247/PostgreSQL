ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_note CHECK (length(btrim(note)) > 0);
