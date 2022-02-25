--[���̺� ���� ��Ģ]

--���̺���� ��ü�� �ǹ��� �� �ִ� ������ �̸��� ����Ѵ�. ������ �ܼ����� �ǰ��Ѵ�.--
--���̺���� �ٸ� ���̺��� �̸��� �ߺ����� �ʾƾ� �Ѵ�.--
--�� ���̺� �������� Į������ �ߺ��ǰ� ������ �� ����. --
--���̺� �̸��� �����ϰ� �� Į������ ��ȣ "( )" �� ���� �����Ѵ�.--
--�� Į������ �޸�" ", �� ���еǰ�, �׻� ���� �����ݷ� ";"���� ������.--
--Į���� ���ؼ��� �ٸ� ���̺���� ����Ͽ� �����ͺ��̽� �������� �ϰ��� �ְ� ����ϴ� ���� ����. (������ ǥ��ȭ ����)--
--Į�� �ڿ� ������ ������ �� �����Ǿ�� �Ѵ�.--
--���̺��� Į������ �ݵ�� ���ڷ� �����ؾ� �ϰ�, �������� ���̿� ���� �Ѱ谡 �ִ�.--
--�������� ������ ������ �����(Reserved word)�� �� �� ����.--
--A-Z, a-z, 0-9, _, $, # ���ڸ� ���ȴ�.

select*from tabs;
CREATE TABLE MEMBER
(
ID               VARCHAR2 (50),
PWD           VARCHAR2 (50),
NAME        VARCHAR2 (50),
GENDER     VARCHAR2 (50),
AGE            NUMBER,
BIRTHDAY  VARCHAR2 (50),
PHONE       VARCHAR2  (50),
REGDATE   DATE
);

DROP TABLE MEMBER;


CREATE TABLE MEMBER
(
ID               VARCHAR2 (20),
PWD            VARCHAR2 (20),
NAME         VARCHAR2 (20),
GENDER      NCHAR (2),
AGE            NUMBER(2),
BIRTHDAY  VARCHAR2 (10),
PHONE       VARCHAR2  (13),
REGDATE   DATE
);

-- �Ϻ� �Ӽ��� �Է��ϴ� ���(�տ� �Ϻ� �Ӽ��� �־�� �Ѵ�)
INSERT INTO MEMBER (ID, PWD, NAME)VALUES('200901','111','KEVIN');
��ȸ�ϱ�
SELECT * FROM MEMBER;
-- ��ü �Ӽ��� �Է��ϴ� ���
INSERT INTO MEMBER VALUES('200901','112','JAMES','M',29,'01-JAN-99','010-1234-2345','1994/05/02');
-- ��ȸ�ϱ�(Ȯ���ϱ�)
SELECT*FROM MEMBER;
-- ���� ����
(��뷮 ������ �θ���)
ALTER TABLE MEMBER ADD TEXT NCLOB;

INSERT INTO MEMBER(ID,PWD,TEXT) VALUES('200903','112','��ġ�� ������ ���� �����Ѵ�');

--2022�� 2�� 16��

--���� ���̺��� �̿��Ͽ� ���ο� ���̺��� ����
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
SELECT*FROM MEMBER1;
DESC MEMBER1;

-- ���̺� ������ �����ϱ�
CREATE TABLE MEMBER2 AS SELECT * FROM MEMBER1 WHERE 1=0;
DESC MEMBER2;

-- �÷� ���� Ȯ��
SELECT * FROM USER_UNUSED_COL_TABS;
-- ���̺��� ��� ROW ����
TRUNCATE TABLE MEMBER1;



-- *�� ALL�� �ǹ��Ѵ�

--���̺� �Ӽ� �� Ÿ�� ��ȸ

DESC MEMBER;   
--DESC�� DESCRIPTION(���̺� �Ӽ� �� Ÿ�� ��ȸ)

SELECT * FROM TABS;
--TABS�� ���� �ִ� ���̺� ����Ʈ

--ALTER(���̺��� �Ӽ��� ���� �Ǵ� ����)
DESC MEMBER1;
ALTER TABLE MEMBER1 MODIFY(ID VARCHAR2(50), NAME NVARCHAR2(50));
--����(Į�� ������ ����)
ALTER TABLE MEMBER1 RENAME COLUMN BIRTHDAY TO BD;
--����
ALTER TABLE MEMBER1 DROP COLUMN AGE;
--�߰�(�߰��� �����߿����� �߰��� �׸�� �Ӽ��� ���� �Է��ؾ� �Ѵ�.)
ALTER TABLE MEMBER1 ADD AGE NUMBER;
--ID�� PRIMARY KEY�� ������������ �ΰ� ������
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER1_PK PRIMARY KEY (ID);

--[����] MEMBER2 ���̺��� ������ �� ����, ����, ����, �߰� �۾��� �����ϼ���.(�л� �̷� TABLE)

CREATE TABLE MEMBER2 AS SELECT * FROM MEMBER;
SELECT*FROM MEMBER2;

--���̺�� : PLAYER
--���̺� ���� : K-���� �������� ������ ������ �ִ� ���̺�
--Į���� : PLAYER_ID (����ID) ���� ���� �ڸ��� 7�ڸ�,
--PLAYER_NAME (������) ���� ���� �ڸ��� 20�ڸ�,
--TEAM_ID (��ID) ���� ���� �ڸ��� 3�ڸ�,
--JOIN_YYYY (�Դܳ⵵) ���� ���� �ڸ��� 4�ڸ�,
--POSITION (������) ���� ���� �ڸ��� 10�ڸ�,
--BACK_NO (���ȣ) ���� 2�ڸ�,
--NATION (����) ���� ���� �ڸ��� 20�ڸ�,
--BIRTH_DATE (�������) ��¥,
--�������� : �⺻Ű(PRIMARY KEY) :  PLAYER_ID
--(�������Ǹ��� PLAYER_PK)
--���� �ݵ�� ���� (NOT NULL) : PLAYER_NAME, TEAM_ID


CREATE TABLE PLAYER
(
PLAYER_ID               NCHAR (7),
PLAYER_NAME            VARCHAR (20) NOT NULL, 
TEAM_ID                 NCHAR (3) NOT NULL, 
JOIN_YYYY           NCHAR (4),
POSITION             VARCHAR(10),
BACK_NO            NUMBER (2),
NATION             VARCHAR2  (20),
BIRTH_DATE       DATE,
CONSTRAINT PLAYER_PK PRIMARY KEY (PLAYER_ID)
);
DESC PLAYER;
DROP TABLE PLAYER;

--���̺� 2�� ����(���� ���� ����)
CREATE TABLE PLAYER AS SELECT * FROM MEMBER;
SELECT*FROM PALYER;
DESC PLAYER;


