--1  모든 사원의 부서번호, 이름, 급여, 부서별 급여 순위를 출력하세요. 중복순위 사원이 있으면 차순위는 없습니다. 이 결과에 
--이전 순위 사원의 급여를 추가하여 출력하세요

select department_id, first_name || ' ' || last_name AS full_name, salary,
rank() over (partition by department_id order by salary) sal_dense_rank, 
lag(salary, 1, 0) over (partition by department_id order by salary) as prev_salary,
first_value(salary) over (partition by department_id order by salary rows between 1 preceding and 1 following) as preve_salary2
from employees
order by department_id;


--2 170번 사원의 사원번호 직전 사원의 이름을 출력하세요.
select first_name from employees
where employee_id = (
select pre_id from (select employee_id,
Lag(employee_id, 1, 0) over (order by employee_id) as pre_id from employees
)
where employee_id = 170
);

--3 모든 사원의 급여 정보를 출력하세요. 출력할 때 각 사원이 근무하는 부서의 가장 적은 급여, 그리고 가장 큰 급여, 그리
-- 고 부서에서 급여가 가장 많은 사원과의 급여 차이를 출력하세요.

select employee_id, department_id,
first_value(salary)
over (partition by department_id
order by salary
rows between unbounded preceding and unbounded following) as lower_sal,
last_value(salary)
over (partition by department_id order by salary
rows between unbounded preceding and unbounded following) as higher_sal,
last_value(salary)
over (partition by department_id order by salary
rows between unbounded preceding and unbounded following) as diff_sal
from employees;
