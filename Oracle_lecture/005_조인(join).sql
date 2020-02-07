-- 002. sql �Լ�

-----------------------------------------------------------------------------------------------------------------------

-- 1. �Լ� ��� ����
-- ������ ���� ����� Ư���� ���� SQL�� �Լ� ����� ���� ������ ���, ����ó��, Ÿ�Ժ�ȯ, �������� ��ȯ ���� ����� ó���Ѵ�. 
-- �̶�, SOL�� �Լ��� �ݵ�� 1���� ���� �����ؾ� �Ѵ�.
-- sql ���: �������, ������, ������� X (����, �ݺ�, ����, ����ó�� �Ұ�)
-- program ���: - ������, ó������ ��� O (����, �ݺ�, �������,����ó�� ����)

-----------------------------------------------------------------------------------------------------------------------

-- 2. �Լ� ����
-- select, where, order by �� �߿��� select ���� �Լ��� ���� ��찡 ���� ����. 
-- 1) predefine function
-- ������ �Լ�: �����Լ�, �����Լ�, ��¥�Լ� , �Ϲ��Լ� (nulló��, ����ó�� �Լ�), ����ȯ �Լ�
-- ������ �Լ�(group �Լ�)
-- window �м��Լ�
-- ����Լ�
-- 2) custion function
-- Procedure Language SQL Object

-----------------------------------------------------------------------------------------------------------------------

-- A. �����Լ� (character function)
-- ascii-127������ 
-- ebcdic-256������

select chr(48), chr(65), chr(97), chr(13)
from dual;

select upper('hello'), lower('HELLO'), initcap('HELLO SQL')
from dual;

select concat('hello' ,  ' SQL')
from dual;

-- substr('����', ����1, ����2): �ش� ����1 ��°������ ����2���� ���ڸ� ����
select substr('hello world', 6), substr('hello world', 3,2), substr('hello world', -5, 3)
from dual;

-- ���� ���� ������ üũ�� �� ����
select  instr('hello world', 'o'), instr('hello world', 'o', 6), 
        instr('hello world', 'o', 1, 2) , instr('hello world', 'o',-7)
from dual;

-- replace('����','�ٲٰ� ���� ����','�ٲ� ����')
select replace('Jack and Jue', 'J', 'Bl')
from dual;

select length('korea'), length('���ѹα�'), 
       lengthb('korea'), lengthb('���ѹα�')
from dual;

-- �Լ� ���ο� �Լ��� ����� �� ������, ����� ���� �Լ����� ��
-- trim: �� ���� ������ ����
-- rtrim, ltrim �Լ��� �����̳� ������ ���� �Ǵ� ������ ����
select length(' k o r e a ') ,  length(trim(' k o r e a '))
from dual;

select translate('Jack and Jue', 'acJ', '137')
from dual;

-- �� ����
select  sal, lpad(sal, 10 , '$'), rpad(sal, 10, '$')
from emp;

-- ���Խ� regexp

-----------------------------------------------------------------------------------------------------------------------

-- B. �����Լ� (number function)

-- round(�ش����, n): �ش� ���ڸ� �Ҽ��� n���� �ݿø��Ͽ� ǥ��
select round(1234.567, 2), round(1234.567, 0), round(1234.567, -2)
from dual;

-- trunc(�ش����, n): �ش� ���ڸ� �Ҽ��� n���� �����Ͽ� ǥ��
select trunc(1234.567, 2),trunc(1234.567, 0), trunc(1234.567, -2)
from dual;

-- mod(a, b): a / b �� ������, ���� ����
-- remainder(a, b): b / a �� ������
select mod(100,35), remainder(10,35)
from dual;

-- ceil
-- floor
-- power
select ceil(34.56), floor(34.56), power(2,10)
from dual;

-- Q. emp ���̺�κ��� 82�⵵�� �Ի��� �����ȸ
select ename
from emp
where hiredate like '87%';

select ename
from emp
where '87' = substr(hiredate,1,2);

-- Q. emp ���̺�κ��� ����� Ȧ���� ��� ��ȸ
select ename
from emp
where mod(empno,2)=1;

-----------------------------------------------------------------------------------------------------------------------

-- C. ��¥ �Լ�

-- month_between
select ename, hiredate, months_between(sysdate,hiredate)
from emp;

select ename, hiredate, trunc(months_between(sysdate, hiredate))
from emp;

-- round�Լ��� ��¥ Ÿ�Կ� ���� ���� �Լ�
select  trunc(to_date('2021/7/16'), 'Month') 
        , trunc(to_date('2021/7/14'), 'Month') 
        , trunc(to_date('2021/7/16'), 'Year') 
        , trunc(to_date('2021/6/16'), 'Month') 
from dual;  

-- add_months
select sysdate, add_months(sysdate, 3)
from dual;

-- sysdate�Լ��� �ý���(�ü��)�� ���� �ð��� dateŸ�԰����� ��ȯ
-- current_date �Լ��� DB���� client ������ timezone�������  dateŸ�԰����� ��ȯ
-- current_date �Լ��� DB���� client ������ timezone�������  timestampŸ��(date+fractional second)������ ��ȯ
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
select next_day(sysdate,7), next_day(sysdate,'��')
from dual;

select  next_day(sysdate, '��'), next_day(sysdate, '��')
from dual;

-- extract=
select hiredate, extract( month from hiredate)
from emp;

select hiredate, extract( day from hiredate)
from emp;

-- ��¥ �ð� ���� �÷� Ÿ��
timestamp with timezone
interval year to month
interval day to second

select hiredate, hiredate + TO_DSINTERVAL('100 00:00:00')
        , hiredate + to_yminterval('01-02')
from emp;

-----------------------------------------------------------------------------------------------------------------------

-- D. ����ȯ �Լ�(conversion function)
-- T0_XXX�� �����ϴ� �Լ�

-- 1. oracle server �ڵ� ����ȯ
-- ���ø� ���� ���� �����ε� ���ڷ� ����ȯ, �ڴ� �����ε� ���ڷ� ����ȯ
select 10||10, '10'+'10'
from dual;

-- 2. ����� ������ 
-- 1) to_char
-- ��¥->����: to_char('��¥', '��ȯ�� format')
-- ����->����: to_char(����, ''��ȯ�� format')
-- �Ѵ� ������ ��, ��ȯ�� format string �� �������� �ʾƵ� �ȴ�. 
-- 2) to_number
-- ����->����: to_number('���ڿ���ġ', '��ȯ�� format')
-- ������ ��, ��ȯ�� format string �� �����ؾ���
-- 3) to_date
-- ����->��¥: to_date('��¥���ڿ�', '��ȯ�� format')
-- ������ ��, ��ȯ�� format string �� �����ؾ���

-- ����
select sysdate,to_char(sysdate, 'YYYY"��" MM"��" DD"��" Day')
from dual;

select 1234.56, to_char(1234.56, '$999,999.990')
from dual;

-- erroe: ������ �������� ����
select '$1,234.56', to_number('$1234,56', '999,999.990')
from dual;

-- ���ڿ��� ���ڷ� ��ȯ�ϸ� ��ȣ ����
select '$1,234.56', to_number('$1,234.56', '$999,999.990')
from dual;

select '2020�� 2�� 5�� ������',
       to_date('2020�� 2�� 5�� ������', 'YYYY"��" MM"��" DD"��" Day"����"')
from dual;

-----------------------------------------------------------------------------------------------------------------------

-- E. �Ϲ� �Լ� (general function)
-- 1. null ó�� �Լ�

-- 1) nvl(arg1, arg2) 
-- if arg1 is not null then return arg1 else return arg2
-- �ݵ�� arg1, arg2�� ������ Ÿ���̾�� ��

-- error: ���������� �Լ� ����� format ������ �¾ƾ� �ȴ�.
select nvl(comm, 'No Commission')
from emp;
select nvl(to_char(comm), 'No Commission')
from emp;

-- 2) nvl2(arg1, arg2, arg3))
-- if arg1 is not null then return arg2 else return arg3
-- �ݵ�� arg2, arg3�� ������ Ÿ���̾�� ��

-- Q. emp ���̺��� commission�� �޴� ����� sal+comm �����ϰ�, commission�� ���� �ʴ� ����� sal ������ ��� ���
select ename, sal, comm, nvl2(comm, sal+comm, comm)
from emp;

-- 3) coalesce(arg1, arg2,......argn) 
-- if arg1 is not null then return arg1 else if arg2 is not null then return arg2 ...
-- null�ƴ� argument�� �����ϰ� �Լ��� ����
select coalesce(1,2,3,4,5), coalesce(null, null, 3,4,5), coalesce(null,null,null,null,5)
from dual;

-- 2. ����ó�� �Լ�
-- 1) decode()
-- Q. 10�� �μ� ����� �޿��� 5% �λ�, 20�� �μ� ����� �޿��� 7%�λ�, 30�� ����� �޿��� 3% �λ��Ͽ� ���� �޿��� �Բ� ���
select ename, deptno, sal,
       decode(deptno, 10, sal*1.04, 20, sal*1.07, 30, sal*1.03, sal) "Increase"
from emp;

-- 2) ǥ��sql ���� case when then ... else end
select ename, deptno, sal,
        case deptno when 10 then sal*1.04
        when 20 then sal*1.07
        when 30 then sal*1.03
        else sal end "Increase"
from emp;

-- Q. �޿��� ���� ������ �޿��� �Բ� ����Ͻÿ�.
-- �޿��� 1000�̸��̸� ���� 0��, �޿��� 1000�̻� 2000�̸��̸� ���� �޿��� 5%, �޿��� 2000�̻� 3000�̸��̸� ���� �޿��� 10%,
-- �޿��� 3000�̻� 4000�̸��̸� ���� �޿��� 15%, �޿��� 4000�̻� �̸� ���� �޿��� 20%, �÷� ��Ī�� Tax

select ename,sal,
    decode

select ename, sal,
    case sal 
    when 

-----------------------------------------------------------------------------------------------------------------------

-- F. �׷��Լ� (group function, multiple row function)
-- ���̺� ��ü ���ڵ带 �ϳ��� �׷����� �Լ��� ����
-- ���̺��� ���ڵ带 Ư�� �÷����� �׷����ϰ� �׷��ε� ���ڵ�鿡 �Լ� ����
--count(), min(), max(), sum(), avg(), stddev(), variance()

select count(sal), min(sal), max(sal), sum(sal), avg(sal), stddev(sal), variance(sal)
from emp;  

--count(), min(), max()�� ��� �÷�Ÿ�� ���� ����
select   count(hiredate), min(hiredate), max(hiredate)
from emp; 

select   count(ename), min(ename), max(ename)
from emp; 

--count�� null�� �ƴ� �÷����� ������ ����
--count�� �μ��� *�� ����� �� ����=> ���̺��� ����� ���� (not null���������� ����� �÷����� ���� ��� ����)
-- distinct �ߺ�����
select count(*), count(comm), count(deptno), count(distinct deptno)
from emp;

-- ���μ���: �ϳ��� �۾��� �����ϴ� �۾����� ������ �ϴ� ��
-- ��Ƽ���μ����� �ϳ��� ���μ����� ���ؼ� ������ ������ ��, ���� �����ϰ� �����

-- ������ �κ�!
-- �׷��Լ��� null�� �Լ� ��꿡 �������� �ʽ��ϴ�.(�����մϴ�.)
�� avg
select  avg(comm), sum(comm)/count(empno), sum(comm)/count(comm)
from emp;   ---comm�÷��� null���ԵǾ� �����Ƿ� ��ü ����� Ŀ�̼� ����� �ƴ� Ŀ�̼��� �޴� ������� Ŀ�̼� ����� ��µ�


select  avg(nvl(comm, 0)), sum(comm)/count(empno) 
from emp;


-- �ֿ� ����!!
-- ���� ������ Ȯ���ϱ� ���ؼ� col�� �ϳ� �߰�
alter table emp add (address varchar2(50));
desc emp

-- ��� col ���� null�� ���, count �Լ��� �����? 
-- ����? null? 0? -> 0!
select empno, ename, address from emp;
select count(address) from emp;

-- ��� col ���� null�� ���, sum �Լ��� �����?
-- ����? null? 0? -> null!
select empno, ename, address from emp;
select sum(address) from emp; 

alter table emp drop (address);
alter table emp add (price number(6));
desc emp
select empno,ename, price from  emp;
select sum(price) from emp;
-- ��� �� null

-- group �Լ� ���� ���� grouping�� ���� �����ؾ� ��
-- group by ���� ����!! �÷����� �� �� ������ ����!!

-- ��ü���� �� ����
-- select ~
-- from ~
-- where ~
-- group by ~ �÷�
-- order by ~

select deptno, avg(comm), sum(comm)
from emp;
-- ��� �� error
-- �׷��Լ��� ����ϴµ�, �� �Լ��� ������� �ʴ� �Լ��� groupby�� ������� ��!

select deptno, avg(comm), sum(comm)
from emp
group by deptno;

-- 1�� �׷�� ���ڵ忡�� 2�� �׷��� ���밡��
select deptno,job, avg(comm),sum(comm)
from emp
group by deptno, job;

-- Q. �� �μ��� ��� �޿��� 2500�̻��� �μ��� �ش� �μ��� �޿� ����� �˻� ����Ͻÿ�.
select deptno, avg(sal), sum(sal)
from emp
group by deptno;

select deptno, avg(sal), sum(sal)
from emp
where avg(sal) >= 2500
group by deptno;
-- ����, where ���� group by ���� ����Ǿ� �׷��Լ� ��� �Ұ�

-- �׷��Լ��� ���� ����, group by �Ŀ� ����
select deptno, avg(sal), sum(sal)
from emp
group by deptno
having avg(sal) >= 2500;

-- Q. employees ���̺��� department_id, salary �÷�
-- �μ��� �޿��� ����� ����� ������������ ����ϵ��� SQL �ۼ�
conn hr/oracle
select department_id, avg(salary)
from employees
group by department_id
order by 2 desc;

-- Q. employees ���̺��� department_id, salary, manager_id �÷�
-- �����ڰ� �ִ� ������� �����ڷ� �׷����ؼ� ������ �����ڷκ��� ������ �޴� 
-- �ǰ������� �ּ� �޿���  6000�̸��� ����� �����ڿ� �ּұ޿��� �������� SQL �ۼ�
conn hr/oracle
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having avg(salary) < 6000
order by 2 desc;


Q> ��ü ����� �޿� ��հ�
     �μ��� ������� �޿� ��հ�
      �μ��� ������ ������� �޿� ����� ���� ��� �������� �����ϴ� SQL�� �ۼ��Ͻÿ�

select department_id, job_id, avg(salary)
from employees
group by  rollup (department_id, job_id);



Q> ��ü ����� �޿� ��հ�
     �μ��� ������� �޿� ��հ�
     ������ ������� �޿� ��հ�
      �μ��� ������ ������� �޿� ����� ���� ��� �������� �����ϴ� SQL�� �ۼ��Ͻÿ�

select department_id, job_id, avg(salary)
from employees
group by  cube (department_id, job_id);


-- Q. ��ü ����� �޿� ��հ� �μ��� ������� �޿� ��հ�
-- �μ��� ������ ������� �޿� ����� ���� ��� �������� �����ϴ� SQL�� �ۼ��Ͻÿ�
-- col ������ ���°� �¾ƾ� ��!
-- ** rollup ������
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

-- rollup�� �����ȹ
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

-- �����ȹ�� ����� ��ȿ������

-- cube ������
-- cube �� �����ȹ
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

-- ���� A,B,C / A / B,C / () �� ���� �͸� ����ϰ� �ʹٸ� � �����ڸ� ���?


Q> ��ü ����� �޿� ��հ�
     �μ��� ������� �޿� ��հ�
     �����ڿ� ������ ������� �޿� ��հ�
     �μ��� �����ں� ������� �޿� ����� ���� ��� �������� �����ϴ� SQL�� �ۼ��Ͻÿ�

select department_id, job_id, avg(salary)
from employees
group by  grouping sets ((department_id, manager_id, job_id),                                 (department_id), 
                                 (department_id, manager_id),
                                 (department_id,  job_id));



-----------------------------------------------------------------------------------------------------------------------

-- ���� ������ set operator

-- db�� data ���� ����: table
--select�� ��� ���� -> result set, cursor

--���� ���
--1. join
--2. seperator: �ΰ� �̻��� select����� �ϳ��� ���ϰ�� �������� ����
--3. subquery

--result1, result2�� ���� : �� result�� col ������ �����ؾ� ��!
--order by�� ������ select �������� ��� ���� 
--union : �ߺ� ����
--union all : �ߺ� ���� x, append ������� ������


conn hr/oracle
desc employees
-- ���� �ٹ��ϴ� ������� ����: 107
select count(*) from employees;

-- ���� �ٹ��ϴ� ������� ����: 10
desc job_history
select count(*)from job_history;

-- Q. ������� ���� �ٹ������� ���� �ٹ� ������ ��� ����ϴ� SQL �ۼ�
select employee_id, department_id, job_id
from employees
union all
select employee_id, department_id, job_id
from job_history;

-- Q. ������� ���� �ٹ������� ���� �ٹ� ������ ��� ����ϵ� ������ ������ �μ������� �ٹ��� ��� �ѹ��� ����ϴ�  SQL �ۼ�
select employee_id, department_id, job_id
from employees
union 
select employee_id, department_id, job_id
from job_history; 

-- Q. ������� ���� ������ ���ſ� ������ ������ �����ߴ� �����ȣ, ������ ����ϴ� SQL �ۼ�
select employee_id,   job_id
from employees
intersect
select employee_id,   job_id
from job_history;

-- Q. ������߿��� �Ի��� ���� �ѹ��� �μ��� ������ ���������� ���� �����ȣ��  ����ϴ� SQL �ۼ�
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


#3��, 4��, 5�� , 8���� �����̵�
http://70.12.116.160:8080/bigdata.html