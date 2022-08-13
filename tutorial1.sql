Select EmployeeID, FirstName, Age
from EmployeeDemographics
Union
Select EmployeeID, JbTitle, Salary
from EmployeeSalary
Order by EmployeeID


Select FirstName, LastName, Age,
case
when Age > 30 then 'old'
when Age between 27 and 30 then 'Young'
else 'Baby' 
end
from EmployeeDemographics
where Age is not null
Order by Age

Select FirstName, LastName, JbTitle, Salary,
case
when JbTitle= 'Salesman' Then Salary +(Salary* .10)
When JbTitle= 'Accountant' Then Salary + (Salary* .05)
when JbTitle = 'HR' Then Salary + (Salary* .000001)
else Salary + (Salary* .03)
end as Salary_After_Raise
from EmployeeDemographics
Join EmployeeSalary
on EmployeeDemographics.EmployeeID= EmployeeSalary.EmployeeID


Select JbTitle, Count(JbTitle) as Numm
from EmployeeDemographics
Join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group by JbTitle
Having Count(JbTitle) >1

Select *
From EmployeeDemographics
Update EmployeeDemographics
Set Age = 31, Gender = 'Female'
Where FirstName = 'Holly' And LastName = 'Flax'


Select *
 from EmployeeDemographics
Where EmployeeID = 1004



--Aliasing
Select FirstName + ' ' + LastName as FullName
from EmployeeDemographics

Select Avg(Age) as Average_Age
from EmployeeDemographics

 Partition By
Select FirstName, LastName, Gender, Salary,
Count (Gender) over (Partition by Gender) as TotalGender
From EmployeeDemographics dem
Join EmployeeSalary sal
on dem.EmployeeID= sal.EmployeeID

With CTE_Employee as
(Select FirstName, LastName, Gender, Salary, 
Count(Gender) over (Partition by Gender) as totalGender, 
AVG(Salary) over (Partition by Gender) as AvgSalary)
from EmployeeDemographics emp
Join EmployeeSalary sal
on emp.EmployeeID = sal.EmployeeID
where Salary >'45000'
)

Select FirstName, AvgSalary
From CTE_Employee



--temp tables
Create Table #temp_Employee(
EmployeeID int,
JobTitle varchar(100),
Salary int
)



Insert into #temp_Employee values
(1001, 'HR', 4500)


Insert into #temp_Employee
select *
from tutorial1..EmployeeSalary

Select *
from #temp_Employee


--tempTable2
Create Table #Temp_Employee2(
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalar int
)

Insert into #Temp_Employee2 
Select JbTitle, Count(JbTitle), Avg(Age), Avg(Salary)
from tutorial1..EmployeeDemographics emp
Join tutorial1..EmployeeSalary sal
on emp.EmployeeID= sal.EmployeeID
group by JbTitle


--select *
--from #Temp_Employee2


--cleaning, trim, ltrim, rtrim



--Stored procedures
Create Procedure test
as
select *
from EmployeeDemographics

exec test

create procedure Temp_Employee
AS
create table #temp_employee
(
JbTitle varchar(100),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)


insert into #temp_employee
select JbTitle, count(JbTitle), Avg(Age), Avg(salary)
from EmployeeDemographics emp
join EmployeeSalary sal
on emp.EmployeeID = sal.EmployeeID
group by JbTitle



--subqueries
Select * 
from EmployeeSalary

select EmployeeID, Salary, (Select Avg(Salary) from EmployeeSalary) as All_Avg
from EmployeeSalary


select a.EmployeeID
from (select EmployeeID, Salary
		from EmployeeSalary) a


 --How to do it with partition by
Select EmployeeID, Salary, Avg(Salary) over () as AllAvgSalary
from EmployeeSalary

