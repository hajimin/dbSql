
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

SELECT ename, sal, TO_CHAR(sal, 'L009,999.00') // 길이 맞춰주기
FROM emp;

 NULL과 관련된 함수
NVL
NVL2
NULLF
COALESCE;


왜 null처리를 해야할까?

null의 특징
- null에 대한 연산결과는 NULL이다.

예를 들어서, emp테이블에 존재하는 sal, comm 두개의 컬럼값을 포함한 값을 알고 싶어서 다음과 같이 SQL을 작성.

SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 expr1을 리턴

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;



SELECT *
FROM users;
 
 reg_dt 컬럼이 null일경우 현재 날짜가 속한 월의 마지막 일자로 표현
 SELECT userid, usernm, reg_dt, NVL(reg_dt, LAST_DAY(SYSDATE))
 FROM users;
 
 