/**
 * Employees and company departments
 */
create keyspace if not exists exercise_1
with replication = {
	'class': 'SimpleStrategy',
	'replication_factor': 1
}; 

use exercise_1;

create table if not exists employees(
	email varchar,
	first_name varchar,
	last_name varchar,
	employment_start timestamp,
	salary decimal, 
	dep_name varchar,
	primary key (email)
);

insert into employees(email, first_name, last_name, employment_start, salary, dep_name) values('jkowalski@example.com', 'Jan', 'Kowalski', '2012-01-01', 5000, 'Analiza');
insert into employees(email, first_name, last_name, employment_start, salary, dep_name) values('anowak@example.com', 'Adam', 'Nowak', '2013-04-01', 4000, 'Analiza');
insert into employees(email, first_name, last_name, employment_start, salary, dep_name) values('mkowalska@example.com', 'Magda', 'Kowalska', '2014-05-01', 6000, 'R&D');

select * from employees where email = 'jkowalski@example.com';

create table if not exists departments(
	name_first_letter varchar,
	name varchar,
	description varchar,
	create_date timestamp,
	primary key ((name_first_letter), name)
) with clustering order by (name asc);

insert into departments(name_first_letter, name, create_date) values ('A', 'Analiza', '2012-01-01');
insert into departments(name_first_letter, name, create_date) values ('R', 'R&D', '2013-01-01');

select * from departments;

create table if not exists departments_with_employee_count(
	name_first_letter varchar,
	name varchar,
	employee_count counter,
	primary key((name_first_letter), name)
) with clustering order by (name asc);

update departments_with_employee_count set employee_count = employee_count + 2 where name_first_letter = 'A' and name = 'Analiza';
update departments_with_employee_count set employee_count = employee_count + 1 where name_first_letter = 'R' and name = 'R&D';

select * from departments_with_employee_count;

create table if not exists employees_by_name(
	last_name_first_letter varchar,
	email varchar,
	first_name varchar,
	last_name varchar,
	employment_start timestamp,
	salary decimal, 
	dep_name varchar,
	primary key ((last_name_first_letter), last_name, first_name, email)
) with clustering order by (last_name asc, first_name asc);

insert into employees_by_name(last_name_first_letter, email, first_name, last_name, employment_start, salary, dep_name) values('K', 'jkowalski@example.com', 'Jan', 'Kowalski', '2012-01-01', 5000, 'Analiza');
insert into employees_by_name(last_name_first_letter, email, first_name, last_name, employment_start, salary, dep_name) values('N', 'anowak@example.com', 'Adam', 'Nowak', '2013-04-01', 4000, 'Analiza');
insert into employees_by_name(last_name_first_letter, email, first_name, last_name, employment_start, salary, dep_name) values('K', 'mkowalska@example.com', 'Magda', 'Kowalska', '2014-05-01', 6000, 'R&D');

select * from employees_by_name;

create table if not exists employees_by_salary(
	last_name_first_letter varchar,
	first_name varchar,
	last_name varchar,
	email varchar,
	employment_start timestamp,
	salary decimal, 
	dep_name varchar,
	primary key ((last_name_first_letter), salary, email)
) with clustering order by (salary desc);

insert into employees_by_salary(last_name_first_letter, email, first_name, last_name, employment_start, salary, dep_name) values('K', 'jkowalski@example.com', 'Jan', 'Kowalski', '2012-01-01', 5000, 'Analiza');
insert into employees_by_salary(last_name_first_letter, email, first_name, last_name, employment_start, salary, dep_name) values('N', 'anowak@example.com', 'Adam', 'Nowak', '2013-04-01', 4000, 'Analiza');
insert into employees_by_salary(last_name_first_letter, email, first_name, last_name, employment_start, salary, dep_name) values('K', 'mkowalska@example.com', 'Magda', 'Kowalska', '2014-05-01', 6000, 'R&D');

select * from employees_by_salary;

create table if not exists employees_by_department(
	email varchar,
	first_name varchar,
	last_name varchar,
	employment_start timestamp,
	salary decimal, 
	dep_name varchar,
	primary key ((dep_name), salary, email)
) with clustering order by (salary desc);

insert into employees_by_department(email, first_name, last_name, employment_start, salary, dep_name) values('jkowalski@example.com', 'Jan', 'Kowalski', '2012-01-01', 5000, 'Analiza');
insert into employees_by_department(email, first_name, last_name, employment_start, salary, dep_name) values('anowak@example.com', 'Adam', 'Nowak', '2013-04-01', 4000, 'Analiza');
insert into employees_by_department(email, first_name, last_name, employment_start, salary, dep_name) values('mkowalska@example.com', 'Magda', 'Kowalska', '2014-05-01', 6000, 'R&D');

select * from employees_by_department;

create table if not exists employees_department_history(
	email varchar,
	dep_name varchar,
	assignment_start timestamp,
	assignment_end timestamp,
	assignee varchar,
	primary key((email), assignment_start, dep_name)
) with clustering order by (assignment_start asc, dep_name asc);

create table if not exists department_employees_history(
	dep_name varchar,
	email varchar,
	assignment_start timestamp,
	assignment_end timestamp,
	assignee varchar,
	primary key((dep_name), assignment_start, email)
) with clustering order by (assignment_start asc, email asc);





