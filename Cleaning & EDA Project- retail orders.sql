select *
from orders;
-----------------------------------------

#creating a copy of original table

create table orders2
like  orders;
INSERT orders2
SELECT * 
FROM orders;
select *
from orders2;
#done
---------------------------------------------------
# cheaking for dublicates

# no dublicates
#Done
------------------------------------------------------
#2. Standardize Data

#rename columns names ..make them lower case and replace space with underscore
#df.rename(columns={'Order Id':'order_id', 'City':'city'}) 

#done by settings

select distinct segment
from orders2;

select distinct county
from orders2;

select*
from orders2;

#done
----------------------------------------------------------
#discount

select*,(last_price * discount_persent) * .01 as discount
from orders2;

alter table orders2
add discount nvarchar(255);

update orders2
set discount = (last_price * discount_persent) * .01;
--------------------------------------------------------
#sale_price

select*,(last_price - discount) as sale_price
from orders2;

alter table orders2
add sale_price nvarchar(255);

update orders2
set sale_price = (last_price - discount);

select*
from orders2;
----------------------------------------------
#profit

select*,(last_price - cost_price) as profit
from orders2;

alter table orders2
add profit nvarchar(255);

update orders2
set profit = (last_price - cost_price) ;

select*
from orders2;
------------------------------------------------

select `order_date`,
  str_to_date(`order_date` , '%d/%m/%Y')
  FROM orders2;
  
  UPDATE orders2
  SET `order_date` =   str_to_date(`order_date` , '%d/%m/%Y');
  
  ALTER TABLE orders2
  modify column `order_date` DATE;
  
  --------------------------------------------------------------
#Replacing one int to sth else...

select distinct ship_mode
from orders2;

select coalesce(ship_mode ,'Not Available') as NULL
from orders2;

UPDATE ORDERS2
SET ship_mode = 'NULL'
WHERE ship_mode = 'Not Available'
;
UPDATE ORDERS2
SET ship_mode = 'NULL'
WHERE ship_mode = 'N/A';

select distinct ship_mode
from orders2;

--------------------------------------------
#droping unuseful culomns

ALTER TABLE orders2
DROP COLUMN cost_price;

ALTER TABLE orders2
DROP COLUMN last_price;

ALTER TABLE orders2
DROP COLUMN discount_persent;

select*
from orders2;

------------------------------------------------------------------------------
#EDA(exploring the data) From Retail-Orders Database

select*from orders2;
--------------------------------------------------------------
#TOP 10 HIGHEST GENRATING REVENUS PRODUCTS

select product_id, round(sum(sale_price),2) as sales
from orders2
group by product_id
order by sales desc
limit 10;
-----------------------------------------------------
#Top 5 SELLING PRODUCT IN EACH REGION

with cte as
(
select region, product_id, round(sum(sale_price),2) as sales
from orders2
group by region,product_id
)
select *,
row_number()over(partition by region order by sales desc) as rn
from cte;


with cte as
(
select region, product_id, round(sum(sale_price),2) as sales
from orders2
group by region,product_id
)
select* from (
select *,
row_number()over(partition by region order by sales desc) as rn
from cte) as rr
where rn<=5;
-------------------------------------------------------------------
# Find month over month growth comparison for 2022 and 2023 sales

select distinct year(order_date)
from orders2;

with cte as (
select year(order_date) as order_year ,month(order_date) as order_month ,round(sum(sale_price),2) as sales
from orders2
group by year(order_date),month(order_date)
#order by year(order_date),month(order_date)
)
select order_month
, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by order_month
order by order_month;

----------------------------------------------------------------------------
# For each category which month had highest sales

select distinct(category)
from orders2;

with cte as (
select category, substring(order_date,1,7) as order_year_month, sum(sale_price) as sales
from orders2
group by category , order_year_month
order by category , order_year_month
)
select *,
row_number()over (partition by category order by sales desc) as rn
from cte;

with cte as (
select category, substring(order_date,1,7) as order_year_month, sum(sale_price) as sales
from orders2
group by category , order_year_month
order by category , order_year_month
) select * from(
select *,
row_number()over (partition by category order by sales desc) as rn
from cte) a 
where rn = 1;

---------------------------------------------------------------------------------------
# which sub-category had highest growth(%) by profit in 2022 compare to 2023

#select sub_categoy , round(sum(sale_price),2) as sales , year(order_date) as order_year
#from orders2
#group by sub_categoy, order_year
#order by sub_categoy, order_year

with cte as (
select sub_categoy, year(order_date) as order_year , round(sum(sale_price),2) as sales
from orders2
group by sub_categoy , year(order_date)
#order by year(order_date),month(order_date)
)
, cte2 as (
select sub_categoy
, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by sub_categoy
order by sub_categoy asc
)
select *
, (sales_2023 - sales_2022) * 100 / sales_2022 as %sales_growth
from cte2
order by sales_growth desc
limit 1;
------------------------------------------------------------------------

 -----And so more-----
