-- LAB 3
-- 09 March 2021
-- Practice queries

select TITLE
from course c, DEPARTMENT d
where d.DEPT_NAME=c.DEPT_NAME and d.BUILDING= 'Main';

select d.DEPT_NAME, BUDGET
from course c, DEPARTMENT d
where d.DEPT_NAME=c.DEPT_NAME and CREDITS >= 4;

select d.DEPT_NAME, BUDGET
from course NATURAL JOIN DEPARTMENT d
where CREDITS >= 4;

@ G:\sql\banking.sql


select customer_name
from customer
where customer_name LIKE 'A%';

select account_number, customer_name, balance
from customer c, depositor d
where c.customer_name = d.customer_name and customer_city LIKE '%ri%';