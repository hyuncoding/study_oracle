SELECT * FROM EMPLOYEES;

-- 여러 개의 컬럼을 바탕으로 정렬할 경우, 앞에 컬럼 순서로 정렬된 후
-- 겹치는 경우에는 뒷 컬럼 순서로 정렬된다.
SELECT FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE 
FROM EMPLOYEES
ORDER BY SALARY, HIRE_DATE DESC;
-- 하나는 DESC 로도 사용가능.

-- 회사에 존재하는 직급(JOB_ID) 조회하기
-- DISTINCT : 해당 컬럼에서 중복되는 값을 제외시킨다.
SELECT DISTINCT JOB_ID FROM EMPLOYEES;

-- 여러 컬럼을 동시에 작성할 경우 두 개의 컬럼이 모두 중복되는 경우에만 중복처리한다.
SELECT DISTINCT JOB_ID, HIRE_DATE FROM EMPLOYEES;

-- 정렬 기준으로 삼은 컬럼을 꼭 조회할 필요는 없다.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
ORDER BY SALARY;

-- 테이블 컬럼명을 별칭(별명)으로 설정하기
SELECT FIRST_NAME AS "이름", 
	LAST_NAME AS "성", 
	SALARY AS "봉급", 
	EMPLOYEE_ID AS "사원 번호" 
FROM EMPLOYEES;

-- AS (ALIAS) 생략 가능
-- "" 생략 가능
-- 만일 별명에 띄어쓰기가 포함되어 있다면 "" 생략 불가능
SELECT FIRST_NAME 이름, 
	LAST_NAME 성, 
	SALARY 봉급, 
	EMPLOYEE_ID "사원 번호" 
FROM EMPLOYEES
ORDER BY 봉급;

--================================================================
-- 연산자

-- DUAL 테이블 : 다른 테이블을 참조할 필요가 없이
-- 값을 확인하고 싶을 때 사용할 수 있는 테이블
-- (오라클에서 지원해 준다.)
SELECT 10 || 20
FROM DUAL;
-- 결과는 1020 (문자)

SELECT '나는 ' || '볼링치고 싶다'
FROM DUAL;

SELECT FIRST_NAME || LAST_NAME 성함
FROM EMPLOYEES;

SELECT HIRE_DATE || '사랑해'
FROM EMPLOYEES;

-- [실습]
/* 사원의 이름과 메일주소를 출력하기
 * 이 때 이름은 FIRST_NAME 과 LAST_NAME 이 띄어쓰기로 이어져있고,
 * 메일 주소는 사원메일주소@koreait.com 이다.
 */

SELECT FIRST_NAME || ' ' || LAST_NAME 이름, 
	EMAIL || '@koreait.com' "메일 주소"
FROM EMPLOYEES;

-- 산술연산자
SELECT EMPLOYEE_ID,
	EMPLOYEE_ID + 10,
	EMPLOYEE_ID - 10,
	EMPLOYEE_ID * 2,
	EMPLOYEE_ID / 2
FROM EMPLOYEES;

-- [실습]
/* 직원의 이름, 봉급, 인상 봉급, 감축 봉급을 조회하기
 * 이름은 성과 함께 띄어쓰기로 연결되어 있다.
 * 인상 봉급은 기존 봉급의 10% 증가되었고
 * 감축 봉급은 기존 봉급의 10% 감소되었다.
 * 결과를 기존 봉급 오름차순으로 정렬하여 조회한다.
 */

SELECT FIRST_NAME || ' ' || LAST_NAME 이름,
	SALARY 봉급,
	SALARY * 1.1 "인상 봉급",
	SALARY * 0.9 "감축 봉급"
FROM EMPLOYEES
ORDER BY SALARY;

-- 날짜 타입의 산술 연산
-- 1. 날짜와 숫자
SELECT HIRE_DATE,
	HIRE_DATE + 10,
	HIRE_DATE - 10
FROM EMPLOYEES;

-- SYSDATE
-- 현재 날짜와 시간 정보를 가지고 있으며
-- 오라클에서 기본적으로 제공한다.
SELECT SYSDATE 
FROM DUAL;

-- 날짜와 날짜의 연산
-- 날짜 - 날짜 : 며칠이 지났는지 결과로 나온다.
-- 연산결과는 숫자 타입이다.
SELECT HIRE_DATE,
	SYSDATE,
	SYSDATE - HIRE_DATE
	-- SYSDATE + HIRE_DATE 오류난다.
FROM EMPLOYEES;

-- 날짜와 숫자의 연산에서 기본적으로 숫자는 일 수를 의미하기 때문에
-- 시간, 분 단위로 연산하고 싶다면 일(24H)로 환산해야 한다.
SELECT SYSDATE,
	SYSDATE + 0.5,	-- 12시간
	SYSDATE - 1/24,	-- 1시간
	SYSDATE - 30 / 60 / 24	-- 30분
FROM DUAL;

-- WHERE 절 (행 골라내기)
-- 직원의 이름, 성, 봉급을 조회한다.
-- 단, 봉급이 10000 이상인 직원 정보만 조회
SELECT FIRST_NAME 이름,
	LAST_NAME 성,
	SALARY 봉급 
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY SALARY;

-- [실습]
-- 직원의 이름, 성을 조회한다.
-- 단, 이름이 David 인 직원만 골라서 출력한다.

SELECT FIRST_NAME 이름,
	LAST_NAME 성
FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

SELECT FIRST_NAME 이름,
	LAST_NAME 성,
	SALARY 봉급 
FROM EMPLOYEES
WHERE SALARY >= 10000	-- 여기에서는 별칭(alias)으로 사용 불가능
ORDER BY 봉급;

-- 별칭을 설정할 경우
-- 명령어들의 순서를 잘 생각해야 한다.
SELECT FIRST_NAME 이름,		-- 3. 각 컬럼에 별칭을 붙여서 조회
	LAST_NAME 성,
	SALARY 봉급 
FROM EMPLOYEES				-- 1. EMPLOYEES 테이블에서
WHERE 봉급 >= 10000			-- 2. 봉급을 찾지 못한다. 그래서 오류가 난다.
ORDER BY 봉급;				-- 4. 봉급 오름차순으로 정렬

-- EMPLOYEES 테이블에서
-- SALARY 가 10000 이상, 12000 이하인 직원의
-- FIRST_NAME, LAST_NAME, SALARY 를
-- SALARY 오름차순으로 조회하기
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 12000
ORDER BY SALARY;

-- IN 
/* EMPLOYEES 테이블에서
 * SALARY 가 10000 혹은 11000 혹은 12000 인 직원의
 * FIRST_NAME, LAST_NAME, SALARY 를
 * SALARY 오름차순으로 정렬하여 조회
 */
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY IN(10000, 11000, 12000)
ORDER BY SALARY;

-- LIKE
-- % : ~아무거나
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%e';

-- _ : 자릿수
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '____e';

-- e 를 포함하는 문자
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%e%';

-- NULL : 값이 없음을 나타내는 값
-- NULL 은 연산하면 결과가 NULL 이다.
SELECT NULL + 10
FROM DUAL;

/* 직원 테이블에서
 * COMMISSION_PCT 가 NULL 인 직원의
 * 이름, 성, COMMISSION_PCT 를 조회하기
 */

-- 자주 실수하는 예제
SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT = NULL;

SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

/* 직원 테이블에서
 * COMMISSION_PCT 가 NULL 이 아닌 직원의
 * 이름, 성, COMMISSION_PCT 를 조회하기
 */
SELECT FIRST_NAME, LAST_NAME, COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;	-- <> 안된다.

-- 논리연산자
/* 직원 테이블에서
 * 부서가 영업부이면서, 봉급이 10000 이상인 직원들의
 * 이름, 성, 봉급, 부서id 를
 * 봉급 오름차순으로 조회하기
 */
SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80 AND SALARY >= 10000
ORDER BY SALARY;

-- NOT 연산자
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE NOT FIRST_NAME = 'David';