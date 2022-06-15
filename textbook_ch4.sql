--1 
select job_id, AVG(salary) as salary from employees group by job_id;
--2
select department_id, count(*) from employees group by department_id;
--3 
select department_id, job_id, count(*) from employees group by department_id, job_id;
--4
select department_id, ROUND(STDDEV(salary), 2) from employees group by department_id;
--5
select department_id, count(*) from employees where department_id >= 4 group by department_id;
--6
select job_id, count(*) from employees where department_id = 50 group by job_id;
--7
select job_id, count(*) from employees where department_id = 50 group by job_id
having count(*) <= 10;
--8
select to_char(hire_date, 'yyyy') as 입사년도, round(AVG(salary),2) as 급여평균, count(*) as 사원수 
from employees group by to_char(hire_date, 'yyyy') order by to_char(hire_date, 'yyyy');

--9 
select to_char(hire_date, 'yyyy') as 입사년도, to_char(hire_date, 'MM') as 입사월, 
round(avg(salary), 2) as 급여평균, count(*)as 사원수
from employees
group by rollup(to_char(hire_date, 'yyyy'), to_char(hire_date, 'MM'))
order by 입사년도, 입사월;
-- 10
select 
decode(grouping(department_id), 1, '소계',
to_char(department_id)) as 부서,
decode(grouping(job_id), 1, '소계', job_id) as 직무,
round(avg(salary),2) as 평균,
count(*) as 사원의수
from employees
group by cube(department_id, job_id)
order by 부서,직무;
-- 11
select	nvl(to_char(hire_date,	'RRRR'),	
decode(grouping(to_char(hire_date,	'RRRR')),	1,	'합계')) as	입사년도,
nvl(to_char(hire_date,	'MM'),	
decode(grouping(to_char(hire_date,	'MM')),	1,	'소계'))	as	입사월,
grouping_id(to_char(hire_date,	'RRRR'),to_char(hire_date,	'MM')) asgid,
round(avg(salary),0)	as	급여평균, count(*)	as	사원수
from employees  group by cube(to_char(hire_date,	'RRRR'),	to_char(hire_date,	'MM')) order	by	입사년도,	입사월;