--1 
select * from employees where email like '%LEE%';
--2
select first_name, salary , job_id from employees where manager_id = 103;
--3
select * from employees where (job_id ='SA_MAN' and department_id = 80) or (manager_id = 100 and department_id = 20);
--4
select replace(phone_number, '.', '-') from employees;
--5 
select rpad(first_name||' '||last_name, 20, '*') as full_name, 
to_char(coalesce(salary + salary * commission_pct, salary), '$099,999.00') as salary, 
to_char(hire_date, 'yyyy-mm-dd') as hire_date,round(SYSDATE - hire_date) as work_day 
from employees
where upper(job_id) = 'IT_PROG' and salary >= 5000
order by full_name;
--6 
select rpad(first_name||' '||last_name, 20, '*') as full_name,
to_char(coalesce(salary + salary * commission_pct, salary), '$099,999.00') as salary, 
to_char(hire_date,'yyyy"년"-mm"월"-dd"일"') as hire_date,
trunc(months_between(sysdate,	hire_date))	AS	month
from employees
where upper(job_id) = 'IT_PROG' and salary > 5000
order by full_name;
-- 7
select rpad(first_name||' '||last_name, 17, '*') as full_name, to_char(coalesce(salary + salary *commission_pct, salary), '$99,999.00') as salary
from employees
where department_id = 80 and salary > 10000;
--8
select first_name as "Name",  
    decode(TRUNC(TRUNC(months_between(sysdate, hire_date)/12)/5), 
    1, '5년차',
    2, '10년차',
    3, '15년차',
        '기타')
    AS "근무년수"
from employees
where department_id = 60;
-- 9
select to_char(hire_date + 1000, 'yyyy-mm-dd') as "1000일쨰되는날" 
from employees
where first_name = 'Lex';
--10
select first_name, to_char(hire_date, 'yyyy-mm-dd') as hire_date
from employees
where to_char(hire_date, 'mm') = 05;
--11
select first_name, salary, to_char(hire_date, 'yyyy"년 입사"') as year, 
to_char(hire_date, 'day') as day,
case when to_number(to_char(hire_date,  'yyyy')) >= 2005 then to_char(salary + salary * 0.05, '$999,999')
when to_number(to_char(hire_date,  'yyyy')) >= 2010 then to_char(salary + salary * 0.1, '$999,999')
else to_char(salary, '$999,999')
end as increasing_salary
from employees;

--12
select first_name, salary, to_char(hire_date, 'yyyy"년 입사"') as year,
case when to_number(to_char(hire_date, 'yyyy')) = 2005 then (salary + salary * 0.1)
when to_number(to_char(hire_date, 'yyyy')) = 2010 then (salary + salary * 0.5)
else salary
end as increasing_salry2
from employees;
--13

select country_id, coalesce(state_province,country_id) as state from locations;