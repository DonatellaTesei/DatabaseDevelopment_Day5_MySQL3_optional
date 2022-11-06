/* 1. Report:
How many rows do we have in each table in the employees database? */
#working on each table separately
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM salaries;
SELECT COUNT(*) FROM titles;
#output 9, 331603, 24, 300024, 2844047, 443308

#alternatively, use the following code line which returns a table as an output
SELECT table_name, table_rows 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'employees';
#output 
table_name table_rows
departments    9
dept_emp  331143
dept_manager  24
employees 299512
salaries 2838354
titles    442308

/* 2.Report:
How many employees with the first name "Mark" do we have in our company? */
SELECT COUNT(first_name) FROM employees WHERE first_name = 'Mark';
#output 230

/* 3.Report:
How many employees with the first name "Eric" and the last name beginning with "A" do we have in our company? */
SELECT COUNT(first_name) FROM employees WHERE first_name = 'Mark' AND last_name LIKE 'A%';
#output 12

SELECT first_name, last_name FROM employees WHERE first_name = 'Mark' AND last_name LIKE 'A%';
#will show the employees names and surnames

/* 4.Report:  HILFE!!!
How many employees do we have that are working for us since 1985 and who are they? */
SELECT first_name, last_name, emp_no        #output first_name, last_name, emp_no total results 13237                    
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE from_date LIKE '1985%' AND to_date LIKE '9999-01-01%')

SELECT COUNT(*) #output 13237
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE from_date LIKE '1985%' AND to_date LIKE '9999-01-01%')


#the commands below will return info and the No. of employees hired between 185 and 2022
SELECT COUNT(*) FROM employees 
WHERE year(hire_date) BETWEEN 1985 AND 2022;
SELECT last_name, hire_date FROM employees 
WHERE year(hire_date) BETWEEN 1985 AND 2022;
#output 300024 and list of names (in two different tables), corresponds to total No. employees

SELECT last_name, COUNT(last_name) AS EmployeesCount FROM employees WHERE year(hire_date) = 1985 GROUP BY emp_no;
#output list of names (here shown partially) and count (not in a table)
last_name EmployeesCount
Simmel      1
Peac        1
Terkki      1
Herbst      1

/* 5.Report:
How many employees got hired from 1990 until 1997 and who are they? */
SELECT COUNT(*) FROM employees 
WHERE year(hire_date) BETWEEN 1990 AND 1997;
SELECT last_name, hire_date FROM employees 
WHERE year(hire_date) BETWEEN 1990 AND 1997;
#output 129545 and list of names (in two separate tables))

#alternatively
SELECT last_name, hire_date FROM employees 
WHERE year(hire_date) >= 1990 AND year(hire_date) <= 1997;

/* 6. Report:
How many employees have salaries higher than EUR 70 000,00 and who are they? */ 
SELECT COUNT(*) FROM employees WHERE emp_no IN (SELECT emp_no FROM salaries WHERE salary > 70000);
#output 135631
SELECT first_name, last_name, emp_no FROM employees WHERE emp_no IN (SELECT emp_no FROM salaries WHERE salary > 70000);


/* 7. Report: #3 info from 2 tables 
How many employees do we have in the Research Department, who are working for us since 1992 and who are they? */
SELECT COUNT(*)
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no = 'd008' AND from_date LIKE '1992%' AND to_date LIKE '9999-01-01%')
#output 924 
SELECT first_name, last_name, emp_no 
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no = 'd008' AND from_date LIKE '1992%' AND to_date LIKE '9999-01-01%')
#output table with name, surnames and emp_no, 924 results

# HILFE!!!!!!!!
# TIP: You can use the CURRENT_DATE() FUNCTION to access "today's date"
SELECT COUNT(*)
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no = 'd008'AND year(from_date) >= 1992 AND year(to_date) <= CURRENT_DATE())
#output 12750
SELECT first_name, last_name, emp_no 
FROM employees 
WHERE emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no = 'd008'AND year(from_date) >= 1992 AND year(to_date) <= CURRENT_DATE())


/* 8.Report #3 info from 3 tables
How many employees do we have in the Finance Department, who are working for us since 1985 until 
now and who have salaries higher than EUR 75 000,00 - who are they? */


SELECT emp_no FROM dept_emp WHERE year(to_date) LIKE 2000