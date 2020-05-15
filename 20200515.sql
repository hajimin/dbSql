ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY �� ����

�Ʒ� ������ ����׷�
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP �� ����� �÷��� +1

�ǽ� 2
SELECT NVL(job, '�Ѱ�'),deptno, 
        GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT 
CASE
    when GROUPING(job) = 1 THEN '�Ѱ�'
    ELSE job
END job,
 deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);


�ǽ�
SELECT 
CASE
    WHEN GROUPING(job) = 1 THEN '��' 
    ELSE job
END job, 
CASE
    WHEN GROUPING(job) = 1 THEN '��'
    WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
    ELSE TO_CHAR(deptno)
    END deptno, SUM(sal) sal_sum
FROM emp
GROUP BY ROLLUP (job, deptno);

�ǽ�3
SELECT deptno,job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno,job);


�ǽ� 4 
REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION �� �����ϸ�
�������� SQL�� �ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� �������� ����

=> ���� ���ϰ� �ϴ°� REPORT GROUP FUNCTION 

ROLLUP���� ����Ǵ� �÷��� ������ ��ȸ����� ������ ��ģ��
(****** ���� �׷��� ����� �÷��� �����ʺ��� �����س����鼭 ����)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

OUTER JOIN ����

SELECT dept.dname, emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno=dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

�ζ��κ� ����
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno,job, SUM(sal) sum_sal
FROM emp 
GROUP BY ROLLUP (deptno,job))a, dept
WHERE a.deptno=dept.deptno;


�ǽ� 5
SELECT  NVL(dept.dname,'�Ѱ�'), emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno=dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


2.GROUPING SETS
ROLLUP�� ���� : ���ɾ��� ����׷쵵 �����ؾ��Ѵ�.
            ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
            ���� �߰������� �ִ� ����׷��� ���ʿ��� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼭�� ����
                
���� : GROUP BY GROUPING SETS (col1, col2)

GROUP BY col1
UNION ALL
GROUP BY col2


��� ����? �� ����~
GROUP BY GROUPING SETS (col1, col2)
GROUP BY GROUPING SETS (col2, col1)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�Ʒ������� ����

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY (job);

UNION

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY (deptno);

�׷������
1.job, deptno
2. mgr

GROUP BY GROUPING SETS ((job, deptno), mgr)


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);


3. CUBE
���� : GROUP BY CUBE

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


�������� REPORT GROUP ����ϱ�
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);


**�߻������� ������ ���
1       2       3
job     deptno  mgr    => GROUP BY job, deptno, mgr
job     X       mgr    => GROUP BY job, mgr
job     deptno  X      => GROUP BY job, deptno
job     X       X      => GROUP BY job


SELECT job,deptno, mgr, SUM(sal+NVL(comm,0))sal
FROM emp
GROUP BY job, rollup(job, deptno), CUBE(mgr);

1       2           3
job     job ,deptno  mgr     => GROUP BY job, job,deptno,mgr ==> GROUP BY job, deptno,mgr
job     job          mgr     => GROUP BY job,job, mgr ==> GROUP BY job, mgr
job     X            mgr     => GROUP BY job, x, mgr==> GROUP BY job, mgr
job     job ,deptno  X       => GROUP BY job, job, deptno ==> GROUP BY job,deptno
job     job          X       =>  GROUP BY job, job, X ==>  GROUP BY job
job     X            X       =>  GROUP BY job, X, X==> =>  GROUP BY job

��ȣ���� �������� ������Ʈ
1. emp ���̺��� �̿��Ͽ� emp_test ���̺� ����
==>������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS 
SELECT *
FROM emp;

2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
DESC emp;  
ALTER TABLE dept_test ADD (dname VARCHAR2(14));
DESC emp_test;

3. subquery �� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ���ִ� ������ �ۼ�
emp_test �� dname �÷��� ���� dept ���̺��� dname�÷����� update
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname �÷����� ������ update

SELECT *
FROM emp;

emp_test���̺��� dname �÷��� dept ���̺��� �̿��ؼ� dname���� ��ȸ�Ͽ� ������Ʈ
UPDATE����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����

��������� ������� dname �÷��� dept���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);
                             
�ǽ� 1
DROP TABLE dept_test;

CREATE TABLE dept_test AS 
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER(4));

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno
                                GROUP BY deptno);
                             
SELECT *
FROM dept_test;

SELECt ��� ��ü�� ������� �׷��Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����

SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;



