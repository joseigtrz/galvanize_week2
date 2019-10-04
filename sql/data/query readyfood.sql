select top 10
userid,dt
from readychef.dbo.users
where campaign_id='FB';

SELECT COUNT(*) FROM readychef.dbo.users;

SELECT COUNT(*) FROM readychef.dbo.users
where campaign_id = 'FB';

SELECT campaign_id, COUNT(*) FROM readychef.dbo.users
group by campaign_id;

SELECT COUNT(distinct dt) 
FROM readychef.dbo.users;


SELECT MIN(dt), MAX(dt) 
FROM readychef.dbo.users;

SELECT avg(price)
FROM readychef.dbo.meals;

SELECT type, avg(price) as AVG_PRICE,
min(price) as MIN_PRICE, max(price) as MAX_PRICE
FROM readychef.dbo.meals
group by type;


select *
FROM readychef.dbo.meals
where MONTH(dt)<=3 and YEAR(dt)=2013;

SELECT type, month(dt) as [month], avg(price) as AVG_PRICE,
min(price) as MIN_PRICE, max(price) as MAX_PRICE
FROM readychef.dbo.meals
group by type, month(dt)
order by type, month(dt);

select meal_id,
[event], count([userid]) as Count
FROM readychef.dbo.[events]
group by meal_id, [event]
order by meal_id, [event]

select A.userid,
B.campaign_id, 
A.meal_id,
A.[event]
from  readychef.dbo.[events] A
inner join readychef.dbo.[users] B
on A.userid = B.userid

select A.userid,
B.campaign_id, 
A.meal_id,
C.[type],
C.[price]
from  readychef.dbo.[events] A
inner join readychef.dbo.[users] B
on A.userid = B.userid
inner join readychef.dbo.[meals] C
on A.meal_id = C.meal_id
where A.[event] = 'bought'


select 
C.[type],
count(A.meal_id) as count
from  readychef.dbo.[events] A
inner join readychef.dbo.[meals] C
on A.meal_id = C.meal_id
where A.[event] = 'bought'
group by C.[type]