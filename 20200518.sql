����׷� ���� ���
ROLLUP: �ڿ��� (�����ʿ���) �ϳ��� ���������� ����׷� ����
            => (deptno, job), (deptno) , wjscp
CUBE : 

sub_a2�ǽ�
DROP TABLE dept_test;

SELECT *
FROM dept;

DELETE dept
WHERE deptno NOT IN(10,20,30,40);

COMMIT;

CREATE TABLE dept_test AS 
SELECT *
FROM dept;

SELECT *
FROM dept_test;

INSERT INTO dept_test values (99,'it1', 'daejeon');
INSERT INTO dept_test values (98,'it2', 'daejeon');


DELETE dept_test
WHERE deptno NOT IN (SELECT deptno FROM emp);


40�� �μ� ����
DELETE dept_test
WHERE NOT EXISTS (SELECT 'X' 
                  FROM emp 
                  WHERE emp.deptno = dept.deptno);


sub_a3�ǽ�
SELECT *
FROM emp_test;


UPDATE emp_test SET sal = sal +  200 
WHERE sal <(�ش������� ���� �λ��� �޿������ ���ϴ� SQL);

ROLLBACK;
��ȣ���� �������� UPDATE 
UPDATE emp_test a 
SET sal = sal +  200 
WHERE sal <(SELECT avg(sal)
            FROM emp_test b
            WHERE a.deptno = b.deptno
            GROUP BY deptno);

SELECT *
FROM emp_test;

���Ŀ��� �ƴ����� , �˻� - ������ ���� ������ ǥ��
���������� ���� ��� 
1. Ȯ���� : ��ȣ���� �������� (EXISTS)
            ==> ���� �������� ���� ==> ���� ���� ����
2. ������: ���������� ���� ����Ǽ� ���� ������ ���� ���� ���ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno 
                FROM emp);
                             
SELECT *
FROM emp
WHERE mgr IN (7369, 7499, .....);

�μ��� �޿������ ��ü�޿���պ��� ū �μ��� �μ���ȣ, �μ��� �޿���� ���ϱ�

�μ��� ��� �޿�(�Ҽ��� ��°�ڸ����� ��������)
SELECT deptno, ROUND(avg(sal), 2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(avg(sal), 2)
FROM emp;


SELECT deptno, ROUND(avg(sal), 2)
FROM emp
GROUP BY deptno
HAVING ROUND(avg(sal), 2)>(SELECT ROUND(avg(sal), 2)
                           FROM emp);



WITH ���� �̿��� ���� ���� ��ȸ
WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERT)�� ������ �����Ͽ�
         SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸� 
         Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� keyword
         ��, �ϳ��� sql���� �ݺ����� sql ���� ������ ���� �� �� �ۼ��� sql�� ���ɼ��� ���� ������
         �ٸ� ���·� ������ �� �ִ��� Ȯ��
         
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal), 2)
    FROM emp
)

SELECT deptno, ROUND(avg(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(avg(sal), 2)>(SELECT*
                           FROM emp_avg_sal);

�������� : �޷¸����
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� �� ��ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM DUAL
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����(=�����ü�� ����)
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸� 10000�ǿ� ���� DISK I/O�� �߻�

SELECT ROWNUM
FROM emp
WHERE ROWNUM <=5;

1. �츮���� �־��� ���ڿ� ��� : 202005
    �־��� ����� �ϼ��� ���Ͽ� �ϼ��� ���� ����
    TO_DATE('202005', 'YYYYMM'), LEVEL
        

�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����    
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 7�� �÷��� �߰��� ����
        �Ͽ����̸� dt�÷�, �������̸� dt�÷�, ȭ�����̸� dt�÷�.... ������̹� dt�÷�
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'); 

�Ʒ�������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��� �並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 
        DECODE (TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '1', TO_DATE('202005', 'YYYYMM') + (LEVEL-1) sun,
        SECODE (TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '2', TO_DATE('202005', 'YYYYMM') + (LEVEL-1) mon
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'); 

SELECT dt, dt�� �����̹� dt, dt�� ȭ�����̹� dt.... 7���� �÷��߿� �� �ϳ��� �÷����� dt���� ǥ���ȴ�

SELECT dt, DECODE(d, 1,dt) sun, DECODE(d,2,dt)mon, DECODE(d,3,dt)tue,
            DECODE(d,4,dt) wed, DECODE(d,5,dt)thu, DECODE(d,6,dt)fri, DECODE(d,7,dt)sat
FROM
(SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D') d
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')); 

�������� ///////////// 

SELECT DECODE(d,1,iw+1,iw),
            MIN(DECODE(d, 1,dt)) sun, MIN(DECODE(d,2,dt)) mon, 
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt))fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY DECODE(d,1,iw+1,iw) 
 ORDER BY DECODE(d,1,iw+1,iw);




SELECT TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')
FROM dual;


SELECT 
            MIN(DECODE(d, 1,dt)) sun, MIN(DECODE(d,2,dt)) mon, 
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt))fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) - 
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw')+1 f_sun
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY f_sun 
 ORDER BY f_sun;




