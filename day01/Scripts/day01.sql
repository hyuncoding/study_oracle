-- EMPLOYEES 테이블에서 FIRST_NAME 컬럼만 조회
SELECT FIRST_NAME 
FROM EMPLOYEES;

-- 주석
-- 컴퓨터가 해석하지 않는다.
-- 실행시키지 않고 설명을 작성할 때 사용한다.

/* 범위주석
 * 단축키 : Ctrl + Shift + /
 */

SELECT FIRST_NAME FROM HR.EMPLOYEES;
-- 테이블 명을 작성할 때 정확하게 작성하려면 계정명을 작성하고
-- (.)을 써줘야 한다. . 은 ~안에 있는 이라는 의미이다.

/* ; 세미콜론 : 세미콜론은 하나의 명령이 끝나면 작성한다.
 * 마침표라고 생각하면 좋다.
 * 세미콜론을 적어야 한 줄의 끝이라고 생각하기 때문에
 * 세미콜론 이전에 줄바꿈을 해도 상관없다.
 */

SELECT FIRST_NAME, LAST_NAME 
FROM EMPLOYEES;

-- [실습]
-- 직원 테이블에서 성, 이름, 휴대전화번호, 이메일 주소, 사원번호를 한번에 조회하기
-- (순서대로 조회되어야 한다.)

SELECT LAST_NAME, FIRST_NAME, PHONE_NUMBER, EMAIL, EMPLOYEE_ID
FROM EMPLOYEES;

-- 모든 컬럼 조회하기
-- * : 모든, all
SELECT * FROM EMPLOYEES;

-- 정렬해서 조회하기
-- ORDER BY 절
-- 사원의 이름, 성, 봉급을 봉급 낮은 순서부터 조회하기
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY ASC;
-- ORDER BY 정렬하겠다 SALARY 기준 ASC 오름차순으로
-- 낮은 순서부터 조회는 낮은 값부터 높은 값 순서대로를 의미한다.
-- 오름차순은 영어로 ascending 이다. 앞글자 3개를 따서 ASC로 사용한다.
SELECT FIRST_NAME, LAST_NAME, SALARY 
FROM EMPLOYEES
ORDER BY SALARY DESC; -- 내림차순 descending 

-- 직원의 이름 성 고용일을 고용일 순서로 정렬
-- 날짜 값도 정렬이 가능하다.
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE ASC;

-- 직원의 이름, 성을 성 순서대로 정렬
-- 문자도 정렬이 가능하다.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
ORDER BY LAST_NAME ASC;

-- 기본은 오름차순 정렬이다.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
ORDER BY LAST_NAME;
