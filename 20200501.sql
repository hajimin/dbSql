�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex : ��ü������ �޿����, SMITH ������ ���� �μ��� �μ���ȣ

WHERE ���� ��밡���� ������
WHERE deptno = 10
==> 

�μ���ȣ�� 10 Ȥ�� 30���� ���
WHERE deptno = IN(10,30)
WHERE deptno = 10 OR 30 

������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno IN(�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

SMITH - 20, ALLEN�� 30�� �μ��� ����
SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ��� 
==> ������������ ��밡���� ������ IN(���� ���� ��, �߿�!), (ANY, ALL)

IN : ���������� ����� �� ������ ���� ���� �� TRUE
    WHERE �÷�|ǥ���� IN (��������)
    
ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷�|ǥ���� ������ ANY (��������)

ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷�|ǥ���� ������ ALL (��������)

SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
[1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
SELECT deptno
FROM emp
WHERE ename IN('SMITH', 'ALLEN');

[1-2] 1-1���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� �������� ��ȸ
SELECT deptno
FROM emp
WHERE ename IN(20,30);

==> ���������� �̿��ϸ� �ϳ��� SQL���� ���డ��
SELECT deptno
FROM emp
WHERE deptno IN(SELECT deptno
               FROM emp
               WHERE ename IN('SMITH', 'ALLEN'));

sub3
SELECT *
FROM emp
WHERE sal IN(SELECT deptno
               FROM emp
               WHERE ename IN('SMITH', 'WORD'));


[����]
ANY, ALL
SMITH(800)�� WORD(1250) �� ����� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ 
==> sal < 1250;
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN('SMITH', 'WORD'));
                
SMITH(800)�� WORD(1250) �� ����� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ 
==> sal > 1250;

SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN('SMITH', 'WORD'));

IN �������� ����
�ҼӺμ��� 20, Ȥ�� 30�� ���
WHERE deptno IN (20,30)

�ҼӺμ��� 20, 30�� ������ �ʴ� ���
WHERE deptno NOT IN (20,30)

NOT IN �����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�

�Ʒ� ������ ��ȸ�Ǵ� ����� � �ǹ� �ΰ�?
SELECT *
FROM emp
WHERE empno NOT IN(SELECT mgr
                    FROM emp);
--> emp���̺� ����� �� mgr(�Ŵ���)�� �ƴ� ��� ��ȸ
--> NULL�� �ֱ� ������,,  �� ������ ������ ���� ���� 

--> NULL���� ���� ���� ����!

1. WHERE������ ó��
SELECT *
FROM emp
WHERE empno NOT IN(SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);
2. NVLó��
SELECT *
FROM emp
WHERE empno NOT IN(SELECT NVL(mgr, -1)
                    FROM emp);


���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT *
FROM emp
WHERE empno IN(7499,7782);

SELECT mgr, deptno
FROM emp
WHERE empno IN(7499,7782);

WHERE empno IN(7499); = WHERE empno = 7499;


7499, 7782����� ������ (���� �μ�, ���� �Ŵ���)�� ��� ���� ���� ��ȸ
�Ŵ����� 7689�̸鼭 �ҼӺμ��� 30�� ���
�Ŵ����� 7839�̸鼭 �ҼӺμ��� 10�� ���

mgr �÷��� deptno�÷��� �������� ����
(7698,10)
(7698,30)
(7839,10)
(7839,30)

�������ϴ� ��
(7698,30)
(7839,10)

�Ʒ� ������ ��� ���� ����
SELECT *
FROM emp
WHERE mgr IN(7698,7839)
  AND deptno IN(10,30);

�׷��� ���� ���ϴ� ���� ������ �Ϸ���
PAIRWISE ����*( ���� �������� ����� �� �� ����)
SELECT *
FROM emp
WHERE (mgr,deptno) IN(SELECT mgr, deptno
                      FROM emp
                      WHERE empno IN(7499,7782));
                      
                      

(�߿��� �� �ƴ�����, ����)                      
�������� ����-��� ��ġ
SELECT - ��Į�� ��������
FROM - �ζ��� ��
WHERE - ��������


�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
    ���� �÷�(��Į�� ���� ����)
    ���� �÷�
���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�
    
��Į�� ��������
SELECT ���� ǥ���Ǵ� ��������
���� �� ���� �÷��� �����ϴ� ���������� ��밡��
���� ������ �ϳ��� �÷�ó�� �ν�

�̷��Ե� ���� ������ �� ������ ����� ����
SELECT 'X',(SELECT SYSDATE FROM dual);
FROM dual;

��Į�� ���������� �ϳ��� ��, �ϳ��� �÷��� ��ȯ�ؾ��Ѵ�.

���� �ϳ�����, �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename, FROM emp WHERE ename='SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ���� ==> ����
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

�� ������ ��Į�� ���������� ����

SELECT empno, ename, deptno, �μ���
FROM emp;

����
SELECT empno, ename, deptno, dname
FROM emp JOIN dept ON (emp deptno = dept.deptno);

��Į�� ��������
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno)
FROM emp;


�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
    .���������� ����Ǿ�� ���������� ������ �����ϴ�(����)

���ȣ���� ��������(non corelated sub query)
    .main������ ���̺��� ���� ��ȸ�� ���� �ְ�
     sub������ ���̺��� ���� ��ȸ�� ���� �ִ�
     ==> ����Ŭ�� �Ǵ������� ���ɻ� ������ �������� ��������� ����
    
��� ������ �޿���� ���� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ��ϼ���(�������� �̿�)
SELECT *
FROM emp 
WHERE sal > (SELECT avg(sal) 
              FROM emp);

�����غ� ����, ���� ������ ��ȣ���� ���� �����ΰ�? ���ȣ ���� ���� ���� �ΰ�?
���ȣ����


������ ���� �μ��� �޿���պ��� ���� �޿��� �޴� ����
��ü ������ �޿���� ==> ������ ���� �μ��� �޿����


Ư���μ�(10)�� �޿������ ���ϴ� SQL
SELECT avg(sal) 
FROM emp 
WHERE deptno = 10;


SELECT *
FROM emp e
WHERE sal > (SELECT avg(sal) 
             FROM emp 
             WHERE deptno = e.deptno);


OUTER JOIN
������ ���еǴ��� �������� ���� ���̺��� �÷� ������ ��ȸ�� �ǵ��� �ϴ� ���ι��
table LEFT OUTER JOIN table2
==> table�� �÷��� ���ο� �����ϴ��� ��ȸ�� �ȴ�
(ORACLE 9i ���������� ������ �Ǵ� ���̺� ���� �д´�
==> oracle 10g ���ĺ��ʹ� ���ɻ� ������ ���̺� ���� �д´�)

SELECT *
FROM dept;


insert into dept values (99,'ddit', 'deajeon');

emp���̺� ��ϵ� �������� 10,20,30�� �μ����� �ҼӵǾ� ����
���� �Ҽӵ��� ���� �μ� 40,99


SELECT * 
FROM dept (SELECT *
            FROM deptno NOT IN (10,20,30));


������ �Ѹ��̶� �����ϴ� �μ�
SELECT * 
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);


���������� �̿��Ͽ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� �����Ҷ�
���� ������ �־ �������(����)

SELECT deptno NOT IN (10,10,10);
FROM deptno =10;
OR deptno =10;
OR deptno =10;


������ �μ���ȣ�� ������������ ��ȸ���� �ʵ��� �����Ϸ��� �׷쿬���� �� ���( ���� �´�)
SELECT *
FROM dept 
WHERE deptno NOT IN(SELECT deptno 
                    FROM emp;
                    GROUP BY deptno;


SELECT pid,pnm
FROM product
WHERE pid NOT IN(SELECT pid FROM cycle WHERE cid =1);

[sub5]
SELECT cid, pid, day, cnt
FROM cycle 
WHERE cid = 1 IN (SELECT cid
                   FROM cycle 
                   WHERE cid = 2);
                   
                   
                   
[sub6]
1�� ���� ������ǰ ������ ��ȸ�� �Ѵ�.
�� 2�� ���� �Դ� ������ǰ�� ��ȸ�� �Ѵ�.

1�� ��
SELECT cid, pid, day, cnt
FROM cycle
WHERE cid = 1

2�� ��
SELECT pid
FROM cycle
WHERE cid = 2

��ġ��
SELECT cid, cnm, pid, day, cnt
FROM cycle, customer, product
WHERE cid = 1 AND pid IN(SELECT pid
                         FROM cycle
                         WHERE cid = 2);
                         
                         
[sub7]  
������ �̿��� ���
SELECT c.cid, cnm, c.pid, pnm, day, cnt
FROM cycle c JOIN customer ON(customer.cid = c.cid AND c.cid = 1)
           JOIN product ON(product.pid = c.pid) AND c.pid IN(SELECT pid
                                                                FROM cycle
                                                                WHERE cid = 2);

��Į�� ���������� �̿��� ���
SELECT cid (SELECT cnm FROM customer WHERE cid = cycle.cid ) cnm
       pid (SELECT pnm FROM customer WHERE pid = cycle.pid ) pnm, day, cnt
FROM cycle
WHERE cid =1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid =2);
