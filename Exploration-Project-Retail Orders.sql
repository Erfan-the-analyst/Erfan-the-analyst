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
 





