-- 00?. 

-----------------------------------------------------------------------------------------------------------------------

-- # ����

-- join�̶�?
-- �ϳ��̻��� ���̺�κ��� ������ �Ӽ��� �÷����� ��ġ�Ҷ� ���ڵ带 �����ؼ� �˻�
-- (���̺��� �ϳ��� ���ڵ尡 �ٸ� ���̺��� �ϳ��� ���ڵ�� ����)

-- ���ι��� 2����
-- where���� ���� ���� ����
-- sql 1999 ǥ�� ���� ���� (from�� ���� ����)

-- join ����
-- 1. equi join(inner join): ������ �� ���̺��� ������ �Ӽ��� �÷����� ��ġ�Ҷ� (=������ ���)
-- outer-join: equi join���� ������ �� ���̺��� ������ �Ӽ��� �÷����� ��ġ�Ҷ� ���ڵ带 �����ؼ� �˻� ����� �����ϹǷ�, 
--             ������ �÷��� �ϳ��� null�ΰ��� ���� ������տ��� ���ڵ尡 �������� �ʰ� ������տ� �������� ���� �����ϴ� join
-- cross join(cartesian join): ���������� �����Ǹ� ������ ���̺��� ���ڵ尡 ��ü ���ڵ忡 ���ؼ� �ѹ��� ���ε�
-- natural join: ������ �÷��� �����ϴ� ���, �� �÷����� ������ ��쿡�� ����
--               ��, ������ �÷��� �ΰ� �̻� �����ϴ� ��� �� �÷����� ��� ���� ��츸 ���ε�
--               ������ ���� �÷� ������ ���� ��� ������ �� ���, �ϳ��� �÷����� ���� ������ join using ���
--               (������ �̸��� �÷��տ� ������(���̺��, alias)�� �������� �ʽ��ϴ�.)
-- join ~ using: ������ �̸��� �Ӽ��� �������� ���̺��� ������ ��, �ϳ��� �÷����θ� equi ��� ������ ����
--               (������ �̸��� �÷��տ� ������(���̺��, alias)�� �������� �ʽ��ϴ�.)
-- join ~ on: sql 1999 ������ where ���� ���� ������ ���� ���� ��õ���� �ʾƼ� �̸� ���
--            �� ���̺��� �÷� �̸��� �ٸ����� �̸� �������� join�ϴ� ���
--            �� ��� �÷����� UK�� ����
-- 2. non-equi join: ������ �� ���̺��� ������ �Ӽ��� �÷��� �������� ���� ��� (=�� �ƴ� �ٸ� �����ڸ� ����ؼ� ���� ������ ����)
-- where ���� ����
-- from ���� ���� : join ~ on + ���� 
-- self-join: ������ �� ���̺��� ������ ���̺�(�ϳ��� ���̺��� PK�� �����ϴ� FK�� �����ϴ� ���μ� �ڱ����� ������ ���̺�)�κ���  ���ڵ带 �����ؼ� �˻�
--            join ~ on ���

-- # equi join ����
-- catesian join: �������� ���� ���
select  a.employee_id, a.last_name, b.department_id, b.department_name
from employees a  , departments b;

-- equip join: ���������� �� ���
select  a.employee_id, a.last_name, b.department_id, b.department_name
from employees a  , departments b
where a.department_id = b.department_id;
-- null �� ���� ���������� outer join
-- ���ڴ� UK���� nul ���, ���ڴ� PK���� null ��� ���� 

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
select * from dept;  --���̺� ����, ���ڵ� ����
desc dept2
select * from dept2;
select a.empno, a.ename, a.deptno, b.dname
from emp a  join dept2 b on a.deptno = b.deptid;

-- # non-eqip join ����
desc emp
desc salgrade

-- where ����
select  a.ename, a.sal, b.grade
from  emp a, salgrade b
where a.sal between b.losal and b.hisal;

-- from ����
select  a.ename, a.sal, b.grade
from  emp a, salgrade b
where a.sal between b.losal and b.hisal;

-- self join 
select  e.empno, e.ename, e.mgr, m.ename
from  emp e , emp m
where e.mgr = m.empno;

select  e.empno, e.ename, e.mgr, m.ename
from  emp e join  emp m on e.mgr = m.empno;

-- Q. �μ���ȣ, ����̸�, �������̸�
select a.deptno, a.ename, b.ename
from emp a join emp b on a.deptno = b.deptno and a.ename<>b.ename;

-- Q. outer join
insert into emp (empno, ename)
values (8000, 'Hong');  --���ڵ� �߰�
commit;  --����
select * from emp; --Ȯ��

select a.empno, a.ename, deptno, b.dname
from emp a  join dept  b  using (deptno); ---equi join (8000�� �������)
-- equip join���� ������ row�� ����������ΰ��������� outer join�� �����ؾ� �ϸ�
-- ������ ���ڵ尡 ���� ���̺��� �������ǿ� outer ������(+)�� �߰��մϴ�.
--------------------------------------------------------------------------------------------------------------
select a.empno, a.ename, a.deptno, b.dname
from emp a  ,  dept  b 
where  a.deptno = b.deptno(+);  

select a.empno, a.ename, a.deptno, b.dname
from emp a left outer  join  dept  b  on   a.deptno = b.deptno ;  

Q> ����� ���� �μ� ������ �����ؼ� �μ��� �μ���ȣ, �μ��̸�, �����ȣ, ����̸��� �˻�

select a.empno, a.ename, deptno, b.dname
from emp a  join dept  b  using (deptno); --equi join (40�� �μ����� ����)

select b.deptno, b.dname, a.empno, a.ename 
from emp a  ,  dept  b 
where  a.deptno(+) = b.deptno
order by 1 ; 

select b.deptno, b.dname, a.empno, a.ename 
from emp a  right outer join  dept  b  on  a.deptno = b.deptno
order by 1 ; 


- Q> ����� ���� �μ� ������ �����ϰ�,  �μ��� �������� ���� ��������� �����ؼ� �μ��� �μ���ȣ, �μ��̸�, �����ȣ, ����̸��� �˻�

select b.deptno, b.dname, a.empno, a.ename 
from emp a  ,  dept  b 
where  a.deptno(+) = b.deptno(+)
order by 1 ;   ---error


select b.deptno, b.dname, a.empno, a.ename 
from emp a  full outer join  dept  b  on  a.deptno  = b.deptno
order by 1 ; 


#n���� ���̺��� ������ ��� �ּ� ���������� n-1�� �����ؾ� �մϴ�.
conn hr/oracle
desc employees
desc departments
desc locations

Q> ����̸�, �μ��̸�, �μ��� ���ø��� �˻� 
select a.last_name, b.department_name, c.city
from  employees a ,  departments b , locations c
where a.department_id = b.department_id
and b.location_id = c.location_id;


select a.last_name, b.department_name, c.city
from  employees a join departments b  
   on a.department_id = b.department_id 
 join  locations c  on b.location_id = c.location_id;



-----------------------------------------------------------------------------------------------------------------------

-- # ���� ��������

-- Q1
-- 1)
select location_id, b.street_address, b.city, b.state_province, b.country_id
from departments a join locations b using (location_id);

-- 2)
select location_id, b.street_address, b.city, b.state_province, b.country_id
from departments a natural join locations b ;




-- Q3
-- non-equi
-- join ���� 2��
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

-- sub query��?
-- nested query, inner query
-- select��(outer query, main query) ���� ���ԵǴ� select��(sub query)�� �ǹ�
-- 1�� �̻� select�� �����ؾߵǴ� ��� ��� (�������� �ƴ� �ѹ��� select�� �ۼ� ����)
-- data ������� set(����), join, subquery(join�� Ư���� ����)�� ������, join ������ ������ subquery�� ������, ���� ���������� �˾Ƽ� join���� ���T�� ����
-- �׻�()�� �Բ� ���
-- sub query�� �׻� ���� ����� (main query ����)
-- select, from, where, having, orderby ������ ��� ���� (group by ����)
-- where�� subquery�� ������ ������ ()�� ����

-- ���� ��� �ƴ��� �޿��� ��ȸ�ϰ�, �� �޿����� ū �޿��� �޴� ����� ��ȸ : select ����
-- select �̸�, �޿�
-- from ������̺�
-- where ����޿� > (select �޿� from ������̺� where �̸��� �ƴ�)

-- single row subquery
-- subquery 1�� �� return
-- >, <, <=, >=, = �� ���� single row operator�� �Բ� ����

-- multiple row subquery
-- 2�� �̻��� �� return
-- in, any, all�� ���� multiple row operator�� �Բ� ����

-- Q. 7369����� ������ ������ ����ϴ� ����� �̸�, �μ���ȣ, ����, �޿��� ��ȸ (7369����� ������� �����Ͻÿ�)
select ename, deptno, job, sal
from emp
where job = (select job from emp where empno = '7369')
    and empno <> '7369';
    
-- Q. allen ����� ������ �μ����� �ٹ��ϸ鼭�޿��� �� ���� �޴� ��� �˻�
select ename, deptno, job, sal
from emp
where sal > (select sal from emp where ename = 'ALLEN')
    and deptno = (select deptno from emp where ename = 'ALLEN');
    
-- Q. emp���̺��� �޿��� ���� ���� �޴� ����� �̸�, �μ�, ����, �޿��� �˻�
select ename, deptno, job, sal
from emp
where sal = (select min(sal) from emp);

-- Q. �μ��� �ִ� �޿��� �޴� ������� �̸�, �μ�, ����, �޿��� �˻�
select ename, deptno, job, sal
from emp
where sal in (select max(sal) from emp group by deptno);
-- ��¥ ����? Ȯ���غ��� ����ƴ�
-- �̶� multiple columns subquery ���
-- ������ �����ִ� sql �ۼ�
select ename, deptno, job, sal
from emp
where (deptno, sal)
    in (select deptno, max(sal) from emp group by deptno);

-- Q. ������ salesman�� ��� ������� �޿��� ���� �޴� ����˻�
-- (�̸�, ����, �޿� - �� salesman���� ����)
select ename, job, sal
from emp
where sal > (select max(sal) from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
select ename, job, sal
from emp
where sal > all(select sal from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
-- Q. ������ salesman�� �ּ� �Ѹ��� ������� �޿��� ���� �޴� ����˻�
-- (�̸�, ����, �޿� - �� salesman���� ����)
select ename, deptno, job, sal
from emp
where sal > any (select sal from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';
    
select ename, deptno, job, sal
from emp
where sal > (select min(sal) from emp where job = 'SALESMAN')
    and job <> 'SALESMAN';    

-- Q. ��ü ����� ��� �޿����� �޿��� ���� �޴� ��� �˻�
select ename, deptno, job, sal
from emp
where sal > (select avg(sal) from emp);    

-- Q. �� �μ��� �μ��� ��� �޿����� �޿��� ���� �޴� ��� �˻�
select ename, deptno, job, sal
from emp
where (deptno, sal)  (select deptno,avg(sal) from emp group by deptno);


-- # co-related subquery
-- ������� ���������� main query�� �� �� ��ŭ �ݺ� ����
-- ������� ���������� row �ϳ��� ���������� ���� �־� ���ǿ� ������ �������� ������ �ƴϸ� ������ �ݺ�
-- join ���ε� ���� ����
select ename, deptno, job, sal
from emp a
where sal > (select avg(sal) from emp b where a.deptno = b.deptno);

select a.ename, a.deptno, a.sal
from emp a, (select deptno, avg(sal) avgsal from emp group by deptno) b
where a.deptno = b.deptno 
    and a.sal > b.avgsal;


    