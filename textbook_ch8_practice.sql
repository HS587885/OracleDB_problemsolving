select rnum, first_name, salary from 
(select first_name, salary, rownum as rnum from
(select first_name, salary from employees order by salary desc));


create table manager as select employee_id, first_name, job_id, salary, hire_date
from employees
where 1=2;




insert into manager
(employee_id, first_name, job_id, salary, hire_date)
select employee_id, first_name, job_id, salary, hire_date
from employees
where job_id like '%MAN';

select * from manager;

drop table manager;


create table emps as select * from employees;

Alter table emps

add (constraint emps_emp_id_pk primary key(employee_id),
constraint emps_manager_id_fk FOREIGN KEY (manager_id)
references emps(employee_id)
);


select employee_id, first_name, salary from emps
where employee_id = 103;

-- 다음 구문은 103 사원의 급여를 10% 인상합니다
update emps
set salary = salary * 1.1
where employee_id = 103;


select employee_id, first_name, salary
from emps
where employee_id = 103;


-- commit


-- 서브쿼리로  다중 열 갱신

select employee_id, first_name, job_id, salary, manager_id
from emps
where employee_id in(108, 109);


update emps
set (job_id, salary, manager_id) = (select job_id, salary, manager_id
from emps where employee_id = 108)
where employee_id = 109;



create table emps as select * from employees;

Alter table emps
    ADD(constraint emps_emp_id_pk primary key (employee_id),
    constraint emps_manager_id_fk foreign key (manager_id)
    references emps(employee_id));
    
delete from emps
where employee_id =104;


create table emps_it as select * from employees where 1=2;
insert into emps_it
(employee_id,	first_name,	last_name,	email,	hire_date,	job_id)
values
(105,	'David',	'Kim',	'DAVIDKIM',	'06/MAR/04',	'IT_PROG');



MERGE	INTO	emps_it	a
USING	(SELECT	*	FROM	employees	WHERE	job_id='IT_PROG')	b
ON	(a.employee_id	=	b.employee_id)
    WHEN	MATCHED	THEN
    	UPDATE	SET

a.phone_number	=	b.phone_number,
 				a.hire_date	=	b.hire_date,
 				a.job_id	=	b.job_id,
 				a.salary	=	b.salary,
 				a.commission_pct	=	b.commission_pct,
 				a.manager_id	=	b.manager_id,
 				a.department_id	=	b.department_id
 WHEN	NOT	MATCHED	THEN
 		INSERT	VALUES	
 			(b.employee_id,	b.first_name,	b.last_name,	b.email,	
            b.phone_number,	b.hire_date,	b.job_id,	b.salary,	
            b.commission_pct,	b.manager_id,	b.department_id);
            
 -- Multiple INSERT           
INSERT	ALL	
 		INTO	emp1	
 				VALUES	(300,	'Kildong',	'Hong',	'KHONG',	'011.624.7902',	
 						TO_DATE('2015-05-11',	'YYYY-MM-DD'),	'IT_PROG',	6000,	
 						null,	100,	90)
 		INTO	emp2	
 				VALUES	(400,	'Kilseo',	'Hong',	'KSHONG',	'011.3402.7902',	
 						TO_DATE('2015-06-20',	'YYYY-MM-DD'),	'IT_PROG',	5500,	
						null,	100,	90)
 		SELECT	*	FROM	dual;

-- UNCONDITIONAL INSERT ALL

create table emp_salary as 
select employee_id, first_name, salary, commission_pct
from employees
where 1 =2;


create table emp_hire_date as 
select employee_id, first_name, hire_date, department_id
from employees
where 1=2;


-------------------------------------------

CREATE	TABLE	emp_10	AS	SELECT	*	FROM	employees	WHERE	1=2;
CREATE	TABLE	emp_20	AS	SELECT	*	FROM	employees	WHERE	1=2;


INSERT	ALL
		WHEN	department_id=10	THEN
				INTO	emp_10	VALUES
 								(employee_id,	first_name,	last_name,	email,	phone_number,	
 									hire_date,	job_id,	salary,	commission_pct,	manager_id,	
									department_id)
 		WHEN	department_id=20	THEN 				INTO	emp_20	VALUES								(employee_id,	first_name,	last_name,	email,	phone_number,
hire_date,	job_id,	salary,	commission_pct,	manager_id,	
								department_id)
		SELECT	*	FROM	employees;
        
        
select * from emp_10;
select * from emp_20;



-- conditional insert

CREATE	TABLE	emp_sal5000	AS	
 SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
 CREATE	TABLE	emp_sal10000	AS	
 SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
 CREATE	TABLE	emp_sal15000	AS	
 SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
 CREATE	TABLE	emp_sal20000	AS	
 SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;
 CREATE	TABLE	emp_sal25000	AS	
 SELECT	employee_id,	first_name,	salary	FROM	employees	WHERE	1=2;



 INSERT	FIRST
 		WHEN	salary	<=	5000	THEN
 				INTO	emp_sal5000	VALUES	(employee_id,	first_name,	salary)
 		WHEN	salary	<=	10000	THEN
 				INTO	emp_sal10000	VALUES	(employee_id,	first_name,	salary)
 		WHEN	salary	<=	15000	THEN
 				INTO	emp_sal15000	VALUES	(employee_id,	first_name,	salary)
 		WHEN	salary	<=	20000	THEN
 				INTO	emp_sal20000	VALUES	(employee_id,	first_name,	salary)
 		WHEN	salary	<=	25000	THEN
 				INTO	emp_sal25000	VALUES	(employee_id,	first_name,	salary)
 		SELECT	employee_id,	first_name,	salary	FROM	employees;
        
        
SELECT	COUNT(*) FROM	emp_sal5000;
SELECT	COUNT(*) FROM	emp_sal10000;
SELECT	COUNT(*) FROM	emp_sal15000;
SELECT	COUNT(*) FROM	emp_sal20000;
SELECT	COUNT(*) FROM	emp_sal25000;


-- pivoting inset