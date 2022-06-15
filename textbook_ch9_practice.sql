create table chaos as select * from employees;

delete from chaos where department_id = 10;

savepoint delete_10;

delete from emps where department_id = 20;

savepoint delete_20;

delete from emps where department_id = 30;

rollback to savepoint delete_20;

drop table chaos;