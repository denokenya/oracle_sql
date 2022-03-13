
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
SELECT ename , deptno , sal , RANK() OVER(ORDER BY sal DESC) AS rank  ,DENSE_RANK() OVER(ORDER BY sal DESC) AS dense_rank
FROM emp
