--[테이블 생성 규칙]

--테이블명은 객체를 의미할 수 있는 적절한 이름을 사용한다. 가능한 단수형을 권고한다.--
--테이블명은 다른 테이블의 이름과 중복되지 않아야 한다.--
--한 테이블 내에서는 칼럼명이 중복되게 지정될 수 없다. --
--테이블 이름을 지정하고 각 칼럼들은 괄호 "( )" 로 묶어 지정한다.--
--각 칼럼들은 콤마" ", 로 구분되고, 항상 끝은 세미콜론 ";"으로 끝난다.--
--칼럼에 대해서는 다른 테이블까지 고려하여 데이터베이스 내에서는 일관성 있게 사용하는 것이 좋다. (데이터 표준화 관점)--
--칼럼 뒤에 데이터 유형은 꼭 지정되어야 한다.--
--테이블명과 칼럼명은 반드시 문자로 시작해야 하고, 벤더별로 길이에 대한 한계가 있다.--
--벤더에서 사전에 정의한 예약어(Reserved word)는 쓸 수 없다.--
--A-Z, a-z, 0-9, _, $, # 문자만 허용된다.

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

-- 일부 속성만 입력하는 경우(앞에 일부 속성을 넣어야 한다)
INSERT INTO MEMBER (ID, PWD, NAME)VALUES('200901','111','KEVIN');
조회하기
SELECT * FROM MEMBER;
-- 전체 속성을 입력하는 경우
INSERT INTO MEMBER VALUES('200901','112','JAMES','M',29,'01-JAN-99','010-1234-2345','1994/05/02');
-- 조회하기(확인하기)
SELECT*FROM MEMBER;
-- 내용 수정
(대용량 데이터 부르기)
ALTER TABLE MEMBER ADD TEXT NCLOB;

INSERT INTO MEMBER(ID,PWD,TEXT) VALUES('200903','112','정치는 국민을 위해 존재한다');

--2022년 2월 16일

--기존 테이블을 이용하여 새로운 테이블을 생성
CREATE TABLE MEMBER1 AS SELECT * FROM MEMBER;
SELECT*FROM MEMBER1;
DESC MEMBER1;

-- 테이블 구조만 복사하기
CREATE TABLE MEMBER2 AS SELECT * FROM MEMBER1 WHERE 1=0;
DESC MEMBER2;

-- 컬럼 갯수 확인
SELECT * FROM USER_UNUSED_COL_TABS;
-- 테이블의 모든 ROW 삭제
TRUNCATE TABLE MEMBER1;



-- *은 ALL을 의미한다

--테이블 속성 및 타입 조회

DESC MEMBER;   
--DESC는 DESCRIPTION(테이블 속성 및 타입 조회)

SELECT * FROM TABS;
--TABS는 현재 있는 태이블 리스트

--ALTER(테이블의 속성을 변경 또는 수정)
DESC MEMBER1;
ALTER TABLE MEMBER1 MODIFY(ID VARCHAR2(50), NAME NVARCHAR2(50));
--변경(칼럼 제목을 변경)
ALTER TABLE MEMBER1 RENAME COLUMN BIRTHDAY TO BD;
--삭제
ALTER TABLE MEMBER1 DROP COLUMN AGE;
--추가(추가할 내용중에서는 추가할 항목과 속성을 같이 입력해야 한다.)
ALTER TABLE MEMBER1 ADD AGE NUMBER;
--ID에 PRIMARY KEY를 제약조건으로 두고 싶을때
ALTER TABLE MEMBER1 ADD CONSTRAINT MEMBER1_PK PRIMARY KEY (ID);

--[과제] MEMBER2 테이블을 생성한 후 수정, 변경, 삭제, 추가 작업을 수행하세요.(학생 이력 TABLE)

CREATE TABLE MEMBER2 AS SELECT * FROM MEMBER;
SELECT*FROM MEMBER2;

--테이블명 : PLAYER
--테이블 설명 : K-리그 선수들의 정보를 가지고 있는 테이블
--칼럼명 : PLAYER_ID (선수ID) 문자 고정 자릿수 7자리,
--PLAYER_NAME (선수명) 문자 가변 자릿수 20자리,
--TEAM_ID (팀ID) 문자 고정 자릿수 3자리,
--JOIN_YYYY (입단년도) 문자 고정 자릿수 4자리,
--POSITION (포지션) 문자 가변 자릿수 10자리,
--BACK_NO (등번호) 숫자 2자리,
--NATION (국적) 문자 가변 자릿수 20자리,
--BIRTH_DATE (생년월일) 날짜,
--제약조건 : 기본키(PRIMARY KEY) :  PLAYER_ID
--(제약조건명은 PLAYER_PK)
--값이 반드시 존재 (NOT NULL) : PLAYER_NAME, TEAM_ID


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

--테이블 2개 생성(제약 조건 포함)
CREATE TABLE PLAYER AS SELECT * FROM MEMBER;
SELECT*FROM PALYER;
DESC PLAYER;


