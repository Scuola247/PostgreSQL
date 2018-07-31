-- Function: scuola247.tr_grading_meetings_valutations_d()

-- DROP FUNCTION scuola247.tr_grading_meetings_valutations_d();

CREATE OR REPLACE FUNCTION scuola247.tr_grading_meetings_valutations_d()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The poll is closed')::utility.system_message,
    ('en', 2, 'The ''grading_meeting_valutation'': ''%s'' refer to the ''grading_meeting'': ''%s''  that it is closed ')::utility.system_message,
    ('en', 3, 'To correct the value of ''grading_meeting '' and to propose the operation')::utility.system_message,
    ('it', 1, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 2, 'La ''scrutinio_valutazione'': ''%s'' fa riferimento allo ''scrutinio'': ''%s'' che è chiuso')::utility.system_message,
    ('it', 3, 'Correggere il valore di ''scrutinio '' e riproporre l''operazione')::utility.system_message];	
BEGIN 
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the grading_meeting is open
--
  PERFORM 1 FROM scuola247.grading_meetings 
    WHERE grading_meeting = old.grading_meeting
      AND closed = false;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), old.grading_meeting_valutation, old.grading_meeting),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN OLD;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION scuola247.tr_grading_meetings_valutations_d()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION scuola247.tr_grading_meetings_valutations_d() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION scuola247.tr_grading_meetings_valutations_d() TO scuola247_user;
REVOKE ALL ON FUNCTION scuola247.tr_grading_meetings_valutations_d() FROM public;
