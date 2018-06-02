-- Function: public.tr_grading_meetings_valutations_qua_d()

-- DROP FUNCTION public.tr_grading_meetings_valutations_qua_d();

CREATE OR REPLACE FUNCTION public.tr_grading_meetings_valutations_qua_d()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages    utility.system_message[] = ARRAY [
    ('en', 1, 'The ''grading_meeting_valutation_qua'': ''%s'' refer to the ''grading_meeting_valutation'': ''%s'' that makes reference to a closed poll')::utility.system_message,
    ('en', 2, 'The poll is closed')::utility.system_message,
    ('en', 3, 'Check the value of the: ''grading_meeting'' of the ''grading_meeting_valutation'' and repeat the operation')::utility.system_message,
    ('it', 1, 'La ''scrutinio_valutazione_qualifica'': ''%s fa'' riferimento allo ''scrutinio_valutazione'': ''%s'' che fà riferimento ad uno scrutinio chiuso')::utility.system_message,
    ('it', 2, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 3, 'Correggere il valore di ''scrutinio'' dello ''scrutinio_valutazione'' e riproporre l''operazione')::utility.system_message];
BEGIN 
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the grading_meeting is open
--
  PERFORM 1 FROM grading_meetings_valutations sv
     JOIN grading_meetings s ON s.grading_meeting = sv.grading_meeting
    WHERE sv.grading_meeting_valutation = old.grading_meeting_valutation
      AND s.closed = false;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), old.grading_meeting_valutation_qua, old.grading_meeting_valutation),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN OLD;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.tr_grading_meetings_valutations_qua_d()
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_qua_d() TO postgres;
GRANT EXECUTE ON FUNCTION public.tr_grading_meetings_valutations_qua_d() TO scuola247_relative;
REVOKE ALL ON FUNCTION public.tr_grading_meetings_valutations_qua_d() FROM public;
