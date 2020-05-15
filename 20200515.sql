ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY 를 실행

아래 쿼리의 서브그룹
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

ROLLUP 사용시 생성되는 서브그룹의 수는 : ROLLUP 에 기술한 컬럼수 +1

실습 2
SELECT NVL(job, '총계'),deptno, 
        GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT 
CASE
    when GROUPING(job) = 1 THEN '총계'
    ELSE job
END job,
 deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);


실습
SELECT 
CASE
    WHEN GROUPING(job) = 1 THEN '총' 
    ELSE job
END job, 
CASE
    WHEN GROUPING(job) = 1 THEN '계'
    WHEN GROUPING(deptno) = 1 THEN '소계'
    ELSE TO_CHAR(deptno)
    END deptno, SUM(sal) sal_sum
FROM emp
GROUP BY ROLLUP (job, deptno);

실습3
SELECT deptno,job, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno,job);


실습 4 
REPORT GROUP FUNCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION 을 사용안하면
여러개의 SQL을 작성, UNION ALL을 통해서 하나의 결과로 합쳐지는 과정

=> 좀더 편하게 하는게 REPORT GROUP FUNCTION 

ROLLUP절에 기술되는 컬럼의 순서는 조회결과에 영향을 미친다
(****** 서브 그룹을 기술된 컬럼의 오른쪽부터 제거해나가면서 생성)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);

OUTER JOIN 연습

SELECT dept.dname, emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno=dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

인라인뷰 연습
SELECT dept.dname, a.job, a.sum_sal
FROM
(SELECT deptno,job, SUM(sal) sum_sal
FROM emp 
GROUP BY ROLLUP (deptno,job))a, dept
WHERE a.deptno=dept.deptno;


실습 5
SELECT  NVL(dept.dname,'총계'), emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno=dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);


2.GROUPING SETS
ROLLUP의 단점 : 관심없는 서브그룹도 생성해야한다.
            ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
            만약 중간과정에 있는 서브그룹이 불필요할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP과는 다르게 방향서잉 없다
                
사용법 : GROUP BY GROUPING SETS (col1, col2)

GROUP BY col1
UNION ALL
GROUP BY col2


얘랑 같냐? 응 같아~
GROUP BY GROUPING SETS (col1, col2)
GROUP BY GROUPING SETS (col2, col1)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

아래쿼리랑 같음

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY (job);

UNION

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY (deptno);

그룹기준을
1.job, deptno
2. mgr

GROUP BY GROUPING SETS ((job, deptno), mgr)


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno), mgr);


3. CUBE
사용법 : GROUP BY CUBE

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job, deptno);


여러개의 REPORT GROUP 사용하기
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);


**발생가능한 조합을 계산
1       2       3
job     deptno  mgr    => GROUP BY job, deptno, mgr
job     X       mgr    => GROUP BY job, mgr
job     deptno  X      => GROUP BY job, deptno
job     X       X      => GROUP BY job


SELECT job,deptno, mgr, SUM(sal+NVL(comm,0))sal
FROM emp
GROUP BY job, rollup(job, deptno), CUBE(mgr);

1       2           3
job     job ,deptno  mgr     => GROUP BY job, job,deptno,mgr ==> GROUP BY job, deptno,mgr
job     job          mgr     => GROUP BY job,job, mgr ==> GROUP BY job, mgr
job     X            mgr     => GROUP BY job, x, mgr==> GROUP BY job, mgr
job     job ,deptno  X       => GROUP BY job, job, deptno ==> GROUP BY job,deptno
job     job          X       =>  GROUP BY job, job, X ==>  GROUP BY job
job     X            X       =>  GROUP BY job, X, X==> =>  GROUP BY job

상호연관 서브쿼리 업데이트
1. emp 테이블을 이용하여 emp_test 테이블 생성
==>기존에 생성된 emp_test 테이블 삭제 먼저 진행
DROP TABLE emp_test;

CREATE TABLE emp_test AS 
SELECT *
FROM emp;

2. emp_test 테이블에 dname컬럼 추가(dept 테이블 참고)
DESC emp;  
ALTER TABLE dept_test ADD (dname VARCHAR2(14));
DESC emp_test;

3. subquery 를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트해주는 쿼리를 작성
emp_test 의 dname 컬럼의 값을 dept 테이블의 dname컬럼으로 update
emp_test테이블의 deptno값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname 컬럼값을 가져와 update

SELECT *
FROM emp;

emp_test테이블의 dname 컬럼을 dept 테이블을 이용해서 dname값을 조회하여 업데이트
UPDATE대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음

모든직원을 대상으로 dname 컬럼을 dept테이블에서 조회하여 업데이트
UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);
                             
실습 1
DROP TABLE dept_test;

CREATE TABLE dept_test AS 
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER(4));

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno
                                GROUP BY deptno);
                             
SELECT *
FROM dept_test;

SELECt 결과 전체를 대상으로 그룹함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1=2;

GROUP BY 절을 기술한 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다

SELECT COUNT(*)
FROM emp
WHERE 1=2
GROUP BY deptno;



