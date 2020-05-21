DROP TABLE gis_dt;
CREATE TABLE gis_dt AS
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-12, 18)) dt,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v1,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v2,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v3,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v4,
       '����� ����� ������ Ű��� ���� ���� ������ �Դϴ� ����� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴٺ���� ����� ������ Ű��� ���� ���� ������ �Դϴ�' v5
FROM dual
CONNECT BY LEVEL <= 1000000;

CREATE INDEX idx_n_gis_dt_01 ON gis_dt (dt);


SELECT COUNT(*)
FROM gis_dt;

SELECT dt
FROM gis_dt;

dt�÷��� ����� ������ �ߺ��� �����ؼ� ��ȸ�ϴ�
20200501~20200630 :61

dt�÷����� �����Ͱ� 5/8~6/7�� �ش��ϴ� ����Ʈ Ÿ�� �ڷᰡ ����Ǿ� �ִµ�
5/1~5/31�� �ش��ϴ� ��¥(�����)�� �ߺ����� ��ȸ�ϰ� �ʹ�
���ϴ� ��� : 5/8~5/31 �ִ� 24���� ���� ��ȸ�ϰ� ���� ��Ȳ

SELECT TO_CHAR(dt, 'YYYYMMDD'), count(*)
FROM gis_dt
WHERE dt BETWEEN TO_DATE('20200508','YYYYMMDD') AND TO_DATE('20200531 23:59:59', 'YYYYMMDD HH24:MI:SS')
GROUP BY TO_CHAR(dt, 'YYYYMMDD');

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

1. EXISTS ==>

�츮�� ���ϴ� ���� �ִ� ���� ��� : 24�� ==> 31���� ���� �ִ� ��
SELECT TO_CHAR(d, 'YYYYMMDD')
FROM
(SELECT TO_DATE('20200501', 'YYYYMMDD') + (LEVEL-1) d
FROM dual
CONNECT BY LEVEL <= 31) a
WHERE EXISTS (SELECT 'X'
              FROM gis_dt
              WHERE dt BETWEEN TO_DATE(TO_CHAR(d, 'YYYYMMDD') || '00:00:00', 'YYYYMMDD HH24:MI:SS') AND
                              TO_DATE(TO_CHAR(d, 'YYYYMMDD') || '23:59:59', 'YYYYMMDD HH24:MI:SS'));

ȣ��ȣ
10��, 1~2�� ȸ�簡 PL/SQL �� ��ȣ
PL/SQL==> PL/SQL�� �����ϴ� ���� ����Ŭ ��ü
          �ڵ� ��ü�� ����Ŭ�� ����(����Ŭ ��ü�ϱ�)
          ������ �ٲ� �Ϲ� ���α׷���(java) ���� ������ �ʿ䰡 ����
          
SQL ==> SQL ������ �Ϲݾ��� ���� (java)
        ����, SQL�� ���õ� ������ �ٲ�� java ������ ������ ���ɼ��� ŭ

PL/SQL : Procedual Language / Structured Query Language
SQL : ������, ������ ���� (�̺��ϰ� ����, CASE, DECODE..)

������ �ϴٺ��� � ���ǿ� ���� ��ȸ�ؾ��� ���̺� ��ü�� �ٲ�ų� , ������ ��ŵ�ϴ� ���� 
�������� �κ��� �ʿ��� ���� ����

�������� : �ҵ��� 25% �� �ſ�ī�� + ���ݿ����� + üũī��� �Һ� 
          �Һ�ݾ��� �Һ��� 25%�� �ʰ��ϴ� �ݾ׿� ���ؼ� �ſ�ī��� ���� : 20%, ���ݿ������� 30%, üũī�� 25%�� �����ϴ�
          ��, �����ݾ��� 300������ ������ ����
          ��, ���߱��뿡 ���� �߰������� 100������ �������� �� �ְ�
          ��, ������忡 ���ݿ� ���ؼ��� �߰������� 100������ �������� �� �ִ�.
            
DBMS�󿡼� ���Ͱ��� ������ ������ SQL�� �ۼ��ϴµ��� ������ ����(��������)
�Ϲ����� ���α׷��� ���� ����ϴ� ��������(if, case)�ݺ���(for, while), ���� ���� Ȱ���� �� �ִ�
PL/SQL �� ����

*���� : �򰥸� ����

���� ������
java = 
ps/sql :=

java���� Sysout ==> console�� ���
PL/SQL ���� ����

SET SERVEROUTPUT ON;

PL/SQL bolck�� �⺻����
DECLARE : ����� (���� ���� ����, ��������)
BEGIN : �����(������ �����Ǵ� �κ�)
EXCEPTION : ���ܺ�(���ܰ� �߻����� �� CATCH�Ͽ� �ٸ� ������ �����ϴ� �κ�(java try-catch)

PL/SQL �͸� (�̸��� ����, ��ȸ��) ���

DECLARE
    /*java : ���� TYPE ������
    PL/SQL : �������� TYPE*/
    
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN    
    /*dept���̺��� 10�� �μ��� �ش��ϴ� �μ���ȣ, �μ����� DECLARE ���� ������ �ΰ��� ������ ���*/

    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;

    /*JAVA�� SYSOUT*/
    /*System.out.println(v_deptno + "     " + v_dname);*/
    DBMS_OUTPUT.PUT_LINE(v_deptno || '    ' || v_dname);
END;
/



������ Ÿ�� ����
v_deptno, v_dname �ΰ��� ���� ���� ==> dept���̺��� �÷� ���� �������� ����
                                ==> dept���̺��� �÷� ������ Ÿ�԰� �����ϰ� �����ϰ� ���� ��Ȳ


DECLARE

 
    /*java : ���� TYPE ������
    PL/SQL : �������� TYPE*/
    
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN    
    /*dept���̺��� 10�� �μ��� �ش��ϴ� �μ���ȣ, �μ����� DECLARE ���� ������ �ΰ��� ������ ���*/

    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;

    /*JAVA�� SYSOUT*/
    /*System.out.println(v_deptno + "     " + v_dname);*/
    DBMS_OUTPUT.PUT_LINE(v_deptno || '    ' || v_dname);
END;
/


������ Ÿ���� ���� �������� �ʰ� ���̺��� �÷�Ÿ���� �����ϵ��� ������ �� �ִ�


���̺��.�÷���%TYPE;
==> ���̺� ������ �ٲ� pl/sql ��Ͽ� ����� ������ Ÿ���� �������� �ʾƵ� �ڵ����� ����ȴ�


DECLARE

    v_deptno dept.deptno%type;
    v_dname dept.dname%type;

BEGIN    

    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;

    DBMS_OUTPUT.PUT_LINE(v_deptno || '    ' || v_dname);

END;
/

��¥�� �Է¹޾� ==> �� ȸ���� ������ �������� 5�� ���� ��¥�� �����ϴ� �Լ�
  ȸ�縸�� Ư���� ������ �ʿ��� ��� �Լ��� ���� �� �ִ�
  
PROCEDURE : �̸��� �ִ� PL/SQL ���, ���ϰ��� ����
            ������ ���� ó�� �� �����͸� �ٸ� ���̺� �Է��ϴ� ����
            ����Ͻ� ������ ó�� �� �� ���
            ����Ŭ ��ü ==> ����Ŭ ������ ������ �ȴ�
            ������ �ִ� ������� ���ν��� �̸��� ���� ������ ����
            
CREATE OR REPLACE PROCEDURE printdept (p_deptno IN dept.deptno%TYPE) IS
--�����
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || '    ' || v_dname);
END;
/



���ν��� ������ : EXEC ���ν��� �̸�;
EXEC printdept;


���ڰ� �ִ� printdpet ����
EXEC printdept(10);

PL/SQL������ SELECT ������ �������� �� �����Ͱ� �Ѱ� �ȳ��� ��� NO_DATA_FOUND ���ܸ� ������


CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE) IS
--�����
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT ename, dname INTO v_ename, v_dname
    FROM emp, dept
    WHERE emp.deptno = dept.deptno  
    AND empno = p_empno;

    
    DBMS_OUTPUT.PUT_LINE(v_ename || '    ' || v_dname);
END;
/


EXEC printemp(7369);


SELECT *
FROM dept_test




INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon') ;
ROLLBACK;

CREATE OR REPLACE PROCEDURE register_test (p_deptno IN dept.deptno%TYPE, 
                                           p_dname IN dept.dname%TYPE,
                                           p_loc IN dept.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc);
    COMMIT;
END;
/



EXEC register_test (99, 'ddit', 'daejeon');

SELECT*
FROM dept_test;



CREATE OR REPLACE PROCEDURE UPDATEdept_test (p_deptno IN dept.deptno%TYPE, 
                                           p_dname IN dept.dname%TYPE,
                                           p_loc IN dept.loc%TYPE) IS
BEGIN
    INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc);
    COMMIT;
END;
/

EXEC register_test (99, 'ddit_m', 'daejeon');

SELECT*
FROM dept_test;


���� ����
��ȸ����� �÷��� �ϳ��� ������ ��� �۾� ���ŷӴ� ==> ���� ���� ����Ͽ� �������� �ؼ�

0. %TYPE : �÷�
1. %ROWTYPE : Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ���� ���� Ÿ��
    (���� %TYPE - Ư�� ���̺��� �÷� Ÿ���� ����)
2. PL/SQL RECORD : ���� �����Ҽ� �ִ� Ÿ��, �÷��� �����ڰ� ���� ���
                    ���̺��� ��� �÷��� ����ϴ°� �ƴ϶� �÷� �� �Ϻθ� ����ϰ� ���� ��
3. PL/SQL TABLE TYPE : �������� ��, �÷��� ������ �� �ִ� Ÿ��

%ROWTYPE
�͸���� dept ���̺��� 10�� �μ������� ��ȸ�Ͽ� %ROWTYPE���� ������ ������
������� �����ϰ� DBMS_OUTPUT.PUT_LINE�� �̿��Ͽ� ���

DECLARE 
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || '/'||v_dept_row.dname || '/' || v_dept_row.loc);
END;
/


2. record : ���� ������ �� �ִ� ����Ÿ��, �÷� ������ �����ڰ� ���� ������ �� �ִ�
dept���̺��� dpetno, dname �ΰ� �÷��� ������� �����ϰ� ������

SELECT deptno, dname
FROM dept
WHERE deptno = 10;

DECLARE
    /*deptno, dname �÷� �ΰ��� ���� ������ �� �ִ� TYPE�� ����*/
    TYPE dept_rec IS RECORD(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE);
    
    /*���Ӱ� ���� Ÿ������ ������ ���� (class ����� �ν��Ͻ� ����)*/
    
    v_dept_rec dept_rec;
BEGIN
    SELECT deptno, dname INTO v_dept_rec
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_rec.deptno || '/' || v_dept_rec.dname);
END;
/

�������� ������ �� ��
SELECT ����� �������̱� ������ �ϳ��� �� ������ ���� �� �ִ� ROWTYPE 

TABLE TYPE : ���� ���� ���� �� �� �ִ� Ÿ��
���� : TYPE Ÿ�Ը� IS TABLE OF �� Ÿ�� INDEX BY �ε����� Ÿ��;

dept���̺��� �� ������ ������ �� �ִ� ���̺� type
    List<Dept> dept_tab = new ArrayList<Dept>();
    
    java ���� �迭 �ε���
    int[] intArray = new int[50];
    intArray[0];
    java������ �ε����� �翬�� ����
    
    intArray["ù��°"] = 50;
    System.out.println(intArray["ù��°"]);
    
    Map<String, Dept> deptMap = new HashMap<String, Dept>();
    deptMap.put("ù��°", new 
    
    PL/SQL������ �ΰ��� Ÿ���� ���� : ����(BINARY_INTEGER), ���ڿ�(VARCHAR(2))
    
    TYPE dept_table IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER




dept���̺��� �� ������ ������ �� �ִ� ���̺� type

DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;

BEGIN
    SELECT * BULK COLLECT INTO v_dept
    FROM dept;
END;










    








