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


--DATA ANALYSIS
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees 
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-1-1' AND '1986-12-31'
ORDER BY hire_date;

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name 
FROM dept_manager 
JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
ORDER BY departments.dept_name;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp 
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
ORDER BY departments.dept_name;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY last_name;

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp 
ON employees.emp_no = dept_emp.emp_no
JOIN departments 
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees 
JOIN dept_emp 
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'
ORDER BY departments.dept_name;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, count(emp_no) AS number_employees_with_same_last_name
FROM employees
GROUP BY last_name
ORDER BY number_employees_with_same_last_name DESC;