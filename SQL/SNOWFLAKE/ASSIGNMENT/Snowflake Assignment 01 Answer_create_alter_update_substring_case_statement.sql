---------------------------------------------11th December live class -- Assignment & Doubt----------------------------
--1. Load the given dataset into snowflake with a primary key to Order Date column.
create or replace table AP_Sales_Data(
Order_Id varchar(20),
Order_Date Date primary key,
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

--2. Change the Primary key to Order Id Column.
alter table ap_sales_data
drop primary key;

alter table ap_sales_data
add primary key (ORDER_ID);

Describe table ap_sales_data;

---3. Check the data type for Order date and Ship date and mention in what data type it should be?
--Answer: order_date and ship_date I already upload it in date format

--4. Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.
select *,substring(order_id,9) as extract_order_id from ap_sales_data;

--5. Create a new column called Discount Flag and categorize it based on discount. 
-----Use ‘Yes’ if the discount is greater than zero else ‘No’.
select *,case
            when Discount > 0 then 'YES'
            else 'NO'
       end as Discount_Flag
from ap_sales_data;

--6. Create a new column called process days and calculate how many days it takes for each order id 
-----to process from the order to its shipment.
select datediff('day',order_date,ship_date) as waiting_day_count from ap_sales_data;

--7. Create a new column called Rating and then based on the Process dates give rating like given below.
---------a. If process days less than or equal to 3days then rating should be 5
---------b. If process days are greater than 3 and less than or equal to 6 then rating should be 4
---------c. If process days are greater than 6 and less than or equal to 10 then rating should be 3
---------d. If process days are greater than 10 then the rating should be 2.
select datediff('day',order_date,ship_date) as waiting_day_count,
        case
            when datediff('day',order_date,ship_date) <=3 then 5
            when datediff('day',order_date,ship_date) > 3 and datediff('day',order_date,ship_date) <=6 then 4
            when datediff('day',order_date,ship_date) > 6 and datediff('day',order_date,ship_date) <= 10 then 3
            else 2
       end as Ranking 
from ap_sales_data
order by datediff('day',order_date,ship_date);