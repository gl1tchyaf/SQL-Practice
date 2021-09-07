--Group Assignment 1

drop table Cab cascade constraints;
drop table Driver cascade constraints;
drop table Rider cascade constraints;
drop table Trip cascade constraints;

create table Cab(
	taxi_id varchar2(5),
	license_number number,
	brand varchar2(20),
	model varchar2(20),
	primary key(taxi_id)
);

create table Driver(
	driver_id varchar2(5),
	driver_name varchar2(20),
	driver_address varchar2(20),
	driver_phone number,
	date_joined date,
	taxi_id varchar2(5),
	primary key(driver_id)
);

create table Rider(
rider_id varchar2(5),
rider_name varchar2(20),
date_joined date,
gender varchar2(1),
rider_dob date,
primary key (rider_id)
);

create table Trip(
trip_id varchar2(5),
rider_id varchar2(5),
driver_id varchar2(5),
trip_date date,
start_location varchar2(20),
dest_location varchar2(20),
amount number
);


insert into cab values('t-001',1234567891,'Toyota','Corola');
insert into cab values('t-002',5367453427,'Mahindra','Scorpio');
insert into cab values('t-003',8462158795,'Volkswagen','Passat');
insert into cab values('t-004',5477896214,'Ford','Mondeo');


insert into Driver values('d-001','Kashem','Dhaka',01798986532,'21-mar-2019','t-001');
insert into Driver values('d-002','Karim','Gazipur',01647123654,'02-jan-2020','t-002');
insert into Driver values('d-003','Salauddin','Narayanganj',01996321547,'10-aug-2018','t-003');
insert into Driver values('d-004','Tabib','Chittagong',01855471305,'17-dec-2017','t-004');


insert into rider values('r-001','Rashik','17-dec-2017','M','25-aug-1998');
insert into rider values('r-002','Sinha','15-feb-2019','M','12-jan-1996');
insert into rider values('r-003','Sakib','16-apr-2020','M','17-mar-2000');
insert into rider values('r-004','Meem','26-feb-2016','F','30-apr-1999');


insert into trip values('t-001','r-001','d-001','03-jan-2020','Dhaka','Cox-bazar',5000);
insert into trip values('t-002','r-002','d-002','13-feb-2020','Dhaka','Rajshahi',7000);
insert into trip values('t-003','r-003','d-003','12-Mar-2021','Shylet','Gazipur',6000);
insert into trip values('t-004','r-004','d-004','03-apr-2021','Dhaka','Feni',2000);


alter table driver add foreign key (taxi_id) references cab(taxi_id);
alter table trip add foreign key (rider_id) references rider(rider_id);
alter table trip add foreign key (driver_id) references driver(driver_id);

commit;

--G. Defining Views:
--01
--create a view without the driver phone number and 
--texi id who is not from Dhaka which is an updatable view
--Conditions: Select clause must not have distinct or aggrigiate functions
--From must contain only one table
--No having or group by must be used
--The column that is not included on my view can be set to null 

create view v1 as
        select driver_id,driver_name,driver_address,date_joined
        from driver
        where driver_address!='Dhaka';


--02
--Show the view
select * from v1;
/*
d-002	Karim	Gazipur	02-JAN-20
d-003	Salauddin	Narayanganj	10-AUG-18
d-004	Tabib	Chittagong	17-DEC-17
*/

--03
--create a view which will show the driver name of trips
--short by ammount in desending order which is a non updatable view
--My quary content multitable quary and order by clause. So this is 
--not an updatable view
create view v2 as
        select d.driver_name,t.amount
        from driver d,trip t
        where d.driver_id=t.driver_id
        order by t.amount desc;
		
--04
--show the view
select * from v2;
/*
Karim	7000
Salauddin	6000
Kashem	5000
Tabib	2000
*/


--H. Authorization
--01
--Creating 3 users
create user user1 identified by user;
create user user2 identified by user;
create user user3 identified by user;
--allowing system level privileges
GRANT RESOURCE, CONNECT, CREATE SESSION, CREATE TABLE,
CREATE VIEW, CREATE ANY TRIGGER, CREATE ANY PROCEDURE, CREATE
SEQUENCE, CREATE SYNONYM, UNLIMITED TABLESPACE TO user1;

GRANT RESOURCE, CONNECT, CREATE SESSION, CREATE TABLE,
CREATE VIEW, CREATE ANY TRIGGER, CREATE ANY PROCEDURE, CREATE
SEQUENCE, CREATE SYNONYM, UNLIMITED TABLESPACE TO user2;

GRANT RESOURCE, CONNECT, CREATE SESSION, CREATE TABLE,
CREATE VIEW, CREATE ANY TRIGGER, CREATE ANY PROCEDURE, CREATE
SEQUENCE, CREATE SYNONYM, UNLIMITED TABLESPACE TO user3;

--02
--grant select and insert option user1 on view v1
grant select, insert on v1 to user1 with grant option;
--grant select  option user3 on view v1 with grant option
grant select on v1 to user3 with grant option;
--from user1, grant select on view v1 to user2
grant select on fahim.v1 to user2;
--from user3, grant select on view v1 to user2
grant select on fahim.v1 to user2;

--content of user_tab_privs of the user who is the owner of the view
/*
USER3	FAHIM	V1	FAHIM	SELECT	YES	NO
USER1	FAHIM	V1	FAHIM	SELECT	YES	NO
USER1	FAHIM	V1	FAHIM	INSERT	YES	NO
USER2	FAHIM	V1	USER3	SELECT	NO	NO
USER2	FAHIM	V1	USER1	SELECT	NO	NO
*/

--content of user_tab_privs of user1
/*
USER1	FAHIM	V1	FAHIM	SELECT	YES	NO
USER1	FAHIM	V1	FAHIM	INSERT	YES	NO
USER2	FAHIM	V1	USER1	SELECT	NO	NO
*/

--content of user_tab_privs of user2
/*
USER2	FAHIM	V1	USER3	SELECT	NO	NO
USER2	FAHIM	V1	USER1	SELECT	NO	NO
*/

--content of user_tab_privs of user3
/*
USER3	FAHIM	V1	FAHIM	SELECT	YES	NO
USER2	FAHIM	V1	USER3	SELECT	NO	NO
*/

--03
--Revoking select permission from user1
revoke select on v1 from user1;
--Revoking select permission from user3
revoke select on v1 from user3;

--content of user_tab_privs of the user who is the owner of the view
/*
USER1	FAHIM	V1	FAHIM	INSERT	YES	NO
*/

--content of user_tab_privs of user1
/*
USER1	FAHIM	V1	FAHIM	INSERT	YES	NO
*/

--content of user_tab_privs of user2
/*
Empty Output
*/

--content of user_tab_privs of user3
/*
Empty Output
*/
--Explaination: 
--After removing select from user 1, user 1 doesnt have select permission
--so user1 can not give select access on v1 to user2
--again select permission on v1 from user3 was revoked. 
--so user2 and user3 now doesnt have any access to view v1 as user3 also provided
--select access to user2