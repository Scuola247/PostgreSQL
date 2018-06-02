-- Check: public.grading_meetings_ck_description

-- ALTER TABLE public.grading_meetings DROP CONSTRAINT grading_meetings_ck_description;

ALTER TABLE public.grading_meetings
  ADD CONSTRAINT grading_meetings_ck_description CHECK (length(btrim(description::text)) > 0);
