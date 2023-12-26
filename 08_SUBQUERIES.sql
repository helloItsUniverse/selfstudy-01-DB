-- ------------------------------------------
-- SUBQUERIES
-- ------------------------------------------

-- 유재식씨의 부서와 같은 부서에서 일하는 직원
SELECT * FROM employee;

-- 서브쿼리
SELECT dept_code FROM employee WHERE EMP_NAME = '유재식'; -- D6

-- 메인쿼리
SELECT * FROM employee WHERE dept_code = 'D6'; -- 유재식씨와 같은 부서에서 일하는 직원(본인 포함)


-- 서브쿼리를 포함한 메인쿼리
SELECT
		 *
  FROM employee
 WHERE dept_code = (SELECT dept_code -- 서브쿼리에는 컬럼을 엔터 이후 적는게 아니라 SELECT 바로 옆에 적어야 함.
                      FROM employee
                     WHERE EMP_NAME = '유재식');
   
-- 이와 같은 방법으로 유재식씨의 사번을 추출해서 해당 사원을 제거해보자
SELECT
       *
  FROM employee
 WHERE dept_code = (SELECT DEPT_CODE
 							 FROM employee
 							WHERE EMP_NAME = '유재식')
   AND EMP_ID <> (SELECT EMP_ID
   					  FROM employee
   					 WHERE emp_name = '유재식');
   					 
   					 
   					 
   					 
   					 
-- --------------------------------------
-- 상관서브쿼리
-- --------------------------------------

SELECT
		 AVG(menu_price)
  FROM tbl_menu
 WHERE category_code = 4;

-- 메뉴를 조회 시, 메뉴의 카테고리에 있는 메뉴들의 평균 가격보다 높은 메뉴만 조회 
-- 상관 서브쿼리, 단일 행 서브쿼리
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE a.menu_price > (SELECT AVG(b.menu_price)
 								 FROM tbl_menu b
 								WHERE b.category_code = a.category_code);
 								
 								
-- 메뉴 카테고리의 평균과 같은 가격의 메뉴를 조회
-- 상관 서브쿼리 안쓰고 다중 행 서브쿼리 씀
SELECT
		 *
  FROM tbl_menu a
 WHERE a.menu_price IN (SELECT AVG(b.menu_price) 
 								 FROM tbl_menu b
 								WHERE b.category_code = a.category_code
 								GROUP BY b.category_code);
 								


-- -------------------------------------
-- EXISTS
-- 메뉴가 있는 카테고리 조회
-- -------------------------------------
SELECT
		 category_code
     , category_name
  FROM tbl_category a
 WHERE EXISTS(SELECT 1
                FROM tbl_menu b
                WHERE b.category_code = a.category_code)
 ORDER BY 1;

-- -------------------------------------
-- 4번 카테고리를 메인 쿼리에서 where조건 판별 중 동작하는 서브쿼리
-- 카테고리를 가진 메뉴의 카테고리만 조회한 것

SELECT 
		 1
  FROM tbl_menu b
  WHERE b.category_code = 4;


-- -------------------------------------
-- JOIN을 활용하여 메뉴가 있는 카테고리 조회
-- -------------------------------------
SELECT
		 a.category_code
	  , a.category_name
  FROM tbl_category a
  JOIN tbl_menu b ON (a.category_code = b.category_code)
 GROUP BY a.category_code, a.category_name
 ORDER BY 1;
 
-- INNER JOIN하면 category 의 null 값이 모두 없어짐
-- 



-- 예제 1. 가장 높은 급여를 받는 사원 조회하기 - MAX(column_name)
SELECT
		 a.EMP_NAME AS 이름
	  , MAX(a.SALARY) AS 급여
  FROM employee a;
  
SELECT
		 *
  FROM employee
 WHERE salary = (SELECT MAX(salary)
						 FROM employee);

-- 예제 2. 평균 급여가 가장 높은 부서 조회하기 - AVG(column_name), MAX(column_name), MAX(AVG(column_name))

-- 단일 열 다중 행
SELECT
		 b.DEPT_TITLE
	  , AVG(SALARY)
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
 GROUP BY a.DEPT_CODE;

SELECT * FROM employee;

-- 단일 열 다중 행에 단일 열 단일 행 서브쿼리를 붙임
SELECT
		 MAX(sal_avg)
  FROM (SELECT AVG(salary) sal_avg  -- 연산 식에 대한 컬럼은 웬만하면 이런 식으로 별칭을 달아줘야 한다.
  			 FROM employee
  			GROUP BY dept_code) a;

-- 메인 쿼리
SELECT 
		 a.DEPT_CODE
	  , b.DEPT_TITLE
  FROM employee a 
  JOIN department b ON(a.DEPT_CODE = b.DEPT_ID)
 GROUP BY a.DEPT_CODE
HAVING AVG(salary) = (SELECT MAX(c.sal_avg)
							   FROM (SELECT AVG(salary) sal_avg
							   		  FROM employee 
							   		 GROUP BY DEPT_CODE) c);


-- 직급별 가장 높은 급여를 조회하시오
-- 표시 : 직급 이름, 가장 높은 급여

SELECT
		 b.JOB_NAME AS 직급
	  , MAX(a.SALARY) AS 가장 높은 급여
	  , MIN(a.SALARY) AS 가장 낮은 급여
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
 GROUP BY a.JOB_CODE;


-- 서브쿼리를 사용하여 '송은희'와 같은 직급인 사원들을 조회하시오
-- 표시 : 사원명, 직급 이름, 부서 이름
SELECT
		 a.EMP_NAME AS '사원명'
	  , b.JOB_NAME AS '직급'
	  , c.DEPT_TITLE AS '부서'
  FROM employee a
  JOIN job b ON(a.JOB_CODE = b.JOB_CODE)
  JOIN department c ON(a.DEPT_CODE = c.DEPT_ID)
 WHERE b.JOB_CODE = (SELECT d.JOB_CODE
 							  FROM employee d
 							 WHERE d.EMP_NAME = '송은희');
 							 
-- 갈릭미역파르페와 같은 카테고리 코드를 가진 메뉴들을 조회하여라.
-- 표시 : 메뉴 이름, 카테고리 코드
SELECT
		 a.menu_name AS '메뉴 이름'
	  , a.category_code AS '카테고리 코드'
  FROM tbl_menu a
  JOIN tbl_category b ON(a.category_code = b.category_code)
 WHERE a.category_code = (SELECT c.category_code
 									 FROM tbl_menu c
 									WHERE c.menu_name = '갈릭미역파르페');

-- ALL을 활용한 방법
-- 서브쿼리 중에 다중행 서브쿼리인 경우에는 비교 연산자가 일반 비교연산자와 달라진다.
--    > ALL, < ALL, > ANY, < ANY, IN
-- 
-- 1. > ALL : 모든 서브쿼리 결과보다 크다
-- 2. < ALL : 모든 서브쿼리 결과보다 작다
-- 3. > ANY : 서브쿼리 결과 중 최소 하나보다는 크다(서브쿼리의 최소값보다 크다)
-- 4. < ANY : 서브쿼리 결과 중 최대 하나보다는 작다(서브쿼리의 최대값보다 작다)
-- 5. IN : 서브쿼리 결과 중에 하나라도 일치한다.
SELECT
		 dept_code
	  , AVG(salary)
  FROM employee
 GROUP BY dept_code
HAVING AVG(salary) >= ALL (SELECT AVG(salary)
 									  FROM employee
 									 GROUP BY dept_code);

-- 이번엔 반대 로... 급여 평균이 가장 낮은 부서?
-- result set : 부서코드, 부서이름, 평균 급여
SELECT
		 a.DEPT_CODE AS '부서 코드'
	  , b.DEPT_TITLE AS '부서 이름'
	  , AVG(a.SALARY) AS '평균 급여'
  FROM employee a
  JOIN department b ON(a.DEPT_CODE = b.DEPT_ID)
 GROUP BY a.DEPT_CODE
HAVING AVG(a.SALARY) <= ALL (SELECT AVG(c.SALARY)
										 FROM employee c
									   GROUP BY c.DEPT_CODE);
									   
-- ALL 없이?

SELECT
		 a.DEPT_CODE
	  , b.DEPT_TITLE
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
 GROUP BY a.DEPT_CODE
HAVING MIN(AVG(a.SALARY))