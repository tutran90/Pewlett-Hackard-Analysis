SELECT COUNT(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
--90398

SELECT COUNT(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'; 
--21209

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- 41380

--Section 7.3.3 Joins in Action 
-- Joining departments and dept_manager tables
--Select: selects only the columns we want to view 
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
-- FROm the talbe to be joined (departments)--will be on the left 
FROM departments
--INNER Join is the type of join with the dept_manager which will be the right table 
INNER JOIN dept_manager
-- ON: indicates where they will join on NOTE: must match 
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
-- this is the left table 
FROM retirement_info
-- we are joining with dept_emp which is the right table 
LEFT JOIN dept_emp 
ON retirement_info.emp_no = dept_emp.emp_no


--Making an alias
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
--saving the data from the query into a new table
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
-- WHERE 9999-01-01 will give us a the current employees 
WHERE de.to_date = ('9999-01-01');

--Section 7.3.4 
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;


--Section 7.3.5 Create Add'l Lists 
--List 1: Employee Info
-- Need: employee number, first name, last name, gender, to_Date, salary
SELECT e.emp_no, 
FROM employees as e 
LEFT JOIN salaries as s 

--filtered employees table ready to join 
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	    AND (de.to_date = '9999-01-01');
		
SELECT *
FROM emp_info;

--List 2: Management 
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
-- commneted out the INTO line--> results show only 5 departments with managers 


--List 3: Department Retirees 
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--results show duplicate managers in different departments 

--Section 7.3.6 Create tailored lsts 
--Create a query that will return only the information relevant to the Sales team
-- Includes emp.no, first_name, last_name, dept_name 
SELECT r.emp_no,
	r.first_name,
	r.last_name,
	de.dept_no,
	d.dept_name
FROM retirement_info as r 
JOIN dept_emp as de 
ON (r.emp_no = de.emp_no)
INNER JOIN departments as d 
ON (de.dept_no = d.dept_no)
WHERE de.dept_no = 'd007'
	AND d.dept_name = 'Sales';

--List retiring employees from Sales and Development using the WHERE and OR statment 
	SELECT r.emp_no,
	r.first_name,
	r.last_name,
	de.dept_no,
	d.dept_name
FROM retirement_info as r 
JOIN dept_emp as de 
ON (r.emp_no = de.emp_no)
INNER JOIN departments as d 
ON (de.dept_no = d.dept_no)
WHERE de.dept_no = 'd007' OR 
	de.dept_no = 'd005'
	AND d.dept_name = 'Development' OR 
	d.dept_name ='Sales';
