SET SERVEROUTPUT ON ; 
DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;

BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept;

    /*java : for
    int[] arr = new int[20]();
    for(int i=0; i<array.length; i++){
        System.out.println(arr[i]);
    }*/
    
    FOR i IN 1..v_dept.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_dept(i).deptno || '/' || v_dept(i).dname || '/' ||v_dept(i).loc);
    END LOOP;
END;
/

��������
IF ����

IF condition THEN
    statement;
ELSIF condition THEN
    statement;
END IF;

NUMBER Ÿ���� p ������ �����ϰ� 2�� ����
IF ������ ���� p���� üũ�Ͽ� ����ϴ� ����

DECLARE
    --int a = 2;
    p NUMBER := 2;
BEGIN
    /*p�� 1�̸� 1�� ���
    p�� 2�̸� 2�� ���
    �׹��� ���� ���� else�� ���
    
    java
    if( p==1 )
    
    javascript
    var a;
    if( p==1 )
    if (p ===1 )*/

    IF p = 1 THEN 
        DBMS_OUTPUT.PUT_LINE('1');
    ELSIF p = 2 THEN
        DBMS_OUTPUT.PUT_LINE('2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('else');
    END IF;
    
END;
/

CASE ����
�˻� ���̽�(java switch)
���� 
    CASE ǥ����
        WHEN VALUE THEN
            statement;
        WHEN VALUE2 THEN
            statement;
        ELSE 
            statement;
    END CASE;
    
    
    
DECLARE
    p NUMBER := 2;

BEGIN
     case p
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('1');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('2');
        ELSE
            DBMS_OUTPUT.PUT_LINE('else');
    END CASE;
END;



�Ϲ� ���̽� : �Ϲ� ����� IF����, SQL���� ����� CASE ������ ����, CASE - END CASE;
    CASE
        WHEN expression THEN
            statement;
        WHEN expression2 THEN
            statement;
        ELSE 
            statement;
    END CASE;
    
 
    
DECLARE
    p NUMBER := 2;
BEGIN
    CASE
        WHEN p =1  THEN
            DBMS_OUTPUT.PUT_LINE('1');
        WHEN p =2  THEN
            DBMS_OUTPUT.PUT_LINE('2');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('else');
    END CASE;
      
END;
/
    
  
    
���̽� ǥ���� 
    CASE
        WHEN expression THEN
            ��ȯ�� ��;
        WHEN expression2 THEN
            ��ȯ�� ��;
        ELSE 
            ��ȯ�� ��;
    END CASE;




DECLARE
    p NUMBER := 2;
    ret NUMBER := 0;
BEGIN
    ret := CASE
        WHEN p =1  THEN
            4
        WHEN p =2  THEN
            5
        ELSE 
            6
    END;
  DBMS_OUTPUT.PUT_LINE(ret);
END;
/


�ݺ���
�ε��� ������ �����ڰ� ������ �������� �ʴ´�
REVERSE �ɼ��� ����ϸ� ���ᰪ ���� ���� 1�� �ٿ������� �ε��� ������ ���۰��� �� ������ ����
for(int = 10; 1>0; i++)

FOR �ε��� ���� IN(REVERSE) ���۰�.. ���ᰪ LOOP
END LOOP;

1���� 5���� �ݺ����� �̿��Ͽ� ���

DECLARE
    i NUMBER := 5;
BEGIN
    FOR i IN 1.. 5 LOOP
        DBMS_OUTPUT.PUT_LINE('test');
    END LOOP;  
        DBMS_OUTPUT.PUT_LINE(i);

END;
/


2~9�ܱ���

DECLARE
BEGIN
    FOR i IN 2..9 LOOP
        FOR j IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' ||  (i*j));
        END LOOP;
    END LOOP;
END;
/




java �ݺ��� ���� : for, while, do-while



while 
����
WHILE condition LOOP
    statement;
END LOOP;



 
DECLARE
    i NUMBER := 1;
BEGIN
    WHILE i <=5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        i := i+1;
    END LOOP;
END;
/

LOOP
java �������� �ϸ�
java : while(TRUE){
            if(condition){
                break;
            }
        }

���� :


LOOP
    statement;
    EXIT WHEN condition;
    statement;
END LOOP;

 
DECLARE
    i NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN i > 5;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i+1;
    END LOOP;
END;
/


�߿�!!!
������� �߿��Ѱ�
CURSOR : SELECT ���� ���� ����� �����͸� ����Ű�� ������(�޸�)
SQL�� ����ڰ� DBMS�� ��û�� ������ �� ó�� ����
1. ������ SQL�� ����� ���� �ִ��� Ȯ��(�����ȹ�� �����ϱ� ���ؼ�)
2. ���ε� ��������(���ε� ������ ���Ǿ��� ���)
3. ����(execution)
4. ����(fetch)

cursor�� ����ϰ� �Ǹ� ����ܰ踦 �����
==> SELECT ������ ����� ������ ���� �ʰ� CURSOR�� ���� ���� �޸𸮿� ������ �� �ִ�.


PL/SQL�� ��κ��� ������ SELECT ����� Ư�� ������ �����Ͽ� ó���ϴ� ���̱� ������
������ ������ SELECT ����� ��� ���� ���ո����� ���� �ִ�.


cursor�� ����
������ : ������ �̸��� �ο����� �ʰ� ������ DML ����
����� : �����ڰ� �̸��� �ο��� cursor

cursor�� ����ó�� ���� ==> DECLARE

cursor ���ܰ�
1. ����
2. ����(open)
3. ����(FETCH)
4. �ݱ�(CLOSE)

����
1. ���� (DECLARE ��)
    CURSOR Ŀ�� �̸� IS
        QUERY;
2. ����(BEGIN)
    OPEN Ŀ�� �̸�;
3. ���� (BEGIN)
    FETCH Ŀ���̸� INTO variable;
4. �ݱ� (BEGIN)
    CLOSE Ŀ���̸�;

dept ���̺��� ��� ���� ��ȸ�ϰ�, deptno, dname �÷��� Ŀ���� ���ؼ�
��Į�� ����(v_deptno, v_dname)

�������� ��ȸ�ϴ� SELECT ������ ������� �����ϱ� ���ؼ� TABLE TYPE�� ���

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    OPEN deptcursor;
    LOOP
        FETCH deptcursor INTO v_deptno, v_dname;
        
        EXIT WHEN deptcursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_deptno || '/' || v_dname);
    END LOOP;
    CLOSE deptcursor;
END;
/


����� Ŀ���� FOR LOOP ���� ==> ���� ����ϱ� ���� ����
OPEN, CLOSE, FETCH �ϴ� ������ FRO LOOP ���� �ڵ������� �������ش�
�����ڴ� Ŀ�� ����� FOR LOOP�� Ŀ������ �־��ִ� �ɷ� ������ �ܼ�ȭ


����
FOR ���ڵ� �̸�(�� ������ ����) IN Ŀ���̸� LOOP
    ���ڵ� �̸�.�÷������� �÷� ���� ����
END FOR;



������ �ϸ� ����� Ŀ����
�Ʒ� �ִ� ������ ����� Ŀ��!

DECLARE
    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    FOR rec IN deptcursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || '/' || rec.dname);
    END LOOP;
END;
/


�Ķ���Ͱ� �ִ� ����� Ŀ��
(Ŀ���� �Ķ���͸� ���� ��)
�μ� ��ȣ�� �Է� �޾� WHERE������ ����ϴ� Ŀ���� ����

DECLARE
    CURSOR deptcursor (p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname
        FROM dept
        WHERE deptno <= p_deptno;
BEGIN
    FOR rec IN deptcursor(30) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || '/' || rec.dname);
    END LOOP;
END;
/


FOR LOOP�� �ζ���(���� ���) Ŀ��
DECLARE ���� Ŀ���� ��������� �������� �ʰ�
FOR LOOP���� SQL�� ���� ���.


DECLARE
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || '/' || rec.dname);
    END LOOP;
END;
/

=> Ŀ���� ������ Ȯ���ϰ� ���� �߿� ���Ѱ� �ϳ� �˾Ƴ���!!!!
=> ������ �ζ����� �������� �������� �� �Ⱦ���, FOR  LOOP ������ ���¸� �Ϲ������� ���̾�


/*
����
FOR ���ڵ� �̸�(�� ������ ����) IN Ŀ���̸� LOOP
    ���ڵ� �̸�.�÷������� �÷� ���� ����
END FOR;



������ �ϸ� ����� Ŀ����
�Ʒ� �ִ� ������ ����� Ŀ��!

DECLARE
    CURSOR deptcursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    FOR rec IN deptcursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || '/' || rec.dname);
    END LOOP;
END;
*/

pro_3
SELECT *
FROM dt;


CREATE TABLE dt2 AS
SELECT 40 n FROM dual UNION ALL
SELECT 35 FROM dual UNION ALL
SELECT 30 FROM dual UNION ALL
SELECT 25 FROM dual UNION ALL
SELECT 20 FROM dual UNION ALL
SELECT 15 FROM dual UNION ALL
SELECT 10 FROM dual UNION ALL
SELECT 5 FROM dual;


DECLARE
    CURSOR dtcursor IS
        SELECT n
        FROM dt2;
BEGIN
    FOR rc IN dtcursor LOOP
        DBMS_OUTPUT.PUT_LINE(rc.n || '-' || rc.n);
    END LOOP;
END;
/


DECLARE
    i NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN i > 5;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i+1;
    END LOOP;
END;
/

		int[] arr = new int[]{40,35,30,25,20,15,10,5};
		int sum =0;
		
		for(int i = 0; i< arr.length-1; i++){
			int diff = arr[i] - arr[i+1];
			sum = sum + diff;
		}
			System.out.println(sum/(arr.length-1));	
	}


SELECT avg(n)
FROM dt2

SELECT count(*)
FROM dt2;

SELECT *
FROM dt2; 


SELECT *
FROM dt b
WHERE b - (SELECT *
            FROM dt2 a
            WHERE a+1) a
            








