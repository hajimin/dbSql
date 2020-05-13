CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1=1;

�ǽ� 1
CREATE UNIQUE INDEX idx_dept_test2_01 ON dept_test2 (deptno);
CREATE INDEX idx_dept_test2_02 ON dept_test2 (dname);
CREATE INDEX idx_dept_test2_03 ON dept_test2 (deptno,dname);


�ǽ� 2
DROP INDEX idx_dept_test2_01 ON dept_test2 (deptno);
DROP INDEX idx_dept_test2_02 ON dept_test2 (dname);
DROP INDEX idx_dept_test2_03 ON dept_test2 (deptno,dname);

�ǽ� 3

�ǽ� 4 ����

�����ȹ

�����ð��� ��� ����
==> ������ ���� ���¸� �̾߱���, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���α��
null = '7698'
outer join : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ� ���ᰡ���� ��� ����� ���� ���εǴ� ���� ���
self join : ���� ���̺��� �����ϴ� ����

�����ڰ� DBMS�� SQL�� �����û�ϸ� DBMS�� sql�� �м��ؼ�
��� �� ���̺� ���������� ����, 3���� ����� ���ι��(������ ���ι��, ������� �̾߱�)
1. Nested Loop Join : �ҷ��� �����͸� �����ϴ� ���(���� ���伺), �ּ����� �Ǽ��� ��ȸ�Ǹ� ����..?
2. Sort Merge Join : �뷮�� �����͸� �����ϴ°��, �����÷��� �ε����� ���� ���
                    : ������ �Ǿ� �����Ƿ� �������ǿ� �ش��ϴ� �����͸� ã�� ���� 
                    : ������ ������ ������ �����ϹǷ� ����ӵ��� ���� , =�� �ƴϾ ��밡��
                    : 
3. Hash Join : �����÷��� �ε����� ���� ���
             : ���� �÷��� ���� hash�Լ��� �̿��� ����
             : ���� ���̺��� �Ǽ��� ������ ���� ������ ���� ��� 
             : �ݵ�� ���������� =�� ���
             : Hash ���� ���� �����ͳ���
             : Nested �Լ� ������ �ذ�,, single IO ������ ����
             
             hash �Լ�Ư¡
             - �浹�� �ȳ��� ������ ������ �ٲ��� 
             - �Է°��� ���̿� ������� ���� ���� ������ȯ
             - � ���̵� ������ ���·� ó���ϴ� ���� ��������
             - ��������� �Է°� ���� �Ұ� (��ȣ �˰������ε� ���)
             - �Է°��� �Ϻθ� ����ǵ� ������
             
             
             
             
OLTP (Online Transaction Processing) : �ǽð� ó�� ==> ������ ����� �ϴ� �ý���(�Ϲ����� ������)
OLAP (Online Analysis Processing) : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿��� ���(���� ���ڰ��, ���� �ѹ��� ���)

index�� Ȱ������ ���ϴ� ���
1. �÷��� ����
SELECT *
FROM emp
WHERE NVL(comm, 0)>0;
--nvl���� �ε����� �����ϱ� �� ���� �ֱ� ������, ������� ����

 ����
SELECT *
FROM emp
WHERE comm>0;

2. ������ ����
SELECT *
FROM emp
WHERE job != 'SALESMAN';

3. NULL ��
NULL ���� �ε����� ���� ����

SELECT *
FROM emp
WHERE ename IS NOT NULL;

����
SELECT *
FROM emp
WHERE ename > ' ';

4. LIKE ����� ���� ���ϵ� ī��
SELECT *
FROM emp
WHERE ename LIKE '%T';

INDEX UNIQUE SCAN : �ߺ��� ������ �ʴ� unique�ε����� �̿��Ͽ� ã�����ϴ� �����͸� ��ȸ
INDEX RANGE SCAN : �ε����� �Ϻα����� ��ȸ(��������/��������)
INDEX FULL SCAN : �ε��� ��ü��ȸ(��������/��������)
INDEX FAST SCAN : �ε��� ��ü�� multiblock l/O�� ��ȸ 
INDEX ? SCAN : �����÷��� �־����� �ʰ� �����÷��� ��ȸ

���̺� 3��
TABLE ACCESS FULL

���� 3��

���� 
SORT AGGREGATE (union)�׷��Լ� �������� �����۾�
SORT UNIQUE �ߺ��� ���� 
SORT GROUP BY
SORT ORDER BY
SORT JOIN

predicate 
