table���� ��ȸ/���� ������ ����.
==> ORDER BY �÷��� ���Ĺ��,...

ORDER BY �÷����� ��ȣ�� ���İ���
���� ==> �÷��� ������ �ٲ�ų�, �÷��߰��� �Ǹ� ���� �ǵ���� �������� ���� ���ɼ��� ����

SELET�� 3��° �÷��� �������� ����
SELECT *
FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
SAL*DEPTNO SAL_DESC

SELECT empno, ename, sal, deptno, sal*deptno, sal_dept
FROM emp
ORDER BY sal_dept;

//�ǽ� dept
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;
//
SELECT *
FROM emp
ORDER BY comm DESC
WHERE comm IS NOT NULL
AND ORDER BY empno; 

SELECT *
FROM emp
WHERE comm != 0 
ORDER BY comm DESC, empno;


//
SELECT *
FROM emp
WHERE deptno in (10,30) 
AND sal > 1500
ORDER BY ename DESC;

����¡ ó���� �ϴ� ����
1. �����Ͱ� �ʹ� �����ϱ�
  - �� ȭ�鿡 ������ ��뼺�� ��������
  - ���ɸ鿡�� ��������
  
����Ŭ���� ����¡ ó�� ��� ==> ROWNUM

ROWNUM : SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� Ű����


SELECT���� *ǥ���ϰ� �޸��� ���� �ٸ� ǥ��(ex ROWNUM) �� ����� ���
==> �տ� � ���̺� ���� ���� ���̺� ��Ī/ ��Ī�� ����ؾ� �Ѵ�.

//��� emp������ ��ȸ�Ϸ��� *�տ� emp. �� ���� �� 
SELECT ROWNUM, e.*
FROM emp e;


//����¡ ó���� ���� �ʿ��� ���� 
1. ������ ������(10)
2. ������ ���Ŀ� ���� ����

1page : 1~10
2page : 11~20 (11~14)

1 ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

2 ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20; // ���� �ȵ�

ROWNUM�� Ư¡
1. ORACLE���� ����
 - �ٸ�DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ���� (LIMIT)
 
2. 1�� ���� ���������� �д� ��츸 ����
  ROWNUM BETWEEN 1 AND 10 ==> 1~10
  ROWNUM BETWEEN 11 AND 20 ==> 1~10�� SKIP�ϰ� 11~20�� �������� �õ�
  
  WHERE ������ ROWNUM�� ����� ��� ���� ����
  ROWNUM = 1;
  ROWNUM BETWEEN 1 AND N;
  ROWNUM <, <= N (1~N)

ROWNUM�� ORDER BY
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;


SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM�� ORDER BY ������ ����
SELECT -> ROWNUM -> ORDER BY

ROWNUM�� ��������� ���� ������ �� ���·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW�� ����ؾ� �Ѵ�.
** IN-LINE : ���� ����� �ߴ�.

SELECT ROWNUM, a.*
FROM
    (SELECT ROWNUM rn, a.*
     FROM 
        (SELECT empno, ename
         FROM emp
         ORDER BY ename) a ) a   //1���� ���̺� -> �˸��ƽ� ������ �����ְ� �����ؾ� ��.
WHERE rn BETWEEN 11 AND 20;  //-> ����������.

SELECT a.*
FROM
    (SELECT ROWNUM rn, a.*
     FROM 
        (SELECT empno, ename
         FROM emp
         ORDER BY ename) a ) a 
WHERE rn BETWEEN 1 + (:page - 1) * :pagesize AND :page * :pagesize;



1+(n+1)*10 �̶�� ���� �� �� �ִ�.
WHERE rn BETWEEN 1 AND 10; 1PAGE
WHERE rn BETWEEN 11 AND 20; 2PAGE 
WHERE rn BETWEEN 21 AND 30; 3PAGE
.
.
WHERE rn BETWEEN x AND pagesize * n; n PAGE
WHERE rn BETWEEN 1+(n+1)*10 AND pagesize * n; n PAGE //n, pagesize��� ������ Ȱ���� �� �ִ� ������ �ݷ��� �̿�


����

ù��° �ζ��� ��  - ROWNUM�� ������ �A ������ ���� ����������
SELECT empno, ename
FROM emp
ORDER BY ename;
         
         
�ι�° �ζ��� �� 
SELECT ROWNUM rn, a.*
FROM 
(SELECT empno, ename
 FROM emp
 ORDER BY ename) a;
 
INLINE-VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�)
VIEW - ����

DML - Data Manipulation Language : SELECT, INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME



CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
//���ѵ� �ذ��ؾ��Ѵ� -> system���� ����
//GRANT CREATE VIEW TO jm;



IN-LINE VIEW�� �ۼ��� ����
SELECT *
FROM (SELECT empno, ename
      FROM emp
      ORDER BY ename);




VIEW�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;


emp���̺� �����͸� �߰��ϸ�
in-line view, view�� ����� ������ ����� ��� ������ ������?

//������ �߰��ϴ� ����
INSERT INTO emp (empno, ename) VALUES (9999, '����');
SELECT empno, ename
FROM emp;

VIEW�� ��ü�� ����, ���̺� �ƴ�

���� �ۼ��� ������ ã�ư���

java : �����
SQL : ����� ����(������) ����


����¡ ó�� ==> ����, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM���� ������ �ϸ� ���ڰ� ���̴� ���� �߻� ==> INLINE-VIEW
 ���Ŀ� ���� INLINE-VIEW
 ROWNUM�� ���� INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn, a.* 
 FROM
  (SELECT empno, ename
   FROM emp
   ORDER BY ename) a )
WHERE rn BETWEEN 11 AND 20;


SELECT *
FROM
(SELECT ROWNUM rn, b.* // (������ ���� ��, ���� ���ʺ��� ������ ã�� ���� �� - ���� VIEW ���� ���������� �����غ� ��)
 FROM
  (SELECT empno, ename
   FROM emp
   ORDER BY ename) a )
WHERE rn BETWEEN 11 AND 20;

//���� 3
SELECT *
FROM
(SELECT ROWNUM rn, b.*
 FROM
  (SELECT empno, ename
   FROM emp
   ORDER BY ename) b )
WHERE rn BETWEEN 11 AND 20;

**�űԹ���
PRPD ���̺��� PROD_LGU(��������),PROD_COST(����)���� �����Ͽ� ����¡ ó�� ������ �ۼ��ϼ���
��, ������ ������� 5
���ε� ���� ����� ��

SELECT *
FROM
(SELECT ROWNUM rn, c.*
 FROM 
   (SELECT *
    FROM PROD
    ORDER BY PROD_LGU DESC, PROD_COST) c)
WHERE rn BETWEEN  (:page - 1) * :pagesize + 1 AND :page * :pagesize;



