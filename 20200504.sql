EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS(��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� �����ϱ� ������
emp���̺��� ��� �����Ͱ� ��ȸ�ȴ�.

�Ʒ������� ���ȣ ��������
�Ϲ������δ� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� �����ʰ� �ߴ�.
���� ���翩�ο� ������ ������ ���

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);
              

�Ŵ����� ���� ���� :KING
�Ŵ��� ������ �����ϴ� ���� : 14-KING = 13���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

IS NOT NULL �̿��� �� ����
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

==> EXISTS ������ Ȱ���ؼ� �ǽ�

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



���տ���
������
{1,5,3} U {2,3} = {1,2,3,5}
SQL���� �����ϴ� UNION ALL (�ߺ������͸� �������� �ʴ´�)
{1,5,3} U {2,3} = {1,2,3,5}


������
 {1,5,3} ������ {2,3} = {3}

������
 {1,5,3} ������ {2,3} = {1,5}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ��(��, �Ʒ��� ���յȴ�)

UNION ������
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698, 7369)


UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)



UNION ALL������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)


INTERSECT ������ �� �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)


MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����


SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698)



SQL ���� �������� Ư¡

���� �̸� : ù�� SQL�� �÷��� ���󰣴�

SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7689);

	2. ������ �ϰ� ���� ��� �������� ���� ����
����SQL���� ORDER BY �Ұ�(�ζ��� �並 ����ؾ� ������������ ORDER BY�� ������� ������ ����) 


SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY n, �߰� ������ ���� �Ұ�
UNION

SELECT ename, empno
FROM emp
WHERE empno IN (7689)
ORDER BY nm;

	3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���հ���� ����) 
    ��, UNION ALL�� �ߺ����

	4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
	==> ����ڿ��� ����� �����ִ� �������� ������
		==> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡�� �����ϴ�.
		
	�˰���(���� - ���� ����, ���� ���ġ���
				 �ڷᱸ�� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
				  heap
				  stack, queue
				  list
				
	���տ��꿡�� �߿��� ���� : �ߺ�����
	
�������� 
For(int i = 0;..){ //10��
	For(int j = 1;��){ //10�� 
		 code��.
	}
}

==> 100�� = n����

SELECT *
FROM FASTFOOD;

������ �Ҷ� 1������
��/��/��/�� =GROUP
=>����ŷ+�Ƶ�����+KFC/�Ե�����
��Į��? ����? ���տ��� �ʿ�

���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT), �ζ��κ�, ROWNUM, ORDER BY. ��Ī(�÷�, ���̺�), ROUND, JOIN



SELECT SUM(count(gb) b + count(gb) m + count(gb) k) / count(gb) l
FROM FASTFOOD
WHERE gb;

SELECT sido, sidungu, COUNT(*)
FROM FASTFOOD f 
WHERE gb IN ('����ŷ','�Ƶ�����','KFC')
GROUP BY sido, sidungu;
         
(select count(*) FROM FASTFOOD a WHERE gb IN ('�Ե�����'))
      
               
               
                
SELECT ROWNUM rn, a.sido, a.sigungu, a.cntt
FROM
(SELECT bk.sido, bk.sigungu, bk.cnt, mac.cnt, kfc.cnt, lo.cnt, ROUND(bk.cnt+ mac.cnt+ kfc.cnt)/lo.cnt, 2 cntt
FROM 
(SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('����ŷ') 
GROUP BY sido, sigungu bk)

(SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('�Ƶ�����') 
GROUP BY sido, sigungu mac

SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('KFC') 
GROUP BY sido, sigungu kfc

SELECT sido, sigungu, count(*) cnt
FROM FASTFOOD f
WHERE gb IN ('�Ե�����') 
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

[�ʼ�]
����1. fastfood ���̺�� tax���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� sql�ۼ�
 1. �õ� �ñ����� ���ù������� ���ϰ�(������ ���� ���ð� ������ ����)
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
 3. ���ù��������� �δ� �Ű�� [[������ ���� �����ͳ���]] �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL�ۼ�
 
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������,����û �õ�, ����û �ñ���,����û ��������ݾ� 1�δ� �Ű��

[�ɼ�]
����2
�ܹ��� ���ù��������� ���ϱ� ���� 4���� �ζ��� �並 ����ߴµ�,(FASTFOOD ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (FASTFOOD ���̺��� 1���� ���)
case, DECODE

[�ɼ�]
����3
�ܹ������� sql�� �ٸ����·� �����ϱ�




(select count(*) FROM FASTFOOD a WHERE gb IN ('�Ե�����'))



SELECT sido, sigungu, s.count(*)
FROM FASTFOOD f JOIN FASTFOOD s ON(f.sido = s.sigungu)
AND f.gb IN ('����ŷ','�Ƶ�����','KFC')
AND s.gb IN ('�Ե�����');



