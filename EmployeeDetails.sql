/* Here is Table Script*/
CREATE TABLE EmployeeDetails (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Department VARCHAR(50),
Salary DECIMAL(10,2),
HireDate DATE);

/* Inserting data into EmployeesTable */
INSERT INTO EmployeeDetails (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
(1, 'Amit'   , 'Sharma'   , 'HR'       , 50000.00, '2015-05-20'),
(2, 'Anjali' , 'Singh'    , 'IT'       , 60000.00, '2017-08-15'),
(3, 'Rahul'  , 'Verma'    , 'Marketing', 55000.00, '2020-01-10'),
(4, 'Priya'  , 'Reddy'    , 'Finance'  , 65000.00, '2017-04-25'),
(5, 'Vikram' , 'Patel'    , 'HR'       , 52000.00, '2017-09-30'),
(6, 'Amit'  , 'Mishra'   , 'IT'        , 62000.00, '2021-11-18'),
(7, 'Suresh' , 'Iyer'     , 'Marketing', 58000.00, '2024-02-26'),
(8, 'Lakshmi', 'Menon'    , 'Finance'  , 70000.00, '2022-07-12'),
(9, 'Arjun'  , 'Menon'    , 'HR'       , 53000.00, '2023-10-05'),
(10, 'Nisha' , 'Mehta'    , 'IT'       , 64000.00, '2016-03-08');


# Question 1:  Retrieve only the FirstName and LastName of all employees.
Select FirstName, LastName from Employeedetails;

# Question 2: Retrieve distinct departments from the employeeDetails table.
Select distinct Department from Employeedetails;

# Question 3: Retrieve employees whose salary is greater than 55000.
Select * from Employeedetails
where Salary > 55000;

# Question 4 : Retrieve employees hired after 2019.
Select * from Employeedetails
where HireDate > '2019-12-31';

# Question 5: Retrieve employees whose first name starts with ‘A’.
Select * from employeedetails
where FirstName like 'A%';

# Question 6 :Retrieve employees whose last name ends with ‘non’.
Select * from employeedetails
where LastName like '%non';

# Question 7: Retrieve employees whose First name do not have ‘a’.
Select * from employeedetails
where FirstName not like '%a%';

# Question 8 :Retrieve employees sorted by their salary in descending order.
Select * from employeedetails order by Salary DESC;

# Question 9: Retrieve the count of employees in each department.
Select Department, Count(*) as EmployeeCount
from employeedetails Group By Department;

# Question 10 :Retrieve the average salary of employees in the Finance department.
Select Avg(Salary) as AverageSalary
from employeedetails where Department = 'Finance';

# Question 11: Retrieve the maximum salary among all employees.
Select max(Salary) as MaxiumSalary
from employeedetails;

# Question 12 :Retrieve the total salary expense for the company.
Select sum(Salary) as TotalSalaryExpense from employeedetails;

# Question 13: Retrieve the oldest and newest hire date among all employees.
Select MIN(HireDate) as OldestHireDate, Max(HireDate) as NewestHireDate
From Employeedetails;

# Question 14 :Retrieve employees with a salary between 50000 and 60000.
Select * from EmployeeDetails where Salary Between 50000 and 60000;

# Question 15: Retrieve employees who are in the HR department and were hired before 2019.
Select * from employeedetails where Department = 'HR'
and HireDate < '2019-01-01';

# Question 16 :Retrieve employees with a salary less than the average salary of all employees.
Select * from employeedetails where Salary < (Select AVG(Salary) 
from employeedetails);

# Question 17: Retrieve the top 3 highest paid employees.
Select * from employeedetails Order by Salary DESC
Limit 3 ;

# Question 18 : Retrieve employees whose hire date is not in 2017.
Select * from employeedetails where Year (HireDate) <> 2017;

# Question 19 : Retrieve the nth highest salary (you can choose the value of n).
SELECT DISTINCT Salary 
FROM employeedetails 
ORDER BY Salary DESC 
LIMIT 1 OFFSET 2;

# Question 20 : Retrieve employees who were hired in the same year as ‘Priya Reddy’.
Select Distinct Salary from employeedetails 
where year(HireDate) = (Select Year(HireDate) from employeedetails
where FirstName = 'Priya' and LastName = 'Reddy');

# Question 21 : Retrieve employees who have been hired on weekends (Saturday or Sunday).
SELECT * FROM employeedetails WHERE WEEKDAY(HireDate) IN (1, 7);

# Question 22 : Retrieve employees who have been hired in the last 6 years.
Select * from employeedetails where year(HireDate) >= -6;

# Question 23 : Retrieve the department with the highest average salary.
Select Department from employeedetails
Group by Department 
Having Avg(Salary) = (
	Select Max(AvgSalary)
    from (
        Select Avg(Salary) as AvgSalary
        from employeedetails
        group by Department
	) As AvgSalaries
);
# Question 24 : Retrieve the top 2 highest paid employees in each department.
Select EmployeeID, FirstName, LastName, Department, Salary
From (
     Select EmployeeID, FirstName, LastName, Department, Salary,
     Row_number() over(Partition by Department order by Salary Desc) as Rank_h
     from employeedetails
     ) as Rankdemployeedetails
     where Rank_h <= 2;

# Question 25 : Retrieve the cumulative salary expense for each department sorted by department and hire date.
Select EmployeeID, FirstName, LastName, Department, Salary, HireDate,
Sum(Salary) Over(Partition By Department Order BY HireDate) as CumulativeSalaryExpense
From employeeDetails
order by Department, HireDate;

# Question 26 : Retrieve the employee ID, salary, and the next highest salary for each employee.
Select EmployeeID, Salary, 
Lead(Salary) Over(Order by Salary Desc) as NextHighestSalary
From employeeDetails;

# Question 27 : Retrieve the employee ID, salary, and the difference between the current salary and the next highest salary for each employee.
Select EmployeeID, Salary,
Salary - Lead(Salary) over (Order by Salary Desc) as SalaryDifference
from employeedetails;

# Question 28 : Retrieve the employee(s) with the highest salary in each department.
SELECT EmployeeID, FirstName, LastName, Department, Salary
FROM (
    SELECT EmployeeID, FirstName, LastName, Department, Salary,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS Rank_h
    FROM employeedetails
) AS RankedEmployees
WHERE Rank_h = 1;

# Question 29 : Retrieve the department(s) where the total salary expense is greater than the average total salary expense across all departments.
Select Department, Sum(Salary) as TotalSalaryExpense
from employeedetails 
group by Department
having Sum(Salary) >
(Select avg(TotalSalaryExpense) from
            (Select Sum(Salary) as TotalSalaryExpense
            From employeeDetails Group by Department) as AvgTotalSalary);
            
# Question 30 : Retrieve the employee(s) who have the same first name and last name as any other employee.
Select * From employeedetails e1
where Exists (
    Select 1
    from employeeDetails e2
    where e1.EmployeeID != e2.EmployeeID
    and e1.FirstName = e2.FirstName
    and e1.LastName = e2.LastName );

# Question 31 : Retrieve the employee(s) who have been with the company for more then 7 Years.
SELECT FirstName, LastName, TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsWithCompany
FROM employeedetails
WHERE TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) > 7;

# Question 32 : Retrieve the department with the highest salary range (Difference b/w highest and lowest).
Select Department, Max(Salary) - Min(Salary) as Range_h
from employeedetails
group by Department
order by Range_h Desc;
