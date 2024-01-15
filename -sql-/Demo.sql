show databases;

create database db_bc2311;

use db_bc2311;

CREATE USER 'nataterri'@'localhost' IDENTIFIED BY 'admin1234';

ALTER USER 'nataterri'@'localhost' IDENTIFIED BY 'admin1234';

GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'nataterri'@'localhost'WITH GRANT OPTION;

SHOW VARIABLES LIKE 'validate_password@';

SET GLOBAL validate_password.policy = LOW;

create table customer (
id integer not null,
cust_name varchar(50) not null,
cust_email_addr varchar(30),
cust_phone varchar(50)
);

-- delete all data (without where)
delete from customer;

insert into customer (id, cust_name, cust_email_addr, cust_phone) values (1, 'John Lau', 'johnlau@gmail.com', '12345678');

-- Insert some more records ...
-- Try insert some null values
insert into customer (id, cust_name, cust_email_addr, cust_phone) values (2, 'Sunny Wong', 'sunnywong@gmail.com', '12345678');
insert into customer (id, cust_name, cust_email_addr, cust_phone) values (3, 'Mary Lau', 'marylau@yahoo.com', '1234567890');
insert into customer (id, cust_name, cust_email_addr, cust_phone) values (4, 'Christy Cheng', null, null);

-- where
select * from customer where id = 3;
select * from customer where cust_name = 'John Lau' and cust_phone = '12345678';
select * from customer where (cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com') and cust_email_addr = 'johnlau@gmail.com';

-- where + order by
-- desc (descending order)
-- asc (ascending order)
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by id desc;
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by cust_name asc;
select * from customer where cust_name = 'John Lau' or cust_email_addr = 'sunnywong@gmail.com' order by cust_name; -- asc by default

insert into customer (id, cust_name, cust_email_addr, cust_phone) values (5, 'Sunny Wong', 'sunnywong@gmail.com', '87654321');
select * from customer where cust_name = 'John Lau' or cust_name = 'Sunny Wong' order by cust_name desc, cust_phone asc;
select * from customer where cust_name in ('John Lau','Sunny Wong') order by cust_name desc, cust_phone asc;

-- delete table (where)
insert into customer (id, cust_name, cust_email_addr, cust_phone) values (6, 'Dummy', 'dummy@yahoo.com.hk', 'Dummy');
delete from customer where cust_name = 'Dummy';

-- where -> like
-- % means any character(s) or no character
insert into customer (id, cust_name, cust_email_addr, cust_phone) values (7, 'Tommy Lau.', 'dummy@yahoo.com.hk', '1234');
select * from customer where cust_name like '%Lau'; -- return John Lau, Mary Lau
select * from customer where cust_name like '%Lau%'; -- return John Lau, Mary Lau, Tommy Lau.
select * from customer where cust_name like '%Sunny%'; -- return Sunny Wong, Sunny Wong
select * from customer where cust_email_addr like '%@%' or cust_email_addr is null;
select * from customer;

-- alter table add/ modify/ drop
-- add a new column
alter table customer add join_date date;

-- update
update customer set join_date = str_to_date('1990-01-01', '%Y-%m-%d');
update customer set join_date = str_to_date('1990 01 01', '%Y %m %d');
update customer set join_date = str_to_date('2023 01 01', '%Y %m %d') where id = 2;

-- VARCHAR, INTEGER, DATE, DECIMAL, DATETIME
alter table customer add score decimal(5,2); -- 3 digits for integer, 2 digits for decimal places, -999.99 <= value <= 999.99

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score) 
values (5, 'Sunny Wong', 'sunnywong@yahoo.com.hk', '87654321', str_to_date('1990-01-01','%Y-%m-%d'), 120.56);

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score) 
values (8, 'Sunny Chan', 'sunnychan@yahoo.com.hk', '1234', str_to_date('1990-01-01','%Y-%m-%d'), 120.56);

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score) 
values (9, 'Katie Kwan', 'katie@yahoo.com.hk', '1234', str_to_date('1990-01-01','%Y-%m-%d'), 999.99);

update customer set score = -1000 where id =9; -- error, 1000 is out of range for decimal(5,2)

alter table customer add last_transaction_time datetime;

insert into customer (id, cust_name, cust_email_addr, cust_phone, join_date, score, last_transaction_time) 
values (9, 'Katie Kwan', 'katie@yahoo.com.hk', '1234', str_to_date('1990-01-01','%Y-%m-%d'), 999.99, str_to_date('1990-01-01 20:20:21', '%Y-%m-%d %H:%i:%s'));

-- Some other approaches to insert data
insert into customer
values (10, 'Jason Kwan', 'jason@yahoo.com.hk', '1234', str_to_date('1990-01-01','%Y-%m-%d'), 200.99, str_to_date('1990-01-01 20:20:21', '%Y-%m-%d %H:%i:%s'));

-- error, by default you should provide all column values when you skip the column description
-- insert into customer
-- values (10, 'Jason Kwan', 'jason@yahoo.com.hk', '1234', str_to_date('1990-01-01','%Y-%m-%d'), 200.99);

insert into customer (id, cust_name, join_date, score, last_transaction_time) 
values (11, 'Jenny So', str_to_date('1990-01-01','%Y-%m-%d'), 12.99, str_to_date('1990-01-01 20:20:21', '%Y-%m-%d %H:%i:%s'));

-- where: between and (inclusive)
select * from customer where join_date between str_to_date('2023-01-01','%Y-%m-%d') and str_to_date('2023-12-31','%Y-%m-%d');
select * from customer where join_date >= str_to_date('2023-01-01','%Y-%m-%d') and join_date <= str_to_date('2023-12-31','%Y-%m-%d');

-- where: >, <, >=, <=
-- ifnull() function: Treat null value as another specified value
select * from customer where ifnull(score,100) > 0 and ifnull(score,100) < 1000;
select * from customer where coalesce(score,100) > 0 and coalesce(score,100) < 1000;

-- alter table -> drop column
alter table customer add dummy VARCHAR(10);
alter table customer drop column dummy;

-- alter table -> modify column
-- Extend length of the column
alter table customer modify column cust_email_addr varchar(50); 
-- Shorten the length of the column
-- alter table customer modify column cust_email_addr varchar(10); -- error, existed data's length 

-- Find the customer with score > 100, and showing the id, cust_name, join_date of the result set.
select id, cust_name, join_date from customer where score > 100;

-- IS NULL, IS NOT NULL
select id, score from customer where score is not null;

-- String Function
select upper(c.cust_name) as customer_name_upper_case
, lower(c.cust_name) as customer_name_lower_case
, c.cust_name as customer_name
, length(c.cust_name) as customer_name_length
, substring(c.cust_name,1 ,3) as customer_name_prefix
, concat(c.cust_name, ',email address:', c.cust_email_addr) as customer_info
, replace(c.cust_name, 'Lau', 'Chan') as new_customer_name
, left(c.cust_name, 3) -- retrieve characters from left to right
, right(c.cust_name, 2) -- retrieve characters from right to left
, trim(c.cust_name) -- remove leading and tall spaces
, replace(c.cust_name, ' ','') -- remove all spaces
from customer c;

-- MySQL case-insensitive
select * from customer where cust_name = 'Mary Lau';
select * from customer where cust_name = 'mary lau'; -- still can return, case-insensitive
select * from customer where cust_name COLLATE utf8mb4_bin = 'Mary Lau'; -- case sensitive check in MYSQL

-- Like: %, _
select * from customer where cust_name like '_ohn%'; -- There is only one character before 'o'
select * from customer where cust_name like '_John%'; -- 

-- Math
update customer set score = 12.14 where id = 1;
update customer set score = 12.15 where id = 2;
update customer set score = 12.16 where id = 3;

select c.*
, 1 as one
, 'dummy value' as dummy_column 
, round(c.score, 1) rounded_score
, ceil(c.score) as ceiling_value
, floor(c.score) as ceiling_value
, abs(score) as abs_value
, power(score, 2) as power2_score
, date_add(join_date, interval 3 month) as three_month_after_join_date
, date_add(join_date, interval 3 day) as three_day_after_join_date
, date_add(join_date, interval 3 year) as three_year_after_join_date
, date_sub(join_date, interval 3 day) as three_day_before_join_date
, join_date + interval 1 day -- correct
, join_date - 1 -- wrong syntax in MYSQL
, join_date - interval 1 day -- correct
, datediff('1990-12-31', join_date) as number_of_days_between_joindate_1990_12_31
, datediff(join_date, join_date)
, now() as curr_timestamp
from customer c;

-- CASE
select cust_name, score,
	case
		when score < 20 then 'Fail'
        when score < 100 then 'Pass'
        when score < 1000 then 'Excellent'
        else 'N/A'
	end as grade
from customer;

-- primary key is one of the constraint: not null, unique, index
create table department (
	id integer primary key, -- 1,2,3,4,5,6,7,8,9
    dept_name varchar(50),
    dept_code varchar(10) -- HR, IT
);

create table employee (
	id integer primary key,  -- 1,2,3,4
    staff_id varchar(50) unique,
    staff_name varchar(50),
    hkid varchar(10) unique,
    dept_id integer,
    foreign key (dept_id) references department(id)
);

create table employee_contact_info (
	id integer primary key,  -- 1,2,3,4
    phone varchar(50),
    staff_id varchar(50) unique,
    foreign key (staff_id) references employee(staff_id)
);

insert into employee_contact_info values (1, '12345');

alter table employee add country_id integer;
alter table employee add constraint fk_country_id foreign key (country_id) references country(id);

create table country (
	id integer primary key,
    country_code varchar(2) unique,
    description varchar(50)
);
insert into department values (1, 'Human Resource', 'HR');
insert into department values (2, 'Information Technology', 'IT');

insert into employee values (1, '001', 'John Lau', 'A1234567', 2);
insert into employee values (2, '002', 'Mary Chan', 'A1234568', 1);
-- insert into employee values (3, '003', 'Jenny Wong', 'A1234569', 3); -- error, because dept_id 3 does not exists in table department
insert into employee values (3, '003', 'Sunny Lau', 'A1234598', 2);

-- inner join
select * 
from employee inner join department;

select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code
from employee e inner join department d on e.dept_id = d.id;

select * from employee;
insert into country values (1, 'HK', 'Hong Kong');
insert into country values (2, 'US', 'U.S.');
update employee set country_id = 1;

select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from employee e 
inner join department d on e.dept_id = d.id
inner join country c on e.country_id = c.id
where d.dept_code = 'IT';

-- inner join without key, all records join (Inner join demo in a wrong way)
select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code, c.country_code, c.description
from employee e 
inner join department d
inner join country c;

-- Another approach to perform inner join
select e.id, e.staff_id, e.staff_name, d.dept_name, d.dept_code
from employee e, department d
where e.dept_id = d.id
and d.dept_code = 'IT'
order by e.staff_name desc;

-- Left Join
insert into department values (3, 'Marketing', 'MK');

select d.*, e.*
from department d left join employee e on e.dept_id = d.id;

-- group by
select * from employee;
insert into employee values (4, '005', 'Peter Chan', 'A123456333', 3, 2);

-- count() -> aggregation function
select e.dept_id, count(1) as number_of_employee
from employee e
group by e.dept_id;

select e.*, 1 as one
from employee e;

-- add column year_of_exp 
alter table employee add year_of_exp integer;
select * from employee ;
update employee set year_of_exp = 1 where id = 2;
update employee set year_of_exp = 10 where id = 1;
update employee set year_of_exp = 5 where id = 3;
update employee set year_of_exp = 18 where id = 4;

-- group by: max(year_of_exp)
select e.dept_id, min(year_of_exp), avg(year_of_exp)
from employee e
group by e.dept_id;

-- Find staff_name who has the max year of exp
-- select max(year_of_exp), staff_name from employee
-- Sub query
select *
from employee
where year_of_exp = (select max(year_of_exp) from employee);

-- CTE
with max_year_of_exp as (
	select max(year_of_exp) as max_exp
    from employee
), min_year_of_exp as (
	select min(year_of_exp) as min_exp
    from employee
)
select *
from employee e, max_year_of_exp m
where e.year_of_exp = m.max_exp;

-- group by + join
select e.dept_id, count(1) as number_of_employee
from employee e, department d
where e.dept_id = d.id
and d.dept_code in ('IT', 'MK') -- filter record before group by
group by e.dept_id 
having count(1) > 1 -- filter group after group by
;















