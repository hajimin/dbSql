SELECT *        --모든 컬럼정보를 조회
FROM  prod;     --데이터를 조회할 테이블 기술

특정컬럼에 대해서만 조회 : SELECT 컬럼1, 컬럼2....
prod_id, prod_name컬럼만 prod테이블에서 조회;

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

SQL 연산 : JAVA와 다르게 대입 x, 사칙연산
int b = 2;     = 대입연산자, == 비교;

SQL 데이터 타입 : 문자, 숫자, 날짜(date);

users 테이블이 (4/14 만들어놓음) 존재
users 테이블의 모든 데이터를 조회;

SELECT *
FROM users;

날짜 타입에 대한 연산 : 날짜는 +,- 연산가능
date type + 정수 : date에서 정수날짜만큼 미래 날짜로 이동
date type - 정수 : date에서 정수날짜만큼 과거 날짜로 이동;

SELECT userid,reg_dt, reg_dt + 5
FROM users;

SELECT userid,reg_dt, reg_dt + 5 after_5days, reg_dt - 5
FROM users;


컬럼 별칭 : 기존 컬럼명을 변경하고 싶을 때
syntax :  기존 컬럼명 [ as ] 별칭명칭
별칭 명칭에 공백이 표현되어야 할 경우 더블 쿼테이션으로 묶는다
또한 오라클에서는 객체명을 대문자 처리하기 때문에 소문자로 별칭을 지정하기 위해서도
더블쿼테이션을 사용한다

SELECT userid as id, userid id2, userid 아이디
FROM users;

SELECT prod_id, userid id2, userid 아이디
FROM users;


SELECT prod_id as id, prod_name name 
FROM prod;

SELECT lprod_gu as gu, lprod_nm nm 
FROM lprod;

SELECT buyer_id as 바이어아이디, buyer_name 이름 
FROM buyer;

문자열 연산(결합연산) : ||   (문자열 결합은 + 연산자가 아니다)
SELECT /*userid 'test'(오류)*/userid || 'test', reg_dt + 5, 'test', 15
FROM users;

경 이름 축
SELECT '경  ' || userid || ' 축' 
FROM users;

SELECT * 
FROM users;

SELECT userid || usernm as id_name,
       CONCAT(userid, usernm) AS concat_id_name
FROM users;

user_tables : oracle 관리하는 테이블 정보를 담고 있는 테이블[view] ==> data dictionary
SELECT * 
FROM user_tables;

SELECT table_name
FROM user_tables;


SELECT 'SELECT * FROM ' || table_name || ';' as QUERY
FROM user_tables;

테이블의 구성 컬럼을 확인
1. tool(sql developer)을 통해 확인
   테이블 - 확인하고자하는 테이블

2. SELECT *
   FROM 테이블
   일단 전체 조회  --> 모든 컬럼이 표시
   
3. DESC 테이블명   

DESC emp;

4. data dictionary : user_tab_columns  컬럼 확인

SELECT *
FROM user_tab_columns;

지금까지 배운 SELECT 구문
조회하고자 하는 컬럼기술 : SELECT
조회할 테이블 기술 :FROM
조회할 행을 제한하는 조건을 기술 : WHERE

java의 비교연산 : a변수와 b변수의 값이 같은지 비교
int a = 5;
int b = 2;
( a랑 b의 값이 같을 때만 특정로직 실행)
if( a == b){
}

sql의 비교연산 : = 
sql에서는 대입연산이 없음

SELECT *
FROM users
WHERE userid = 'cony';

조건이 참일 때, WHERE절 만족한 값만 가져온 것
꼭 컬럼을 안써도 되고, 참인 값을 적으면 항상 참의 값이 나옴

SELECT *
FROM users
WHERE userid = userid;

SELECT *
FROM users
WHERE 'cony' = 'cony';

emp테이블의 컬럼과 데이터 타입을 확인;
DESC emp;
데이터 타입은 숫자


SELECT *
FROM emp;

emp : employee 
empno : 사원번호
ename : 이름
job : 담당 직책
mgr : 담당자(관리자)
hiredate : 입사일자
sal : 급여
comm : 성과급
deptno : 부서번호

deptno(부서번호) 확인하려면 

SELECT *
FROM dept;

emp 테이블에서 직원이 속한 부서번호가 30번 보다 큰(>) 부서에 속한 직원을 조회

SELECT *
FROM emp
WHERE deptno >= 30;

오류
WHERE deptno > 30; 
WHERE 10 > 30; 
WHERE 20 > 30; 
WHERE 30 > 30; 

!= 다를때
Users 테이블에서 사용자 아이디가 brown이 아닌 사용자 조회

SELECT *
FROM users
WHERE userid != 'brown';

SQL 리터럴
숫자 : 20, 50.1....
문자 : 싱글 쿼테이션 : 'hello world'
날짜 : TO_DATE('날짜문자열', '날짜문자열의 형식');


날짜비교 - 함수필요
SELECT *
FROM emp;

1982년 1월 1일 이후에 입사한 직원만 조회
직원의 입사일자 : hiradate 컬럼
emp 테이블의 직원 : 14명

1982년 1월 1일 이후에 입사한 직원 : 3명
1982년 1월 1일 이전에 입사한 직원 : 11명



SELECT ename 
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');
WHERE hiredate >= TO_DATE('1982.01.01', 'YYYY.MM.DD');

WHERE hiredate < TO_DATE('1982.01.01', 'YYYY.MM.DD');

연도 두자리 밖에 안 보일때
도구 - 환경설정 - 데이터베이스 NLS RR/MM/DD -> YYYY/MM/DD로 변경 후 저장


