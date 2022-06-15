--1. 새로운 사용자를 생성하세요. 

--조건1) c##foo와 c##bar 총 2명의 사용자를 생성하세요. 비밀번호는 a12345입니다.

conn /as sysdba;
create user c##foo IDENTIFIED By a12345;
create user c##bar IDENTIFIED By a12345;

--2. c##manager 역할(ROLE)을 생성하세요. 

--조건1) c##manager 역할에 테이블과 뷰를 생성하기 위한 권한을 부여하세요. 
--조건2) c##manager 역할을 c##foo와 c##bar 사용자에게 부여하세요.

conn / as sysdba;
create role c##manager;
grant create table, create view to c##manager;
grant c##manager to c##foo, c##bar;


--3. 사용자 c##foo를 통해 hr 사용자의 사원(EMPLOYEES) 테이블의 총 데이터 수를 구하세요. 

--조건1) 사용자 c##foo와 c##bar에게 로그인 권한을 부여하세요. 
--조건2) 사원 테이블을 질의하기 위해 사용자 c##foo에게 권한을 부여하세요. 
--조건3) 사용자 c##foo로 접속하여 c##bar에게도 사원 테이블에 대한 SELECT 권한을 부여하고, 사원의 수를 조회하세요

grant create session to c##foo, c##bar;
conn hr/hr;
grant select on employees to c##foo with grant option;
conn c#foo/a12345;
select count(*) from hr.employees; --사용자가 조회
grant select on hr.employees to c##bar;
conn c##var.a12345;
select count(*) from hr.employees; -- c##bar 사용자가 조회


--4. 사용자 c##foo와 c##bar에게 부여했던 hr 사용자의 권한을 회수하고 c##foo, c##bar 사용자를 삭제하세요.

conn hr/hr;
revoke select on employees from c##foo;
conn /as sysdba;
drop user c##foo;
drop user c##bar;