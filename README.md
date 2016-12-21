PostgreSQL for Scuola247
========================

Database DCL, DDL e DML for Scuola247 on PostgreSQL

Qui di seguito le istruzioni per ricreare un server ubuntu 
all'interno di una macchina virtuale VirtualBox
su cui poi installare PostgreSQL e quindi il database di Scuola247.

L'ambiente su cui ho fatto personalmente le prove è il seguente:
Windows 10.1607,
VirtualBox 5.1.10, 
Ubuntu 16.04.1 LTS,
PostgreSQL 9.6, 
Chiaramente cambiare la versione non dovrebbe essere un problema
ma si sa che un conto è la teoria un altro la pratica ....

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
esterni, anche qui sul mio blog ho preparato un piccolo articolo
http://www.folstuff.eu/2014/03/postgresql-la-prima-connessione

Le funzioni di scuola247 utilizzano diverse Extension di Postgres.
Alcune di queste hanno bisogno di installazione...

La prima serve per fare il debug delle funzioni a livello di sorgente
qui trovate tutte le istruzioni per l'installazione: 
http://www.folstuff.eu/2016/04/come-fare-il-debug-di-una-funzione-postgresql

la seconda serve per la comunicazione via HTTP
anche qui ho ecco una piccola guida: 
http://www.folstuff.eu/2016/03/postgresql-come-fare-richieste-http-da-plpgsql

infine abbiamo un'estensione per il controllo sintattico delle funzioni
come al solito qui un articolo per aiutarvi: 
http://www.folstuff.eu/2016/12/postgresql-check-function

Una volta preparato l'ambiente possiamo passare al popolamento del db
Questo avviene con degli script che posso usare anche interattivamente
caricandoli ed eseguendoli direttamente da pgadmin III o pgadmin4

innanzitutto provvediamo a ricostruire gli utenti e i gruppi del sistema
lo script da lanciare è il seguente:

global.sql

poi creiamo il database vero e proprio con:

scuola247_database-sql

a questo punto carichiamo lo schema dati con:

scuola247_schema.sql

infine carichiamo i dati (escluse le immagini)

scuola247_data.sql

a questo punto eseguite il comando per registrare 
l'estensione HTPP (che non viene riportata nel backup):

CREATE EXTENSION http;

Poi dobbiamo sistemare le sequenze con il comando:

SELECT utility.set_all_sequences_2_the_max();

bisogna a questo punto ricreare la struttura
delle directory che andranno ad ospitare
le immagini sul file system:

/var/lib/scuola247/persons/photos

/var/lib/scuola247/persons/thumbnails

/var/lib/scuola247/wikimedia_files/infos

/var/lib/scuola247/wikimedia_files/photos

/var/lib/scuola247/wikimedia_files/thumbnails

proprietario e gruppi vanno impostati su 'postgres'
e i permessi a 0770

a questo punto siamo pronti per caricare le immagini.
Siccome le immagini occupano molto spazio sul db ed, ovviamente,
anche nel backup ho deciso di svutare la tabella persons dalle immagini
prima di fare il backup in modo che questo possa essere gestito 
con più facilità, ad esempio caricandolo ed eseguendolo conme un qualsiasi 
altro script su pgadmin III.
Le immagini invece vengono scaricate ed memorizzate sia sul db che sul
file sistem da alcune funzioni progettate ad hoc.

Nella prima funzione imposto a null le colonne info, photo e thumbnail 
della tabella wikimedia_files e imposto a null le colonne photo e thumbnail 
della tabella persons poi rimuovo, ricorsivamente, tutti i file 
a partire dalla directory '/var/lib/scuola247/' per fare tutto questo basta eseguire:

SELECT public.wikimedia_0_reset();

idrato poi le colonne info, thumbnail e photo della tabella wikimedia_files 
prendendo i dati dal sito di wikimedia (dalle url ricavate dal nome file)
con il comando:

SELECT public.wikimedia_1_hydration(10000);

quindi popolo le directory a partire da '/var/lib/scuola247/wikimedia_files' 
con il comando:

SELECT public.wikimedia_2_popolate_files();

aggiorno quindi le colonne photo e thumbnail della tabella persons 
prendondo i dati dalla tabella wikimedia_files facendomi guidare
dall'assegnazione fatta con la tabella wikimedia_files_persons
eseguendo il comando:

SELECT public.wikimedia_3_hydration_persons();

infine popolo le directory a partire da '/var/lib/scuola247/persons' 
con il comando:

SELECT public.wikimedia_4_popolate_files_persons();

Bene avete appena completato l'installazione del database di scuola247 !
