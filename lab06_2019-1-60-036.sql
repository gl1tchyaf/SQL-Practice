--Student ID: 2019-1-60-036
--Student Name: Hasib Ar Rafiul Fahim
--Lab 06 Task Online
--01
create view Senior_Student_info as
    select id,name,dept_name,tot_cred
    from student
    where tot_cred>60;
	
--02
create view Senior_CSE as
    select id,name,tot_cred
    from Senior_Student_info
    where dept_name = 'Comp. Sci.';
	
--03
select * 
from Senior_CSE
where tot_cred>100;

--04
/*
Yes, senior_student_info is an updatable view as it satisfy all the conditions. It is a simple table. 
Select clause has no distinct or aggrigiate functions
From contains only one table
No having or group by is found
The column that is not included on my view can be set to null
*/

--05
/*
If I insert the values, it will be updated into the main table which is student
*/

--06
create view Student_count as
		select dept_name,count(name) as num_stud
		from student
		group by dept_name;
		
--07
/*
No, student_count is not updeatable.
Because an updateable view must not contain 
any group by statements.
*/