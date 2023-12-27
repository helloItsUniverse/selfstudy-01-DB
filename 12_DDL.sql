-- =======================
-- DDL                    
-- =======================

CREATE TABLE IF NOT EXISTS tb1 (
    pk INT PRIMARY KEY, -- 컬럼 레벨에서 제약조건 추가
    fk INT, 
    col1 VARCHAR(255),  -- 모르겠으면 일단 VARCHAR 에 255 로 하자.
    CHECK(col1 IN ('Y', 'N')) -- 테이블 레벨에서 제약조건 추가
) ENGINE=INNODB;

DESC tb1;


-- 모든 테이블은 기본적으로 primary key 를 반드시 하나 가지고 있어야 함.

-- PRIMARY KEY = UNIQUE + NOT NULL

INSERT
  INTO tb1
VALUES
(
  1, 2, 'Y'
);

SELECT * FROM tb1; -- 확인용



-- ---------------------
DROP TABLE tb2; -- 잘못 만들었을 때 날리기

CREATE TABLE IF NOT EXISTS tb2 (
    pk INT PRIMARY KEY AUTO_INCREMENT, -- 행이 알아서 증가하는 컬럼
    fk INT, 
    col1 VARCHAR(255),  -- 모르겠으면 일단 VARCHAR 에 255 로 하자.
    CHECK(col1 IN ('Y', 'N')) -- 테이블 레벨에서 제약조건 추가
) ENGINE=INNODB;

DESC tb2;

INSERT
  INTO tb2
VALUES
(
  NULL, 2, 'Y'
);

SELECT * FROM tb2; -- 확인용

-- -------------------------------
-- ALTER TABLE                    
--                                
-- 문법: ALTER TABLE 테이블명 ADD 컬럼명 컬럼정의
-- -------------------------------
ALTER TABLE tb2 ADD col2 INT NOT NULL;
DESC tb2;

-- 컬럼 삭제
-- 문법: ALTER TABLE 테이블명
--       DROP COLUMN 컬럼명
ALTER TABLE tb2
DROP COLUMN col2;
DESC tb2;

-- 컬럼 이름 및 컬럼 정의(데이터 타입, 제약조건) 변경
-- 문법: ALTER TABLE 테이블명 CHANGE COLUMN 기존컬럼명 바꿀컬럼명 컬럼정의
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;
DESC tb2;


-- 제약조건 제거
ALTER TABLE tb2 DROP PRIMARY KEY; -- 에러 뜸

-- AUTO_INCREMENT 제거
ALTER TABLE tb2
MODIFY pk INT;
DESC tb2;

-- 다시 제약조건 제거
ALTER TABLE tb2 DROP PRIMARY KEY;
DESC tb2;



-- ------------------
-- TRUNCATE;
-- DROP 이후 테이블을 재생성
-- DELETE 보다 나음
-- AUTO_INCREMENT 시작 값도 0으로 초기화시켜주어 편하다
-- ------------------

-- tb6 테이블 생성
CREATE TABLE IF NOT EXISTS tb6 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;



-- 4개 행 데이터 INSERT
INSERT
  INTO tb6
VALUES
(NULL, 10, 'Y'),
(NULL, 20, 'Y'),
(NULL, 30, 'Y'),
(NULL, 40, 'Y');

-- 제대로 INSERT 되었는지 확인
SELECT * FROM tb6;

-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
TRUNCATE tb6;