SELECT job, count(*) cnt
FROM emp
GROUP BY job;



SELECT mgr, count(*) cnt
FROM emp
GROUP BY mgr;



DML
데이터를 입력(INSERT), 수정(UPDATE), 삭제(DELETE) 할때 사용하는 SQL

INSERT

구문
INSERT INTO 테이블명 [(테이블의 컬럼명, …)] VALUES(입력할 값, …);

크게 다음 두가지 형태로 사용
	1. 테이블 모든 컬럼에 값을 입력하는 경우, 컬럼명을 나열하지 않아도 된다
	단, 입력할 값의 순서는 테이블에 정의된 컬럼 순서로 인식된다.
INSERT INTO 테이블명 VALUES(입력할 값, 입력할 값2…);

	2. 입력하고자하는 컬럼을 명시하는 경우
	단, 테이에 NOT NULL 설정이 되어 있는 컬럼이 누락되면 INSERT는 실패한다
INSERT INTO 테이블명 (컬럼1, 컬럼2) VALUES (입력할 값, 입력할 값2);

DESC emp;


Dept테이블에 deptno 99, dname DDIT, loc daejeon값을 입력하는 INSERT 구문작성
SELECT *
FROM dept;

데이터 입력을 확정을 지으려면 : commit - 트랜잭션 완료
데이터 입력을 취소하려면 : rollback - 트랜잭션 취소

rollback;

INSERT INTO dept VALUES (99, 'DDIT', 'daejeon');

INSERT INTO dept (loc, deptno, dname) VALUES ('daejeon', 99, 'DDIT');


SELECT *
FROM dept;

위의 INSERT 고정된 문자열, 상수를 입력한 경우
INSERT 구문에서 스칼라 서브쿼리, 함수도 사용가능
EX : 테이블에 데이터가 들어갈 당시의 일시정보를 기록하는 경우가 많음 ==> SYSDATE

SELECT *
FROM emp;

Emp테이블의 경우 컬럼 총 개수는 8개, NOT NULL은 1개(EMPNO)
empno가 9999이고 ename은 본인이름, hitedate는 현재일시를 저장하는 INSERT구문을 작성
INSERT INTO emp (empno, ename, hiredate) VALUES (9999, 'JM', SYSDATE);

9998번 사번으로 jw사원을 입력, 입사일자는 2020년 4월 13일로 설정하여 데이터 입력
INSERT INTO emp (empno, ename, hiredate) VALUES (9998, 'jw', TO_DATE('2020/04/13', 'YYYY/MM/DD'));



3. SELECT 결과를 테이블에 입력하기(대량입력)

DESC dept;

dept테이블에는 4건의 데이터가 존재(10~40)
아래쿼리를 실행하면 기존 존재 4건 + SELECT 로 입력되는 4건 총 8건의 데이터가 dept테이블에 입력됨
INSERT INTO dept
SELECT *
FROM dept;

데이터 확인
SELECT *
FROM dept;

rollback;


UPDATE : 데이터 수정
UPDATE 테이블명 set 수정할 컬럼1 = 수정할 값1,
				 [수정할 컬럼1, = 수정할 값1, …]
[WHERE condition-SELECT 절에서 배운 WHERE절과 동일
	수정할 행을 인식하는 조건을 기술]
	
Dept테이블에 99, DDIT, daejeon;

INSERT INTO dept VALUES (99, 'DDIT','daejeon');

99번 부서의 부서명을 대덕IT로, 위치를 영민빌딩으로 변경
UPDATE dept set dname = '대덕IT', 
                loc = '영민빌딩'
WHERE deptno= 99;


아래쿼리는 dept테이블의 모든 행의 부서명과 위치를 변경하는 쿼리
UPDATE dept set dname = '대덕IT', 
                loc = '영민빌딩'

INSERT : 없던걸 새로 생성
UPDATE, DELETE : 기존에 있는 걸 변경, 삭제
 ==> 쿼리를 작성할 경우 주의
 1. WHERE절이 누락되지 않았는지
 2. UPDATE, DELETE 문을 실행하기 전에 WHERE절을 복사해서 SELECT를 하여
    영향이 가는 행을 눈으로 확인
SELECT*
FROM dept
WHERE deptno= 99;

ORACLE사용자는 UPDATE, DELETE 시 실수 했을 경우 한번더 기회있음
ROLLBACK;


서브쿼리를 이용한 데이터 수정
INSERT INTO emp(empno, ename, job) VALUES (9999,'brown',NULL);

SELECT *
FROM emp;

9999번 직원의 deptno, job 두개의 컬럼을 SMITH사원의 정보와 동일하게 변경

UPDATE emp set deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job = (SELECT job FROM emp WHERE ename = 'SMITH'),
                sal = (SELECT sal FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

일반적인 UPDATE 구문에서는 컬럼별로 서브쿼리를 작성하여 비효율이 존재
==> MERGE 구문을 통해 비효율을 제거할 수 있다.

변경사항을 취소
ROLLBACK;

DELETE : 테이블에 존재하는 데이터를 삭제
구문
DELETE [FROM] 테이블명
[WHERE condition]

주의점
1. 특정 컬럼만 값을 삭제 ==> 해당컬럼을 NULL로 UPDATE
    DELETE절은 행자체를 삭제
    
2. UPDATE 마찬가지로 DELETE쿼리를 실행하기 전에 SELECT 를 통해 삭제 대상이 되는 행을 조회, 확인하자

삭제 테스트 데이터 입력
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

사번이 9999번인 행을 삭제하는 쿼리 작성
DELETE emp
WHERE empno = 9999;

SELECT *
FROM emp
WHERE empno = 9999;

ROLLBACK;

아래 쿼리의 의미 : emp 테이블의 모든 행을 삭제
DELETE emp;

SELECT *
FROM emp;

ROLLBACK;

SELECT *
FROM emp;

UPDATE, DELETE절의 경우 테이블에 존재하는 데이터에 변경, 삭제를 하는 것이기 때문에
대상 행을 제한하기 위해 WHERE절을 기술할 수 있고, 
WHERE 절은 SELECT절에서 사용한 내용을 적용할 수 있다.
예를 들어 서브쿼리를 통한 행의 제한이 가능


매니저가 7698인 직원들을 모두 삭제하고 싶을 때
DELETE emp
WHERE empno IN 
        (SELECT empno
         FROM emp
         WHERE mgr =7698);
         
SELECT *
FROM emp;

ROLLBACK;

DML : SELECT, INSERT, UPDATE, DELETE
WHERE 절을 사용가능한 DML : SELECT, UPDATE, DELETE
    3개의 쿼리는 데이터를 식별하는 WHERE 절이 사용될 수 있다
    데이터를 식별하는 속도에 따라 쿼리의 실행 성능이 좌우 됨.
    ==> INDEX 객체를 통해 속도향상이 가능
    
INSERT : 빈공간에 신규 데이터를 입력 하는 것
         빈공간을 식별하는 게 중요
         ==> 개발자가 할 수 있는 튜닝 포인트가 많지않음

테이블의 데이터를 지우는 방법(모든 데이터 지우기)
1. DELETE : WHERE절을 기술하지 않으면 됨
2. TRUNCATE 
    사용법 : TRUNCATE TABLE 테이블명
    특징 : 1) 삭제시 로그를 남기지 않음
            ==> 복구가 불가능
          2) 로그를 남기지 않기 때문에 실행 속도가 빠르다
            ==> 운영환경에서는 잘 사용하지 않음(복구가 안되기 때문에)
                테스트 환경에서 주로 사용
                
데이터를 복사하여 테이블 생성(따라 해보기)

CREATE TABLE emp_copy AS 
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

emp_copy 테이블을 TRUNCATE 명령을 통해 모든 데이터 삭제
TRUNCATE TABLE emp_copy;

ROLLBACK;

SELECT *
FROM emp_copy;

트랜잭션 : 논리적인 일의 단위
ex : ATM- 출금과 입금이 둘다 정상적으로 이루어져야 문제가 발생되지 않음
            출금은 정상처리 되었지만 입금이 비정상 처리 되었다면
            정상 처리된 출금도 취소를 해줘야한다
            
출금
입금(실패)
ROLLBACK;

오라클에서는 첫번째 DML이 시작이 되면 트랜의 시작으로 인식
트랜잭션의 종료는 ROLLBACK, COMMIT을 통해 종료가 된다

트랜잭션 종료 후 새로운 DML이 실행되면 새로운 트랜잭션이 시작


평소 사용하는 게시판을 생각해보자
게시글 입력할 때 입력 하는 것 : 제목(1개), 내용(1개), 첨부파일(복수가능)
RDBMS에서는 속성이 중복될 경우 별도의 엔터이(테이블)로 분리를 한다
게시글 테이블(제목, 내용) / 게시글 첨부파일 테이블(첨부파일에 대한 정보)

게시글을 하나 등록을 하더라도
게시글 테이블과, 게시글 첨부파일 테이블에 데이터를 신규로 등록을 한다.
INSERT INTO 게시글 테이블 (제목, 내용, 등록자, 등록일시) VALUES (....);
INSERT INTO 게시글 첨부파일 테이블 (첨부파일명, 첨부파일 사이즈) VALUES (....);

두개의 INSERT 쿼리가 게시글 등록의 트랜잭션 다위
즉, 두개중에 하나라도 문제가 생기면 일반적으로 ROLLBACK을 통해 두개의 INSERT 구문을 취소.











