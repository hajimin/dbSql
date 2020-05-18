서브그룹 생성 방식
ROLLUP: 뒤에서 (오른쪽에서) 하나씩 지워가변서 서브그룹 생성
            => (deptno, job), (deptno) , wjscp
CUBE : 

sub_a2실습
DROP TABLE dept_test;

SELECT *
FROM dept;

DELETE dept
WHERE deptno NOT IN(10,20,30,40);

COMMIT;

CREATE TABLE dept_test AS 
SELECT *
FROM dept;

SELECT *
FROM dept_test;

INSERT INTO dept_test values (99,'it1', 'daejeon');
INSERT INTO dept_test values (98,'it2', 'daejeon');


DELETE dept_test
WHERE deptno NOT IN (SELECT deptno FROM emp);


40번 부서 삭제
DELETE dept_test
WHERE NOT EXISTS (SELECT 'X' 
                  FROM emp 
                  WHERE emp.deptno = dept.deptno);


sub_a3실습
SELECT *
FROM emp_test;


UPDATE emp_test SET sal = sal +  200 
WHERE sal <(해당직원이 속한 부사의 급여평균을 구하는 SQL);

ROLLBACK;
상호연관 서브쿼리 UPDATE 
UPDATE emp_test a 
SET sal = sal +  200 
WHERE sal <(SELECT avg(sal)
            FROM emp_test b
            WHERE a.deptno = b.deptno
            GROUP BY deptno);

SELECT *
FROM emp_test;

공식용어는 아니지만 , 검색 - 도서에 자주 나오는 표현
서브쿼리의 사용된 방법 
1. 확인자 : 상호연관 서브쿼리 (EXISTS)
            ==> 메인 쿼리부터 실행 ==> 서브 쿼리 실핼
2. 공급자: 서브쿼리가 먼저 실행되서 메인 쿼리에 값을 공급 해주는 역할

13건 : 매니저가 존재하는 직원을 조회
SELECT *
FROM emp
WHERE mgr IN (SELECT empno 
                FROM emp);
                             
SELECT *
FROM emp
WHERE mgr IN (7369, 7499, .....);

부서별 급여평균이 전체급여평균보다 큰 부서의 부서번호, 부서별 급여평균 구하기

부서별 평균 급여(소숫점 둘째자리까지 결과만들기)
SELECT deptno, ROUND(avg(sal), 2)
FROM emp
GROUP BY deptno;

전체 급여 평균
SELECT ROUND(avg(sal), 2)
FROM emp;


SELECT deptno, ROUND(avg(sal), 2)
FROM emp
GROUP BY deptno
HAVING ROUND(avg(sal), 2)>(SELECT ROUND(avg(sal), 2)
                           FROM emp);



WITH 절을 이용해 따로 빼서 조회
WITH 절 : SQL에서 반복적으로 나오는 QUERY BLOCK(SUBQUERT)을 별도로 선언하여
         SQL 실행시 한번만 메모리에 로딩을 하고 반복적으로 사용할 때 메모리 공간의 데이터를 
         활용하여 속도 개선을 할 수 있는 keyword
         단, 하나의 sql에서 반복적인 sql 블럭이 나오는 것은 잘 못 작성한 sql일 가능성이 높기 때문에
         다른 형태로 변경할 수 있는지 확인
         
WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal), 2)
    FROM emp
)

SELECT deptno, ROUND(avg(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(avg(sal), 2)>(SELECT*
                           FROM emp_avg_sal);

계층쿼리 : 달력만들기
CONNECT BY LEVEL : 행을 반복하고 싶은 수 많큼 복제를 해주는 기능
위치 : FROM(WHERE)절 다음에 기술
DUAL 테이블과 많이 사용

테이블에 행이 한건, 메모리에서 복제
SELECT LEVEL
FROM DUAL
CONNECT BY LEVEL <= 5;

위의 쿼리 말고도 이미 배운 KEYWORD를 이용하여 작성 가능(=결과자체가 동일)
5행 이상이 존재하는 테이블을 갖고 행을 제한
만약에 우리가 복제할 데이터가 10000건이면 10000건에 대한 DISK I/O가 발생

SELECT ROWNUM
FROM emp
WHERE ROWNUM <=5;

1. 우리에게 주어진 문자열 년월 : 202005
    주어진 년월의 일수를 구하여 일수만 행을 생성
    TO_DATE('202005', 'YYYYMM'), LEVEL
        

달력의 컬럼은 7개 - 컬럼의 기준은 요일 : 특정일자는 하나의 요일에 포함    
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 7개 컬럼을 추가로 생성
        일요일이면 dt컬럼, 월요일이면 dt컬럼, 화요일이면 dt컬럼.... 토요일이묜 dt컬럼
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'); 

아래방식으로 SQL을 작성해도 쿼리를 완성하는게 가능하나
가독성 측면에서 너무 복잡하여 인라인 뷰를 이용하여 쿼리를 좀더 단순하게 만든다
SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt, 
        DECODE (TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '1', TO_DATE('202005', 'YYYYMM') + (LEVEL-1) sun,
        SECODE (TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D'), '2', TO_DATE('202005', 'YYYYMM') + (LEVEL-1) mon
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'); 

SELECT dt, dt가 월욜이묜 dt, dt가 화요일이묜 dt.... 7개의 컬럼중에 딱 하나의 컬럼에만 dt값이 표현된다

SELECT dt, DECODE(d, 1,dt) sun, DECODE(d,2,dt)mon, DECODE(d,3,dt)tue,
            DECODE(d,4,dt) wed, DECODE(d,5,dt)thu, DECODE(d,6,dt)fri, DECODE(d,7,dt)sat
FROM
(SELECT TO_DATE('202005', 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE('202005', 'YYYYMM') + (LEVEL-1), 'D') d
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')); 

한행으로 ///////////// 

SELECT DECODE(d,1,iw+1,iw),
            MIN(DECODE(d, 1,dt)) sun, MIN(DECODE(d,2,dt)) mon, 
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt))fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY DECODE(d,1,iw+1,iw) 
 ORDER BY DECODE(d,1,iw+1,iw);




SELECT TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')), 'DD')
FROM dual;


SELECT 
            MIN(DECODE(d, 1,dt)) sun, MIN(DECODE(d,2,dt)) mon, 
            MIN(DECODE(d,3,dt)) tue, MIN(DECODE(d,4,dt)) wed, 
            MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt))fri, 
            MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) - 
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw')+1 f_sun
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY f_sun 
 ORDER BY f_sun;




