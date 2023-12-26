-- -----------------------------
-- LIMIT 절은 SELECT문의 result set에서 행의 수를 제한하는 데 사용된다.
-- -----------------------------
-- 페이징 처리를 할 때 자주 씀

-- SELECT
-- 		 select_list
--   FROM table_name
--  LIMIT [offset,] row_count;

SELECT * FROM tbl_menu;

-- 1행부터 5개의 메뉴 행 조회
SELECT
		 *
  FROM tbl_menu
 LIMIT 0, 5;   -- lIMIT (시작인덱스), (시작인덱스부터 조회할 행의 개수)


-- 6행부터 5개의 메뉴 행 조회
SELECT
		 *
  FROM tbl_menu
 LIMIT 5, 5;
 
 
 
-- -------------------------------------
-- LIMIT의 offset 생략 시

SELECT
		 *
  FROM tbl_menu;

SELECT
		 *
  FROM tbl_menu
 LIMIT 5;
--  LIMIT을 자주 쓰진 않지만 이후 TOP-N 분석이나 Paging 처리를 할 때 사용된다.