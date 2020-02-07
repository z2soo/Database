-- 치환변수
select *
from emp
where empno = &emp_num;

-- sqlplus에서 실행하여 입력하면 아얘 값이 자동으로 저장됨 

select *
from emp
where empno = &emp_num;

