show databases;

CREATE DATABASE BOOTCAMP_EXERCISE;

USE BOOTCAMP_EXERCISE1;

CREATE TABLE LOCATIONS (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12),
    country_id CHAR(2)
    FOREIGN KEY (
);

CREATE TABLE COUNTRIES (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT
);

CREATE TABLE REGIONS (
    region_id INT,
    region_name VARCHAR(25)
);
    
    
CREATE TABLE DEPARTMENTS (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    manager_id INT,
    location_id INT
);

CREATE TABLE EMPLOYEES (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary INT,
    commission_pct INT,
    manager_id INT,
    department_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE JOB_HISTORY (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
values (1000, '1297 Via Cola di Rie', 989, 'Roma', '', 'IT');

select * from locations;
 
insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
values (1100, '93091 Calle della Te', 10934, 'Venice', '', 'IT');

insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
values (1200, '2017 Shinjuku-ku', 1689, 'Tokyo', 'Tokyo JP', '');

insert into locations (location_id, street_address, postal_code, city, state_province, country_id)
values (1400, '2014 Jabberwocky Rd', 26192, 'Southlake', 'Texas', 'US');

insert into countries (country_id, country_name, region_id)
values ('DE', 'Germany', 1);

insert into countries (country_id, country_name, region_id)
values ('IT', 'Italy', 1);

insert into countries (country_id, country_name, region_id)
values ('JP', 'Japan', 3);

insert into countries (country_id, country_name, region_id)
values ('US', 'United States', 2);

insert into departments (department_id, department_name, manager_id,location_id)
values (10, 'Administration', 200, 1100);

insert into departments (department_id, department_name, manager_id,location_id)
values (20, 'Marketing', 201, 1200);

insert into departments (department_id, department_name, manager_id,location_id)
values (30, 'Purchasing', 202, 1400);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id, department_id)
values (100, 'Steven', 'King', 'SKING', 515-1234567, 1987-06-17, 'ST_CLERK', 24000.00, 0.00, 109, 10);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id, department_id)
values (101, 'Neena','Kochhar', 'NKOCHHAR', 5151234568, 1987-06-18, 'MK_REP', 17000.00, 0.00, 103, 20);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id, department_id)
values (102, 'Lex', 'De Haan', 'LDEHAAN', 515-1234569, 1987-06-19, 'IT_PROG', 17000.00, 0.00, 108, 30);

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary,commission_pct, manager_id, department_id)
values (103, 'Alexander', 'Hunold', 'AHUNOLD', 590-4234567, 1987-06-20, 'MK_REP', 9000.00, 0.00, 105, 20);

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
values (102, 1992-01-13, 1987-07-24, 'IT_PROG', 20);

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
values (101, 1989-09-21, 1993-10-27, 'MK_REP', 10);

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
values (101, 1993-10-28, 1997-03-15, 'MK_REP', 30);

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
values (100, 1996-02-17, 1999-12-19, 'ST_CLERK', 30);

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
values (103, 1998-03-24, 1999-12-31, 'MK_REP', 20);


drop table employees;
drop table departments;
drop table countries;
drop table locations;

delete from locations;

















 
