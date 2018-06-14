SET ROLE 'test-manager-a@scuola-1.it'
SET ROLE 'manager-c@scuola-2.it'
SET ROLE 'manager-e@scuola-28961.it'
SET ROLE 'fol@scuola247.it'
SET ROLE 'matteonovelli.my@gmail.com'
RESET ROLE
SELECT school, usename from persons WHERE usename IS not null