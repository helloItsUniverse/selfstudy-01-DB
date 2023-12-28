-- =============================
-- Index                        
-- =============================

-- full scan 을 방지하여 조회 성능이 향상된다.
-- cardinality가 높은(중복값이 적은) 컬럼에 인덱스를 붙여서 성능을 높임.
-- 면접에서 거의 무조건 나옴


-- 인덱스(Index)는 데이터 검색 속도를 향상시키는 데이터 구조로 데이터를 빠르게 조회할 수 있는 포인터를 제공한다.
-- 데이터베이스에서 데이터를 찾을 때 전체 테이블을 검색하는 대신 인덱스를 통해 검색을 하므로 속도가 더 빨라지게 된다.
-- 인덱스는 주로 WHERE절의 조건이나 JOIN 연산에 사용되는 컬럼에 생성한다.
-- 다만 인덱스도 데이터 저장 공간을 차지하고 데이터가 변경될 때마다 인덱스 역시 갱신해야 하기 때문에 어떤 컬럼에 인덱스를 생성할지는 신중히 결정해야 한다.


-- PRIMARY KEY 제약조건을 지닌 기본 테이블 생성 후 기본 데이터 INSERT 후 조회
CREATE TABLE phone (
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT 
  INTO phone (phone_code , phone_name , phone_price )
VALUES 
(1, 'galaxyS23', 1200000),
(2, 'iPhone14pro', 1433000),
(3, 'galaxyZfold3', 1730000);

-- 단순 조회
SELECT * FROM phone WHERE phone_name = 'galaxyS23';


-- 인덱스가 없는 컬럼을 WHERE절의 조건으로 활용한 조회 진행 시 EXPLAIN으로 쿼리 실행 계획 확인
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';


-- phone_name 컬럼에 idx_name이라는 이름의 인덱스 생성 후 확인
CREATE INDEX idx_name ON phone (phone_name);

SHOW INDEX FROM phone;

-- 테이블에 인덱스가 설정 된 컬럼을 활용해 조회를 진행
SELECT * FROM phone WHERE phone_name = 'iPhone14pro';

-- 인덱스 추가 후 다시 해당 컬럼을 조건으로 해서 조회
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iPhone14pro';

-- 인덱스는 주기적으로 다시 달아주어야 된다.
OPTIMIZE TABLE phone;

-- 인덱스 삭제 후 확인
DROP INDEX idx_name ON phone;
SHOW INDEX FROM phone;