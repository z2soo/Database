-- 002. sql 함수

-----------------------------------------------------------------------------------------------------------------------

-- 1. 함수 사용 이유
-- 다음과 같은 언어적 특성에 따라 SQL은 함수 사용을 통해 복잡한 계산, 조건처리, 타입변환, 포켓형식 변환 등의 기술을 처리한다. 
-- 이때, SOL의 함수는 반드시 1개의 값을 리턴해야 한다.
-- sql 언어: 결과지향, 선언적, 과정기술 X (조건, 반복, 변수, 예외처리 불가)
-- program 언어: - 절차적, 처리과정 기술 O (조건, 반복, 변수사용,예외처리 가능)

-----------------------------------------------------------------------------------------------------------------------

-- 2. 함수 종류
-- select, where, order by 절 중에서 select 절에 함수를 쓰는 경우가 가장 많다. 
-- 1) predefine function
-- 단일행 함수: 문자함수, 숫자함수, 날짜함수 , 일반함수 (null처리, 조건처리 함수), 형변환 함수
-- 복수행 함수(group 함수)
-- window 분석함수
-- 통계함수
-- 2) custion function
-- Procedure Language SQL Object

-----------------------------------------------------------------------------------------------------------------------

-- A. 문자함수 (character function)
-- ascii-127개문자 
-- ebcdic-256개문자

select chr(48), chr(65), chr(97), chr(13)
from dual;

select upper('hello'), lower('HELLO'), initcap('HELLO SQL')
from dual;

select concat('hello' ,  ' SQL')
from dual;

-- substr('문자', 숫자1, 숫자2): 해당 숫자1 번째부터의 숫자2개의 문자를 추출
select substr('hello world', 6), substr('hello world', 3,2), substr('hello world', -5, 3)
from dual;

-- 값의 존재 유무를 체크할 때 유용
select  instr('hello world', 'o'), instr('hello world', 'o', 6), 
        instr('hello world', 'o', 1, 2) , instr('hello world', 'o',-7)
from dual;

-- replace('문자','바꾸고 싶은 문자','바뀐 문자')
select replace('Jack and Jue', 'J', 'Bl')
from dual;

select length('korea'), length('대한민국'), 
       lengthb('korea'), lengthb('대한민국')
from dual;

-- 함수 내부에 함수를 사용할 수 있으며, 실행시 안쪽 함수부터 평가
-- trim: 앞 뒤의 공백을 제거
-- rtrim, ltrim 함수는 왼쪽이나 오른쪽 문자 또는 공백을 제거
select length(' k o r e a ') ,  length(trim(' k o r e a '))
from dual;

select translate('Jack and Jue', 'acJ', '137')
from dual;

-- 셀 정렬
select  sal, lpad(sal, 10 , '$'), rpad(sal, 10, '$')
from emp;

-- 정규식 regexp

-----------------------------------------------------------------------------------------------------------------------

-- B. 숫자함수 (number function)

-- round(해당숫자, n): 해당 숫자를 소수점 n까지 반올림하여 표현
select round(1234.567, 2), round(1234.567, 0), round(1234.567, -2)
from dual;

-- trunc(해당숫자, n): 해당 숫자를 소수점 n까지 내림하여 표현
select trunc(1234.567, 2),trunc(1234.567, 0), trunc(1234.567, -2)
from dual;

-- mod(a, b): a / b 의 나머지, 모듈라 연산
-- remainder(a, b): b / a 의 나머지
select mod(100,35), remainder(10,35)
from dual;

-- ceil
-- floor
-- power
select ceil(34.56), floor(34.56), power(2,10)
from dual;

-- Q. emp 테이블로부터 82년도에 입사한 사원조회
select ename
from emp
where hiredate like '87%';

select ename
from emp
where '87' = substr(hiredate,1,2);

-- Q. emp 테이블로부터 사번이 홀수인 사원 조회
select ename
from emp
where mod(empno,2)=1;

-----------------------------------------------------------------------------------------------------------------------

-- C. 날짜 함수

-- month_between
select ename, hiredate, months_between(sysdate,hiredate)
from emp;

select ename, hiredate, trunc(months_between(sysdate, hiredate))
from emp;

-- round함수도 날짜 타입에 적용 가능 함수
select  trunc(to_date('2021/7/16'), 'Month') 
        , trunc(to_date('2021/7/14'), 'Month') 
        , trunc(to_date('2021/7/16'), 'Year') 
        , trunc(to_date('2021/6/16'), 'Month') 
from dual;  

-- add_months
select sysdate, add_months(sysdate, 3)
from dual;

-- sysdate함수는 시스템(운영체제)의 현재 시간을 date타입값으로 반환
-- current_date 함수는 DB접속 client 세션의 timezone기반으로  date타입값으로 반환
-- current_date 함수는 DB접속 client 세션의 timezone기반으로  timestamp타입(date+fractional second)값으로 반환
select sysdate, current_date, current_timestamp, sessiontimezone
from dual;

-- alter session set
alter session set time_zone='+3:00';

select sysdate, current_date, current_timestamp, sessiontimezone
from dual;

-- dbtimezone
select dbtimezone from dual;
alter session set nls_date_format='RR/MM/DD';

-- last_day
select last_day(sysdate), last_day(to_date('1900/02/03')), 
       last_day(to_date('2000/02/03')) , last_day(to_date('1996/02/03')) 
from dual;

-- next_day
select next_day(sysdate,7), next_day(sysdate,'월')
from dual;

select  next_day(sysdate, '금'), next_day(sysdate, '월')
from dual;

-- extract=
select hiredate, extract( month from hiredate)
from emp;

select hiredate, extract( day from hiredate)
from emp;

-- 날짜 시간 관련 컬럼 타입
timestamp with timezone
interval year to month
interval day to second

select hiredate, hiredate + TO_DSINTERVAL('100 00:00:00')
        , hiredate + to_yminterval('01-02')
from emp;

-----------------------------------------------------------------------------------------------------------------------

-- D. 형변환 함수(conversion function)
-- T0_XXX로 시작하는 함수

-- 1. oracle server 자동 형변환
-- 예시를 보면 앞은 숫자인데 문자로 형변환, 뒤는 문자인데 숫자로 형변환
select 10||10, '10'+'10'
from dual;

-- 2. 명시적 형변한 
-- 1) to_char
-- 날짜->문자: to_char('날짜', '변환할 format')
-- 숫자->문자: to_char(숫자, ''변환할 format')
-- 둘다 변한할 값, 변환할 format string 이 동일하지 않아도 된다. 
-- 2) to_number
-- 문자->숫자: to_number('문자열수치', '변환할 format')
-- 변한할 값, 변환할 format string 이 동일해야함
-- 3) to_date
-- 문자->날짜: to_date('날짜문자열', '변환할 format')
-- 변한할 값, 변환할 format string 이 동일해야함

-- 예시
select sysdate,to_char(sysdate, 'YYYY"년" MM"월" DD"일" Day')
from dual;

select 1234.56, to_char(1234.56, '$999,999.990')
from dual;

-- erroe: 형식이 동일하지 않음
select '$1,234.56', to_number('$1234,56', '999,999.990')
from dual;

-- 문자에서 숫자로 변환하면 기호 빠짐
select '$1,234.56', to_number('$1,234.56', '$999,999.990')
from dual;

select '2020년 2월 5일 수요일',
       to_date('2020년 2월 5일 수요일', 'YYYY"년" MM"월" DD"일" Day"요일"')
from dual;

-----------------------------------------------------------------------------------------------------------------------

-- E. 일반 함수 (general function)
-- 1. null 처리 함수

-- 1) nvl(arg1, arg2) 
-- if arg1 is not null then return arg1 else return arg2
-- 반드시 arg1, arg2가 동일한 타입이어야 함

-- error: 마찬가지로 함수 실행시 format 형식이 맞아야 된다.
select nvl(comm, 'No Commission')
from emp;
select nvl(to_char(comm), 'No Commission')
from emp;

-- 2) nvl2(arg1, arg2, arg3))
-- if arg1 is not null then return arg2 else return arg3
-- 반드시 arg2, arg3가 동일한 타입이어야 함

-- Q. emp 테이블에서 commission을 받는 사원은 sal+comm 리턴하고, commission을 받지 않는 사원은 sal 리턴한 결과 출력
select ename, sal, comm, nvl2(comm, sal+comm, comm)
from emp;

-- 3) coalesce(arg1, arg2,......argn) 
-- if arg1 is not null then return arg1 else if arg2 is not null then return arg2 ...
-- null아닌 argument를 리턴하고 함수는 종료
select coalesce(1,2,3,4,5), coalesce(null, null, 3,4,5), coalesce(null,null,null,null,5)
from dual;

-- 2. 조건처리 함수
-- 1) decode()
-- Q. 10번 부서 사원은 급여를 5% 인상, 20번 부서 사원은 급여를 7%인상, 30번 사원은 급여를 3% 인상하여 기존 급여와 함께 출력
select ename, deptno, sal,
       decode(deptno, 10, sal*1.04, 20, sal*1.07, 30, sal*1.03, sal) "Increase"
from emp;

-- 2) 표준sql 구문 case when then ... else end
select ename, deptno, sal,
        case deptno when 10 then sal*1.04
        when 20 then sal*1.07
        when 30 then sal*1.03
        else sal end "Increase"
from emp;

-- Q. 급여에 대한 세금을 급여와 함께 출력하시오.
-- 급여가 1000미만이면 세금 0원, 급여가 1000이상 2000미만이면 세금 급여의 5%, 급여가 2000이상 3000미만이면 세금 급여의 10%,
-- 급여가 3000이상 4000미만이면 세금 급여의 15%, 급여가 4000이상 이면 세금 급여의 20%, 컬럼 별칭은 Tax

select ename,sal,
    decode

select ename, sal,
    case sal 
    when 

-----------------------------------------------------------------------------------------------------------------------

-- F. 그룹함수 (group function, multiple row function)
-- 테이블 전체 레코드를 하나의 그룹으로 함수에 적용
-- 테이블의 레코드를 특정 컬럼으로 그룹핑하고 그룹핑된 레코드들에 함수 적용
--count(), min(), max(), sum(), avg(), stddev(), variance()

select count(sal), min(sal), max(sal), sum(sal), avg(sal), stddev(sal), variance(sal)
from emp;  

--count(), min(), max()는 모든 컬럼타입 적용 가능
select   count(hiredate), min(hiredate), max(hiredate)
from emp; 

select   count(ename), min(ename), max(ename)
from emp; 

--count는 null이 아닌 컬럼값의 개수를 리턴
--count는 인수로 *를 사용할 수 있음=> 테이블의 행수를 리턴 (not null제약조건이 선언된 컬럼값의 개수 계산 리턴)
-- distinct 중복제거
select count(*), count(comm), count(deptno), count(distinct deptno)
from emp;

-- 프로세스: 하나의 작업을 실행하는 작업자의 역할을 하는 것
-- 멀티프로세서는 하나의 프로세서에 대해서 여럿이 역할을 함, 같이 공유하고 사용함

-- 주의할 부분!
-- 그룹함수는 null을 함수 계산에 포함하지 않습니다.(무시합니다.)
※ avg
select  avg(comm), sum(comm)/count(empno), sum(comm)/count(comm)
from emp;   ---comm컬럼에 null포함되어 있으므로 전체 사원의 커미션 평균이 아닌 커미션을 받는 사원들의 커미션 평균이 출력됨


select  avg(nvl(comm, 0)), sum(comm)/count(empno) 
from emp;


-- 주요 문제!!
-- 다음 문제를 확인하기 위해서 col을 하나 추가
alter table emp add (address varchar2(50));
desc emp

-- 모든 col 값이 null인 경우, count 함수의 결과는? 
-- 오류? null? 0? -> 0!
select empno, ename, address from emp;
select count(address) from emp;

-- 모든 col 값이 null인 경우, sum 함수의 결과는?
-- 오류? null? 0? -> null!
select empno, ename, address from emp;
select sum(address) from emp; 

alter table emp drop (address);
alter table emp add (price number(6));
desc emp
select empno,ename, price from  emp;
select sum(price) from emp;
-- 결과 값 null

-- group 함수 적용 전에 grouping을 먼저 실행해야 함
-- group by 에는 오직!! 컬럼만이 올 수 있음을 유의!!

-- 전체적인 논리 순서
-- select ~
-- from ~
-- where ~
-- group by ~ 컬럼
-- order by ~

select deptno, avg(comm), sum(comm)
from emp;
-- 결과 값 error
-- 그룹함수를 사용하는데, 이 함수를 사용하지 않는 함수는 groupby로 묶어줘야 됨!

select deptno, avg(comm), sum(comm)
from emp
group by deptno;

-- 1차 그룹된 레코드에서 2차 그루핑 적용가능
select deptno,job, avg(comm),sum(comm)
from emp
group by deptno, job;

-- Q. 각 부서별 평균 급여가 2500이상인 부서와 해당 부서의 급여 평균을 검색 출력하시오.
select deptno, avg(sal), sum(sal)
from emp
group by deptno;

select deptno, avg(sal), sum(sal)
from emp
where avg(sal) >= 2500
group by deptno;
-- 오류, where 절은 group by 전에 수행되어 그룹함수 사용 불가

-- 그룹함수의 조건 지정, group by 후에 실행
select deptno, avg(sal), sum(sal)
from emp
group by deptno
having avg(sal) >= 2500;

-- Q. employees 테이블의 department_id, salary 컬럼
-- 부서별 급여의 평균을 평균의 내림차순으로 출력하도록 SQL 작성
conn hr/oracle
select department_id, avg(salary)
from employees
group by department_id
order by 2 desc;

-- Q. employees 테이블의 department_id, salary, manager_id 컬럼
-- 관리자가 있는 사원들을 관리자로 그룹핑해서 동일한 관리자로부터 관리를 받는 
-- 피관리자의 최소 급여가  6000미만인 사원의 관리자와 최소급여를 내림차순 SQL 작성
conn hr/oracle
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having avg(salary) < 6000
order by 2 desc;


Q> 전체 사원의 급여 평균과
     부서별 사원들의 급여 평균과
      부서와 직무별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL을 작성하시오

select department_id, job_id, avg(salary)
from employees
group by  rollup (department_id, job_id);



Q> 전체 사원의 급여 평균과
     부서별 사원들의 급여 평균과
     직무별 사원들의 급여 평균과
      부서와 직무별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL을 작성하시오

select department_id, job_id, avg(salary)
from employees
group by  cube (department_id, job_id);


-- Q. 전체 사원의 급여 평균과 부서별 사원들의 급여 평균과
-- 부서와 직무별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL을 작성하시오
-- col 갯수와 형태가 맞아야 됨!
-- ** rollup 연산자
select to_number(null), to_char(null),avg(salary)
from employees
union all
select department_id, to_char(null), avg(salary)
from employees
group by department_id
union all
select department_id, job_id, avg(salary)
from employees
group by rollup(department_id, job_id);
--????????????????????

-- rollup의 실행계획
-- ~
--group by rollup(A,B)
---> group by A,B
---> group by A
---> group by ()

--~
--group by rollup(A,B,C)
---> group by A,B,C
---> group by A,B
---> group by A
---> group by()

-- 실행계획이 상당히 비효율적임

-- cube 연산자
-- cube 의 실행계획
-- ~
--group by rollup(A,B)
---> group by A,B
---> group by A
---> group by B
---> group by ()

--~
--group by rollup(A,B,C)
---> group by A,B,C
---> group by A,B
---> group by A,C
---> group by B,C
---> group by A
---> group by B
---> group by C
---> group by()

-- 만약 A,B,C / A / B,C / () 에 대한 것만 출력하고 싶다면 어떤 연산자를 사용?


Q> 전체 사원의 급여 평균과
     부서별 사원들의 급여 평균과
     관리자와 직무별 사원들의 급여 평균과
     부서와 관리자별 사원들의 급여 평균을 단일 결과 집합으로 생성하는 SQL을 작성하시오

select department_id, job_id, avg(salary)
from employees
group by  grouping sets ((department_id, manager_id, job_id),                                 (department_id), 
                                 (department_id, manager_id),
                                 (department_id,  job_id));



-----------------------------------------------------------------------------------------------------------------------

-- 집합 연산자 set operator

-- db의 data 집합 단위: table
--select의 결과 집합 -> result set, cursor

--연결 방법
--1. join
--2. seperator: 두개 이상의 select결과를 하나의 단일결과 집합으로 생성
--3. subquery

--result1, result2를 연결 : 두 result의 col 갯수가 동일해야 함!
--order by는 마지막 select 문에서만 사용 가능 
--union : 중복 제거
--union all : 중복 제거 x, append 방식으로 가져옴


conn hr/oracle
desc employees
-- 현재 근무하는 사원들이 정보: 107
select count(*) from employees;

-- 과거 근무하는 사원들이 정보: 10
desc job_history
select count(*)from job_history;

-- Q. 사원들의 현재 근무정보와 과거 근무 정보를 모두 출력하는 SQL 작성
select employee_id, department_id, job_id
from employees
union all
select employee_id, department_id, job_id
from job_history;

-- Q. 사원들의 현재 근무정보와 과거 근무 정보를 모두 출력하되 동일한 직무와 부서에서의 근무인 경우 한번만 출력하는  SQL 작성
select employee_id, department_id, job_id
from employees
union 
select employee_id, department_id, job_id
from job_history; 

-- Q. 사원들의 현재 직무를 과거에 동일한 직무를 수행했던 사원번호, 직무를 출력하는 SQL 작성
select employee_id,   job_id
from employees
intersect
select employee_id,   job_id
from job_history;

-- Q. 사원들중에서 입사한 이후 한번도 부서나 직무를 변경한적이 없는 사원번호를  출력하는 SQL 작성
select employee_id 
from employees
minus
select employee_id 
from job_history; --error

select employee_id,   job_id
from employees
intersect
select employee_id,   job_id
from job_history
order by job_id desc;


#3장, 4장, 5장 , 8장의 슬라이드
http://70.12.116.160:8080/bigdata.html