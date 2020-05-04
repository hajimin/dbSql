EXISTS 연산자
사용방법 : EXISTS (서브쿼리)
서브쿼리의 조회결과가 한건이라도 있으면 TRUE
잘못된 사용방법 : WHERE deptno EXISTS(서브쿼리)

메인쿼리의 값과 관계 없이 서브쿼리의 실행 결과는 항상 존재하기 때문에
emp테이블의 모든 데이터가 조회된다.

아래쿼리는 비상호 서브쿼리
일반적으로는 EXISTS 연산자는 상호연관 서브쿼리로 많이 사용

EXISTS 연산자의 장점
만족하는 행을 하나라도 발견을 하면 더이상 탐색을 하지않고 중단.
행의 존재여부에 관심이 있을때 사용

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);
              

매니저가 없는 직원 :KING
매니저 정보가 존재하는 직원 : 14-KING = 13명의 직원
EXISTS 연산자를 활용하여 조회

IS NOT NULL 이용할 수 있음
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

==> EXISTS 연산자 활용해서 실습

SELECT *
FROM emp e
WHERE EXISTS(SELECT 'X'
             FROM emp m
             WHERE e.mgr = m.empno);

join
SELECT *
FROM emp e, emp m
WHERE emp e = emp m



//sub9

SELECT *
FROM product
WHERE EXISTS(SELECT *
             FROM cycle
             WHERE product.pid = cycle.pid
             AND cid =1);



//sub10

SELECT *
FROM product
WHERE NOT EXISTS(SELECT *
             FROM cycle
             WHERE product.pid = cycle.pid
             AND cid = 1);



집합연산
합집합
{1,5,3} U {2,3} = {1,2,3,5}
SQL에만 존재하는 UNION ALL (중복데이터를 제거하지 않는다)
{1,5,3} U {2,3} = {1,2,3,5}


교집합
 {1,5,3} 교집합 {2,3} = {3}

차집합
 {1,5,3} 차집합 {2,3} = {1,5}

SQL에서의 집합연산
연산자 : UNION, UNION ALL, INTERSECT, MINUS
두개의 SQL의 실행결과를 행을 확장(위, 아래로 결합된다)

UNION 연산자
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698, 7369)


UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)



UNION ALL연산자 : 중복허용

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)


INTERSECT 교집합 ㅣ 두집합간 중복되는 요소만 조회

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)


MINUS 연산자 : 위쪽 집합에서 아래쪽 집합 요소를 제거


SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)



SQL 집합 연산자의 특징

열의 이름 : 첫번 SQL의 컬럼을 따라간다

SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7689);

	2. 정렬을 하고 싶을 경우 마지막에 적용 가능
개별SQL에는 ORDER BY 불가(인라인 뷰를 사용해야 메인쿼리에서 ORDER BY가 기술되지 않으면 가능) 


SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY n, 중간 쿼리에 정렬 불가
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7689)
ORDER BY nm;

	3. SQL의 집합 연산자는 중복을 제거한다(수학적 집합개념과 동일) 
    단, UNION ALL은 중복허용

	4. 두개의 집합에서 중복을 제거하기 위해 각각의 집합을 정렬하는 작업이 필요
	==> 사용자에게 결과를 보내주는 반응성이 느려짐
		==> UNION ALL을 사용할 수 있는 상황일 경우 UNION을 사용하지 않아야 속도적인 측면에서 유리하다.
		
	알고리즘(정렬 - 버블 정렬, 삽입 정렬……
				 자료구조 : 트리구조(아진 트리, 밸런스 트리)
				  heap
				  stack, queue
				  list
				
	집합연산에서 중요한 사항 : 중복제거
	
버블정렬 
For(int i = 0;..){ //10개
	For(int j = 1;…){ //10개 
		 code….
	}
}

==> 100개 = n제곱

SELECT *
FROM FASTFOOD;

정렬을 할때 1위부터
시/도/군/구 =GROUP
=>버거킹+맥도날드+KFC/롯데리아
스칼라? 조인? 집합연산 필요

사용된 SQL 문법 : WHERE, 그룹연산을 위한 GROUP BY, 복수행 함수(COUNT), 인라인뷰, ROWNUM, ORDER BY. 별칭(컬럼, 테이블), ROUND, JOIN



SELECT SUM(count(gb) b + count(gb) m + count(gb) k) / count(gb) l
FROM FASTFOOD
WHERE gb;

SELECT sido, sidungu, COUNT(*)
FROM FASTFOOD f 
WHERE gb IN ('버거킹','맥도날드','KFC')
GROUP BY sido, sidungu;
         
(select count(*) FROM FASTFOOD a WHERE gb IN ('롯데리아'))
      
               
               
                
SELECT ROWNUM rn, a.sido, a.sigungu, a.cntt
FROM
(SELECT bk.sido, bk.sigungu, bk.cnt, mac.cnt, kfc.cnt, lo.cnt, ROUND(bk.cnt+ mac.cnt+ kfc.cnt)/lo.cnt, 2 cntt
FROM 
(SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('버거킹') 
GROUP BY sido, sigungu bk)

(SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('맥도날드') 
GROUP BY sido, sigungu mac

SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('KFC') 
GROUP BY sido, sigungu kfc

SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('롯데리아') 
GROUP BY sido, sigungu lo
WHERE bk.sido, = kfc.sigungu
AND bk.sido = mac.sido
AND bk.sigungu = 
AND 
AND 
AND 
AND 


SELECT *
FROM tax;

[필수]
과제1. fastfood 테이블과 tax테이블을 이용하여 다음과 같이 조회되도록 sql작성
 1. 시도 시군구별 도시발전지수 구하고(지수가 높은 도시가 순위가 높다)
 2. 인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
 3. 도시발전지수와 인당 신고액 [[순위가 같은 데이터끼리]] 조인하여 아래와 같이 컬럼이 조회되도록 SQL작성
 
순위, 햄버거 시도, 햄버거 시군구, 햄버거 도시발전지수,국세청 시도, 국세청 시군구,국세청 연말정산금액 1인당 신고액

[옵션]
과제2
햄버거 도시발전지수를 구하기 위해 4개의 인라인 뷰를 사용했는데,(FASTFOOD 테이블을 4번 사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선 (FASTFOOD 테이블을 1번만 사용)
case, DECODE

[옵션]
과제3
햄버거지수 sql을 다른형태로 도전하기




(select count(*) FROM FASTFOOD a WHERE gb IN ('롯데리아'))



SELECT sido, sigungu, s.count(*)
FROM FASTFOOD f JOIN FASTFOOD s ON(f.sido = s.sigungu)
AND f.gb IN ('버거킹','맥도날드','KFC')
AND s.gb IN ('롯데리아');



