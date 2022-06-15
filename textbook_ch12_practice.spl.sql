-- 1. 뷰에 관한 정보는 USER_VIEWS를 통해 확인 가능
select * from user_views;
-- 2. 현재 사용자에게 주어진 롤(ROLE)을 출력
select * from user_role_privs;
-- 3. 현재 사용자에게 주어진 권한을 출력
select * from user_sys_privs;
--4. view 생성하기
create view emp_view_dept60
as select employee_id, first_name, last_name, job_id, salary
FROM employees
where department_id = 60;

--5 DESCRIBE 명령어를 사용하여 구조를 디스플레이 할 수 있음

DESC emp_view_dept60;

--6 view를 통해 데이터를 조회
select * from emp_view_dept60;
-- 7 view 삭제
drop view emp_view_dept60;

--8 view 생성 서브쿼리에서 별칭 사용하기
create view emp_dept60_salary
as select
employee_id as empno, first_name || ' '|| last_name as name,
salary as monthly_salary
from employees
where department_id = 60;

drop view emp_dept60_salary;
--  9 복합 view 생성

create	view	emp_view
as	select	
e.employee_id	as	id,	
e.first_name	as	name,	
d.department_name	as	department,	
j.job_title	as	job
from	employees	e
left	join	departments	d	on	e.department_id	=	d.department_id
join	jobs	j	on	e.job_id	=	j.job_id;

select	*	from emp_view;
select	*	from emp_details_view;
