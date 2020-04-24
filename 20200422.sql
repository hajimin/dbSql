
SELECT '201912' param, TO_CHAR(LAST_DAY('20191201'), 'DD') DT
FROM dual;

SELECT TO_DATE(:yyyymm, 'YYYYMM'),
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')) ,
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') DT
FROM dual;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

SELECT *
FROM table(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM table(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno= 7300 + '69';

SELECT *
FROM table(DBMS_XPLAN.DISPLAY);

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00') // ���� �����ֱ�
FROM emp;

 NULL�� ���õ� �Լ�
NVL
NVL2
NULLF
COALESCE;


�� nulló���� �ؾ��ұ�?

null�� Ư¡
- null�� ���� �������� NULL�̴�.

���� ��, emp���̺� �����ϴ� sal, comm �ΰ��� �÷����� ������ ���� �˰� �; ������ ���� SQL�� �ۼ�.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1�� null�̸� expr2���� �����ϰ�
expr1�� null�� �ƴϸ� expr1�� ����

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;



SELECT *
FROM users;
 
 reg_dt �÷��� null�ϰ�� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
 SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE))
 FROM users;
 
 