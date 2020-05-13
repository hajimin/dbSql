CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1=1;

실습 1
CREATE UNIQUE INDEX idx_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno,dname);


실습 2
DROP INDEX idx_dept_test2_01 ON dept_test2 (deptno);
DROP INDEX idx_dept_test2_02 ON dept_test2 (dname);
DROP INDEX idx_dept_test2_03 ON dept_test2 (deptno,dname);

실습 3

실습 4 과제

실행계획

수업시간에 배운 조인
==> 논리적인 조인 형태를 이야기함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인기법
null = '7698'
outer join : 조인에 실패해도 기준이 되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join : 묻지마 조인(카티션 프러덕트), 조인 조건을 기술하지 않아서 연결가능한 모든 경우의 수로 조인되는 조인 기법
self join : 같은 테이블끼리 조인하는 형태

개발자가 DBMS에 SQL을 실행요청하면 DBMS는 sql을 분석해서
어떻게 두 테이블 연결할지를 결정, 3가지 방식의 조인방식(물리적 조인방식, 기술적인 이야기)
1. Nested Loop Join : 소량의 데이터를 조인하는 경우(빠른 응답성), 최소응답 건수가 조회되면 종료..?
2. Sort Merge Join : 대량의 데이터를 조인하는경우, 조인컬럼에 인덱스가 없을 경우
                    : 정렬이 되어 있으므로 조인조건에 해당하는 데이터를 찾기 유리 
                    : 정렬이 끝나야 연결이 가능하므로 응답속도가 느림 , =이 아니어도 사용가능
                    : 
3. Hash Join : 조인컬럼에 인덱스가 없을 경우
             : 조인 컬럼의 값을 hash함수를 이용해 연결
             : 조인 테이블의 건수가 한쪽이 많고 한쪽이 적은 경우 
             : 반드시 연결조건이 =인 경우
             : Hash 값이 같은 데이터끼리
             : Nested 함수 단점을 해결,, single IO 걱정이 없다
             
             hash 함수특징
             - 충돌이 안나게 유일한 값으로 바꿔줌 
             - 입력값이 길이와 관계없이 같은 길이 난수반환
             - 어떤 값이든 동일한 형태로 처리하는 것이 가능해짐
             - 결과값으로 입력값 예측 불가 (암호 알고리즘으로도 사용)
             - 입력값의 일부만 변경되도 상이함
             
             
             
             
OLTP (Online Transaction Processing) : 실시간 처리 ==> 응답이 빨라야 하는 시스템(일반적인 웹서비스)
OLAP (Online Analysis Processing) : 일괄처리 ==> 전체 처리속도가 중요한 경우(은행 이자계산, 새벽 한번에 계산)

index를 활용하지 못하는 경우
1. 컬럼을 가공
SELECT *
FROM emp
WHERE NVL(comm, 0)>0;
--nvl에는 인덱스를 적용하기 전 값이 있기 때문에, 사용하지 못함

 개선
SELECT *
FROM emp
WHERE comm>0;

2. 부정형 연산
SELECT *
FROM emp
WHERE job != 'SALESMAN';

3. NULL 비교
NULL 값은 인덱스에 들어가지 않음

SELECT *
FROM emp
WHERE ename IS NOT NULL;

개선
SELECT *
FROM emp
WHERE ename > ' ';

4. LIKE 연산시 선행 와일드 카드
SELECT *
FROM emp
WHERE ename LIKE '%T';

INDEX UNIQUE SCAN : 중복이 허용되지 않는 unique인덱스를 이용하여 찾고자하는 데이터만 조회
INDEX RANGE SCAN : 인덱스의 일부구간을 조회(오름차순/내림차순)
INDEX FULL SCAN : 인덱스 전체조회(오름차순/내림차순)
INDEX FAST SCAN : 인덱스 전체를 multiblock l/O로 조회 
INDEX ? SCAN : 선행컬럼이 주어지지 않고 후행컬럼만 조회

테이블 3개
TABLE ACCESS FULL

조인 3개

정렬 
SORT AGGREGATE (union)그룹함수 적용위해 정렬작업
SORT UNIQUE 중복값 제거 
SORT GROUP BY
SORT ORDER BY
SORT JOIN

predicate 
