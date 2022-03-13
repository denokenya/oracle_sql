
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