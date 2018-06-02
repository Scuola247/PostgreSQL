CREATE TRIGGER absences_iu
  AFTER INSERT OR UPDATE
  ON public.absences
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_absences_iu();

