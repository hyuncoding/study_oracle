/* AVG 함수를 쓰지 않고 PLAYER 테이블에서 선수들의 평균 키 구하기
 * (NULL 미포함)
 */
SELECT ROUND(SUM(HEIGHT)/ COUNT(HEIGHT), 2)
FROM PLAYER;

/* DEPT 테이블을 참고하여 EMP 테이블에 저장된 사원들의 
 * LOC 별 평균 급여와 각 LOC별 SAL 합을 조회
 */
SELECT LOC, AVG(SAL), SUM(SAL)
FROM DEPT D JOIN EMP E 
ON D.DEPTNO = E.DEPTNO
GROUP BY D.LOC;

/* PLAYER 테이블에서 팀별 최대 몸무게인 선수 전체 정보 검색 */
SELECT *
FROM (
	SELECT TEAM_ID, MAX(WEIGHT) WEIGHT
	FROM PLAYER P
	GROUP BY TEAM_ID
) P1 JOIN PLAYER P2
ON P1.TEAM_ID = P2.TEAM_ID AND P1.WEIGHT = P2.WEIGHT 
ORDER BY P1.TEAM_ID;

/* 위 문제를 JOIN 없이 풀기
 * (A, B) IN (C, D) : A = C AND B = D */
SELECT * FROM PLAYER P
WHERE (TEAM_ID, WEIGHT) IN (
	SELECT TEAM_ID, MAX(WEIGHT) 
	FROM PLAYER P
	GROUP BY TEAM_ID
)
ORDER BY TEAM_ID;

/* 형변환 함수
 * TO_CHAR() */
SELECT SYSDATE 
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "현재 날짜"
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일"') "현재 날짜"
FROM DUAL;

-- 숫자에 콤마 찍기
-- 형식보다 큰 자리수가 들어오면 데이터가 손상된다.
-- 형식 지정시 0 또는 9를 사용하며
-- 9를 쓰면 값이 없을 때 공백이 들어간다.
-- 0을 쓰면 0이 들어간다.
-- FM을 형식 가장 왼쪽에 넣어주면 불필요한 공백을 없애준다.
SELECT TO_CHAR(12341526465, 'FM9,999,999,999,999,999') 포맷
FROM DUAL;

-- TO_NUMBER()
SELECT '1000'
FROM DUAL;

SELECT TO_NUMBER('1000')
FROM DUAL;

SELECT '1000' + '1000'
FROM DUAL;

-- TO_DATE()
SELECT TO_DATE('2000-05-05', 'YYYY-MM-DD')
FROM DUAL;

--================================================================
/* 집합 */
SELECT * FROM EMP e 
WHERE DEPTNO = 30;

SELECT * FROM EMP e 
WHERE DEPTNO = 10;

-- EMP 테이블에서 DEPTNO 가 30 또는 10인 데이터를 조회하기
-- 두 테이블을 UNION(합집합) 으로 연결한다.
SELECT * FROM EMP e 
WHERE DEPTNO = 30
UNION
SELECT * FROM EMP e 
WHERE DEPTNO = 10;

/* EMP 테이블에서 SAL 이 1000 이상 2000 이하,
 * 1500 이상, 3000 이하의 결과를 같이 조회한다. */

SELECT * FROM EMP E
WHERE SAL BETWEEN 1000 AND 2000
UNION 
SELECT * FROM EMP E
WHERE SAL BETWEEN 1500 AND 3000;

-- UNION ALL 은 중복되는 행을 제거하지 않는다.
SELECT * FROM EMP E
WHERE SAL BETWEEN 1000 AND 2000
UNION ALL
SELECT * FROM EMP E
WHERE SAL BETWEEN 1500 AND 3000;

/* UNION 은 중복을 제거하는 작업을 추가로 하므로 UNION ALL보다
 * 연산이 많아진다. 중복을 제거할 필요가 없다면
 * UNION ALL 을 사용하는 것이 효율적이다. */

-- UNION으로 다른 테이블의 값들도 같이 조회할 수 있을까?
SELECT * FROM EMP E;
SELECT * FROM DEPT D;

-- 오류 : 열의 수가 다르면 UNION을 사용할 수 없다.
SELECT * FROM EMP E
UNION
SELECT * FROM DEPT D;

-- 열의 수와 타입이 일치한다면 UNION이 가능하다.
SELECT EMPNO, ENAME, JOB FROM EMP E
UNION 
SELECT * FROM DEPT D;

-- 교집합
SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER P
WHERE HEIGHT BETWEEN 185 AND 186
INTERSECT 
SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER P
WHERE WEIGHT BETWEEN 76 AND 78;

-- 차집합
SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER P
WHERE HEIGHT BETWEEN 185 AND 186
MINUS  
SELECT PLAYER_NAME 이름, TEAM_ID 팀, HEIGHT 키, WEIGHT 몸무게
FROM PLAYER P
WHERE WEIGHT BETWEEN 76 AND 78;
--==================================================================
/* VIEW */
/* PLAYER 테이블에서 나이 컬럼을 추가한 뷰 만들기 */
SELECT * FROM PLAYER P;

SELECT P.*, SYSDATE - BIRTH_DATE 
FROM PLAYER P;

SELECT P.*, ROUND((SYSDATE - BIRTH_DATE)/365) AGE
FROM PLAYER P;

CREATE VIEW VIEW_PLAYER AS 
SELECT P.*, ROUND((SYSDATE - BIRTH_DATE)/365) AGE
FROM PLAYER P;

SELECT * FROM VIEW_PLAYER VP;
SELECT AGE FROM VIEW_PLAYER VP;

/* PLAYER 테이블에 TEAM_NAME 컬럼을 추가한 VIEW 만들기 */
CREATE VIEW VIEW_TEAM AS
SELECT P.*, T.TEAM_NAME
FROM TEAM T JOIN PLAYER P 
ON T.TEAM_ID = P.TEAM_ID; 

SELECT TEAM_ID, TEAM_NAME
FROM VIEW_TEAM VT;
--===================================================================
/* CASE */
/*
 * EMPLOYEES 테이블에서
 * 부서 ID가 50인 부서는 기존 급여에서 10& 삭감
 * 부서 ID가 80인 부서는 기존 급여에서 10& 인상
 * 나머지는 그대로
 * 사원의 이름과 기존급여, 조정급여를 조회하기
 */

SELECT LAST_NAME || ' ' || FIRST_NAME NAME,
	SALARY 기존급여,
	CASE 
		WHEN DEPARTMENT_ID = 50 THEN SALARY * 0.9
		WHEN DEPARTMENT_ID = 80 THEN SALARY * 1.1
		ELSE SALARY
	END 조정급여, 
	DEPARTMENT_ID 부서
FROM EMPLOYEES e;

SELECT * FROM EMP e;

SELECT ENAME, DEPTNO, SAL,
	CASE 
		WHEN DEPTNO = 20 THEN SAL * 1.1
		WHEN ENAME = 'SMITH' THEN SAL * 2
	END RESULT_SAL 
FROM EMP e;

-- [실습]
/* 
 * EMP 테이블에서 사원들의 번호, 이름, 급여와
 * 최종 급여 컬럼을 같이 조회한다.
 * 최종 급여는 커미션(COMM)이 존재하면 봉급과 더하고
 * 커미션이 존재하지 않는다면 100을 더해준다.
 * 조회 결과는 최종급여 오름차순으로 정렬한다.
 */

SELECT EMPNO 번호, ENAME 이름, SAL 급여, 
	CASE
		WHEN COMM IS NOT NULL THEN SAL + COMM
		WHEN COMM IS NULL THEN SAL + 100
	END "최종 급여"
FROM EMP e 
ORDER BY "최종 급여";

/* EMP 테이블의 사원 정보를 가져온다.
 * 이 때 SAL 가 높은 순으로 정렬하고 비고 컬럼을 만든다.
 * 비고 컬럼에는 급여 순위가 1~5등이면 상
 * 6~10등이면 중
 * 나머지는 하 를 넣는다.
 */

SELECT ROWNUM, SAL,
	CASE
		WHEN ROWNUM BETWEEN 1 AND 5 THEN '상'
		WHEN ROWNUM BETWEEN 6 AND 10 THEN '중'
		ELSE '하'
	END 비고
FROM (
	SELECT * FROM EMP E
	ORDER BY SAL
) E;
