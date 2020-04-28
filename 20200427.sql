//COUNT�� �ι� ��� ���//����
SELECT COUNT(*) cnt
FROM 
    (SELECT deptno /*deptno�÷��� 1�� ����, row�� 3�� ����*/
     FROM emp
     GROUP BY deptno);
     
DBMS : DataBase Management System
 ==> dbe
 
RDBMS : Relational DataBase Management System
 ==> ������ �����ͺ��̽� �����ý���


SELECT *
FROM emp;


JOIN ������ ����
ANSI - ǥ��
�������� ����(ORACLE)

JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
SELECT �� �� �ִ� �÷��� ������ ��������(����Ȯ��)

���տ��� ==> ���� Ȯ�� (���� ������)

NATURAL JOIN 
   - �����Ϸ��� �� ���̺��� ����� �÷��� �̸� ���� ���
   - emp, dept���̺��� detpno��� ����� (������ �̸���, Ÿ�Ե� ����) ����� �÷��� ����
   - �ٸ� ANSI -SQL������ ���ؼ� ��ü�� �����ϰ�, �������̺���� �÷����� �������� ������
     ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����

[emp ���̺� :14��]
[dept ���̺� : 4��]

SELECT *
FROM emp;

SELECT *
FROM dept;

�����Ϸ��� �÷��� ���� ������� ����
SELECT *
FROM emp NATURAL JOIN dept; /*�� ���̺��� �̸��� ������ �÷����� �����Ѵ�. ==> deptno*/

ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
����Ŭ ���� ����
 1. ������ ���̺� ����� FROM���� ����ϸ� �����ڴ� �ݷ�(,)
 2. ����� ������ WHERE���� ����ϸ� �ȴ�(ex: WHERE emp.deptno = dept.deptno)


SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno�� 10���� �����鸸 dept���̺�� �����Ͽ� ��ȸ
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND dept.deptno = 10;


ANSI-SQL : JOIN with using
 - JOIN�Ϸ��� ���̺� �� �̸��� ���� �÷��� 2���̻��϶�
 - �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
  
SELECT *
FROM emp JOIN dept USING (deptno);

�߿�/���� �߾�
ANSI-SQL : JOIN with ON 
  - �����Ϸ��� �����̺� �÷����� �ٸ���
  - ON���� ����� ������ ���
  
  
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
(�߿�)ORACLE �������� �� SQL�� �ۼ�
SELECT *
FROM emp, dept 
WHERE emp.deptno = dept.deptno;

JOIN�� ������ ����
SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
EMP ���̺��� ������ ������ ������ ��Ÿ���� ������ ������ mgr�÷��� �ش������� ������ ����� ����
�ش� ������ �������� �̸��� �˰� ���� �� 

ANSI_SQL�� SQL ���� : 
�����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
            ����� �÷� : ����.mgr = ������.empno
            ==> ���� �÷� �̸��� �ٸ���( MGR< EMPNO)
                ==> NATURAL JOIN, JOIN with USING�� ����� �Ұ����� ����
                    ==> JOIN with ON
                    
SELF JOIN : 

SELECT *
FROM emp a JOIN emp b ON (a.mgr = b.empno);

NONEUQI JOIN : ����� ������  =�� �ƴҶ�
�׵��� WHERE���� ����� ������ : =, !=, <>, <=, <, >, >=
                                AND, OR, NOT
                                LIKE %, _ 
                                OR - IN
                                BETWEEN AND ==>  >=, <=
                                
SELECT *
FROM salgrade;

SELECT *
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

���ϴ� ������ SELECT���� ���
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE ���� �������� ����
 
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
 
//�ǽ� join0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname 
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

//�ǽ� join0 ORACLE��������
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

//�ǽ� join0_1

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
  AND emp.deptno IN (10,30);
  
//�ǽ� join0_1 ORACLE��������
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno IN (10,30);

//�ǽ� join0_2
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
  AND emp.sal > 2500;
  
//�ǽ� join0_2 ORACLE��������
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500; 


























