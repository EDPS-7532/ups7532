-- ESCAPE
SELECT * FROM employees WHERE job_id like '%\_A%' escape '\';
SELECT * FROM employees WHERE job_id like '%#_A%' escape '#';

--IN : or 대신에 사용한다
SELECT * FROM employees WHERE manager_id = 101 or manager_id = 102 or manager_id=103;
SELECT * FROM employees WHERE manager_id in (101,102,103);

--BETWEEN AND : AND 대신에 사용(포함)
SELECT* FROM employees WHERE manager_id BETWEEN 101 AND 103;

--IS NULL/ IS NOT NULL
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;

--[주요 함수]
--MOD 함수 : 나누었을 때 나머지를 구하는 함수
SELECT * FROM employees WHERE MOD(employee_id,2)=1;
SELECT MOD(10,3) FROM dual;

--ROUND() : 소수점이하 반올림 함수
SELECT ROUND(355.95555) FROM dual;
SELECT ROUND(355.95555,0) FROM dual;
SELECT ROUND(355.95555,2) FROM dual;
SELECT ROUND(355.95555,-1) FROM dual;

--TRUNC() : 지정한 자릿수 이하를 버림
SELECT TRUNC(45.5555,1) FROM dual;
SELECT last_name, TRUNC(salary/12,2) FROM employees;

--날짜 관련 함수
SELECT SYSDATE FROM dual;
SELECT SYSDATE + 1 FROM dual;
SELECT last_name, TRUNC((SYSDATE - hire_date)/365) 근속연수 FROM employees;
SELECT last_name, hire_date, ADD_MONTHS(hire_date, 6) FROM employees;
SELECT LAST_DAY(sysdate) - sysdate FROM dual;
SELECT hire_date, NEXT_DAY(hire_date,'월') FROM employees;
SELECT sysdate, NEXT_DAY(sysdate, '금') FROM dual;

--개월수
--MONTHS_BETWEEN()
SELECT last_name,sysdate,hire_date, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) FROM employees;

--형변환 함수
--NUMBER CHARACTER DATE
--TO DATE() 문자열을 날짜로
--to_number, to_character, to_date
SELECT last_name, months_between('12/12/31',hire_date) FROM employees;
SELECT trunc(sysdate - to_date('2014/01/01')) FROM dual;

-- Q. employees 테이블에 있는 직원들(사번, 이름기준으로)에 대하여 현재기준으로 근속연수를 구하세요.
SELECT employee_id,last_name, TRUNC((SYSDATE - hire_date)/365) 근속연수 FROM employees;

SELECT TO_DATE('20210101'),
TO_CHAR((TO_DATE('20210101'),' MonthDD YYYY','NLS_DATE_LANGUAGE=ENGLISH') format1 FROM dual;

SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual;
SELECT TO_CHAR(SYSDATE, 'hh24:mi:ss') From dual;
SELECT TO_CHAR(SYSDATE, 'DAY') FROM dual;

SELECT salary, TO_CHAR(salary,'09999') FROM employees;

--TO_CHAR
--9 한자리의 숫자표현
--0 앞부분을 0으로 표현
--$ 달러기호를 앞에 표현
--. 소수점을 표시
--, 특정 위치에 표시
--MI 오른쪽에 ?기호 표시
--PR 음수값을 <>으로 표현
--eeee과학적표현
--ㅣ 지역통화
SELECT salary, TO_CHAR(salary,'09999') FROM employees;
SELECT TO_CHAR(-salary,'99999PR') from employees;
SELECT TO_CHAR(1111, '99.99EEEE') FROM DUAL;
SELECT TO_CHAR(1111, 'B9999.99') FROM DUAL;
SELECT TO_CHAR(1111, 'L9999') FROM DUAL;

--WIDTH_BUCKET() 지정값, 최소값, 최대값, BUCKET개수
SELECT WIDTH_BUCKET(92,0,100,10) FROM DUAL;
SELECT department_id, last_name, salary, width_bucket(salary,0,20000,5) from employees where department_id=50;

--[과제] employees 테이블에서 employee_id, last_name, salary, hire_date 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한후 출력하세요.
--2001년 1워 1일에 창업하여 현재 (2020년 12월 31일)까지 20년간 운영되어온 회사는 직원의 근속연수에 따라 30등급으로 나누어 등급에 따라 1000원의 bonus를 지급
--(bonus 기준 내림차순 정렬)
SELECT employee_id, last_name, salary, hire_date,
TRUNC(((to_date('20201231') - hire_date)/365))근속연수,
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30)) 보너스등급,
(WIDTH_BUCKET(TRUNC(((to_date('20.12.31') - hire_date)/365)),0,20,30))*1000 bonus
FROM employees
ORDER BY bonus DESC;

--문자함수
SELECT UPPER('Hello World')FROM dual;
SELECT LOWER('HELLO WORLD') FROM dual;
SELECT last_name, salary from employees where lower(last_name)='seo';

SELECT INITCAP(job_id) FROM employees;
--문자열의 길이
select job_id, length(job_id) from employees;
--문자열중 몇번째인지?(hello world에서 o라는 문자가 찾을 위치(3)>> 시작위치, 몇번째 것인가(2)?
select instr('hello world','o',3,2) from dual;
--substr(시작위치부터 몇번째인가 ex 3,3>>3번째부터 3번을 나타내기)
select substr('hello world',3,3) from dual;
-- -3은 뒤에서부터 3칸 
select substr('hello world',-3,3) from dual;
--전체 자리수를 20으로 잡고 나머지 부분은 #으로 채워준다(오른쪽)
SELECT LPAD('hello world',20,'#') from dual;
--전체 자리수를 20으로 잡고 나머지 부분은 #으로 채워준다(왼쪽)
SELECT RPAD('hello world',20,'#') from dual;
-- 특정 문자를 제거(왼쪽부분만)
select LTRIM('aaahello worldaaa','a') from dual;
-- 특정 문자를 제거(오른쪽부분만)
select RTRIM('aaahello worldaaa','a') from dual;

select LTRIM('    hello world    ',' ') from dual;
select RTRIM('    hello world    ',' ') from dual;
select TRIM('    hello world    ',' ') from dual;

--기타함수  nvl = nul을 0또는 1로 변환
SELECT salary,commission_pct,  salary*12 *nvl(commission_pct,0) FROM employees;
-- 데이터를 달아줄때 유용함
select last_name, department_id,
case when department_id=90 then '경영지원실'
WHEN department_id = 60 THEN '프로그래머'
WHEN department_id=100 THEN '인사부'
END AS 소속
FROM employees;

-- 분석함수 : 여러 가지 기준을 적용해 여러 결과를 return 할 수 있으며 처리 대상이 되는 행위 집단을 window라고 지칭
-- FIRST_VALUE() OVER() 그룹의 첫번째 값을 구한다.
SELECT first_name 이름, salary 연봉,
FIRST_VALUE(salary) over(order by salary desc rows 3 preceding) 최고연봉
FROM employees;

-- 3줄 위의 값까지중 최저연봉
SELECT first_name 이름, salary 연봉,
FIRST_VALUE(salary) over(order by salary rows 3 preceding) 최저연봉
FROM employees;

SELECT first_name 이름, salary 연봉,
LAST_VALUE(salary) over(order by salary desc rows 3 preceding) 
FROM employees;

-- 위아래 각각 2줄까지 중 최저연봉
SELECT first_name 이름, salary 연봉,
LAST_VALUE(salary) over(order by salary DESC ROWS BETWEEN 2 preceding and 2 following) 최저연봉
FROM employees;


-- [과제] employees 테이블에서 department_id =50인 직원의 연봉을 내림차순으로 정렬하여 누적카운트를 출력하세요.
SELECT employees, department_id, salary
count(*) over(order by salary desc)누적카운트 from employees where department_id=50;
-- [과제] employees 테이블에서 department_id를 기준으로 오름차순 정렬하고 직원의 연봉 누적 합계를 출력하세요.
SELECT  department_id,last_name, salary, sum(salary) over(partition by department_id order by department_id asc)
from employees;



-- [과제] employees 테이블에서 department_id(부서) 별 직원 연봉순위를 출력하세요.
select first_name, department_id 부서, salary 연봉
rank() over(partition by department_id order by salary desc) 부서 연봉순위
from employees;









--dml 

DESC BOOK;
-- BOOK에 내용을 전부 추출
SELECT*FROM BOOK;
-- BOOK에서 BOOKNAME과 PRICE를 추출
SELECT BOOKNAME,PRICE FROM BOOK;
--PUBLISHER를 추출
SELECT PUBLISHER FROM BOOK;
--PUBLISHER에서 중복을 제거
SELECT DISTINCT PUBLISHER FROM BOOK;
-- 불린 인덱싱(특정 조건을 추출하는 방법)
SELECT*
FROM BOOK
WHERE PRICE < 10000;

-- Q. 가격이 10000원 이상 20000원 이하인 도서를 검색하세요.
SELECT*
FROM BOOK
WHERE PRICE >= 10000 AND PRICE <= 20000;

--Q. 출판사가 굿스포츠,혹은 대한미디어인 도서를 검색하세요.
SELECT* FROM BOOK WHERE PUBLISHER = '굿스포츠' OR PUBLISHER = '대한미디어';
SELECT* FROM BOOK WHERE PUBLISHER IN ('굿스포츠','대한미디어');
--Q. 출판사가 굿스포츠,혹은 대한미디어가 아닌 도서를 검색하세요
SELECT* FROM BOOK WHERE PUBLISHER NOT IN ('굿스포츠','대한미디어');

--Q. 도서이름에 축구가 포함된 출판사를 검색하세요.
SELECT PUBLISHER FROM BOOK WHERE BOOKNAME LIKE '%축구%';
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';

--[과제] 도서 이름의 왼쪽 두번째 위치에 구 라는 문자열을 갖는 도서를 검색하세요.
SELECT* FROM BOOK WHERE BOOKNAME LIKE '%_구%';

--[과제] 축구에 관한 도서중 가격이 20,000원 이상인 도서를 검색하세요.
SELECT* FROM BOOK WHERE BOOKNAME LIKE '%축구%' AND PRICE>=20000;

--정렬(BOOKNAME을 기준으로)

SELECT* 
FROM BOOK
ORDER BY BOOKNAME;

-- 내림차순
SELECT*
FROM BOOK
ORDER BY BOOKNAME DESC;

--Q. 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하세요.
SELECT*
FROM BOOK
ORDER BY PRICE,BOOKNAME;

--Q. 도서를 가격의 내림차순으로 검색하고 만약 가격이 같다면 출판사의 오름차순으로 출력하세요.(publisher가 default값임)
SELECT*
FROM BOOK
ORDER BY PRICE DESC,PUBLISHER;

-- SALEPRICE의 합계를 출력하기
select* from orders;
select sum(saleprice)
from orders;

-- 이름을 총매출로 변경 >> AS로 사용함
SELECT SUM(SALEPRICE) AS "총매출" 
FROM ORDERS;

-- Q.CUSTID가 2번인 고객이 주문한 도서의 총 판매액을 구하세요
SELECT SUM(SALEPRICE) AS "총 판매액" FROM ORDERS WHERE CUSTID=2;

-- Q.SUM,AVG,MIN,MAX을 출력하세요
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE,
MAX(SALEPRICE) AS MAXIMUM,
MIN(SALEPRICE) AS MINIMUN
FROM ORDERS;

--COUNT
SELECT COUNT(*) FROM ORDERS;

--Q. CUSTID별 도서 수량과 총 판매액을 구하세요
SELECT CUSTID, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총판매액"
FROM ORDERS GROUP BY CUSTID;

--Q. 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요 단, 두번 이상 구매한 고객에 한정함.
SELECT CUSTID, COUNT(*) AS 도서수량
FROM ORDERS
WHERE SALEPRICE >=8000
GROUP BY CUSTID
HAVING COUNT(*) >=2;

SELECT* FROM CUSTOMER;

-- 두개의 열을 합치기
SELECT*
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID

-- 고객에 데이터를 정력하기
SELECT*
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID;

-- 내림차순 정렬
SELECT*
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID
ORDER BY CUSTOMER.CUSTID.DESC;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬하세요
SELECT NAME,SUM(SALEPRICE)
FROM CUSTOMER,ORDERS
WHERE CUSTOMER.CUSTID=ORDERS.CUSTID
GROUP BY CUSTOMER.NAME
ORDER BY CUSTOMER.NAME;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요
SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM CUSTOMER, ORDERS,BOOK
WHERE CUSTOMER.CUSTID=ORDERS.CUSTID AND ORDERS.BOOKID=BOOK.BOOKID;

SELECT C.NAME, B.BOOKNAME
FROM CUSTOMER C, ORDERS O ,BOOK B
WHERE C.CUSTID=O.CUSTID AND O.BOOKID=B.BOOKID;

--[과제] 가격이 20,000인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE
FROM CUSTOMER C , ORDERS O, BOOK B
WHERE C.CUSTID=O.CUSTID AND O.BOOKID=B.BOOKID AND B.PRICE=20000;

--[과제] 도서를 구매하지 않을 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
-- OUTER JOIN : 조인 조건을 만족하지 못하더라도 해당 행을 나타냄
SELECT CUSTOMER.NAME, SALEPRICE
FROM CUSTOMER LEFT OUTER JOIN ORDERS ON CUSTOMER.CUSTID=ORDERS.CUSTID;

--[과제] 가장 비싼 도서의 이름을 출력하세요.
SELECT BOOKNAME
FROM BOOK
WHERE PRICE=(SELECT MAX(PRICE) FROM BOOK);

--[과제] 도서를 구매한 적이 있는 고객의 이름을 검색하세요.
SELECT NAME
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
--[과제] 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력하세요.
SELECT NAME FROM CUSTOMER WHERE CUSTID IN
(SELECT CUSTID FROM ORDERS WHERE BOOKID IN
(SELECT BOOKID FROM BOOK WHERE PUBLISHER='대한미디어'));
--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시요.
SELECT B1.BOOKNAME 
FROM BOOK b1 
WHERE B1.PRICE > (SELECT AVG(B2.PRICE) 
FROM BOOK B2 WHERE B2.PUBLISHER=B1.PUBLISHER)
--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT NAME 
FROM CUSTOMER 
MINUS 
SELECT NAME 
FROM CUSTOMER 
WHERE CUSTID IN(SELECT CUSTID FROM ORDERS);
--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT NAME,ADDRESS 
FROM CUSTOMER CS 
WHERE EXISTS (SELECT* FROM ORDERS OD WHERE CS.CUSTID=OD.CUSTID);

SELECT NAME, ADDRESS
FROM CUSTOMER
WHERE CUSTID IN(SELECT CUSTID FROM ORDERS);
--Q. CUSTOMER 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하세요.
UPDATE CUSTOMER
SET ADDRESS ='대한민국 부산'
WHERE CUSTID =5;
--결과
SELECT*FROM CUSTOMER;
-- 가급적이면 대소문자를 구별한다.

--Q. CUSTOMER 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하세요.
UPDATE customer
SET address = (SELECT address FROM customer
WHERE name = '김연아')
WHERE name = '박세리';

--Q. CUSTOMER 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
DELETE CUSTOMER
WHERE CUSTID=5;

SELECT ABS(-78),ABS(+78) FROM DUAL;
--Q. 4.875 소수점 처음까지 반올림하세요
SELECT ROUND(4.875,1) FROM DUAL;

SELECT * FROM orders;
--Q. 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하세요.
SELECT custid 고객번호, ROUND(avg(saleprice),-2)평균금액
FROM orders
GROUP BY custid;

--Q.  도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록, 가격을 보이시오.
SELECT * FROM book;
SELECT bookid, REPLACE(bookname,'야구','농구') bookname, price
FROM Book;
--Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목, LENGTH(bookname)글자수, LENGTHB(bookname)바이트수
FROM book
WHERE publisher='굿스포츠';

SELECT*FROM customer;
--Q. 아래에 있는 내용을 추가하세요.
--(5,"박세리","대한민국 대전,NULL)
INSERT INTO customer VALUES(5,'박세리','대한민국 대전',null);
INSERT INTO customer VALUES(6,'박세리','대한민국 대전','010-9000-0001');

--Q. 6행을 삭제하세요
DELETE CUSTOMER
WHERE CUSTID=6;

--Q. 마당서점의 고객중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하세요.
SELECT SUBSTR(name,1,1)성,COUNT(*)인원수
FROM Customer
GROUP BY SUBSTR(name,1,1);

SELECT * FROM orders;
--Q. 마당서점은 주문일로 부터 10후 매출을 확정한다, 각 주문의 확정일자를 구하세요.
SELECT orderdate 주문날짜, orderdate+10 확정일
FROM Orders;

--Q. 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오
-- 현재 날짜를 표시
SELECT SYSDATE FROM DUAL;
SELECT sysdate,TO_CHAR(sysdate,'yyyy/mm/dd dy hh24:mi:ss')SYSDATE1
FROM DUAL;

--Q. 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호 ,도서번호를 모두 보이시오.
SELECT orderid 주문번호, To_CHAR(orderdate,'yyyy-mm-dd day')주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate='20.07/07';
--Q 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <=(SELECT AVG(saleprice) FROM Orders);
--Q 고객 목록에서 고객번호, 이름 전화번호를 앞의 두명만 보이시오
SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM<=2;
--Q 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid,saleprice
FROM Orders
WHERE saleprice <=(SELECT AVG(saleprice) FROM Orders);

--Q. 각 고객의 전체 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid, custid, saleprice
FROM orders md
WHERE saleprice > (SELECT AVG(saleprice) FROM Orders so WHERE md.custid=so.custid);

SELECT	orderid, custid, saleprice
from Orders b1
where b1.saleprice > (select avg(b2.saleprice)
from Orders b2 where b2.custid = b1.custid);
--Q. '대한민국'에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시요.
SELECT SUM(saleprice) 총판매액
FROM Orders
WHERE custid IN (SELECT custid FROM Customer WHERE address LIke '%대한민국%');
--Q. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문 번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice > ALL(SELECT saleprice FROM Orders WHERE custid='3');
--[과제]. EXISTS 연산자를 사용하여 '대한민국'에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오
SELECT SUM(saleprice) 총판매액 FROM Orders od WHERE EXISTS 
(SELECT * FROM Customer cs WHERE address LIKE '%대한민국%' AND custid=od.custid);

--[과제]. 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).
SELECT (SELECT name FROM Customer cs WHERE cs.custid=od.custid) 이름, SUM(saleprice) 합계
FROM Orders od
GROUP BY od.custid;

--Q. 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).
SELECT cs.name, SUM(od.saleprice) 판매액
FROM (SELECT custid, name FROM Customer WHERE custid<=2)cs, Orders od
WHERE cs.custid=od.custid
GROUP BY cs.name;

--Q. 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오
CREATE VIEW vw_Customer
AS SELECT * FROM Customer WHERE address LIKE '%대한민국%';
SELECT * FROM vw_Customer;
--Q. orders 테이블에서 고객이름과 도서이름을 바로 확인 할 수 있는 뷰를 생성한 후,
--'김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
CREATE VIEW vw_Orders (orderid, custid, name, bookid,bookname,saleprice,orderdate)
AS SELECT od.orderid,od.custid,cs.name,od.bookid,bk.bookname,od.saleprice,od.orderdate
FROM Orders od, Customer cs, Book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid;

--결과 확인
SELECT orderid,bookname,saleprice
FROM vw_Orders
WHERE name='김연아';

--[과제] vw_Customer를 미국을 주소로 가진 고객으로 변경하세요.
CREATE OR REPLACE VIEW vw_Customer (custid,name,address)
AS SELECT custid, name, address FROM Customer WHERE address LIKE '%미국%';

SELECT* FROM vw_Customer;

--[과제] 앞서 생성한 뷰 vw_customer를 삭제하시오.
DROP VIEW vw_Customer;
SELECT *
FROM vw_Customer;

SELECT*FROM employees;
-- [과제] . EMPLOYEES 테이블에서 commission_pct의 null값 갯수를 출력하세요.
  SELECT COUNT(*)
  FROM EMPLOYEES
  WHERE commission_pct is null;

-- [과제] EMPLOYEES 테이블에서 employee_id가 홀수인 것만 출력하세요.
SELECT *
FROM EMPLOYEES
WHERE MOD(employee_id,2)=1;

-- [과제] job_id의 문자 길이를 구하세요
SELECT job_id, LENGTH(job_id) FROM employees;

-- [과제] job_id별로 연봉합계 연봉평균 최고연봉 최저연봉 출력
SELECT SUM(SALARY) AS TOTAL,
AVG(SALARY) AS average,
MAX(SALARY) AS maximum,
MIN(SALARY) AS minumun
FROM SALARY;

--날짜 관련 함수
SELECT SYSDATE FROM DUAL;
SELECT * FROM employees;
SELECT last_name, hire_date, TRUNC((SYSDATE - hire_date)/365,0)근속연수 FROM employees;

--특정 개월 수를 더한 날짜를 구하기
SELECT last_name, hire_date, ADD_MONTHS(hire_date,6) FROM employees;

--해당 날짜가 속한 월의 말일을 반환하는 함수
SELECT LAST_DAY(SYSDATE) FROM dual;

--Q. 다음 달 말일(hire_data 기준)
select last_name, hire_date,last_DAY(ADD_MONTHS(hire_date,1)) "입사 다음달 말일"
from employees;

--해당 날짜를 기준으로 명시된 요일에 해당하는 다음주 날짜를 반환
SELECT hire_date,next_day(hire_date,'월') FROM employees;

--months_between() 날짜와 날짜 사이의 개월 수를 구하기
SELECT last_name, TRUNC(MONTHS_BETWEEN(sysdate,hire_date),0)근속월수1, ROUND(MONTHS_BETWEEN(sysdate,hire_date),0)근속월수2 FROM employees;

--Q.입사일 6개월 후 첫 번째 월요일을 직원이름별로 출력하세요.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),'월')d_day
FROM employees;

--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 포함
select job_id , sum(salary)연봉합계,avg(salary)연봉평균,max(salary)최고연봉,min(salary)최저연봉
from employees
group by job_id
having avg(salary) >= 5000;

--Q.job_id 별로 연봉합계 연봉평균 최고연봉 최저연봉 출력, 단 평균연봉이 5000 이상인 경우만 내림차순으로 정렬
select job_id , sum(salary)연봉합계,avg(salary)연봉평균,max(salary)최고연봉,min(salary)최저연봉
from employees
group by job_id
having avg(salary) >= 5000
order by avg(salary) desc;


--Q. last_name에 L이 포함된 직원의 연봉을 구하라
SELECT LAST_NAME , SALARY
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%L%';

--Q. job_id에 PROG가 포함된 직원의 입사일 구하라
SELECT JOB_ID,HIRE_DATE
FROM EMPLOYEES
WHERE JOB_ID LIKE '%PROG%';

--Q. 연봉이 10000$ 이상인 MANAGER_ID 가 100인 직원의 데이터 출력
SELECT * 
FROM EMPLOYEES
WHERE SALARY >=10000 AND MANAGER_ID =100;

--Q. DEPARTMENT_ID 가 100보다 적은 모든 직원의 연봉을 구하여라
SELECT DEPARTMENT_ID,SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID <100;

--Q. MANAGER_ID 가 101,103인 직원의 JOB_ID를 구하여라
SELECT MANAGER_ID,JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID =101 OR MANAGER_ID =103;

--join

--Q. 사원번호가 110인 사원의 부서명
SELECT employee_id, department_name
FROM employees e,departments d
WHERE e.department_id=d.department_id and employee_id=110;

SELECT employee_id, department_name
FROM employees e
join departments d on e.department_id=d.department_id
WHERE employee_id=110;

--Q.사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(두가지 방식)
select employee_id,last_name,e.job_id,job_title 
from employees e 
join jobs j on e.job_id=j.job_id
where employee_id=120;

select employee_id,last_name,e.job_id,job_title from employees e,jobs j 
where employee_id=120 and e.job_id=j.job_id;

--사번, 이름, department_name, job_title(employees, departments, jobs)
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;

SELECT e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
FROM employees e, departments d, jobs j
WHERE e.job_id=j.job_id AND e.department_id=d.department_id;

SELECT e.employee_id 사번, e.last_name 이름, d.department_name 사원, j.job_title 직무명
FROM employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id;

--self join 하나의 테이블이 두 개의 테이블인 것처럼 조인
SELECT e.employee_id 사번, e.last_name 이름, m.last_name, m.manager_id 
FROM employees e, employees m
WHERE e.employee_id = m.manager_id;

--outer join: 조인 조건에 만족하지 못하더라도 해당 행을 나타내고 싶을 때 사용
SELECT e.employee_id 사번, e.last_name 이름, m.last_name, m.manager_id
FROM employees e, employees m
WHERE e.employee_id=m.manager_id(+);

SELECT employee_id, last_name, manager_id 
FROM employees
WHERE last_name='Kumar';

--Q.100번 부서의 구성원 모두의 급여보다 더 많은 급여를 받는 사원을 출력
select e.last_name, e.salary from employees e
where e.salary > ALL(select (salary) from employees where department_id = 100);


--[과제] 2005년 이후에 입사한 직원의 사번, 이름, 입사일, 부서명(department_name), 업무명(job_title)을 출력
SELECT e.employee_id,e.last_name,hire_date,department_name,job_title
FROM employees e, departments d, jobs j
WHERE e.department_id=d.department_id AND e.job_id=j.job_id and hire_date >= '05/01/01'
ORDER BY hire_date;

--[과제]job_title, department_name별로 평균 연봉을 구한 후 출력하세요. 
SELECT job_title, department_name, ROUND(AVG(salary)) "평균 연봉"
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id AND e.job_id=j.job_id
GROUP BY job_title, department_name;

--[과제]평균보다 많은 급여를 받는 직원 검색 후 출력하세요.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--[과제]last_name이 King인 직원의 last_name, hire_date, department_id를 출력하세요
SELECT last_name, hire_date, department_id
FROM employees
WHERE LOWER(last_name)='king';

--[과제] 사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
--salary > 20000 then '대표이사'
--salary > 15000 then '이사' 
--salary > 10000 then '부장' 
--salary > 5000 then '과장' 
--salary > 3000 then '대리'
--나머지 '사원'
SELECT employee_id 사번, last_name 이름,
CASE WHEN salary > 20000 then '대표이사'
WHEN salary > 15000 then '이사' 
WHEN salary > 10000 then '부장' 
WHEN salary > 5000 then '과장' 
WHEN salary > 3000 then '대리'
ELSE '사원'
END AS 직급
FROM employees;

-- UNION ( 두 결과를 합치면서 중복 값을 제거)
SELECT first_name 이름, salary 급여 from employees
where salary < 5000 
union 
select first_name 이름, salary 급여 FROM employees
where hire_date < '99/01/01';

select * from employees;
-- UNION ALL( 두 결과를 합치면서 중복을 포함)
SELECT first_name 이름, salary 급여 from employees
where salary < 5000 
union all
select first_name 이름, salary 급여 FROM employees
where hire_date < '99/01/01';

-- INTERSECT(교집합)
SELECT first_name 이름, salary 급여 from employees
where salary < 5000 
intersect
select first_name 이름, salary 급여 FROM employees
where hire_date < '07/01/01';

--  MINUS(차집합)
SELECT first_name 이름, salary 급여 from employees
where salary < 5000 
MINUS
select first_name 이름, salary 급여 FROM employees
where hire_date < '07/01/01';




