In scuola247 abbiamo creato un framework per lo unit test.
Il framework può essere usato con qualsiasi db: non è stato fatto esclusivamente per scuola247.
Il framework si compone esclusivamente di ogetti postgresql ed è installato tramite uno script sql.
Ogni test effettuato con Scuola247/unit_testing viene definito check_point.
I checkpoint vengono raggruppati (e codificati) in funzioni postgresql dette funzioni di unit_test.
le funzioni di unit_test sono riconoscibili perchè hanno in input un boolean e ritornano un array di un tipo dati ben preciso: unit_testing.unit_test_result.
Ogni funzione può dichiarare quale altre funzioni debbano essere eseguite prima di quella in oggetto.
Le funzioni possono essere eseguite tutte, oppure singolarmente o ancora selezionate in set.
L'esecuzione delle funzioni di unit_test viene gestita dal comando unit_testing.run();
Ogni esecuzioni del comando unit_testing.run() è un test indipendentemente dal numero di funzioni e di checkpoint richiamate.
Ogni test e i risultati di tutti i checkpoint di ogni funzioni richiamata vengono memorizzati nelle tabelle: tests e tests_detail.
Il comando "run" può eseguire anche una verifica degli errori presenti nelle functions del database tramite l'estensione plpgsql_check:
"https://github.com/okbob/plpgsql_check" inoltre può eseguire una verifica di tutte le query richiamandole con una predicato FALSE (0=1)
per evitare che ritornino dei dati.
Concettualmente il comando "run" ha le seguenti fasi:

- controllo dei parametri di input
- controllo degli errori di compilazione delle functions (se richiesto)
- controllo delle query (se richiesto)
- creazione/aggiornamento albero delle dipendenze (se necessario)
- controllo riferimenti circolari
- selezione delle funzioni da richiamare e l'ordine in cui farlo
- inizio della transazione in cui richiudere tutti i test
- richiamo delle funzioni di test
- interruzzione della transazione (abort)
-  memorizzazione dei risultati dei tests 
- visualizzazione del numero di test assegnato

Nonostante le funzioni di unti test si possano scrivere dove si vuole consigliamo di raggrupparle, come abbiamo fatto in scuola247,
in un apposito schema che noi abbiamo chiamato (con grande fantasia) unit_tests.

Una funzione di unit test, tipicamente si scrive così:

```
CREATE OR REPLACE FUNCTION unit_tests.<nome_function>(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE 
  context               text;
  full_function_name 	  text;
  test_name	          	text = '';
  error			            diagnostic.error;
BEGIN
  -- richiamo delle helper_function per determinare il nome della funzione corrente tramite l'analisi dello stack:
  -- la funzione si trova nello schema diagnostic di scuola247
  
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  -- check to build dependencies
  -- richiamo la funziona che provvede a segnalare quale funzione richiamare prima della presente
  IF _build_dependencies THEN
      -- se non ci sono funzioni da richiamare prima della presenre:
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
      --- se invece ci sono funzioni da richiamar prima la sintassi è la seguente:
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'funcion2',
                                                                                         'function3');
  
    RETURN;
  END IF;  
  
  -- finalmente cominciamo il primo test: innanzitutto gli diamo un nome:
  -----------------------------
  test_name = 'first test';
  -----------------------------
  BEGIN
    INSERT INTO table1 (col1, col2) VALUES (1, 2);
    -- il test ha avuto successo quindi si accodano in output i dati restituiti dalla funzione pass
    _results =  _results || assert.pass(full_function_name, test_s
    EXCEPTION
      WHEN OTHERS THEN 
        -- per maggiore leggibilità sono andato a capo ad ogni assegnazione ma una volta appreso il concetto il consiglio
        -- è di mettere tutto su un'unica riga per risparmiare spazio in verticale
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE,
                                error.message_text = MESSAGE_TEXT, 
                                error.schema_name = SCHEMA_NAME, 
                                error.table_name = TABLE_NAME, 
                                error.column_name = COLUMN_NAME, 
                                error.constraint_name = CONSTRAINT_NAME, 
                                error.pg_exception_context = PG_EXCEPTION_CONTEXT, 
                                error.pg_exception_detail = PG_EXCEPTION_DETAIL, 
                                error.pg_exception_hint = PG_EXCEPTION_HINT, 
                                error.pg_datatype_name = PG_DATATYPE_NAME;
        -- in questo caso invece siè verificato un problema imprevisto (out of space per esempio)
        -- quindi dopo aver raccolto i dati diagnostici che ci mette a disposizione postgresql
        -- componiamo i dati da restituire con la funzione assert.fail e li acodiamo per l'output
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.schools FAILED'::text, error);   
        RETURN; 
  END;
  RETURN;  
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests.schools(boolean)
  OWNER TO postgres;
```
