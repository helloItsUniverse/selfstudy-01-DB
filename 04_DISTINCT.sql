-- -----------------------------------------------------
-- DISTINCT
-- 중복된 행을 날림
-- 메뉴가 존재하는 카테고리의 종류를 뽑을 때 Distinct를 쓸 수 있다.
-- 다중열의 값들이 모두 동일하면 중복된 것으로 판별한다.
-- -----------------------------------------------------


-- 단일 열 선택하는 경우
SELECT
		 category_code
  FROM tbl_menu
 ORDER BY 1;

SELECT
		 DISTINCT category_code
  FROM tbl_menu
 ORDER BY category_code;

SELECT
		 DISTINCT category_code
  FROM tbl_menu
 ORDER BY 1;




-- DISTINCT 사용 시에는 일반 column을 사용할 수 없다.
-- (DISTINCT가 무의미 해지기 때문)
SELECT
		 DISTINCT category_code
	  , menu_name
  FROM tbl_menu;



-- NULL이 있는 경우
SELECT
		 ref_category_code
  FROM tbl_category;
  
SELECT
		 DISTINCT ref_category_code
  FROM tbl_category;
  
  
-- NULL값을 맨 아래로 보내고 싶다면?

-- method 1)
SELECT
		 DISTINCT ref_category_code
  FROM tbl_category
 ORDER BY 1 DESC;
 
-- method 2) 별칭을 활용
--                      
-- DISTINCT를 사용할 때
-- 기본 정렬의 개념(순번이나 별칭을 사용하는 않고는 정렬할 수 없다)은
-- syntax error 가 발생한다

-- -- ERROR 발생 쿼리
SELECT
		 DISTINCT ref_category_code
  FROM tbl_category
 ORDER BY DISTINCT ref_category_code DESC;

-- ---------------------------------------
-- 별칭 사용하면 가능 (이게 정석)
-- ---------------------------------------
SELECT
		 DISTINCT ref_category_code AS 'rcc'
  FROM tbl_category
 ORDER BY -rcc DESC;
-- ---------------------------------------
-- ---------------------------------------



-- ---------------------------------------
-- column 두개 이상도 distinct로 묶을 수는 있지만
-- 안좋은 형태의 코드이다 (닌자 코드)
-- 돌아가긴 함
-- column 두개 이상일 때는 이후 배울 GROUP BY 절을 통해 중복 제거를 하자.
SELECT
		 DISTINCT category_code, orderable_status
  FROM tbl_menu;


-- 예시
-- ---------------------------------
-- name		blood_type	Duplicated?
-- 홍길동	A				No
-- 유관순	B				YES
-- 강감찬	O				NO
-- 홍길동	B				NO
-- 유관순	B				YES