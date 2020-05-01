SELECT 에서 연산 : 
    날짜연산 (+,-) : 날짜 + 정수, -정수 : 날짜에서 +-정수를 한 과거 혹은 미래일자의 데이트 타입 변환
    정수연산 (...) 
    문자열 연산
        리터럴 : 표기방법
                숫자 리터럴 : 숫자로 표현
                문자 리터럴 : java : "문자열" / sql : 'sql'
                            SELECT SELECT * FROM || 'sql'
                            SELECT 'SELECT' * FROM || table name
                    문자열 겹합연산 : +가 아니라 || (java 에서는 +)
                날짜?? : TO_DATE('날짜문자열', '날짜 문자열에 대한 포맷')
                        TO_DATE('20200417', 'yyyymmdd')
                        
WHERE : 기술한 조건에 만족하는 행만 조회되도록 제한;

SELECT *
FROM users
WHERE userid = 'brown';

SELECT *
FROM users
WHERE 1 = 1;


sal값이 1000보다 크거나 같고, 2000보다 작거나 같은 직원만 조회 ==> BETWEEN AND;
비교대상 컬럼 / BETWEEN 값 AND 시작값 종료값
시작값과 종료값의 위치를 바꾸면 정상 작동하지 않음

java sal >= 1000 && sal <= 2000
sql sal >= 1000 AND sal <= 2000


SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
    AND sal <= 2000;

exclusive or (배타적 or)
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

IN 연산자
컬럼 : 특정값 IN (값1, 값2,...)
컬럼이나 특정값이 괄호안 값중에 하나라도 일치하면 TRUE

SELECT *
FROM emp
WHERE deptno IN (10,30); 
==> deptno가 10번이거나 30번인 직원
deptno = 10 or deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
OR deptno = 30; 


참이 아님
SELECT *
FROM emp

WHERE 10 = 10
AND 10 = 30; 

//문제
SELECT userid as 아이디,usernm as 이름,alias as 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally'); 

문자열 매칭 연산 LIKE 연산 / java startWith(prefix), .endsWith(suffix)
마스킹 문자열 : % 모든 문자열(공백포함)
               _ 어떤 문자열이든지 딱 하나의 문자
문자열의 일부가 맞으면 TRUE

컬럼 특정값 LIKE 패턴 문자열;


'cony' = cony인 문자열
'co%' : 문자열이 co로 시작하고 뒤에는 어떤 문자열이든지 올 수 있는 문자열
        'cony' 'con' 'coe' 'co'
'%co%' : co를 포함하는 문자열
        'cony'  'sally cony' 
'co__' : co로 시작하고 뒤에 두개의 문자가 오는 문자열
'_on_' : 가운데 두글자가 on이고 앞뒤로 어떤 문자열이든지 하나의 문자가 올 수 있는 문자열


//직원이름이 대문자 s로 시작하는 직원만 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

NULL 비교
SQL 비교연산자 : 
    WHERE usernm = 'brown'
    
mgr 값이 없는 모든 직원   

sql에서 NULL값을 비교할 경우 일반적으로 비교연산자(=)를 사용못하고 IS 연산자 사용

SELECT *
FROM emp
WHERE mgr IS NULL;

값이 있는 상황에서 등가 비교는 : =, !=, <> 사용
NULL : IS NULL, IS NOT NULL

emp테이블에서 mgr 컬럼 값이 NULL아닌 직원조회
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

//문제 
SELECT *
FROM emp;
WHERE comm IS NOT NULL;

논리연산
AND
OR
NOT

//연습문제

SELECT *
FROM emp
WHERE mgr = 7698
    AND sal > 1000;


SELECT *
FROM emp
WHERE mgr = 7698
    OR sal > 1000;

AND보다  OR을 사용할수록 조회되는 데이터가 많아진다

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

NULL비교하고 싶으면 밑으로 빼서 계산해야됨
SELECT *
FROM emp
WHERE mgr NOT IN (7698,7839)
OR mgr IS NULL;


//연습문제7
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD')
AND sal > 1300;

//연습문제8
SELECT *
FROM emp
WHERE deptno !=10
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

//연습문제9
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

//연습문제 10
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND deptno IN (10,20,30)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

//연습문제 11
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');



//연습문제 12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND empno LIKE '78%';

//연습문제 12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%'; //형변환하기 나중에 오류가 날 수 있음 추후 배울 내용//

//연습문제 13
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno BETWEEN 7800 AND 7899;

//연습문제 14
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



집합 : {a, b, c} = {a, c, b}

table에는 조회, 저장 시 순서가 없어(보장하지 않음)
오늘 조회한 결과와 내일 조회한 결과가 같지 않음
==> 집합과 유사

SQL에서는 데이터를 정렬하려면 별도의 구문이 필요

<사용방법>
ORDER BY 컬럼명 [정렬형태], 컬럼명2, ......


정렬 두가지 오름차순(DEPAULT) - ASC, 내림차순 - DESC
정렬형태 지정하지 않으면 기본적으로 오름차순

//예제

직원 이름으로 오름차순정렬

SELECT *
FROM emp
ORDER BY ename ASC;

직원 이름으로 내림차순정렬

SELECT *
FROM emp
ORDER BY ename DESC;


job을 기준으로 오름차순 정렬하고 job이 같을 경우 입사일자로 내림차순 정렬
모든 데이터 조회

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
