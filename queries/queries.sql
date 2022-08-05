SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--Find employees born in 1952.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--Find employees born in 1953.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--Find employees born in 1953.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--Find employees born in 1955.
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--Retirement eligibility.
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')

--Export retirement_info
SELECT first_name, last_name
INTO retirement_info
    ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments As d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no,
    first_name,
last_name,
    gender
	INTO emps_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


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
	 
SELECT* FROM emp_info;

FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

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
SELECT * FROM manager_info

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

-- List of employees from sales
SELECT  d.dept_name,
        ri.emp_no,
        ri.last_name,
        ri.first_name
INTO sales_info
FROM retirement_info AS ri
     INNER JOIN salaries AS s
        ON (ri.emp_no = s.emp_no)
     INNER JOIN dept_emp AS de
                   ON (s.emp_no = de.emp_no)
     INNER JOIN departments as d
                ON (de.dept_no= d.dept_no)
                WHERE dept_name= 'Sales';

SELECT * FROM sales_info;

-- List of employees from sales and development
SELECT  d.dept_name,
        ri.emp_no,
        ri.last_name,
        ri.first_name
INTO sales_dev_info
FROM retirement_info AS ri
     INNER JOIN salaries AS s
        ON (ri.emp_no = s.emp_no)
     INNER JOIN dept_emp AS de
                   ON (s.emp_no = de.emp_no)
     INNER JOIN departments as d
                ON (de.dept_no= d.dept_no)
                WHERE dept_name IN ('Sales', 'Development');
SELECT * FROM sales_dev_info

--Create a retirement titles table.
SELECT  e.emp_no,
		e.first_name,
        e.last_name,
		t.title,
		t.from_date,
		t.to_date		
INTO retirement_titles
FROM employees AS e
     INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
 	   rt.first_name,
	   rt.last_name,
	   rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;

-- Retrieve the number of employees to retire
SELECT COUNT(ut.emp_no),
		ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   t.title
INTO mentorship_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON e.emp_no = de.emp_no
	INNER JOIN titles AS t
		ON e.emp_no = t.emp_no
WHERE (t.to_date = ('9999-01-01'))
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;

SELECT COUNT(emp_no)
FROM unique_titles;
-- Returns 72458

SELECT COUNT(emp_no)
FROM mentorship_eligibility;
-- Returns 1549



