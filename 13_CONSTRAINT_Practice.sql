-- 4-1. 회원등급 부모 테이블
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT, -- = PRIMARY KEY
    grade_name VARCHAR(255),
    PRIMARY KEY (grade_code, grade_name)
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
-- (자식 테이    grade_name VARCHAR(255),
    FOREIGN KEY (grade_code, grade_name) REFERENCES user_grade (grade_code, grade_name)
	 -- user_grade(부모 테이블)의 grade_code 를 참고하겠다는 뜻
	 -- 이렇게 해야 JOIN이 가능 	 
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code, grade_name)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10, '일반회원'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20, '우수회원');

SELECT * FROM user_foreignkey1;

-- foreign key 제약조건 에러 발생(참조 컬럼에 없는 값(50) 적용)
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', 50);

-- 자식 테이블에 FOREIGN KEY 제약 조건 컬럼에 NULL 값으로 INSERT
-- 자식 테이블에는 부모 테이블의 데이터 + NULL 까지만 들어갈 수 있다.
-- ERROR 발생 안함
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(3, 'user03', 'pass03', '이순신', '남', '010-777-7777', 'lee222@gmail.com', NULL);

SELECT * FROM user_foreignkey1;



-- ===========================================
-- 문제 만들기
-- ===========================================

DROP TABLE IF EXISTS user_foreignkey1;
DROP TABLE IF EXISTS user_foreignkey2;

-- 4-1. 회원등급 부모 테이블
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT PRIMARY KEY,  -- = PRIMARY KEY
    grade_name VARCHAR(255)
) ENGINE=INNODB;

INSERT 
  INTO user_grade
VALUES 
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;




DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
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
(NULL, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(NULL, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

SELECT
		 a.user_name
	  , b.grade_name
  FROM user_foreignkey2 a
  JOIN user_grade b ON(a.grade_code = b.grade_code)
 WHERE b.grade_name = '우수회원'





