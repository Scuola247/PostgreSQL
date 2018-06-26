/*
select school, description, example
from schools

select *
from _rls_test

select *
FROM _rls_test_security_barrier

select *
from _rls_test_with_check_local

select *
from _rls_test_with_check_local_cascade

select *
from branches

select *
from school_years

select *
from classrooms
order by classroom

select *
from classrooms_students
order by classroom_student

select *
from absences
order by classroom_student

select a.absence, a.classroom_student, cs.classroom, c.school_year, sy.school
from absences a
join classrooms_students cs on cs.classroom_student = a.classroom_student
join classrooms c on c.classroom = cs.classroom
join school_years sy on sy.school_year = c.school_year
order by classroom_student


select cs.classroom_student, cs.classroom, c.school_year, sy.school
from classrooms_students cs
join classrooms c on c.classroom = cs.classroom
join school_years sy on sy.school_year = c.school_year
order by sy.school

select d.delay, d.classroom_student, cs.classroom, c.school_year, sy.school
from delays d
join classrooms_students cs on cs.classroom_student = d.classroom_student
join classrooms c on c.classroom = cs.classroom
join school_years sy on sy.school_year = c.school_year
order by classroom_student

select *
from lessons

select *
from valutations

UPDATE schools SET example = FALSE
WHERE school = 1

select school, person, name, surname
from persons
--WHERE school = ANY (schools_enabled())
limit 100

select schools_enabled()

select school_years_enabled()

select *
from notes_ex

select school, school_description, school_year
from classrooms_ex


select pg_has_role('superuser')

show is_superuser;

-- necessario per la comprensione di come si fa uno unit test di sicureza verticale.
SET ROLE 'manager-a@scuola-1.it'
SET ROLE 'manager-c@scuola-2.it'
SET ROLE 'manager-e@scuola-28961.it'
SET ROLE 'fol@scuola247.it'
SET ROLE 'matteonovelli.my@gmail.com'
RESET ROLE
SELECT school, usename from persons WHERE usename IS not null
WITH t AS (SELECT school, count(school) FROM branches GROUP BY school)
select count (*) from t
SELECT school, count(school) INTO me.school, me.count_school FROM branches GROUP BY school
GET DIAGNOSTICS me.row_count = ROW_COUNT;
select assert.are_equals('unit_tests_rls','controllo schools(school)',2,me.school)
select assert.are_equals('unit_tests_rls','controllo schools(count_school)',1,me.count_school)
select assert.are_equals('unit_tests_rls','controllo schools(school)',1,me.row_count)

*/
