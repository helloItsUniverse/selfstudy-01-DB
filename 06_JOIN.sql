-- 다른 테이블끼리 관계를 맺는 것을 전제하고 그게 만족되는 경우
-- 그 테이블들끼리는 JOIN이 가능하다.
-- ---------------------------------------
-- JOIN
-- ---------------------------------------

DESC tbl_menu;
DESC tbl_category;

SELECT
		 *
  FROM tbl_menu JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;
--   JOIN절은 FROM절에 속해 있는 것이 맞으나 이렇게 적으면 coding convention에 맞지는 않음

SELECT
		 *
  FROM tbl_menu
  JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;


-- -------------------------
-- Join되는 여러 테이블들 중에 FROM 에 가까울 수록 우선순위를 갖는다.


-- ------------------
-- Join할 두 테이블 전체 조회
SELECT
		 *
  FROM tbl_menu;

SELECT
		 *
  FROM tbl_category;



-- 메뉴명과 카페고리명만 조회
SELECT
		 menu_name
	  , category_name
  FROM tbl_menu
  JOIN tbl_category ON (tbl_menu.category_code = tbl_category.category_code);

  
-- table name 도 별칭(alias)을 붙일 수 있다
SELECT
		 menu_name
	  , category_name
  FROM tbl_menu tm
  JOIN tbl_category tc ON (tm.category_code = tc.category_code); -- '.' 은 참조 연산자

-- ***********************************************************
-- 두 테이블에 같은 column명이 있는 상태에서 join 시 주의할 점
-- ***********************************************************
SELECT
		 menu_name
	  , category_name
  FROM tbl_menu tm
  JOIN tbl_category tc ON (category_code = category_code);
--   ambiguous error 뜸


SELECT
		 menu_name
	  , category_name
  FROM tbl_menu tm
  JOIN tbl_category tc ON (tm.category_code = tc.category_code);
-- 두 테이블이 동일한 컬럼명을 가질 시 별칭 필수




-- 그래서 되냐?

SELECT
		 menu_name
	  , category_name
	  , tm.category_code
  FROM tbl_menu tm
  JOIN tbl_category tc ON (tm.category_code = tc.category_code);
  
  
-- *************************************************
-- 관례 상 join 시에는 쿼리에 사용되는 모든 column에 alias를 다는 것을 원칙으로 한다.

-- alias 는 FROM 절 이후부터 나오는 테이블 순서대로 a, b, c, ... 이렇게 단다.

-- like this
SELECT
		 a.menu_name
	  , b.category_name
	  , a.category_code
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code);
-- *************************************************

SELECT
		 DISTINCT a.category_code
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code);
  

-- using 은 되도록 쓰지 말자
SELECT
		 a.menu_name
	  , b.category_name
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code);



-- *************************************************
-- 1) INNER JOIN: ON 또는 USING 뒤에 오는 JOIN의 조건을 만족하여 매칭되는 결과들만 JOIN됨
SELECT
		 *
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code)
 WHERE b.category_code = 7;  -- 조회 결과 없음 (7번 카테고리는 존재하지만 join에는 존재 x)
 
-- -------------------------------------------------
-- 2)  LEFT JOIN: JOIN 키워드 기준 왼쪽 테이블의 행이 모두 나오도록 JOIN
SELECT
		 *
  FROM tbl_menu a
  LEFT JOIN tbl_category b ON (a.category_code = b.category_code);

-- 카테고리가 없는 메뉴를 만들기 위해
-- a. 메뉴 카테고리에 null이 들어갈 수 있게 not null 제약 조건 해제
SELECT * FROM tbl_menu WHERE menu_code = 1;
ALTER TABLE tbl_menu CHANGE category_code category_code INTEGER DEFAULT NULL;
-- ALTER TABLE tbl_menu MODIFY COLUMN category_code INTEGER NOT NULL; -- NOT NULL로 재설정

-- b. 1번 메뉴의 메뉴 카테고리가 null로 변경 되게 설정
UPDATE tbl_menu
   SET category_code = 6
 WHERE menu_code = 1;
 
-- c. 1번 메뉴의 메뉴 카테고리가 없는 상태에서 inner join vs left join 비교하기   
SELECT
       *
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code);
  
SELECT
       *
  FROM tbl_menu a
  LEFT JOIN tbl_category b ON (a.category_code = b.category_code);





-- -------------------------------------------------
-- 3) RIGHT JOIN: JOIN 키워드 기준 오른쪽 데이블의 행이 모두 나오도록 JOIN
SELECT
		 *
  FROM tbl_menu a
 RIGHT JOIN tbl_category b ON (a.category_code = b.category_code);


-- -------------------------------------------------
-- 4) CROSS JOIN : CROSS JOIN 이 발생하면 실수했다는 증거
-- ON에 쓰는 join 조건을 잘못 썼을 가능성이 높다.

SELECT
		 *
  FROM tbl_menu
  JOIN tbl_category b ON (1=1);
--   모든 경우의 수를 나타냄

SELECT
		 *
  FROM tbl_menu
 CROSS JOIN tbl_category b;

-- -------------------------------------------------
-- 5)  SELF JOIN
-- self join은 하나의 테이블에 상위 개념과 하위 개념이 모두 들어있을 때
-- 자기 자신 테이블을 Join하게 되는 경우에 사용한다.
-- (ex. 신입사원 vs 사수,          
--  하위 카테고리 vs 상위 카테고리 
--  댓글 vs 대댓글 등             )

SELECT
		 *
  FROM tbl_category;

-- 한 테이블 안에 상위/하위 개념이 있는 것

SELECT
		 a.category_name
	  , b.category_name
  FROM tbl_category a
  JOIN tbl_category b ON (a.ref_category_code = b.category_code);
--   a: 자식 카테고리, b: 부모 카테고리

  


SELECT
		 *
  FROM employee;
  
SELECT
		 *
  FROM department;
  
SELECT
		 a.EMP_name
		 b.DEPT_TITLE
  FROM employee a
  JOIN department b ON (a.dept_code = b.dept_id);