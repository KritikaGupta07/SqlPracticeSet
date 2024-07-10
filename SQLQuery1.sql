
 create table student(
	roll_number integer Primary Key,
	name varchar(50)
 );

 insert into student values(1,'a');
 insert into student values(2,'b');
 insert into student values(3,'c');

  create table mark(
	roll_number integer,
	s1 integer,
	s2 integer,
	s3 integer
 );

 insert into mark values(1, 29, 30, 50);
 insert into mark values(2, 10, 30, 20);
 insert into mark values(3, 20, 20, 20);

 select * from mark;


 select * from student;
 select * from mark;

 with cal as (select roll_number, (s1+s2+s3) as total from mark)
 
 select s.roll_number, c.total
 from student s inner join cal c on s.roll_number = c.roll_number where c.total < 100;
 
 ;


-------------------------------------------------------------------------------------------------
 create table emp(
 emp_id integer,
 emp_name varchar(50),
 department_id integer,
 salary integer
 );


 insert into emp values(1, 'Ankit', 100, 10000);
 insert into emp values(2, 'Mohit', 100, 15000);
 insert into emp values(3, 'Vikas', 100, 10000);
 insert into emp values(4, 'Rohit', 100, 5000);
 insert into emp values(5, 'Mudit', 200, 12000);
 insert into emp values(6, 'Agam', 200, 12000);
 insert into emp values(7, 'Sanjay', 200, 9000);
 insert into emp values(8, 'Ashish', 200, 5000);


 select * from emp;


 select emp_id, emp_name, department_id,salary,
 Rank() over(partition by department_id order by salary desc) as rnk,
 Dense_Rank() over(partition by department_id order by salary desc) as d_rnk,
 Row_Number() Over(partition by department_id order by salary desc) as rk
 from emp;

 select * from(
 select emp_id, emp_name, department_id, salary, 
 Rank() Over(partition by department_id order by salary desc) as rnk
 from emp) a where rnk = 1;

 create table Match(
 team_1 varchar(50),
 team_2 varchar(50),
 winner varchar(50)
 );


 insert into Match values('India' , 'Sl' , 'India');
 insert into Match values('Sl' , 'Aus' , 'Aus');
 insert into Match values('SA' , 'Eng' , 'Eng');
 insert into Match values('Eng' , 'NZ' , 'NZ');
 insert into Match values('Aus' , 'India' , 'India');


 select * from Match;


 
 select team_name, count(1) as no_of_match_played, sum(win_flag) as no_of_match_won , count(1) - sum(win_flag) as no_of_match_losses
 from(
 select team_1 as team_name , case when team_1 = winner then 1 else 0 end as win_flag from Match
 union all
 select team_2 as team_name , case when team_2 = winner then 1 else 0 end as win_flag from Match) A
 group by team_name
 order by no_of_match_won desc;

 
 

  create table Employee
 (
	emp_id integer,
	emp_name varchar(50),
	salary integer,
	manager_id integer
 );

 
 insert into Employee values(1, 'Ankit', 10000, 4);
 insert into Employee values(2, 'Mohit', 15000, 5);
 insert into Employee values(3, 'Vikas', 10000, 4);
 insert into Employee values(4, 'Rohit', 5000, 2);
 insert into Employee values(5, 'Mudit', 12000, 6);
 insert into Employee values(6, 'Agam', 12000, 2);
 insert into Employee values(7, 'Sanjay', 9000, 2);
 insert into Employee values(8, 'Ashish', 5000, 2);

 select * from Employee;

 select e.emp_id, e.emp_name, m.emp_name as manager_name, e.salary , m.salary as manager_salary
 from Employee e 
 inner join
 Employee m on e.manager_id = m.emp_id
 where e.salary > m.salary;



 create table customer_orders(
 order_id integer,
 customer_id integer,
 order_date date,
 order_amount integer
 );

 insert into customer_orders values(1, 100, '2022-01-01', 2000);
 insert into customer_orders values(2, 200, '2022-01-01', 2500);
 insert into customer_orders values(3, 300, '2022-01-01', 2100);
 insert into customer_orders values(4, 100, '2022-01-02', 2000);
 insert into customer_orders values(5, 400, '2022-01-02', 2200);
 insert into customer_orders values(6, 500, '2022-01-02', 2700);
 insert into customer_orders values(7, 100, '2022-01-03', 3000);
 insert into customer_orders values(8, 400, '2022-01-03', 1000);
 insert into customer_orders values(9, 600, '2022-01-03', 3000);

 select * from customer_orders;

 with first_Visit as (
 select customer_id , min(order_date) as first_visit_date 
 from customer_orders group by customer_id),

 visit_flag as (
 select co.*,fv.first_visit_date,
 case when co.order_date = fv.first_visit_date then 1 else 0 end as new_customer,
 case when co.order_date != fv.first_visit_date then 1 else 0 end as repeat_customer
 from customer_orders co inner join first_Visit fv 
 on co.customer_id = fv.customer_id
 )
 select order_date, sum(new_customer) as new , sum(repeat_customer) as repeat 
 from visit_flag group by order_date;



 -------------------------------------------------------------------
 ---How to find duplicate in a given table 
 

 create table empTable(
 emp_id integer,
 emp_name varchar(50),
 department_id integer,
 salary integer,
 manager_id integer
 );

 insert into empTable values(1,'Ankit', 100, 10000, 4);
 insert into empTable values(2,'Mohit', 100, 15000, 5);
 insert into empTable values(3,'Vikas', 100, 10000, 4);
 insert into empTable values(4,'Rohit', 100, 5000, 2);
 insert into empTable values(5,'Mudit', 200, 12000, 6);
 insert into empTable values(6,'Agam', 200, 12000, 2);
 insert into empTable values(7,'Sanjay', 200, 9000, 2);
 insert into empTable values(8,'Ashish', 200, 5000, 2);
 insert into empTable values(1,'Saurabh', 900, 12000, 2);

 select * from empTable;

 
 select emp_id , count(1) as totalCount from empTable group by emp_id having Count(1) > 1;

 ----------------------------------------------------------------------------------------------------

 --- How to delete duplicates

 create table empTable1(
 emp_id integer,
 emp_name varchar(50),
 department_id integer,
 salary integer,
 manager_id integer
 );

 insert into empTable1 values(1,'Ankit', 100, 10000, 4);
 insert into empTable1 values(2,'Mohit', 100, 15000, 5);
 insert into empTable1 values(3,'Vikas', 100, 10000, 4);
 insert into empTable1 values(4,'Rohit', 100, 5000, 2);
 insert into empTable1 values(5,'Mudit', 200, 12000, 6);
 insert into empTable1 values(6,'Agam', 200, 12000, 2);
 insert into empTable1 values(7,'Sanjay', 200, 9000, 2);
 insert into empTable1 values(8,'Ashish', 200, 5000, 2);
 insert into empTable1 values(1,'Saurabh', 900, 12000, 2);

 select * from empTable1;

 with cte as (
 select emp_id, emp_name, department_id, salary , manager_id ,
 row_number() over(partition by emp_id order by emp_id) as rnk
 from empTable1)
 
 delete from cte where rnk>1;

 select * from empTable1;

 ---------------------------------------------------------

 --Difference between union and union all

 select * from empTable;
 select * from empTable1;


 --Union all will return the combination of both the table
 select manager_id from empTable
 union all
 select manager_id from empTable1;

 ---Union will return only the unique value
 select manager_id from empTable
 union 
 select manager_id from empTable1;

 --------------------------------------------------------------

 ---Employees who are not present in department table

 select * from empTable;

 create table department(
 department_id integer,
 department_name varchar(50)
 );


 insert into department values(100, 'Analytics');
 insert into department values(300, 'IT');

 select * from empTable;
 select * from department;

 select * from empTable where department_id not in (select department_id from department);

 ---------------------------------------------------------------------

 --Second highest salary in each department

 select * from empTable;

 with cte as 
 (select  emp_name, department_id , salary, 
 DENSE_RANK() over(partition by department_id order by salary desc ) as drnk
 from empTable)
 
 select department_id, emp_name, salary from cte where drnk =2;

 ----------------------------------------------------------------------------

 --Find all transaction done by Shilpa

 create table orders(
 customer_name varchar(50),
 order_date date,
 order_amount integer,
 customer_gender varchar(50)
 );

 insert into orders values('Shilpa', '2020-01-01', 10000, 'Male');
 insert into orders values('Rahul', '2020-01-02', 12000, 'Female');
 insert into orders values('SHILPA', '2020-01-02', 12000, 'Male');
 insert into orders values('Rohit', '2020-01-03', 15000, 'Female');
 insert into orders values('shilpa', '2020-01-03', 14000, 'Male');


 select * from orders;

 select * from orders where upper(customer_name) = 'SHILPA';

 ------------------------------------------------------------------------------------------

 --Update query to swap gender

 select * from orders;

 update orders set
 customer_gender = case when customer_gender = 'Female' then 'Male' 
						when customer_gender = 'Male' then 'Female' end;

select * from orders;



 -----------------------------------------------------------------------------------------

 ---Self join manager salary > employee salary

 select * from empTable;

 select e.emp_id , e.emp_name,  m.emp_name as manager_name, e.salary , m.salary as manager_salary
 from empTable e inner join 
 empTable m on e.emp_id = m.manager_id
 where m.salary  > e.salary;

 ---------------------------------------------------------------------------------------------------------


 create table entries(
 name varchar(50),
 address varchar(50),
 email varchar(50),
 floor integer,
 resources varchar(50)
 );

 insert into entries values('A','Bangalore','A@gmail.com',1,'CPU');
 insert into entries values('A','Bangalore','A1@gmail.com',1,'CPU');
 insert into entries values('A','Bangalore','A2@gmail.com',2,'Desktop');
 insert into entries values('B','Bangalore','B@gmail.com',2,'Desktop');
 insert into entries values('B','Bangalore','B1@gmail.com',2,'Desktop');
 insert into entries values('B','Bangalore','B2@gmail.com',1,'Monitor');

 select * from entries;

 ----------------------------------
 --Note---
 --string_agg() function

 select name, STRING_AGG(resources, ',') from entries group by name;

--output
 --- name   resources
 ---  A	    CPU,CPU,Desktop
 ---  B	    Desktop,Desktop,Monitor
 


 with distinct_resource as (select distinct name, resources from entries)
 ,agg_resources as (select name, STRING_AGG(resources,',') as used_resource from distinct_resource group by name)
 ,total_visits as
 (select name, count(1) as total_visit , STRING_AGG(resources,',') as resources_used 
 from entries 
 group by name)
 ,floor_visit as
 (select name, floor, count(1) as no_of_floor_visit,
 rank() over(partition by name order by count(1) desc) as rnk
 from entries group by name, floor)
 
 select fv.name, fv.floor as most_visited_floor , tv.total_visit , ar.used_resource
 from floor_visit fv 
 inner join total_visits tv on fv.name = tv.name
 inner join agg_resources ar on fv.name = ar.name
 where rnk = 1;


 ---------------------------------------------------------------------


 ----datepart

 ---datepart         abbreviations
 ---year				yy,yyyy
 ---quarter				qq,q
 ---month				mm,m
 ---dayofyear			dy, y
 ---day					dd, d
 ---week				wk,ww
 ---weekday				dw
 ---hour				hh
 ---minute				mi, n
 ---second				ss, s
 ---millisecond			ms
 ---microsecond			mcs
 ---nanosecond			ns
 ---tzoffset			tz
 ---iso_week			isowk, isoww

 select DATEPART(day,'2024-05-17')

 select DATEPART(WEEKDAY,'2024-05-17')

 select DATEPART(year,'2024-05-17')

 select DATEPART(quarter,'2024-05-17')

 select DATEPART(MONTH,'2024-05-17')

 -----------------------------------------------------------

 ---dateadd function

 select DATEADD(day,2 , '2024-05-17')

 select DATEADD(year,1 , '2024-05-17')

 select DATEADD(year,2 , '2024-05-17')

 select DATEADD(month,2 , '2024-05-17')

 select DATEADD(month,5 , '2024-05-17')

 ------------------------------------------------------------------

 ---datediff function

 select DATEDIFF(day,'2024-05-17','2024-05-20')  ---output 3

 select DATEDIFF(day,'2024-05-20','2024-05-17') --- output -3

 ------------------------------------------------------------------------
 
 
 create table customer_orders_date(
 order_id integer,
 customer_id integer,
 order_date date,
 ship_date date
 );

 insert into customer_orders_date values(1000,1, '2022-01-05', '2022-01-11');
 insert into customer_orders_date values(1001,2, '2022-02-04', '2022-02-16');
 insert into customer_orders_date values(1002,3, '2022-01-01', '2022-01-19');
 insert into customer_orders_date values(1003,4, '2022-01-06', '2022-01-30');
 insert into customer_orders_date values(1004,1, '2022-02-07', '2022-02-13');
 insert into customer_orders_date values(1005,4, '2022-01-07', '2022-01-31');
 insert into customer_orders_date values(1006,3, '2022-02-08', '2022-02-26');
 insert into customer_orders_date values(1007,2, '2022-02-09', '2022-02-21');
 insert into customer_orders_date values(1008,4, '2022-02-10', '2022-03-06');

 select * from customer_orders_date;

 select *, DATEDIFF(day,order_date,ship_date) as no_of_days_ship,
 DATEDIFF(week,order_date,ship_date) as week_between_days,
 DATEDIFF(day,order_date,ship_date) - 2*DATEDIFF(week,order_date,ship_date) as business_day_to_ship
 from customer_orders_date;


 --- To calculate the business days then 

 --  DATEDIFF(day,order_date,ship_date) - 2*DATEDIFF(week,order_date,ship_date) as business_day_to_ship

 ----------------------------------------------------------------------------------------------------

 create table customer(
 customer_id integer,
 customer_name varchar(50),
 gender varchar(50),
 dob date
 );

 insert into customer values(1,'Rahul', 'M', '2000-01-05');
 insert into customer values(2,'Shilpa', 'F', '2004-04-05');
 insert into customer values(3,'Ramesh', 'M', '2003-07-07');
 insert into customer values(4,'Katrina', 'F', '2005-02-05');
 insert into customer values(5,'Alia', 'F', '1992-01-01');

 select * from customer;

 ---To get the today'sdate we have function name getdate()

 select GETDATE()

 select *, DATEDIFF(YEAR,dob,GETDATE())  as customer_age from customer;
 
 
 
 -----------------------------------------------------------------------------------------

 create table employee_pivot(
 emp_id integer,
 salary_componen_type varchar(50),
 val integer
 );

 insert into employee_pivot values(1, 'salary', 10000);
 insert into employee_pivot values(1, 'bonus', 5000);
 insert into employee_pivot values(1, 'hike_percent', 10);
 insert into employee_pivot values(2, 'salary', 15000);
 insert into employee_pivot values(2, 'bonus', 7000);
 insert into employee_pivot values(2, 'hike_percent', 8);
 insert into employee_pivot values(3, 'salary', 12000);
 insert into employee_pivot values(3, 'bonus', 6000);
 insert into employee_pivot values(3, 'hike_percent', 7);


 select * from employee_pivot;

 select emp_id,
 sum(case when salary_componen_type = 'salary' then val end) as salary,
 sum(case when salary_componen_type = 'bonus' then val end) as bonus,
 sum(case when salary_componen_type = 'hike_percent' then val end) as hike_percent
 from employee_pivot
 group by emp_id;

 ----------------------------------------------------------------------------------------------------
 

 create table person(
 person_id integer,
 name varchar(50),
 email varchar(50),
 score integer
 );

 insert into person values(1,'Alice', 'alice2018@hotmail.com', 88);
 insert into person values(2,'Bob', 'bob2018@hotmail.com', 11);
 insert into person values(3,'Davis', 'davis2018@hotmail.com', 27);
 insert into person values(4,'Tara', 'tara2018@hotmail.com', 45);
 insert into person values(5,'John', 'john2018@hotmail.com', 63);

 select * from person;

 create table friend(
 person_id integer,
 friend_id integer
 );

 insert into friend values(1,2);
 insert into friend values(1,3);
 insert into friend values(2,1);
 insert into friend values(2,3);
 insert into friend values(3,5);
 insert into friend values(4,2);
 insert into friend values(4,3);
 insert into friend values(4,5);

 select * from friend;


 select * from person;
 select * from friend;

 with score_details as 
 (select f.person_id,  sum(p.score) as friend_score, count(1) as no_of_friend  from friend f 
 inner join person p on f.friend_id = p.person_id
 group by f.person_id
 having sum(p.score) > 100)
 
 select s.*, p.name as person_name
 from person p inner join score_details s 
 on p.person_id = s.person_id;

 --------------------------------------------------------------------------------------------------------
 
 create table emp_case
 (
 emp_id integer,
 emp_name varchar(50),
 department_id integer,
 salary integer,
 manager_id integer,
 emp_age integer
 );

 insert into emp_case values(1,'Ankit', 100, 10000, 4, 39);
 insert into emp_case values(2,'Mohit', 100, 15000, 5, 48);
 insert into emp_case values(3,'Vikas', 100, 10000, 4, 37);
 insert into emp_case values(4,'Rohit', 100, 5000, 2, 16);
 insert into emp_case values(5,'Mudit', 200, 12000, 6, 55);
 insert into emp_case values(6,'Agam', 200, 12000, 2, 14);
 insert into emp_case values(7,'Sanjay', 200, 9000, 2, 13);
 insert into emp_case values(8,'Ashish', 200, 5000, 2, 12);
 insert into emp_case values(9,'Mukesh', 300, 6000, 6, 51);
 insert into emp_case values(10,'Rakesh', 300, 7000, 6, 50);

 select * from emp_case;

 
select *,
case 
	when emp_age < 20 then 'Kids'
	when emp_age >= 20 and emp_age <= 40  then 'Adult'
	else 'Old'
end as emp_age_bucket
from emp_case
order by emp_age;

select * from department;

insert into department values(200,'HR');

select e.emp_name, e.salary, d.department_name,
case 
	when d.department_name = 'Analytics' then e.salary + 0.2 * e.salary
	when d.department_name = 'IT' then e.salary + 0.15 * e.salary
	else e.salary + 0.25 * e.salary
end as new_salary
from emp_case  e
inner join department  d
on e.department_id = d.department_id;
 
 ----------------------------------------------------------------------------------------------------

Create table  Trips 
(
id int, 
client_id int, 
driver_id int, 
city_id int, 
status varchar(50), 
request_at varchar(50)
);

Create table Users 
(
users_id int, 
banned varchar(50), 
role varchar(50)
);

Truncate table Trips;

insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values 
('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');


Truncate table Users;

insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');


select * from Trips;
select * from Users;

select request_at,
count(case when status in ('cancelled_by_client','cancelled_by_driver') then 1 else null
end) as cancelled_trip_count,
COUNT(1) as total_trips,
1.0 * count(case when status in ('cancelled_by_client','cancelled_by_driver') then 1 else null end) / COUNT(1) * 100 as cancelled_percent
from Trips t inner join Users c on t.client_id = c.users_id
inner join Users d on t.driver_id = d.users_id
where c.banned = 'No' and d.banned = 'No'
group by request_at;


-----------------------------------------------------------------------------------------------------------


select * from department;

insert into department values(400, 'Text Analytics');

--------------------------------------------------------------------------------------------
--replace() of string

select *, replace(department_name,'Analytic','Mining') as replace_word_with_little_matching,
replace(department_name,'Analytics','Mining') as replace_word
from department;

-----stuff(column_name, position, length, string)

select *, replace(department_name,'Analytic','Mining') as replace_word_with_little_matching,
replace(department_name,'Analytics','Mining') as replace_word,
STUFF(department_name, 1, 3, 'demo') as stuff_string
from department;

---substring()

select *, replace(department_name,'Analytic','Mining') as replace_word_with_little_matching,
replace(department_name,'Analytics','Mining') as replace_word,
STUFF(department_name, 1, 3, 'demo') as stuff_string, -- from position first three character will be replaced by demo
SUBSTRING(department_name,2, 3) as substring_string -- from second position return three character
from department;


---translate()


select *, replace(department_name,'Analytic','Mining') as replace_word_with_little_matching,
replace(department_name,'Analytics','Mining') as replace_word,
STUFF(department_name, 1, 3, 'demo') as stuff_string, -- from position first three character will be replaced by demo
SUBSTRING(department_name,2, 3) as substring_string, -- from second position return three character
TRANSLATE(department_name,'AR', 'ST') as translate_string ---replace the character 'A' with 'S' and 'R' with 'T' kind of one to one mapping
from department;


----------------------------------------------------------------------------------------------------------

----Calculate median for even and odd no of outcomes 

----- for even,
--- 1,2,3,4,5,6 = (3+4)/2 = 3.5 

-----for odd,
----1,2,3,4,5,6,7,8,9 = 5

---- There are different ways to calculate median in sql 
-----1. row_number() for both odd and even

select * from emp_case;

--- for odd no of outcomes

with age_odd_median as(
select * 
, row_number() over(order by emp_age asc) as rnk_asc
, row_number() over(order by emp_age desc) as rnk_desc
from emp_case 
where emp_id < 10
)

select * from age_odd_median 
where abs(rnk_asc - rnk_desc) <= 1
order by emp_age asc;

---- For even no_of_outcome

with cte_age_even as(
select *
,ROW_NUMBER() over(order by emp_age asc) as rnk_asc
,ROW_NUMBER() over(order by emp_age desc) as rnk_desc
from emp_case)

select * from cte_age_even 
where abs(rnk_asc - rnk_desc) <= 1
order by emp_age;

---------------------------------------------------------------------------------------------------

create table task(
date_value date,
state varchar(50)
);


insert into task values('2019-01-01','success');
insert into task values('2019-01-02','success');
insert into task values('2019-01-03','success');
insert into task values('2019-01-04','fail');
insert into task values('2019-01-05','fail');
insert into task values('2019-01-06','success');

select * from task;

with all_dates as(
select * 
, ROW_NUMBER() over(partition by state order by date_value) as rnk
,DATEADD(day,-1 * ROW_NUMBER() over(partition by state order by date_value), date_value) as group_date
from task)

select min(date_value) as start_date, max(date_value) as end_date , state
from all_dates
group by group_date,state
order by min(date_value);

-------------------------------------------------------------------------------------------------------
----Working with null value 


create table customers(
customer_id integer,
customer_name varchar(50),
gender varchar(50),
dob date,
age integer
);


insert into customers values(1, 'Rahul', 'M' , '2000-01-05', 22);
insert into customers values(2, 'Shilpa', 'F' , '2004-04-05', 18);
insert into customers values(3, 'Ramesh', 'M' , '2003-07-07', 19);
insert into customers values(4, 'Katrina', 'F' , '2005-02-05', 17);
insert into customers values(5, 'Alia', 'F' , '1992-01-01', 30);
insert into customers values(6, 'Ali', 'M' , null,null);


select * from customers;

---filtering null values as '=', 'is null', 'is not null'

select * from customers where dob = null; --- null is not equal to null

select * from customers where dob is null; ---- return the null value

select * from customers where dob is not null; --- return not null value


-----------handling null value, the functions are 1. isnull() 2. coalesce()

select *, isnull(dob,'2000-01-20') as handling_null from customers;
select *, isnull(age,20) as handling_null from customers;

select *, coalesce(dob ,null, '2000-01-01', '2000-01-02') as handling_null from customers;

-------------count()
select * from customers;
select count(*) as total from customers;
select count(age) from customers;
select count(isnull(age,20)) from customers;

----avg() in case of null value

select * from customers;
select sum(age) from customers;
select count(age) from customers;
select sum(age)/count(age) from customers;
select avg(age) from customers;

select avg(isnull(age,0)) from customers;


----------------------------------------------------------------------------------------------------

select * from emp_case;

-----------without cte

select * from emp_case 
where salary > (select avg(salary) from emp_case);

-----------with cte

with avg_salary as
(
select AVG(salary) as avgS from emp_case
)

select * from emp_case e
inner join avg_salary a
on salary > avgS
;

------------------------------------------------------------------------------------------

create table transactions
(
order_id integer,
order_date date,
product_name varchar(50),
order_amount integer,
create_time datetime2 
);

insert into transactions values(1,'2022-03-03','P1',150,'2022-03-03 15:34:51.067');
insert into transactions values(1,'2022-03-03','P1',150,'2022-03-03 15:35:12.400');
insert into transactions values(2,'2022-03-03','P2',200,'2022-03-03 15:35:49.610');
insert into transactions values(2,'2022-03-03','P2',200,'2022-03-03 15:36:45.933');
insert into transactions values(2,'2022-03-03','P2',200,'2022-03-03 15:38:09.810');
insert into transactions values(3,'2022-03-03','P3',300,'2022-03-03 15:38:28.523');


select * from transactions;

---to take the backup of the above table

select * into transaction_backup from transactions;
select * from transaction_backup;


select order_id, count(1) as no_of_record from transactions 
group by order_id
having COUNT(1) > 1;

select order_id, min(create_time) as min_time from transactions 
group by order_id
having count(1) > 1;

delete t 
from transactions t 
inner join (select order_id, min(create_time) as create_time from transactions 
group by order_id
having count(1) > 1) a
on a.order_id = t.order_id and a.create_time = t.create_time;

select * from transactions;


delete from transactions;
insert into transactions select * from transaction_backup;

select * from transactions;


with dup_dele as
(select *
, ROW_NUMBER() over(partition by order_id order by create_time desc) as rnk
from transactions)
delete from dup_dele where rnk > 1
;


select * from transactions;
-----------------------------------------------------------------------------------------------------------
create table orders_purchase
(
 order_id integer,
 customer_id integer,
 product_id integer
);

insert into orders_purchase values(1,1,1);
insert into orders_purchase values(1,1,2);
insert into orders_purchase values(1,1,3);
insert into orders_purchase values(2,2,1);
insert into orders_purchase values(2,2,2);
insert into orders_purchase values(2,2,4);
insert into orders_purchase values(3,1,5);

select * from orders_purchase;

create table products
(
id integer,
name varchar(50)
);

insert into products values(1,'A');
insert into products values(2,'B');
insert into products values(3,'C');
insert into products values(4,'D');
insert into products values(5,'E');


select * from orders_purchase;
select * from products;

--------------------------------------------------------------------------------------------------------

select * from products;

create table colors
(
color_id integer,
color varchar(50)
);


insert into colors values(1,'Blue');
insert into colors values(2,'Green');
insert into colors values(3,'Orange');

select * from colors;

select p.*,c.* from products p, colors c;

select * from products p
cross join colors c;

create table transactions_cross
(
order_id integer,
product_name varchar(50),
color varchar(50),
size varchar(50),
amount integer
); 

insert into transactions_cross values(1,'A','Blue','L',300);
insert into transactions_cross values(2,'B','Blue','XL',150);
insert into transactions_cross values(3,'B','Green','L',250);
insert into transactions_cross values(4,'C','Blue','L',250);
insert into transactions_cross values(5,'E','Green','L',270);
insert into transactions_cross values(6,'D','Orange','L',200);
insert into transactions_cross values(7,'D','Green','M',250);

select * from transactions_cross;

create table sizes
(
size_id integer,
size varchar(50)
);

insert into sizes values(1,'M');
insert into sizes values(2,'L');
insert into sizes values(3,'XL');


select * from sizes;


select * from products;
select * from colors;
select * from sizes;
select * from transactions_cross;

select product_name, color, size, sum(amount) as total_amount 
from transactions_cross
group by product_name, color, size;

-------------------------------------------------------------------------------------------------------------

create table mode(
id integer
);

insert into mode values(1);
insert into mode values(2);
insert into mode values(2);
insert into mode values(2);
insert into mode values(2);
insert into mode values(3);
insert into mode values(3);
insert into mode values(3);
insert into mode values(3);
insert into mode values(4);
insert into mode values(5);

select * from mode;


-----------------1. Approach-----------
with mode_rnk as 
(select * 
, row_number() over(partition by id order by id) as rnk
from mode)

select * from mode_rnk where rnk = (select max(rnk) from mode_rnk);


-----------------2. Approach-----------

with frq_cte as
(select id, count(*) as freq from mode group by id)

select * from frq_cte where freq = (select max(freq) as mode from frq_cte)
;

------------------------------------------------------------------------------------------------------

create table emp_2020
(
emp_id integer,
designation varchar(50)
);

insert into emp_2020 values(1,'Trainee');
insert into emp_2020 values(2,'Developer');
insert into emp_2020 values(3,'Senior Developer');
insert into emp_2020 values(4,'Manager');

create table emp_2021
(
emp_id integer,
designation varchar(50)
);

insert into emp_2021 values(1,'Developer');
insert into emp_2021 values(2,'Developer');
insert into emp_2021 values(3,'Manager');
insert into emp_2021 values(5,'Trainee');

select * from emp_2020;
select * from emp_2021;

select coalesce(e1.emp_id, e2.emp_id),
case when e1.designation != e2.designation then 'Promoted'
	 when e2.designation is null then 'Resigned'
	 else 'New '
end as comment
from emp_2020 e1
full outer join emp_2021 e2
on e1.emp_id = e2.emp_id
where isnull(e1.designation,'xxx') != isnull(e2.designation,'yyy');


----------------------------------------------------------------------------------------------------------

create table list(
id varchar(50)
);

insert into list values('a');
insert into list values('a');
insert into list values('b');
insert into list values('c');
insert into list values('c');
insert into list values('c');
insert into list values('d');
insert into list values('d');

select * from list;

select *,
DENSE_RANK() over(order by id) as rnk
from list;

with cte_dup as(
select id from list group by id having count(1) > 1),
cte_rank as(
select *,
rank() over(order by id asc) as rn
from cte_dup)

select l.* , 'DUP' + cast(cr.rn as varchar(50)) from list l left join cte_rank cr on l.id = cr.id;

----------------------------------------------------------------------------------------------------------------------


create table activity(
user_id integer,
event_name varchar(50),
event_date date,
country varchar(50)
);

insert into activity values(1,'app-installed','2022-01-01', 'India');
insert into activity values(1,'app-purchase','2022-01-02', 'India');
insert into activity values(2,'app-installed','2022-01-01', 'USA');
insert into activity values(3,'app-installed','2022-01-01', 'USA');
insert into activity values(3,'app-purchase','2022-01-03', 'USA');
insert into activity values(4,'app-installed','2022-01-03', 'India');
insert into activity values(4,'app-purchase','2022-01-03', 'India');
insert into activity values(5,'app-installed','2022-01-03', 'SL');
insert into activity values(5,'app-purchase','2022-01-03', 'SL');
insert into activity values(6,'app-installed','2022-01-04', 'Pakistan');
insert into activity values(6,'app-purchase','2022-01-04', 'Pakistan');

select * from activity;

select event_date, count(distinct user_id) from activity
group by event_date;

select *, datepart(week, event_date) from activity;

select datepart(week, event_date) as week_number, count(distinct user_id) from activity
group by datepart(week, event_date);


select * from activity;

select user_id, event_date
,case when event_name = 'app-installed' then event_date end as app_installed_date,
case when event_name = 'app-purchase' then event_date end as app_purchase_date
from activity;

select event_date, count(user_id) as no_of_user from(
select user_id, event_date , count(distinct event_name) as no_of_events 
from activity
group by user_id, event_date
having count(distinct event_name) = 2) a
group by event_date;


------------------------------------------------------------------------------------------------------

create table lift(
id integer,
capacity_kg integer
);

insert into lift values(1,300);
insert into lift values(2,350);

create table lift_passengers
(
passenger_name varchar(50),
weight_kg integer,
lift_id integer
);

insert into lift_passengers values('Rahul',85, 1);
insert into lift_passengers values('Adarsh',73, 1);
insert into lift_passengers values('Riti',95, 1);
insert into lift_passengers values('Dheeraj',80, 1);
insert into lift_passengers values('Vimal',83, 2);
insert into lift_passengers values('Neha',77, 2);
insert into lift_passengers values('Priti',73, 2);
insert into lift_passengers values('Himanshi',85, 2);

select * from lift;
select * from lift_passengers;

select 73+80+85+95; --333
select 73+77+83+85;  ---318

with cte as(
select *
,sum(weight_kg) over(partition by l.id order by l.id, p.weight_kg) as cummu_sum
, case when capacity_kg >= sum(weight_kg) over(partition by l.id order by l.id, p.weight_kg) then 1 else 0 end as flag
from lift l
inner join lift_passengers p 
on l.id = p.lift_id
)

select lift_id, string_agg(passenger_name,',' ) as passenger from cte where flag = 1
group by lift_id
;

--------------------------------------------------------------------------------------------------

create table bms(
seat_no integer,
is_empty varchar(50)
);

insert into bms values(1,'N');
insert into bms values(2,'Y');
insert into bms values(3,'N');
insert into bms values(4,'Y');
insert into bms values(5,'Y');
insert into bms values(6,'Y');
insert into bms values(7,'N');
insert into bms values(8,'Y');
insert into bms values(9,'Y');
insert into bms values(10,'Y');
insert into bms values(11,'Y');
insert into bms values(12,'N');
insert into bms values(13,'Y');
insert into bms values(14,'Y');

select * from bms;

select * from
(select * 
,lag(is_empty, 1) over(order by seat_no) as prev_1
,lag(is_empty, 2) over(order by seat_no) as prev_2
,lead(is_empty, 1) over(order by seat_no) as next_1
,lead(is_empty, 2) over(order by seat_no) as next_2
from bms) as a
where is_empty = 'Y' and prev_1 = 'Y' and prev_2 = 'Y'
or (is_empty = 'Y' and prev_1 = 'Y' and next_1 = 'Y')
or (is_empty = 'Y' and next_1 = 'Y' and next_2 = 'Y');


with diff_num as(
select *
, row_number() over(order by seat_no) as rnk
, seat_no - row_number() over(order by seat_no) as diff
from bms
where is_empty = 'Y'),
cnt as(select diff , count(1) as total from diff_num
group by diff
having count(1) >= 3)

select * from diff_num where diff in (select diff from cnt);

-------------------------------------------------------------------------------------------------------------

create table exams(
student_id integer,
suject varchar(50),
marks integer
);

insert into exams values(1,'Chemistry',91);
insert into exams values(1,'Physics',91);
insert into exams values(2,'Chemistry',80);
insert into exams values(2,'Physics',90);
insert into exams values(3,'Chemistry',80);
insert into exams values(4,'Chemistry',71);
insert into exams values(4,'Physics',54);


select * from exams;

select student_id from exams
where suject in ('Chemistry','Physics')
group by student_id
having count(distinct suject) = 2 and count(distinct marks) = 1;


------------------------------------------------------------------------------------------------------

CREATE TABLE STORES (
Store varchar(10),
SQuarter varchar(10),
Amount int);

INSERT INTO STORES (Store, SQuarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);


select * from STORES;

select Store, 'Q' + cast(10 - sum(CAST(RIGHT(SQuarter, 1) as int)) as char(2))as q_no from STORES 
group by Store;


----------------------------------------------------------------------------------------------------------------

select * from emp_case;
select * from department;


---------------------------------------------------------------------------------------------------------------
create table covid(
city varchar(50),
days date,
cases integer
);


insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);
insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);
insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);
insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

select * from covid;

with xxx_cte as(
select *
,rank() over(partition by city order by days) as diff_days
,rank() over(partition by city order by cases) as diff_cases
,rank() over(partition by city order by days) - rank() over(partition by city order by cases) as diff
from covid)

select city from xxx_cte
group by city 
having count(distinct diff ) = 1 and max(diff) = 0  
;
-------------------------------------------------------------------------------------------------------------

create table company_users
(
company_id integer,
user_id integer,
language varchar(50)
);

insert into company_users values(1,1,'English');
insert into company_users values(1,1,'German');
insert into company_users values(1,2,'English');
insert into company_users values(1,3,'German');
insert into company_users values(1,3,'English');
insert into company_users values(1,4,'English');
insert into company_users values(2,5,'English');
insert into company_users values(2,5,'German');
insert into company_users values(2,5,'Spanish');
insert into company_users values(2,6,'German');
insert into company_users values(2,6,'Spanish');
insert into company_users values(2,7,'English');

select * from company_users;


select company_id, count(1) from 
(
select company_id, user_id
from company_users where language in('English', 'German')
group by company_id, user_id
having count(1) = 2)a
group by company_id
having count(1) >= 2;


----------------------------------------------------------------------------------------------------


create table product
(
product_id varchar(50),
cost integer
);

insert into product values('P1',200);
insert into product values('P2',300);
insert into product values('P3',500);
insert into product values('P4',800);

select * from product;

create table customer_budget
(
customer_id integer,
budgets integer
);

insert into customer_budget values(100,400);
insert into customer_budget values(200,800);
insert into customer_budget values(300,1500);

select * from customer_budget;

select * from product;
select * from customer_budget;

with running_cost as(
select *
,sum(cost) over(order by cost asc) as cumm
from product)

select customer_id,budgets, count(1) as no_of_products, STRING_AGG(product_id,',')as list_of_product
from customer_budget cb
left join running_cost rc
on rc.cumm < cb.budgets
group by customer_id,budgets;


------------------------------------------------------------------------------------------------------------------

create table emp_count
(
emp_id integer,
emp_name varchar(50),
salary integer,
manager_id integer,
emp_age integer,
dep_id integer,
dep_name varchar(50),
gender varchar(50)
);

insert into emp_count values(1,'Ankit',14300,4,39,100,'Analytics','Male');
insert into emp_count values(2,'Mohit',15600,5,48,200,'IT','Male');
insert into emp_count values(3,'Vikas',12100,4,37,100,'Analytics','Male');
insert into emp_count values(4,'Rohit',7260,2,16,100,'Analytics','Male');
insert into emp_count values(5,'Mudit',15600,6,55,200,'IT','Male');
insert into emp_count values(6,'Agam',15600,2,14,200,'IT','Male');
insert into emp_count values(7,'Sanjay',12000,2,13,200,'IT','Male');
insert into emp_count values(8,'Ashish',7200,2,12,200,'IT','Male');
insert into emp_count values(9,'Mukesh',7000,6,51,300,'HR','Male');
insert into emp_count values(10,'Rakesh',8000,6,50,300,'HR','Male');
insert into emp_count values(11,'Akhil',4000,1,31,500,Null,'Male');
insert into emp_count values(Null,Null,Null,Null,Null,Null,Null,Null);

update emp_count set gender = 'Male' where emp_id = 1;

select * from emp_count;

select count(*)
,count(1)
,count(0)
,count(-1)
,count('aa'), count('ankit')   ----------- at the place of 'aa' and 'ankit' I can give anything
,count(dep_name) 
,count(distinct dep_name)
from emp_count;
--------------------------------------------------------------------------------------------------------------


create table subscriber
(
sms_date date,
sender varchar(50),
receiver varchar(50),
sms_no integer
);

insert into subscriber values('2020-04-01', 'Avinash','Vibhor', 10);
insert into subscriber values('2020-04-01','Vibhor', 'Avinash', 20);
insert into subscriber values('2020-04-01', 'Avinash','Pawan', 30);
insert into subscriber values('2020-04-01', 'Pawan','Avinash', 20);
insert into subscriber values('2020-04-01', 'Vibhor','Pawan', 5);
insert into subscriber values('2020-04-01', 'Pawan','Vibhor', 8);
insert into subscriber values('2020-04-01','Vibhor','Deepak', 50);

select * from subscriber;

select sms_date, P1, P2, sum(sms_no) as total from
(select *
, case when sender < receiver then sender else receiver end as P1
, case when sender > receiver then sender else receiver end as P2
from subscriber) a
group by sms_date, P1, P2;

------------------------------------------------------------------------------------------------------------------

CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
);

insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

select * from students;

with avg_cte as
(select subject, avg(marks) as avg_marks from students
group by subject
)

select s.* , ac.*
from students s 
inner join avg_cte ac on 
s.subject = ac.subject
where s.marks > ac.avg_marks
;

select * from students;

select 
count(distinct case when marks > 90 then studentid else null end)* 1.0 / count(distinct studentid) * 100 as percentage
from students; 


select * from students;


select * 
,case when marks > prev_marks then 'Increase' else 'Decrease' end as status 
from
(select *,
lag(marks, 1) over(partition by studentid order by testdate, subject) as prev_marks
from students) a;


-------------------------------------------------------------------------------------------------------------

create table strings
(
name varchar(50)
);

insert into strings values('Ankit Bansal');
insert into strings values('Ram Kumar Verma');
insert into strings values('Akshay Kumar Ak k');
insert into strings values('Rahul');

select * from strings;

select name
,REPLACE(name,' ','') as rep_name
,LEN(name) - LEN(REPLACE(name,' ','')) as cnt
from strings;

select name
,REPLACE(name,'Ak','') as rep_name
,LEN(name) as name_len
,LEN(REPLACE(name,'Ak','')) as rep_name_len
,(LEN(name) - LEN(REPLACE(name,'Ak',''))) / LEN('Ak') as cnt
from strings;

-------------------------------------------------------------------------------------------------------

create table int_orders(
salesperson_id integer,
order_number integer,
order_date date,
amount integer
);

insert into int_orders values(1,30, '1995-07-14',460);
insert into int_orders values(2,10, '1996-08-02',540);
insert into int_orders values(2,40, '1998-01-29',2400);
insert into int_orders values(7,50, '1998-02-03',600);
insert into int_orders values(7,60, '1998-03-02',720);
insert into int_orders values(7,70, '1998-05-06',150);
insert into int_orders values(8,20, '1999-01-30',1800);

select * from int_orders;


select sum(amount) from int_orders;

select salesperson_id, sum(amount) from int_orders
group by salesperson_id;

select *,
sum(amount) over()
from int_orders;

select * 
, sum(amount) over(partition by salesperson_id) as cum
from int_orders;

select * 
,sum(amount) over(order by order_date) as cum
from int_orders;

select * 
, sum(amount) over(partition by salesperson_id order by order_date) as cum
from int_orders;

select * 
,sum(amount) over(order by order_date rows between 2 preceding and current row) as cum
from int_orders;


select * 
,sum(amount) over(order by order_date rows between 1 preceding and 1 following) as cum
from int_orders;

select * 
,sum(amount) over(order by order_date rows between unbounded preceding and current row) as cum
from int_orders;

select * 
,sum(amount) over(partition by salesperson_id order by order_date rows between 1 preceding and current row) as cum
from int_orders;

select * 
,sum(amount) over(order by order_date rows between 1 preceding and 1 preceding) as cum   --- show the result like lag
from int_orders;


select * 
,sum(amount) over(order by order_date rows between 1 following and 1 following) as cum    --- show the result like lead
from int_orders;



---------------------------------------------------------------------------------------------------------------------


CREATE TABLE int_orders_other(
 [order_number] [int] NOT NULL,
 [order_date] [date] NOT NULL,
 [cust_id] [int] NOT NULL,
 [salesperson_id] [int] NOT NULL,
 [amount] [float] NOT NULL
) ON [PRIMARY];

INSERT INTO [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT into [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT INTO [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT into [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT into [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT into [dbo].[int_orders_other] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);


select * from int_orders_other;

select a.order_number,a.order_date, a.cust_id, a.salesperson_id, a.amount from int_orders_other a
left join int_orders_other b
on a.salesperson_id = b.salesperson_id
group by a.order_number,a.order_date, a.cust_id, a.salesperson_id, a.amount
having a.amount >= MAX(b.amount);


------------------------------------------------------------------------------------------------------
create table event_status
(
event_time varchar(10),
status varchar(10)
);

insert into event_status values
('10:01','on'),
('10:02','on'),
('10:03','on'),
('10:04','off'),
('10:07','on'),
('10:08','on'),
('10:09','off'),
('10:11','on'),
('10:12','off');

select * from event_status;

with xxx as
(select *
,case when status = 'on' and prev_status = 'off' then 1 else 0 end as cnt 
,sum(case when status = 'on' and prev_status = 'off' then 1 else 0 end) over(order by event_time) as group_key
from
(select *
,lag(status, 1 ) over(order by event_time) as previ_status
,lag(status, 1 , status) over(order by event_time) as prev_status
from event_status) a
)

select min(event_time) as login, max(event_time) as logout, count(1)-1 as on_count 
from xxx group by group_key;


-------------------------------------------------------------------------------------------------------


select * from customers;

delete from customers where customer_id = 6;


create table customers_orders
(
order_id integer,
customer_id integer,
order_date date,
ship_date date
);


insert into customers_orders values(1000,1,'2022-01-05','2022-01-11');
insert into customers_orders values(1001,2,'2022-02-04','2022-02-16');
insert into customers_orders values(1002,3,'2022-01-01','2022-01-19');
insert into customers_orders values(1003,4,'2022-01-06','2022-01-30');
insert into customers_orders values(1004,6,'2022-02-07','2022-02-13');

select * from customers_orders;


select * from customers;
select * from customers_orders;


------------------------------------------------------------------------------------------------------------

CREATE TABLE employeeInfo(
 [emp_id] [int] NULL,
 [emp_name] [varchar](50) NULL,
 [salary] [int] NULL,
 [manager_id] [int] NULL,
 [emp_age] [int] NULL,
 [dep_id] [int] NULL,
 [dep_name] [varchar](20) NULL,
 [gender] [varchar](10) NULL
) ;

insert into employeeInfo values(1,'Ankit',14300,4,39,100,'Analytics','Male')
insert into employeeInfo values(2,'Mohit',14000,5,48,200,'IT','Male')
insert into employeeInfo values(3,'Vikas',12100,4,37,100,'Analytics','Male')
insert into employeeInfo values(4,'Rohit',7260,2,16,100,'Analytics','Male')
insert into employeeInfo values(5,'Mudit',15000,6,55,200,'IT','Male')
insert into employeeInfo values(6,'Agam',15600,2,14,200,'IT','Male')
insert into employeeInfo values(7,'Sanjay',12000,2,13,200,'IT','Male')
insert into employeeInfo values(8,'Ashish',7200,2,12,200,'IT','Male')
insert into employeeInfo values(9,'Mukesh',7000,6,51,300,'HR','Male')
insert into employeeInfo values(10,'Rakesh',8000,6,50,300,'HR','Male')
insert into employeeInfo values(11,'Akhil',4000,1,31,500,'Ops','Male')

select * from employeeInfo;

with sal as
(select *,
DENSE_RANK() over(partition by dep_name order by salary desc) as rnk
,count(1) over(partition by dep_name) as cnt
from employeeInfo)

select emp_id,emp_name, salary,dep_id,dep_name from sal
where rnk = 3 or (cnt < 3 and cnt = rnk);

---------------------------------------------------------------------------------------------------

create table business_city 
(
business_date date,
city_id int
);


insert into business_city values( cast('2020-01-02' as date),3),
								( cast('2020-07-01' as date),7),
								( cast('2021-01-01' as date),3),
								( cast('2021-02-03' as date),19),
								( cast('2022-12-01' as date),3),
								( cast('2022-12-15' as date),3),
								( cast('2022-02-28' as date),12);

select * from business_city;


with cte as
(select DATEPART(YEAR,business_date) as bus_year, city_id from business_city)

select c1.bus_year, count(distinct case when c2.city_id is null then c1.city_id end ) as no_of_new_city
from cte c1
left join cte c2
on c1.bus_year > c2.bus_year and c1.city_id = c2.city_id
group by c1.bus_year;

---------------------------------------------------------------------------------------------------------------

create table call_details
(
call_type varchar(50),
call_number integer,
call_duration integer
);

insert into call_details values  ('OUT','181868',13)
								,('OUT','2159010',8)
								,('OUT','2159010',178)
								,('SMS','4153810',1)
								,('OUT','2159010',152)
								,('OUT','9140152',18)
								,('SMS','4162672',1)
								,('SMS','9168204',1)
								,('OUT','9168204',576)
								,('INC','2159010',5)
								,('INC','2159010',4)
								,('SMS','2159010',1)
								,('SMS','4535614',1)
								,('OUT','181868',20)
								,('INC','181868',54)
								,('INC','218748',20)
								,('INC','2159010',9)
								,('INC','197432',66)
								,('SMS','2159010',1)
								,('SMS','4535614',1);

select * from call_details;

with cte as
(select call_number,
sum(case when call_type = 'OUT' then call_duration else null end) as out_duration,
sum(case when call_type = 'INC' then call_duration else null end) as inc_duration
from call_details
group by call_number)

select call_number from cte where
out_duration is not null and inc_duration is not null and out_duration > inc_duration
;

----using having clause

select call_number
from call_details
group by call_number
having sum(case when call_type = 'OUT' then call_duration else null end) > 0 and
sum(case when call_type = 'INC' then call_duration else null end) > 0 and
sum(case when call_type = 'OUT' then call_duration else null end) > sum(case when call_type = 'INC' then call_duration else null end);

------------------------------------------------------------------------------------------------------------------------------------------------------------

create table emp_join
(
emp_id int,
emp_name varchar(20),
dep_id int,
salary int,
manager_id int,
emp_age int
);

insert into emp_join values (1, 'Ankit', 100,10000, 4, 39);
insert into emp_join values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp_join values (3, 'Vikas', 100, 10000,4,37);
insert into emp_join values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp_join values (5, 'Mudit', 200, 12000, 6,55);
insert into emp_join values (6, 'Agam', 200, 12000,2, 14);
insert into emp_join values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp_join values (8, 'Ashish', 200,5000,2,12);
insert into emp_join values (9, 'Mukesh',300,6000,6,51);
insert into emp_join values (10, 'Rakesh',500,7000,6,50);

select * from emp_join;

create table dept
(
dep_id integer,
dep_name varchar(50)
);

insert into dept values(100,'Analytics');
insert into dept values(200,'IT');
insert into dept values(300,'HR');
insert into dept values(400,'Text Analytics');

select * from dept;

select * from emp_join;
select * from dept;

select * from emp_join e left join 
dept d on e.dep_id = d.dep_id and dep_name = 'Analytics';

select * from emp_join e left join 
dept d on e.dep_id = d.dep_id where dep_name = 'Analytics';


-----------------------------------------------------------------------------------------------------------------

create table brands 
(
category varchar(20),
brand_name varchar(20)
);

insert into brands values ('chocolates','5-star'),
						  (null,'dairy milk'),
						  (null,'perk'),
						  (null,'eclair'),
						  ('Biscuits','britannia'),
						  (null,'good day'),
						  (null,'boost');

select * from brands;

with cte1 as
(select *
,ROW_NUMBER() over(order by (select null)) as rn
from brands)
,cte2 as
(select *,
lead(rn , 1 , 9999) over(order by rn) as next_rn
from cte1
where category is not null)
select cte2.category,cte1.brand_name from cte1 inner join cte2 on
cte1.rn >= cte2.rn  and cte1.rn <= cte2.next_rn-1;

----------------------------------------------------------------------------------------------------------------


create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');

select * from phonelog;

--------------------------------------------------------------------------------------------------------

create table employee_wocte
(
emp_id integer,
emp_name varchar(50),
dept varchar(50),
salary integer
);


insert into employee_wocte values(1,'Alice','Sales',7000);
insert into employee_wocte values(2,'Bob','HR',6000);
insert into employee_wocte values(3,'Charlie','IT',8000);
insert into employee_wocte values(4,'Dave','Sales',7200);
insert into employee_wocte values(5,'Eve','HR',6500);
insert into employee_wocte values(6,'Frank','IT',8500);

select * from employee_wocte;

select avg(salary) as avg_salary from employee_wocte;

select * from employee_wocte;
select dept
,sum(salary) over(partition by dept order by emp_id) as sal_sum
from employee_wocte
;

select dept,salary from employee_wocte
group by dept,salary;

select dept from
(select dept,
avg(salary) over(partition by dept order by dept) as avg_sal
from employee_wocte
) as a
where avg_sal not in (max(avg_sal),min(avg_sal)); 


select * from employee_wocte where salary > (select avg(salary) from employee_wocte);

-------------------------------------------------------------------------------------------------------------------------------

create table airbnb_searches
(
user_id integer,
date_searched date,
filter_room_types varchar(50)
);


insert into airbnb_searches values(1,'2022-01-01','entire home,private room');
insert into airbnb_searches values(2,'2022-01-02','entire home,shared room');
insert into airbnb_searches values(3,'2022-01-02','private room,shared room');
insert into airbnb_searches values(4,'2022-01-03','private room');



select * from airbnb_searches;

--- string_split()

select * from airbnb_searches cross apply string_split(filter_room_types,',');  --- vvI

select value as room_type, count(1) as no_of_searches from airbnb_searches 
cross apply string_split(filter_room_types,',')
group by value
order by no_of_searches desc;

--------------------------------------------------------------------------------------------------------------------------

create table hospital 
( 
emp_id int,
action varchar(10),
time datetime
);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');


select * from hospital;

select emp_id
,max(case when action = 'in' then time end) as in_time
,max(case when action = 'out' then time end) as out_time
from hospital
group by emp_id
having max(case when action = 'in' then time end) > max(case when action = 'out' then time end)
or max(case when action = 'out' then time end) is null;




with cte as
(select emp_id
,max(case when action = 'in' then time end) as in_time
,max(case when action = 'out' then time end) as out_time
from hospital
group by emp_id)

select * from cte where in_time > out_time or out_time is null
; 

-------------------------------------------------------------------------------------------------------------------

create table candidates
(
emp_id int,
experience varchar(20),
salary int
);


insert into candidates values(1,'Junior',10000),
							 (2,'Junior',15000),
							 (3,'Junior',40000),
							 (4,'Senior',16000),
							 (5,'Senior',20000),
							 (6,'Senior',50000);

select * from candidates;

with total_sal as
(select *
,sum(salary) over(partition by experience order by salary rows between unbounded preceding and current row) as running_salary
from candidates)
,senior as
(select * from total_sal where experience = 'Senior' and running_salary <= 70000)

select * from total_sal where experience = 'Junior' and running_salary <= 70000 - (select sum(salary) from senior)
union all
select * from senior
;

----------------------------------------------------------------------------------------------------------------

create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);


insert into tickets values (1,'2022-08-01','2022-08-03'),
						   (2,'2022-08-01','2022-08-12'),
						   (3,'2022-08-01','2022-08-16');


create table holidays
(
holiday_date date,
reason varchar(100)
);


insert into holidays values('2022-08-11','Rakhi'),
						   ('2022-08-15','Independence day');


select * from tickets;
select * from holidays;

select *
,DATEDIFF(DAY,create_date,resolved_date) as actual_days
,DATEDIFF(WEEK,create_date,resolved_date) as week_diff
,DATEPART(week, create_date) as week_part_create
,DATEPART(WEEK,resolved_date) as week_part_resolved
from tickets;


select *
,DATEDIFF(DAY,create_date,resolved_date) as actual_days
,DATEDIFF(WEEK,create_date,resolved_date) as week_diff
,DATEDIFF(DAY,create_date,resolved_date) - 2 * DATEDIFF(WEEK,create_date,resolved_date) as no_of_business_days
from tickets;


select *
,DATEDIFF(DAY,create_date,resolved_date) - 2 * DATEDIFF(WEEK,create_date,resolved_date) - no_of_holidays as business_days
from 
(select ticket_id, create_date,resolved_date, count(holiday_date) as no_of_holidays 
from tickets left join holidays on
holiday_date between create_date and resolved_date
group by ticket_id, create_date,resolved_date) A;


--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE [emp_salary]
(
    [emp_id] INTEGER  NOT NULL,
    [name] NVARCHAR(20)  NOT NULL,
    [salary] NVARCHAR(30),
    [dept_id] INTEGER
);


INSERT INTO emp_salary (emp_id, name, salary, dept_id) VALUES(101, 'sohan', '3000', '11'),
															 (102, 'rohan', '4000', '12'),
															 (103, 'mohan', '5000', '13'),
															 (104, 'cat', '3000', '11'),
															 (105, 'suresh', '4000', '12'),
															 (109, 'mahesh', '7000', '12'),
															 (108, 'kamal', '8000', '11');

select * from emp_salary;

select * from
(select *
,DENSE_RANK() over(partition by dept_id order by salary) as rnk
from emp_salary) a
where rnk < 2;

with sal_dept as
(select dept_id , salary from emp_salary 
group by dept_id, salary
having count(1) > 1)

select es.* from emp_salary es
inner join sal_dept ds on
es.dept_id = ds.dept_id and es.salary = ds.salary;

----------------------------------------------------------------------------------------------------------------------------


create table emp_self_join(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp_self_join values (1, 'Ankit', 100,10000, 4, 39);
insert into emp_self_join values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp_self_join values (3, 'Vikas', 100, 12000,4,37);
insert into emp_self_join values (4, 'Rohit', 100, 14000, 2, 16);
insert into emp_self_join values (5, 'Mudit', 200, 20000, 6,55);
insert into emp_self_join values (6, 'Agam', 200, 12000,2, 14);
insert into emp_self_join values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp_self_join values (8, 'Ashish', 200,5000,2,12);
insert into emp_self_join values (9, 'Mukesh',300,6000,6,51);
insert into emp_self_join values (10, 'Rakesh',500,7000,6,50);

select * from emp_self_join;

select emp_id,emp_name,manager_id from emp_self_join;


select e.emp_id, e.emp_name, m.emp_name as Manager_name, sm.emp_name as senior_manager
from emp_self_join e
left join emp_self_join m 
on e.manager_id = m.emp_id
left join emp_self_join sm 
on m.manager_id = sm.emp_id
;

---------------------------------------------------------------------------------------------------------------------

create table adobe_transaction
(
customer_id integer,
product varchar(50), 
revenue integer
);

insert into adobe_transaction values(123,'Photoshop',50);
insert into adobe_transaction values(123,'Premier',100);
insert into adobe_transaction values(123,'After Effects',50);
insert into adobe_transaction values(234,'Illustrator',200);
insert into adobe_transaction values(234,'Premier Pro',100);

select * from adobe_transaction;

select customer_id, sum(revenue) as revenue 
from adobe_transaction 
where customer_id in (
select distinct customer_id 
from adobe_transaction 
where product = 'Photoshop') 
and product != 'Photoshop'
group by customer_id
order by customer_id;



--------------------------------------------------------------------------------------------------------------------------

create table personal_profiles(
profile_id integer,
name varchar(50),
followers integer
);

insert into personal_profiles values(1,'Nick Singh',92000);
insert into personal_profiles values(2,'Zach Wilson',199000);
insert into personal_profiles values(3,'Daliana Liu',171000);
insert into personal_profiles values(4,'Ravit Jain',107000);
insert into personal_profiles values(5,'Vin Vashishta',139000);
insert into personal_profiles values(6,'Susan Wojcicki',39000);

select * from personal_profiles;


create table company_pages(
company_id integer,
name varchar(50),
followers integer
);

insert into company_pages values(1,'The Data Science Podcast',8000);
insert into company_pages values(2,'Airbnb',700000);
insert into company_pages values(3,'The Ravit Show',6000);
insert into company_pages values(4,'DataLemur',200);
insert into company_pages values(5,'YouTube',16000000);
insert into company_pages values(6,'DataScience.Vin',4500);
insert into company_pages values(9,'Ace The Data Science',4479);

select * from company_pages;


create table employee_company
(
personal_profile_id integer,
company_id integer
);


insert into employee_company values(1,4);
insert into employee_company values(1,9);
insert into employee_company values(2,2);
insert into employee_company values(3,1);
insert into employee_company values(4,3);
insert into employee_company values(5,6);
insert into employee_company values(6,5);

select * from employee_company;


select * from personal_profiles;
select * from employee_company;
select * from company_pages;


with cte as
(select ec.personal_profile_id, max(cp.followers) as max_follower from company_pages cp
inner join
employee_company ec 
on cp.company_id = ec.company_id
group by ec.personal_profile_id)

select pp.profile_id,pp.name, pp.followers,cte.max_follower
from personal_profiles pp
inner join cte on pp.profile_id = cte.personal_profile_id
where pp.followers > cte.max_follower
;



------------------------------------------------------------------------------------------------------------------------
------sql.namaste@gmail.com

create table employee_LT 
(
emp_name varchar(10),
dep_id int,
salary int
);


insert into employee_LT values ('Siva',1,30000),
							   ('Ravi',2,40000),
							   ('Prasad',1,50000),
							   ('Sai',2,20000);


with cte as
(select dep_id, max(salary) as emp_max_sal, min(salary) as emp_min_sal
from employee_LT
group by dep_id)

select e.dep_id,
max(case when e.salary = cte.emp_max_sal then emp_name end) as max_sal_emp,
max(case when e.salary = cte.emp_min_sal then emp_name end) as min_sal_emp
from employee_LT e
inner join cte 
on e.dep_id = cte.dep_id
group by e.dep_id
;



---2. Approach of the above question

with cte as
(select *,
ROW_NUMBER() over(partition by dep_id order by salary desc) as rn_desc,
ROW_NUMBER() over(partition by dep_id order by salary asc) as rn_as
from employee_LT)

select dep_id
,min(case when rn_desc = 1 then emp_name end) as max_sal
,min(case when rn_as = 1 then emp_name end) as min_sal
from cte
group by dep_id;



-----------------------------------------------------------------------------------------------------------------------------

create table tbl_orders
(
order_id integer,
order_date date
);


insert into tbl_orders values (1,'2022-10-21'),
							  (2,'2022-10-22'),
							  (3,'2022-10-25'),
							  (4,'2022-10-25');

select * from tbl_orders;

select * into tbl_orders_copy from  tbl_orders;

select * from tbl_orders;
select * from tbl_orders_copy;


insert into tbl_orders values (5,'2022-10-26'),(6,'2022-10-26');

delete from tbl_orders where order_id=1;


select coalesce(o.order_id,c.order_id) as order_id
,case when o.order_id is null then 'D'
	  when c.order_id is null then 'I'
end as flag
from tbl_orders o
full outer join tbl_orders_copy c
on o.order_id = c.order_id
where o.order_id is null or c.order_id is null;


----------------------------------------------------------------------------------------------------------------------------
create table purchases
(
user_id integer,
product_id integer,
quantity integer,
purchase_date datetime
);


insert into purchases values(536,3223, 6,'01-11-2022 12:33:44');
insert into purchases values(827,3585, 35,'02-20-2022 14:05:26');
insert into purchases values(536,3223, 5,'03-02-2022 09:33:28');
insert into purchases values(536,1435, 10,'03-02-2022 08:40:00');
insert into purchases values(827,2452, 45,'04-09-2022 00:00:00');

select count(1) as user_num from
(select user_id,product_id, count(distinct cast(purchase_date as date)) as p_date_count
from purchases
group by user_id,product_id
having count(distinct cast(purchase_date as date)) > 1) a;



--------------------------------------------------------------------------------------------------------------------------
create table rental_amenities
(
rental_id integer,
amenity varchar(50)
);


insert into rental_amenities values(123,'pool');
insert into rental_amenities values(123,'kitchen');
insert into rental_amenities values(234,'hottub');
insert into rental_amenities values(234,'fireplace');
insert into rental_amenities values(345,'kitchen');
insert into rental_amenities values(345,'pool');
insert into rental_amenities values(456,'pool');

select * from rental_amenities;

select amenities_list, count(rental_id) as cnt
from(
select rental_id,
STRING_AGG(amenity,',') within group(order by amenity) as amenities_list  ---- vvI
from rental_amenities
group by rental_id
---order by amenities_list
) a
group by amenities_list
having count(rental_id) > 1;


----------------------------------------------------------------------------------------------------------------------


create table transactionTable(
transaction_id integer,
type varchar(50),
amount decimal,
transaction_date datetime
);


insert into transactionTable values(19153,'deposit',65.90,'07/10/2022 10:00:00');
insert into transactionTable values(53151,'deposit',178.55,'07/08/2022 10:00:00');
insert into transactionTable values(29776,'withdrawal',25.90,'07/08/2022 10:00:00');
insert into transactionTable values(16461,'withdrawal',45.99,'07/08/2022 10:00:00');
insert into transactionTable values(77134,'deposit',32.60,'07/10/2022 10:00:00');

select * from transactionTable;


select distinct transaction_date,
sum(amt) over(partition by transaction_date order by transaction_date) as bal
from
(select type,amount,transaction_date
---,ROW_NUMBER() over(partition by transaction_date order by transaction_date) as rn
,case when type = 'deposit' then amount 
	 when type = 'withdrawal' then -amount 
end as amt
from transactionTable) a;



------------------------------------------------------------------------------------------------------------------------

create table distance(
source varchar(50),
destination varchar(50),
distance integer
);


insert into distance values('Mumbai','Bangalore',500);
insert into distance values('Bangalore','Mumbai',500);
insert into distance values('Delhi','Mathura',150);
insert into distance values('Mathura','Delhi',150);
insert into distance values('Nagpur','Pune',500);
insert into distance values('Pune','Nagpur',500);


select * from distance;

select GREATEST(1,4,9,10);
select GREATEST('Kritika','Akash','Dharti','Pretty');

select LEAST(1,4,9,10);
select LEAST('Kritika','Akash','Dharti','Pretty');

select GREATEST(source,destination) as source , LEAST(source,destination) as destination , max(distance)
from distance
group by GREATEST(source,destination), LEAST(source,destination);

-----------------------------------------------------------------------------------------------------------------------

create table product_inventory_fact
(
product_id varchar(10),
quantity integer,
snapshot_date date
);


insert into product_inventory_fact values ('ITEM1',10,'2022-08-01'),
										  ('ITEM2',14,'2022-08-01'),
										  ('ITEM1',10,'2022-08-02'),
										  ('ITEM2',12,'2022-08-02'),
										  ('ITEM1',5,'2022-08-03'),
										  ('ITEM2',6,'2022-08-03'),
										  ('ITEM3',6,'2022-08-03'),
										  ('ITEM1',10,'2022-08-04'),
										  ('ITEM2',9,'2022-08-04'),
										  ('ITEM3',3,'2022-08-04'),
										  ('ITEM4',8,'2022-08-04');

select * from product_inventory_fact;


select * from 
(select *,
RANK() over(order by snapshot_date desc) as rn,
DENSE_RANK() over(order by snapshot_date desc) as drn
from product_inventory_fact) a
where drn <= 2;


-----------------------------------------------------------------------------------------------------------------------------



create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);


insert into call_start_logs values ('PN1','2022-01-01 10:20:00'),
								   ('PN1','2022-01-01 16:25:00'),
								   ('PN2','2022-01-01 12:30:00'),
								   ('PN3','2022-01-02 10:00:00'),
								   ('PN3','2022-01-02 12:30:00'),
								   ('PN3','2022-01-03 09:20:00');


create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);


insert into call_end_logs values ('PN1','2022-01-01 10:45:00'),
								 ('PN1','2022-01-01 17:05:00'),
								 ('PN2','2022-01-01 12:55:00'),
								 ('PN3','2022-01-02 10:20:00'),
								 ('PN3','2022-01-02 12:50:00'),
								 ('PN3','2022-01-03 09:40:00');


select * from call_start_logs;
select * from call_end_logs;
select s.phone_number,s.rn,s.start_time,e.end_time,DATEDIFF(MINUTE,s.start_time,e.end_time) as duration
from
(select *,
ROW_NUMBER() over(partition by phone_number order by start_time) as rn
from call_start_logs) s
inner join 
(select *,
ROW_NUMBER() over(partition by phone_number order by end_time) as rn
from call_end_logs) e
on s.phone_number = e.phone_number and s.rn = e.rn;

-----
-----2. Approach


select phone_number, rn , min(call_time) as start_time , max(call_time) as end_time, 
DATEDIFF(MINUTE,min(call_time),max(call_time)) as duration
from
(select phone_number,start_time as call_time,
ROW_NUMBER() over(partition by phone_number order by start_time) as rn
from call_start_logs
union all 
select *,
ROW_NUMBER() over(partition by phone_number order by end_time) as rn
from call_end_logs) a
group  by phone_number, rn;


-----------------------------------------------------------------------------------------------------------------------

create table emp_dup_del_record
(
emp_id integer,
emp_name varchar(50),
emp_sal integer,
data_insert datetime
);

insert into emp_dup_del_record values(1,'Ankit',10000,GETDATE()),
									 (2,'Suresh',13000,GETDATE()),
									 (3,'Kamlesh',20000,GETDATE()),
									 (4,'Rakesh',12000,GETDATE()),
									 (5,'Suraj',10000,GETDATE()),
									 (2,'Suresh',13000,GETDATE()),
									 (3,'Kamlesh',20000,GETDATE()),
									 (4,'Rakesh',12000,GETDATE()),
									 (6,'Amit',10000,GETDATE());

insert into emp_dup_del_record values(3,'Kamlesh',20000,GETDATE()),
									 (4,'Rakesh',12000,GETDATE()),
									 (5,'Suraj',10000,GETDATE()),
									 (2,'Suresh',13000,GETDATE());



select * from emp_dup_del_record;

select emp_id, count(1) as count_of_emp_id
from emp_dup_del_record
group by emp_id
having count(1) > 1;


select emp_id, min(data_insert) as time_stamp
from emp_dup_del_record
group by emp_id
having count(1) > 1;



delete from emp_dup_del_record 
where (emp_id,data_insert) in  ---- Having issue
(select emp_id, min(data_insert) as time_stamp
from emp_dup_del_record
group by emp_id
having count(1) > 1);


---------------------------------------------------------------------------------------------------------------------------------

create table drivers
(
id varchar(10), 
start_time time, 
end_time time, 
start_loc varchar(10), 
end_loc varchar(10)
);

insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),
						  ('dri_1', '09:30', '10:30', 'b','c'),
						  ('dri_1','11:00','11:30', 'd','e');

insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),
						  ('dri_1', '13:30', '14:30', 'c','h');

insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),
						  ('dri_2', '13:30', '14:30', 'c','h');


select * from drivers;

select id, COUNT(1) as total_rides, 
sum(case when end_loc = next_ride then 1 else 0 end) as profit_rides
from
(select *
,lead(start_loc, 1) over(partition by id order by start_loc) as next_ride
from drivers) a
group by id;

---------------------------------------------------------------------------------------------------------------------------

create table purchase_history
(
userid int
,productid int
,purchasedate date
);

SET DATEFORMAT dmy;

insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012')
;


select * from purchase_history;

with cte as
(select userid, count(distinct purchasedate) as no_of_dates
,count(productid) as count_prod , count(distinct productid) as count_dist_prod 
from purchase_history
group by userid)

select userid from cte where
no_of_dates > 1 and count_prod = count_dist_prod
;

-------------------------------------------------------------------------------------------------------------------


create table employee_first_last(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int,
    manager_id int,
    emp_age int
);

insert into employee_first_last values(1,'Ankit',100,10000,4,39);
insert into employee_first_last values(2,'Mohit',100,15000,5,48);
insert into employee_first_last values(3,'Vikas',100,10000,4,37);
insert into employee_first_last values(4,'Rohit',100,5000,2,16);
insert into employee_first_last values(5,'Mudit',200,12000,6,55);
insert into employee_first_last values(6,'Agam',200,12000,2,14);
insert into employee_first_last values(7,'Sanjay',200,9000,2,13);
insert into employee_first_last values(8,'Ashish',200,5000,2,12);
insert into employee_first_last values(9,'Mukesh',300,6000,6,51);
insert into employee_first_last values(10,'Rakesh',500,7000,6,50);


select * from employee_first_last;

select *,
FIRST_VALUE(emp_name) over(order by salary) as low_sal_emp,
FIRST_VALUE(emp_name) over(partition by dept_id order by salary) as dep_low_sal_emp
from employee_first_last;

------------------------------------------------------------------------------------------------------------------------------------

create table emp_d
(
emp_id integer,
emp_name varchar(20),
salary integer,
dob date
);

insert into emp_d values(1,'Ankit',10000,'1983-12-02');
insert into emp_d values(2,'Mohit',15000,'1974-12-02');
insert into emp_d values(3,'Vikas',10000,'1985-12-02');
insert into emp_d values(4,'Rohit',5000,'2006-12-02');
insert into emp_d values(5,'Mudit',12000,'1967-12-02');


select * from emp_d;

---Dynamic Insert

select concat('insert into emp_d values(',emp_id,',',char(39),emp_name,char(39),',',salary,',',char(39),dob,char(39),');') 
from emp_d;

insert into emp_d values(1,'Ankit',10000,'1983-12-02');
insert into emp_d values(2,'Mohit',15000,'1974-12-02');
insert into emp_d values(3,'Vikas',10000,'1985-12-02');
insert into emp_d values(4,'Rohit',5000,'2006-12-02');
insert into emp_d values(5,'Mudit',12000,'1967-12-02');

select * from emp_d;

--------------------------------------------------------------------------------------------------------------------------------

Create Table Trade_tbl
(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
);

Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20);
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15);
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30);
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32);
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19);
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19);

select * from Trade_tbl;

select t1.TRADE_ID,t2.TRADE_ID,t1.Trade_Timestamp,t2.Trade_Timestamp, t1.Price, t2.Price, t1.Trade_Stock, t2.Trade_Stock,
abs(t1.Price - t2.Price) * 1.0 / t1.Price * 100
from Trade_tbl t1
inner join Trade_tbl t2 on t1.Trade_Stock = t2.Trade_Stock
where t1.Trade_Timestamp < t2.Trade_Timestamp and datediff(second, t1.Trade_Timestamp,t2.Trade_Timestamp) < 10 and
abs(t1.Price - t2.Price) * 1.0 / t1.Price * 100 > 10
order by t1.TRADE_ID;

------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE [marketing_campaign]
(
 [user_id] [int] NULL,
 [created_at] [date] NULL,
 [product_id] [int] NULL,
 [quantity] [int] NULL,
 [price] [int] NULL
);


insert into marketing_campaign values 
(10,'2019-01-01',101,3,55),
(10,'2019-01-02',119,5,29),
(10,'2019-03-31',111,2,149),
(11,'2019-01-02',105,3,234),
(11,'2019-03-31',120,3,99),
(12,'2019-01-02',112,2,200),
(12,'2019-03-31',110,2,299),
(13,'2019-01-05',113,1,67),
(13,'2019-03-31',118,3,35),
(14,'2019-01-06',109,5,199),
(14,'2019-01-06',107,2,27),
(14,'2019-03-31',112,3,200),
(15,'2019-01-08',105,4,234),
(15,'2019-01-09',110,4,299),
(15,'2019-03-31',116,2,499),
(16,'2019-01-10',113,2,67),
(16,'2019-03-31',107,4,27),
(17,'2019-01-11',116,2,499),
(17,'2019-03-31',104,1,154),
(18,'2019-01-12',114,2,248),
(18,'2019-01-12',113,4,67),
(19,'2019-01-12',114,3,248),
(20,'2019-01-15',117,2,999),
(21,'2019-01-16',105,3,234),
(21,'2019-01-17',114,4,248),
(22,'2019-01-18',113,3,67),
(22,'2019-01-19',118,4,35),
(23,'2019-01-20',119,3,29),
(24,'2019-01-21',114,2,248),
(25,'2019-01-22',114,2,248),
(25,'2019-01-22',115,2,72),
(25,'2019-01-24',114,5,248),
(25,'2019-01-27',115,1,72),
(26,'2019-01-25',115,1,72),
(27,'2019-01-26',104,3,154),
(28,'2019-01-27',101,4,55),
(29,'2019-01-27',111,3,149),
(30,'2019-01-29',111,1,149),
(31,'2019-01-30',104,3,154),
(32,'2019-01-31',117,1,999),
(33,'2019-01-31',117,2,999),
(34,'2019-01-31',110,3,299),
(35,'2019-02-03',117,2,999),
(36,'2019-02-04',102,4,82),
(37,'2019-02-05',102,2,82),
(38,'2019-02-06',113,2,67),
(39,'2019-02-07',120,5,99),
(40,'2019-02-08',115,2,72),
(41,'2019-02-08',114,1,248),
(42,'2019-02-10',105,5,234),
(43,'2019-02-11',102,1,82),
(43,'2019-03-05',104,3,154),
(44,'2019-02-12',105,3,234),
(44,'2019-03-05',102,4,82),
(45,'2019-02-13',119,5,29),
(45,'2019-03-05',105,3,234),
(46,'2019-02-14',102,4,82),
(46,'2019-02-14',102,5,29),
(46,'2019-03-09',102,2,35),
(46,'2019-03-10',103,1,199),
(46,'2019-03-11',103,1,199),
(47,'2019-02-14',110,2,299),
(47,'2019-03-11',105,5,234),
(48,'2019-02-14',115,4,72),
(48,'2019-03-12',105,3,234),
(49,'2019-02-18',106,2,123),
(49,'2019-02-18',114,1,248),
(49,'2019-02-18',112,4,200),
(49,'2019-02-18',116,1,499),
(50,'2019-02-20',118,4,35),
(50,'2019-02-21',118,4,29),
(50,'2019-03-13',118,5,299),
(50,'2019-03-14',118,2,199),
(51,'2019-02-21',120,2,99),
(51,'2019-03-13',108,4,120),
(52,'2019-02-23',117,2,999),
(52,'2019-03-18',112,5,200),
(53,'2019-02-24',120,4,99),
(53,'2019-03-19',105,5,234),
(54,'2019-02-25',119,4,29),
(54,'2019-03-20',110,1,299),
(55,'2019-02-26',117,2,999),
(55,'2019-03-20',117,5,999),
(56,'2019-02-27',115,2,72),
(56,'2019-03-20',116,2,499),
(57,'2019-02-28',105,4,234),
(57,'2019-02-28',106,1,123),
(57,'2019-03-20',108,1,120),
(57,'2019-03-20',103,1,79),
(58,'2019-02-28',104,1,154),
(58,'2019-03-01',101,3,55),
(58,'2019-03-02',119,2,29),
(58,'2019-03-25',102,2,82),
(59,'2019-03-04',117,4,999),
(60,'2019-03-05',114,3,248),
(61,'2019-03-26',120,2,99),
(62,'2019-03-27',106,1,123),
(63,'2019-03-27',120,5,99),
(64,'2019-03-27',105,3,234),
(65,'2019-03-27',103,4,79),
(66,'2019-03-31',107,2,27),
(67,'2019-03-31',102,5,82);

select * from marketing_campaign;


------------------------------------------------------------------------------------------------------------------------------



create table input_p 
(
id int,
formula varchar(10),
value int
);

insert into input_p values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);

select * from input_p;

with cte as
(select *
,left(formula,1) as d1, SUBSTRING(formula,2,1) as op, RIGHT(formula, 1) as d2
from input_p)

select c.id,c.value,c.formula,c.op,i1.value as d1_value, i2.value as d2_value
,case when c.op = '+' then i1.value + i2.value else i1.value - i2.value end as new_value
from cte c inner join input_p i1
on c.d1 = i1.id
inner join input_p i2 
on c.d2 = i2.id
;


----------------------------------------------------------------------------------------------------------------------------

create table hall_events
(
hall_id integer,
start_date date,
end_date date
);


insert into hall_events values 
(1,'2023-01-13','2023-01-14')
,(1,'2023-01-14','2023-01-17')
,(1,'2023-01-15','2023-01-17')
,(1,'2023-01-18','2023-01-25')
,(2,'2022-12-09','2022-12-23')
,(2,'2022-12-13','2022-12-17')
,(3,'2022-12-01','2023-01-30');

select * from hall_events;


------------------------------------------------------------------------------------------------------------------------------

create table product_master 
(
product_id int,
product_name varchar(100)
);


insert into product_master values(100,'iphone5'),(200,'hp laptop'),(300,'dell laptop');

create table orders_usa
(
order_id int,
product_id int,
sales int
);
create table orders_europe
(
order_id int,
product_id int,
sales int
);

create table orders_india
(
order_id int,
product_id int,
sales int
);

--delete from orders_india

insert into orders_usa values (1,100,500);
insert into orders_usa values (7,100,500);

insert into orders_europe values (2,200,600);

insert into orders_india values (3,100,500);
insert into orders_india values (4,200,600);
insert into orders_india values (8,100,500);

select * from product_master;
select * from orders_usa;
select * from orders_europe;
select * from orders_india;

select distinct
coalesce(ou.product_id,oe.product_id,oi.product_id) as product_id, 
ou.sales as USA_Sales,
oe.sales as Europe_Sales,
oi.sales as India_Sales
from orders_usa ou
full outer join orders_europe oe on ou.product_id = oe.product_id
full outer join orders_india oi on coalesce(ou.product_id,oe.product_id) = oi.product_id;

---Other Approach
with cte as
(
select product_id, sales as USA_sales, null as Europe_sales , null as India_sales from orders_usa
union all
select product_id, null as USA_sales, sales as Europe_sales , null as India_sales from orders_europe
union all
select product_id, null as USA_sales, null as Europe_sales , sales as India_sales from orders_india)
select product_id, sum(USA_sales) as USA_sales, sum(Europe_sales) as Europe_sales, sum(India_sales) as India_sales 
from cte
group by product_id
;

------------------------------------------------------------------------------------------------------------------------------------------------

create table family 
(
person varchar(5),
type varchar(10),
age int
);


insert into family values ('A1','Adult',54)
,('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);


select * from family;

with adult as
(
select *,row_Number() over(order by person) as rn from family where type = 'Adult'
),
child as
(
select *,row_Number() over(order by person) as rn from family where type = 'Child'
)
select a.person,c.person 
from adult a left join child c 
on a.rn = c.rn
;

with adult as
(
select *,row_Number() over(order by age desc) as rn from family where type = 'Adult'
),
child as
(
select *,row_Number() over(order by age asc) as rn from family where type = 'Child'
)
select a.person,a.age,c.person , c.age
from adult a left join child c 
on a.rn = c.rn
;

----------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE employee_checkin_details (
    employeeid	INT,
    entry_details	VARCHAR(512),
    timestamp_details	VARCHAR(512)
);

INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'login', '2023-06-16 01:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'login', '2023-06-16 02:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'login', '2023-06-16 03:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1000', 'logout', '2023-06-16 12:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'login', '2023-06-16 01:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'login', '2023-06-16 02:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'login', '2023-06-16 03:00:15.34');
INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES ('1001', 'logout', '2023-06-16 12:00:15.34');

select * from employee_checkin_details; 

CREATE TABLE employee_details (
    employeeid	INT,
    phone_number	INT,
    isdefault	VARCHAR(512)
);

INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES ('1001', '9999', 'false');
INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES ('1001', '1111', 'false');
INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES ('1001', '2222', 'true');
INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES ('1003', '3333', 'false');


select * from employee_details;

select * from employee_checkin_details; 
select * from employee_details;


--- employeeid, employee_default_phone_number, total_entry, total_login, total_logout, latest_login, latest_logout

with login_cte as
(
select employeeid, count(employeeid) as total_entry,
sum(case when entry_details = 'login' then 1 end) as total_login,
sum(case when entry_details = 'logout' then 1 end) as total_logout,
(select max(timestamp_details) from employee_checkin_details where entry_details = 'login') as latest_login,
(select max(timestamp_details) from employee_checkin_details where entry_details = 'logout') as latest_logout
from employee_checkin_details
group by employeeid
)
select l.employeeid,d.phone_number as employee_default_phone_number,
l.total_entry,l.total_login, l.total_logout, l.latest_login,l.latest_logout
from login_cte l inner join employee_details d
on l.employeeid = d.employeeid
where d.isdefault = 'true'
;



-----------------------------------------------------------------------------------------------------------------------------


declare 
	i number;
begin
	 i:= 1;
	 loop
	 dbms_output.put_line(i);
	 i := i + 1;
	 exit when i > 5;
	 end loop;
end;


----------------------------------------------------------------------------------------------------------------------

Create table candidate(
id int primary key,
positions varchar(10) not null,
salary int not null
);

---test case 1:
insert into candidate values(1,'junior',5000);
insert into candidate values(2,'junior',7000);
insert into candidate values(3,'junior',7000);
insert into candidate values(4,'senior',10000);
insert into candidate values(5,'senior',30000);
insert into candidate values(6,'senior',20000);

select * from candidate;

with cte as
(
select *,
sum(salary) over(partition by positions order by salary,id) as runn_sum
from candidate
),
senior_cte as
(
select count(*) as senior, coalesce(SUM(salary),0) as s_sal
from cte
where positions = 'senior' and runn_sum <= 50000
),
junior_cte as
(
select count(*) as junior
from cte
where positions = 'junior' and runn_sum <= 50000 - (select s_sal from senior_cte) 
)
select junior,senior
from junior_cte,senior_cte;


----------------------------------------------------------------------------------------------------------------------------

create table company_revenue 
(
company varchar(100),
year int,
revenue int
);

insert into company_revenue values 
('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);


select * from company_revenue;

with cte as
(
select *,
LAG(revenue,1,0) over(partition by company order by year) as prev_year_revenue,
revenue - LAG(revenue,1,0) over(partition by company order by year) as revenue_diff,
count(year) over(partition by company) as cnt
from 
company_revenue
)
select company , cnt, COUNT(1) as sales_inc_years
from cte 
where revenue_diff > 0
group by company , cnt
having cnt = COUNT(1)
;

--------------------------------------------------------------------------------------------------------------------------------

create table people
(
id int primary key not null,
name varchar(20),
gender char(2)
);

create table relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into people (id, name, gender)
values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');

insert into relations(c_id, p_id)
values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);

select * from people;
select * from relations;


with m_cte as
(
select r.c_id,p.name as mother_name
from relations r
inner join people p
on r.p_id = p.id and gender = 'F'
),
f_cte as
(
select r.c_id,p.name as father_name
from relations r
inner join people p
on r.p_id = p.id and gender = 'M'
)
select m.c_id as child_id ,p.name as child_name, f.father_name as father_name, m.mother_name as mother_name
from m_cte m inner join f_cte f 
on m.c_id = f.c_id
inner join people p on p.id = f.c_id; 


---------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE cinema 
(
    seat_id INT PRIMARY KEY,
    free int
);


INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);


select * from cinema;

with cte as
(
select *, 
ROW_NUMBER() over(order by seat_id) as rn,
seat_id - ROW_NUMBER() over(order by seat_id) as grp
from cinema
where free = 1
)
select seat_id from
(
select *, 
count(*) over(partition by grp) as cnt 
from cte
)a
where cnt > 1;

-------------------------------------------------------------------------------------------------------------------------------

create table job_positions 
(
	id  int,
	title varchar(100),
    groups varchar(10),
    levels varchar(10),     
    payscale int, 
    totalpost int 
);
 
 
insert into job_positions values(1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values(2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values(3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  


create table job_employees 
(
id int, 
name varchar(100),     
position_id int 
);


insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3);

select * from job_positions;
select * from job_employees;


with cte as
(
select id, title, groups, levels, payscale, totalpost, 1 as rn from job_positions
union all
select id, title, groups, levels, payscale, totalpost, rn + 1 from cte
where rn + 1 <= totalpost
),
emp as
(
select *,
ROW_NUMBER() over(partition by position_id order by id) as rn
from job_employees
)
select cte.*,coalesce(emp.name,'Vacant') as name  
from cte left join emp 
on cte.id = emp.position_id and cte.rn = emp.rn
order by cte.id, cte.rn;


---------------------------------------------------------------------------------------------------------------------------------------------

create table students_skills  
(
student_id int,
skill varchar(20)
);


insert into students_skills values
(1,'sql'),(1,'python'),(1,'tableau'),(2,'sql'),(3,'sql'),(3,'python'),(4,'tableau'),(5,'python'),(5,'tableau');

select * from students_skills;

---1. Write a SQL query to find the student belonging to sql and pyhton skills only.

with cte as
(
select student_id,
count(*) as total_skill_cnt,
count(case when skill in ('sql','python') then skill else null end) as sp_skill
from students_skills
group by student_id
)
select * from cte where total_skill_cnt = 2 and sp_skill = 2;


--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');


select * from flights;
select * from flights;


select o.cid, o.origin,d.destination as final_destination from flights o
inner join flights d
on o.destination = d.origin;


-------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE sales_customer
(
    order_date date,
    customer VARCHAR(512),
    qty INT
);

INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-01-01', 'C1', '20');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-01-01', 'C2', '30');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-02-01', 'C1', '10');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-02-01', 'C3', '15');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-03-01', 'C5', '19');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-03-01', 'C4', '10');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-04-01', 'C3', '13');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-04-01', 'C5', '15');
INSERT INTO sales_customer (order_date, customer, qty) VALUES ('2021-04-01', 'C6', '10');


select * from sales_customer;

select order_date,count(distinct customer) as count_new_cust from 
(
select *,
row_number() over(partition by customer order by order_date) as rn
from sales_customer
) a
where rn = 1
group by order_date
;


-------------------------------------------------------------------------------------------------------------------------------

--Independent and subquery 

create table emp_i_s
(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int
);

insert into emp_i_s values (1, 'Ankit', 100,10000, 4, 39);
insert into emp_i_s values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp_i_s values (3, 'Vikas', 100, 10000,4,37);
insert into emp_i_s values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp_i_s values (5, 'Mudit', 200, 12000, 6,55);
insert into emp_i_s values (6, 'Agam', 200, 12000,2, 14);
insert into emp_i_s values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp_i_s values (8, 'Ashish', 200,5000,2,12);
insert into emp_i_s values (9, 'Mukesh',300,6000,6,51);
insert into emp_i_s values (10, 'Rakesh',300,7000,6,50);


select * from emp_i_s;

select e.*,d.avg_sal_dept from emp_i_s e
inner join (
select department_id,
avg(salary) as avg_sal_dept
from emp_i_s
group by department_id) d
on e.department_id = d.department_id
where e.salary > d.avg_sal_dept;


---------------------------------------------------------------------------------------------------------------------------------

create table namaste_python
(
file_name  varchar(100),
content varchar(200)
);

insert into namaste_python values('python bootcamp 1.txt','python for data analytics 0 to here bootcamp starting on jan 6th');
insert into namaste_python values('python bootcamp 2.txt','classes will be held on weekends from 11am  to 1pm for 5-6 weeks');
insert into namaste_python values('python bootcamp 3.txt','use code NY2024 to get 33 percent off. You can register from namaste sql website. Link in pinned comment');


select * from namaste_python;
select * from string_split('python for data analytics 0 to here bootcamp starting on jan 6th',' ');

select value as word, count(value) as count_of_each_word
from namaste_python 
cross apply string_split(content,' ')
group by value
having count(value) > 1
order by count_of_each_word desc;


------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Product_s (
    ProductID INT,
    ProductName VARCHAR(100),
    Tags VARCHAR(100)
);


INSERT INTO Product_s (ProductID, ProductName, Tags)
VALUES
    (1, 'Apple', 'Fruit,Red,Sweet'),
    (2, 'Banana', 'Fruit,Yellow,Sweet'),
    (3, 'Cherry', 'Fruit,Red,Small');

SELECT ProductID, ProductName, value AS Tag
FROM Product_s
CROSS APPLY STRING_SPLIT(Tags, ',');


--------------------------------------------------------------------------------------------------------------------------------


---- Recursive CTE

with my_cte as
(
select 1 as n
union all
select n + 1 from my_cte 
where n < 3
)
select * from my_cte;


CREATE TABLE employees_recursive 
(
emp_id int PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
manager_id INT 
);

INSERT INTO employees_recursive (emp_id, emp_name, manager_id) VALUES
(1, 'Madhav', NULL),
(2, 'Sam', 1),
(3, 'Tom', 2),
(4, 'Arjun', 6),
(5, 'Shiva', 4),
(6, 'Keshav', 1),
(7, 'Damodar', 5);

select * from employees_recursive;

--------------------------------------------------------------------------------------------------------------------------------

create table source
(
id int, 
name varchar(5)
);

create table target
(
id int, 
name varchar(5)
);

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D')

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');

select * from source;
select * from target;


select coalesce(s.id , t.id )as id, 
case when s.name is null then 'New in Target' 
	  when t.name is null then 'New in Source'
	  else
	  'Mismatch'
end as comment
from source s 
full outer join target t
on s.id = t.id
where s.name != t.name or s.name is null or t.name is null;


-------------------------------------------------------------------------------------------------------------------------------

create table clocked_hours
(
empd_id int,
swipe time,
flag char
);

insert into clocked_hours values
(11114,'08:30','I'),
(11114,'10:30','O'),
(11114,'11:30','I'),
(11114,'15:30','O'),
(11115,'09:30','I'),
(11115,'17:30','O');


select * from clocked_hours;

with cte as
(
select * 
,row_number() over(partition by empd_id,flag order by swipe) as rn
from clocked_hours
),cte2 as
(
select empd_id,rn,min(swipe) as swipe_in, max(swipe) as swipe_out, datediff(hour,min(swipe),max(swipe)) as no_of_hours
from cte
group by empd_id,rn
)
select empd_id, sum(no_of_hours) as clocked_in_hours
from cte2
group by empd_id;

----------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE travel_data 
(
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
    ('c1', 'New York', 'Lima'),
    ('c1', 'London', 'New York'),
    ('c1', 'Lima', 'Sao Paulo'),
    ('c1', 'Sao Paulo', 'New Delhi'),
    ('c2', 'Mumbai', 'Hyderabad'),
    ('c2', 'Surat', 'Pune'),
    ('c2', 'Hyderabad', 'Surat'),
    ('c3', 'Kochi', 'Kurnool'),
    ('c3', 'Lucknow', 'Agra'),
    ('c3', 'Agra', 'Jaipur'),
    ('c3', 'Jaipur', 'Kochi');


select * from travel_data;

with cte as
(
select customer,start_loc as location, 'start_loc' as column_name from travel_data
union all
select customer,end_loc as location, 'end_loc' as column_name from travel_data
),
cte2 as
(
select *, count(*) over(partition by customer,location) as cnt
from cte
---order by customer,location
)
select customer,
max(case when column_name = 'start_loc' then location end) as initial_point
,max(case when column_name = 'end_loc' then location end) as final_point
from cte2 
where cnt = 1
group by customer;

----------------------------------------------------------------------------------------------------------------------------------

create table namaste_orders
(
order_id int,
city varchar(10),
sales int
);

create table namaste_returns
(
order_id int,
return_reason varchar(20),
);

insert into namaste_orders
values(1, 'Mysore' , 100),(2, 'Mysore' , 200),(3, 'Bangalore' , 250),(4, 'Bangalore' , 150)
,(5, 'Mumbai' , 300),(6, 'Mumbai' , 500),(7, 'Mumbai' , 800)
;


insert into namaste_returns values
(3,'wrong item'),(6,'bad quality'),(7,'wrong item');


select * from namaste_orders;
select * from namaste_returns;

select o.city,count(r.order_id) as count_of_return_orders
from namaste_orders o left join namaste_returns r
on o.order_id = r.order_id
group by o.city
having count(r.order_id) = 0;


-------------------------------------------------------------------------------------------------------------------------------
create table sku 
(
sku_id int,
price_date date ,
price int
);


insert into sku values 
(1,'2023-01-01',10)
,(1,'2023-02-15',15)
,(1,'2023-03-03',18)
,(1,'2023-03-27',15)
,(1,'2023-04-06',20);

select * from sku;


select * from sku where DATEPART(day,price_date) = 1;

with cte as
(
select *
,ROW_NUMBER() over(partition by sku_id,year(price_date),month(price_date) order by price_date desc) as rn
from sku
)
select sku_id,price_date,price from sku where DATEPART(day,price_date) = 1
union all
select sku_id, datetrunc(month,DATEADD(MONTH,1,price_date)) as next_month,price
from cte
where rn = 1;


--------------------------------------------------------------------------------------------------------------------------------


create table customersName
(
customer_name varchar(30)
);

insert into customersName values ('Ankit Bansal')
,('Vishal Pratap Singh')
,('Michael'); 

select * from customersName;

with cte as
(
select *, REPLACE(customer_name,' ','') as rep_name
,LEN(customer_name) - LEN(REPLACE(customer_name,' ','')) as  no_of_spaces
,CHARINDEX(' ',customer_name) as first_space_position
,CHARINDEX(' ',customer_name,CHARINDEX(' ',customer_name) + 1) as second_space_position
from customersName
)
select * 
,case when no_of_spaces = 0 then customer_name 
else SUBSTRING(customer_name,1, first_space_position - 1) 
end as first_name
,case when no_of_spaces <= 1 then null
else SUBSTRING(customer_name , first_space_position+1,second_space_position - first_space_position -1)
end as middle_name
,case when no_of_spaces = 0 then null 
when no_of_spaces = 1 then SUBSTRING(customer_name,first_space_position + 1,LEN(customer_name)- first_space_position)
when no_of_spaces = 2 then SUBSTRING(customer_name,second_space_position + 1,LEN(customer_name)- second_space_position)
end as last_name
from cte;
------------------------------------------------------------------------------------------------------------------------------





