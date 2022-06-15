--1 20번 부서에 근무하는 사원들의 매니저와 매니저가 같은 사원들의 정보를 출력
select employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary
from employees 
where manager_id in (select distinct manager_id from employees where department_id = 20);

--2 가장 많은 급여를 받은 사람의 이름을 출력하세요.
select first_name from employees 
where salary > any (select salary from employees)
fetch first 1 row only;

--3 급여 순으로(내림차순) 3위부터 5위까지 출력하세요.(rownum 이용)
select rnum, first_name, salary from 
(select first_name, salary, rownum as rnum
from (select first_name, salary from employees order by salary desc))
where rnum between 3 and 5;
--4 부서별 부서의 평균이상 급여를 받는 사원의 부서번호, 이름, 급여, 평균급여를 출력
select department_id, first_name, salary, (select round(avg(salary)) from employees b where b.department_id = e.department_id ) as avg_salary
from employees e
where salary >= (select avg(salary) from employees b where b.department_id = e.department_id )
order by department_id;
