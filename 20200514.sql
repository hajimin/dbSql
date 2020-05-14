���� ��ȹ : SQL�� ���������� � ������ ���ļ� �������� ������ �ۼ�
            * ����ϴµ� ��� ���� ����� �ʿ�(�ð�)


2���� ���̺��� �����ϴ� SQL
2���� ���̺� ���� �ε����� 5�� �ִٸ� ������ �����ȹ ���� �? ������ ���� ==> ª�� �ð��ȿ� �س��� �Ѵ�(������ ���� �ؾ��ϹǷ�)


���� ������ SQL�� ����� ��� ������ �ۼ��� �����ȹ�� ������ ���
���Ӱ� ������ �ʰ� ��Ȱ���� �Ѵ�(���ҽ� ����)


���̺� ���� ��� : ���̺� ��ü(1), ������ �ε���(5)
a => b
b => a
����� �� : 16�� & 2�� = 72��

������ SQL�̶� : SQL������ ��ҹ��ڿ� ������� ��ġ�ϴ� SQL
�Ʒ� �ΰ��� sql�� ���� �ٸ� sql�� �ν��Ѵ�
SELECT * FROM emp;
select * FROM emp;

SELECT /*202004_B*/ *
FROM emp;

Select /*202004_B*/ *
FROM emp;

Ư�������� ������ ��ȸ�ϰ� ������ : ����� �̿��ؼ�
SELECT /*202004_B*/ *
FROM emp
WHERE empno=7499; --�ΰ��� ��ȸ;

SELECT /*202004_B*/ *
FROM emp
WHERE empno=:empno; --�޸𸮸� ȿ�������� �����Ϸ��� ���ε� ������ �̿��� ��ȸ;

�����м�(�����ȹ) - ���ε� -  - 

���۸� : ��ݴ����� ä���ִ� ��


SELECT *
FROM sem.V_emp;

sem.V_emp ==> V_emp

SELECT *
FROM V_emp; --> ����

SYNONYM : ��ü�� ��Ī�� �����ؼ� ��Ī�� ���� ���� ��ü�� ���
���� :  CREATE SYNONYM �ó�� �̸� for ��� ������Ʈ;

sem.V_emp ==> V_emp �ó������ ����

CREATE SYNONYM V_emp for sem.V_emp;

V_emp�� ���� ������ü�� sem.V_emp�� ����� �� �ִ�

SELECT *
FROM V_emp;

SQL CATEGORY
DML ��κ� SELECT �̴�
DDL 
DCL ���Ѻο�/ȸ��
TCL

DCL 
���� �ο� (GRANT)
���� ȸ�� (REVOKE)

����Ŭ ���� 
 1. �ý��� ���� : �ý��۰���, ����
 2. ��ü ���� : ��ü ����
 
DATA Dictionary : �ý��� ������ �� �� �ִ� view, ����Ŭ�� ��ü���� ����
category (���ξ�)
USER : �ش� ����ڰ� �����ϰ� �ִ� ��ü ���
ALL : �ش� ����� ���� + ������ �ο����� ��ü ���
DBA : ��� ��ü ���
V$ : ����, �ý��� ����

SELECT *
FROM USER_tables;

SELECT *
FROM ALL_tables;
 
SELECT *
FROM DBA_tables; --���� ���� SYSTEM �������� Ȯ��

SELECT *
FROM dictionary;

Multiple insert : �������� �����͸� ���ÿ� �Է��ϴ� insert �� Ȯ�屸��

1.unconditional insert : ������ ���� �������̺� �Է��ϴ� ���
���� : 
    INSERT ALL
        INTO ���̺��
        [,INTO ���̺��]
    VALUES (...) | SELECT QUERY;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (9999, 'brown',98);


emp_test1���̺��� �̿��Ͽ� emp_test2 ���̺� ����
CREATE TABLE emp_test2 AS
SELECT *
FROM emp_test
WHERE 1=2;

EMPNO, ENAME, DEPTNO

emp_test, emp_test2���̺� ���ÿ� �Է�
INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 9998, 'brown', 88 FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

SELECT *
FROM emp_test;

SELECT *
FROM emp_test2;


2. conditional insert : ���ǿ� ���� �Է��� ���̺��� ����
INSERT ALL 
    WHEN ���� .... THEN 
        INTO �Է����̺� VALUES
    WHEN ���� .... THEN 
        INTO �Է����̺�2 VALUES
    ELSE  
        INTO �Է����̺�3 VALUES

SELECT ����� ���� ���� EMPNO = 9998�̸� EMP_TEST���� �����͸� �Է�
                     �׿ܿ��� EMP_TEST2�� �����͸� �Է�
INSERT ALL 
    WHEN empno = 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno) 
    ELSE
        INTO emp_test2 (empno, deptno) VALUES (empno, deptno)   
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;

ROLLBACK;

conditional insert (all) = > first;

INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno<= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony', 88 FROM dual;



merge : �����͸� �Է��� �ϰų� ������ �ϰ� ������, ������ key�� �ƴϸ� �Է�, ������ key�� ������ ����
      : �ϳ��� ������ ���� �ٸ� ���̺�� �����͸� �ű��Է�, �Ǵ� ������Ʈ �ϴ� ����
���� :
MERGE INTO ���� ���(emp_test)
USING (�ٸ� ���̺� | VIEW | subquery)
ON (�������� USING ���� ���������� ���)
WHEN NOT MATCHED THEN 
    INSERT (col1, col2..) VALUES (value1, value2...)
WHEN MATCHED THEN
    UPDATE SET col1=value1, col2=value2

1. �ٸ� �����ͷκ��� Ư�� ���̺�� �����͸� �����ϴ� ���      
2.  KEY�� ���� ��� INSERT
    KEY�� ���� �� UPDATE
    
emp���̺��� �����͸� emp_test ���̺�� ����
emp ���̺��� �����ϰ� emp_test���̺��� �������� �ʴ� ������ �ű��Է�
emp ���̺��� �����ϰ� emp_test���̺��� �����ϴ� ������ �̸�����

INSERT INTO emp_test VALUES (7369, 'cony', 88);
SELECT *
FROM emp_test;

emp���̺��� 14�� �����͸� emp_test ���̺� ������ empno�� �����ϴ��� �˻��ؼ�
������ empno�� ������ insert-empno, ename, ������ empno�� ������ update-ename

MERGE INTO emp_test
USING emp 
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES(emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;

SELECT *
FROM emp_test;

���� �ó������� 
9999�� ������� �ű��Է��ϰų�, ������Ʈ�� �ϰ� ���� ��
(����ڰ� 9999��, james����� ����ϰų� ������Ʈ�ϰ� ���� ��)
���� ���� ���̺� ==> �ٸ� ���̺�� ����

�̹��� �ϴ� �ó����� : �����͸� ==> Ư�����̺�� ���� (�� ���� ����)
(9999, james)

MERGE ������ ������� ������
SELECT *
FROM emp_test
WHERE empno=9999;


�����Ͱ� ������ ==> UPDATE
�����Ͱ� ������ ==> INSERT

//���ֻ��//
MERGE INTO emp_test
USING dual 
    ON (emp_test.empno=9999)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

SELECT *
FROM emp_test;


MERGE INTO emp_test
USING (SELECT 9999 eno, 'james' enm
        FROM dual) a
    ON (emp_test.empno = a.eno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

emp���̺��� 7698�� ������ �̸���
emp_test ���̺��� 9999�� ������ �̸����� ������Ʈ�ϴ� merge���� �ۼ�
���� 9999�� ������ emp_test �� ������ empno= 9999, 
                                        ename= emp���̺��� 7698 ������ �̸� , deptno= null�� �ű��Է�

MERGE INTO emp_test
USING emp 
    ON (emp_test.empno=7698)
WHEN NOT MATCHED THEN
    INSERT (empno, ename, deptno) VALUES (9999, 'BLAKE', null)
WHEN MATCHED THEN
    UPDATE SET empno = 9999;


report group function


SELECT deptno, SUM(sal) 
FROM emp
GROUP BY deptno


SELECT SUM(sal)
FROM emp;

==> �ΰ��� ���̺� ���ļ� ���




union���
emp���̺��� �̿��Ͽ� �μ���ȣ�� ������ �޿� �հ�, ��ü ������ �޿����� ��ȸ�ϱ� ���� 
GROUP BY �� ����ϴ� �ΰ��� SQL�� ������ �ϳ��� ������ (UNION)�۾��� ����

SELECT deptno, SUM(sal) 
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp

==>GROUP BY ROLLUP���� ����

SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno);

����׷��� ������ : ROLLUP ���� ����� �÷� ���� + 1;


Ȯ��� GROUP BY 3���� 
1. GROUP BY ROLLUP
���� : GROUP BY ROLLUP (�÷�, �÷�2...)
���� : ����׷��� ������ִ� �뵵
����׷� ���� ��� : ROLLUP ���� ����� �÷��� �����ʿ������� �ϳ��� �����ϸ鼭 ����׷��� ����
������ ����׷��� UNION�� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

����׷� : 1. GROUP BY job, deptno
            UNION
          2. GROUP BY job
            UNION 
          3. ��ü�� GROUP BY 
         

==> �Ʒ������� ROLLUP �ϰ� ����


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job, deptno

UNION ALL

SELECT job, null, SUM(sal) sal
FROM emp
GROUP BY job

UNION 

SELECT null, null, SUN(sal) sal
FROM emp;