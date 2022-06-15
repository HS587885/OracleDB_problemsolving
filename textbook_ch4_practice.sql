select avg(salary), max(salary), Min(salary), sum(salary) from employees where job_id like 'SA%';
select department_id, round(avg(salary), 2) from employees group by department_id having AVG(salary)	>	8000;
SELECT job_id, AVG(salary) PAYROLL from employees where job_id not like 'SA%' GROUP	BY	job_id HAVING AVG(salary)	>	8000 ORDER	BY	AVG(salary);

-- group by 
select department_id, job_id, round(avg(salary), 2) from employees group by grouping sets (department_id, job_id) order by department_id, job_id;
select department_id, job_id, round(avg(salary), 2) from employees group by grouping sets (department_id, job_id) order by department_id, job_id;
SELECT	department_id,	job_id,	ROUND(AVG(salary),	2) FROM	employees GROUP	BY	GROUPING	SETS (department_id,	job_id) ORDER	BY	department_id,	job_id;
select department_id, job_id, manager_id, ROUND(AVG(salary), 2) as avg_sal from employees  group by  GROUPING SETS ((department_id,	job_id),(job_id,	manager_id)) order by department_id, job_id, manager_id
SELECT department_id, job_id, ROUND(AVG(salary),2),	COUNT(*) FROM employees GROUP BY	department_id,	job_id ORDER	BY	department_id,	job_id;
SELECT department_id,	job_id,	ROUND(AVG(salary),2),	COUNT(*) FROM employees GROUP	BY	ROLLUP(department_id,	job_id)ORDER	BY	department_id,	job_id;
SELECT department_id,	job_id,	ROUND(AVG(salary),2),	COUNT(*) FROM employees GROUP	BY	CUBE(department_id,	job_id)	 ORDER	BY	department_id,	job_id

select department_id, job_id, round(avg(salary), 2) from employees group by grouping sets (department_id, job_id)

