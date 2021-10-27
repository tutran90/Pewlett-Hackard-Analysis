--Deliverable 1 
--1.Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name
FROM Employees

--2. Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date
FROM Titles

--3.Create a new table using the INTO clause.

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles 
FROM  Employees as e, Titles as t 

--4.Join both tables on the primary key.
SELECT e.emp_no,
     e.first_name, 
     e.last_name,
     e.birth_date,
     t.title,
     t.from_date,
     t.to_date
INTO retirement_titles 
FROM  Employees as e
LEFT JOIN Titles as t ON e.emp_no = t.emp_no

--SELECT count(emp_no)
-- FROM retirement_titles
-- count of 443308

--5.Filter the data on the birth_date column to retrieve the 
--employees who were born between 1952 and 1955. 
--Then, order by the employee number.

SELECT e.emp_no,
     e.first_name, 
     e.last_name,
     e.birth_date,
     t.title,
     t.from_date,
     t.to_date
INTO retirement_titles 
FROM  Employees as e
LEFT JOIN Titles as t ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
--new count of 133776; after filtering out the birthdates 

--Dropping the birth_date column 
ALTER TABLE retirement_titles 
DROP birth_date 

--HELP** GROUP BY is not working 
SELECT r.emp_no, r.first_name, r.last_name, r.title,
	r.from_date, 
	r.to_date
FROM retirement_titles as r
GROUP BY r.emp_no

--6.Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

--#8-14 -- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, 
first_name, 
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;
--count of 90398

--#15-20 
--Write another query in the Employee_Database_challenge.sql file to retrieve 
--the number of employees by their most recent job title who are about to retire.

-- Write another query in the Employee_Database_challenge.sql file to 
--retrieve the number of employees by their most recent job title who are about to retire.

SELECT count(title)
FROM unique_titles
--90398

-- Create a Retiring Titles table. 
--Group the table by title, then sort the count column in descending order. 
-- retrieve the number of titles from the unique titles table
-- Create a retiring titles table to hold the required information 
-- group the table by title, then sort the column in descendng order 

SELECT COUNT(title), title 
INTO TABLE retiring_titles
FROM unique_titles
GROUP By title
ORDER BY COUNT(title) DESC;

