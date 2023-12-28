-- ====================
-- CONSTRAINT 제약조건 
-- ====================

-- --------------------
-- 1. NOT NULL
-- --------------------

DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- USER_ID 를 NULL 로 했을 경우 ERROR
INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, NULL, 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_notnull;



-- --------------------
-- 2. UNIQUE
-- --------------------

DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE (phone)
) ENGINE=INNODB;

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- 전화번호 중복 (에러)
INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', '강감찬', '남', '010-777-7777', 'yu77@gmail.com');

SELECT * FROM user_unique;


-- -------------------------
-- 3. PRIMARY KEY 제약 조건
-- -------------------------
-- 테이블에서 한 행의 정보를 찾기 위해 사용 할 컬럼을 의미한다.
-- 테이블에 대한 식별자 역할을 한다.(한 행씩 구분하는 역할을 한다.)
-- NOT NULL + UNIQUE 제약조건의 의미
-- 한 테이블당 한 개만 설정할 수 있음
-- 컬럼 레벨, 테이블 레벨 둘 다 설정 가능함
-- 한 개 컬럼에 설정할 수도 있고, 여러 개의 컬럼을 묶어서 설정할 수도 있음(복합키)
-- 복합키는 테이블 레벨에서만 달 수 있음.
-- 예시: PRIMARY KEY(menu_code, order_code)


DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (user_no)
) ENGINE=INNODB;

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');



-- User number 에 NULL 넣으면 에러
INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(null, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

-- User number 에 중복값 적용하면 에러
INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com');

SELECT * FROM user_primarykey;







-- -------------------------
-- 4. FOREIGN KEY(FK) 제약 조건
-- -------------------------

-- https://mariadb.com/kb/en/foreign-keys/

-- 참조 무결성을 위배하지 않기 위해 사용
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- FOREIGN KEY 제약조건에 의해서 테이블 간의 관계(RELATIONSHIP)가 형성 됨
-- 제공되는 값 외에는 NULL을 사용할 수 있음
-- 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기1(부모 테이블)

-- FOREIGN KEY 에는 관계맺는 테이블(부모 테이블)의 데이터 + NULL 까지만 들어갈 수 있다.
-- 부모 테이블이 존재해야 FOREIGN KEY가 있을 수 있다. (일대 다 의 개념)

-- 4-1. 회원등급 부모 테이블
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT NOT NULL UNIQUE, -- = PRIMARY KEY
    grade_name VARCHAR(255) NOT NULL
) ENGINE=INNODB;

INSERT 
  INTO user_grade
VALUES 
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;




-- -------------------------
-- 4-2. 이후에 회원 자식 테이블 생성
-- 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기2
-- (자식 테이블 - DELETE 삭제룰 없을 시 )
-- -------------------------
DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code) REFERENCES user_grade (grade_code)
	 -- user_grade(부모 테이블)의 grade_code 를 참고하겠다는 뜻
	 -- 이렇게 해야 JOIN이 가능 	 
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey1;

-- foreign key 제약조건 에러 발생(참조 컬럼에 없는 값(50) 적용)
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);

-- 자식 테이블에 FOREIGH KEY 제약 조건 컬럼에 NULL 값으로 INSERT
-- 자식 테이블에는 부모 테이블의 데이터 + NULL 까지만 들어갈 수 있다.
-- ERROR 발생 안함
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', NULL);

SELECT * FROM user_foreignkey1;

-- -------------------------
-- 5. 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기3
-- (자식 테이블 - DELETE 삭제룰 있을 시 )
-- -------------------------
DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code) 
		REFERENCES user_grade (grade_code)
        ON UPDATE SET NULL -- UPDATE 룰
        ON DELETE SET NULL -- DELETE 룰
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

-- 부모 테이블에서 우수 회원 등급 삭제
SELECT * FROM user_grade;
DELETE FROM user_grade WHERE grade_code = 20;
-- user_foreignkey1 테이블은 삭제 룰을 적용하지 않고 20을 참조한 데이터가 있다.
-- 그래서 에러 뜨는 것.
DELETE FROM user_foreignkey1 WHERE 1 = 1;

SELECT * FROM user_foreignkey2;
DELETE FROM user_grade WHERE grade_code = 20;
-- user_foreignkey2 는 삭제룰(부모테이블에서 FK를 DELETE시 NULL 로 대체되게 하는 룰)
-- 이 있으므로 '20' 이 NULL 로 바뀐 것을 확인할 수 있다.
SELECT * FROM user_foreignkey2;


-- 부모 테이블에 새로운 등급 추가
INSERT
  INTO user_grade
VALUES (40, 'Emerald 회원');

-- NULL값으로 변화된 자식 테이블의 행들을 새로 추가한 회원 등급으로 업데이트
UPDATE user_foreignkey2
   SET grade_code = 40
 WHERE grade_code IS NULL;

-- 확인
SELECT * FROM user_foreignkey2;


-- 부모테이블을 함부로 건드리지 못한다.
-- 부모테이블을 건드리려면 자식테이블 생성 시 삭제룰을 적용해야 한다.


-- -------------------------
-- 6. CHECK 제약 조건(조건식을 활용한 구체적인 제약조건)
-- CHECK 제약 조건 위반시 허용하지 않는 제약조건
-- 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기
-- -------------------------

DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남', '여')),
    age INT CHECK (age >= 19)
) ENGINE=INNODB;

INSERT 
  INTO user_check
VALUES 
(null, '홍길동', '남', 25),
(null, '이순신', '남', 33);

SELECT * FROM user_check;


-- gender 컬럼의 CHECK 제약 조건 에러 발생
-- (성별이 중성)
INSERT
  INTO user_check
VALUES (NULL, '아메바', '중', 19);

-- 나이에 잘못된 값 입력해보기
INSERT
  INTO user_check
VALUES (NULL, '유관순', '여', 16);





-- -------------------------
-- 7. DEFAULT 제약 조건
-- 컬럼에 null 대신 기본 값 적용
-- 컬럼 타입이 DATE일 시 current_date만 가능
-- 컬럼 타입이 DATETIME일 시 current_time과 current_timestamp, now() 모두 사용 가능
-- 제약조건 확인용 테이블 생성 및 테스트 데이터 INSERT 후 조회하기
-- -------------------------
DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (current_date),
    add_time DATETIME DEFAULT (current_time)
) ENGINE=INNODB;

SELECT * FROM tbl_country;

-- default 설정이 되어 있는 컬럼들에 default 값이 들어가도록 INSERT 진행 후 조회
INSERT 
  INTO tbl_country
VALUES (NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

-- insert시 default 설정된 컬럼을 무시하고 insert하면 NULL 이 아닌 default 로 초기 세팅된 값이 들어간다.
INSERT
  INTO tbl_country
(country_code)
VALUES
(NULL);

-- AUTO_INCREMENT 라서 NULL 을 넣어도 문제 없이 돌아감.
SELECT * FROM tbl_country;

-- TRUNCATE tbl_country;