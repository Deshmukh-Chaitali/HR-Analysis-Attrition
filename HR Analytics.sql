create database projects;
create schema HR_Analytics;

use projects;

show databases;

desc hr_1; 
desc hr_2;

show tables ;

select * from hr_1;
select count(*) from hr_1;

select * from hr_2;

## 1.  attrition rate wrt departments

SELECT
    Department,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS AttritionCount,
    COUNT(*) AS TotalEmployees,
    100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) AS AttritionRate
FROM Hr_1 
GROUP BY Department;

## 2.   average hourly rate for male research scientist

select jobrole, gender, avg(hourlyrate)*100 as average_Hourly_Rate
from hr_1
where gender = "male" and jobrole = "research scientist";


## 3. Attrition rate and monthly income stats against department

select department, count(CASE WHEN monthlyincome between 1000 And 10000 then 1 end) as "bet 1000 to 10000"
				, count(CASE WHEN monthlyincome between 10001 And 20000 then 1 end) as "bet 100001 to 20000"
                , count(CASE WHEN monthlyincome between 20001 And 30000 then 1 end) as "bet 20001 to 30000"
				, count(CASE WHEN monthlyincome between 30001 And 40000 then 1 end) as "bet 30001 to 40000"
				, count(CASE WHEN monthlyincome between 40001 And 50000 then 1 end) as "bet 40001 to 50000"
                , count(CASE WHEN monthlyincome > 50000 then 1 end) as "Above 50000"
from HR_1 as a 
inner join HR_2 as b on
a.employeenumber=b.`employee Id`
group by department;

select * from hr_2;
select count(*) from hr_2;

## 4. Average working years for each department
select * from hr_2;

select a.department, avg(b.yearsatcompany) as Average_Working_years_at_company
from hr_1 as a
inner join hr_2 as b on 
a.Employeenumber=b.`employee Id`
group by a.department
order by a.department;

select a.department, avg(b.totalworkingyears) as Average_Working_years
from hr_1 as a
inner join hr_2 as b on 
a.Employeenumber=b.`employee Id`
group by a.department
order by a.department;

## 5. Job Role v/s work life balance

select a.jobrole , count(CASE WHEN `worklifebalance` = 1 THEN 1 end) as VeryPoor_WorkLife
				, count(CASE WHEN worklifebalance = 2 THEN 1 end) as Poor_WorkLife				
                , count(CASE WHEN worklifebalance = 3 THEN 1 end) as Good_WorkLife               
				, count(CASE WHEN worklifebalance = 4 THEN 1 end) as Excellent_WorkLife
                , count(*) as total_count
from HR_1 as a 
inner join HR_2 as b on
a.employeenumber=b.`employee Id`
group by jobrole;

## 6. Attrition rate v/s year since last promotion

select a.jobrole, concat(format(avg(a.attrition_rate)*100,2), '%') AS Avg_Attrition_Rate
, format(avg(b.yearssincelastpromotion),2) as Avg_YearsSinceLastPromotion
from ( select jobrole , attrition, employeenumber,
case when attrition = 'yes' then 1 
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on
b.`employee id`=a.employeenumber
group by a.jobrole;