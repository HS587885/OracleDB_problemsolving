select first_name||' '||last_name name, hire_date, salary from employees;
select first_name||' '||last_name "Name", salary, salary + 300 from employees;
select first_name, last_name, salary, salary + salary * 0.1 from employees;
select first_name, department_id, commission_pct from employees;
select first_name as 이름, salary as 급여 from employees;
select first_name "Employee Name", salary *12 "Annual Salary" from employees;
select first_name||' '||last_name|| '''s salary is $' || salary as "Employee Details" from employees;
select DISTINCT department_id from employees;
select  rowid, rownum, employee_id, first_name from employees;
select first_name, job_id, department_id from employees where job_id = 'IT_PROG';
select first_name, last_name, hire_date from employees where last_name = 'King';
select first_name, salary, hire_date from employees where salary >= 15000;
select first_name, salary, hire_date from employees where hire_date = '04/JAN/30'; --데이터가 없음 
select first_name, salary, hire_date from employees where first_name = 'Steven';
select first_name, salary from employees where salary between 10000 and 12000;
select first_name, salary from employees where hire_date between '03/JAN/01' and '03/DEC/13';
select first_name, salary, hire_date from employees where first_name between 'A' AND 'Bzzzzzzzz';
select employee_id, first_name, salary, manager_id from employees where manager_id IN(101, 102, 103);
select first_name, last_name, job_id, department_id from employees where job_id in ('IT_PROG','FI_MGR','AD_VP');
select first_name, last_name, job_id, department_id from employees where job_id LIKE 'IT%';
select first_name, hire_date from employees where hire_date like '03%';
select first_name, email from employees where email LIKE '_A%';
select first_name, job_id from employees where job_id like 'SA/_M%' ESCAPE '/'; 
select first_name, manager_id from employees where manager_id is null;
select first_name, manager_id from employees where manager_id is not null;
select first_name, job_id, salary from employees where job_id='IT_PROG'	AND	salary>=5000;
select first_name, job_id, salary from employees WHERE	job_id='IT_PROG' OR	salary>=5000;
select first_name ,hire_date from employees order by hire_date DESC;
select first_name, salary*12 as annsal from employees order by annsal;
--1
select employee_id, first_name, hire_date, salary from employees;
--2
select first_name||' '||last_name as name from employees;
--3
select * from employees where department_id = 50;
--4 
select first_name, department_id, employee_id from employees;
--5
select first_name||' '||last_name as name, salary + 300 as salary from employees;
 --6
 select first_name, salary from employees where salary > 10000;
 --7
 select first_name, commission_pct from employees where commission_pct is not null;
 --8
 select first_name, hire_date from employees where hire_date between '03/JAN/01' and '03/DEC/31/';
 --9
 --10
 --11
 --12
 --13
 --14
 --15