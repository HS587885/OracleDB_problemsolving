--1. 게시판의 게시글 번호를 위한 시퀀스를 생성하세요.

-- 조건1) 시퀀스 이름은 BBS_SEQ여야 합니다. 
-- 조건2) 게시글 번호는 1씩 증가합니다. 
-- 조건3) 시퀀스는 1부터 시작하며 최대값을 설정하지 않습니다. 
-- 조건4) 캐쉬 개수는 20개이며, 사이클은 허용치 않습니다.

create sequence BBS_SEQ
        increment by 1
        start with 1
        cache 20
        nocycle;


--2. 사원의 급여 지급액으로 검색을 하고 싶습니다. 급여 지급액으로 인덱스를 생성하세요.

-- 조건1) 인덱스 이름은 idx_emp_realsal입니다. 
-- 조건2) 급여 지급액 계산식은 SALARY + SALARY * COMMISSION_PCT입니다

CREATE	INDEX	idx_emp_realsal
ON	emps(COALESCE(SALARY + SALARY * COMMISSION_PCT,	salary));
