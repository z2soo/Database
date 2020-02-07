-- 함수연습문제

-- Q1
alter session set nls_language=american;
alter session set nls_date_format='DD-Mon-YY';
select sysdate from dual;

-- Q2
desc employees
select employee_id "EMPLOYEE_ID", last_name "LAST_NAME", salary "SALARY", salary*1.155 "NEW_SALARY"
from employees;
-- 대소문자 구분하려면 ""으로 감싸주기

-- Q3
select employee_id "EMPLOYEE_ID", last_name "LAST_NAME", salary "SALARY", 
    salary*1.155 "NEW_SALARY", salary*1.155 - salary "INCREASE"
from employees;

-- Q5
select length(last_name)
from employees
where last_name like 'J%'
or last_name like 'A%'
or last_name like 'M%'; 

select last_name "Name", length(last_name) "Length"
from employees
where substr(last_name, 1, 1) in ('J','A','M');


-- '&first' : 치환변수로 first는 임의로 설정한 변수명, &를 주면 실행시마다 물음

-- Q6
-- trunc
-- months_between
desc employees
select last_name "LAST_NAME", trunc(MONTHS_BETWEEN(SYSDATE,hire_date)) "MONTHS_WORKED"
from employees;


-- Q7
-- || 사용
select last_name || 'earns' || to_char(salary, '$99,999.99') || 'monthly but wants' || to_char(salary*3, '$999,999.99')||'.' "Dream Salaries"
from employees;

-- concat 사용
select concat(concat(concat(concat(concat(last_name, 'earn'),
    to_char(salary, '$999,999.00')),
    'monthly but wants'),
    to_char(salary*3, '$999,999.00')),
    '.') "Dream Salaries"
from employees;

-- Q8
-- pad, lpad, rpad
select last_name "LAST_NAME", 
    lpad(salary, 15, '$') "SALARY"
from employees;

-- Q9
-- to_cahr(
alter session set nls_date_format='DD-MON-YY';
alter session set nls_language='american';

select last_name "LAST_NAME", hire_date "HIRE_DATE",
    to_char(hire_date, ) "REVIEW"
from employees;?????????????????????????????????????????????

-- Q10
alter session set nls_language='american';
select last_name "LAST_NAME",
    hire_date "HIRE_DATE",
    to_char(hire_date, 'DAY') "DAY"
from employees;

-- Q11
-- ""과 ''차이?
-- nvl의 arg가 동일한 타입이여야 되서 to_char
select last_name, "LAST_NAME",
    nvl(to_char(commission_pct), 'No Commission') "COMM"
from employees;

-- Q12
-- lpad, rpad
select concat(last_name, rpad(' ',trunc(salary/1000)+1,'*')) 
    "EMPLOYEES_AND_THEIR_SALARIES"
from employees;

select  rpad(concat(last_name, ' '), length(last_name)+1+trunc(salary/1000), '*')
        EMPLOYEES_AND_THEIR_SALARIES
from employees;

-- Q13
-- decoe
-- case 표현식 
desc employees;
desc jobs;

select job_id "JOB_ID",
    case job_id
        when 'AD_PRES' then 'A'
        when 'ST_MAN' then 'B'
        when 'IT_PROG' then 'C'
        when 'SA_REP' then 'D'
        when 'ST_CLERK' then 'E'
    else '0' 
    end "GRADE"
from employees;

-- Q14
select
from employees;

-- Q15
select
from employees;

-- Q16
select
from employees;

-- Q17
select
from employees;

-- Q18
select
from employees;

-- Q19
desc 
select manager_id "MANAGER_ID", min(salary) "MIN(SALARY)"
from employees
where manager_id is not null
group by manager_id
having min(salary) < 6000
order by min(salary) desc;

-- Q20-??????????????????????????????????????????????????????????????????
-- 조건은 decode 또는 when/then
select count(*) "TOTAL",
    count(decode(to_char(hire_date, 'YYYY') = '2002', 1, 0)) "2002",
    count(decode(to_char(hire_date, 'YYYY') = '2003', 1, 0)) "2003",
    count(decode(to_char(hire_date, 'YYYY') = '2004', 1, 0)) "2004",
    count(decode(to_char(hire_date, 'YYYY') = '2005', 1, 0)) "2005" 
from employees;

where 
group by 
having 
order by 

-- Q21
select  job_id,
    sum(decode(department
from employees
where 
group by 
having 
order by 


-- Q19
select  
from employees
where 
group by 
having 
order by 


-- Q20
select  
from employees
where 
group by 
having 
order by 
