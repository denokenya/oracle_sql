-----Select all the salgrade
SELECT  grade ,hisal - losal as difference
FROM salgrade

--Using dense_rank,rank ,partition

SELECT ename , deptno , sal , RANK() OVER(ORDER BY sal DESC) AS rank  ,DENSE_RANK() OVER(ORDER BY sal DESC) AS dense_rank
FROM emp

------------------------------------------------------
--Calculate the months between hiredate and the current date order by employee name
SELECT ename,sal * 12,TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) 

FROM emp
WHERE deptno = 30
ORDER BY ename;