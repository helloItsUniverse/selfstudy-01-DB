-- tbl_menu 로부터 그 안에 있는 3가지 속성을 선택
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	FROM tbl_menu;

DESC tbl_category;

SELECT 
		 category_code
	  , category_name
	  , ref_category_code
	FROM tbl_category;
	
SELECT
		 menu_name
	  , category_name
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code);

-- ------------------------------------------------------------

SELECT 7 + 3;
SELECT 10 * 2;
SELECT 6 % 3, 6 % 4; -- 나머지 연산자 (modulus)
SELECT NOW();
SELECT CONCAT('유', ' ', '관순');

-- alias
SELECT 7 + 3 AS '합', 10 * 2 AS '곱';

-- 별칭 달아보기
SELECT 7 + 3 합, 10 * 2 곱; -- 어느 정도의 문자는 그냥 AS 없이도 자동으로 인식함
SELECT 7 + 3 '합 입니다.', 10 * 2 '곱 입니다.';
SELECT NOW() AS '현재시간';
SELECT CONCAT('유', ' ', '관순');

-- 특수기호가 들어간 별칭은 싱글 쿼테이션(')이 반드시 필요하다 
-- ERROR 뜸
-- SELECT 7 + 3 합 입니다., 10 * 2 곱 입니다.;


--  ------------------------------------------------------------