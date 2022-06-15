--서브쿼리
--Nancy의 급여보다 많은 급여를 받는 사원의 이름과 급여를 출력하는 문제
select first_name, salary from employees 
where salary > (select salary from employees where first_name = 'Nancy');

-- 단일행 서브쿼리
-- 103번 사원의 직무와 같은 사원의 이름과 직무, 그리고 입사일을 출력
select first_name, job_id, hire_date
from employees
where job_id = (select job_id from employees where employee_id =103);


-- 다중행 서브쿼리
-- 다음 구문은 David보다 많은 급여를 받는 사원의 이름과 급여를 출력
select first_name, salary
from employees
where salary > any (select salary from employees where first_name ='David');

-- 다음 구문은 David와 같은 부서에 근무하는 사원의 이름(First Name)과 부서번호, 직무를 출력
select first_name, department_id, job_id from employees
where department_id IN (select department_id from employees where first_name ='David');


-- 다음 구문은 EXISTS 연산자의 예입니다. EXISTS 연산자는 서브쿼리만 가능합니다. 다음 구문은 부서의 매니저에 속하는 사원의 이름과 부서아이디, 직무아이디를 출력
select first_name, department_id, job_id
from employees e
where exists (select * from departments d where d.manager_id = e.employee_id);

-- 상호연관 서브쿼리
-- 다음 구문은 자신이 속한 부서의 평균보다 많은 급여를 받는 사원의 이름과 급여를 출력
select first_name, salary from employees a
where salary > (select avg(salary) from employees b where b.department_id = a.department_id);

-- 스칼라 서브쿼리
-- 다음 구문은 모든 사원의 이름과 부서의 이름을 출력
select first_name, (select department_name from departments d
where d.department_id = e.department_id) department_name
from employees e
order by first_name;

-- 다음 구문은 모든 사원의 이름과 부서의 이름을 출력하기 위해 조인을 사용
select first_name, department_name
from employees e
join departments d on (e.department_id= d.department_id)
order by first_name;


--인라인 뷰
-- 다음 구문은 급여를 가장 많이 받는 사람부터 상위 10명의 사원 이름과 급여를 출력
select row_number, first_name, salary
from (select first_name, salary, row_number() over (order by salary DESC) AS row_number
from employees)
where row_number between 1 and 10;

-- 3중 쿼리
-- 급여가 가장 많은 사원부터 적은 순으로 상위 10명의 급여를 출력
select rownum, first_name, salary
from (select first_name, salary
from employees
order by salary desc)
where rownum between 1 and 10;

-- 급여액 기준 상위 11위부터 20위까지 정보를 출력(rownum은 반드시 첫 번쨰 행부터 조회가 이루어져야함)
select rnum, first_name, salary 
from (select first_name, salary, rownum as rnum
from (select first_name, salary from employees order by salary desc))
where rnum between 11 and 20;

-- 버젼2
select row_number, first_name, salary 
from (select first_name, salary, row_number()over (order by salary desc) as row_number
from employees)
where row_number between 11 and 20;

--계층형 쿼리
--다음 구문은 모든 사원의 매니저-사원 관계도 출력
select	employee_id,
lpad('	',3*(level-1))||first_name||'	'||last_name,
level
from employees
START WITH manager_id IS NULL
connect by prior employee_id = manager_id;

-- 매니저-사원 관계도에서 같은 매니저를 갖는 사원들을 이름순
select	EMPLOYEE_ID,
LPAD('	',3*(level-1))||FIRST_NAME||'	'||LAST_NAME,
level
from EMPLOYEES
START WITH manager_id IS NULL
connect by prior EMPLOYEE_ID = MANAGER_ID
order siblings by first_name;