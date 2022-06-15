--1 John 사원의 이름과 부서이름, 부서위치(city)를 출력하세요.(오라클조인, 안시조인 구문 둘 다 작성하세요)
-- 오라클 조인
select first_name, department_name, city from employees, departments, locations
where departments.manager_id = employees.department_id and departments.location_id = locations.location_id
and first_name = 'John';
-- 안시 조인
select first_name, department_name, city from departments 
left outer join employees on departments.manager_id = employees.department_id
right outer join locations on departments.location_id = locations.location_id
where first_name = 'John' ;


--2 103번 사원의 사원번호, 이름, 급여, 매니저이름, 매니저 부서이름을 출력하세요.(안시조인으로 작성하세요)
select e.employee_id, e.first_name, e.salary, m.first_name, d.department_name
from employees e
join employees m on e.manager_id = m.employee_id
join departments d on m.department_id = d.department_id
where e.employee_id = 103;


--3 90번부서 사원들의 사번, 이름, 급여, 매니저이름, 매니저급여, 매니저부서이름을 출력하세요.(오라클 조인과 안시조인 구문 둘 다 작성하세요)
-- 오라클 조인
select e.employee_id, e.first_name, e.salary, m.first_name as manager_name, m.salary, d.department_name
from employees e, employees m, departments d
where e.manager_id = m.employee_id(+)
and m.department_id = d.department_id(+)
and e.department_id = 90;
-- 안시 조인
select e.employee_id, e.first_name, e.salary, m.first_name as manager_name, m.salary as manager_salary, d.department_name
from employees e
left outer join employees m on e.manager_id = m.employee_id
left outer join departments d on m.department_id = d.department_id
where  e.department_id = 90;
--4  103번사원이 근무하는 도시는?(안시 조인 구문으로 작성하세요)
select e.employee_id, l.city from employees e 
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where e.employee_id = 103;
--5 사원번호가 103인사원의 부서위치(city)와 매니저의 직무이름(job_title)을 출력하세요.(안시 조인 구문으로 작성하세요)
select l.city as "Department Location", j.job_title as "Manager's Job"
from employees e
join departments d on e.department_id=d.department_id
join locations l on	d.location_id=l.location_id
join employees m on	e.manager_id=m.employee_id
join jobs j	on m.job_id=j.job_id
where e.employee_id=103;

--6 사원의 모든 정보를 조회하는 쿼리문을 작성하세요. 사원의 부서번호는 부서이름으로, 직무아이디는 직무이름으로, 매니저아이디는 매니저이름으로 출력하세요
select	e.employee_id,	e.first_name,	e.last_name, e.email,
e.phone_number,	e.hire_date, j.job_title, e.salary, e.commission_pct,	
m.first_name	as	manager_first_name, m.last_name	as	manager_last_name,	
d.department_name	
from employees	e	
left join departments d	on	e.department_id=d.department_id	
join jobs	j	on	e.job_id=j.job_id	
left join	employees	m	on	e.manager_id=m.employee_id
--7 다음 중 오류가 있는 라인은?
-- 2번 라인 employees.first_name이 아니라 e.first_name이 되야함

