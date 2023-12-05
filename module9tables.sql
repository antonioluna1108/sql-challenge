-- DATA ENGINEERING
-- Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:
CREATE TABLE titles (
 title_id varchar(10) PRIMARY KEY,
 title varchar(30));

CREATE TABLE employees (
 emp_no varchar(10) PRIMARY KEY,
 emp_title_id varchar(10) REFERENCES titles(title_id),
 birth_date date,
 first_name varchar(50),
 last_name varchar(50),
 sex varchar(1),
 hire_date date);


CREATE TABLE departments (
 dept_no varchar(30) PRIMARY KEY,
 dept_name varchar(30));
 

CREATE TABLE dept_emp (
 emp_no varchar(30) REFERENCES employees(emp_no),
 dept_no varchar(30) REFERENCES departments(dept_no));


CREATE TABLE dept_manager (
 dept_no varchar(30) REFERENCES departments(dept_no),
 emp_no varchar(30));
	
 
CREATE TABLE salaries (
 emp_no varchar(30) REFERENCES employees(emp_no),
 salary int);

--SHOW TABLES

SELECT * FROM titles
SELECT * FROM employees
SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM salaries