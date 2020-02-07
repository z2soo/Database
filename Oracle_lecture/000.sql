-- 005. 

-----------------------------------------------------------------------------------------------------------------------

-- # 복습

-- 1. 단일행함수
-- 1) character function - instr, length, substr, trim, lpad, rpad, replace, translate,..
-- 2) number function - round, trunc, sign, mod ,...
-- 3) date function - months_between, add_months, next_day, last_day, extract, sysdate, current_date, current_timestamp,...
-- 4) conversion function - to_char, to_number, to_date('character', '변환할 fmt')

-- 2. 기타 일반 함수 
-- nvl(arg1, arg2), nvl2(arg1, arg2, arg3), coalesce(arg1,arg2,.....arg N), nullif(arg1, arg2)

-- 3. 조건 함수
-- 1) 조건처리함수 - decode()
-- 2) 조건처리 표준 sql 표현식  - case ~ when~then~[when~then~]...[else~] end

-- 4. 그룹함수 
-- count, min, max, sum, avg, stddev, variance
-- 그룹함수는 null을 계산에 포함하지 않습니다.
-- 1) group by - 테이블의 레코드를 특정 컬럼 기준으로 그룹핑할때
-- 2) having -그룹핑함수의 조건을 선언

-- 연산되는 순서는 다음과 같음
-- select ~                     // 5
-- from ~                     //  1
-- where ~                    // 필터조건 2
-- group by ~                // 3
-- having ~                   // 4
-- order by ~                  // 6

group by 연산자 - rollup, cube, groupingsets

집합연산자  : 2개이상의 select의 결과(resultset, cursor)를 단일 결과집합으로 만듬
union all
union
minus
intersect
집합연산자와 함께 사용하는 select문들은 컬럼개수, 컬럼타입과 순서 일치

-----------------------------------------------------------------------------------------------------------------------

-- # join 종류

col 기준: projection?
row 기준: select

-- 1. inner join, equi join
-- 조인대상 table로 부터 동일 속성컬럼값이 일치하는 record를 결합
-- 부모 table: Primary Key(PK), Unique(UK) : PK는 not null & unique, UK는 unique
-- 자식 table: Foriegn Key(FK)

-- 2. cross join
-- cartesian product

-- 3. non equi join

-- 4. self join
-- 자기참조를 통한 join
-- 자기참조관계 테이블에서 PK와 FK 컬럼간의 조인 조건
-- select와 차이? 

-- 5. outer join
-- join 할 때, null 값도 가져오기 위해 사용


-----------------------------------------------------------------------------------------------------------------------

-- # join 문법

-- 위의 모든 조인 종류는  where, from 문법으로 모두 가능하다. 
-- 1) where 절에 join 문법 선언
-- 2) from 절에 join 문법 선언: sql 1999 문법: join 함수 사용
-- natural join, join ~using, join ~on

-----------------------------------------------------------------------------------------------------------------------

-- # 연습문제

-- Q. 사원이름, 부서번호, 부서이름을 조회 결과로 생성
select ename, deptno, dname
from emp, dept; 
-- 위 sql error
-- 어떤 table에서 값을 가져와야 되는지 모르기에 error가 뜸
-- 따라서 앞에 출처 table 이름을 달아줌
select emp.ename, emp.deptno,dept.dname
from emp, dept;

select a.ename, a.deptno, b.dname
from emp a, dept b;
-- 56row 출력됨
-- 조인조건이 누락되어 cartesian product로 수행

-- where절 join
select a.ename, a.deptno, b.dname
from emp a, dept b
where a.deptno = b.deptno;

-- from절 join
con hr/oracle
-- employees: 107rows
-- departments: 27rows

-- where 절에 join 선언
select  a.last_name, a.department_id, b.department_name
from employees a, departments b 
where a.department_id = b.department_id;
-- 위의 결과도 107이여야 하는데 값은 106이 나옴
-- 이는 null 값이 하나 있다는 의미

-- 그러면 join은 따로 함수가 있는게 아니라 조건을 추가함으로서 수행하는 것? : 함수가 있음
-- 위에 까지는 where 절에 선언, 밑에는 from 절에 선언
-- 그러면 where 절에 선언할 때는 함수가 없고 from절에 선언할 때는 함수가 있는 건가? 맞음

-----------------------------------------------------------------------------------------------------------------------

-- # from절 선언 join

-- 1. natural join
-- natural join : oracle 서버가 조인할 두 테이블의 동일한 이름의 컬럼값으로 equi join 수행
-- 동일한 이름의 컬럼앞에 소유자 테이블명이나 alias를 선언할 수 없음
select  a.last_name, a.department_id, b.department_name
from employees a  natural join departments b ;-- error

select  a.last_name, department_id, b.department_name
from employees a  natural join departments b ; -- row 32
desc employees
desc departments
-- 데이터 모델링을 잘못해서 두 테이블의 동일한 속석에 대해서 컬럼 이름이 다른경우에는 조인이 수행되지 않음
-- 위의 경우 동일하게 가지는 col이 manager_id, department_id 두 개여서 둘 다를 기준으로 join이 됨
-- 이런 경우 동일하게 가지는 여러 col 중 하나의 컬럼으로만 조인을 수행하기 위해서 join~using 사용

-- 2. join ~ using
select  a.last_name, a.department_id, b.department_name
from employees a  using join (a.department_id) ; --error

select  a.last_name, department_id, b.department_name
from employees a  join departments b using (department_id); --row 160

select  a.last_name, department_id, b.department_name
from employees a  join departments b using (department_id)
where a.department_id > 50; --error

select  a.last_name, department_id, b.department_name
from employees a  join departments b using (department_id)
where department_id > 50; 

-- dept와 동일한 table을 col만 다르게 해서 만들어 주고 확인
conn scott/oracle
create table dept2 (deptid, dname, loc)
as select * from dept;
desc dept2
select * from dept2;

select a.ename, deptno, b.dname
from emp a natural join dept2 b; --14rows
-- join할 컬럼명이 다르므로 equi join이 아닌 cartesian join으로 수행됨

-- 3. join ~ on
select a.ename, a.deptno, b.dname
from emp a join dept2 b on a.deptno = b.deptid; --14rows
-- 왜 여기서는 aliase 선언? : natural join, join using은 선언하지 않지만,join ~ on은 선언
-- join ~ on은 join하고 where로 주는 조건과 다름?

-- Q. 각 사원별로 급여와 급여 등급을 조회출력하는 SQL 작성
desc emp
desc salgrade
-- salgrade는 구간, 구간에 따른 등급 구분 정보

select a.ename, a.sal, b.grade
from emp a, salgrade b
where a.sal between b.losal and b.hisal; 

select a.ename, a.sal, b.grade
from emp a join salgrade b on a.sal between b.losal and b.hisal; 

-- 자기참조
-- Q. 사원별 사번, 이름,관리자번호, 관리자 이름을 조회출력
select a.empno, a.ename, a.mgr, b.ename 
from emp a, emp b
where a.mgr = b.empno;

select a.empno, a.ename, a.mgr, b.ename 
from emp a join emp b on a.mgr = b.empno;

-- 3개의 테이블을 가지고 join을 하려면?
-- Q. 사원이름, 소속부서이름, 소속부서 위치(도시명)출력
conn hr/oracle
desc employees
desc departments
desc locations

select a.employee_id, b.department_name, c.city
from employees a join departments b on a.department_id = b.department_id
where  on b.location_id = c.location_id
from departments b join locations c;


