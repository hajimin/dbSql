SELECT ���� ���� : 
    ��¥���� (+,-) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    �������� (...) 
    ���ڿ� ����
        ���ͷ� : ǥ����
                ���� ���ͷ� : ���ڷ� ǥ��
                ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                            SELECT SELECT * FROM || 'sql'
                            SELECT 'SELECT' * FROM || table name
                    ���ڿ� ���տ��� : +�� �ƴ϶� || (java ������ +)
                ��¥?? : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                        TO_DATE('20200417', 'yyyymmdd')
                        
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ�ǵ��� ����;

SELECT *
FROM users
WHERE userid = 'brown';

SELECT *
FROM users
WHERE 1 = 1;


sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND;
�񱳴�� �÷� / BETWEEN �� AND ���۰� ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �۵����� ����

java sal >= 1000 && sal <= 2000
sql sal >= 1000 AND sal <= 2000


SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
    AND sal <= 2000;

exclusive or (��Ÿ�� or)
a or b a= true,b= true ==> true  
a exclusive or b a= true,b= true ==> false

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE ('19820101', 'YYYYMMDD') AND TO_DATE ('19830101', 'YYYYMMDD');


SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE ('19800101', 'YYYYMMDD') AND TO_DATE ('19821231', 'YYYYMMDD');



SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE ('19820101', 'YYYYMMDD') 
AND hiredate <= TO_DATE ('19830101', 'YYYYMMDD');

IN ������
�÷� : Ư���� IN (��1, ��2,...)
�÷��̳� Ư������ ��ȣ�� ���߿� �ϳ��� ��ġ�ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10,30); 
==> deptno�� 10���̰ų� 30���� ����
deptno = 10 or deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
OR deptno = 30; 


���� �ƴ�
SELECT *
FROM emp

WHERE 10 = 10
AND 10 = 30; 

//����
SELECT userid as ���̵�,usernm as �̸�,alias as ����
FROM users
WHERE userid IN ('brown', 'cony', 'sally'); 

���ڿ� ��Ī ���� LIKE ���� / java startWith(prefix), .endsWith(suffix)
����ŷ ���ڿ� : % ��� ���ڿ�(��������)
               _ � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

�÷� Ư���� LIKE ���� ���ڿ�;


'cony' = cony�� ���ڿ�
'co%' : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵��� �� �� �ִ� ���ڿ�
        'cony' 'con' 'coe' 'co'
'%co%' : co�� �����ϴ� ���ڿ�
        'cony'  'sally cony' 
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �� �� �ִ� ���ڿ�


//�����̸��� �빮�� s�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

NULL ��
SQL �񱳿����� : 
    WHERE usernm = 'brown'
    
mgr ���� ���� ��� ����   

sql���� NULL���� ���� ��� �Ϲ������� �񱳿�����(=)�� �����ϰ� IS ������ ���

SELECT *
FROM emp
WHERE mgr IS NULL;

���� �ִ� ��Ȳ���� � �񱳴� : =, !=, <> ���
NULL : IS NULL, IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�ƴ� ������ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

//���� 
SELECT *
FROM emp;
WHERE comm IS NOT NULL;

������
AND
OR
NOT

//��������

SELECT *
FROM emp
WHERE mgr = 7698
    AND sal > 1000;


SELECT *
FROM emp
WHERE mgr = 7698
    OR sal > 1000;

AND����  OR�� ����Ҽ��� ��ȸ�Ǵ� �����Ͱ� ��������

SELECT *
FROM emp
WHERE mgr IN (7698,7839);

SELECT *
FROM emp
WHERE mgr IN (7698,7839);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839)
==> WHERE mgr != 7698 AND mgr != 7839

NULL���ϰ� ������ ������ ���� ����ؾߵ�
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839)
OR mgr IS NULL;


//��������7
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD')
AND sal > 1300;

//��������8
SELECT *
FROM emp
WHERE deptno !=10
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

//��������9
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

//�������� 10
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND deptno IN (10,20,30)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

//�������� 11
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');



//�������� 12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND empno LIKE '78%';

//�������� 12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%'; //����ȯ�ϱ� ���߿� ������ �� �� ���� ���� ��� ����//

//�������� 13
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899;

//�������� 14
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR (empno >= 7800 AND empno <= 7899)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');



���� : {a, b, c} = {a, c, b}

table���� ��ȸ, ���� �� ������ ����(�������� ����)
���� ��ȸ�� ����� ���� ��ȸ�� ����� ���� ����
==> ���հ� ����

SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�

<�����>
ORDER BY �÷��� [��������], �÷���2, ......


���� �ΰ��� ��������(DEPAULT) - ASC, �������� - DESC
�������� �������� ������ �⺻������ ��������

//����

���� �̸����� ������������

SELECT *
FROM emp
ORDER BY ename ASC;

���� �̸����� ������������

SELECT *
FROM emp
ORDER BY ename DESC;


job�� �������� �������� �����ϰ� job�� ���� ��� �Ի����ڷ� �������� ����
��� ������ ��ȸ

SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC;


SELECT *
FROM emp
WHERE deptno IN (10,20);


SELECT a.*
FROM 
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
 FROM emp
 ORDER BY ename asc) a ) a
 WHERE rn BETWEEN 1 + (:page -1) * :pagesize AND :page * :pagesize;


SELECT *
FROM emp
WHERE ename LIKE 'S%T%H'
AND deptno NOT IN(15);
