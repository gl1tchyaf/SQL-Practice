--1.
--(a)
create table instructor_2019160036(
id number,
name varchar2(20),
dept_name varchar2(10),
salary number
);

--(b)
create table course_2019160036(
course_id varchar(10),
title varchar2(50),
dept_name varchar2(10),
credits number
);

--2.
--(a)
insert into instructor_2019160036 values (10101,'Srinivasam','Comp. Sci.',65000);
insert into instructor_2019160036 values (12121,'Wu','Finance',90000);
insert into instructor_2019160036 values (15151,'Mozart','Music',40000);
insert into instructor_2019160036 values (22222,'Einstein','Physics',95000);
insert into instructor_2019160036 values (32343,'El Said','History',60000);
insert into instructor_2019160036 values (33456,'Gold','Physics',87000);
insert into instructor_2019160036 values (45565,'Katz','Comp. Sci.',75000);
insert into instructor_2019160036 values (58583,'Califieri','History',62000);
insert into instructor_2019160036 values (76543,'Singh','Finance',80000);
insert into instructor_2019160036 values (76766,'Crick','Biology',72000);
insert into instructor_2019160036 values (83821,'Brandt','Comp. Sci.',92000);
insert into instructor_2019160036 values (98345,'Kim','Elec. Eng.',80000);

--(b)
insert into course_2019160036 values ('BIO-101','Intro. to Biology','Biology',4);
insert into course_2019160036 values ('BIO-301','Genetics','Biology',4);
insert into course_2019160036 values ('BIO-399','Compuitational Biology','Biology',3);
insert into course_2019160036 values ('CS-101','Intro. to Computer Science','Comp. Sci.',4);
insert into course_2019160036 values ('CS-190','Game Design','Comp. Sci.',4);
insert into course_2019160036 values ('CS-315','Robotics','Comp. Sci.',3);
insert into course_2019160036 values ('CS-347','Database System Concepts','Comp. Sci.',3);
insert into course_2019160036 values ('EE-181','Intro. to Digital Systems','Elec. Eng.',3);
insert into course_2019160036 values ('FIN-201','Investment Banking','Finance',3);
insert into course_2019160036 values ('HIS-351','World History','History',3);
insert into course_2019160036 values ('MU-199','Music Video Production','Music',3);
insert into course_2019160036 values ('PHY-101','Physical Principles','Physics',4);

--3.
--(i)
select name from instructor_2019160036;
--(ii)
select course_id,title from course_2019160036;
--(iii)
select name,dept_name from instructor_2019160036 where id=22222;
--(iv)
select title,credits from course_2019160036 where dept_name='Comp. Sci.';
--(v)
select name,dept_name from instructor_2019160036 where salary>70000;
--(vi)
select title from course_2019160036 where credits !< 4;
--(vii)
select name,dept_name from instructor_2019160036 where salary >= 80000 and salary <=100000;
--(viii)
select title,credits from course_2019160036 where dept_name != 'Comp. Sci.';
--(ix)
select * from instructor_2019160036;
--(x)
select * from course_2019160036 where dept_name= 'Biology' and credits !=4;