 SELECT	NVL(TO_CHAR(hire_date,	'RRRR'), DECODE(GROUPING(TO_CHAR(hire_date,	'RRRR')),	1,	'합계')) AS	입사년도,
		NVL(TO_CHAR(hire_date,	'MM'),	DECODE(GROUPING(TO_CHAR(hire_date,	'MM')),	1,	'소계'))	AS	입사월,
		GROUPING_ID(TO_CHAR(hire_date,	'RRRR'),TO_CHAR(hire_date,	'MM'))	AS	GID,
        ROUND(AVG(salary),0)	AS	급여평균, COUNT(*)	AS	사원수 
FROM	employees
        GROUP	BY	CUBE(TO_CHAR(hire_date,	'RRRR'),	TO_CHAR(hire_date,	'MM'))
        ORDER	BY	입사년도,	입사월;