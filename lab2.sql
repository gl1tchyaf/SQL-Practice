create table account
   (account_no 	varchar(5),
    balance number not null check (balance>=0),
    primary key(account_no));


create table customer
   (customer_no 	varchar(5),
    customer_name 	varchar2(20) not null,
    customer_city 	varchar2(10),
    primary key(customer_no));


create table depositor
   (account_no varchar(5),
    customer_no varchar(5),
    primary key(account_no, customer_no));


alter table customer add date_of_birth date;


alter table customer drop column date_of_birth;


alter table depositor rename column account_no to a_no;
alter table depositor rename column customer_no to c_no;


alter table depositor add constraint depositor_fk1 foreign key (a_no) references account (account_no);
alter table depositor add constraint depositor_fk2 foreign key (c_no) references customer (customer_no);


insert into account values('A-101',12000);
insert into account values('A-102',6000);
insert into account values('A-103',2500);


insert into customer values('C-101','Alice','Dhaka');
insert into customer values('C-102','Annie','Dhaka');
insert into customer values('C-103','Bob','Chittagong');
insert into customer values('C-104','Charlie','Khulna');


insert into depositor values('A-101','C-101');
insert into depositor values('A-103','C-102');
insert into depositor values('A-103','C-104');
insert into depositor values('A-102','C-103');


select customer_name,customer_city
from customer;


select DISTINCT customer_city
from customer;


select account_no 
from account
where balance>7000;


select customer_no,customer_name
from customer
where customer_city='Khulna';


select customer_no,customer_name
from customer
where customer_city!='Dhaka';


select customer_no,customer_city
from customer c, account a, depositor d
where balance>7000 and a.account_no=d.a_no and c.customer_no=d.c_no;


select customer_no,customer_city
from customer c, account a, depositor d
where balance>7000 and customer_city!='Khulna' and a.account_no=d.a_no and c.customer_no=d.c_no;


select account_no,balance
from depositor d,account a
where a.account_no=d.a_no and c_no='C-102';


select distinct account_no,balance
from customer c, account a, depositor d
where a.account_no=d.a_no and c.customer_no=d.c_no and customer_city='Dhaka' or customer_city='Khulna';



select customer_name
from customer c, account a, depositor d
where a.account_no=d.a_no and c.customer_no=d.c_no and d.a_no=null;