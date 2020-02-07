-- 003. sql �Լ�

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
-- null ó�� �Լ�

-- 1. nvl(arg1, arg2) 
-- if arg1 is not null then return arg1 else return arg2
-- �ݵ�� arg1, arg2�� ������ Ÿ���̾�� ��

-- 2. nvl2(arg1, arg2, arg3))
-- if arg1 is not null then return arg2 else return arg3
-- �ݵ�� arg2, arg3�� ������ Ÿ���̾�� ��

-- 3. coalesce(arg1, arg2,......argn) 
-- if arg1 is not null then return arg1 else if arg2 is not null then return arg2 ...
-- null�ƴ� argument�� �����ϰ� �Լ��� ����

-- error: ���������� �Լ� ����� format ������ �¾ƾ� �ȴ�.
select nvl(comm, 'No Commission')
from emp;
select nvl(to_char(comm), 'No Commission')
from emp;

-- Q. emp���̺��� commission�� �޴� ����� sal+comm �����ϰ�, commission�� ���� �ʴ� ����� sal ������ ��� ���
select ename, sal, comm, nvl2(comm, sal+comm, comm)
from emp;



