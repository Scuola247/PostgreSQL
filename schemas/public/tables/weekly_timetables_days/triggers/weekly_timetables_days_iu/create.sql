-- Trigger: weekly_timetables_days_iu on public.weekly_timetables_days

-- DROP TRIGGER weekly_timetables_days_iu ON public.weekly_timetables_days;

CREATE TRIGGER weekly_timetables_days_iu
  BEFORE INSERT OR UPDATE
  ON public.weekly_timetables_days
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_weekly_timetables_days_iu();
