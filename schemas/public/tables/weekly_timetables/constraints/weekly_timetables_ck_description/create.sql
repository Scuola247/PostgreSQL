ALTER TABLE public.weekly_timetables
  ADD CONSTRAINT weekly_timetables_description CHECK (length(btrim(description::text)) > 0);
