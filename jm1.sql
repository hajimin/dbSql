

SELECT prod_id as ���̵�, prod_name �̸� 
FROM prod;

SELECT * 
FROM users;

SELECT userid || usernm AS id_name, 
       CONCAT(userid, usernm) AS concat_id_name

SELECT userid, reg_dt, reg_dt + 5, reg_dt - 5
FROM users;

SELECT userid as "�� �� ��"
FROM users;

SELECT prod_id as id, prod_name name
FROM prod;

SELECT lprod_gu as gu, lprod_nm nm
FROM lprod;

SELECT '���̵� : ' || userid AS "id name"
FROM users;

SELECT 'SELECT * FROM ' || table_name || ';' AS "QUREY" 
FROM user_tables;

SELECT *
FROM user_tables;

DESC emp;

SELECT * 
FROM user_tab_columns;

��ȸ�� ���� �����ϴ� ������ ��� : WHERE

SELECT *
FROM users
WHERE userid != 'moon';

SELECT *
FROM dept;

emp���̺��� ������ ���� ��ȣ(10)���� ū �μ��� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno > 10;

emp ���̺��� 1981.01.01 ���� ���� ��ȸ
SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE('1981.01.01', 'YYYY.MM.DD');

SELECT *
FROM users;

SELECT reg_dt, reg_dt + 5 
FROM users;

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

//4��
SELECT userid as ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN('brown', 'cony', 'sally');

SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE job LIKE 'C____';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

SELECT *
FROM emp
WHERE mgr IS NULL;

SELECT *
FROM emp;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE mgr = 7698
  AND sal > 1000;


SELECT *
FROM emp
WHERE mgr = 7698
   OR sal > 1000;
   
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('1981.06.01', 'YYYY.MM.DD');

SELECT *
FROM emp
WHERE deptno != 10
AND hiredate >= TO_DATE('1981.06.01', 'YYYY.MM.DD');

SELECT *
FROM emp
WHERE deptno NOT IN 10
AND deptno IN (10,20,30)
AND hiredate >= TO_DATE('1981.06.01', 'YYYY.MM.DD');

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
AND hiredate >= TO_DATE('1981.06.01', 'YYYY.MM.DD');

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR hiredate >= TO_DATE('1981.06.01', 'YYYY.MM.DD');

�����ȣ 78
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR empno LIKE '78%';

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR empno BETWEEN '7800' AND '7899';

SELECT *
FROM emp
ORDER BY 3;

//�ǽ� dept
SELECT *
FROM dept
ORDER BY loc;

SELECT *
FROM emp
ORDER BY comm DESC
WHERE comm IS NOT NULL
AND ORDER BY empno; 

SELECT *
FROM emp
WHERE comm != 0 
ORDER BY comm DESC, empno;

SELECT *
FROM emp
WHERE deptno in (10,30) 
AND sal > 1500
ORDER BY ename DESC;
