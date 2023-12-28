-- ------------------------------------------------------------
-- 상품 입출고 관련 trigger 활용 예제
DROP TABLE pro_detail;
DROP TABLE product;


CREATE TABLE PRODUCT(           -- 이력 테이블(UPDATE가 발생하는 테이블)
  PCODE INT PRIMARY KEY auto_increment,
  PNAME VARCHAR(30),
  BRAND VARCHAR(30),
  PRICE INT,
  STOCK INT DEFAULT 0,
  CHECK(STOCK >= 0)
);

CREATE TABLE PRO_DETAIL(        -- 내역 테이블(INSERT가 발생하는 테이블)
  DCODE INT PRIMARY KEY auto_increment,
  PCODE INT,
  PDATE DATE,
  AMOUNT INT,
  STATUS VARCHAR(10) CHECK(STATUS IN ('입고', '출고')),
  FOREIGN KEY(PCODE) REFERENCES PRODUCT  -- 어차피 해당 테이블의 PK컬럼에 대한 외래키이므로 PK컬럼은 적지 않아도 된다.(알아서 인식함)
);

INSERT
  INTO PRODUCT
(
  PCODE, PNAME, BRAND
, PRICE, STOCK
)
VALUES
(
  null, '갤럭시플립', '삼송'
, 900000, 5
);

INSERT
  INTO PRODUCT
(
  PCODE, PNAME, BRAND
, PRICE, STOCK
)
VALUES
(
  null, '아이펀 14', '애펄'
, 1000000, 5
);

INSERT
  INTO PRODUCT
(
  PCODE, PNAME, BRAND
, PRICE, STOCK
)
VALUES
(
  null, '투명폰 3', '헬쥐'
, 1000000, 5
);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

INSERT
  INTO PRO_DETAIL
(
  DCODE, PCODE, PDATE
, AMOUNT, STATUS
)
VALUES
(
  null, 1, CURDATE()
, 5, '입고'
);

INSERT
  INTO PRO_DETAIL
(
  DCODE, PCODE, PDATE
, AMOUNT, STATUS
)
VALUES
(
  null, 2, CURDATE()
, 2, '출고'
);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

-- -------------------------------------------------------------
DELIMITER //
CREATE OR REPLACE TRIGGER TRG_PRODUCTAFTER 
AFTER INSERT 
ON PRO_DETAIL
FOR EACH ROW
BEGIN
  IF NEW.STATUS = '입고' THEN
    UPDATE PRODUCT A
       SET A.STOCK = A.STOCK + NEW.AMOUNT
     WHERE A.PCODE = NEW.PCODE;
  ELSEIF NEW.STATUS = '출고' THEN
    UPDATE PRODUCT A 
       SET A.STOCK = A.STOCK - NEW.AMOUNT
     WHERE A.PCODE = NEW.PCODE;
  END IF;
END;
//
DELIMITER ;
-- -------------------------------------------------------------