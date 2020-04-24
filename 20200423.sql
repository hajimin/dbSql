NVL(expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1(expr1 != null)
    
NVL2(expr, expr2, expr3)  (
java����ϰ�.. == �ǻ��ڵ�
if expr1 != null
    return expr2
else 
    return expr3;


NULLIF(expr1, expr2)
if expr1 == expr2
    return null
else
    return expr1
    
sal �÷��� ���� 3000�̸� null�� ����
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
          �������ڵ��� Ÿ���� �����ؾ���
          display("test2"), display("test1", "test2", "test3")


���ڵ� �߿� ���� ���� ������ null�� �ƴ� ���� ���� ����
coalesce(expr1, expr2...)
if expr1 != null
    return expr1
else
    coalesce(expr2, expr3....)

mgr �÷� null
comm �÷� null

SELECT empno, ename, mgr, NVL(mgr, 9999) mgr_n, NVL2(mgr, mgr, 9999) mgr_n_1, coalesce(mgr, 9999) mgr_n_2 
FROM emp;


SELECT userid, usernm, reg_dt, coalesce(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid != 'brown';

conditon
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, swithch ���� ����
1. case����
2. decode �Լ�

1. CASE
CASE 
    WHEN ��/ ������ �Ǻ��� �� �ִ� �� THEN ������ ��
    [WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��]
    [ELSE ������ ��(�Ǻ����� ���� WHEN���� ���� ��� ����)]
END

emp���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�ΰ�� SAL���� 5%�λ�� �ݾ��� ���ʽ��� ����(ex: sal 100->105)
�ش� ������ job�� MANAGER�ΰ�� SAL���� 10%�λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�ΰ�� SAL���� 20%�λ�� �ݾ��� ���ʽ��� ����
�׿� �������� SAL��ŭ�� ����

SELECT empno, ename, job, sal
        CASE 
            WHEN ��, ������ ������ �� �ִ� ���� THEN ��ȯ�� ��
        END
FROM emp;
SELECT *
FROM emp;

SELECT empno, ename, job, sal,
        CASE 
            WHEN job = 'SALESMAN' THEN sal*1.05 
            WHEN job = 'MANAGER' THEN sal*1.10 
            WHEN job = 'PRESIDENT' THEN sal*1.20 
            ELSE sal
        END bonus
FROM emp;

2. DECODE(EXPE1, search1, return1, search2, return2, search3, return3...[(default])
    DECODE(EXPE1,
            search1, return1, 
            search2, return2, 
            search3, return3
            default)
            
if EXPR1 == search1
    return return1
else if EXPR1 == search2
    return return2
else if EXPR1 == search3
    return return3
else
    return default;
    
    
    
SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal*1.05,
                    'MANAGER', sal*1.10,
                    'PRESIDENT', sal*1.20,
                    sal) bonus
FROM emp;
    
//
DECODE(deptno, 10, 'ACCOUNTING', 
               20,'RESEARCH',
               30, 'SALES', 
               40, 'OPERATIONS', 'DDIT') dname
//
SELECT empno, ename,
        CASE 
            WHEN deptno = 10 THEN  'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE  'DDIT'
        END dname
FROM emp;

//���س⵵�� ¦��, Ȧ��, ������ ���⵵�� ¦��, Ȧ��
MOD����� ���������� �������� Ŭ �� ����.
MOD(x, 1) ==> 0,1
(1,1) ==>����� Ȧ���⵵, Ȧ��
(0,1) ==>������
(1,0) ==>������
(0,0) ==>�����

SELECT empno, ename, hiredate,
        MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) ,
        MOD(TO_CHAR(hiredate, 'YYYY'), 2) ,
        CASE 
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) THEN '�ǰ����� �����' 
            ELSE '�ǰ����� ������' 
        END contact_to_doctor
FROM emp;

SELECT *
FROM users;
//

SELECT empno, ename, hiredate,
        MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) ,
        MOD(TO_CHAR(hiredate, 'YYYY'), 2) ,
        CASE 
            WHEN MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) = MOD(TO_CHAR(hiredate, 'YYYY'), 2) THEN '�ǰ����� �����' 
            ELSE '�ǰ����� ������' 
        END contact_to_doctor
FROM users;


SELECT userid, usernm, alias, reg_dt,

        CASE 
            WHEN MOD(TO_CHAR(SYSDATE+365, 'YYYY'), 2) = MOD(TO_CHAR(reg_dt, 'YYYY'), 2)  THEN '�ǰ����� �����' 
            ELSE '�ǰ����� ������' 
        END contact_to_doctor
FROM users;

        
