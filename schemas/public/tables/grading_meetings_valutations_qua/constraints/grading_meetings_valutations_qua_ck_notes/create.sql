ALTER TABLE public.grading_meetings_valutations_qua
  ADD CONSTRAINT grading_meetings_valutations_qua_ck_notes CHECK (length(btrim(notes::text)) > 0);
