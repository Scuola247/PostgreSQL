-- Function: git.sync()

-- DROP FUNCTION git.sync();

CREATE OR REPLACE FUNCTION git.sync()
  RETURNS TABLE(_message text) AS
$BODY$
<<me>>
DECLARE
  my_record			record;
  my_command			text;
  error				diagnostic.error;
  my_data_path			text = '/var/lib/postgresql/10/main/git/scuola247/postgreSQL/';
  ctr_casts_create_osdel	int = 0;
  ctr_casts_create_osisrt	int = 0;
  ctr_casts_create_osupd	int = 0;
  ctr_casts_comm_osdel		int = 0;
  ctr_casts_comm_osisrt		int = 0;
  ctr_casts_comm_osupd		int = 0;
  
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  BEGIN
    my_command = format('COPY (SELECT 1) TO PROGRAM %L','mkdir -p ' || my_data_path || 'casts/create'); 
    EXECUTE my_command;
    _message = format('INIT Create directory : %L', my_data_path || 'casts/create' ); RAISE NOTICE '%', _message; RETURN NEXT;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
      _message = format('INIT Error trying create directory: %L',my_data_path || 'casts/create'); RAISE NOTICE '%', _message; RETURN NEXT;      
  END;

  BEGIN
    my_command = format('COPY (SELECT 1) TO PROGRAM %L','mkdir -p ' || my_data_path || 'casts/comments'); 
    EXECUTE my_command;
    _message = format('INIT Create directory : %L', my_data_path || 'casts/comments' ); RAISE NOTICE '%', _message; RETURN NEXT;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      PERFORM diagnostic.show(error);
      _message = format('INIT Error trying create directory: %L',my_data_path || 'casts/comments'); RAISE NOTICE '%', _message; RETURN NEXT;      
  END;
  --
  -- create temp table for ls command
  --
  CREATE TEMP TABLE IF NOT EXISTS _ddl_files ( ddl_name text, ddl_file_name text);
  --
  -- table could be exist and have rows
  --
  DELETE FROM _ddl_files;
  -- 
  -- get the list of .sql files
  --
  my_command = format('COPY _ddl_files(ddl_file_name) FROM PROGRAM %L','ls ' || my_data_path || 'casts/create');
  EXECUTE my_command;
  UPDATE _ddl_files SET ddl_name = left(ddl_file_name,length(ddl_file_name)-4);
  --
  -- casts create
  --
  FOR my_record IN SELECT cast_name, cast_ddl_create, ddl_name, COALESCE(ddl_file_name,cast_name || '.sql') AS ddl_file_name
                     FROM git.casts_ddl_create
                FULL JOIN _ddl_files on cast_name = ddl_name
  LOOP
    IF my_record.cast_name IS NULL THEN

      BEGIN
        my_command = format('COPY (SELECT 1) TO PROGRAM %L','rm ' || format ('%L',my_data_path || 'casts/create/' || my_record.ddl_file_name)); 
        EXECUTE my_command;
        ctr_casts_create_osdel = ctr_casts_create_osdel + 1;        
        _message = format('Cast : %L (create) removed from file system!', my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;
      EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
          PERFORM diagnostic.show(error);
          _message = format('Error trying remove file: %L',my_data_path || 'casts/create/' || my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;      
      END;

    ELSE

      BEGIN
        my_command = format('COPY (SELECT %L) TO PROGRAM %L', my_record.cast_ddl_create, 'cat > ' || format('%L',my_data_path || 'casts/create/' || my_record.ddl_file_name));
        EXECUTE my_command;
        ctr_casts_create_osupd = ctr_casts_create_osupd + 1;        
        _message = format('Cast : %L (create) updated into file system!', my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;
      EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
          PERFORM diagnostic.show(error);
          _message = format('Error trying update file: %L',my_data_path || 'casts/create/' || my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;      
      END;     

    END IF;
  END LOOP;
  --
  -- table could be exist and have rows
  --
  DELETE FROM _ddl_files;
  -- 
  -- get the list of .sql files
  --
  my_command = format('COPY _ddl_files(ddl_file_name) FROM PROGRAM %L','ls ' || my_data_path || 'casts/comments');
  EXECUTE my_command;
  UPDATE _ddl_files SET ddl_name = left(ddl_file_name,length(ddl_file_name)-4);
    --
  -- casts comment
  --
  FOR my_record IN SELECT cast_name, cast_ddl_comment, ddl_name, COALESCE(ddl_file_name,cast_name || '.sql') AS ddl_file_name
                     FROM git.casts_ddl_comment
                FULL JOIN _ddl_files on cast_name = ddl_name
  LOOP
    IF my_record.cast_name IS NULL THEN

      BEGIN
        my_command = format('COPY (SELECT 1) TO PROGRAM %L','rm ' || format('%L',my_data_path || 'casts/comments/' || my_record.ddl_file_name)); 
        EXECUTE my_command;
        ctr_casts_comm_osdel = ctr_casts_comm_osdel + 1;        
        _message = format('Cast : %L (comment) removed from file system!', my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;
      EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
          PERFORM diagnostic.show(error);
          _message = format('Error trying remove file: %L',my_data_path || 'casts/comments/' || my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;      
      END;

    ELSE

      BEGIN
        my_command = format('COPY (SELECT %L) TO PROGRAM %L', my_record.cast_ddl_comment, 'cat > ' || format('%L',my_data_path || 'casts/comments/' || my_record.ddl_file_name));
        EXECUTE my_command;
        ctr_casts_comm_osupd = ctr_casts_comm_osupd + 1;        
        _message = format('Cast : %L (comment) updated into file system!', my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;
      EXCEPTION WHEN OTHERS THEN
        GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
          PERFORM diagnostic.show(error);
          _message = format('Error trying update file: %L',my_data_path || 'casts/comments/' || my_record.ddl_file_name); RAISE NOTICE '%', _message; RETURN NEXT;      
      END;   

    END IF;
  END LOOP;

  _message = format('Casts create deleted from o.s. file system ..........:%s',ctr_casts_create_osdel::text);  RAISE NOTICE '%', _message; RETURN NEXT; 
  _message = format('Casts create added into o.s. file system ............:%s',ctr_casts_create_osupd::text);  RAISE NOTICE '%', _message; RETURN NEXT; 
  _message = format('Casts create updated into o.s. file system ..........:%s',ctr_casts_create_osisrt::text); RAISE NOTICE '%', _message; RETURN NEXT; 
  _message = format('Casts comment deleted from o.s. file system .........:%s',ctr_casts_comm_osdel::text);    RAISE NOTICE '%', _message; RETURN NEXT; 
  _message = format('Casts comment added into o.s. file system ...........:%s',ctr_casts_comm_osupd::text);    RAISE NOTICE '%', _message; RETURN NEXT; 
  _message = format('Casts comment updated into o.s. file system .........:%s',ctr_casts_comm_osisrt::text);   RAISE NOTICE '%', _message; RETURN NEXT; 

END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION git.sync()
  OWNER TO postgres;

