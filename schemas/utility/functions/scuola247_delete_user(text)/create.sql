-- Function: special.scuola247_delete_user(text)

-- DROP FUNCTION special.scuola247_delete_user(text);

CREATE OR REPLACE FUNCTION utility.generate_password(IN _password_length integer DEFAULT 12,  
                                                     IN _upper_case_mandatory boolean DEFAULT FALSE,
                                                     IN _lower_case_mandatory boolean DEFAULT FALSE,
                                                     IN _numeric_mandatory boolean DEFAULT FALSE,
                                                     IN _special_char_mandatory boolean DEFAULT FALSE,
                                                     OUT _password text)
  RETURNS text AS
$BODY$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;

  x int4;
  -- 0,O,1,I,i,|,,,.,:,; sono stati tolti per non generare possibili equivoci
  -- |,_[,],{,},§,°,ç sono stati tolti perchè difficili da trovare sulla tastiera 
  allowed text = '23456789abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ&$#%@-+/\()';
  allowed_len int4 = length(allowed);
BEGIN
-- per intanto l'unico parametro implementato è la lunghezza della password

--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _password = '';
  
  WHILE length(_password) < _password_length LOOP
    me.x := int4(random() * allowed_len);
    _password = _password || substr(allowed, me.x+1, 1);
  END LOOP;

RETURN;
END
$BODY$
  LANGUAGE plpgsql VOLATILE 
  COST 100;
ALTER FUNCTION special.scuola247_delete_user(text)
  OWNER TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO public;
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO scuola247_supervisor;
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO scuola247_executive;
GRANT EXECUTE ON FUNCTION special.scuola247_delete_user(text) TO scuola247_employee;
