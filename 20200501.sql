한개의 행, 하나의 컬럼을 리턴하는 서브쿼리
ex : 전체직원의 급여평균, SMITH 직원이 속한 부서의 부서번호

WHERE 에서 사용가능한 연산자
WHERE deptno = 10
==> 

부서번호가 10 혹은 30번인 경우
WHERE deptno = IN(10,30)
WHERE deptno = 10 OR 30 

다중행 연산자
다중행을 조회하는 서브쿼리의 경우 = 연산자를 사용불가
WHERE deptno IN(여러개의 행을 리턴하고, 하나의 컬럼으로 이루어진 쿼리)

SMITH - 20, ALLEN은 30번 부서에 속함
SMITH 또는 ALLEN이 속하는 부서의 조직원 정보를 조회

행이 여러개고, 컬럼은 하나다 
==> 서브쿼리에서 사용가능한 연산자 IN(가장 많이 씀, 중요!), (ANY, ALL)

IN : 서브쿼리의 결과값 중 동일한 값이 있을 때 TRUE
    WHERE 컬럼|표현식 IN (서브쿼리)
    
ANY : 연산자를 만족하는 값이 하나라도 있을 때 TRUE
    WHERE 컬럼|표현식 연산자 ANY (서브쿼리)

ALL : 서브쿼리의 모든 값이 연산자를 만족할 때 TRUE
    WHERE 컬럼|표현식 연산자 ALL (서브쿼리)

SMITH와 ALLEN이 속한 부서에서 근무하는 모든 직원을 조회

1. 서브쿼리를 사용하지 않을 경우 : 두개의 쿼리를 실행
[1-1] SMITH, ALLEN이 속한 부서의 부서번호를 확인하는 쿼리
SELECT deptno
FROM emp
WHERE ename IN('SMITH', 'ALLEN');

[1-2] 1-1에서 얻은 부서번호로 IN연산을 통해 해당 부서에 속하는 직원정보 조회
SELECT deptno
FROM emp
WHERE ename IN(20,30);

==> 서브쿼리를 이용하면 하나의 SQL에서 실행가능
SELECT deptno
FROM emp
WHERE deptno IN(SELECT deptno
               FROM emp
               WHERE ename IN('SMITH', 'ALLEN'));

sub3
SELECT *
FROM emp
WHERE sal IN(SELECT deptno
               FROM emp
               WHERE ename IN('SMITH', 'WORD'));


[참고]
ANY, ALL
SMITH(800)나 WORD(1250) 두 사원의 급여중 아무 값보다 작은 급여를 받는 직원 조회 
==> sal < 1250;
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN('SMITH', 'WORD'));
                
SMITH(800)나 WORD(1250) 두 사원의 급여중 아무 값보다 작은 급여를 받는 직원 조회 
==> sal > 1250;

SELECT *
FROM emp
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN('SMITH', 'WORD'));

IN 연산자의 부정
소속부서가 20, 혹은 30인 경우
WHERE deptno IN (20,30)

소속부서가 20, 30에 속하지 않는 경우
WHERE deptno NOT IN (20,30)

NOT IN 연산자를 사용할 경우 서브쿼리의 값에 NULL이 있는지 여부가 중요

아래 쿼리가 조회되는 결과는 어떤 의미 인가?
SELECT *
FROM emp
WHERE empno NOT IN(SELECT mgr
                    FROM emp);
--> emp테이블 사람들 중 mgr(매니저)가 아닌 사람 조회
--> NULL이 있기 떄문에,,  위 쿼리는 동작을 하지 않음 

--> NULL값을 갖는 행을 제거!

1. WHERE절에서 처리
SELECT *
FROM emp
WHERE empno NOT IN(SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);
2. NVL처리
SELECT *
FROM emp
WHERE empno NOT IN(SELECT NVL(mgr, -1)
                    FROM emp);


단일 컬럼을 리턴하는 서브쿼리에 대한 연산 ==> 복수 컬럼을 리턴하는 서브쿼리
PAIRWISE 연산 (순서쌍) ==> 동시에 만족

SELECT *
FROM emp
WHERE empno IN(7499,7782);

SELECT mgr, deptno
FROM emp
WHERE empno IN(7499,7782);

WHERE empno IN(7499); = WHERE empno = 7499;


7499, 7782사번의 직원과 (같은 부서, 같은 매니저)인 모든 직원 정보 조회
매니저가 7689이면서 소속부서가 30인 경우
매니저가 7839이면서 소속부서가 10인 경우

mgr 컬럼과 deptno컬럼의 연관성이 없다
(7698,10)
(7698,30)
(7839,10)
(7839,30)

실제원하는 값
(7698,30)
(7839,10)

아래 쿼리는 모든 값이 나옴
SELECT *
FROM emp
WHERE mgr IN(7698,7839)
  AND deptno IN(10,30);

그래서 실제 원하는 값만 나오게 하려면
PAIRWISE 적용*( 위의 쿼리보다 결과가 한 건 적다)
SELECT *
FROM emp
WHERE (mgr,deptno) IN(SELECT mgr, deptno
                      FROM emp
                      WHERE empno IN(7499,7782));
                      
                      

(중요한 건 아니지만, 정리)                      
서브쿼리 구분-사용 위치
SELECT - 스칼라 서브쿼리
FROM - 인라인 뷰
WHERE - 서브쿼리


서브쿼리 구분 - 반환하는 행, 컬럼의 수
단일 행
    단일 컬럼(스칼라 서브 쿼리)
    복수 컬럼
복수 행
    단일 컬럼(많이 쓰는 형태)
    복수 컬럼
    
스칼라 서브쿼리
SELECT 절에 표현되는 서브쿼리
단일 행 단일 컬럼을 리턴하는 서브쿼리만 사용가능
메인 쿼리의 하나의 컬럼처럼 인식

이렇게도 쓸수 있지만 더 간단한 방법이 있음
SELECT 'X',(SELECT SYSDATE FROM dual);
FROM dual;

스칼라 서브쿼리는 하나의 행, 하나의 컬럼을 반환해야한다.

행은 하나지만, 컬럼이 2개여서 에러
SELECT 'X', (SELECT empno, ename, FROM emp WHERE ename='SMITH')
FROM dual;

다중행 하나의 컬럼을 리턴하는 스칼라 서브쿼리 ==> 에러
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp테이블만 사용할 경우 해당 직원의 소속 부서 이름을 알 수가 없다 ==> 조인
특정 부서의 부서 이름을 조회하는 쿼리
SELECT dname
FROM dept
WHERE deptno = 10;

위 쿼리를 스칼라 서브쿼리로 변경

SELECT empno, ename, deptno, 부서명
FROM emp;

조인
SELECT empno, ename, deptno, dname
FROM emp JOIN dept ON (emp deptno = dept.deptno);

스칼라 서브쿼리
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno)
FROM emp;


서브쿼리 구분 - 메인쿼리의 컬럼을 서브쿼리에서 사용하는지 여부에 따른 구분
상호연관 서브쿼리(corelated sub query)
    .메인쿼리가 실행되어야 서브쿼리가 실행이 가능하다(강조)

비상호연관 서브쿼리(non corelated sub query)
    .main쿼리의 테이블을 먼저 조회할 수도 있고
     sub쿼리의 테이블을 먼저 조회할 수도 있다
     ==> 오라클이 판단했을때 성능상 유리한 방향으로 실행방향을 결정
    
모든 직원의 급여평균 보다 많은 급여를 받는 직원을 조회하는 쿼리를 작성하세요(서브쿼리 이용)
SELECT *
FROM emp 
WHERE sal > (SELECT avg(sal) 
              FROM emp);

생각해볼 문제, 위의 쿼리는 상호연관 서브 쿼리인가? 비상호 연관 서브 쿼리 인가?
비상호쿼리


직원이 속한 부서의 급여평균보다 많은 급여를 받는 직원
전체 직원의 급여평균 ==> 직원이 속한 부서의 급여평균


특정부서(10)의 급여평균을 구하는 SQL
SELECT avg(sal) 
FROM emp 
WHERE deptno = 10;


SELECT *
FROM emp e
WHERE sal > (SELECT avg(sal) 
             FROM emp 
             WHERE deptno = e.deptno);


OUTER JOIN
조인이 실패되더라도 기준으로 삼은 테이블의 컬럼 정보는 조회가 되도록 하는 조인방식
table LEFT OUTER JOIN table2
==> table의 컬럼은 조인에 실패하더라도 조회가 된다
(ORACLE 9i 이전까지는 기준이 되는 테이블 부터 읽는다
==> oracle 10g 이후부터는 성능상 유리한 테이블 부터 읽는다)

SELECT *
FROM dept;


insert into dept values (99,'ddit', 'deajeon');

emp테이블에 등록된 직원들은 10,20,30번 부서에만 소속되어 있음
직원 소속되지 않은 부서 40,99


SELECT * 
FROM dept (SELECT *
            FROM deptno NOT IN (10,20,30));


직원이 한명이라도 존재하는 부서
SELECT * 
FROM dept
WHERE deptno NOT IN (SELECT deptno FROM emp);


서브쿼리를 이용하여 IN연산자를 통해 일치하는 값이 있는지 조사할때
값이 여러개 있어도 상관없다(집합)

SELECT deptno NOT IN (10,10,10);
FROM deptno =10;
OR deptno =10;
OR deptno =10;


동일한 부서번호가 서브쿼리에서 조회되지 않도록 제거하려고 그룹연산을 한 경우( 답은 맞다)
SELECT *
FROM dept 
WHERE deptno NOT IN(SELECT deptno 
                    FROM emp;
                    GROUP BY deptno;


SELECT pid,pnm
FROM product
WHERE pid NOT IN(SELECT pid FROM cycle WHERE cid =1);

[sub5]
SELECT cid, pid, day, cnt
FROM cycle 
WHERE cid = 1 IN (SELECT cid
                   FROM cycle 
                   WHERE cid = 2);
                   
                   
                   
[sub6]
1번 고객의 애음제품 정보를 조회를 한다.
단 2번 고객이 먹는 애음제품만 조회를 한다.

1번 고객
SELECT cid, pid, day, cnt
FROM cycle
WHERE cid = 1

2번 고객
SELECT pid
FROM cycle
WHERE cid = 2

합치면
SELECT cid, cnm, pid, day, cnt
FROM cycle, customer, product
WHERE cid = 1 AND pid IN(SELECT pid
                         FROM cycle
                         WHERE cid = 2);
                         
                         
[sub7]  
조인을 이용한 방법
SELECT c.cid, cnm, c.pid, pnm, day, cnt
FROM cycle c JOIN customer ON(customer.cid = c.cid AND c.cid = 1)
           JOIN product ON(product.pid = c.pid) AND c.pid IN(SELECT pid
                                                                FROM cycle
                                                                WHERE cid = 2);

스칼라 서브쿼리를 이용한 방법
SELECT cid (SELECT cnm FROM customer WHERE cid = cycle.cid ) cnm
       pid (SELECT pnm FROM customer WHERE pid = cycle.pid ) pnm, day, cnt
FROM cycle
WHERE cid =1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid =2);
