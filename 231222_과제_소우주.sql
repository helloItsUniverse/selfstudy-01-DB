-- ***************************************
-- <JOIN 미사용 연습문제>                 
-- ***************************************


-- 1. 모든 사원 모든 컬럼 조회
SELECT
		 *
  FROM employee;

  
-- 2. 사원들의 사번(사원번호), 이름 조회
SELECT
		 EMP_ID
	  , EMP_NAME
  FROM employee;
  
  
-- 3. 201번 사번의 사번 및 이름 조회
SELECT
		 EMP_NAME
  FROM employee
 WHERE EMP_ID = 201;

 
-- 4. employee 테이블에서 부서 코드가 'D9'인 사원 조회
SELECT
		 EMP_NAME
  FROM employee
 WHERE DEPT_CODE = 'D9';
 
 
-- 5. employee 테이블에서 직급 코드가 'J1'인 사원 조회
SELECT
		 EMP_NAME
  FROM employee
 WHERE JOB_CODE = 'J1';
 
 
-- 6. employee 테이블에서 급여가 300만원 이상(>=)인 사원의
-- 사번, 이름, 부서코드, 급여를 조회하시오.
SELECT
		 EMP_ID
	  , EMP_NAME
	  , DEPT_CODE
	  , SALARY
  FROM employee
 WHERE SALARY >= 3000000;


-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는
-- 직원의 이름, 부서코드, 급여 조회
SELECT
		 EMP_NAME
	  , DEPT_CODE
	  , SALARY
  FROM employee
 WHERE DEPT_CODE = 'D6'
   AND SALARY > 3000000;


-- 8. 보너스를 받지 않는 사원에 대한
-- 사번, 직원명, 급여, 보너스를 조회
SELECT
		 EMP_ID
	  , EMP_NAME
	  , SALARY
	  , BONUS
  FROM employee
 WHERE BONUS IS NULL;
 
 
-- 9. 'D9' 부서에서 근무하지 않는 사원의
-- 사번, 이름, 부서코드를 조회
SELECT
		 EMP_ID
	  , EMP_NAME
	  , DEPT_CODE
  FROM employee
 WHERE NOT DEPT_CODE = 'D9';
 
 
-- 10. employee 테이블에서 퇴사 여부가 N인 직원들 조회하고
-- 사번, 이름, 입사일을 별칭을 사용해 조회해 보기
-- (퇴사 여부 컬럼은 ENT_YN이고 N은 퇴사 안한 사람, Y는 퇴사 한 사람)
SELECT
		 EMP_ID AS '사번'
	  , EMP_NAME AS '이름'
	  , HIRE_DATE AS '입사일'
  FROM employee
 WHERE ENT_YN = 'N';


-- 11. employee 테이블에서 급여 350만원 이상
-- 550만원 이하를 받는 직원의
-- 사번, 이름, 급여, 부서코드, 직급코드를 별칭을 사용해 조회해 보기
SELECT
		 EMP_ID AS '사번'
	  , EMP_NAME AS '이름'
	  , SALARY AS '급여'
	  , DEPT_CODE AS '부서코드'
	  , JOB_CODE AS '직급코드'
  FROM employee
 WHERE SALARY BETWEEN 3500000 AND 5500000;

 
-- 12. employee 테이블에서 '성이 김씨'인 직원의 사번, 이름, 입사일 조회
SELECT
		 EMP_ID AS '사번'
	  , EMP_NAME AS '이름'
	  , HIRE_DATE AS '입사일'
  FROM employee
 WHERE EMP_NAME LIKE '%김%';

 
-- 13. employee 테이블에서 '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
SELECT
		 EMP_ID AS '사번'
	  , EMP_NAME AS '이름'
	  , HIRE_DATE AS '입사일'
  FROM employee
 WHERE EMP_NAME NOT LIKE '김%';


-- 14. EMPLOYEE 테이블에서 '하'문자가 이름에 포함 된
-- 직원의 이름, 주민번호, 부서코드 조회
SELECT
		 EMP_NAME AS '이름'
	  , EMP_NO AS '주민번호'
	  , DEPT_CODE AS '부서코드'
  FROM employee
 WHERE EMP_NAME LIKE '%하%';
 
 
-- 15. 'J2'직급이면서 급여가 200만원 이상인 직원이거나
-- 'J7'직급인 직원의 이름, 급여, 직급코드 조회
SELECT
		 EMP_NAME AS '이름'
	  , SALARY AS '급여'
	  , JOB_CODE AS '직급코드'
  FROM employee
 WHERE (JOB_CODE = 'J2' AND SALARY >= 2000000)
    OR JOB_CODE = 'J7';

 
-- 16. 'J2'직급이거나 'J7'직급인 직원들 중에
-- 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT
		 EMP_NAME AS '이름'
	  , SALARY AS '급여'
	  , JOB_CODE AS '직급코드'
  FROM employee
 WHERE (JOB_CODE = 'J2' OR JOB_CODE = 'J7')
   AND SALARY >= 2000000;


-- 17. IN 연산자로 업그레이드
SELECT
		 EMP_NAME AS '이름'
	  , SALARY AS '급여'
	  , JOB_CODE AS '직급코드'
  FROM employee
 WHERE JOB_CODE IN ('J2', 'J7')
   AND SALARY >= 2000000;


-- ***************************************
-- <JOIN 사용 연습문제>                   
-- ***************************************

-- REFERENCE
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;
SELECT * FROM location;
SELECT * FROM national;
SELECT * FROM sal_grade;


-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1명)
SELECT
		 a.EMP_ID AS '사번'
	  , a.EMP_NAME AS '이름'
	  , b.DEPT_TITLE AS '부서명'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
 WHERE EMP_NAME LIKE '%형%';
 

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9명)
SELECT
		 a.EMP_NAME AS '사원명'
	  , c.JOB_NAME AS '직급명'
	  , a.DEPT_CODE AS '부서코드'
	  , b.DEPT_TITLE AS '부서명'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
 WHERE b.DEPT_TITLE LIKE '해외영업%';


-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8명)(INNER JOIN 결과)
SELECT
		 a.EMP_NAME AS '사원명'
	  , a.BONUS AS '보너스포인트'
	  , b.DEPT_TITLE AS '부서명'
	  , d.NATIONAL_NAME AS '근무지역명'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN location c ON (b.LOCATION_ID = c.LOCAL_CODE)
  JOIN national d ON (c.NATIONAL_CODE = d.NATIONAL_CODE)
 WHERE a.BONUS IS NOT NULL;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3명)
SELECT
		 a.EMP_NAME AS '사원명'
	  , c.JOB_NAME AS '직급명'
	  , b.DEPT_TITLE AS '부서명'
	  , e.NATIONAL_NAME AS '근무지역명'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
  JOIN location d ON (b.LOCATION_ID = d.LOCAL_CODE)
  JOIN national e ON (d.NATIONAL_CODE = e.NATIONAL_CODE)
 WHERE a.DEPT_CODE = 'D2';


-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20명)
SELECT
		 a.EMP_NAME AS '사원명'
	  , b.JOB_NAME AS '직급명'
	  , a.SALARY AS '급여'
	  , a.SALARY * NVL(a.BONUS, 0) -- 보너스 얼마인지
	  , a.SALARY * 12 * (1 + NVL(a.BONUS, 0)) AS '연봉' -- 보너스를 적용한 연봉
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
  JOIN sal_grade c ON (a.SAL_LEVEL = c.SAL_LEVEL)
 WHERE a.SALARY > c.MIN_SAL;

 
-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15명)
SELECT
		 a.EMP_NAME AS '사원명'
	  , b.DEPT_TITLE AS '부서명'
	  , c.LOCAL_NAME AS '지역명'
	  , d.NATIONAL_NAME AS '국가명'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN location c ON (b.LOCATION_ID = c.LOCAL_CODE)
  JOIN national d ON (c.NATIONAL_CODE = d.NATIONAL_CODE)
 WHERE c.NATIONAL_CODE IN ('KO', 'JP');
 

-- 7. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- self join 사용(60명)
SELECT
		 a.EMP_NAME AS '사원명'
	  , a.DEPT_CODE AS '부서코드'
	  , c.DEPT_TITLE AS '부서이름'
	  , b.EMP_NAME AS '동료이름'
  FROM employee a
  JOIN employee b ON (a.DEPT_CODE = b.DEPT_CODE)
  JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
 WHERE a.EMP_ID <> b.EMP_ID
 ORDER BY 1;
--  일 대 다수의 관계면 상위-하위 관계라고 할 수 있음.


-- 8. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8명)
SELECT
		 a.EMP_NAME AS '사원명'
	  , b.JOB_NAME AS '직급명'
	  , a.SALARY AS '급여'
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
 WHERE a.JOB_CODE IN ('J4', 'J7')
   AND a.BONUS IS NULL;


-- 9. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
SELECT
		 a.EMP_ID AS '사번'
	  , a.EMP_NAME AS '사원명'
	  , c.JOB_NAME AS '직급명'
	  , b.DEPT_TITLE AS '부서명'
	  , d.LOCAL_NAME AS '근무지역명'
	  , a.SALARY AS '급여'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
  JOIN location d ON (b.LOCATION_ID = d.LOCAL_CODE)
 WHERE c.JOB_NAME = '대리'
   AND d.LOCAL_NAME LIKE 'ASIA%';
   
-- join 은 순서가 매우 중요하다.
-- 직급이 없는 사원도 결과 셋에 포함시키려면 LEFT JOIN 을 사용해야 한다.
-- LEFT JOIN 을 한번 쓰기 시작하면 그 쿼리에서는 계속 LEFT JOIN 을 사용해야 한다.

-- 9번문제 정답 2명?




-- 직급이 차장이면서 '해외영업'팀에 근무하는 직원의
-- (1)이름, (2)부서명, (3)근무국가명, (4)보너스 포인트를 적용한 연봉을 조회하시오
SELECT
		 a.EMP_NAME AS '이름'
	  , b.DEPT_TITLE AS '부서명'
	  , e.NATIONAL_NAME AS '근무국가명'
	  , a.SALARY * 12 * (1 + IFNULL(a.BONUS, 0)) AS '연봉'
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
  JOIN location d ON (b.LOCATION_ID = d.LOCAL_CODE)
  JOIN national e ON (d.NATIONAL_CODE = e.NATIONAL_CODE)
 WHERE c.JOB_NAME = '차장'
   AND b.DEPT_TITLE LIKE '해외영업%';
   
-- SALARY 300만 이상, 500만 미만인 사원의 사번, 이름, 월급 조회
SELECT
		 a.EMP_ID AS 사번
	  , a.EMP_NAME AS 이름
	  , a.SALARY AS 월급
  FROM employee a
 WHERE a.SALARY >= 3000000
   AND a.SALARY < 5000000;
   
   
-- menudb
-- 메뉴 코드, 메뉴 이름, 카테고리 코드, 카테고리 이름 조회
-- 카테고리 코드 기준으로 오름차순 정렬
SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;

SELECT
		 b.menu_code AS '메뉴 코드'
	  , b.menu_name AS '메뉴 이름'
	  , a.category_code AS '카테고리 코드'
	  , a.category_name AS '카테고리 이름'
  FROM tbl_category a
  JOIN tbl_menu b ON (a.category_code = b.category_code)
 ORDER BY a.category_code ASC;