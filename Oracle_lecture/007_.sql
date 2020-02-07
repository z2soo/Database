-- 00?. 

-----------------------------------------------------------------------------------------------------------------------

-- # 복습

-- join이란?
-- 하나이상의 테이블로부터 동일한 속성의 컬럼값이 일치할때 레코드를 결합해서 검색
-- (테이블의 하나의 레코드가 다른 테이블의 하나의 레코드와 결합)

-- 조인문법 2가지
-- where절에 조인 조건 선언
-- sql 1999 표준 조인 문법 (from절 조인 선언)

-- join 종류
-- 1. equi join(inner join): 조인할 두 테이블에서 동일한 속성의 컬럼값이 일치할때 (=연산자 사용)
-- outer-join: equi join에서 조인할 두 테이블에서 동일한 속성의 컬럼값이 일치할때 레코드를 결합해서 검색 결과를 생성하므로, 
--             조인할 컬럼중 하나가 null인경우는 조인 결과집합에서 레코드가 누락되지 않고 결과집합에 가져오기 위해 수행하는 join
-- cross join(cartesian join): 조인조건이 누락되면 조인할 테이블의 레코드가 전체 레코드에 대해서 한번씩 조인됨
-- natural join: 동일한 컬럼이 존재하는 경우, 이 컬럼값이 동일한 경우에만 조인
--               단, 동일한 컬럼이 두개 이상 존재하는 경우 두 컬럼값이 모두 같은 경우만 조인됨
--               보통은 여러 컬럼 값들이 같은 경우 조인할 때 사용, 하나의 컬럼값만 같은 조인은 join using 사용
--               (동일한 이름의 컬럼앞에 소유자(테이블명, alias)를 선언하지 않습니다.)
-- join ~ using: 동일한 이름의 속성이 여러개인 테이블을 조인할 때, 하나의 컬럼으로만 equi 방식 조인을 수행
--               (동일한 이름의 컬럼앞에 소유자(테이블명, alias)를 선언하지 않습니다.)
-- join ~ on: sql 1999 문법은 where 절에 조인 조건을 쓰는 것을 추천하지 않아서 이를 사용
--            두 테이블의 컬럼 이름이 다르지만 이를 기준으로 join하는 경우
--            이 경우 컬럼명은 UK를 따름
-- 2. non-equi join: 조인할 두 테이블에서 동일한 속성의 컬럼이 존재하지 않은 경우 (=가 아닌 다른 연산자를 사용해서 조인 조건을 선언)
-- where 절에 선언
-- from 절에 선언 : join ~ on + 조건 
-- self-join: 조인할 두 테이블이 동일한 테이블(하나의 테이블에서 PK를 참조하는 FK가 존재하는 경우로서 자기참조 가능한 테이블)로부터  레코드를 결합해서 검색
--            join ~ on 사용

-- # equi join 예시
-- catesian join: 조인조건 없는 경우
select  a.employee_id, a.last_name, b.department_id, b.department_name
from employees a  , departments b;

-- equip join: 조인조건을 준 경우
select  a.employee_id, a.last_name, b.department_id, b.department_name
from employees a  , departments b
where a.department_id = b.department_id;
-- null 값 또한 가져오려면 outer join
-- 전자는 UK여서 nul 허용, 후자는 PK여서 null 허용 안함 

-- natural join
select  a.employee_id, a.last_name, department_id, b.department_name
from employees a  natural join departments b; 

-- join using
select  a.employee_id, a.last_name, department_id, b.department_name
from employees a  join departments b using (department_id);

-- join on
conn scott/oracle
create table dept2 (deptid , dname, loc)
as
select * from dept;  --테이블 구조, 레코드 복제
desc dept2
select * from dept2;
select a.empno, a.ename, a.deptno, b.dname
from emp a  join dept2 b on a.deptno = b.deptid;

-- # non-eqip join 예시
desc emp
desc salgrade

-- where 선언
select  a.ename, a.sal, b.grade
from  emp a, salgrade b
where a.sal between b.losal and b.hisal;

-- from 선언
select  a.ename, a.sal, b.grade
from  emp a, salgrade b
where a.sal between b.losal and b.hisal;

-- self join 
select  e.empno, e.ename, e.mgr, m.ename
from  emp e , emp m
where e.mgr = m.empno;

select  e.empno, e.ename, e.mgr, m.ename
from  emp e join  emp m on e.mgr = m.empno;

-- Q. 부서번호, 사원이름, 동료사원이름
select a.deptno, a.ename, b.ename
from emp a join emp b on a.deptno = b.deptno and a.ename<>b.ename;

-- Q. outer join
insert into emp (empno, ename)
values (8000, 'Hong');  --레코드 추가
commit;  --저장
select * from emp; --확인

select a.empno, a.ename, deptno, b.dname
from emp a  join dept  b  using (deptno); ---equi join (8000번 사원누락)
-- equip join에서 누락된 row를 결과집합으로가져오려면 outer join을 수행해야 하며
-- 조인할 레코드가 없는 테이블의 조인조건에 outer 연산자(+)를 추가합니다.
--------------------------------------------------------------------------------------------------------------
select a.empno, a.ename, a.deptno, b.dname
from emp a  ,  dept  b 
where  a.deptno = b.deptno(+);  

select a.empno, a.ename, a.deptno, b.dname
from emp a left outer  join  dept  b  on   a.deptno = b.deptno ;  

Q> 사원이 없는 부서 정보를 포함해서 부서별 부서번호, 부서이름, 사원번호, 사원이름을 검색

select a.empno, a.ename, deptno, b.dname
from emp a  join dept  b  using (deptno); --equi join (40번 부서정보 없음)

select b.deptno, b.dname, a.empno, a.ename 
from emp a  ,  dept  b 
where  a.deptno(+) = b.deptno
order by 1 ; 

select b.deptno, b.dname, a.empno, a.ename 
from emp a  right outer join  dept  b  on  a.deptno = b.deptno
order by 1 ; 


- Q> 사원이 없는 부서 정보를 포함하고,  부서를 배정받지 못한 사원정보를 포함해서 부서별 부서번호, 부서이름, 사원번호, 사원이름을 검색

select b.deptno, b.dname, a.empno, a.ename 
from emp a  ,  dept  b 
where  a.deptno(+) = b.deptno(+)
order by 1 ;   ---error


select b.deptno, b.dname, a.empno, a.ename 
from emp a  full outer join  dept  b  on  a.deptno  = b.deptno
order by 1 ; 


#n개의 테이블을 조인할 경우 최소 조인조건은 n-1개 선언해야 합니다.
conn hr/oracle
desc employees
desc departments
desc locations

Q> 사원이름, 부서이름, 부서의 도시명을 검색 
select a.last_name, b.department_name, c.city
from  employees a ,  departments b , locations c
where a.department_id = b.department_id
and b.location_id = c.location_id;


select a.last_name, b.department_name, c.city
from  employees a join departments b  
   on a.department_id = b.department_id 
 join  locations c  on b.location_id = c.location_id;



-----------------------------------------------------------------------------------------------------------------------

-- # 조인 연습문제

-- Q1
-- 1)
select location_id, b.street_address, b.city, b.state_province, b.country_id
from departments a join locations b using (location_id);

-- 2)
select location_id, b.street_address, b.city, b.state_province, b.country_id
from departments a natural join locations b ;




-- Q3
-- non-equi
-- join 조건 2개
select a.last_name,  a.job_id, b.department_id, b.department_name
from employees a, departments b, locations c
where a.department_id = b.department_id
    and b.location_id = c.location_id
    and c.city = 'Toronto';

select a.last_name, a.job_id, b.department_id,  b.department_name
from  employees a join departments b  
   on a.department_id = b.department_id 
 join  locations c  on b.location_id = c.location_id  and c.city = 'Toronto';

select a.last_name, a.job_id, b.department_id,  b.department_name
from  employees a join departments b  
   on a.department_id = b.department_id 
 join  locations c  on b.location_id = c.location_id
where  c.city = 'Toronto';

-- Q4
-- self join
select a.last_name "EMPLOYEE",
    a.employee_id "EMP#", 
    b.last_name "MANAGER", 
    a.manager_id "MGR#"
from employees a, employees b
where a.manager_id = b.employee_id;

-- Q5
select e.last_name "Employee", e.employee_id  "Emp#" ,  
         m.last_name "Manager",  e.manager_id "Mgr#"
from employees e, employees m
where e.manager_id = m.employee_id(+);

select e.last_name "Employee", e.employee_id  "Emp#" ,  
         m.last_name "Manager",  e.manager_id "Mgr#"
from employees e  left outer join employees m
on e.manager_id = m.employee_id; 

-- Q6

-- Q7

-- Q8
alter session set nls_date_format = 'DD-MON-YY';
alter session set nls_language = 'american';

select a.last_name, a.hire_date
from employees a, employees b
where b.last_name = 'Davies'
    and a.hire_date > b.hire_date;

-- Q9
select last_name, hire_date, last_name, hire_date
from employee a, employee b
where a...?;





-----------------------------------------------------------------------------------------------------------------------

-- # Sub Query

-- sub query란?
-- nested query, inner query
-- select문(outer query, main query) 내에 포함되는 select문(sub query)을 의미
-- 1번 이상 select를 수행해야되는 경우 사용 (여러번이 아닌 한번의 select로 작성 가능)
-- data 방법에는 set(집합), join, subquery(join의 특별한 형태)가 있으며, join 성능이 좋지만 subquery가 직관적, 또한 내부적으로 알아서 join으로 변홚서 실행
-- 항상()와 함께 사용
-- sub query는 항상 먼저 수행됨 (main query 보다)
-- select, from, where, having, orderby 절에서 사용 가능 (group by 제외)
-- where절 subquery는 연산자 오른쪽 ()에 선언

-- 예를 들어 아담의 급여를 조회하고, 이 급여보다 큰 급여를 받는 사원을 조회 : select 수행
-- select 이름, 급여
-- from 사원테이블
-- where 사원급여 > (select 급여 from 사원테이블 where 이름은 아담)

-- single row subquery
-- subquery 1개 행 return
-- >, <, <=, >=, = 와 같은 single row operator와 함께 선언

-- multiple row subquery
-- 2개 이상의 행 return
-- in, any, all과 같은 multiple row operator와 함께 선언

-- Q. 7369사원과 동일한 직무를 담당하는 사원의 이름, 부서번호, 직무, 급여를 조회 (7369사원은 결과에서 제외하시오)
select ename, deptno, job, sal
from emp
where job = (select job from emp where empno = '7369')
    and empno <> '7369';
    
-- Q. allen 사원과 동일한 부서에서 근무하면서급여를 더 많이 받는 사원 검색
select ename, deptno, job, sal
from emp
where sal > (select sal from emp where ename = 'ALLEN')
    and deptno = (select deptno from emp where ename = 'ALLEN');
    
-- Q. emp테이블에서 급여를 제일 적게 받는 사원의 이름, 부서, 직무, 급여를 검색
select ename, deptno, job, sal
from emp
where sal = (select min(sal) from emp);

-- Q. 부서별 최대 급여를 받는 사원들의 이름, 부서, 직무, 급여를 검색
select ename, deptno, job, sal
from emp
where sal in (select max(sal) from emp group by deptno);
-- 진짜 정답? 확인해보기 정답아님
-- 이때 multiple columns subquery 사용
-- 쌍으로 비교해주는 sql 작성
select ename, deptno, job, sal
from emp
where (deptno, sal)
    in (select deptno, max(sal) from emp group by deptno);

-- Q. 직무가 salesman인 모든 사원보다 급여를 많이 받는 사원검색
-- (이름, 직무, 급여 - 단 salesman직무 제외)
select ename, job, sal
from emp
where sal > (select max(sal) from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
select ename, job, sal
from emp
where sal > all(select sal from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
-- Q. 직무가 salesman인 최소 한명의 사원보다 급여를 많이 받는 사원검색
-- (이름, 직무, 급여 - 단 salesman직무 제외)
select ename, deptno, job, sal
from emp
where sal > any (select sal from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
select ename, deptno, job, sal
from emp
where sal > (select min(sal) from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';    

-- Q. 전체 사원의 평균 급여보다 급여를 많이 받는 사원 검색
select ename, deptno, job, sal
from emp
where sal > (select avg(sal) from emp);    

-- Q. 각 부서별 부서의 평균 급여보다 급여를 많이 받는 사원 검색
select ename, deptno, job, sal
from emp
where (deptno, sal)  (select deptno,avg(sal) from emp group by deptno);


-- # co-related subquery
-- 상관관계 서브쿼리는 main query의 행 수 만큼 반복 수행
-- 상관관계 서브쿼리는 row 하나씩 서브쿼리에 값을 넣어 조건에 맞으면 메인으로 보내고 아니면 버림을 반복
-- join 으로도 구현 가능
select ename, deptno, job, sal
from emp a
where sal > (select avg(sal) from emp b where a.deptno = b.deptno);

select a.ename, a.deptno, a.sal
from emp a, (select deptno, avg(sal) avgsal from emp group by deptno) b
where a.deptno = b.deptno 
    and a.sal > b.avgsal;


    