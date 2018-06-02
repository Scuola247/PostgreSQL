ALTER TABLE public.valutations_qualifications
  ADD CONSTRAINT valutations_qualifications_ck_note CHECK (length(btrim(note::text)) > 0);
