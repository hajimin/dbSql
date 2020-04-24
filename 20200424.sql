NULLó����� �ϳ� �̻� ���


DESC emp;

SELECT NVL(empno,0), ename, NVL(sal, 0), NVL(comm, 0)-> �߸��� ���
FROM emp; //emp���̺����� nulló�� ���� ���� �ʾƵ���


     (�� ��� ����)
�̸�       ��?       ����           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    


condition : (CASE, DECODE)

�����ȹ : �����ȹ�� ����, ���� ����

SELECT *
FORM emp
ORDER BY deptno;

emp���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�ΰ�� SAL���� 5%�λ�� �ݾ��� ���ʽ��� ����(ex: sal 100->105)

�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30%�λ�� �ݾ��� ���ʽ��� ����
                �׿��� �μ��� ���ϴ� ����� 10%�λ�� �ݾ��� ���ʽ��� ���� 
�ش� ������ job�� PRESIDENT�ΰ�� SAL���� 20%�λ�� �ݾ��� ���ʽ��� ����
�׿� �������� SAL��ŭ�� ����

//decode�̿�//

DRCODE 

SELECT *
FROM emp;


SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal*1.05,
                    'MANAGER', 
                    DECODE(deptno, 10, sal*1.30, sal*1.10),
                    'PRESIDENT', sal*1.20,
                    sal) bonus
FROM emp;


���� A = {10,15,18,23,24,25,29,30,35,37}

�Ҽ� : �ڽŰ� 1�� ����� �ϴ� ��
Prime Numnber �Ҽ� : {23,29,37} : COUNT-3, MAX-37, MIN-29, AVG-29.66, SUM-89 => 3���� �����Ͱ� ��������� �ϳ��� ���� [ �׷��Լ� ]
��Ҽ� : {10,15,18,24,25,30,35};


ī���� + �޿��� �ջ�

SELECT *
FROM emp
ORDER BY deptno;


GROUP FUNCTION

�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�.
EX : �μ��� �޿� ���
    emp���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10,20,30)�� ���� �ִ�
        �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.



GROUP BY ����� ���ǻ��� : SELECT ����� �� �ִ� �÷��� ���ѵ�        

SELECT �׷��� ���� �÷�, �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY ];

�μ����� ���� ���� �޿� ��
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;








//���� : �׷��� �ϱ�� �� �÷��� �ƴ� ���� ����(ename) ������ �� .. ��, �׷��Լ� �����ϸ� ������ MIN(ename)
SELECT deptno, ename, MAX(sal), MIN(ename)
FROM emp
GROUP BY deptno; 



SELECT deptno, 
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), -- �μ����� ���� ���� �޿� ��
        AVG(sal), -- �μ��� �޿� ���
        ROUND(AVG(sal), 2),-- �Ҽ��� �ݿø�
        SUM(sal), -- �μ��� �޿� ��
        COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT (*), -- �μ��� ���� �� (����Ͻ����� ���� ����ϱ� ��)
        COUNT(mgr)
FROM emp
GROUP BY deptno;


SELECT --�׷� �÷����� ��� ������, GROUP BY �÷��� ���� ���� ������ �ȵ�
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), -- �μ����� ���� ���� �޿� ��
        AVG(sal), -- �μ��� �޿� ���
        ROUND(AVG(sal), 2),-- �Ҽ��� �ݿø�
        SUM(sal), -- �μ��� �޿� ��
        COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT (*), -- �μ��� ���� �� (����Ͻ����� ���� ����ϱ� ��)
        COUNT(mgr)
FROM emp
GROUP BY deptno;




* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
  ���� ���� �޿��� �޴� ����� �̸��� �� �� ����
      ==> ���� WINDOW/�м� FUNCTION�� ���� �ذᰡ��


emp���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� �����ϴ� ���

SELECT  MAX(sal), --��ü ���� �� ���� ���� �޿� ��
        MIN(sal), -- ��ü ���� �� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), -- ��ü ������ �޿� ���
        SUM(sal), -- ��ü ������ �μ��� �޿� ��
        COUNT(sal), -- ��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT (*), -- ��ü ���� �� (����Ͻ����� ���� ����ϱ� ��)
        COUNT(mgr) --mgr�÷��� null�� �ƴ� �Ǽ�
FROM emp;


27�� ���� ��ǥ
GROUP BY ���� ����� �÷��� 
    SELECT���� ������ ������?

GROUP BY ���� ����� �÷��� 
    SELECT���� ������?



�׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT���� ǥ���� �� �ִ�(�����ƴ�)
SELECT deptno, 'test',1,
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), -- �μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2),-- �Ҽ��� �ݿø�
        SUM(sal), -- �μ��� �޿� ��
        COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT (*), -- �μ��� ���� �� (����Ͻ����� ���� ����ϱ� ��)
        COUNT(mgr)
FROM emp
GROUP BY deptno;



GROUP�Լ� ����� NULL���� ���ܰ� �ȴ�.
30�� �μ����� NULL���� ���� ���� ������ SUM(comm)�� ���� ���������� ��� �� �� Ȯ�� �� �� �ִ�.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

*Ư���� ������ �ƴϸ� �׷��Լ� ��� ����� NULLó���� �ϴ� ���� ���ɻ� ����
NVL(SUM(comm),0) : COMM�÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL����(1ȸ ȣ��)
SUM(NVL(comm, 0)) : ��� COMM�÷��� NVL�Լ��� ������ (�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, NVL(SUM(comm),0), SUM(NVL(comm, 0)) --�Ѵ� ������ NVL�� ���� ������ ������ ���� �� ȿ������
FROM emp
GROUP BY deptno;


signle row�Լ��� where���� ����� �� ������
multi row�Լ��� (group �Լ�)�� where���� ����� �� ����,
GROUP BY �� ���� HAVING���� ������ ���

signle row�Լ��� where������ ��밡��
SELECT *
FROM emp
WHERE LOWER;

SELECT *
FROM emp
WHERE 
GROUP BY deptno;

�μ��� �޿� ���� 9000 �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

///��Ī ������ ��
SELECT 
        MAX(sal),
        MIN(sal),
        ROUND(AVG(sal), 2),
        SUM(sal),
        COUNT (sal). 
        COUNT (mgr),
        COUNT (*)
FROM emp
GROUP BY deptno


///
SELECT 
        MAX(sal)max_sal,
        MIN(sal)min_sal,
        ROUND(AVG(sal), 2)avg_sal,
        SUM(sal)sum_sal,
        COUNT (sal)count_sal,
        COUNT (mgr)count_mgr,
        COUNT (*)count_all
FROM emp
WHERE sal IS NOT NULL
OR mgr IS NOT NULL;


///
SELECT deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT (sal) count_sal,
        COUNT (mgr) count_mgr,
        COUNT (*) count_all
FROM emp
GROUP BY deptno
HAVING COUNT(sal) IS NOT NULL
OR COUNT(mgr) IS NOT NULL;

///
SELECT  DECODE(deptno, 10, 'ACCOUNTING', 
               20,'RESEARCH',
               30, 'SALES', 
               40, 'OPERATIONS', 'DDIT') dname, 
                MAX(sal) max_sal,
                MIN(sal) min_sal,
                ROUND(AVG(sal), 2) avg_sal,
                SUM(sal) sum_sal,
                COUNT (sal) count_sal,
                COUNT (mgr) count_mgr,
                COUNT (*) count_all
FROM emp
GROUP BY deptno
HAVING COUNT(sal) IS NOT NULL
OR COUNT(mgr) IS NOT NULL;

//����, �� �Ի��� �����
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_YYYYMM, COUNT (*) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

//������ �Ի��� ����� ��
SELECT TO_CHAR(hiredate, 'YYYY') hire_YYYY, COUNT (*) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

//��ü �÷� �߿��� �μ����� ���
SELECT COUNT (deptno) cnt
FROM dept;

//COUNT�� �ι� ��� ���
SELECT COUNT(COUNT (deptno)) cnt
FROM emp
GROUP BY deptno;



