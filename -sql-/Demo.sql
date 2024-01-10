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
















