
--WINDOW FUNCTION (ANLAYTICS FUNCTIONS)
--=====================================

Select * from EMPLOYEES
Select * from Company_and_Courses

Select NAME ,MAX(salary) as max_sal
from EMPLOYEES
group by NAME 

-- it will make a extra column for max salary and will insert max salary for all the rows.
-- here max will not act as a aggregate function but it will treat like a window function.
-- SQL will make a one window for all the rows.
Select e.*,
max(SALARY) over() as max_salary
from EMPLOYEES e


Select e.*,
max(SALARY) over(partition by location) as max_salary
from EMPLOYEES e


--ROW_NUMBER() Example - 1
----------------------------
Select e.*, 
ROW_NUMBER() over(partition by jobtitle order by salary desc) as order_of_salary_by_jobtitle
from EMPLOYEES e

--ROW_NUMBER() Example - 2
----------------------------
Select e.*, 
ROW_NUMBER() over(order by jobtitle)
from EMPLOYEES e

--ROW_NUMBER() Example - 3
----------------------------
Select * from (	
	Select e.*, 
	ROW_NUMBER() over(partition by jobtitle order by salary desc) as order_of_salary_by_jobtitle
	from EMPLOYEES e ) x
where x.order_of_salary_by_jobtitle > 1


--RANK() Example - 1
---------------------
Select e.*, 
RANK() over(order by jobtitle) as order_using_rank
from EMPLOYEES e

--RANK() Example - 2
---------------------
Select e.*, 
RANK() over(partition by jobtitle order by salary) as order_of_salary_by_jobtitle
from EMPLOYEES e


--DENSE_RANK() Example - 1
---------------------------
Select e.*, 
DENSE_RANK() over(order by jobtitle)
from EMPLOYEES e

--DENSE_RANK() Example - 2
---------------------------
Select e.*, 
DENSE_RANK() over(partition by jobtitle order by salary) as order_of_salary_by_jobtitle
from EMPLOYEES e

--DENSE_RANK() Example - 3
---------------------------
Select * from (	
	Select e.*, 
	DENSE_RANK() over(partition by jobtitle order by salary) as order_of_salary_by_jobtitle
	from EMPLOYEES e ) x
where x.order_of_salary_by_jobtitle <= 2


--COMBINING EVERY WINDOW FUNCTION - Example - 1
-------------------------------------------------
Select e.*,
rank() over(partition by jobtitle order by salary desc) as rnk,
dense_rank() over(partition by jobtitle order by salary desc) as dense_rnk,
row_number() over(partition by jobtitle order by salary desc) as row_num
from EMPLOYEES e

--COMBINING EVERY WINDOW FUNCTION - Example - 2
-------------------------------------------------
Select e.*,
rank() over(order by salary desc) as rnk,
dense_rank() over(order by salary desc) as dense_rnk,
row_number() over( order by salary desc) as row_num
from EMPLOYEES e


--LAG()  Example - 1 
--------------------------
-- fetch a query if the salary of an employee is higher, lower or equal to the previous employee.
Select e.* ,
lag(salary) over (partition by jobtitle order by E_ID) as prev_emp_salary
from Employees e


--LAG()  Example - 2 
--------------------------
-- instead of null it will show us 0 and it will look for 1 previous or next value.
-- you can do for 2 instead of 1 also.
Select e.* ,
lag(salary,1,0) over (partition by jobtitle order by E_ID) as prev_emp_salary
from Employees e


-- COMBINING LAG() AND LEAD()
--------------------------------
Select e.* ,
lag(salary) over (partition by jobtitle order by E_ID) as prev_emp_salary,
lead(salary) over (partition by jobtitle order by E_ID) as next_emp_salary
from Employees e

