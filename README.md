PostgreSQL for Scuola247
========================

Database DCL, DDL e DML for Scuola247 on PostgreSQL

Qui di seguito le istruzioni per ricreare un server ubuntu 
all'interno di una macchina virtuale VirtualBox
su cui poi installare PostgreSQL e quindi il database di Scuola247.

L'ambiente su cui IO ho FATTO le prove è il seguente:
Windows 10.1607
VirtualBox 5.1.10
Ubuntu 16.04.1 LTS
PostgreSQL 9.5
Chiaramente cambiare la versione non DOVREBBE essere un problema
questa la teoria poi la pratica ....

Ecco quindi le istruzioni

Innanzitutto bisogna installare VirtualBox
se proprio non lo avete mai fatto qui ci sono due righe per aiutarvi
http://www.folstuff.eu/2016/12/installazione-virtualbox/

Installato VirtualBoX bisogna fare la macchina
virtuale con sopra ubuntu server
qui spiego nel dettaglio tutti i passaggi 
http://www.folstuff.eu/2016/12/installazione-di-ubuntu-server-su-una-macchina-virtuale-di-virtualbox/

Poi è la volta dell'installazione di postgres
anche per questo ho preparato una piccola guida
http://www.folstuff.eu/2016/12/ubuntu-come-installare-postgresql

Una volta installato postgres bisogna abilitarlo ai collegamenti 
esterni, anche qui sul mio blog ho preparato un piccolo artico
http://www.folstuff.eu/2014/03/postgresql-la-prima-connessione

Le Funcion di scuola247 utilizzano diverse Extension di Postgres.
Alcune di queste hanno bisogno di installazione..

La prima serve per il debug a livello di sorgente
qui trovate tutte le istruzioni per l'installazione
http://www.folstuff.eu/2016/04/come-fare-il-debug-di-una-funzione-postgresql

la seconda per la comunicazione via HTTP
anche qui ho scritto una piccola guida
http://www.folstuff.eu/2016/03/postgresql-come-fare-richieste-http-da-plpgsql

infine abbiamo un'estensione per il controllo sintattico delle funzioni
come al solito qui la guira per l'installazione
http://www.folstuff.eu/2016/12/postgresql-check-function

Una volta preparato l'ambiente possiamo passare al popolamento del db
Questo avviene con degli script che posso usare anche interattivamente
su pgadmin III o pgadmin4

innanzitutto provvediamo a ricostruire gli utenti e i gruppi del sistema
lo script è il seguente:
global.sql

poi creiamo il database vero e proprio con:
scuola247_database-sql

a questo punto carichiamo lo schema dati con:
scuola247_schema.sql

infine carichiamo i dati (escluse le immagini)
scuola247_data.sql

a questo punto eseguite il comando per registrare 
l'estensione HTPP (he non viene riportata nel backup):
eseguire CREATE EXTENSION http;

Poi dobbiamo sistemare le sequenze con il comando:
SELECT utility.set_all_sequences_2_the_max();

bisogna a questo punto si deve la struttura
delle directory che andranno ad ospitare
le immagini sul file system:
/var/lib/scuola247/persons/photos
/var/lib/scuola247/persons/thumbnails
/var/lib/scuola247/wikimedia_files/infos
/var/lib/scuola247/wikimedia_files/photos
/var/lib/scuola247/wikimedia_files/thumbnails

proprietario e grupo vanno impostati su 'postgres'
e le permission a 0770

a questo punto siamo pronti per lanciare le
stored provcedure per il caricamento delle immagini

******** purtroppo ho visto   **************

******** ora che ci sono      **************

******** errori da correggere **************


public.wikimedia_0_reset();
public.wikimedia_1_hydration();
public.wikimedia_2_popolate_files();
public.wikimedia_3_hydration_persons();
public.wikimedia_4_popolate_files_persons();

