

-- 급여가 큰 사원부터 이름과 급여, 그리고 순위를 출력합니다.
select employee_id, first_name || ' ' || last_name AS full_name, salary,
rank() over(order by salary desc) sal_rank,
dense_rank() over(order by salary desc) sal_dense_rank,
row_number() over(order by salary desc) sal_number
from employees;


--모든 사원의 아이디와 부서번호 그리고 급여정보를 출력합니다. 급여의 크기순으로 정렬하며 급여의 상대적인 위치와 백분율 순위를 출력합니다.
select employee_id, department_id, salary,
cume_dist() over(order by salary desc) sal_cume_dist,
percent_rank() over(order by salary desc) sal_pct_rank
from employees;


-- COMMISSION_PCT 열의 누적분포를 출력
select employee_id, department_id, salary, 
cume_dist() over(order by commission_pct desc) comml_cume_dist,
percent_rank() over(order by commission_pct desc) comm_pct_rank
from employees;

--  IT_PROG인 사원들을 대상으로 부서내 전체 급여에서 본인이 차지하는 비율을 출력합니다. 
select first_name, salary, 
round(ratio_to_report(salary) over(), 4) as salary_ratio
from employees
where job_id='IT_PROG';

-- 다음 두 구문은 각 부서별 급여의 평균을 구합니다. 그런데 첫 번째 구문은 107개(모든 행의 수)의 행이 출력되며, 두 번째 구문은 12개 행이 반환됩니다.
select department_id,
round(avg(salary)  over (partition by department_id), 2)
from employees;
-- 왜냐하면 아래는 중복을 제거하여 하나의 부서 아이디를 보여주지만 위는 파티션을 사용하여 하나하나 보여주기 떄문이다.
select department_id, round(avg(salary), 2) from employees group by department_id;

-- 다음 구문은 부서번호가 50인 사원들을 10구간으로 나눕니다
select employee_id, department_id, salary,
NTILE(10) over(order by salary desc) sal_quart_tile
from employees
where department_id = 50;

-- 모든 사원의 정보를 출력합니다. 사원의 본인 급여 순위에 한 단계 이전 순위 급여와 한 단계 다음 순위 급여를 출력합니다.
select employee_id, 
LAG(salary, 1, 0) over (order by salary) as lower_sal, 
salary,
LEAD(salary, 1, 0) over (order by salary) as higher_sal
from employees
order by salary;

-- FIRST_VALUE를 사용하면 현재의 값보다 적은 값 또는 직전 값을 구할 수 있고, LAST_VALUE를 사용하면 현재의 값보다 큰 값 또는 다음 값을 구할 수 있습니다.
select employee_id,
FIRST_VALUE(salary)
OVER (ORDER	BY	salary	
ROWS	BETWEEN	1	PRECEDING	AND	1	FOLLOWING)	AS	lower_sal,
salary as my_sal,
Last_value(salary)
over (order by salary
ROWS	BETWEEN	1	PRECEDING	AND	1	FOLLOWING)	AS	higher_sal
from employees;

-- SALARY를 독립 변수로 두고 COMMISSION_PCT를 종속 변수로 두었을 때 모든 사원 급여의 평균과 보너스를 받는 사람의 급여 평균을 출력 
select round(avg(salary), 2), regr_avgx(commission_pct, salary)
from employees;
--WHERE		commission_pct	IS	NOT	NULL;

SELECT	
DISTINCT job_id,	
ROUND(REGR_SLOPE(salary,	SYSDATE-hire_date) OVER	(PARTITION	BY	job_id),	2)	"REGR_SLOPE",
ROUND(REGR_INTERCEPT(salary,	SYSDATE-hire_date)	
OVER	(PARTITION	BY	job_id),	2)	"REGR_INTERCEPT",
ROUND(REGR_R2(salary,	SYSDATE-hire_date)
OVER	(PARTITION	BY	job_id),	2)	"REGR_R2"		
FROM	employees
WHERE department_id =80;

--pivot table

--CREATE	TABLE sales_data(
--employee_id	NUMBER(6),
--week_id	NUMBER(2),
--week_day VARCHAR2(10),
--sales	NUMBER(8,2)
-- );

--INSERT	INTO	sales_data	values(1101,	4,	'SALES_MON',	100);
--INSERT	INTO	sales_data	values(1101,	4,	'SALES_TUE',	150);
--INSERT	INTO	sales_data	values(1101,	4,	'SALES_WED',	80);
--INSERT	INTO	sales_data	values(1101,	4,	'SALES_THU',	60);
--INSERT	INTO	sales_data	values(1101,	4,	'SALES_FRI',	120);
--INSERT	INTO	sales_data	values(1102,	5,	'SALES_MON',	300);
--INSERT	INTO	sales_data	values(1102,	5,	'SALES_TUE',	300);
--INSERT	INTO	sales_data	values(1102,	5,	'SALES_WED',	230);
--INSERT	INTO	sales_data	values(1102,	5,	'SALES_THU',	120);
--INSERT	INTO	sales_data	values(1102,	5,	'SALES_FRI',	150);
--COMMIT;
SELECT	*	FROM	sales_data
pivot
(
sum(sales)
for week_day in('SALES_MON' as SALES_MON,
'SALES_TUE' as SALES_TUE,
'SALES_WED' as SALES_WED,
'SALES_THU' as SALES_THU,
'SALES_FRI' as SALES_FRI
))
order by employee_id, week_id;


create view sales_data_view as 
select employee_id, week_day, sales
from sales_data;

SELECT	*	FROM	sales_data_view
pivot
(
sum(sales)
for week_day in('SALES_MON' as SALES_MON,
'SALES_TUE' as SALES_TUE,
'SALES_WED' as SALES_WED,
'SALES_THU' as SALES_THU,
'SALES_FRI' as SALES_FRI
))
order by employee_id;

--unpivot
select employee_id,	week_id,	week_day,	sales
FROM sales
UNPIVOT
(
sales
FOR	week_day
IN(sales_mon,	sales_tue,	sales_wed,	sales_thu,	sales_fri)
);
