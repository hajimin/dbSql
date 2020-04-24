SELECT *
FROM dual;

오라클 내장 함수 테스트 (대소문자 관련)
LOWER, UPPER, INITCAP : 인자로 문자열 하나를 받는다

SELECT LOWER('Hello, World')
FROM dual;


SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM dual;

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM emp;  //where절에 조건을 안적었기 때문에, 결과적으로 emp테이블 14건에 대해 똑같은 값 출력

SELECT empno, 5, 'test', LOWER('Hello, World') /*, UPPER('Hello, World'), INITCAP('hello, world')*/
FROM emp;

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; 이런식으로 작성하면 안됨
WHERE ename = UPPER('smith'); 두가지 방식 중에 위에보단 현재 방식이 올바른 방식임
  ==> WHERE ename = 'SMITH'


WHERE ename = 'smith'; 테이블에는 데이터 값이 대문자로 저장되어 있으므로 조회건수 0
WHERE ename = 'SMITH'; //정상//


--문자열 연산 함수
CONCAT : 2개의 문자열을 입력 받아, 결합한 문자열을 반환한다
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

NUMBER 관련 함수
ROUND(숫자, 반올림 위치) : 반올림
TRUNC(숫자, 내림 위치) : 내림
MOD(피제수, 제수) 나머지 연산

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

현재시간(SYSDATE)을 시분초단위까지 표현 == TO_CHAR을 이용

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
        TO_CHAR(SYSDATE, 'D') d,
        TO_CHAR(SYSDATE -3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
        TO_CHAR(SYSDATE -1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash, 
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dach_whit_time, 
        TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;

MONTHS_BETWEEN(DATE1, DATE2) : DATE1과 DATE2사이의 개월 수를 반환
4가지 날짜 관련 함수 중에 사용 빈도가 낮음
SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
        MONTHS_BETWEEN(TO_DATE('2020/04/22', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
FROM dual;

ADD_MONTHS(DATE1, 가감할 개월수) : DATE1으로부터 두번째 입력된 개월 수만큼 가감한 DATE
오늘 날짜로부터 5개월 뒤 날짜

SELECT ADD_MONTHS(SYSDATE, 5) dt1,
        ADD_MONTHS(SYSDATE, -5) dt2
FROM dual;

NEXT_DAY(date1, 주간일자) date1이후 등장하는 첫번째 주간일자의 날짜를 반환
SELECT NEXT_DAY(SYSDATE, 7)
FROM dual;

LAST_DAY(date1) DATE1이 속한 월의 마지막 날짜를 반환
SYSDATE : 2020/04/21 ==> 2020/04/30

SELECT LAST_DAY(SYSDATE)
FROM dual;



날짜가 속한 월의 첫번째 날짜 구하기(1일)
SYSDATE : 2020/04/21 ==> 2020/04/01

SELECT SYSDATE, LAST_DAY(SYSDATE),LAST_DAY(SYSDATE) +1,
        ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1)
FROM dual;



SYSDATE로부터 년월까지 문자열 구하기 20204
SELECT SYSDATE, LAST_DAY(SYSDATE),LAST_DAY(SYSDATE) +1,
        ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD') --문자 
FROM dual;


SELECT SYSDATE, LAST_DAY(SYSDATE),LAST_DAY(SYSDATE) +1,
        ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
FROM dual;
