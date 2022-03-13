CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;
DROP TABLE EMP;
CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
	(40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
DROP TABLE BONUS;
CREATE TABLE BONUS
	(
	ENAME VARCHAR2(10)	,
	JOB VARCHAR2(9)  ,
	SAL NUMBER,
	COMM NUMBER
	) ;
DROP TABLE SALGRADE;
CREATE TABLE SALGRADE
      ( GRADE NUMBER,
	LOSAL NUMBER,
	HISAL NUMBER );
INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;
SET TERMOUT ON
SET ECHO ON

--select all employees.
SELECT * FROM emp ;

--display data from emp table whose names starts with 'A' and joined in the year '87'.
SELECT *
FROM emp

WHERE (ename LIKE 'A%'  )

;

--display data from emp table whose joined in the month of jan.
SELECT *
FROM emp 
WHERE to_char(hiredate, 'mon')='jan';

--.write a SQL query to increase the salary by 50% for those employees who doesn't have commission.
SELECT *
FROM emp

WHERE  comm IS NULL SET comm

--write a SQL query to show total salary of all the emplyees from department  numer 20 and 30 and who's commisson is null and salary grater than equal to 1000 
SELECT *
FROM emp
WHERE ( deptno IN(20,30) AND comm IS NULL) AND (sal >= 1000)

;
--write a SQL query to show employee details who's job is CLERK and MANAGER.

SELECT *
FROM emp
WHERE job IN ('CLERK','MANAGER');

--write a SQL query to find which department total salary is grathan 10000.
SELECT deptno 
FROM emp 
WHERE SUM(sal) > 10000 ;


--write a SQL query to find those employees whose salary exceeds 3000 after giving 25% increment.
SELECT *
FROM emp 
WHERE (sal * 1.25) > 3000
;
--write a SQL query to find those employees whose commission is more than their salary. 
SELECT * 
FROM emp
WHERE (comm > sal ) 
--Order all employees by job.
SELECT * FROM emp 
ORDER BY job
;
--Using DISTNCT
 SELECT DISTINCT job  "POSITION"
 FROM emp  ;

--select all employees where hire date is greater than 20-FEB-81
SELECT  * FROM emp 
WHERE hiredate > '20-FEB-81'
;
/*write a SQL query to list the employees’ name, increased their salary by 15% in descending order */

SELECT ename ,(sal *1.15 ) "SALARY" 
FROM emp;

SELECT *
FROM emp
WHERE deptno = 20 AND hiredate = '02-APR-81'

-- write a SQL query to find the minimum ,maximum and average salary from each department.
SELECT deptno, MIN(sal) ,MAX(sal) , AVG(sal)
FROM emp 
GROUP BY deptno
;

--write a SQL query to compute the average salary of those employees who work as ‘ANALYST’. 
SELECT AVG(sal) "ANALYST AVERAGE SALARY"
FROM emp
WHERE job = 'ANALYST'
;
    
/*
displays the EMPNO ,ENAME,SALARY and  SAL+ COMMISSION 
as total salary from employee table whose commission is not null.
*/
SELECT empno ,ename ,salary ,

FROM emp ;

--select all departments.
SELECT * FROM dept ;

--selecting data fromone department
SELECT * FROM dept
WHERE deptno = 10

--Selecting Data from Specified Departments
SELECT * FROM dept
WHERE deptno IN (10,30,40);

--select all from salfrade;
SELECT * FROM salgrade

--SELECT GEADE ,LOSAL FROM salgrade .
SELECT grade , losal
FROM salgrade
WHERE losal > 2000
;

SELECT grade "SALARY GRADE"
FROM salgrade;

--Selecting Data from Two Tables (Joining Two Tables).
SELECT emp.ename "EMPLOYEE NAME" ,dept.dname "DEPARTMENT NAME"
FROM emp , dept
WHERE emp.deptno = dept.deptno
 ;
 --14.display data from emp table whose joined in the month of jan.
SELECT *
FROM emp

WHERE (ename LIKE 'A%'  ) AND to_char(hiredate,'YYYY') = 1987;

---
SELECT *
FROM emp 
WHERE to_char(hiredate, 'mon')='jan';


SELECT deptno, MIN(sal) ,MAX(sal) , AVG(sal)
FROM emp 
GROUP BY deptno
;
