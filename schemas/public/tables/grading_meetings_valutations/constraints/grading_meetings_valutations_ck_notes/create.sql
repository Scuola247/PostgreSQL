ALTER TABLE public.grading_meetings_valutations
  ADD CONSTRAINT grading_meetings_valutations_ck_notes CHECK (length(btrim(notes::text)) > 0);
