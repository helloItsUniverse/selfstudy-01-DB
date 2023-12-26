-- WHERE 절이 있는 쿼리의 실행 순서
-- 1. FROM
-- 2. WHERE
-- 3. SELECT

SELECT
		 menu_name
	  , menu_price
	  , orderable_status
  FROM tbl_menu
 WHERE orderable_status = 'Y';



--  클라이언트 : 주문 불가능한 메뉴 조회(메뉴명, 메뉴코드) 하게 해주세요
--  : orderable_status = 'N' 인 행들 조회하기

SELECT
		 menu_name
	  , menu_code
	  , orderable_status -- 검증용
  FROM tbl_menu
 WHERE orderable_status = 'N';


-- DESC(describe)를 통한 column명 빠르게 확인
DESC tbl_menu;




-- -------------------------------------------
-- '기타'카레고리에 해당하지 않는 메뉴를 조회하시오

-- 1) '기타' 카테고리의 번호 파악하기
SELECT * FROM tbl_category WHERE category_name = '기타';
-- category_code = 10 임을 알아냄

-- 2) 해당 번호를 가지지 않는 메뉴 조회
SELECT * FROM tbl_menu WHERE category_code != 10;
SELECT * FROM tbl_menu WHERE category_code <> 10;



-- ----------------------------------------------------------

-- 10,000원 이상의 메뉴 조회
SELECT * FROM tbl_menu WHERE menu_price >= 10000;

-- 10,000원 미만의 메뉴 조회
SELECT * FROM tbl_menu WHERE menu_price < 10000;


-- 10,000원 이상 12,000원 이하 메뉴 조회

-- 1) AND 를 사용하는 경우
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price >= 10000
 	AND menu_price <= 12000;

-- 2) && 연산자 사용하는 경우 (ANSI 표준이 아니라 비추)
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price >= 10000
	 && menu_price <= 12000;
	 
-- -----------------------------------------------------
	 
-- 논리 연산자 (= 참과 거짓의 연산)


-- 예시 1)
-- 사랑스런 조카가 타고 싶은 롤러 코스터는
-- 7세 이상, 100cm 이상만 가능
-- (AND, 둘 다 만족, 이면서 그리고, 동시에)
SELECT
  FROM nephew
 WHERE age >= 7
   AND height >= 100;

-- 예시 2)
-- 내 친구는 콜라도 좋아하고 사이다도 상관 없다. (콜라 또는 사이다)
-- (OR, 둘 중에 아무거나, 이거나, 또는)
SELECT
  FROM friend
 WHERE beverage = 'coke'
    OR beverage = 'sprite';
    
-- -----------------------------------------------------
DESC tbl_menu;
DESC tbl_category;
DESC tbl_order;




SELECT
		 *
  FROM tbl_menu
 WHERE orderable_status = 'Y'
    OR category_code = 10
 ORDER BY category_code;
 
 
 
--  -------------------------------------
-- AND 와 OR 를 통한 결과 비교
-- -------------------------------------
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price > 5000
 	AND category_code = 10;

SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price > 5000
 	 OR category_code = 10;
 	 
 	 

-- -----------------------------------
-- BETWEEN 연산자 활용하기
-- -----------------------------------

-- 가격이 5000원 이상, 9000원 이하인 메뉴 전체 컬럼 조회

SELECT
		 *
  FROM tbl_menu
 WHERE menu_price >= 5000
   AND menu_price <= 9000;


-- BETWEEN 활용
-- BETWEEN 바로 뒤에 적은 경계값이 포함되는 것을 확인할 수 있음.
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price BETWEEN 5000 AND 9000;




-- 반대의 범위로 테스트

SELECT
		 *
  FROM tbl_menu
 WHERE menu_price < 5000
    OR menu_price > 9000;


-- BETWEEN 활용
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price NOT BETWEEN 5000 AND 9000;



-- ----------------------------------------------------
-- LIKE 활용
-- 메뉴 중에 '밥'이 들어간 메뉴 조회
-- 검색 기능 구현할 때 실제로 씀
-- ----------------------------------------------------
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name LIKE '%밥%';
--  여기서 %는 '와일드카드'라는 것.


-- 밥이 안들어간 경우는?
SELECT
		 *
  FROM tbl_menu
 WHERE NOT menu_name LIKE '%밥%';
 
 
-- --------------------------------------
-- IN 연산자
-- --------------------------------------

SELECT * FROM tbl_category;

-- or 을 활용한 '중식', '커피', '기타' 카테고리의 메뉴 조회하기
SELECT
		 *
  FROM tbl_menu
 WHERE category_code = 5
	 OR category_code = 8
	 OR category_code = 10;

-- IN 연산자 활용
SELECT
		 *
  FROM tbl_menu
 WHERE category_code IN (5, 8, 10);
 
 
-- ---------------------------------------------- 
-- IS NULL 연산자 활용
-- ---------------------------------------------- 
SELECT * FROM tbl_category;

-- ref_category_code (상위 카테고리 번호) 가 없는 카테고리 조회
SELECT
		 *
  FROM tbl_category
 WHERE ref_category_Code IS NULL;
 
-- 반대도 해보자
SELECT
		 *
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL;



