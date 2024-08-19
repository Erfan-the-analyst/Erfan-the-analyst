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