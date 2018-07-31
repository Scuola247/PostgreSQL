-- Function: scuola247.tr_communications_media_iu()

-- DROP FUNCTION scuola247.tr_communications_media_iu();

CREATE OR REPLACE FUNCTION scuola247.tr_communications_media_iu()
  RETURNS trigger AS
$BODY$
<<me>>
DECLARE
  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'Is impossible request the notification if the communications mean doesn''t handle it')::utility.system_message,
    ('en', 2, 'Is impossibile to upgrade to ''TRUE'' the ''notification'' of ''communication_media'': %L about the table ''communications_medias'' ')::utility.system_message,
    ('en', 3, 'For ''type_communication'' indicated the unique value permissible for the column ''notification'' is ''FALSE'',refresh the value or change ''type_communication'' and repeat the operation. ')::utility.system_message,
    ('en', 4, 'Is impossible to insert a ''communication_media'' about the table ''communications_medias'' with the column ''notifications'' set to ''TRUE'' if the ''communications_media'' indicated: %L of the table ''communications_media'' doesn''t runs the notifications (column ''notifications_gesture'' = ''FALSE'')')::utility.system_message,
    ('en', 5, 'The ''school'' of ''person'' isn''t the same of the ''communication_type''')::utility.system_message,
    ('en', 6, 'The ''comunication_type'': %L of ''communication_media'' %L hasn''t the same ''school'' of the ''person'': %L.')::utility.system_message,
    ('en', 7, 'Change the code either for the ''communication_type'' or ''person'' and resubmit the operation')::utility.system_message,
    ('en', 8, 'The ''communication_media'' %L hasn''t the same ''school'' of the ''person'': %L.')::utility.system_message,
    ('it', 1, 'Non è possibile richiedere la notifica se il tipo di comunicazione non la gestisce')::utility.system_message,
    ('it', 2, 'Non è possibile aggiornare a ''TRUE'' la ''notifica'' del ''mezzo_di_comunicazione'': %L della tabella ''mezzi_comunicazione'' perchè il ''tipo_comunicazione'': %L della tabella ''tipi_comunicazione'' non lo gestisce (colonna ''gestione_notifica'' = ''FALSE''٩.')::utility.system_message,
    ('it', 3, 'Per il ''tipo_comunicazione'' indicato l''unico valore ammisibile per la colonna ''notifica'' è ''FALSE'' aggiornare il dato o cambiare ''tipo_comunicazione'' e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Non è possibile inserire un ''mezzo_comunicazione'' della tabella ''mezzi_comunicazione'' con la colonna ''notifica'' impostata a ''TRUE'' se il ''mezzo_di_comunicazione'' indicato: %L della tabella ''mezzi_comunicazione'' non gestisce la notifica (colonna ''gestione_notifica'' = ''FALSE'')')::utility.system_message,	
    ('it', 5, 'La ''school'' della ''person'' non è lo stesso del ''coomunication_type''')::utility.system_message,
    ('it', 6, 'Il ''comunication_type'': %L del ''communication_media'' %L non ha lo stesso ''school'' della ''person'': %L.')::utility.system_message,
    ('it', 7, 'Cambiare il codice per il dato ''communication_type'' o ''person'' e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Il ''communication_media'' %L non ha lo stesso ''school'' della ''person'': %L.')::utility.system_message];	
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- if requested the notification check that communication_media manages it 
--
  IF new.notification = TRUE THEN
  
    PERFORM 1 
       FROM scuola247.communication_types 
      WHERE communication_type = new.communication_type 
        AND notification_management = TRUE;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.communication_media, new.communication_type),
          HINT = utility.system_messages_locale(system_messages,3);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,4), new.communication_type),
          HINT = utility.system_messages_locale(system_messages,3);
      END IF;	   
    END IF;
  END IF;
--
-- Check that the school of communication_type is equal to that of the person
--
  PERFORM 1 
     FROM scuola247.communication_types ct
     JOIN scuola247.persons p ON p.school = ct.school
    WHERE ct.communication_type = new.communication_type
      AND p.person = new.person;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.communication_media, new.communication_type, new.person),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.communication_type, new.person),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;	   
  END IF;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION scuola247.tr_communications_media_iu()
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION scuola247.tr_communications_media_iu() TO scuola247_supervisor WITH GRANT OPTION;
GRANT EXECUTE ON FUNCTION scuola247.tr_communications_media_iu() TO scuola247_user;
REVOKE ALL ON FUNCTION scuola247.tr_communications_media_iu() FROM public;
