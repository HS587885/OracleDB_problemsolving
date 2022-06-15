select last_name, LOWER(last_name), INITCAP(last_name), UPPER(last_name) from employees;
select last_name, LOWER(last_name), INITCAP(last_name), UPPER(last_name) from employees where last_name = 'Austin';
select first_name, length(first_name), instr(first_name, 'a') from employees;
select first_name, substr(first_name, 1, 3), concat(first_name, last_name) from employees;
select LTRIM('JavaSpeciallist', 'Java') from dual;
select LTRIM('  JavaSpecialIst') from dual;
select TRIM(' JavaSpecialist ') from dual;
select  RTRIM('JavaSpecialist  ', 'list') from dual;
select replace('JavaSpecialist', 'Java', 'BigData') from dual;
select replace('Java Specialist', ' ', '') from dual;
select	translate('javaspecialist',	'abcdefghijklmnopqrstuvwxyz',	'defghijklmnopqrstuvwxyzabc') from	dual;
select rpad(substr(first_name, 1, 3), length(first_name), '*') as name, lpad(salary, 10, '*') as salary from employees where lower(job_id) = 'it_prog';

-- 정규표현식
--CREATE	TABLE	test_regexp	(col1 VARCHAR2(10));
--INSERT	INTO	test_regexp	VALUES('ABCDE01234');
-- INSERT	INTO	test_regexp	VALUES('01234ABCDE');
-- INSERT	INTO	test_regexp	VALUES('abcde01234');
-- INSERT	INTO	test_regexp	VALUES('01234abcde');
-- INSERT	INTO	test_regexp	VALUES('1-234-5678');
-- INSERT	INTO	test_regexp	VALUES('234-567890');
-- 
 select * from test_regexp where regexp_like(col1, '[0-9][a-z]');
 -- 다음 구문은 XXX-XXXX형식을 끝나는 행을 찾습니다. X는 숫자입니다
 select * from test_regexp where regexp_like(col1, '[[:digit:]]{3}-[[:digit:]]{4}$');
 -- 앞의 구문에서 0-9는 [:digit:]로 대체할 수 있습니다.
 select * from test_regexp where regexp_like(col1, '[[:digit:]]{3}-[[:digit:]]{4}$');
 
select trunc(45.923,2), trunc(45.923), trunc(45.923,-1) from dual;
select first_name, to_char(hire_date, 'MM/YY') as HiredMonth from employees where first_name = 'Steven';

--drop table test_regexp;
--Null 치환 함수 NVL, NVL2, coalesce

select  first_name, salary + salary * NVL(commission_pct, 0) as ann_sal from employees;

select  first_name, nvl2(commission_pct , salary + (salary * commission_pct), salary) ann_sal from employees;

select first_name, coalesce(salary + (salary * commission_pct), salary) as ann_sal from employees;


-- Case 문
SELECT	job_id,	salary,
CASE	job_id	WHEN	'IT_PROG' THEN	salary*1.10
                WHEN	'FI_MGR' THEN	salary*1.15
                WHEN	'FI_ACCOUNT'	THEN	salary*1.20
                ELSE	salary
                END	AS	REVISED_SALARY
FROM employees;




SELECT	
 		TO_CHAR(LAST_DAY(TO_DATE('01',	'MM')),	'dd')	AS	"1",
 		TO_CHAR(LAST_DAY(TO_DATE('02',	'MM')),	'dd')	AS	"2",
 		TO_CHAR(LAST_DAY(TO_DATE('03',	'MM')),	'dd')	AS	"3",
		TO_CHAR(LAST_DAY(TO_DATE('04',	'MM')),	'dd')	AS	"4", 		
        TO_CHAR(LAST_DAY(TO_DATE('05',	'MM')),	'dd')	AS	"5",
		TO_CHAR(LAST_DAY(TO_DATE('06',	'MM')),	'dd')	AS	"6",
		TO_CHAR(LAST_DAY(TO_DATE('07',	'MM')),	'dd')	AS	"7",
		TO_CHAR(LAST_DAY(TO_DATE('08',	'MM')),	'dd')	AS	"8",
		TO_CHAR(LAST_DAY(TO_DATE('09',	'MM')),	'dd')	AS	"9",
 		TO_CHAR(LAST_DAY(TO_DATE('10',	'MM')),	'dd')	AS	"10",
 		TO_CHAR(LAST_DAY(TO_DATE('11',	'MM')),	'dd')	AS	"11",
 		TO_CHAR(LAST_DAY(TO_DATE('12',	'MM')),	'dd')	AS	"12"
FROM	dual;
-- 기타변환함수 
-- LNNVL
SELECT	first_name,	COALESCE(salary*commission_pct,	0)	AS	bonus
FROM	employees
WHERE	COALESCE(salary*commission_pct,	0)	<	650;

SELECT	first_name,	COALESCE(salary*commission_pct,	0)	AS	bonus
FROM employees
WHERE	LNNVL(salary*commission_pct	>=	650);


-- DECODE

SELECT	job_id,	salary,
		DECODE(job_id,	'IT_PROG',	salary*1.10,
						'FI_MGR',	salary*1.15,
                        'FI_ACCOUNT', salary*1.20, salary) AS	revised_salary
FROM employees;

-- CASE
SELECT	employee_id,	salary,
 				CASE	WHEN	salary	<	5000	THEN	salary*1.2
 						WHEN	salary	<	10000	THEN	salary*1.10
 						WHEN	salary	<	15000	THEN	salary*1.05
 						ELSE	salary
 				END	AS	revised_salary
 FROM	employees;

-- UNION, UNION_ALL
SELECT	employee_id,	first_name
FROM	employees
WHERE	hire_date	LIKE	'04%'
UNION
SELECT	employee_id,	first_name
FROM employees
WHERE department_id=20;



SELECT	employee_id,	first_name
FROM	employees
WHERE	hire_date	LIKE	'04%'
UNION		ALL
SELECT	employee_id,	first_name
FROM employees
WHERE department_id=20;

-- INTERSECT
SELECT	employee_id,	first_name
FROM	employees
WHERE	hire_date	LIKE	'04%'
INTERSECT
SELECT	employee_id,	first_name
FROM employees
WHERE department_id=20;


-- MINUS

SELECT	employee_id,	first_name
FROM	employees
WHERE	hire_date	LIKE	'04%'
MINUS
SELECT	employee_id,	first_name
FROM employees
WHERE department_id=20;
