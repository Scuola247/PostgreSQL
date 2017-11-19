In scuola247 abbiamo creato un framework per lo unit test.
Il framework può essere usato con qualsiasi db: non è stato fatto esclusivamente per scuola247.
Cosa bisogma sapere prima di poertlo usare ?
Innanzitutto partiamo dai concetti:
Ogni test effettuato con Scuola247/unit_testing viene definito check_point.
I checkpoint vengono raggruppati (e codificati) in funzioni postgresql dette funzioni di unit_test.
le funzioni di unit_test sono riconoscibili perchè hanno in input un boolean e ritornano un array di un tipo dati ben preciso: unit_testing.unit_test_result.
Le funzioni di unit test possono dichiarare delle dipendenze, cioè degli unit_test che debbono essere eseguiti prima di quello in oggetto.
Le funzioni possono essere eseguite tutte, oppure singolarmente o ancora selezionate in gruppi.
L'esecuzione delle funzioni di unit_test viene gestita dal comando unit_testing.run();
Il comando "run" può eseguire anche una verifica degli errori presenti nelle functions del database tramite l'estensione plpgsql_check:
"https://github.com/okbob/plpgsql_check" può inoltre eseguire una verifica di tutte le query richiamandole con una predicato falso (0=1)
per evitare che ritornino dei dati.
Concettualmente il comando "run" ha le seguenti fasi
1) controllo dei parametri di input
2) controllo degli errori di compilazione delle functions (se richiesto)
3) controllo delle query (se richiesto)
4) creazione/aggiornamento albero delle dipendenze
5) controllo riferimenti circolari
6) selezione delle funzioni da richiamare e l'ordine in cui farlo
7) inizio di una transazione
8) richiamo delle funzioni di test
9) interruzzione della transazione (abort)
10) memorizzazione dei risultati dei tests 
11) riporto del numero di unit:test eseguito

seleziona le funzioni di test, costruisce l'albero delle dipendenze





Nonostante le funzioni di unti test si possano scrivere dove si vuole consigliamo di raggrupparle, come abbiamo fatto in scuola247
in un apposito schema che noi abbiamo chiamato (con grande fantasia) unit_test.
