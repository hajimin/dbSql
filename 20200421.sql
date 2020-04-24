SELECT *
FROM dual;

����Ŭ ���� �Լ� �׽�Ʈ (��ҹ��� ����)
LOWER, UPPER, INITCAP : ���ڷ� ���ڿ� �ϳ��� �޴´�

SELECT LOWER('Hello, World')
FROM dual;


SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM emp;  //where���� ������ �������� ������, ��������� emp���̺� 14�ǿ� ���� �Ȱ��� �� ���

SELECT empno, 5, 'test', LOWER('Hello, World') /*, UPPER('Hello, World'), INITCAP('hello, world')*/
FROM emp;

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; �̷������� �ۼ��ϸ� �ȵ�
WHERE ename = UPPER('smith'); �ΰ��� ��� �߿� �������� ���� ����� �ùٸ� �����
  ==> WHERE ename = 'SMITH'


WHERE ename = 'smith'; ���̺��� ������ ���� �빮�ڷ� ����Ǿ� �����Ƿ� ��ȸ�Ǽ� 0
WHERE ename = 'SMITH'; //����//


--���ڿ� ���� �Լ�
CONCAT : 2���� ���ڿ��� �Է� �޾�, ������ ���ڿ��� ��ȯ�Ѵ�
SELECT CONCAT('start', 'end') 
FROM dual;

SELECT table_name, tablespace_name, /*CONCAT('start', 'end'),
        CONCAT(table_name, tablespace_name),
        'SELECT * FROM' || table_name || ';',*/
        CONCAT('SELECT * FROM', CONCAT(table_name,';' ))

FROM user_tables;

SELECT CONCAT('SELECT * FROM ', CONCAT(table_name,';' ))
FROM user_tables;


SELECT SUBSTR('Hello, World', 1, 5) sub
FROM dual;

SELECT SUBSTR('Hello, World', 1, 5) sub,
        LENGTH('Hello, World') len,
        INSTR('Hello, World', 'o') ins,
        INSTR('Hello, World', 'o', 6) ins2,
        INSTR('Hello, World', 'o', INSTR('Hello, World', 'o') + 1) ins3,
        LPAD('hello', 15, '*') lp,
        RPAD('hello', 15, '*') rp,
        LPAD('hello', 15) lp2,
        RPAD('hello', 15) rp2,
        REPLACE('Hello, World', 'll', 'LL') rep,
        TRIM('    Hello    ') tr
FROM dual;

NUMBER ���� �Լ�
ROUND(����, �ݿø� ��ġ) : �ݿø�
TRUNC(����, ���� ��ġ) : ����
MOD(������, ����) ������ ����

select round(105.54, 1) round,
       round(105.55, 1) round2,
       round(105.55, 0) round3,
       round(105.55, -1) round4
from dual;

SELECT TRUNC(105.54, 1) trunc,
       TRUNC(105.55, 1) trunc2,
       TRUNC(105.55, 0) trunc3,
       TRUNC(105.55, -1) trunc4
FROM dual;

SELECT MOD (10, 3), MOD(sal, 1000)
FROM emp;

SELECT *
FROM emp;
DESC emp;

SELECT SYSDATE
FROM dual;

SELECT SYSDATE, SYSDATE + 5
FROM dual;

SELECT TO_DATE('2020/04/20', 'YYYY/MM/DD') lastday, 
        TO_DATE('2020/04/20', 'YYYY/MM/DD') -5 lastday_before5, 
        SYSDATE now, SYSDATE - 3 now_before3
FROM dual;

����ð�(SYSDATE)�� �ú��ʴ������� ǥ�� == TO_CHAR�� �̿�

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
        TO_CHAR(SYSDATE, 'D') d,
        TO_CHAR(SYSDATE -3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
        TO_CHAR(SYSDATE -1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash, 
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dach_whit_time, 
        TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;

MONTHS_BETWEEN(DATE1, DATE2) : DATE1�� DATE2������ ���� ���� ��ȯ
4���� ��¥ ���� �Լ� �߿� ��� �󵵰� ����
SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
        MONTHS_BETWEEN(TO_DATE('2020/04/22', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
FROM dual;

ADD_MONTHS(DATE1, ������ ������) : DATE1���κ��� �ι�° �Էµ� ���� ����ŭ ������ DATE
���� ��¥�κ��� 5���� �� ��¥

SELECT ADD_MONTHS(SYSDATE, 5) dt1,
        ADD_MONTHS(SYSDATE, -5) dt2
FROM dual;

NEXT_DAY(date1, �ְ�����) date1���� �����ϴ� ù��° �ְ������� ��¥�� ��ȯ
SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

LAST_DAY(date1) DATE1�� ���� ���� ������ ��¥�� ��ȯ
SYSDATE : 2020/04/21 ==> 2020/04/30

SELECT LAST_DAY(SYSDATE)
FROM dual;



��¥�� ���� ���� ù��° ��¥ ���ϱ�(1��)
SYSDATE : 2020/04/21 ==> 2020/04/01

SELECT SYSDATE, LAST_DAY(SYSDATE),LAST_DAY(SYSDATE) +1,
        ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1)
FROM dual;



SYSDATE�κ��� ������� ���ڿ� ���ϱ� 20204
SELECT SYSDATE, LAST_DAY(SYSDATE),LAST_DAY(SYSDATE) +1,
        ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD') --���� 
FROM dual;


SELECT SYSDATE, LAST_DAY(SYSDATE),LAST_DAY(SYSDATE) +1,
        ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
FROM dual;
