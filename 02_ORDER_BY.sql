-- ORDER BY 절이 있는 쿼리의 실행 순서
-- 1. FROM
-- 2. SELECT
-- 3. ORDER BY

SELECT
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price ASC; -- ascending: 오름차순, descending:내림차순
--  ORDER BY 는 항상 쿼리 하나의 맨 마지막에 넣자.


-- 내림차순
SELECT
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC;

-- column 의 순번을 활용한 정렬
SELECT
		 menu_price  -- 1번쩨 column
	  , menu_name   -- 2번째 column
  FROM tbl_menu
 ORDER BY 1 ASC;
 
-- 별칭을 활용한 정렬
SELECT
		 menu_code AS 'mc'
	  , menu_price AS 'mp'
	  , menu_name AS 'mn'
  FROM tbl_menu
 ORDER BY mp DESC; -- 별칭으로 정렬할 때는 single quotation 을 붙이면 안됨
 
-- column 의 복수개로 정렬
SELECT
		 menu_price
	  , menu_name
  FROM tbl_menu
 ORDER BY 1 DESC, 2 ASC; -- '가격'으로 내림차순 후 같은 가격일 시, '메뉴 이름'을 오름차순으로 조회
 
-- -------------------------------------
-- FIELD
-- FIELD 를 통해서도 정렬할 수 있다
SELECT FIELD('a', 'b', 'z', 'a');
-- 2번째 이후 인자 중에 1번째 인자의 값이 위치하는 값이 나옴 (=3)

-- table 에서 조회 시 field 활용
SELECT
		 FIELD(orderable_status, 'N', 'Y')
	  , orderable_status
	  , menu_name
	  , menu_code
  FROM tbl_menu;
 

-- field를 활용한 order by
SELECT
		 menu_name
	  , orderable_status
  FROM tbl_menu
 ORDER BY FIELD(orderable_status, 'N', 'Y') DESC;
-- 여기서 나오는 결과를 result set 이라고 함


-- -----------------------------------------
-- NULL 값에 대한 정렬
-- '-' 기호는 NULL을 제외한 정렬 기준을 뒤집는다.

-- 1) 오름차순(ASC) 시: NULL 값이 먼저 나옴
SELECT
		 *
  FROM tbl_category
 ORDER BY ref_category_code ASC;
 
 
-- 2) 내림차순(DESC) 시: NULL 값이 나중에 나옴
SELECT
		 *
  FROM tbl_category
 ORDER BY ref_category_code DESC;
 
 
-- 3) 오름차순에서 NULL이 나중에 나오도록 바꿈
SELECT
		 *
  FROM tbl_category
 ORDER BY -ref_category_code DESC;
--  (1) DESC를 통해 NULL을 나중으로 보냄
--  (2) '-'로 NULL이 아닌 값을 ASC로 바꿈


-- 4) 내림차순에서 NULL이 처음에 오도록 바꿈
SELECT
		 *
  FROM tbl_category
 ORDER BY -ref_category_code ASC;
--  (1) ASC를 통해 NULL을 처음으로 보냄
--  (2) '-'로 NULL이 아닌 값을 DESC로 바꿈