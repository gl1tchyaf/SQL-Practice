--Name: Hasib Ar Rafiul Fahim
--ID: 2019-1-60-036
--Lab 5

--01
--with nested
select  distinct customer_name,customer_street,customer_city
from (select * from customer c, branch b where c.customer_city=b.branch_city );
--without nested
select distinct customer_name,customer_street,customer_city
from customer c,branch b
where c.customer_city=b.branch_city;

--02
--with nested
select distinct c.customer_name,c.customer_street,c.customer_city
from customer c,branch b
where c.customer_city=b.branch_city and b.branch_name in(select branch_name from loan l);
--without nested
select distinct c.customer_name,c.customer_street,c.customer_city
from customer c,branch b,loan l
where c.customer_city=b.branch_city and b.branch_name=l.branch_name;

--03
--with having
select b.branch_city,avg(a.balance)
from account a,branch b
where b.branch_name = a.branch_name
group by b.branch_city
having sum(a.balance)>1000;
--without having
select b.branch_city,avg(a.balance)
from account a,branch b,(select b.branch_city,sum(a.balance) as sum_bal from account a,branch b where b.branch_name = a.branch_name group by b.branch_city) c
where b.branch_name = a.branch_name and c.sum_bal>1000
group by b.branch_city;

--04
--with having
select b.branch_city,avg(l.amount)
from loan l,branch b
where b.branch_name = l.branch_name
group by b.branch_city
having avg(l.amount)>1500;
--without having
select b.branch_city,avg(a.amount)
from loan a,branch b,(select b.branch_city,sum(a.amount) as sum_bal from loan a,branch b where b.branch_name = a.branch_name group by b.branch_city) c
where b.branch_name = a.branch_name and c.sum_bal>1500
group by b.branch_city;

--05
--With ALL
select c.customer_name,c.customer_street,c.customer_city
from customer c,account a,depositor d
where d.account_number = a.account_number and d.customer_name = c.customer_name and balance>= ALL(select balance from account);
--without all
select c.customer_name,c.customer_street,c.customer_city
from customer c,account a,depositor d
where d.account_number = a.account_number and d.customer_name = c.customer_name and balance= (select max(balance) from account);

--06
--with all
select c.customer_name,c.customer_street,c.customer_city
from customer c,loan l,borrower b
where b.loan_number = l.loan_number and b.customer_name = c.customer_name and amount<= ALL(select amount from loan);
--without all
select c.customer_name,c.customer_street,c.customer_city
from customer c,loan l,borrower b
where b.loan_number = l.loan_number and b.customer_name = c.customer_name and amount= (select min(amount) from loan);

--07
--IN
select distinct Branch_name,branch_city
from branch 
where branch_name in (select a.branch_name from account a,loan l where a.branch_name=l.branch_name);
--EXISTS
select distinct b.branch_name, branch_city 
from branch b,loan l
where l.branch_name=b.branch_name and exists (select a.branch_name from account a where a.branch_name=b.branch_name);

--08
--Not IN
select distinct c.customer_name, c.customer_city
from customer c,depositor d,account a
where c.customer_name=d.customer_name and a.account_number=d.account_number and c.customer_name not in (select customer_name from borrower);
--Not exists
select distinct c.customer_name, c.customer_city
from customer c,depositor d,account a
where c.customer_name=d.customer_name and d.account_number=a.account_number
and not exists (
        select distinct c.customer_name, c.customer_city
        from borrower b
        where c.customer_name=b.customer_name
);

--09
--without with clause
select b.branch_name,sum(a.balance)
from branch b,account a
where b.branch_name=a.branch_name and a.balance>(select avg(balance) from account)
group by b.branch_name;
--with with clause
WITH temp(avgBa) as
    (SELECT avg(balance)
    from account)
        SELECT b.branch_name,sum(a.balance)
        FROM branch b, account a,temp t
        WHERE b.branch_name=a.branch_name and a.balance>t.avgBa
        group by b.branch_name;

--10
--without with clause
select b.branch_name,sum(l.amount)
from branch b,loan l
where b.branch_name=l.branch_name and l.amount<(select avg(amount) from loan)
group by b.branch_name;
--with with clause
WITH temp(avg_amount) as
    (SELECT avg(amount)
    from loan)
        SELECT b.branch_name,sum(l.amount)
        FROM branch b, loan l,temp t
        WHERE b.branch_name=l.branch_name and l.amount<t.avg_amount
        group by b.branch_name;

--Additional tasks
--1
select id,name from student 
where dept_name in ('Physics','Comp. Sci.');

--2
select id,name from student 
where dept_name not in ('Physics','Comp. Sci.');

--3
select course_id from course 
where dept_name='Comp. Sci.' and course_id in (
select s.course_id from section s);

--4
select course_id from course 
where dept_name='Comp. Sci.' and course_id not in (
select s.course_id from section s);

--5
select course_id from course 
where dept_name='Comp. Sci.' and exists (
select s.course_id from section s where course.course_id=s.course_id );

--6
select course_id from course 
where dept_name='Comp. Sci.' and not exists (
select t.course_id from takes t where course.course_id=t.course_id );

--7
select i.id,i.name from instructor i 
where not exists(
select course_id from course
where dept_name='History'
minus
select t.course_id from teaches t where i.id=t.id);

--8
select id,name
from instructor
where id in(
select id
from teaches
where semester='Spring');

--9
select s.id,s.name,s.dept_name,d.building
from student s,department d
where s.dept_name=d.dept_name and s.tot_cred>=all(select tot_cred from student);

--10
select s.id,s.name,s.dept_name,d.building
from student s,department d
where s.dept_name=d.dept_name and s.tot_cred<=all(select tot_cred from student);

--11
select name
from student 
where tot_cred>some(select tot_cred from student where dept_name='Comp. Sci.');

--12
select course_id,title
from course
where course_id in (
select course_id
from (select t.course_id,count(semester) as sem_count
from teaches t,course c
where t.course_id=c.course_id
group by t.course_id)
WHERE sem_count>1);

--13
select id from (
select id,count(*) as num_courses
from takes t
group  by (id) )
where num_courses = 2;

--14
select department.dept_name,count(course.course_id)
from department left join course on department.dept_name=course.dept_name
group by department.dept_name;

