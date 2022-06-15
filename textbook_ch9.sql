--1. 실습을 위해 EMPLOYEES 테이블의 사본 테이블을 생성하세요. 
--사본 테이블의 이름은 EMP_TEMP입니다.
create table emp_temp as select * from employees;

--2. EMP_TEMP 테이블에서 20번 부서 사원의 정보를 삭제하고 롤백 지점을 생성하세요.
--롤백 지점의 이름은 SVPNT_DEL_20여야 합니다.
delete from emp_temp where department_id = 20;
savepoint SVPNT_DEL_20

--3. 50번부서의 사원의 정보를 삭제하고 롤백 지점을 생성하세요. 
--롤백 지점의 이름은 SVPNT_DEL_50여야 합니다.

delete from emp_temp where department_id = 50;
savepoint SVPNT_DEL_50;

--4. 60번 부서의 사원 정보를 삭제하세요. 
delete from emp_temp where department_id = 60;

--5. 앞의 60번 부서의 사원 정보를 삭제했던 작업을 취소하세요. 
--그 이전 작업은 취소하면 안됩니다.
ROLLBACK	TO	SAVEPOINT	SVPNT_DEL_50;