-- Function: unit_tests_translate.relations(boolean)

-- DROP FUNCTION unit_tests_translate.relations(boolean);

CREATE OR REPLACE FUNCTION unit_tests_translate.relations(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE 
  context               text;
  full_function_name 	text;
  test_name		text = '';
  error			diagnostic.error;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
      PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context));
    RETURN;
  END IF;  
  -----------------------------
  test_name = 'INSERT relations';
  -----------------------------
  BEGIN
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299124000000000','school_years','297479000000000','anni_scolastici','Rappresenta gli anni scolastici e sono divisi per scuole');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299175000000000','absences','297479000000000','assenze','Visualizza le assenze per studente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299146000000000','out_of_classrooms','297479000000000','fuori_classi','Indica quando uno studente non è presente ma non deve essere considerato assente, esempio: attività sportiva');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299149000000000','absences_certified_grp','297479000000000','assenze_certificati_grp','Raggruppa le assenze certificate con data, insegnante e classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299135000000000','absences_ex','297479000000000','assenze_ex','Visualizza ogni asenza per studente con altre informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299077000000000','leavings_month_grp','297479000000000','uscite_mese_grp','Visualizza le uscite del mese');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299085000000000','absences_grp','297479000000000','assenze_grp','Raggruppa le assenze per classe(anche per anno scolastico) e studente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299134000000000','absences_month_grp','297479000000000','assenze_mese_grp','Raggruppa le assenze per classe (anche per anno scolastico) e mese è usata una crossjoin per fare una lista di tutte le persone delle classi per ogni mese a zero per unire essisons the absences of the table for having all absences for every month of the year. also those at zero. otherwise, looking only table of absences, there will not');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299097000000000','classrooms_teachers_subjects_ex','297479000000000','classi_docenti_materie_ex','Visualizza le materie dei docenti con informazioni aggiuntive');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299080000000000','classbooks_month_grp','297479000000000','registro_di_classe_mese_grp','Mostra il registro di classe per mese');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299105000000000','classrooms_students_ex','297479000000000','classi_alunni_ex','Visualizza le informazioni perogni studente per ogni classe in ogni scuola');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299076000000000','classrooms_teachers_ex','297479000000000','classi_docenti_ex','Visualizza tutti gli insegnanti con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299132000000000','classrooms_teachers_subject','297479000000000','classi_docenti_materia','Visualizza le materie dei docenti per ogni classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299128000000000','classrooms_ex','297479000000000','classi_ex','Visualizza le classi per ogni scuola con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299118000000000','valutations_ex','297479000000000','valutazioni_ex','Visualizza ogni valutazione con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299088000000000','signatures_ex','297479000000000','firme_ex','Contiene le firme per ogni insegnante con altre informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299164000000000','signatures_grp','297479000000000','firme_grp','Raggruppa le firme fatte per ogni insegnate nelle classi');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299148000000000','out_of_classrooms_ex','297479000000000','fuori_classi_ex','Visualizza ogni studente che non sarà presente per motivi particolari con altre informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299126000000000','out_of_classrooms_grp','297479000000000','fuori_classi_grp','Raggruppa gli studenti che non saranno in classe (anche per anno scolastico)');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299092000000000','schools_school_years_classrooms_weekly_timetable','297479000000000','istituti_anni_scolastici_classi_orario_settimanale','Visualizza tutti gli orari settimanali per ogni scuola');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299104000000000','lessons_ex','297479000000000','lezioni_ex','Visualizza tutte le lezioni con informazioni maggiori');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299161000000000','lessons_days','297479000000000','lezioni_giorni','Visualizza i giorni di lezione nelle varie scuole');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299090000000000','lessons_grp','297479000000000','lezioni_grp','Ragruppa tutte le lezioni per ogni insegnante e classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299087000000000','faults_grp','297479000000000','mancanze_grp','Raggruppa tutte le mancanze per tutti gli studenti e le classi');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299081000000000','valutations_stats_classrooms_subjects_ex','297479000000000','valutazioni_stats_classi_materie_ex','Statistiche delle valutazioni per classi e materie');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299083000000000','delays_not_explained_grp','297479000000000','ritardi_non_giustificate_grp','Mostra i ritardi di una classe limitandosi ai risultati non ancora giustificati');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299094000000000','weekly_timetables_days_ex','297479000000000','orari_settimanali_giorni_ex','Mostra ogni informazione per giorno nella tabella settimanale');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299101000000000','out_of_classrooms_month_grp','297479000000000','fuori_classi_mese_grp','Mostra gli alunni assenti che non devono giustificare del mese perché fuori dalla classe7');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299106000000000','leavings_certified_grp','297479000000000','uscite_certificati_grp','Mostra le uscite certificate per ogni classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299112000000000','cities','297479000000000','comuni','Contiene tutti i comuni italiani');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299113000000000','notes_iussed_grp','297479000000000','nota_emesse_grp','Mostra tutte le note fatte dai professori per classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299117000000000','absences_not_explanated_grp','297479000000000','assenze_non_giustificate_grp','Mostra tutte le assenze in una classe limitandosi a mostrare quelle non giustificate');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299125000000000','leavings_ex','297479000000000','uscite_ex','Visualizza ogni uscita con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299127000000000','notes_month_grp','297479000000000','nota_mese_grp','Mostra le note del mese');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299141000000000','notes_grp','297479000000000','nota_grp','Mostra tutte le note per classe e studente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299129000000000','weekly_timetable_ex','297479000000000','orario_settimanale_ex','Mostra l''orario settimanale per ogni classe con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299130000000000','delays_ex','297479000000000','ritardi_ex','Mostra ogni ritardo con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299131000000000','notes_ex','297479000000000','nota_ex','Mostra ogni nota con maggiori informazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299151000000000','notes_signed_ex','297479000000000','nota_visto_ex','Mostra tutte le note vistate');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299153000000000','delays_grp','297479000000000','ritardi_grp','Mostra i ritardi di uno studente o in una classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299154000000000','delays_certified_grp','297479000000000','ritardi_certificati_grp','Mostra i ritardi certificati');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299159000000000','valutations_stats_classrooms_students_subjects','297479000000000','valutazioni_stats_classi_alunni_materie','Statistiche per classe / studente / professore');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299167000000000','leavings_not_explained_grp','297479000000000','uscite_non_giustificate_grp','Mostra tutte le uscite di uno studente o classe limitandosi a quelle non giustificate');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('305804000000000','wikimedia_license_infos','297479000000000','wikimedia_licenza_info','Estra l''informazione dalla colonna nella tabella wikimedia per la licenza di utilizzo dei file');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299116000000000','delays_month_grp','297479000000000','ritardi_mese_grp','Mostra i ritardi per classe e viene usata una crossjoin per creare una lista di tutte le persone delle classi per ogni mese a zero per unire alle persone i ritardi della tabella in modo da avere tutti i ritardi del mese, anche quelli a zero. Altrimenti, guardando la tebella dei ritardi, non ci saranno');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299079000000000','leavings','297479000000000','uscite','Mostra le uscite di uno studente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299103000000000','countries','297479000000000','nazioni','Contiene tutte le nazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299168000000000','leavings_grp','297479000000000','uscite_grp','Mostra tutte le uscite di uno studente o classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299173000000000','residence_grp_city','297479000000000','residenza_grp_comune','Mostra tutti i comuni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299177000000000','valutations_ex_references','297479000000000','valutazioni_ex_riferimenti','Mostra ogni riferimento per valutazione');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299172000000000','classrooms_students_addresses_ex','297479000000000','classi_alunni_indirizzi_ex','Visualizza gli indirizzi degli studenti');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299174000000000','classrooms_teachers','297479000000000','classi_docenti','Visualizza tutti gli insegnanti con le loro classi');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299176000000000','out_of_classrooms_certified_grp','297479000000000','fuori_classi_certificati_grp','Indica tutti gli studenti che non saranno presenti in uno specifico giorno per motivi particolari già controllati');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299169000000000','delays','297479000000000','ritardi','Mostra i ritardi di uno studente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299180000000000','grade_types','297479000000000','tipi_voto','Il tipo di voto, può essere Orale o Scritto per esempio');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711860000000000','wikimedia_files','297479000000000','wikimedia_files','Files da wikimedia commons');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299162000000000','branches','297479000000000','filiali','Contiene le filiali per ogni scuola');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299171000000000','faults','297479000000000','mancanze','Mostra le mancanze di uno studente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299084000000000','grading_meetings_valutations_qua','297479000000000','scrutini_valutazioni_qualifiche','Mostra tutti gli scrutini, aperti o chiusi');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299091000000000','grades','297479000000000','voti','Per ogni metrica abbiamo i voti possibili');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299095000000000','regions','297479000000000','regionei','Contiene tutte le regioni italiane');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299099000000000','persons_addresses','297479000000000','personae_indirizzi','Contiene l''indirizzo di ogni persona');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299100000000000','communication_types','297479000000000','tipi_comunicazione','Mezzo di comunicazione della scuola per comunicare le notifiche ai parenti, non presente per ogni scuola perché richiede un costo aggiuntivo');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299102000000000','persons_roles','297479000000000','personae_ruoli','Contiene la lista di persone con i loro ruoli');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299109000000000','subjects','297479000000000','materie','Contiene le materie di ogni scuola');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299133000000000','valutations','297479000000000','valutazioni','Mostra tutte le valutazioni inserite dai professori');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299156000000000','persons_relations','297479000000000','personae_relazioni','Indicates the relations abount persons: tipically student(coloumn person) will have for relationship ''Parent''  the father (person_related_to) for indicates the mother will add a row with same values as said before but looking that this time to insert in coloumn person_related_to the code of person that identifies the mother');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299098000000000','topics','297479000000000','argomenti','Contiene gli oggetti per gli argomenti sulle valutazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299115000000000','classrooms','297479000000000','classi','Contiene tutte le classi per ogni scuola');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299158000000000','parents_meetings','297479000000000','colloqui','In questa tabella vengono memorizzati tutti i periodi di disponibilità per i colloqui');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299086000000000','conversations_invites','297479000000000','conversazioni_invitati','Definisce i partecipanti ad una conversazione, le persone abilitate a guardare o partecipare a certe conversazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299145000000000','signatures','297479000000000','firme','Contiene le firme per ogni insegnante');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299147000000000','explanations','297479000000000','giustificazioni','Contiene tutte le giustificazioni per assenze, ritardi e uscite.Può essere fatto da un insegnante che compilerà la descrizione o da un parente');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299165000000000','districts','297479000000000','provincie','Contiene tutte le provincie italiane');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711858000000000','weekly_timetables','297479000000000','orario_settimanale','Contiene l''orario settimanale della classe');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711859000000000','holidays','297479000000000','vacanze','Contiene tutte le vacanze per scuola');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('305950000000000','usenames_ex','297479000000000','usename_ex','Aggiunge informazioni all''usename nella tabella di sistema utile solo per scuola247');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711864000000000','qualifications_plan','297479000000000','piano_qualifiche','Contiene le connessioni riguardo il piano informativo(sezione, materia, anno) e qualificazioni. Esso è necessario nella fase di valutazione per presentare le qualifiche ai parenti riguardo le valutazioni');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711861000000000','wikimedia_files_persons','297479000000000','wikimedia_files_persone','File da wikimedia commons per persona');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711862000000000','valutations_qualifications','297479000000000','valutazioni_qualifiche','Per ogni valutazione inserita nella tabella è possibile connettere una qualifica presente in questa tabella');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299121000000000','teachears_notes','297479000000000','nota_docentis','Ha la stessa funzione della tabella per le note ma per il registro dei professori.L''unica differenza è che non è necessario replicare la colonna ''disciplinare'' anche perché le note disciplinari possono essere fatte solo nel registro di classe a meno che quest''ultime non sono per uso privato dei professori');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('711863000000000','qualifications','297479000000000','qualifiche','Descrive per ogni scuola le conoscenze, competenze e abilità');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('153000000000','usenames_schools','297479000000000',NULL,'record schools accessible to the user');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('299157000000000','schools','297479000000000','istituti','Un istituzione per la istruzione dei bambini o ragazzi sotto l''età per il college');
INSERT INTO translate.relations(relation,name,language,translation,comment) VALUES ('171000000000','nic_test','297479000000000',NULL,NULL);

    


    _results =  _results || assert.pass(full_function_name, test_name);

    EXCEPTION
      WHEN OTHERS THEN 
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
        _results = _results || assert.fail(full_function_name, test_name, 'INSERT public.relations FAILED'::text, error);   
        RETURN; 
  END;
  RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_translate.relations(boolean)
  OWNER TO postgres;
