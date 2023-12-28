-- ****************************
-- VIEW                        
-- ****************************

-- 가상테이블. 실제로는 쿼리만 들고 있다
-- 캡쳐 뜨는 느낌

SELECT
		 menu_name
	  , menu_price
  FROM tbl_menu;

CREATE OR REPLACE VIEW v_menu
AS
SELECT
		 menu_name '메뉴이름'
	  , menu_price '메뉴가격'
  FROM tbl_menu;

SELECT * FROM v_menu;

-- VIEW 는 원본 테이블을 참조해서 보여주는 용도이고
-- 실제 보여지는 건 원본 테이블의 데이터이다.

-- 증명을 위해 원본인 tbl_menu의 11번 메뉴 가격을 10원으로 수정해보자.
UPDATE tbl_menu
   SET menu_price = 10
 WHERE menu_code = 11;

-- v_menu(뷰)로 확인해보자
SELECT 메뉴이름 FROM v_menu;
-- 뷰 생성 시 별칭으로 생성했다면
-- 뷰를 통한 조회는 별칭으로만 가능하다.
-- 원본 데이터의 은닉화

-- 데이터가 자주 바뀌는 경우에는 VIEW 를 쓰지 않는게 좋다.


-- ===========================================================
-- view를 통한 DML
-- 그러나 실제로는 view 를 통해서 insert, update, delete 는 절대 하면 안된다.
-- ===========================================================

SELECT * FROM tbl_menu;

-- VIEW 생성
CREATE OR REPLACE VIEW hansik AS
SELECT 
       menu_code 
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu 
 WHERE category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;



-- INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT 
  INTO hansik
VALUES (99, '수정과맛국밥', 5500, 4, 'Y');   
SELECT * FROM hansik;
SELECT * FROM tbl_menu;


-- 추가한 베이스 테이블 값 업데이트
UPDATE hansik
   SET menu_name = '버터맛국밥', menu_price = 5700 
 WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- VIEW를 통한 DELETE 이후 VIEW 조회 및 베이스 테이블 조회
DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- VIEW 삭제
DROP VIEW hansik;