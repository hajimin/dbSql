���������� ���� ��ġ�� ���� �з�
SELECT ��Į������
FROM �ζ��κ�
WHERE ��������

��������
1.PRIMARY
2.UNIQUE
3.FOREIGN KEY
4.CHECK
  - NOT NULL
5. NOT NULL
  - CHECK ���� ���������� ���� ����ϱ� ������ ������ KEWORD�� ����
  
NOT NULL ��������
:�÷��� ���� NULL�� ������ ��

DROP TABLE dept_test;

CREATE TABLE dept_test(
		deptno NUMBER(2,0),
		dname VARCHAR(14) NOT NULL,
		loc VARCHAR(13)
);

dname �÷��� ������ NOT NULL �������ǿ� ���� �Ʒ�  INSERT ������ �����Ѵ�.
INSERT INTO dept_test VALUES (99, NULL, 'daejeon');

<���� ����>
���ڿ��� ��� ''�� NULL �� �ν��Ѵ�
�Ʒ��� INSERT ������ ����
INSERT INTO dept_test VALUES (99, '', 'daejeon');

UNIQUE ����
�ش� �÷��� ������ ���� �ߺ����� �ʵ��� ����
���̺��� ��� �� �� �ش� �÷��� ���� �ߺ����� �ʰ� �����ؾ���
EX : �������̺��� ��� �÷�, �л����̺��� �й� �÷�

DROP TABLE dept_test;

CREATE TABLE dept_test(
		deptno NUMBER(2,0),
		dname VARCHAR(14) UNIQUE,
		loc VARCHAR(13)
);

dept_test ���̺��� dname�÷��� UNIQUE ������ �ֱ� ������ ������ ���� �� �� ����.
INSERT INTO dept_test VALUES (99, 'ddit','daejeon');

INSERT INTO dept_test VALUES (98, 'ddit','����');


���� �÷��� ���� UNIQUE ���� ����

DROP TABLE dept_test;


CREATE TABLE dept_test(
		deptno NUMBER(2,0),
		dname VARCHAR(14),
		loc VARCHAR(13),

        CONSTRAINT u_dept_test UNIQUE (dname, loc)
);

dname �÷��� loc�÷��� ���ÿ� ������ ���̾�߸� �ߺ����� �ν�
�ؿ� �ΰ��� ������ ������ �ߺ��� �ƴϹǷ� �������
INSERT INTO dept_test VALUES (99, 'ddit','daejeon');

INSERT INTO dept_test VALUES (98, 'ddit','����');

�Ʒ������� UNIQUE ���� ���ǿ� ���� ����
INSERT INTO dept_test VALUES (98, 'ddit','����');

SELECT *
FROM dept_test;

FOREIGN KEY ��������
�Է��ϰ����ϴ� �����Ͱ� �����ϴ� ���̺��� ������ ���� �Է� ���
EX : emp ���̺��� �����͸� �Է��� �� deptno �÷��� ���� dept ���̺��� �����ϴ� deptno ��
     �̾�� �Է� ����

������ �Է½� (emp)�����ϴ� ���̺� (dept)�� ������ ���� ������ ������ �˱� ���ؼ�
�����ϴ� ���̺�(dept)�� �÷�(deprno)�� �ε����� �ݵ�� �����Ǿ� �־������
FOREIGN KEY ���������� �߰��� �� �ִ�.

UNIQUE ���������� ������ ��� �ش� �÷��� �� �ߺ�üũ�� ������ �ϱ� ���ؼ�
����Ŭ������ �ش��÷��� �ε����� ���� ��� �ڵ����� �����Ѵ�.

PRIMARY KEY �������� : UNIQUE ���� + NOT NULL
PRIMARY KEY �������Ǹ� �����ص� �ش��÷����� �ε����� �������ش�

FOREIGN KEY ���������� �����ϴ� ���̺��� �ֱ� ������ �ΰ��� ���̺��� �����Ѵ�.

DROP TABLE dept_test;

CREATE TABLE dept_test(
		deptno NUMBER(2,0) PRIMARY KEY,
		dname VARCHAR(14),
		loc VARCHAR(13)
);
INSERT INTO dept_test VALUES (99, 'ddit','daejeon');
COMMIT;


CREATE TABLE emp_test(
		emptno NUMBER(4,0) PRIMARY KEY,
		ename VARCHAR2(10),
		deptno NUMBER(2,0)REFERENCES dept_test (deptno)
);

���� �μ����̺����� 99�� �μ��� ����
FOREIGN KEY �������ǿ� ���� emp ���̺��� deptno �÷����� 99�� �̿��� �μ���ȣ�� �Էµ� �� ����.

99�� �μ��� �����ϹǷ� ���������� �Է� ����
INSERT INTO emp_test VALUES (9999, 'brown',99);

98�� �μ��� ������ �����Ƿ� ���������� �Է��� �� ����
INSERT INTO emp_test VALUES (9998, 'sally',98);
 
FOREIGN KEY �������� ���̺� �������� ���
DROP TABLE emp_test;

CREATE TABLE emp_test(
		emptno NUMBER(4,0) PRIMARY KEY,
		ename VARCHAR2(10),
		deptno NUMBER(2,0),
        
        --CONSTRAINT �������� �� �������� type �÷� REFERENCES �����ϴ� ���̺�(�÷�)
        CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno)
);

ROLLBACk;

�ܷ�Ű�� ������ ����
SELECT *
FROM dept_test;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (9999,'brown',99);

COMMIT;

emp.deptno ==> dept.deptno ������
(9999,'brown',99) ===>(99,'ddit','daejeon') 

dept_test ���̺��� 99�� �μ��� �����͸� ����� ��� �ɱ�?
(9999,'brown',99)===>

�θ� ���ڵ带 (dept_test.deptno)�� ������� �ִ� �ڽ� ���ڵ� (emp_test.deptno)��
�����ϱ� ������ �ڽ� ���ڵ� ���忡���� ������ ���Ἲ�� ������ �Ǿ�
���������� ������ �� ����.
DELETE dept_test
WHERE deptno=99;

����Ű�� ���õ� �����͸� ������ �ο��� �� �ִ� �ɼ�

�θ����͸� ������..
FOREIGN KEY �ɼǿ� ���� �ڽ� �����͸� ó�� �� �� �ִ� �ɼ�
1. default ==> �����ϰ� �ִ� �θ� ������ �� ����
2. ON DELETE CASCADE ==> �θ� �����Ǹ� �����ϰ� �ִ� �ڽ� �����͵� ���� ����
3. ON DELETE SET NULL ==> �θ� �����Ǹ� �����ϰ� �ִ� �ڽ� �����͸� NULL�� ����

�ְ����� �ǰ� : default
1. �����ڰ� ���̺��� ������ ��Ȯ�ϰ� �˰� �־������ ���������� �� ����
    ==> ����ų�, �Է��� �������� ������ �˰� �־����
2. ���̺� �������� ��Ȯ���� ������ �ű� �����ڴ� �ش� ������ �� ���� ����
    (java �ڵ� + ���̺� ���� Ȯ�� �ʿ�)
    java �ڵ忡�� dept���̺��� �����ϴ� �ڵ尡 �ִµ� 
    �ű��ϰԵ� emp���̺��� �����Ͱ� �����ǰų� null�� �����Ǵ� ��츦 �� �� ����

CHECK ��������
�÷��� ���� �����ϴ� ���� ����

emp ���̺����� �޿� ����(sal)�� ������ �� sal�÷��� ���� 0���� ���� ���� ���� ���� ���������� �̻���.
sal �÷��� ���� ������ ���� �ʵ��� üũ ���� ������ �̿��Ͽ� ���� �� �� �ִ�.

DROP TABLE emp_test;

CREATE TABLE emp_test(
		emptno NUMBER(4,0) PRIMARY KEY,
		ename VARCHAR2(10),
        sal NUMBER(7,2) CHECK (sal > 0),
		deptno NUMBER(2,0) REFERENCES dept_test (deptno)
);
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO emp_test VALUES (9999,'brown',1000,99);

sal �÷��� ������ check ����(sal > 0)�� ���� ���������� ������� �ʴ´�
INSERT INTO emp_test VALUES (9998,'sally',-1000,99);



���̺� ���� sal üũ �������� ��� �� �׽�Ʈ

DROP TABLE emp_test;

CREATE TABLE emp_test(
		emptno NUMBER(4,0) PRIMARY KEY,
		ename VARCHAR2(10), 
        sal NUMBER(7,2),
        deptno NUMBER(2,0)  REFERENCES dept_test (deptno), 
        
        CONSTRAINT check_sal CHECK (sal > 0) 
);

INSERT INTO dept_test VALUES (99,'ddit','daejeon');

INSERT INTO emp_test VALUES (9999,'brown',1000,99);
INSERT INTO emp_test VALUES (9998,'sally',-1000,99);

CTAS : Create Table AS
SELECT ����� �̿��Ͽ� ���̺��� �����ϴ� ����
NOT NULL ���������� ������ �ٸ� ���� ������ ������� �ʴ´�
�뵵
1.������ ������ ���
2.������ ������ �׽�Ʈ

����
CREATE TABLE ���̺��� [(�÷���1,,,,,)] AS
    SELECT ����;

dept_test ���̺��� ���� ==> dept_test_copy
CREATE TABLE dept_test_copy AS
SELECT *
FROM dept_test;


������ ���� ���̺��� �����ϰ� ���� �� 
CREATE TABLE dept_test_copy2 AS
SELECT *
FROM dept_test
WHERE 1 != 1;

SELECT *
FROM dept_test_copy;

SELECT *
FROM dept_test_copy2;


JAVA JDBC (Java Database Connection)
String sql = "������ sql"

���� �˻� ����� ����
�䱸���� : ��ü �˻�,���� �̸����� �˻�, �޿��˻�;

�����̸� �˻�
SELECT *
FROM emp
WHERE ename LIKE '%' || �˻� Ű���� || '%';

��ü �˻�
SELECt *
FROM emp;

�޿��˻�
SELECt *
FROM emp
WHERE sal > �˻���;


String sql = "SELECT * ";
       sql += "FROM emp";
       sql += "WHERE 1=1";
       
if(����ڰ� �޿��˻� ��û�ߴٸ�){
    sql += " AND sal > " + ����ڰ� �Է��� �˻���;
}
if(����ڰ� ���� �̸� �˻��� ��û�ߴٸ�){
    sql += " AND ename LIKE '%' || " + ����ڰ� �Է��� �˻��� + "'%'";
}

String sql  = "SELECT * ";
       sql += "FROM emp";
       sql += "WHERE 1=1";
       sql += " AND sal > " + ����ڰ� �Է��� �˻���;
       sql += " AND ename LIKE '%' || " + ����ڰ� �Է��� �˻��� + "'%'";
       
TABLE ����
���ݱ��� ������ TABLE ������ ����
�̹� ������ ���̺��� ���� �� ���� ����
    1. ���ο� �÷��� �߰�
        ****** ���ο� �÷��� ���̺��� ������ �÷����� �߰��� �ȴ�.
        ****** ���� �����Ǿ� �ִ� �÷� �߰����� ���ο� �÷��� �߰��� ���� ����
        ==> ���� ���̺��� �����ϰ� �÷������� ������ ���ο� ���̺� ���� DDL�� ���Ӱ� ���̺��� ��������.
            ����̶�� �̹� �����Ͱ� �׿����� ���ɼ��� ������ ����
            ==> ���̺��� ������ �� �����ϰ� �÷� ������ ����

    2. ���� �÷� ����, �÷� �̸� ����, �÷� ������ ����,(Ÿ�Ե� ���������� ���氡��)
        ����Ű�� �ɷ��ִ� ���̺��� �÷��̸��� �����ϴ��� �����ϴ� ���̺����� ������ ���� ����
        (�˾Ƽ� �̸��� �������ش�)
        emp_test.deptno = dept_test.deptno����
        dept_test,deptno �̸� �����Ͽ� dept_test.dno�� �����ϴ��� fk�� ����� �̸����� �� ������ �ȴ�

    3. ���� ���� �߰�
    

���� ���̺��� ���ο� �÷� �߰�
ALTER TABLE ���̺��� ADD (�÷��� �÷�Ÿ��);

DROP TABLE emp_test;

CREATE TABLE emp_test(
		emptno NUMBER(4,0) PRIMARY KEY,
		ename VARCHAR2(10),
		deptno NUMBER(2,0)REFERENCES dept_test (deptno)
);

SELECT *
FROM emp_test;


DESC emp_test;

emp_test ���̺��� hp �÷�(VARCHAR2(20))�� �űԷ� �߰�

ALTER TABLE ���̺��� ADD (�÷��� �÷�Ÿ��);

ALTER TABLE emp_test ADD (hp VARCHAR2(20));


�÷� ������ ����, Ÿ�Ժ���
ALTER TABLE ���̺��� MODIFY (�÷��� �÷�Ÿ��);

������ �߰��� hp �÷��� �÷� ����� 20���� 30���� ����

ALTER TABLE emp_test MODIFY (hp VARCHAR2(30)); 

�÷� Ÿ�� ����

������ �߰��� hp�÷��� Ÿ���� VARCHAR2(30)���� DATE�� ����
ALTER TABLE emp_test MODIFY (hp DATE); 


�����Ͱ� �����ϴ� �÷��� ���ؼ��� Ÿ�� ������ �Ұ��� �ϴ�
INSERT INTO emp_test VALUES (9999,'brown',99,sysdate);
ALTER TABLE emp_test MODIFY (hp VARCHAR2(30));

�÷� �̸� ����
ALTER TABLE ���̺��� RENAME COLUMN �����÷��� TO �ű��÷���;

������ �߰��� emp_test ���̺��� hp �÷��� hp_n���� �̸� ����
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

SELECT *
FROM emp_test;

�÷� ����
1. ALTER TABLE ���̺��� DROP (������ �÷���);
2. ALTER TABLE ���̺��� DROP COLUMN (������ �÷���);

������ �߰��� emp_test ���̺��� hp_n�÷��� ����;
ALTER TABLE emp_test DROP (hp_n);



SQL ���� 
DML : SELECt, INSERT, UPDATE, DELETE ==> Ʈ����� ���� ���� (��� ����)
DDL : CREATE...., ALTER.... ==> Ʈ����� ��� �Ұ��� (��Ұ� �ȵȴ�)/�ڵ� Ŀ��

ROLLBACK;

���� ename�� brown ==> sally�� ����
UPDATE emp_test SET ename='sally'
WHERE emptno=9999;

ALTER TABLE emp_test ADD (hp NUMBER);

DESC emp_test;

DDL�� �ڵ� Ŀ���̱� ������ DML ���忡�� ������ �޴´�
DDL�� ������ ��� �������� ������ �ߴ� �۾��� ���캼 �ʿ䰡 �ִ�
SQL ���迡�� �� ������ ����



