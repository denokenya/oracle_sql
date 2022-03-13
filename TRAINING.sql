--select all departments.
SELECT *
FROM emp
;
--subqueries in sql example 1

SELECT *
FROM emp


WHERE sal =(SELECT MAX(SAL)
FROM emp);

--subqueries example 2

SELECT *
FROM emp
WHERE empno IN 
(SELECT empno
FROM emp
WHERE sal >1500)
;

--subqueries example 3
SELECT *
FROM dept d
WHERE 3 < (
    SELECT COUNT(*)
FROM emp
WHERE deptno =  d.deptno);

--STATEMENT NUMBER 1
SELECT *
FROM emp
WHERE deptno IN
  (
    SELECT deptno
FROM dept
WHERE deptno > 10
  );
--Select all employees order them by salary in descending order
SELECT *
FROM emp
ORDER BY sal DESC
;


--Inline views example 1
/* An inline view is a subquery 
that appears in the FROM clause of a subquery*/
SELECT *
FROM (
    SELECT deptno , AVG(sal) AS average_salary
    FROM emp
    GROUP BY deptno
) e

WHERE e.average_salary > 2000;

/*
Practice Challenge: Inline Views

PROBLEM 1:

Write a query to list the max, min, and average of salaries for every department id in the employee table,
but include only departments whose max salary is greater than the double of their minimum salary.

RESTRICTION: You are not allowed to use a HAVING clause.*/

SELECT *
FROM
    (
        SELECT deptno , MAX(sal) AS max_salary , MIN(sal) AS min_salary , AVG(sal) as average_salary
    FROM emp
    GROUP BY deptno  
    ) e

WHERE e.max_salary > (e.min_salary * 2)
;

--71 Subquery Factoring(The WITH Clause)

WITH
    em
    AS
    (
        SELECT deptno, AVG(sal) AS average_salary
        FROM emp
        GROUP BY 
    deptno
    )
SELECT *
FROM emp ep

WHERE ep.sal > 2000;

SELECT *
FROM emp 

--Fetch all employees who fetch more than average salary of all employees
WITH avarage_salary
(avg_sal ) AS
(SELECT cast(avg(sal)) as INT
FROM emp )
SELECT *
FROM emp e , avg_sal as av
WHERE e.sal > av.average_salary

--73 Top N -QUERIES
select *
from emp
where rownum < = 3
order by sal desc
;


--using WITH subquery 
WITH
    ordered
    AS
    (
        SELECT *
        FROM emp
        ORDER BY sal DESC
    )

SELECT *
FROM ordered
WHERE rownum  <= 3
;


--Analytics Functions Introduction
SELECT *
FROM emp
-----------------------------------
SELECT ename , sal,
    ROW_NUMBER() OVER(ORDER BY sal DESC) AS ROW_NUMBER,
    RANK() OVER(ORDER BY sal DESC) AS RANK,
    DENSE_RANK() OVER(ORDER BY sal DESC) AS DENSE_RANNK
FROM emp
ORDER BY sal DESC
;
------------------------------------------
WITH
    numbered
    AS
    (
        SELECT ename , sal ,
            ROW_NUMBER() OVER (ORDER BY sal DESC) AS rn
        FROM emp
        ORDER BY sal DESC

    )

SELECT *
FROM numbered
WHERE rn <= 3;

----------------------------------------------------;
SELECT *
FROM emp
ORDER BY sal DESC
fetch fisrt 5 rows only ;

--The Row limiting clause


--SINGLE ROW SQL FUNCTIONS

--The partion clause


SELECT deptno , ename, sal , SUM(sal) OVER(
PARTITION BY deptno) total_cost_of_department
FROM
    emp
WHERE
deptno = 30
ORDER BY
deptno
;
----------------------
SELECT deptno , ename, sal , SUM(sal) OVER(
PARTITION BY deptno) total_cost_of_department
FROM
    emp
ORDER BY
deptno
;

--Ranking Functions
--Get the top paid employees in each department

WITH
    topn
    AS
    (
        SELECT empno , ename , deptno, sal, RANK() OVER (PARTITION BY deptno , ORDER BY sal DESC ) AS rn
        FROM emp
    )

SELECT *
FROM topn
WHERE rn <= 2
ORDER BY deptno
;


--Test db scott.sql file
DROP TABLE DEPT;
CREATE TABLE DEPT
(
    DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
    DNAME VARCHAR2(14) ,
    LOC VARCHAR2(13)
)
;
DROP TABLE EMP;
CREATE TABLE EMP
(
    EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);
INSERT INTO DEPT
VALUES
    (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT
VALUES
    (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT
VALUES
    (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT
VALUES
    (40, 'OPERATIONS', 'BOSTON');
INSERT INTO EMP
VALUES
    (7369, 'SMITH', 'CLERK', 7902, to_date('17-12-1980','dd-mm-yyyy'), 800, NULL, 20);
INSERT INTO EMP
VALUES
    (7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-2-1981','dd-mm-yyyy'), 1600, 300, 30);
INSERT INTO EMP
VALUES
    (7521, 'WARD', 'SALESMAN', 7698, to_date('22-2-1981','dd-mm-yyyy'), 1250, 500, 30);
INSERT INTO EMP
VALUES
    (7566, 'JONES', 'MANAGER', 7839, to_date('2-4-1981','dd-mm-yyyy'), 2975, NULL, 20);
INSERT INTO EMP
VALUES
    (7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-9-1981','dd-mm-yyyy'), 1250, 1400, 30);
INSERT INTO EMP
VALUES
    (7698, 'BLAKE', 'MANAGER', 7839, to_date('1-5-1981','dd-mm-yyyy'), 2850, NULL, 30);
INSERT INTO EMP
VALUES
    (7782, 'CLARK', 'MANAGER', 7839, to_date('9-6-1981','dd-mm-yyyy'), 2450, NULL, 10);
INSERT INTO EMP
VALUES
    (7788, 'SCOTT', 'ANALYST', 7566, to_date('13-JUL-87')-85, 3000, NULL, 20);
INSERT INTO EMP
VALUES
    (7839, 'KING', 'PRESIDENT', NULL, to_date('17-11-1981','dd-mm-yyyy'), 5000, NULL, 10);
INSERT INTO EMP
VALUES
    (7844, 'TURNER', 'SALESMAN', 7698, to_date('8-9-1981','dd-mm-yyyy'), 1500, 0, 30);
INSERT INTO EMP
VALUES
    (7876, 'ADAMS', 'CLERK', 7788, to_date('13-JUL-87')-51, 1100, NULL, 20);
INSERT INTO EMP
VALUES
    (7900, 'JAMES', 'CLERK', 7698, to_date('3-12-1981','dd-mm-yyyy'), 950, NULL, 30);
INSERT INTO EMP
VALUES
    (7902, 'FORD', 'ANALYST', 7566, to_date('3-12-1981','dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO EMP
VALUES
    (7934, 'MILLER', 'CLERK', 7782, to_date('23-1-1982','dd-mm-yyyy'), 1300, NULL, 10);
DROP TABLE BONUS;
CREATE TABLE BONUS
(
    ENAME VARCHAR2(10)	,
    JOB VARCHAR2(9)  ,
    SAL NUMBER,
    COMM NUMBER
)
;
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
(
    GRADE NUMBER,
    LOSAL NUMBER,
    HISAL NUMBER
);
INSERT INTO SALGRADE
VALUES
    (1, 700, 1200);
INSERT INTO SALGRADE
VALUES
    (2, 1201, 1400);
INSERT INTO SALGRADE
VALUES
    (3, 1401, 2000);
INSERT INTO SALGRADE
VALUES
    (4, 2001, 3000);
INSERT INTO SALGRADE
VALUES
    (5, 3001, 9999);
COMMIT;


--1. Write query to display empno, ename,sal,dname from emp and dept tables for those employees location is not newyork.
SELECT empno, ename, sal, dname
FROM emp, dept
WHERE loc NOT IN ('NEW YORK');

--2.Write query to display empno, ename,sal,dname for entered employee number.
SELECT empno, ename, sal, dname
FROM emp, dept
WHERE emp.empno=&empno and emp.deptno=dept.deptno
;

--3Write query to display empno, ename,sal,grade for those emplyees whose grade is 1.


SELECT *
FROM emp
    JOIN salgrade ON sal BETWEEN losal AND hisal
WHERE grade = 1

--4 Write query to display employee and their boss details those who are having salary more than their boss(manager).
--STEPS
--STEP 1:Get the salaty of employee
--STEP 2 :To get manager salary by joining managerid to empid
--STEP 3: TO compare the results
select e.empno as employee_no , e.sal as employee_salary, M.empno AS Manager_Number , M.sal AS manager_salary
from emp e
    join emp M ON E.empno = M.mgr
WHERE e.sal > M.sal

--5 Write a query to diaplay every employee those belongs to any department & also those all not belongs to any department.

SELECT *
FROM emp

WHERE deptno IS NULL



--6. Write query to display employees who doesn't have boss(manager)
select *
from emp
where mgr is null

--7 scenario: there are 2 tables data give n in below as table1  and table2, both tables have only one column. Question to disple the number of rows if you do inner join, left join, right join and full join.

--8. display emplee name in uper case, lower case, lenght of each emplyee name, first charecter of employee name.

SELECT UPPER(ename) , LOWER(ename) , LENGTH(ename) , SUBSTR(ename,1, 1)
FROM emp

--9. display each employee name and experience in months.
SELECT ename, TRUNC(months_between(SYSDATE, HIREDATE)) AS employee_experince_in_months
FROM emp;

--10 display current month first day and next month first sunday date. duse dual table.
SELECT TRUNC(SYSDATE, 'MM') AS first_day_of_mnth, next_day(trunc(sysdate,'MM') - 1,'sun') first_sun
FROM dual;


--11. display department wise average salary whose department avarage salary more than department 20.(sub query)
SELECT deptno , sal
FROM emp
WHERE
sal > ( SELECT AVG(


--12.dispaly deptno where atleast 4 emplyees working 
SELECT deptno

FROM emp
GROUP BY deptno
HAVING count(*) >= 4;

--13.display 5th record to 10th record from employee table (rownum)

SELECT *
FROM EMP
OFFSET
5 ROWS
FETCH FIRST 5 ROWS
WITH TIES ;

--14 display 1st and last records fro emp table.
    SELECT *
    FROM emp
    where rownum =1

union all

    SELECT *
    FROM ( SELECT *
        FROM emp
        ORDER BY rownum DESC)
    WHERE rownum =1;

--First Record 7369 SMITH
--Last Record 7934 MILLER

--15 display last but one record (2nd row from last) from emp table.

--16 display fifth maximum salary from emp table.
SELECT *
FROM
    (
        SELECT ename, sal, DENSE_RANK() 
        OVER(ORDER BY sal DESC) salary_rank
    FROM EMP)
WHERE salary_rank =5;


--17.display 3rd and 5th maximum salary employee details.
SELECT *
FROM
    (
        SELECT ename, sal, DENSE_RANK() 
        OVER(ORDER BY sal DESC) salary_rank
    FROM EMP)
WHERE salary_rank IN(3,5);

--18

-19. display the empno, ename,salary from the previous row to calculate the difference between the salary of the current row and that of the previous row.
SELECT empno,
    ename,
    sal,
    LAG(sal, 1, 0) OVER (ORDER BY sal) AS sal_prev,
    sal - LAG(sal, 1, 0) OVER (ORDER BY sal) AS sal_diff
FROM emp;

--20 display the deptno, ename,salary from the previous row to calculate the difference between the salary of the current row and that of the previous row from each department separately.
SELECT deptno,
    empno,
    ename,
    sal,
    LAG(sal, 1, 0) OVER (PARTITION BY deptno ORDER BY sal) AS sal_prev
FROM emp;

--21. display the empno, ename,salary from the next row to calculate the difference between the salary of the current row and that of the previous row.
SELECT empno,
    ename,
    sal,
    LEAD(sal, 1, 0) OVER (ORDER BY sal) AS sal_next,
    LEAD(sal, 1, 0) OVER (ORDER BY sal) - sal AS sal_diff
FROM emp;


--22 display the deptno, ename,salary from the next row to calculate the difference between the salary of the current row and that of the previous row from each department separately.
SELECT deptno,
    empno,
    ename,
    sal,
    LEAD(sal, 1, 0) OVER (PARTITION BY deptno ORDER BY sal) AS sal_next,
    sal - LEAD(sal, 1, 0) OVER (PARTITION BY deptno ORDER BY sal DESC)  AS sal_diff

FROM emp;

--23 write a query to create view usning sum(sal), avg(sal), min(comm), max(comm) from employee table
CREATE VIEW employee_view
(
    sum_sal,
    avg_sal,
    min_comm ,
    max_comm
)
as
    select sum(sal), avg(sal), min(comm), max(comm)
    from emp;

--24 dispaly all dept numbers from emp table and dept table
    SELECT deptno
    FROM emp
union
    SELECT deptno
    FROM dept;

----------------------------------------
--ANALYTICAL FUNCTIONS

--1.RANK
--2 DENSE_RANK
--3 ROW_NUMBER
--4.COUNT
--5.LAG--PREVIOUS
--6.LEAD --NEXT
--7.FIRST_VALUE
--8.LAST_VALUE
--9.FIRST
--10.LAST
--RANK....DENSE_RANK
SELECT *
FROM
    (

SELECT ename, sal, deptno, DENSE_RANK() OVER(ORDER BY sal DESC) AS rnk
    FROM
        emp 
)
WHERE rnk < =5
;

--DENSE_RANK is applied in partions

SELECT ename , sal , deptno, DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) AS d_rank
FROM emp ;
