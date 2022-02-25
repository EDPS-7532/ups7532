-- ESCAPE
SELECT * FROM employees WHERE job_id like '%\_A%' escape '\';
SELECT * FROM employees WHERE job_id like '%#_A%' escape '#';

--IN : or ��ſ� ����Ѵ�
SELECT * FROM employees WHERE manager_id = 101 or manager_id = 102 or manager_id=103;
SELECT * FROM employees WHERE manager_id in (101,102,103);

--BETWEEN AND : AND ��ſ� ���(����)
SELECT* FROM employees WHERE manager_id BETWEEN 101 AND 103;

--IS NULL/ IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--[�ֿ� �Լ�]
--MOD �Լ� : �������� �� �������� ���ϴ� �Լ�
SELECT * FROM employees WHERE MOD(employee_id,2)=1;
SELECT MOD(10,3) FROM dual;

--ROUND() : �Ҽ������� �ݿø� �Լ�
SELECT ROUND(355.95555) FROM dual;
SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

--TRUNC() : ������ �ڸ��� ���ϸ� ����
SELECT TRUNC(45.5555,1) FROM dual;
SELECT last_name, TRUNC(salary/12,2) FROM employees;

--��¥ ���� �Լ�
SELECT SYSDATE FROM dual;
SELECT SYSDATE + 1 FROM dual;
SELECT last_name, TRUNC((SYSDATE - hire_date)/365) �ټӿ��� FROM employees;
SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6) FROM employees;
SELECT LAST_DAY(sysdate) - sysdate FROM dual;
SELECT hire_date, NEXT_DAY(hire_date,'��') FROM employees;
SELECT sysdate, NEXT_DAY(sysdate, '��') FROM dual;

--������
--MONTHS_BETWEEN()
SELECT last_name,sysdate,hire_date, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) FROM employees;

--����ȯ �Լ�
--NUMBER CHARACTER DATE
--TO DATE() ���ڿ��� ��¥��
--to_number, to_character, to_date
SELECT last_name, months_between('12/12/31',hire_date) FROM employees;
SELECT trunc(sysdate - to_date('2014/01/01')) FROM dual;

-- Q. employees ���̺� �ִ� ������(���, �̸���������)�� ���Ͽ� ����������� �ټӿ����� ���ϼ���.
SELECT employee_id,last_name, TRUNC((SYSDATE - hire_date)/365) �ټӿ��� FROM employees;

SELECT TO_DATE('20210101'),
TO_CHAR((TO_DATE('20210101'),' MonthDD YYYY','NLS_DATE_LANGUAGE=ENGLISH') format1 FROM dual;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh24:mi:ss') From dual;
SELECT TO_CHAR(SYSDATE, 'DAY') FROM dual;

SELECT salary, TO_CHAR(salary,'09999') FROM employees;

--TO_CHAR
--9 ���ڸ��� ����ǥ��
--0 �պκ��� 0���� ǥ��
--$ �޷���ȣ�� �տ� ǥ��
--. �Ҽ����� ǥ��
--, Ư�� ��ġ�� ǥ��
--MI �����ʿ� ?��ȣ ǥ��
--PR �������� <>���� ǥ��
--eeee������ǥ��
--�� ������ȭ
SELECT salary, TO_CHAR(salary,'09999') FROM employees;
SELECT TO_CHAR(-salary,'99999PR') from employees;
SELECT TO_CHAR(1111, '99.99EEEE') FROM DUAL;
SELECT TO_CHAR(1111, 'B9999.99') FROM DUAL;
SELECT TO_CHAR(1111, 'L9999') FROM DUAL;

--WIDTH_BUCKET() ������, �ּҰ�, �ִ밪, BUCKET����
SELECT WIDTH_BUCKET(92,0,100,10) FROM DUAL;
SELECT department_id, last_name, salary, width_bucket(salary,0,20000,5) from employees where department_id=50;

--[����] employees ���̺��� employee_id, last_name, salary, hire_date �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰����� ����ϼ���.
--2001�� 1�� 1�Ͽ� â���Ͽ� ���� (2020�� 12�� 31��)���� 20�Ⱓ ��Ǿ�� ȸ��� ������ �ټӿ����� ���� 30������� ������ ��޿� ���� 1000���� bonus�� ����
--(bonus ���� �������� ����)
SELECT employee_id, last_name, salary, hire_date,
TRUNC(((to_date('20201231') - hire_date)/365))�ټӿ���,
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30)) ���ʽ����,
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30))*1000 bonus
FROM employees
ORDER BY bonus DESC;

--�����Լ�
SELECT UPPER('Hello World')FROM dual;
SELECT LOWER('HELLO WORLD') FROM dual;
SELECT last_name, salary from employees where lower(last_name)='seo';

SELECT INITCAP(job_id) FROM employees;
--���ڿ��� ����
select job_id, length(job_id) from employees;
--���ڿ��� ���°����?(hello world���� o��� ���ڰ� ã�� ��ġ(3)>> ������ġ, ���° ���ΰ�(2)?
select instr('hello world','o',3,2) from dual;
--substr(������ġ���� ���°�ΰ� ex 3,3>>3��°���� 3���� ��Ÿ����)
select substr('hello world',3,3) from dual;
-- -3�� �ڿ������� 3ĭ 
select substr('hello world',-3,3) from dual;
--��ü �ڸ����� 20���� ��� ������ �κ��� #���� ä���ش�(������)
SELECT LPAD('hello world',20,'#') from dual;
--��ü �ڸ����� 20���� ��� ������ �κ��� #���� ä���ش�(����)
SELECT RPAD('hello world',20,'#') from dual;
-- Ư�� ���ڸ� ����(���ʺκи�)
select LTRIM('aaahello worldaaa','a') from dual;
-- Ư�� ���ڸ� ����(�����ʺκи�)
select RTRIM('aaahello worldaaa','a') from dual;

select LTRIM('    hello world    ',' ') from dual;
select RTRIM('    hello world    ',' ') from dual;
select TRIM('    hello world    ',' ') from dual;

--��Ÿ�Լ�  nvl = nul�� 0�Ǵ� 1�� ��ȯ
SELECT salary,commission_pct,  salary*12 *nvl(commission_pct,0) FROM employees;
-- �����͸� �޾��ٶ� ������
select last_name, department_id,
case when department_id=90 then '�濵������'
WHEN department_id = 60 THEN '���α׷���'
WHEN department_id=100 THEN '�λ��'
END AS �Ҽ�
FROM employees;

-- �м��Լ� : ���� ���� ������ ������ ���� ����� return �� �� ������ ó�� ����� �Ǵ� ���� ������ window��� ��Ī
-- FIRST_VALUE() OVER() �׷��� ù��° ���� ���Ѵ�.
SELECT first_name �̸�, salary ����,
FIRST_VALUE(salary) over(order by salary desc rows 3 preceding) �ְ���
FROM employees;

-- 3�� ���� �������� ��������
SELECT first_name �̸�, salary ����,
FIRST_VALUE(salary) over(order by salary rows 3 preceding) ��������
FROM employees;

SELECT first_name �̸�, salary ����,
LAST_VALUE(salary) over(order by salary desc rows 3 preceding) 
FROM employees;

-- ���Ʒ� ���� 2�ٱ��� �� ��������
SELECT first_name �̸�, salary ����,
LAST_VALUE(salary) over(order by salary DESC ROWS BETWEEN 2 preceding and 2 following) ��������
FROM employees;


-- [����] employees ���̺��� department_id =50�� ������ ������ ������������ �����Ͽ� ����ī��Ʈ�� ����ϼ���.
SELECT employees, department_id, salary
count(*) over(order by salary desc)����ī��Ʈ from employees where department_id=50;
-- [����] employees ���̺��� department_id�� �������� �������� �����ϰ� ������ ���� ���� �հ踦 ����ϼ���.
SELECT  department_id,last_name, salary, sum(salary) over(partition by department_id order by department_id asc)
from employees;



-- [����] employees ���̺��� department_id(�μ�) �� ���� ���������� ����ϼ���.
select first_name, department_id �μ�, salary ����
rank() over(partition by department_id order by salary desc) �μ� ��������
from employees;









--dml 

DESC BOOK;
-- BOOK�� ������ ���� ����
SELECT*FROM BOOK;
-- BOOK���� BOOKNAME�� PRICE�� ����
SELECT BOOKNAME,PRICE FROM BOOK;
--PUBLISHER�� ����
SELECT PUBLISHER FROM BOOK;
--PUBLISHER���� �ߺ��� ����
SELECT DISTINCT PUBLISHER FROM BOOK;
-- �Ҹ� �ε���(Ư�� ������ �����ϴ� ���)
SELECT*
FROM BOOK
WHERE PRICE < 10000;

-- Q. ������ 10000�� �̻� 20000�� ������ ������ �˻��ϼ���.
SELECT*
FROM BOOK
WHERE PRICE >= 10000 AND PRICE <= 20000;

--Q. ���ǻ簡 �½�����,Ȥ�� ���ѹ̵���� ������ �˻��ϼ���.
SELECT* FROM BOOK WHERE PUBLISHER = '�½�����' OR PUBLISHER = '���ѹ̵��';
SELECT* FROM BOOK WHERE PUBLISHER IN ('�½�����','���ѹ̵��');
--Q. ���ǻ簡 �½�����,Ȥ�� ���ѹ̵� �ƴ� ������ �˻��ϼ���
SELECT* FROM BOOK WHERE PUBLISHER NOT IN ('�½�����','���ѹ̵��');

--Q. �����̸��� �౸�� ���Ե� ���ǻ縦 �˻��ϼ���.
SELECT PUBLISHER FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';

--[����] ���� �̸��� ���� �ι�° ��ġ�� �� ��� ���ڿ��� ���� ������ �˻��ϼ���.
SELECT* FROM BOOK WHERE BOOKNAME LIKE '%_��%';

--[����] �౸�� ���� ������ ������ 20,000�� �̻��� ������ �˻��ϼ���.
SELECT* FROM BOOK WHERE BOOKNAME LIKE '%�౸%' AND PRICE>=20000;

--����(BOOKNAME�� ��������)

SELECT* 
FROM BOOK
ORDER BY BOOKNAME;

-- ��������
SELECT*
FROM BOOK
ORDER BY BOOKNAME DESC;

--Q. ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻��ϼ���.
SELECT*
FROM BOOK
ORDER BY PRICE,BOOKNAME;

--Q. ������ ������ ������������ �˻��ϰ� ���� ������ ���ٸ� ���ǻ��� ������������ ����ϼ���.(publisher�� default����)
SELECT*
FROM BOOK
ORDER BY PRICE DESC,PUBLISHER;

-- SALEPRICE�� �հ踦 ����ϱ�
select* from orders;
select sum(saleprice)
from orders;

-- �̸��� �Ѹ���� ���� >> AS�� �����
SELECT SUM(SALEPRICE) AS "�Ѹ���" 
FROM ORDERS;

-- Q.CUSTID�� 2���� ���� �ֹ��� ������ �� �Ǹž��� ���ϼ���
SELECT SUM(SALEPRICE) AS "�� �Ǹž�" FROM ORDERS WHERE CUSTID=2;

-- Q.SUM,AVG,MIN,MAX�� ����ϼ���
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE,
MAX(SALEPRICE) AS MAXIMUM,
MIN(SALEPRICE) AS MINIMUN
FROM ORDERS;

--COUNT
SELECT COUNT(*) FROM ORDERS;

--Q. CUSTID�� ���� ������ �� �Ǹž��� ���ϼ���
SELECT CUSTID, COUNT(*) AS ��������, SUM(SALEPRICE) AS "���Ǹž�"
FROM ORDERS GROUP BY CUSTID;

--Q. ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���ϼ��� ��, �ι� �̻� ������ ���� ������.
SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE >=8000
GROUP BY CUSTID
HAVING COUNT(*) >=2;

SELECT* FROM CUSTOMER;

-- �ΰ��� ���� ��ġ��
SELECT*
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID

-- ���� �����͸� �����ϱ�
SELECT*
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

-- �������� ����
SELECT*
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID.DESC;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ �����ϼ���
SELECT NAME,SUM(SALEPRICE)
FROM CUSTOMER,ORDERS
WHERE CUSTOMER.CUSTID=ORDERS.CUSTID
GROUP BY CUSTOMER.NAME
ORDER BY CUSTOMER.NAME;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���
SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM CUSTOMER, ORDERS,BOOK
WHERE CUSTOMER.CUSTID=ORDERS.CUSTID AND ORDERS.BOOKID=BOOK.BOOKID;

SELECT C.NAME, B.BOOKNAME
FROM CUSTOMER C, ORDERS O ,BOOK B
WHERE C.CUSTID=O.CUSTID AND O.BOOKID=B.BOOKID;

--[����] ������ 20,000�� ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE
FROM CUSTOMER C , ORDERS O, BOOK B
WHERE C.CUSTID=O.CUSTID AND O.BOOKID=B.BOOKID AND B.PRICE=20000;

--[����] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
-- OUTER JOIN : ���� ������ �������� ���ϴ��� �ش� ���� ��Ÿ��
SELECT CUSTOMER.NAME, SALEPRICE
FROM CUSTOMER LEFT OUTER JOIN ORDERS ON CUSTOMER.CUSTID=ORDERS.CUSTID;

--[����] ���� ��� ������ �̸��� ����ϼ���.
SELECT BOOKNAME
FROM BOOK
WHERE PRICE=(SELECT MAX(PRICE) FROM BOOK);

--[����] ������ ������ ���� �ִ� ���� �̸��� �˻��ϼ���.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
--[����] ���ѹ̵��� ������ ������ ������ ���� �̸��� ����ϼ���.
SELECT NAME FROM CUSTOMER WHERE CUSTID IN
(SELECT CUSTID FROM ORDERS WHERE BOOKID IN
(SELECT BOOKID FROM BOOK WHERE PUBLISHER='���ѹ̵��'));
--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT B1.BOOKNAME 
FROM BOOK b1 
WHERE B1.PRICE > (SELECT AVG(B2.PRICE) 
FROM BOOK B2 WHERE B2.PUBLISHER=B1.PUBLISHER)
--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT NAME 
FROM CUSTOMER 
MINUS 
SELECT NAME 
FROM CUSTOMER 
WHERE CUSTID IN(SELECT CUSTID FROM ORDERS);
--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT NAME,ADDRESS 
FROM CUSTOMER CS 
WHERE EXISTS (SELECT* FROM ORDERS OD WHERE CS.CUSTID=OD.CUSTID);

SELECT NAME, ADDRESS
FROM CUSTOMER
WHERE CUSTID IN(SELECT CUSTID FROM ORDERS);
--Q. CUSTOMER ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����ϼ���.
UPDATE CUSTOMER
SET ADDRESS ='���ѹα� �λ�'
WHERE CUSTID =5;
--���
SELECT*FROM CUSTOMER;
-- �������̸� ��ҹ��ڸ� �����Ѵ�.

--Q. CUSTOMER ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����ϼ���.
UPDATE customer
SET address = (SELECT address FROM customer
WHERE name = '�迬��')
WHERE name = '�ڼ���';

--Q. CUSTOMER ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
DELETE CUSTOMER
WHERE CUSTID=5;

SELECT ABS(-78),ABS(+78) FROM DUAL;
--Q. 4.875 �Ҽ��� ó������ �ݿø��ϼ���
SELECT ROUND(4.875,1) FROM DUAL;

SELECT * FROM orders;
--Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���ϼ���.
SELECT custid ����ȣ, ROUND(avg(saleprice),-2)��ձݾ�
FROM orders
GROUP BY custid;

--Q.  ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT * FROM book;
SELECT bookid, REPLACE(bookname,'�߱�','��') bookname, price
FROM Book;
--Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
SELECT bookname ����, LENGTH(bookname)���ڼ�, LENGTHB(bookname)����Ʈ��
FROM book
WHERE publisher='�½�����';

SELECT*FROM customer;
--Q. �Ʒ��� �ִ� ������ �߰��ϼ���.
--(5,"�ڼ���","���ѹα� ����,NULL)
INSERT INTO customer VALUES(5,'�ڼ���','���ѹα� ����',null);
INSERT INTO customer VALUES(6,'�ڼ���','���ѹα� ����','010-9000-0001');

--Q. 6���� �����ϼ���
DELETE CUSTOMER
WHERE CUSTID=6;

--Q. ���缭���� ���߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���ϼ���.
SELECT SUBSTR(name,1,1)��,COUNT(*)�ο���
FROM Customer
GROUP BY SUBSTR(name,1,1);

SELECT * FROM orders;
--Q. ���缭���� �ֹ��Ϸ� ���� 10�� ������ Ȯ���Ѵ�, �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
SELECT orderdate �ֹ���¥, orderdate+10 Ȯ����
FROM Orders;

--Q. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�
-- ���� ��¥�� ǥ��
SELECT SYSDATE FROM DUAL;
SELECT sysdate,TO_CHAR(sysdate,'yyyy/mm/dd dy hh24:mi:ss')SYSDATE1
FROM DUAL;

--Q. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ ,������ȣ�� ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, To_CHAR(orderdate,'yyyy-mm-dd day')�ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate='20.07/07';
--Q ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <=(SELECT AVG(saleprice) FROM Orders);
--Q �� ��Ͽ��� ����ȣ, �̸� ��ȭ��ȣ�� ���� �θ� ���̽ÿ�
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM<=2;
--Q ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid,saleprice
FROM Orders
WHERE saleprice <=(SELECT AVG(saleprice) FROM Orders);

--Q. �� ���� ��ü ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid, custid, saleprice
FROM orders md
WHERE saleprice > (SELECT AVG(saleprice) FROM Orders so WHERE md.custid=so.custid);

SELECT	orderid, custid, saleprice
from Orders b1
where b1.saleprice > (select avg(b2.saleprice)
from Orders b2 where b2.custid = b1.custid);
--Q. '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) ���Ǹž�
FROM Orders
WHERE custid IN (SELECT custid FROM Customer WHERE address LIke '%���ѹα�%');
--Q. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ� ��ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice > ALL(SELECT saleprice FROM Orders WHERE custid='3');
--[����]. EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ ���Ǹž��� ���Ͻÿ�
SELECT SUM(saleprice) ���Ǹž� FROM Orders od WHERE EXISTS 
(SELECT * FROM Customer cs WHERE address LIKE '%���ѹα�%' AND custid=od.custid);

--[����]. ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).
SELECT (SELECT name FROM Customer cs WHERE cs.custid=od.custid) �̸�, SUM(saleprice) �հ�
FROM Orders od
GROUP BY od.custid;

--Q. ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).
SELECT cs.name, SUM(od.saleprice) �Ǹž�
FROM (SELECT custid, name FROM Customer WHERE custid<=2)cs, Orders od
WHERE cs.custid=od.custid
GROUP BY cs.name;

--Q. �ּҿ� '���ѹα�'�� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�
CREATE VIEW vw_Customer
AS SELECT * FROM Customer WHERE address LIKE '%���ѹα�%';
SELECT * FROM vw_Customer;
--Q. orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ�� �� �� �ִ� �並 ������ ��,
--'�迬��' ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
CREATE VIEW vw_Orders (orderid, custid, name, bookid,bookname,saleprice,orderdate)
AS SELECT od.orderid,od.custid,cs.name,od.bookid,bk.bookname,od.saleprice,od.orderdate
FROM Orders od, Customer cs, Book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid;

--��� Ȯ��
SELECT orderid,bookname,saleprice
FROM vw_Orders
WHERE name='�迬��';

--[����] vw_Customer�� �̱��� �ּҷ� ���� ������ �����ϼ���.
CREATE OR REPLACE VIEW vw_Customer (custid,name,address)
AS SELECT custid, name, address FROM Customer WHERE address LIKE '%�̱�%';

SELECT* FROM vw_Customer;

--[����] �ռ� ������ �� vw_customer�� �����Ͻÿ�.
DROP VIEW vw_Customer;
SELECT *
FROM vw_Customer;

SELECT*FROM employees;
-- [����] . EMPLOYEES ���̺��� commission_pct�� null�� ������ ����ϼ���.
  SELECT COUNT(*)
  FROM EMPLOYEES
  WHERE commission_pct is null;

-- [����] EMPLOYEES ���̺��� employee_id�� Ȧ���� �͸� ����ϼ���.
SELECT *
FROM EMPLOYEES
WHERE MOD(employee_id,2)=1;

-- [����] job_id�� ���� ���̸� ���ϼ���
SELECT job_id, LENGTH(job_id) FROM employees;

-- [����] job_id���� �����հ� ������� �ְ��� �������� ���
SELECT SUM(SALARY) AS TOTAL,
AVG(SALARY) AS average,
MAX(SALARY) AS maximum,
MIN(SALARY) AS minumun
FROM SALARY;

--��¥ ���� �Լ�
SELECT SYSDATE FROM DUAL;
SELECT * FROM employees;
SELECT last_name, hire_date, TRUNC((SYSDATE - hire_date)/365,0)�ټӿ��� FROM employees;

--Ư�� ���� ���� ���� ��¥�� ���ϱ�
SELECT last_name, hire_date, ADD_MONTHS(hire_date,6) FROM employees;

--�ش� ��¥�� ���� ���� ������ ��ȯ�ϴ� �Լ�
SELECT LAST_DAY(SYSDATE) FROM dual;

--Q. ���� �� ����(hire_data ����)
select last_name, hire_date,last_DAY(ADD_MONTHS(hire_date,1)) "�Ի� ������ ����"
from employees;

--�ش� ��¥�� �������� ��õ� ���Ͽ� �ش��ϴ� ������ ��¥�� ��ȯ
SELECT hire_date,next_day(hire_date,'��') FROM employees;

--months_between() ��¥�� ��¥ ������ ���� ���� ���ϱ�
SELECT last_name, TRUNC(MONTHS_BETWEEN(sysdate,hire_date),0)�ټӿ���1, ROUND(MONTHS_BETWEEN(sysdate,hire_date),0)�ټӿ���2 FROM employees;

--Q.�Ի��� 6���� �� ù ��° �������� �����̸����� ����ϼ���.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),'��')d_day
FROM employees;

--Q.job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 ����
select job_id , sum(salary)�����հ�,avg(salary)�������,max(salary)�ְ���,min(salary)��������
from employees
group by job_id
having avg(salary) >= 5000;

--Q.job_id ���� �����հ� ������� �ְ��� �������� ���, �� ��տ����� 5000 �̻��� ��츸 ������������ ����
select job_id , sum(salary)�����հ�,avg(salary)�������,max(salary)�ְ���,min(salary)��������
from employees
group by job_id
having avg(salary) >= 5000
order by avg(salary) desc;


--Q. last_name�� L�� ���Ե� ������ ������ ���϶�
SELECT LAST_NAME , SALARY
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%L%';

--Q. job_id�� PROG�� ���Ե� ������ �Ի��� ���϶�
SELECT JOB_ID,HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID LIKE '%PROG%';

--Q. ������ 10000$ �̻��� MANAGER_ID �� 100�� ������ ������ ���
SELECT * 
FROM EMPLOYEES
WHERE SALARY >=10000 AND MANAGER_ID =100;

--Q. DEPARTMENT_ID �� 100���� ���� ��� ������ ������ ���Ͽ���
SELECT DEPARTMENT_ID,SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID <100;

--Q. MANAGER_ID �� 101,103�� ������ JOB_ID�� ���Ͽ���
SELECT MANAGER_ID,JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID =101 OR MANAGER_ID =103;

--join

--Q. �����ȣ�� 110�� ����� �μ���
SELECT employee_id, department_name
FROM employees e,departments d
WHERE e.department_id=d.department_id and employee_id=110;

SELECT employee_id, department_name
FROM employees e
join departments d on e.department_id=d.department_id
WHERE employee_id=110;

--Q.����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(�ΰ��� ���)
select employee_id,last_name,e.job_id,job_title 
from employees e 
join jobs j on e.job_id=j.job_id
where employee_id=120;

select employee_id,last_name,e.job_id,job_title from employees e,jobs j 
where employee_id=120 and e.job_id=j.job_id;

--���, �̸�, department_name, job_title(employees, departments, jobs)
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.job_id=j.job_id AND e.department_id=d.department_id;

SELECT e.employee_id ���, e.last_name �̸�, d.department_name ���, j.job_title ������
FROM employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id;

--self join �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
SELECT e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id 
FROM employees e, employees m
WHERE e.employee_id = m.manager_id;

--outer join: ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
SELECT e.employee_id ���, e.last_name �̸�, m.last_name, m.manager_id
FROM employees e, employees m
WHERE e.employee_id=m.manager_id(+);

SELECT employee_id, last_name, manager_id 
FROM employees
WHERE last_name='Kumar';

--Q.100�� �μ��� ������ ����� �޿����� �� ���� �޿��� �޴� ����� ���
select e.last_name, e.salary from employees e
where e.salary > ALL(select (salary) from employees where department_id = 100);


--[����] 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(department_name), ������(job_title)�� ���
SELECT e.employee_id,e.last_name,hire_date,department_name,job_title
FROM employees e, departments d, jobs j
WHERE e.department_id=d.department_id AND e.job_id=j.job_id and hire_date >= '05/01/01'
ORDER BY hire_date;

--[����]job_title, department_name���� ��� ������ ���� �� ����ϼ���. 
SELECT job_title, department_name, ROUND(AVG(salary)) "��� ����"
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id=j.job_id
GROUP BY job_title, department_name;

--[����]��պ��� ���� �޿��� �޴� ���� �˻� �� ����ϼ���.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--[����]last_name�� King�� ������ last_name, hire_date, department_id�� ����ϼ���
SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name)='king';

--[����] ���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
--salary > 20000 then '��ǥ�̻�'
--salary > 15000 then '�̻�' 
--salary > 10000 then '����' 
--salary > 5000 then '����' 
--salary > 3000 then '�븮'
--������ '���'
SELECT employee_id ���, last_name �̸�,
CASE WHEN salary > 20000 then '��ǥ�̻�'
WHEN salary > 15000 then '�̻�' 
WHEN salary > 10000 then '����' 
WHEN salary > 5000 then '����' 
WHEN salary > 3000 then '�븮'
ELSE '���'
END AS ����
FROM employees;

-- UNION ( �� ����� ��ġ�鼭 �ߺ� ���� ����)
SELECT first_name �̸�, salary �޿� from employees
where salary < 5000 
union 
select first_name �̸�, salary �޿� FROM employees
where hire_date < '99/01/01';

select * from employees;
-- UNION ALL( �� ����� ��ġ�鼭 �ߺ��� ����)
SELECT first_name �̸�, salary �޿� from employees
where salary < 5000 
union all
select first_name �̸�, salary �޿� FROM employees
where hire_date < '99/01/01';

-- INTERSECT(������)
SELECT first_name �̸�, salary �޿� from employees
where salary < 5000 
intersect
select first_name �̸�, salary �޿� FROM employees
where hire_date < '07/01/01';

--  MINUS(������)
SELECT first_name �̸�, salary �޿� from employees
where salary < 5000 
MINUS
select first_name �̸�, salary �޿� FROM employees
where hire_date < '07/01/01';




