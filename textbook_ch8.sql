-- 1. EMPLOYEES 테이블에 있는 데이터를 열 단위로 나눠 저장하고 싶습니다. 사원번호, 사원이름, 급여, 보너스율을 저장하기 위한 구조와 데이터를 갖는 테이블을 
--EMP_SALARY_INFO이라는 이름으로 생성하세요. 그리고 사원번호, 사원이름, 입사일, 부서번호를 저장하기 위한 구조와 데이터를 갖는 테이블을 EMP_HIREDATE_INFO라
--는 이름으로 생성하세요.

create table emp_salary_info as select employee_id, first_name, salary, commission_pct
from employees;

create table emp_hiredate_info as select employee_id, first_name, hire_date, department_id
from employees;

-- 2. EMPLOYEES 테이블에 다음 데이터를 추가하세요. 사원번호 : 1030
-- 성 : KilDong
-- 이름 : Hong
-- 이메일 : HONGKD
-- 전화번호 : 010-1234-5678
-- 입사일 : 2018/03/20
-- 직무아이디 : IT_PROG
-- 급여 : 6000
-- 보너스율 : 0.2
-- 매니저번호 : 103
-- 부서번호 : 60

INSERT	INTO	employees
VALUES (1030, 'KilDong', 'Hong',	'HONGKD',	'010-1234-5678','18/MAR/20',	'IT_PROG',	6000,	0.2,	103,	60);

-- 3. 1030번 사원의 급여를 10% 인상시키세요.

update employees set salary = salary * 1.1
where employee_id = 1030;

-- 4. 1030번 사원의 정보를 삭제하세요
delete from employees where employee_id = 1030;

--5. 사원테이블을 이용하여, 2001년부터 2003년까지의 연도에 근무한 사원들의 사원아이디, 이름, 입사일, 연도를 출력하세요. 조건1) 각 연도에 해당하는 테이블을 생성하세요. 
--속성은 사원아이디, 이름, 입사일, 연도입니다. 적절한 데이터 크기를 지정하세요. 테이블이름은 ‘emp_yr_연도’ 형식으로 
--생성하세요. 조건2) 연도 열은 입사일에서 연도만 출력하세요. 열 이름은 ‘yr’이고, 4자리 문자로 표현하세요. 조건3) INSERT ALL 구문으로 작성하세요.

-- 1)
create table emp_yr_2001 (
employee_id NUMBER(6, 0),
first_name VARCHAR2(20),
hire_date DATE,
yr VARCHAR2(20));

create table emp_yr_2002 (
employee_id NUMBER(6, 0),
first_name VARCHAR2(20),
hire_date DATE,
yr VARCHAR2(20));

create table emp_yr_2003 (
employee_id NUMBER(6, 0),
first_name VARCHAR2(20),
hire_date DATE,
yr VARCHAR2(20));

-- 2)
insert all
when	TO_CHAR(HIRE_DATE,	'RRRR')	=	'2001' then into	EMP_YR_2001	values	(EMPLOYEE_ID,	FIRST_NAME,	HIRE_DATE,	YR)
when	TO_CHAR(HIRE_DATE,	'RRRR')	=	'2002' then	into	EMP_YR_2002	values	(EMPLOYEE_ID,	FIRST_NAME,	HIRE_DATE,	YR)
when	TO_CHAR(HIRE_DATE,	'RRRR')	=	'2003' then	into	EMP_YR_2003	values	(EMPLOYEE_ID,	FIRST_NAME,	HIRE_DATE,	YR)
select	EMPLOYEE_ID,	FIRST_NAME,	HIRE_DATE,	
TO_CHAR(HIRE_DATE,'RRRR')	as	YR	from	EMPLOYEES;

select * from emp_yr_2001
union 
select * from emp_yr_2002
union
select * from emp_yr_2003;

--6. 문제 5의의 조건3을 비교연산자를 사용하여, INSERT FIRST 구문으로 작성하세요.
insert first
when hire_date <= '01/DEC/31' then
into	emp_yr_2001	values	(employee_id,	first_name,	hire_date,	yr)
when hire_date <= '02/DEC/31' then
into	emp_yr_2002	values	(employee_id,	first_name,	hire_date,	yr)
when hire_date <= '03/DEC/31' then
into	emp_yr_2003	values	(employee_id,	first_name,	hire_date,	yr);
select	employee_id,	first_name,	hire_date,	
to_char(hire_date,'RRRR')	as	yr	from	employees;



--7. Employees 테이블의 사원들 정보를 아래의 두 테이블에 나눠 저장하세요. 

--조건1) emp_personal_info 테이블에는 employee_id, first_name, last_name, email, 
--phone_number가 저장되도록 하세요. 

--조건2) emp_office_info 테이블에는 employee_id, hire_date, salary, commission_pct, 
--manager_id, department_id가 저장되도록 하세요.

create table emp_personal_info as select employee_id, first_name, last_name, email, 
phone_number from employees where 1=2;

create table emp_office_info as select employee_id, hire_date, salary, commission_pct, 
manager_id, department_id from employees where 1=2;

insert all
into emp_personal_info
values (employee_id,	first_name,	last_name,	email,	phone_number)
into	emp_office_info
values	(employee_id,	hire_date,	salary,	commission_pct,	manager_id,	department_id)
select	*	from	employees;

select * from emp_personal_info;
select * from emp_office_info;

--8. Employees 테이블의 사원들 정보를 아래의 두 테이블에 나눠 저장하세요. 
--조건1) 보너스가 있는 사원들의 정보는 emp_comm 테이블에 저장하세요. 
--조건2) 보너스가 없는 사원들의 정보는 emp_nocomm 테이블에 저장하세요

CREATE	TABLE	emp_comm	AS	SELECT	*	FROM	employees	WHERE	1=2;
CREATE	TABLE	emp_nocomm	AS	SELECT	*	FROM	employees	WHERE	1=2;

insert all
when commission_pct is null then
into emp_comm
values 	(employee_id,	first_name,	last_name,	email, 	phone_number,	hire_date,	job_id,	salary,	commission_pct,	manager_id,	department_id)

when commission_pct is not null then
into emp_nocomm 
values 	(employee_id,	first_name,	last_name,	email, 	phone_number,	hire_date,	job_id,	salary,	commission_pct,	manager_id,	department_id)
select * from employees;

select * from emp_comm;
select * from emp_nocomm;