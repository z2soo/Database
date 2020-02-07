-- 005. 

-----------------------------------------------------------------------------------------------------------------------

-- # ����

-- 1. �������Լ�
-- 1) character function - instr, length, substr, trim, lpad, rpad, replace, translate,..
-- 2) number function - round, trunc, sign, mod ,...
-- 3) date function - months_between, add_months, next_day, last_day, extract, sysdate, current_date, current_timestamp,...
-- 4) conversion function - to_char, to_number, to_date('character', '��ȯ�� fmt')

-- 2. ��Ÿ �Ϲ� �Լ� 
-- nvl(arg1, arg2), nvl2(arg1, arg2, arg3), coalesce(arg1,arg2,.....arg N), nullif(arg1, arg2)

-- 3. ���� �Լ�
-- 1) ����ó���Լ� - decode()
-- 2) ����ó�� ǥ�� sql ǥ����  - case ~ when~then~[when~then~]...[else~] end

-- 4. �׷��Լ� 
-- count, min, max, sum, avg, stddev, variance
-- �׷��Լ��� null�� ��꿡 �������� �ʽ��ϴ�.
-- 1) group by - ���̺��� ���ڵ带 Ư�� �÷� �������� �׷����Ҷ�
-- 2) having -�׷����Լ��� ������ ����

-- ����Ǵ� ������ ������ ����
-- select ~                     // 5
-- from ~                     //  1
-- where ~                    // �������� 2
-- group by ~                // 3
-- having ~                   // 4
-- order by ~                  // 6

group by ������ - rollup, cube, groupingsets

���տ�����  : 2���̻��� select�� ���(resultset, cursor)�� ���� ����������� ����
union all
union
minus
intersect
���տ����ڿ� �Բ� ����ϴ� select������ �÷�����, �÷�Ÿ�԰� ���� ��ġ

-----------------------------------------------------------------------------------------------------------------------

-- # join ����

col ����: projection?
row ����: select

-- 1. inner join, equi join
-- ���δ�� table�� ���� ���� �Ӽ��÷����� ��ġ�ϴ� record�� ����
-- �θ� table: Primary Key(PK), Unique(UK) : PK�� not null & unique, UK�� unique
-- �ڽ� table: Foriegn Key(FK)

-- 2. cross join
-- cartesian product

-- 3. non equi join

-- 4. self join
-- �ڱ������� ���� join
-- �ڱ��������� ���̺��� PK�� FK �÷����� ���� ����
-- select�� ����? 

-- 5. outer join
-- join �� ��, null ���� �������� ���� ���


-----------------------------------------------------------------------------------------------------------------------

-- # join ����

-- ���� ��� ���� ������  where, from �������� ��� �����ϴ�. 
-- 1) where ���� join ���� ����
-- 2) from ���� join ���� ����: sql 1999 ����: join �Լ� ���
-- natural join, join ~using, join ~on

-----------------------------------------------------------------------------------------------------------------------

-- # ��������

-- Q. ����̸�, �μ���ȣ, �μ��̸��� ��ȸ ����� ����
select ename, deptno, dname
from emp, dept; 
-- �� sql error
-- � table���� ���� �����;� �Ǵ��� �𸣱⿡ error�� ��
-- ���� �տ� ��ó table �̸��� �޾���
select emp.ename, emp.deptno,dept.dname
from emp, dept;

select a.ename, a.deptno, b.dname
from emp a, dept b;
-- 56row ��µ�
-- ���������� �����Ǿ� cartesian product�� ����

-- where�� join
select a.ename, a.deptno, b.dname
from emp a, dept b
where a.deptno = b.deptno;

-- from�� join
con hr/oracle
-- employees: 107rows
-- departments: 27rows

-- where ���� join ����
select  a.last_name, a.department_id, b.department_name
from employees a, departments b 
where a.department_id = b.department_id;
-- ���� ����� 107�̿��� �ϴµ� ���� 106�� ����
-- �̴� null ���� �ϳ� �ִٴ� �ǹ�

-- �׷��� join�� ���� �Լ��� �ִ°� �ƴ϶� ������ �߰������μ� �����ϴ� ��? : �Լ��� ����
-- ���� ������ where ���� ����, �ؿ��� from ���� ����
-- �׷��� where ���� ������ ���� �Լ��� ���� from���� ������ ���� �Լ��� �ִ� �ǰ�? ����

-----------------------------------------------------------------------------------------------------------------------

-- # from�� ���� join

-- 1. natural join
-- natural join : oracle ������ ������ �� ���̺��� ������ �̸��� �÷������� equi join ����
-- ������ �̸��� �÷��տ� ������ ���̺���̳� alias�� ������ �� ����
select  a.last_name, a.department_id, b.department_name
from employees a  natural join departments b ;-- error

select  a.last_name, department_id, b.department_name
from employees a  natural join departments b ; -- row 32
desc employees
desc departments
-- ������ �𵨸��� �߸��ؼ� �� ���̺��� ������ �Ӽ��� ���ؼ� �÷� �̸��� �ٸ���쿡�� ������ ������� ����
-- ���� ��� �����ϰ� ������ col�� manager_id, department_id �� ������ �� �ٸ� �������� join�� ��
-- �̷� ��� �����ϰ� ������ ���� col �� �ϳ��� �÷����θ� ������ �����ϱ� ���ؼ� join~using ���

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

-- dept�� ������ table�� col�� �ٸ��� �ؼ� ����� �ְ� Ȯ��
conn scott/oracle
create table dept2 (deptid, dname, loc)
as select * from dept;
desc dept2
select * from dept2;

select a.ename, deptno, b.dname
from emp a natural join dept2 b; --14rows
-- join�� �÷����� �ٸ��Ƿ� equi join�� �ƴ� cartesian join���� �����

-- 3. join ~ on
select a.ename, a.deptno, b.dname
from emp a join dept2 b on a.deptno = b.deptid; --14rows
-- �� ���⼭�� aliase ����? : natural join, join using�� �������� ������,join ~ on�� ����
-- join ~ on�� join�ϰ� where�� �ִ� ���ǰ� �ٸ�?

-- Q. �� ������� �޿��� �޿� ����� ��ȸ����ϴ� SQL �ۼ�
desc emp
desc salgrade
-- salgrade�� ����, ������ ���� ��� ���� ����

select a.ename, a.sal, b.grade
from emp a, salgrade b
where a.sal between b.losal and b.hisal; 

select a.ename, a.sal, b.grade
from emp a join salgrade b on a.sal between b.losal and b.hisal; 

-- �ڱ�����
-- Q. ����� ���, �̸�,�����ڹ�ȣ, ������ �̸��� ��ȸ���
select a.empno, a.ename, a.mgr, b.ename 
from emp a, emp b
where a.mgr = b.empno;

select a.empno, a.ename, a.mgr, b.ename 
from emp a join emp b on a.mgr = b.empno;

-- 3���� ���̺��� ������ join�� �Ϸ���?
-- Q. ����̸�, �ҼӺμ��̸�, �ҼӺμ� ��ġ(���ø�)���
conn hr/oracle
desc employees
desc departments
desc locations

select a.employee_id, b.department_name, c.city
from employees a join departments b on a.department_id = b.department_id
where  on b.location_id = c.location_id
from departments b join locations c;


