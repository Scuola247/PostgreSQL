PostgreSQL for Scuola247
========================

Database DCL, DDL e DML for Scuola247 on PostgreSQL

Step to create the DB:

1) Login to your server with an admin account (like postgres)
2) run the globals.sql script taking care to change the user "postgres" with the name of the administrative account used
3) create the database scuola247 (you can change the name if you want)
4) run the script schema.sql in db scuola247 to create the schema
5) run the script data_noimage.sql to populate the data without image (to save space)

N.B.
You can run the script either with pgadmin or psql
