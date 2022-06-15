--1. 직무별 급여 평균과 사원의 급여 차이를 구하는 뷰를 생성하세요. 

--조건1) 뷰 이름은 SAL_GAP_VIEW_BY_JOB로 하세요. 

--조건2) 뷰의 열은 사원이름과 직무아이디, 직무별 급여 평균과 사원급여의 차이입니다. 

--조건3) 직무별 급여 평균은 직무테이블의 최대 급여와 최소 급여의 평균을 의미합니다.

create	or	replace	view  sal_gap_view_by_job
as	select
e.first_name as	name, a.job_id,
round(a.avg_sal	- e.salary,	0) as job_sal_gap
from employees e
join (select job_id, (max_salary + min_salary)/2 as	avg_sal
from jobs) a
on	a.job_id = e.job_id;

select * from sal_gap_view_by_job;

--2. 모든 사원의 아이디와 이름 그리고 부서 이름과 직무 이름을 출력할 수 있는 뷰를 생성
--하세요.

create	or	replace	view	emp_view
as	select	
e.employee_id	as	id,	
e.first_name	as	name,	
d.department_name	as	department,	
j.job_title	as	job
from	employees	e
left	join	departments	d	on	e.department_id	=	d.department_id
join	jobs	j	on	e.job_id	=	j.job_id;


select * from emp_view;