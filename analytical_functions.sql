
.....................................................................................................................................................
/*
http://pafumi.net/Analytic_Functions.html
DATE:13/2/2022

Select MAX() OVER ()
The OVER() statement signals a start of an Analytic function. That is what differentiates an Analytical Function from a regular Oracle SQL function
---------------------------------------------------------------------------------------------------------------------------------------------------
Select MAX() OVER(partition by field1).
The portioning clause is used to setup the group of data that the Analytic function would be applied to.
-----------------------------------------------------------------------------------------------------------------------------------------------------
Select MAX() OVER(Partition by field order by)
Order by specify the order of the window in the group by statement. 
The Order by clause is a keyword in the Oracle Analytic syntax that is requirement for using some Analytic functions
Analytic functions are the last set of operations performed in a query except for the final ORDER BY clause. 
All joins and all WHERE, GROUP BY, and HAVING clauses are completed before the analytic functions are processed. 
Therefore, analytic functions can appear only in the select list or ORDER BY clause.

*/
.........................................................................................................................................................
SELECT ename , deptno , sal ,
    ROUND(AVG(sal) OVER(PARTITION BY deptno ),2)AS avg_sal_dept
FROM emp
;

/*ROW_NUMBER is an analytic function. It assigns a unique number to each row to which it is applied 
(either each row in the partition or each row returned by the query),
in the ordered sequence of rows specified in the order_by_clause, beginning with 1 */
--Example 1

--Let's look at what ROW_NUMBER can do. Here is an example query using ROW_NUMBER to assign an increasing number to each row in the EMP table after sorting by SAL DESC:

select ename , sal,
    row_number() over(order by sal desc) rn
from emp

order by sal desc;

--I can apply a predicate to ROW_NUMBER after it is assigned. For example

select *
from
    (
        select ename, sal , row_number() over (order by sal desc) rn
    from emp
    )
where rn <=5
order by sal desc;

--Sort the sales people by salary from greatest to least. Give the first three rows. If there are less then three people in a department, this will return less than three records.
SELECT *
FROM
    (
        SELECT deptno, ename, sal, ROW_NUMBER()
            OVER(PARTITION BY deptno ORDER BY sal DESC) TOP3
    FROM emp
    )
WHERE top3 <= 3

/*Example 2

Bearing this in mind, I can use other analytic functions to remove
the ambiguity from example 1. 
They will do so, but the analytic functions might return more than n rows.
In my opinion, when the attribute I order by is not unique, 
I want my query to return all of the relevant records—not just
the first n arbitrary ones. To that end,
I can use the RANK and DENSE_RANK analytic functions. 
Let's take a look at what they do:*/
SELECT ename, sal,
    row_number() OVER(ORDER BY sal DESC)rnk,
    dense_rank() OVER(ORDER BY sal DESC) drnk
FROM emp;
-----------------------------------------------------------------
/*Give me the set of sales people who make the top 3 salaries - 
that is, find the set of distinct salary amounts, sort them, take the largest three, 
and give me everyone who makes one of those values    
*/
SELECT *

FROM
    (
        SELECT deptno ,ename,sal,
        DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) TOPN
        FROM emp
    )
WHERE TOPN <= 3
ORDER BY deptno,sal DESC;

----------------------------------------------------------------------
--------------LAG-----------------------------------------------------
/*LAG provides access to more than one row of a table at the same 
time without a self join. Given a series of rows returned from a 
query and a position of the cursor, LAG provides access to a row at 
a given physical offset prior to that position. If you do not specify
 offset, then its default is 1. The optional default value is returned 
 if the offset goes beyond the scope of the window. If you do not 
 specify default, then its default value is null. 
 ###The following example provides, for each person in the EMP table, 
 the salary of the employee hired just before:### */
SELECT ename,hiredate ,sal,
        LAG(sal,1,0) OVER(ORDER BY hiredate) AS Prevsal
FROM emp
WHERE job = 'CLERK';

------LEAD-------------------------------------------
/*LEAD provides access to more than one row of a table 
at the same time without a self join.*/
---The following example provides, for each employee in the EMP table, the hire date of the employee hired just after
SELECT ename, hiredate ,
    LEAD(hiredate ,1)OVER(ORDER BY hiredate) as Nexthired

FROM emp
WHERE deptno = 3 ;

------Determine the First Value / Last Value of a Group-----------------
--The FIRST_VALUE and LAST_VALUE functions allow you to select 
--the first and last rows from a group. 
--These rows are especially valuable because they are often used as 
--the baselines in calculations


--The following example selects, for each employee in each department,
-- the name of the employee with the lowest salary.
SELECT deptno,ename,sal,
    FIRST_VALUE(ename)
    OVER(PARTITION BY deptno ORDER BY sal) AS MIN_SAL_HAS
FROM emp
ORDER BY deptno,ename    

--The following example selects, for each employee in each department, 
--the name of the employee with the highest salary

SELECT deptno ,ename ,sal,
    FIRST_VALUE(ename) OVER(PARTITION BY deptno ORDER BY sal DESC) 
        AS MIN_SAL_HAS
FROM emp
ORDER BY deptno, ename ;     

--The following example selects, for each employee in 
--department 30 the name of the employee with the lowest salary
-- using an inline view
SELECT deptno ,ename,sal,
    FIRST_VALUE(ename)
    OVER(ORDER BY sal )AS MIN_SAL_HAS
FROM
    (
        SELECT * FROM emp WHERE deptno = 30
    )    

--Analytics running total---
SELECT *
FROM emp
ORDER BY deptno

--Getting a SUM of SAL by DEPTNO---

SELECT deptno, ename, sal,
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal) running_total1
    SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ,rowid) running_total2
FROM emp
ORDER BY deptno ,sal    