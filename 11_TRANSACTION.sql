-- ==========================
-- TRANSACTION               
-- ==========================

-- autocommit 비활성화
SET autocommit = 0;

START TRANSACTION;

INSERT
  INTO tbl_menu
VALUES
(
  NULL, '바나나해장국', 8500
, 4, 'Y'
);

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴1'
 WHERE menu_code = 5;

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴2'
 WHERE menu_code = 6;


SELECT * FROM tbl_menu; -- 이 시점에서 조회된 데이터는 실제 DB에 적용된 값이 아니다.
-- 실제 작업은 JAVA 단에서 이루어짐.
-- COMMIT;
ROLLBACK;

SELECT * FROM tbl_menu; -- ROLLBACK 또는 COMMIT 이후 SELECT한 것이 실제 DB에 적용된 값이다.
