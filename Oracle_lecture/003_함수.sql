-- 003. sql 함수

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
-- null 처리 함수

-- 1. nvl(arg1, arg2) 
-- if arg1 is not null then return arg1 else return arg2
-- 반드시 arg1, arg2가 동일한 타입이어야 함

-- 2. nvl2(arg1, arg2, arg3))
-- if arg1 is not null then return arg2 else return arg3
-- 반드시 arg2, arg3가 동일한 타입이어야 함

-- 3. coalesce(arg1, arg2,......argn) 
-- if arg1 is not null then return arg1 else if arg2 is not null then return arg2 ...
-- null아닌 argument를 리턴하고 함수는 종료

-- error: 마찬가지로 함수 실행시 format 형식이 맞아야 된다.
select nvl(comm, 'No Commission')
from emp;
select nvl(to_char(comm), 'No Commission')
from emp;

-- Q. emp테이블에서 commission을 받는 사원은 sal+comm 리턴하고, commission을 받지 않는 사원은 sal 리턴한 결과 출력
select ename, sal, comm, nvl2(comm, sal+comm, comm)
from emp;



