---------------------------------------------11th December live class -- Assignment & Doubt----------------------------
create or replace table AP_Sales_Data(
Order_Id varchar(20),
Order_Date Date,
Ship_Date Date,
Ship_Mode varchar(20),
Customer_name varchar(30),
Segment varchar(20),
State varchar(50),
Country varchar(50),
Mark varchar(10),
Region varchar(20),
Product_Id varchar(30),
Category varchar(25),
Sub_Category varchar(30),
product_name varchar(150),
Sales Number(8,2),
Quantity Number(8,2),
Discount Number(8,2),
Profit Number(12,6),
Shipping_Cost Number(8,2),
Order_Priority varchar(20),
Year Number(8));

describe table ap_sales_data;

select * from ap_sales_data;--51,290 rows

----1 .SET PRIMARY KEY.---------
alter table ap_sales_data
add primary key(ORDER_ID);

Describe table ap_sales_data;

---2. CHECK THE ORDER DATE AND SHIP DATE TYPE AND THINK IN WHICH DATA TYPE YOU HAVE TO CHANGE.
--Answer: order_date and ship_date I already upload it in date format

--3. EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT.
select *,substring(order_id,9) as extract_order_id from ap_sales_data;

--4.  FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN  YES ELSE FALSE AND PUT IT IN NEW COLUMN FRO EVERY ORDER ID.
select *,case
            when Discount > 0 then 'YES'
            else 'FALSE'
       end as Discount_status
from ap_sales_data;

--6.  FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID.
select datediff('day',order_date,ship_date) as waiting_day_count from ap_sales_data;

--7 . FLAG THE PROCESS DAY AS BY RATING IF IT TAKES LESS OR EQUAL 3  DAYS MAKE 5,
--LESS OR EQUAL THAN 6 DAYS BUT MORE THAN 3 MAKE 4,
--LESS THAN 10 BUT MORE THAN 6 MAKE 3,MORE THAN 10 MAKE IT 2 FOR EVERY ORDER ID.
select datediff('day',order_date,ship_date) as waiting_day_count,
        case
            when datediff('day',order_date,ship_date) <=3 then 5
            when datediff('day',order_date,ship_date) <=6 and datediff('day',order_date,ship_date) > 3 then 4
            when datediff('day',order_date,ship_date) <10 and datediff('day',order_date,ship_date) > 6 then 3
            else 2
       end as Ranking 
from ap_sales_data
order by datediff('day',order_date,ship_date);