COMMIT;

//실습 join0_3
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
  AND emp.sal > 2500 
  AND emp.empno > 7600;

//실습 join0_3 ORACLE문법으로
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.sal > 2500
  AND emp.empno > 7600; 
  
//실습 join0_4
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
  AND emp.deptno = 20
  AND emp.sal > 2500 
  AND emp.empno > 7600;
  
//실습 join0_4 ORACLE문법으로
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.deptno = 20
  AND emp.sal > 2500
  AND emp.empno > 7600;  


//실습 join1
SELECT lprod.lprod_gu, lprod.lprod_nm, prod.prod_id, prod.prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);

//실습 join2 
SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

//열 갯수 세기
SELECT count(buyer.buyer_id)
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

//buyer_name, 건수,
SELECT buyer.buyer_name, count(*)
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id)
GROUP BY buyer.buyer_name;


//실습 join3
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM prod,cart,member
WHERE prod.prod_id = cart.cart_prod
AND cart.cart_member = member.mem_id;

//ANSI
테이블 JOIN 테이블 ON/USING
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member JOIN cart ON(cart.cart_member = member.mem_id) 
            JOIN prod ON(prod.prod_id = cart.cart_prod);

참고사항 // 몇 행이 나올까? 
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT * 
FROM 
    (SELECT deptno, COUNT(*)
     FROM emp
     GROUP BY deptno)
WHERE deptno = 30;

//위와 같은 것 // 아래것 처럼 하는 것이 더 남, 위에는 조회하지 않아야 될 것도 조회함
SELECT deptno, COUNT(*)
FROM emp
WHERE deptno = 30
GROUP BY deptno;


SELECT *
FROM customer;

SELECT *
FROM cycle;

cycle : 애음주기
cid :  고객 id
pid :  제품 id
day : 애음 요일(월요일, 화요일 .../.)
cnt : 수량

SELECT *
FROM product;

SELECT *
FROM buyer;

//4
SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
  AND customer.cnm != 'cony';  

SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE customer.cnm IN ('brown', 'sally');

  
//5
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)
              JOIN product ON(cycle.pid = product.pid AND customer.cnm != 'cony'); 
  
              
SELECT customer.cid, cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM customer, cycle, product 
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid 
AND customer.cnm IN ('brown', 'sally');             



//6

SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, sum(cycle.cnt) cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
              JOIN product ON (cycle.pid = product.pid)
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;



//7
SELECT cycle.pid, product.pnm, sum(cycle.cnt) cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
              JOIN product ON (cycle.pid = product.pid)
GROUP BY cycle.pid, product.pnm;

SELECT pid, sum(cycle.cnt) cnt
FROM cycle 
GROUP BY cycle.pid = product.pid
WHERE pid, product.pnm;

