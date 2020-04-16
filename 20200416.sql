SELECT *        --��� �÷������� ��ȸ
FROM  prod;     --�����͸� ��ȸ�� ���̺� ���

Ư���÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2....
prod_id, prod_name�÷��� prod���̺��� ��ȸ;

SELECT prod_id, prod_name
FROM prod;

SELECT *
FROM  lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT *
FROM member;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�� �ٸ��� ���� x, ��Ģ����
int b = 2;     = ���Կ�����, == ��;

SQL ������ Ÿ�� : ����, ����, ��¥(date);

users ���̺��� (4/14 ��������) ����
users ���̺��� ��� �����͸� ��ȸ;

SELECT *
FROM users;

��¥ Ÿ�Կ� ���� ���� : ��¥�� +,- ���갡��
date type + ���� : date���� ������¥��ŭ �̷� ��¥�� �̵�
date type - ���� : date���� ������¥��ŭ ���� ��¥�� �̵�;

SELECT userid,reg_dt, reg_dt + 5
FROM users;

SELECT userid,reg_dt, reg_dt + 5 after_5days, reg_dt - 5
FROM users;


�÷� ��Ī : ���� �÷����� �����ϰ� ���� ��
syntax :  ���� �÷��� [ as ] ��Ī��Ī
��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�
���� ����Ŭ������ ��ü���� �빮�� ó���ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ���
���������̼��� ����Ѵ�

SELECT userid as id, userid id2, userid ���̵�
FROM users;

SELECT prod_id, userid id2, userid ���̵�
FROM users;


SELECT prod_id as id, prod_name name 
FROM prod;

SELECT lprod_gu as gu, lprod_nm nm 
FROM lprod;

SELECT buyer_id as ���̾���̵�, buyer_name �̸� 
FROM buyer;

���ڿ� ����(���տ���) : ||   (���ڿ� ������ + �����ڰ� �ƴϴ�)
SELECT /*userid 'test'(����)*/userid || 'test', reg_dt + 5, 'test', 15
FROM users;

�� �̸� ��
SELECT '��  ' || userid || ' ��' 
FROM users;

SELECT * 
FROM users;

SELECT userid || usernm as id_name,
       CONCAT(userid, usernm) AS concat_id_name
FROM users;

user_tables : oracle �����ϴ� ���̺� ������ ��� �ִ� ���̺�[view] ==> data dictionary
SELECT * 
FROM user_tables;

SELECT table_name
FROM user_tables;


SELECT 'SELECT * FROM ' || table_name || ';' as QUERY
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1. tool(sql developer)�� ���� Ȯ��
   ���̺� - Ȯ���ϰ����ϴ� ���̺�

2. SELECT *
   FROM ���̺�
   �ϴ� ��ü ��ȸ  --> ��� �÷��� ǥ��
   
3. DESC ���̺��   

DESC emp;

4. data dictionary : user_tab_columns  �÷� Ȯ��

SELECT *
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷���� : SELECT
��ȸ�� ���̺� ��� :FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE

java�� �񱳿��� : a������ b������ ���� ������ ��
int a = 5;
int b = 2;
( a�� b�� ���� ���� ���� Ư������ ����)
if( a == b){
}

sql�� �񱳿��� : = 
sql������ ���Կ����� ����

SELECT *
FROM users
WHERE userid = 'cony';

������ ���� ��, WHERE�� ������ ���� ������ ��
�� �÷��� �Ƚᵵ �ǰ�, ���� ���� ������ �׻� ���� ���� ����

SELECT *
FROM users
WHERE userid = userid;

SELECT *
FROM users
WHERE 'cony' = 'cony';

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;
DESC emp;
������ Ÿ���� ����


SELECT *
FROM emp;

emp : employee 
empno : �����ȣ
ename : �̸�
job : ��� ��å
mgr : �����(������)
hiredate : �Ի�����
sal : �޿�
comm : ������
deptno : �μ���ȣ

deptno(�μ���ȣ) Ȯ���Ϸ��� 

SELECT *
FROM dept;

emp ���̺��� ������ ���� �μ���ȣ�� 30�� ���� ū(>) �μ��� ���� ������ ��ȸ

SELECT *
FROM emp
WHERE deptno >= 30;

����
WHERE deptno > 30; 
WHERE 10 > 30; 
WHERE 20 > 30; 
WHERE 30 > 30; 

!= �ٸ���
Users ���̺��� ����� ���̵� brown�� �ƴ� ����� ��ȸ

SELECT *
FROM users
WHERE userid != 'brown';

SQL ���ͷ�
���� : 20, 50.1....
���� : �̱� �����̼� : 'hello world'
��¥ : TO_DATE('��¥���ڿ�', '��¥���ڿ��� ����');


��¥�� - �Լ��ʿ�
SELECT *
FROM emp;

1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
������ �Ի����� : hiradate �÷�
emp ���̺��� ���� : 14��

1982�� 1�� 1�� ���Ŀ� �Ի��� ���� : 3��
1982�� 1�� 1�� ������ �Ի��� ���� : 11��



SELECT ename 
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');
WHERE hiredate >= TO_DATE('1982.01.01', 'YYYY.MM.DD');

WHERE hiredate < TO_DATE('1982.01.01', 'YYYY.MM.DD');

���� ���ڸ� �ۿ� �� ���϶�
���� - ȯ�漳�� - �����ͺ��̽� NLS RR/MM/DD -> YYYY/MM/DD�� ���� �� ����


