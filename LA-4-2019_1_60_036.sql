-- Student ID: 2019-1-60-036
-- Student Name: Hasib Ar Rafiul Fahim
-- Lab Assignment - 4


-- Creating Table
create table Company_Hasib(
	companyId varchar2(5),
	companyName varchar2(20),
	yearlyIncome number,
	profit number,
	primary key(companyId));
	
create table Branch_Hasib(
	branchId varchar2(5),
	branchName varchar2(20),
	branchAddr varchar2(20),
	dateOpened date,
	companyId varchar2(5),
	primary key(branchId));
	
create table Section_Hasib(
	sectionId varchar2(5),
	sectionName varchar2(20),
	sectionHead varchar2(5),
	branchId varchar2(5),
	primary key(sectionId));
	
	
create table Employee_Hasib(
	empId varchar2(5),
	empName varchar2(20),
	gender varchar2(10),
	dateOfBirth date,
	bloodGroup varchar2(10),
	annualSalary number,
	sectionId varchar2 (5),
	primary key(empId));
	
--Altering table
ALTER TABLE Section_Hasib ADD FOREIGN KEY (SectionHead) REFERENCES Employee_Hasib (empId);
ALTER TABLE Branch_Hasib ADD FOREIGN KEY (companyId) REFERENCES Company_Hasib (companyId);
ALTER TABLE Section_Hasib ADD foreign key(branchId) references Branch_Hasib(branchId);
ALTER TABLE Employee_Hasib ADD foreign key(sectionId) references Section_Hasib(sectionId);


--Inserting rows
Insert into Company_Hasib Values('C-001','ABC LIMITED',100000,10000);
Insert into Company_Hasib Values('C-002','AAC CORP',200000,20000);
Insert into Branch_Hasib Values('Br1','Utt','Uttara','23-Jan-2021','C-001');
Insert into Branch_Hasib Values('Br2','tt','Tongi','25-Mar-2019','C-001');
Insert into Branch_Hasib Values('Br3','BD','Badda','18-Jan-2018','C-002');
Insert into Branch_Hasib Values('Br4','RP','Rampura','28-Mar-2020','C-002');
Insert into Section_Hasib Values('SC1','HR',NULL,'Br1');
Insert into Section_Hasib Values('SC2','Ktt',NULL,'Br2');
Insert into Section_Hasib Values('SC3','Ptt',NULL,'Br3');
Insert into Section_Hasib Values('SC4','Rtt',NULL,'Br4');
Insert into Employee_Hasib Values('Em101','Tabib','Male','17-Mar-1981','AB-',50000,'SC1');
Insert into Employee_Hasib Values('Em102','Rashik','Male','14-Mar-1997','B-',200000,'SC2');
Insert into Employee_Hasib Values('Em103','MRS. Chowdhuri','Female','21-Mar-1999','AB+',50000,'SC3');
Insert into Employee_Hasib Values('Em104','Nidhi','Female','17-Mar-1999','A+',70000,'SC4');

--Update rows
UPDATE Section_Hasib
SET SectionHead = 'Em101'
Where sectionId= 'SC1';
UPDATE Section_Hasib
SET SectionHead = 'Em102'
Where sectionId= 'SC2';
UPDATE Section_Hasib
SET SectionHead = 'Em103'
Where sectionId= 'SC3';
UPDATE Section_Hasib
SET SectionHead = 'Em104'
Where sectionId= 'SC4';

commit;


-- Single Table Queries
--01
select empId,empName
from Employee_Hasib
where gender= 'Female';
/*
Output:
Em103 MRS.Chowdhuri
Em104 Nidhi
*/

--02
select *
from Company_Hasib
where profit>=10;
/*
Output:
aa101 ABC LIMITED 1000000 10000
aa102 AAC CORP 2000000 20000
*/

--03
select branchId,branchName
from Branch_Hasib
where (dateOpened>='01-Jan-2021') and companyId='C-001';
/*
Output:
Br1 Utt
*/
--04(Find the company with yearlyIncome more then 100000 and also profit is less then 25000)
select companyName
from Company_Hasib
where yearlyIncome>100000 and profit <25000;
/*
Output:
AAC CORP
*/

--MultiTable Queries
--01
select empId,empName
from Employee_Hasib e,Section_Hasib s
where e.empId=s.sectionHead and sectionName='HR';
/*
Output:
Em101 Tabib
*/

--02
select branchId,branchName
from Branch_Hasib b,Company_Hasib c
where b.companyId=c.companyId and companyName='ABC LIMITED';
/*
Output:
br1 utt
br2 tt
*/
--03
select empId,empName
from Employee_Hasib e,Section_Hasib s
where e.empId=s.sectionHead;
/*
Output:
Em101 Tabib
Em102 Rashik
Em103 MRS. Chowdhuri
Em104 Nidhi
*/

--04
select empId,empName
from Employee_Hasib e,Section_Hasib s,Branch_Hasib b,Company_Hasib c
where e.empId=s.sectionHead and s.branchId=b.branchId and b.companyId=c.companyId and companyName='ABC LIMITED';
/*
Output:
Em101 Tabib
Em102 Rashik
*/

--05 (Find the branch name from a given employee name)
select branchName
from Branch_Hasib b, Section_Hasib s, Employee_Hasib e
where b.branchId=s.branchId and s.sectionHead=e.empId and empName='Rashik';
/*
Output:
tt
*/

--set operation
--01
select branchId,branchName
from Branch_Hasib
where dateOpened>='01-Jan-2020'
Union
select branchId,branchName
from Branch_Hasib b,Company_Hasib c
where b.companyId=c.companyId and companyName='ABC LIMITED';
/*
Output:
Br1 Utt
Br2 tt
Br4 RP
*/

--02
select sectionId,sectionName
from Section_Hasib
Minus
select sectionId,sectionName
from Section_Hasib
where SectionHead is not NULL;
/*
Output:
Empty, because in my database, all the section have section heads
*/

--03
select empId,empName
from Employee_Hasib e,Section_Hasib s
where e.empId=s.sectionHead and sectionName = 'HR';
intersect
SELECT empId,empName
FROM Employee_Hasib
where TRUNC(((SYSDATE) - TO_DATE(dateOfBirth))/ 365.25)>30;
/*
Output:
EMP101 Tabib
*/

--04(Find the company name whose yearlyIncome is greater then or equal to 100000 and whose branches were Opened after 2019)
select companyName
from company_hasib
where yearlyIncome>=100000
intersect
select companyName
from company_hasib c,branch_hasib b
where c.companyId=b.companyId and dateOpened<='31-Dec-2018';
/*
Output:
AAC CORP
*/

--Use of LIKE, DISTINCT, BETWEEN and Arithmetic Operations in SELECT clause
--01
select empId,empName
from Employee_Hasib
where empName like '%Chowdhuri%';
/*
Output:
Em103 MRS. Chowdhuri
*/

--02
select empId,empName
from Employee_Hasib
where annualSalary between 120000 and 240000;
/*
Output:
Em102 Rashik
*/

--03
select distinct sectionName
from Section_Hasib;
/*
Output:
Rtt
Ktt
Stt
Ptt
*/

--04
select empName,empId,cast(annualSalary/12 as decimal(10,2)) as monthlySalary
from Employee_Hasib;
/*
Output:
Tabib  Emp101 4166.67
Rashik Emp102 16666.67
MRS. Chowdhuri Emp103 4166.67
Nidhi Em104 5833.33
*/

--05(Find the employee name having 'shi' in their name)
select empName
from Employee_Hasib
where empName LIKE '%shi%';
/*
Output:
Rashik
*/

--Aggregate Queries
--01
select max(annualSalary)
from Employee_Hasib;
/*
Output:
200000
*/

--02
select (max(annualSalary)-min(annualSalary)) as diff
from Employee_Hasib;
/*
Output:
150000
*/

--03
select avg(annualSalary) as Avarage
from Employee_Hasib e,Section_Hasib s,Branch_Hasib b,Company_Hasib c
where e.empId=s.sectionHead and s.branchId=b.branchId and b.companyId=c.companyId and companyName='ABC LIMITED' and sectionName='HR';
/*
Output:
50000
*/

--04
select companyName,avg(annualSalary) as avarageSalary
from Employee_Hasib e,Section_Hasib s,Branch_Hasib b,Company_Hasib c
where e.empId=s.sectionHead and s.branchId=b.branchId and b.companyId=c.companyId
group by companyName order by avarageSalary desc;
/*
Output:
ABC LIMITED 125000
AAC CORP 60000
*/

--05
select branchName,companyName,avg(annualSalary) as avarageSalary
from Employee_Hasib e,Section_Hasib s,Branch_Hasib b,Company_Hasib c
where e.empId=s.sectionHead and s.branchId=b.branchId and b.companyId=c.companyId
group by branchName,companyName;
/*
Output:
BD AAC CORP 50000
Utt ABC LIMITED 50000
RP AAC CORP 70000
tt ABC LIMITED 200000
*/

--06
select companyName,avg(annualSalary) as avarageSalary
from Employee_Hasib e,Section_Hasib s,Branch_Hasib b,Company_Hasib c
where e.empId=s.sectionHead and s.branchId=b.branchId and b.companyId=c.companyId 
group by companyName
having count(empId)>=3;
/*
Output:
No output, because my database has one employee per company which is less then 3
*/

--07(Find the sum of the salary of the employees of each Company but the sum must be greater then 100000)
select companyName,sum(annualsalary) as sumOfSalary
from Employee_Hasib e,Section_Hasib s,Branch_Hasib b,Company_Hasib c
where e.empId=s.sectionHead and s.branchId=b.branchId and b.companyId=c.companyId 
group by companyName
having sum(e.annualsalary)>100000;
/*
Output:
ABC LIMITED 250000
AAC CORP 120000
*/