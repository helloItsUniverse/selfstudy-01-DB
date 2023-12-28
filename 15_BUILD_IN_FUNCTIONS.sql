-- =============================================
-- BUILD IN FUNCTIONS                           
-- =============================================

-- -----------------------------------
-- 1. 문자열 관련 함수
-- -----------------------------------

-- ASCII(아스키 코드), CHAR(숫자)
SELECT ASCII('A'), CHAR(65);
SELECT ASCII('a'), CHAR(97);

-- BIT_LENGTH(문자열), CHAR_LENGTH(문자열), LENGTH(문자열)
-- 영어, 숫자, 특수기호 제하고 한 문자당 3바이트 할당
SELECT
		 BIT_LENGTH('한글')
	  , CHAR_LENGTH('한글')
	  , LENGTH('한글');

-- CONCAT(문자열1, 문자열2, ...), CONCAT_WS(구분자, 문자열1, 문자열2)
SELECT CONCAT('Nice', ' to', ' meet', ' you!');
SELECT CONCAT_WS(' ', 'Nice', 'to', 'meet', 'you!');

SELECT CONCAT(CAST(menu_price AS CHAR), '원') FROM tbl_menu ;

SELECT
		 a.category_code AS '카테고리 코드'
	  , CONCAT(CAST(CAST(AVG(a.menu_price) AS INT) AS CHAR), '원') AS '평균 가격'
  FROM tbl_menu a
 GROUP BY a.category_code;

-- ELT(위치, 문자열1, 문자열2, ...), FIELD(찾을 문자열, 문자열1, 문자열2, ...),
-- FIND_IN_SET(찾을 문자열, 문자열 리스트), INSTR(기준 문자열, 부분 문자열),
-- LOCATE(부분 문자열, 기준 문자열)
SELECT
		 ELT(2, '축구', '야구', '농구') 
	  , FIELD('축구', '야구', '농구', '축구')
	  , FIND_IN_SET('축구', '야구,농구,축구')
	  , INSTR('축구농구야구', '농구')
	  , LOCATE('야구', '축구농구야구');
	  -- INSTR과 LOCATE는 서로 인자가 반대


-- INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)
SELECT INSERT('나와라 피카츄!', 5, 3, '꼬부기') AS 'Result of INSERT';


-- LEFT(문자열, 길이), RIGHT(문자열, 길이)
SELECT LEFT('Hello World!', 5), RIGHT('Nice Shot!', 5);


-- UPPER(문자열), LOWER(문자열)
SELECT UPPER('Hello World!'), LOWER('Nice Shot!');


-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
SELECT LPAD('왼쪽', 10, '#'), RPAD('오른쪽', 10, '#');


-- LTRIM(문자열), RTRIM(문자열)
-- TRIM(문자열), TRIM(방향 자를_문자열 FROM 문자열)
SELECT LTRIM('       왼쪽'), RTRIM('오른쪽                     ');
SELECT
		 TRIM('               MariaDB               ')
	  , TRIM(BOTH '@' FROM '@@@@MariaDB@@@@')
	  , TRIM(LEADING '@' FROM '@@@@MariaDB@@@@')  -- LTRIM
	  , TRIM(TRAILING '@' FROM '@@@@MariaDB@@@@'); -- RTRIM
		 
SELECT CONCAT(menu_name, '의 가격은 ', menu_price, '원 입니다.') AS '가격 설명'
  FROM tbl_menu;
		 


-- FORMAT(숫자, 소수점 자릿수)
SELECT FORMAT(12312312321334, 3);
-- 실행 결과 : 12,312,312,321,334.000


-- BIN(10진수숫자), OCT(10진수숫자), HEX( 숫자)
SELECT BIN(65), OCT(65), HEX(65);

-- REPEAT(문자열, 횟수)
SELECT REPEAT('재미져 ', 5);

-- REPLACE(문자열, 찾을 문자열, 바꿀 문자열)
SELECT REPLACE('마리아DB', '마리아', 'Maria');

-- REVERSE(문자열)
SELECT REVERSE('happiness');

-- SPACE(길이)
SELECT CONCAT('제 포켓몬은', SPACE(3), '이고, 속성은', SPACE(6), '입니다');

-- SUBSTRING
SELECT SUBSTRING('열심히 DB공부를 해 봅시다!', 5, 4);
SELECT SUBSTRING('열심히 DB공부를 해 봅시다!', 11); -- 11번째 문자부터 끝까지

-- SUBSTRING_INDEX(문자열, 구분자, 횟수) 
SELECT
		 SUBSTRING_INDEX('010-1234-5678', '-', 2)
	  , SUBSTRING_INDEX('010-1234-5678', '-', -1);

-- -----------------------------------
-- 2. 숫자 관련 함수                  
-- -----------------------------------

-- ABS(숫자) : 절댓값
SELECT ABS(-123);

-- CEILING(숫자), FLOOR(숫자), ROUND(숫자)
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);

-- CONV(숫자, 원래 진수, 변환할 진수)
SELECT CONV('A', 16, 10), CONV('A', 16, 2);

-- MOD(숫자1, 숫자2)
SELECT MOD(10, 3), 10 % 3;

-- POW(밑, 지수), SQRT(숫자)
SELECT POW(3, 2), SQRT(81);

-- ----------------------------
-- 난수 생성                   
-- ----------------------------
-- RAND(): 0.000000000000 ~ 0.999999999999 사이의 난수 반환
-- RAND() * 생성할 난수 개수 + 난수의 초기값
-- FLOOR 사용 : 정수화

-- 예제: 5~33 사이의 정수인 난수를 생성

SELECT FLOOR(RAND() * (33 - 5 + 1) + 5) AS '5~33 사이의 랜덤 정수';


-- SIGN(숫자)
-- 양수면 1, 0이면 0, 음수면 -1 반환
SELECT SIGN(10.1), SIGN(0), SIGN(-3030.1);

-- TRUNCATE(숫자, 정수)
SELECT TRUNCATE(12345.12345678, 2), TRUNCATE(12345.12345678, -2);



-- -----------------------------------
-- 3. 날짜 및 시간 관련 함수          
-- -----------------------------------

-- 날짜 관련해서는 DB 언어가 강력하다. 쉽게 날짜 덧셈 뺄셈이 가능하다.

-- ADDDATE(날짜, 차이), SUBDATE(날짜, 차이)
SELECT
		 ADDDATE('2023-02-01', INTERVAL 28 DAY)
	  , ADDDATE('2020-02-01', 28);

SELECT
		 SUBDATE('2023-02-01', INTERVAL 1 DAY)
	  , SUBDATE('2020-02-01', 1);

SELECT ADDDATE('2020-02-01', INTERVAL 28 MONTH);
SELECT ADDDATE('2020-02-01', INTERVAL 1 MONTH);


-- ADDTIME(날짜/시간, 시간), SUBTIME(날짜/시간, 시간)
SELECT 
		 ADDTIME('2023-12-28 10:27:00', '1:0:10')
	  , SUBTIME('2023-12-28 10:27:00', '1:0:10');

-- CURDATE(), CURTIME(), NOW(), SYSDATE()
SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();
SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;

SELECT @@GLOBAL.TIME_ZONE; -- 현재 타임 존 기준을 확인하는 조회문


-- YEAR(날짜), MONTH(날짜), DAY(날짜)
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE()), DAY(CAST('2023-12-28' AS DATE));
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME());

SELECT DATE(NOW()), TIME(NOW());


-- DATEDIFF(날짜1, 날짜2), TIMEDIFF(날짜1/시간1, 날짜2/시간2)
SELECT DATEDIFF('2024-06-14', '2023-12-28'); -- 전역하는 날 ^^;;
SELECT TIMEDIFF(CAST('18:00:00' AS TIME), CURTIME());


-- DAYOFWEEK(날짜), MONTHNAME(날짜), DAYOFYEAR(날짜)
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());

-- LAST_DAY(날짜)
SELECT LAST_DAY('20200201');

-- MAKEDATE(연도, 지난 날)
SELECT MAKEDATE(2023, 35);

-- MAKETIME(시, 분, 초)
SELECT MAKETIME(17, 50, 01);

-- **************************************
-- ************ 시험 안나옴 *************
-- PERIOD_ADD(연월, 개월 수), PERIOD_DIFF(연월1, 연월2)
SELECT PERIOD_ADD(202305, 06);
SELECT PERIOD_DIFF(202406, 202312);
-- **************************************

-- QUARTER(날짜)
SELECT QUARTER('2023-12-28');

-- TIME_TO_SEC(시간) : 시간을 초 단위로 구함
SELECT TIME_TO_SEC(CURTIME()); -- 오늘 00:00:00 부터 흐른 초단위 시간