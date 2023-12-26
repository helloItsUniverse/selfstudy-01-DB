-- 해석 순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY


-- 조회의 6가지 절을 모두 활용한 예제

-- SELECT : GROUP BY 절에서 group을 묶는 조건으로 활용한 컬럼만 조회
--          또는 그룹 함수를 통해 조회한다.

-- FROM : 테이블 또는 JOIN을 활용한 result set을 작성한다

-- WHERE : FROM절의 각 행마다 적용될 조건을 작성한다

-- GROUP BY : WHERE절까지 만족하는 행들에 대해 그룹이 될 컬럼을 작성한다.

-- HAVING : 그룹별로 적용한 조건을 GROUP BY에서 작성한 컬럼
--          또는 그룹 함수를 통해 조회한다.

-- ORDER BY : 제일 마지막에 해석되며 SELECT의 결과(result set)의 순번, 별칭, 컴럼명 등으로 오름차순 또는 내림차순 한다.


SELECT
		 category_code   -- 그룹을 묶은 컬럼을 제외한
	  , COUNT(*)        --                
	  , SUM(menu_price) -- 그룹함수만 가능
	  , AVG(menu_price) --                
  FROM tbl_menu
 WHERE category_code IS NOT NULL
 GROUP BY category_code
HAVING SUM(menu_price) >= 24000  -- 그룹의 조건 또는 그룹 함수의 조건
 ORDER BY 2;
 
-- COUNT explanaton
SELECT
		 category_code   
	  , COUNT(*)               -- 모든 행 갯수 세기
	  , COUNT(category_code)   -- category_code가 NULL이 아닌 행만 갯수 세기
	  , SUM(menu_price) 
	  , AVG(menu_price) 
  FROM tbl_menu
 WHERE category_code IS NOT NULL
 GROUP BY category_code
HAVING SUM(menu_price) >= 24000  -- 그룹의 조건 또는 그룹 함수의 조건
 ORDER BY 2;


-- ------------------------------------
-- 메뉴가 없는 가테고리까지 셀건지 구분해서 count 해 보기

SELECT
		 COUNT(*)
	  , COUNT(a.menu_name)
  FROM tbl_menu a
 RIGHT JOIN tbl_category b ON (a.category_code = b.category_code);
 
-- --------------------------------------
-- 함수의 종류

--  단일 행 함수
-- : 단일 행마다 적용되어 해애의 갯수만큰 결과가 나오는 함수
--   (NVL, IFNULL 등)

-- 그룹 함수
-- : 그룹마다 적용되어 그룹의 갯수만큼 결과가 나오는 함수
--   (COUNT, SUM, AVG 등)
--   단, GROUP BY 절이 없는 조회는 그룹 함수의 결과가 단일행(행 하나)이다.



-- --------------------------------------------------------------
-- ROLLUP
-- 중간 합계 및 최종 합계를 도출

-- GROUP BY에서 두 개 이상의 컬럼으로 그룹 형성 시
-- 앞의 컬럼을 기준으로 중간 합계가 나오게 된다.

SELECT
		 menu_price
	  , category_code
	  , SUM(menu_price)
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP;



CREATE TABLE sales (
    CODE INT AUTO_INCREMENT,
    YEAR VARCHAR(4),
    MONTH VARCHAR(2),
    product VARCHAR(50),
    amount DECIMAL(10, 2),
    PRIMARY KEY(CODE)
);

-- LPAD : L(left)
INSERT INTO sales (code, year, month, product, amount) VALUES
(null, '2023', LPAD('1', 2, '0'), 'Product A', 1000.00),
(null, '2023', LPAD('1', 2, '0'), 'Product B', 1500.00),
(null, '2023', LPAD('2', 2, '0'), 'Product A', 2000.00),
(null, '2023', LPAD('2', 2, '0'), 'Product B', 2500.00),
(null, '2023', LPAD('3', 2, '0'), 'Product A', 1200.00),
(null, '2024', LPAD('3', 2, '0'), 'Product B', 1700.00);

INSERT INTO sales
(
  CODE 
, YEAR
, MONTH
, product
, amount
)
VALUES
(
  NULL
, '2023'
, LPAD('1', 2, '0')
, 'Product A'
, 1000.00
),
(
  NULL
, '2023'
, LPAD('1', 2, '0')
, 'Product B'
, 1500.00
),
(
  NULL
, '2023'
, LPAD('2', 2, '0')
, 'Product A'
, 2000.00
),
(
  NULL
, '2023'
, LPAD('2', 2, '0')
, 'Product B'
, 2500.00
),
(
  NULL
, '2023'
, LPAD('3', 2, '0')
, 'Product A'
, 1200.00
),
(
  NULL
, '2024'
, LPAD('3', 2, '0')
, 'Product B'
, 1700.00
);



SELECT * FROM sales;


-- 연, 월, 상풍명을 모두 하나의 그룹으로 묶어
-- 연, 월, 중간 합계 및 전체 합계를 ROLLUP으로 구해보자.
SELECT
		 YEAR
	  , MONTH
	  , product
	  , SUM(amount) AS total_sales
  FROM sales
 GROUP BY YEAR, MONTH, product
  WITH ROLLUP;
