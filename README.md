PostgreSQL for Scuola247
========================

Database DCL, DDL e DML for Scuola247 on PostgreSQL

Qui di seguito le istruzioni per ricreare un server ubuntu 
all'interno di una macchina virtuale VirtualBox
su cui poi installare PostgreSQL e quindi il database di Scuola247.

per chi invece volesse qualche comodità in più ecco dove scaricare 
una macchina virtuale già pronta con il database e il filesystem 
senza le immagini prese da wikimedia:

https://sourceforge.net/projects/scuola247/files/ubuntu-server-1604-scuola247-without-images.zip/download

l'utente del s.o. è: 'fol' con password: 'password' (le virgolette sono escluse)
l'utente postgres è: 'postgres' con password: 'postgres' (le virgolette sono escluse)

per chi non ha problemi sulle dimensini del download ho preparata anche
una macchina virtuale con il database già popolato con le immagini prese 
da wikimedia, la potete trovare qui:

https://sourceforge.net/projects/scuola247/files/ubuntu-server-1604-scuola247-with-images.zip/download

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

database.sql

a questo punto carichiamo lo schema dati con:

schema.sql

infine carichiamo i dati (escluse le immagini)

data.sql

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
a partire dalla directory '/var/lib/scuola247/' 
inoltre rimuovo tutte le righe della tabella wikimedia_files_persons.
Per fare tutto questo basta eseguire:

SELECT public.wikimedia_0_reset();

riattribuisco quindi, casualmente, con il comando:

SELECT public.wikimedia_1_recreate_wikimedia_files_persons();

le foto dei file della tabella wikimedia_files alla tabella persons eventualmente
riutilizzando dall'inizio le righe di wikimedia_files se non sono sufficenti a coprire
tutte le righe della tabella persons.

idrato poi le colonne info, thumbnail e photo della tabella wikimedia_files 
prendendo i dati dal sito di wikimedia (dalle url ricavate dal nome file)
il comando è il seguente

SELECT public.wikimedia_2_wikimedia_files_hydration('numero di righe da popolare');

Lanciate il comando tenendo presente che:
1) e' soggetto alle condizione del sito di wikimedia e della velocità della vostra
connessione internet e quindi può non andare a buon fine.
2) se il comando non va' a buon fine tutte le modifiche vanno perse
3) nel momento in cui scrivo queste raccomandazioni il numero di righe della tabella
wikimedia_files è di 4099 righe

personalmente ho visto che con un 'numero di righe da popolare' maggiore di 500
gli errori sono molto frequenti con 'numero di righe da popolare' inferiore a 100
si deve impartire il comado troppe volte.

quindi personalmenteimpartisco il comando:

SELECT piblic.wikimedia_2_wikimedia_files_hydration(100);

facendo copia e incolla altre quaranta volte 

quindi popolo le directory a partire da '/var/lib/scuola247/wikimedia_files' 
con il comando:

SELECT public.wikimedia_3_wikimedia_files_popolate_files();

aggiorno quindi le colonne photo e thumbnail della tabella persons 
prendondo i dati dalla tabella wikimedia_files facendomi guidare
dall'assegnazione fatta con la tabella wikimedia_files_persons
eseguendo il comando:

SELECT public.wikimedia_4_persons_hydration();

infine popolo le directory a partire da '/var/lib/scuola247/persons' 
con il comando:

SELECT public.wikimedia_5_persons_popolate_files(); 

Bene avete appena completato l'installazione del database di scuola247 !
