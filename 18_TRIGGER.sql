-- ===============================
-- TRIGGER                        
-- ===============================

-- 세팅된 이벤트를 자동으로 발생시키는 것

-- 이력 테이블은 UPDATE 가 되는 테이블
-- 내역 테이블은 INSERT 만 되는 테이블

-- INSERT 가 발생하면 이후 작업이 자동으로 진행되도록 세팅해놓은 객체가 TRIGGER

SELECT * FROM tbl_country;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;






-- 메뉴 츄가 시 update 자동화 trigger 만들기


-- 주문 메뉴(tbl_order_menu) 테이블에 INSERT가 되고 나서 주문(tbl_order) 테이블의 총 합계가 UPDATE 될 수 있는 트리거 생성
DELIMITER //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW
BEGIN
    UPDATE tbl_order
    SET total_order_price = total_order_price + NEW.order_amount * (SELECT menu_price FROM tbl_menu WHERE menu_code = NEW.menu_code)
    WHERE order_code = NEW.order_code;
END//      

DELIMITER ;


-- 주문 테이블(tbl_order)에 INSERT 후
-- 주문 메뉴 테이블(tbl_order_menu)에 주문한 메뉴마다 INSERT 후 주문 테이블에 총 금액이 UPDATE 되는지 확인하자.

-- 주문 테이블 INSERT
INSERT
  INTO tbl_order
(
  order_code
, order_date
, order_time
, total_order_price
)
VALUES
(
  NULL
, CONCAT(CAST(YEAR(NOW()) AS VARCHAR(4))
	    , CAST(LPAD(MONTH(NOW()), 2, 0) AS VARCHAR(2))
	    , CAST(LPAD(DAY(NOW()), 2, 0) AS VARCHAR(2)))
, CONCAT(CAST(LPAD(HOUR(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(MINUTE(NOW()), 2, 0) AS VARCHAR(2))
       , CAST(LPAD(SECOND(NOW()), 2, 0) AS VARCHAR(2)))
, 0			
);

SELECT * FROM tbl_order; -- INSERT 됐는지 확인


-- 주문 메뉴 테이블 INSERT 1
INSERT
  INTO tbl_order_menu
(
  order_code
, menu_code
, order_amount
)
VALUES
(
  1
, 3
, 2
);

-- 주문 메뉴 테이블 INSERT 2
INSERT
  INTO tbl_order_menu
(
  order_code
, menu_code
, order_amount
)
VALUES
(
  1
, 6
, 3
);

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;tbl_menu

-- 다시 되돌려 테스트 해보고자 할 경우
-- 1) rollback하기
ROLLBACK;
-- 2) 기존 데이터 지우기
DELETE FROM tbl_order WHERE 1 = 1;
DELETE FROM tbl_order_menu WHERE 1 = 1;

-- 이후 AUTO_INCREMENT도 다시 초기화 해 준다.
ALTER TABLE tbl_order AUTO_INCREMENT = 1;





