ALTER TABLE public.grading_meetings
  ADD CONSTRAINT grading_meetings_ck_description CHECK (length(btrim(description::text)) > 0);
