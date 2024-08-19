# Creating And Designing an Online_Shop_Database

# users: user 1

insert into users(id, user_name, password, first_name,last_name,birth_date)
values(uuid(), 'erfantous', 'fg76786318eg7', 'erfan','nazarzadeh','2000-04-29');

select *from users;

select*from roles;

insert into user_roles(user_roles, role_id)
values( '78e5e26b-5e07-11ef-8ecd-f8a96373eb93', 1);

insert into user_roles(user_roles, role_id)
values( '78e5e26b-5e07-11ef-8ecd-f8a96373eb93', 2);

select*from user_roles;
-------------------------------------------------------------------
#user 2: 

set @new_user_created_id = uuid();
insert into users(id, user_name, password, first_name,last_name,birth_date)
values(@new_user_created_id, 'sarcin', 'fg76786318e88', 'sarcin','hoseyni','2008-04-29');

insert into user_roles(user_roles, role_id)
values( @new_user_created_id, 3);
-----------------------------------------------------------------------------
# Category

insert into categories ( title, parent_id)
values('سوپر مارکت' , null),
('لوازم برقی',null),
('پوشاک' ,null),
('اسباب بازی',null);

insert into categories ( title, parent_id)
values('اماکارونی', 1),
('لبنیات', 1),
('گوشت', 1),
('جاروبرقی', 2),
('یخچال' , 2);

select*from categories;

-----------------------------------------------------------
# Products

insert into products(title , detail, price, category_id)
values('گوشت' , null, 100000 , 7  ),
('جارو برقی' , null, 500000 , 8  ),
('یخچال' , null, 1500000 , 9  ),
('عروسک' , null, 60000 , 4  );

select*from products;
--------------------------------------------------------------
#user_basket

insert into user_basket(user_id , product_id , quantity)
values('f0a54b91-5e09-11ef-8ecd-f8a96373eb93' , 1 , 5),
('f0a54b91-5e09-11ef-8ecd-f8a96373eb93' , 3 , 2),
('f0a54b91-5e09-11ef-8ecd-f8a96373eb93' , 4 , 3);

insert into user_basket(user_id , product_id , quantity)
values('78e5e26b-5e07-11ef-8ecd-f8a96373eb93' , 4 , 3);

select*from user_basket;

--------------------------------------------------------------------

#  orders

insert into orders(user_id , order_date, order_id )
values('f0a54b91-5e09-11ef-8ecd-f8a96373eb93' , current_timestamp() , '1');

select* from orders;
--------------------------------------------------------------------------
#order_detail

insert into order_detail(order_id ,product_id , quantity, price )
select 1 ,b.product_id , b.quantity, p.price from user_basket as b 
inner join products as p
on b.product_id = p.product_id;

select* from order_detail;

------------------------------------------------------------------------------

#discount

insert into discount(discount_id , title , discount_code , active_date , expire_date , persentege_discount)
value(1 , 'd1', left(uuid() , 8), '2024-02-01' , '2024-11-30' , 10  );

select*from discount;

----------------------------------------------------------------------------------------------------------
#payment

select id , persentege_discount into @id  , @persentege_discount from discount where discount_code = '235bfa37' and active_date <= date(now()) and expire_date >= date(now());

insert into payment(order_id, discount_id,total_price, discount_amount,total_amount, payment_type, payment_date , payment_code )
select 1 , @id , total_price , total_price * @persentege_discount /100 , price -(total_price * @persentege_discount /100)  , date(now()) , time(now()) ,'35346377678' from (
select sum(price * quantity) as total_price from order_detail where order_id = 1
group by order_id ) as order_detail;



----finish---