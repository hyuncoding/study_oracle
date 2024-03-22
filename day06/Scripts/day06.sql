SELECT * FROM PLAYER;

/* 집계함수 : 결과 행 1개
 * 주의사항 : NULL은 포함시키지 않는다, WHERE절에서는 사용 불가
 * 
 * 평균 : AVG()
 * 최대값 : MAX()
 * 최소값 : MIN()
 * 총 합 : SUM()
 * 개 수: COUNT()
 */
SELECT AVG(HEIGHT) FROM PLAYER;
SELECT MAX(HEIGHT) FROM PLAYER;
SELECT MIN(HEIGHT) FROM PLAYER;
SELECT SUM(HEIGHT) FROM PLAYER;
SELECT COUNT(HEIGHT) FROM PLAYER;

SELECT * FROM PLAYER; 

SELECT COUNT(NVL(HEIGHT, 0)) FROM PLAYER;

--================================================================
/* GROUP BY : ~별 (예 : 포지션 별 평균키)
 * GROUP BY 컬럼명
 * HAVING 조건식
 * WHERE 절은 집계 함수가 불가능하지만 HAVING은 가능하다.
 * WHERE 절에 우선적으로 처리할 조건식을 작성해야 속도가 빠르다.
 */

/* PLAYER 테이블에서 포지션 종류 검색 */
SELECT DISTINCT "POSITION" FROM PLAYER;

/* 오류 발생 
 * GROUP BY로 포지션 종류를 보게 되면
 * 4개의 포지션이 나오게 되는데 SELECT로 모든 정보를 본다는 것은
 * 말이 되지 않는다. 4개의 행으로 모든 정보를 나타낼 수 없기 때문이다.
 */
SELECT * FROM PLAYER 
GROUP BY "POSITION";

/* 포지션을 GROUP BY로 묶어준다면, 묶어주는 포지션 컬럼을 조회한다.
 * 반드시 조회를 해야하는 것은 아니지만 무엇을 기준으로 그룹을 지었는지 알기 쉽다.
 */

/* 포지션 별 평균 키를 구한다. */
SELECT "POSITION", AVG(HEIGHT) FROM PLAYER 
GROUP BY "POSITION";

/* PLAYER 테이블에서 몸무게가 80이상인 선수들의 평균 키가 180 초과인 포지션 검색 */
SELECT "POSITION" 
FROM PLAYER 
WHERE WEIGHT >= 80
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180;

-- 결과가 맞는지 확인해보자
SELECT "POSITION", AVG(HEIGHT), MIN(WEIGHT) 
FROM PLAYER 
WHERE WEIGHT >= 80
GROUP BY "POSITION" 
HAVING AVG(HEIGHT) > 180;

/* EMPLOYEES 테이블에서 JOB_ID 별 평균 SALARY 가 10000 미만인 JOB_ID 검색
 * JOB_ID 는 알파벳 순으로 정렬(오름차순)
 */

SELECT JOB_ID, AVG(SALARY) 
FROM EMPLOYEES
GROUP BY JOB_ID 
HAVING AVG(SALARY) < 10000
ORDER BY JOB_ID ASC;

-- [실습]
/* PLAYER 테이블 */

/* PLAYER_ID 가 2007로 시작하는 선수들 중
 * POSITION 별 평균 키를 조회
 */


SELECT "POSITION", AVG(HEIGHT) 
FROM PLAYER 
WHERE PLAYER_ID LIKE '2007%'
GROUP BY "POSITION";

/* 선수들 중 포지션이 DF인 선수들의 평균 키를 TEAM_ID 별로 조회하기
 * 평균 키 오름차순으로 정렬하기
 */

SELECT TEAM_ID, AVG(HEIGHT) 
FROM PLAYER 
WHERE "POSITION" = 'DF'
GROUP BY TEAM_ID 
ORDER BY AVG(HEIGHT);

/* 포지션이 MF인 선수들의
 * 입단연도 별 평균 몸무게, 평균 키를 구한다.
 * 컬럼명은 입단연도, 평균 몸무게, 평균 키로 표시한다.
 * 입단연도를 오름차순으로 정렬한다.
 */
SELECT * FROM PLAYER; 

SELECT JOIN_YYYY 입단연도, ROUND(AVG(WEIGHT), 1) "평균 몸무게", ROUND(AVG(HEIGHT), 1) "평균 키"
FROM PLAYER 
WHERE "POSITION" = 'MF'
GROUP BY JOIN_YYYY 
ORDER BY 입단연도; 

/* EMPLOYEES 테이블 */

/* 핸드폰 번호가 515로 시작하는 사원들의
 * JOB_ID 별 SALARY 평균을 구한다.
 * 조회 컬럼은 부서, 평균 급여로 표시한다.
 * 평균 급여가 높은 순으로 정렬한다.
 */
SELECT JOB_ID 부서, AVG(SALARY) "평균 급여"
FROM EMPLOYEES 
WHERE PHONE_NUMBER LIKE '515%'
GROUP BY JOB_ID 
ORDER BY AVG(SALARY) DESC;

/* COMMISSION_PCT 별 평균 급여를 조회한다.
 * COMMISSION_PCT 를 오름차순으로 정렬하며
 * HAVING절을 사용하여 NULL 은 제외한다. */
SELECT COMMISSION_PCT, AVG(SALARY) "평균 급여"
FROM EMPLOYEES 
GROUP BY COMMISSION_PCT 
HAVING COMMISSION_PCT IS NOT NULL
ORDER BY COMMISSION_PCT;

--==========================================================================================
-- SUB QUERY

-- IN LINE VIEW
/* PLAYER 테이블에서 전체 평균 키와 포지션별 평균 키 구하기 */

SELECT AVG(HEIGHT)
FROM PLAYER;

SELECT "POSITION", AVG(HEIGHT)
FROM PLAYER 
GROUP BY "POSITION";

-- 오류
-- 서브쿼리의 행의 수가 메인 쿼리보다 많음 (4 vs 480)
SELECT "POSITION", AVG(HEIGHT), (SELECT * FROM PLAYER)
FROM PLAYER 
WHERE "POSITION" IS NOT NULL 
GROUP BY "POSITION";

SELECT "POSITION" 포지션, 
	AVG(HEIGHT) "포지션 별 평균 키", 
	(SELECT AVG(HEIGHT) FROM PLAYER) "전체 평균 키"
FROM PLAYER 
WHERE "POSITION" IS NOT NULL 
GROUP BY "POSITION";

-- SCALAR 
/* PLAYER 테이블에서 TEAM_ID 가 'K01'인 선수 중 POSITION이
 * 'GK'인 선수를 조회하기 (SUB 쿼리 사용하기)
 */

SELECT * FROM PLAYER  
WHERE TEAM_ID = 'K01' AND "POSITION" = 'GK';

SELECT * FROM PLAYER  
WHERE TEAM_ID = 'K01';

SELECT * FROM PLAYER  
WHERE "POSITION" = 'GK';

-- 서브 쿼리
SELECT * 
FROM (
	SELECT * FROM PLAYER 
	WHERE TEAM_ID = 'K01'
)
WHERE "POSITION" = 'GK';
-- 서브쿼리를 안 쓰는 게 더 빠르지만 써야만 하는 상황이 많다.
-- 그러므로 서브쿼리를 쓰기 전에 안 써도 해결되는지 먼저 생각하고 사용한다.

-- SUB QUERY 
/* PLAYER 테이블에서 평균 몸무게보다 더 많이 나가는 선수들 검색 */
SELECT AVG(WEIGHT)
FROM PLAYER;

SELECT * FROM PLAYER
WHERE WEIGHT > (
	SELECT AVG(WEIGHT)
	FROM PLAYER
);

-- 결과 확인
SELECT MIN(WEIGHT) FROM PLAYER 
WHERE WEIGHT > (
	SELECT AVG(WEIGHT) 
	FROM PLAYER 
);

-- [실습]
/* PLAYER 테이블에서 정남일 선수가 소속된 팀의 선수들 조회 */
SELECT * 
FROM PLAYER 
WHERE TEAM_ID = (
	SELECT TEAM_ID 
	FROM PLAYER 
	WHERE PLAYER_NAME = '정남일'
);

/* PLAYER 테이블에서 평균 키보다 작은 선수 조회 */

SELECT * FROM PLAYER 
WHERE HEIGHT < (
	SELECT AVG(HEIGHT) 
	FROM PLAYER
);

-- 결과 확인
SELECT MAX(HEIGHT) FROM PLAYER 
WHERE HEIGHT < (
	SELECT AVG(HEIGHT)
	FROM PLAYER
);

/* SCHEDULE 테이블에서 경기 일정이
 * 20120501 ~ 20120502 사이에 있는 경기장 전체 정보 조회 
 * IN() 을 써야한다. */
SELECT * FROM STADIUM
WHERE STADIUM_ID IN(
	SELECT STADIUM_ID
	FROM SCHEDULE 
	WHERE SCHE_DATE BETWEEN '20120501' AND '20120502'
);

