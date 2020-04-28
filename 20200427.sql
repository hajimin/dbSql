//COUNT로 두번 묶어서 계산//복습
SELECT COUNT(*) cnt
FROM 
    (SELECT deptno /*deptno컬럼이 1개 존재, row는 3개 존재*/
     FROM emp
     GROUP BY deptno);
     
DBMS : DataBase Management System
 ==> dbe
 
RDBMS : Relational DataBase Management System
 ==> 관계형 데이터베이스 관리시스템


SELECT *
FROM emp;


JOIN 문법의 종류
ANSI - 표준
벤더사의 문법(ORACLE)

JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 때문에
SELECT 할 수 있는 컬럼의 개수가 많아진다(가로확장)

집합연산 ==> 세로 확장 (행이 많아짐)

NATURAL JOIN 
   - 조인하려는 두 테이블의 연결고리 컬럼의 이름 같을 경우
   - emp, dept테이블에는 detpno라는 공통된 (동일한 이름의, 타입도 동일) 연결고리 컬럼이 존재
   - 다른 ANSI -SQL문법을 통해서 대체가 가능하고, 조인테이블들의 컬럼명이 동일하지 않으면
     사용이 불가능하기 때문에 사용빈도는 다소 낮다

[emp 테이블 :14건]
[dept 테이블 : 4건]

SELECT *
FROM emp;

SELECT *
FROM dept;

조인하려는 컬럼을 별도 기술하지 않음
SELECT *
FROM emp NATURAL JOIN dept; /*두 테이블의 이름이 동일한 컬럼으로 연결한다. ==> deptno*/

ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않음
오라클 조인 문법
 1. 조인할 테이블 목록을 FROM절에 기술하며 구분자는 콜론(,)
 2. 연결고리 조건을 WHERE절에 기술하면 된다(ex: WHERE emp.deptno = dept.deptno)


SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

deptno가 10번인 직원들만 dept테이블과 조인하여 조회
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND dept.deptno = 10;


ANSI-SQL : JOIN with using
 - JOIN하려는 테이블 간 이름이 같은 컬럼이 2개이상일때
 - 개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술
  
SELECT *
FROM emp JOIN dept USING (deptno);

중요/제일 잘씀
ANSI-SQL : JOIN with ON 
  - 조인하려는 두테이블간 컬럼명이 다를때
  - ON절에 연결고리 조건을 기술
  
  
SELECT *
FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
(중요)ORACLE 문법으로 위 SQL을 작성
SELECT *
FROM emp, dept 
WHERE emp.deptno = dept.deptno;

JOIN의 논리적인 구분
SELF JOIN : 조인하려는 테이블이 서로 같을 때
EMP 테이블의 한행은 직원의 정보를 나타내고 직원의 정보중 mgr컬럼은 해당직원의 관리자 사번을 관리
해당 직원의 관리자의 이름을 알고 싶을 때 

ANSI_SQL로 SQL 조인 : 
조인하려고 하는 테이블 EMP(직원), EMP(직원의 관리자)
            연결고리 컬럼 : 직원.mgr = 관리자.empno
            ==> 조인 컬럼 이름이 다르다( MGR< EMPNO)
                ==> NATURAL JOIN, JOIN with USING은 사용이 불가능한 형태
                    ==> JOIN with ON
                    
SELF JOIN : 

SELECT *
FROM emp a JOIN emp b ON (a.mgr = b.empno);

NONEUQI JOIN : 연결고리 조건이  =이 아닐때
그동안 WHERE에서 사용한 연산자 : =, !=, <>, <=, <, >, >=
                                AND, OR, NOT
                                LIKE %, _ 
                                OR - IN
                                BETWEEN AND ==>  >=, <=
                                
SELECT *
FROM salgrade;

SELECT *
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

원하는 조건을 SELECT절에 기술
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

==> ORACLE 조인 문법으로 변경
 
SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
 
//실습 join0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname 
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

//실습 join0 ORACLE문법으로
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

//실습 join0_1

SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
  AND emp.deptno IN (10,30);
  
//실습 join0_1 ORACLE문법으로
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno IN (10,30);

//실습 join0_2
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
  AND emp.sal > 2500;
  
//실습 join0_2 ORACLE문법으로
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500; 


























