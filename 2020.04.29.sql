OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<==>
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN  : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN  : LEFT OUTER JOIN + RIGHT OUTER JOIN -(�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp ���̺� �÷� �� mgr �÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������, KING ������ ��� ����ڰ� ���� ������ �Ϲ����� INNER ���� ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�


SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

������ �����ؾ�����, �����Ͱ� ��ȸ�ȴ�.
==> KING�� ����� ������(mgr) NULL�̱� ������ ���ο� �����ϰ�
    KING�� ������ ������ �ʴ´�. (emp���̺� �Ǽ� 14�� ==> ���ΰ�� 13��)
    
ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);

���� ������ OUTER �������� ����
(KING������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, 
 ������ ����� ������ ���� ������ ������ �ʴ´�.)

//���� ���� ���̺�(e) ���� / �����ڴ� m
SELECt m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECt m.empno, m.ename, e.empno, e.ename
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1. FROM���� ������ ���̺� ���(�޸��� ����)
2. WHERE���� ���� ������ ���
3. ���� �÷�(�����) �� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�.
  ==> ������ ���̺� �ݴ��� �� ���̺��� �÷�
  
SELECt m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);

ORACLE-SQL
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) 
  AND e.deptno = 10;


������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno) //����� INNER�������� �ؼ��� ��
WHERE e.deptno = 10;

OUTER������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ� ���� �´�.



[outer JOIN1]
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE p.prod_id = b.buy_prod(+)
  AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

[outer JOIN1]
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.prod_id = b.buy_prod) 
  AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

[outer JOIN2]
SELECT NVL(buy_date, '2005/01/25') buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.prod_id = b.buy_prod) 
  AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');

[outer JOIN2]
SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD'), b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.prod_id = b.buy_prod) 
  AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
  

[outer JOIN3]
SELECT NVL(buy_date, '2005/01/25') buy_date, b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty, 0)
FROM buyprod b RIGHT OUTER JOIN prod p ON (p.prod_id = b.buy_prod) 
  AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
  
[outer JOIN4]
 
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM customer;

SELECT p.pid, p.pnm, NVL(c.cid, 1) cid, NVL(c.day,0) day, NVL(c.cnt,0)cnt
FROM cycle c RIGHT OUTER JOIN product p ON (p.pid = c.pid)
AND c.cid = 1;

//?
SELECT *
FROM
(SELECT p.pid, p.pnm, c.cid cid, u.cnm, NVL(c.day,0) day, NVL(c.cnt,0)cnt
 FROM cycle c RIGHT OUTER JOIN product p ON(p.pid = c.pid)
 AND c.cid = 1)
JOIN customer u ON(u.cid = c.cid);


//5
SELECT p.pid, p.pnm, c.cid cid, u.cnm, NVL(c.day,0) day, NVL(c.cnt,0)cnt
 FROM cycle c RIGHT OUTER JOIN product p ON(p.pid = c.pid)
                          JOIN customer u ON(u.cid = c.cid)
 AND c.cid = 1;




CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�.

emp 14 * dept 4 = 56 

ANSI-SQL
SELECT *
FROM emp CROSS JOIN dept;

ORACLE (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�.)
SELECT *
FROM emp, dept;

[CORSS JOIN1]
SELECT *
FROM customer, product;

��������
WHERE ������ �����ϴ� �ุ ��ȸ�ǵ��� ����
SELECT *
FROM emp
WHERE 1 = 1
   OR 1 != 1; 
1 = 1 OR 1 != 1 �� �� �߿� �ϳ��� ���̸� �� TRUE OR FALSE ==> TRUE

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT
    SCALAR SUB QUERY
     * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̿��� �Ѵ�.
     EX) DUAL���̺�
2. FROM
    INLINE-VIEW
    SELECT ������ ��ȣ�� ���� ��

3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
    
SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������
2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ

==> �������� 2���� ������ ���� ����
    �ι�° ������ ù��° ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
    (SMITH => WARD(30 ==> �ι�° ���� �ۼ��� 10������ 30������ ������ ����
    ==> �������� ���鿡�� ���� ����)

ù��° ����
SELECT deptno --20
FROM emp
WHERE ename = 'SMITH';
    
�ι�° ����
SELECT *
FROM emp
WHERE deptno = 20;


�������� ���� ���� ����
SELECT *
FROM emp
WHERE deptno =  (SELECT deptno 
                 FROM emp
                 WHERE ename = 'SMITH');
                               :ename // �ڹٿ��� �Է°��� ���� �޶���
SELECT avg(sal)
FROM emp;

[sub1]
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT avg(sal)
             FROM emp);


[sub2]
SELECT *
FROM emp
WHERE sal > (SELECT avg(sal)
             FROM emp);
             
             


