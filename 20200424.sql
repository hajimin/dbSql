NULL처리방법 하나 이상 기억


DESC emp;

SELECT NVL(empno,0), ename, NVL(sal, 0), NVL(comm, 0)-> 잘못된 방법
FROM emp; //emp테이블에서는 null처리 굳이 하지 않아도됨


     (널 허용 여부)
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    


condition : (CASE, DECODE)

실행계획 : 실행계획이 뭔지, 보는 순서

SELECT *
FORM emp
ORDER BY deptno;

emp테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN인경우 SAL에서 5%인상된 금액을 보너스로 지급(ex: sal 100->105)

해당 직원의 job이 MANAGER이면서 deptno가 10이면 SAL에서 30%인상된 금액을 보너스로 지급
                그외의 부서에 속하는 사람은 10%인상된 금액을 보너스로 지급 
해당 직원의 job이 PRESIDENT인경우 SAL에서 20%인상된 금액을 보너스로 지급
그외 직원들은 SAL만큼만 지급

//decode이용//

DRCODE 

SELECT *
FROM emp;


SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal*1.05,
                    'MANAGER', 
                    DECODE(deptno, 10, sal*1.30, sal*1.10),
                    'PRESIDENT', sal*1.20,
                    sal) bonus
FROM emp;


집합 A = {10,15,18,23,24,25,29,30,35,37}

소수 : 자신과 1을 약수로 하는 수
Prime Numnber 소수 : {23,29,37} : COUNT-3, MAX-37, MIN-29, AVG-29.66, SUM-89 => 3개의 데이터가 결과적으로 하나로 나옴 [ 그룹함수 ]
비소수 : {10,15,18,24,25,30,35};


카운팅 + 급여도 합산

SELECT *
FROM emp
ORDER BY deptno;


GROUP FUNCTION

여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다.
EX : 부서별 급여 평균
    emp테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10,20,30)에 속해 있다
        부서별 급여 평균은 3개의 행으로 결과가 반환된다.



GROUP BY 적용시 주의사항 : SELECT 기술할 수 있는 컬럼이 제한됨        

SELECT 그룹핑 기준 컬럼, 그룹함수
FROM 테이블
GROUP BY 그룹핑 기준 컬럼
[ORDER BY ];

부서별로 가장 높은 급여 값
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;








//오류 : 그룹핑 하기로 한 컬럼이 아닌 값이 오면(ename) 오류가 남 .. 단, 그룹함수 적용하면 괜찮음 MIN(ename)
SELECT deptno, ename, MAX(sal), MIN(ename)
FROM emp
GROUP BY deptno; 



SELECT deptno, 
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), -- 부서별로 가장 낮은 급여 값
        AVG(sal), -- 부서별 급여 평균
        ROUND(AVG(sal), 2),-- 소수점 반올림
        SUM(sal), -- 부서별 급여 합
        COUNT(sal), -- 부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT (*), -- 부서별 행의 수 (비즈니스에선 자주 사용하긴 함)
        COUNT(mgr)
FROM emp
GROUP BY deptno;


SELECT --그룹 컬럼명이 없어도 되지만, GROUP BY 컬럼에 없는 값을 적으면 안됨
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), -- 부서별로 가장 낮은 급여 값
        AVG(sal), -- 부서별 급여 평균
        ROUND(AVG(sal), 2),-- 소수점 반올림
        SUM(sal), -- 부서별 급여 합
        COUNT(sal), -- 부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT (*), -- 부서별 행의 수 (비즈니스에선 자주 사용하긴 함)
        COUNT(mgr)
FROM emp
GROUP BY deptno;




* 그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만
  가장 높은 급열르 받는 사람의 이름을 알 수 없다
      ==> 추후 WINDOW/분석 FUNCTION을 통해 해결가능


emp테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정하는 방법

SELECT  MAX(sal), --전체 직원 중 가장 높은 급여 값
        MIN(sal), -- 전체 직원 중 가장 낮은 급여 값
        ROUND(AVG(sal), 2), -- 전체 직원의 급여 평균
        SUM(sal), -- 전체 직원의 부서별 급여 합
        COUNT(sal), -- 전체 직원의 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT (*), -- 전체 행의 수 (비즈니스에선 자주 사용하긴 함)
        COUNT(mgr) --mgr컬럼이 null이 아닌 건수
FROM emp;


27일 정답 발표
GROUP BY 절에 기술된 컬럼이 
    SELECT절에 나오지 않으면?

GROUP BY 절에 기술된 컬럼이 
    SELECT절에 나오면?



그룹화와 관련 없는 문자열, 상수 등은 SELECT절에 표현될 수 있다(에러아님)
SELECT deptno, 'test',1,
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), -- 부서별로 가장 낮은 급여 값
        ROUND(AVG(sal), 2),-- 소수점 반올림
        SUM(sal), -- 부서별 급여 합
        COUNT(sal), -- 부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT (*), -- 부서별 행의 수 (비즈니스에선 자주 사용하긴 함)
        COUNT(mgr)
FROM emp
GROUP BY deptno;



GROUP함수 연산시 NULL값은 제외가 된다.
30번 부서에는 NULL값을 갖는 행이 있지만 SUM(comm)의 값이 정상적으로 계산 된 걸 확인 할 수 있다.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

*특별한 사유가 아니면 그룹함수 계산 결과에 NULL처리를 하는 것이 성능상 유리
NVL(SUM(comm),0) : COMM컬럼에 SUM 그룹함수를 적용하고 최종 결과에 NVL적용(1회 호출)
SUM(NVL(comm, 0)) : 모든 COMM컬럼에 NVL함수를 적용후 (해당 그룹의 ROW수 만큼 호출) SUM 그룹함수 적용

SELECT deptno, NVL(SUM(comm),0), SUM(NVL(comm, 0)) --둘다 되지만 NVL이 먼저 앞으로 나오는 것이 더 효율적임
FROM emp
GROUP BY deptno;


signle row함수는 where절에 기술할 수 없지만
multi row함수는 (group 함수)는 where절에 기술할 수 없고,
GROUP BY 절 이후 HAVING절에 별도로 기술

signle row함수는 where절에서 사용가능
SELECT *
FROM emp
WHERE LOWER;

SELECT *
FROM emp
WHERE 
GROUP BY deptno;

부서별 급여 합이 9000 넘는 부서만 조회
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

///명칭 안적은 것
SELECT 
        MAX(sal),
        MIN(sal),
        ROUND(AVG(sal), 2),
        SUM(sal),
        COUNT (sal). 
        COUNT (mgr),
        COUNT (*)
FROM emp
GROUP BY deptno


///
SELECT 
        MAX(sal)max_sal,
        MIN(sal)min_sal,
        ROUND(AVG(sal), 2)avg_sal,
        SUM(sal)sum_sal,
        COUNT (sal)count_sal,
        COUNT (mgr)count_mgr,
        COUNT (*)count_all
FROM emp
WHERE sal IS NOT NULL
OR mgr IS NOT NULL;


///
SELECT deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT (sal) count_sal,
        COUNT (mgr) count_mgr,
        COUNT (*) count_all
FROM emp
GROUP BY deptno
HAVING COUNT(sal) IS NOT NULL
OR COUNT(mgr) IS NOT NULL;

///
SELECT  DECODE(deptno, 10, 'ACCOUNTING', 
               20,'RESEARCH',
               30, 'SALES', 
               40, 'OPERATIONS', 'DDIT') dname, 
                MAX(sal) max_sal,
                MIN(sal) min_sal,
                ROUND(AVG(sal), 2) avg_sal,
                SUM(sal) sum_sal,
                COUNT (sal) count_sal,
                COUNT (mgr) count_mgr,
                COUNT (*) count_all
FROM emp
GROUP BY deptno
HAVING COUNT(sal) IS NOT NULL
OR COUNT(mgr) IS NOT NULL;

//연도, 월 입사한 사람들
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_YYYYMM, COUNT (*) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

//연도별 입사한 사람들 명
SELECT TO_CHAR(hiredate, 'YYYY') hire_YYYY, COUNT (*) CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

//전체 컬럼 중에서 부서갯수 계산
SELECT COUNT (deptno) cnt
FROM dept;

//COUNT로 두번 묶어서 계산
SELECT COUNT(COUNT (deptno)) cnt
FROM emp
GROUP BY deptno;



