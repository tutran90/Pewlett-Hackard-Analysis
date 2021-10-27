# **Pewlett Hackard Analysis**

## Overview of the Analysis

 The purpose of this analysis was to utilize PostgreSQL to pull in mutliple tables of data to determine who in Pewlett Hackard was retiring and who was eligible to be a mentor to new staff members. 

## Results 

Retiring Employees: 
- The initial count prior to filtering the table revealed that there was a total of 443,308 employees. The following code was used to obtain the information above:

>>SELECT e.emp_no,
     e.first_name, 
     e.last_name,
     e.birth_date,
     t.title,
     t.from_date,
     t.to_date
INTO retirement_titles 
FROM  Employees as e
LEFT JOIN Titles as t ON e.emp_no = t.emp_no

- After filtering the retirement_titles table to show those that were eligible for retiring, it revealed that 133,776 employees met the criteria (based on birth dates between 01/01/1952 - 12/31/1955). The following filter was used to find the information mentioned above: 

>>SELECT e.emp_no,
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

- Since many employees may have held different positions, another filter was performed on the unique_titles table to remove the duplicate values. By doing this it showed that there was only 90,398 employees that met the criteria to retire. 
The following code was used to find this information:
>>SELECT DISTINCT ON (emp_no) emp_no, 
first_name, 
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

Employees Eligible for the Mentorship Program:
- As with any company, people tend to move up in a company and hold different positions. Some may also leave the company after a short time. 

- In order to find who was still in the company and met the criteria to be a mentor another filter was performed to show who was still active. This revealed that only 1549 employees were eligible to be a mentor. The following code was used to find this information:
>>SELECT 
     DISTINCT ON (e.emp_no) e.emp_no, 
     e.first_name,
     e.last_name,
     e.birth_date,
     d.from_date,
     d.to_date,
     t.title
INTO mentorship_eligibilty
FROM employees as e
LEFT JOIN dept_emp as d on e.emp_no = d.emp_no
LEFT JOIN titles as t on e.emp_no = t.emp_no
WHERE d.to_date = '9999-01-01' AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

## Summary

The inital set of data showed that there were 443,308 employees. This number was not unique and had many duplications. When filtering through the data for unique values it showed that 90,398 were eligible to retire. What we do know is the number of active employees that are nearing retirement is 1,549. We see a huge gap because there may have been a huge percent that retired early or left the company prior to this analysis. What would help make this mentorship program more successful, is determining how long before retirement for the 1,549 employees, then determining how long a mentorship program would be to maximize the time that valued employee has with the company.