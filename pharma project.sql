use pharma;

create table inventory(
    Material VARCHAR(50) Null, Material_Description Text Null, 
    Plant VARCHAR(50) Null, Storage_Location VARCHAR(50) Null, 
    Movement_Type VARCHAR(20) Null, Material_Document VARCHAR(50) Null, 
    Material_Document_Item VARCHAR(20) Null, Posting_Date DATE, 
    Qty_in_Unit_of_Entry int Null, Unit_of_Entry VARCHAR(20) Null, Orders VARCHAR(50),
    Reference VARCHAR(50) Null, Movement_Type_Text VARCHAR(100) Null,
    Document_Date DATE, Qty_in_OPUn int Null, 
    Order_Price_Unit VARCHAR(20) Null, Qty_in_order_unit int Null,
    Company_Code VARCHAR(10) Null, Entry_Date DATE,
    Time_of_Entry TIME, Amount_in_LC DECIMAL(18, 2) Null, 
    Purchase_Order VARCHAR(50) Null, Item INT Null, 
    Ext_Amount_in_Local_Currency int Null, Sales_Value int Null,
	Sales_Order_Schedule VARCHAR(50) Null,
    Sales_Order_Item INT Null, Cost_Center VARCHAR(50) Null,
    Movement_indicator VARCHAR(10) Null, Consumption varchar(20) Null,
    Supplier VARCHAR(50) Null, Base_Unit_of_Measure VARCHAR(20) Null, 
    Quantity int Null, Material_Document_Year varchar(20) Null, 
    Reservation VARCHAR(50) Null, Item_No_Stock_Transfer_Reserv VARCHAR(50) Null, 
    Debit_Credit_ind varchar(20) Null, User_name VARCHAR(50) Null, 
    Trans_Event_Type VARCHAR(50) Null, Sales_Value_inc_VA varchar(50), 
    Currency VARCHAR(10) Null, Original_Line_Item VARCHAR(50) Null,
    Material_Type VARCHAR(50) Null, Vendor_code varchar(50)
);

select *from inventory;
drop table inventory;

LOAD DATA INFILE 'pharma dataset new.csv'
INTO TABLE inventory
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;


#EXPLORATORY DATA ANALYSIS(EDA)
#FIRST MOMENT BUSINESS DECISION
#QTY_IN_UNIT_OF_ENTRY   
#MEAN
select avg(Qty_in_Unit_of_Entry) as mean from inventory;

#MEDIAN
select Qty_in_Unit_of_Entry as median
from (
    select Qty_in_Unit_of_Entry, row_number() 
    over (order by Qty_in_Unit_of_Entry) as row_num,
	count(*) over () as total_count
    from inventory
) as subquery
where row_num = (total_count + 1) / 2 or row_num = (total_count + 2) / 2;   

#MODE
select Qty_in_Unit_of_Entry, count(Qty_in_Unit_of_Entry) 
as MODE from inventory group by Qty_in_Unit_of_Entry
order by MODE 
desc limit 1;


#SECOND MOMENT BUSINESS DECISION
#STANDARD DEVIATION
select stddev(Qty_in_Unit_of_Entry) as std_dev
from inventory;

#RANGE
select max(Qty_in_Unit_of_Entry) - min(Qty_in_Unit_of_Entry) as range_data
from inventory;

#VARIANCE
select variance(Qty_in_Unit_of_Entry) as variance_data
from inventory;


#THIRD MOMENT BUSINESS DECISION
#SKEWNESS
select
    (
        sum(power(Qty_in_Unit_of_Entry - (select avg(Qty_in_Unit_of_Entry) 
        from inventory), 3)) / 
        (count(*) * power((select stddev(Qty_in_Unit_of_Entry) 
        from inventory), 3))
    ) 
        as skewness
        from inventory;


#FOURTH MOMENT BUSINESS DECISION
#KURTOSIS
select 
    (
	      (sum(power(Qty_in_Unit_of_Entry - (select avg(Qty_in_Unit_of_Entry) from inventory), 4)) / 
	      (count(*) * power((select stddev(Qty_in_Unit_of_Entry) from inventory), 4))) - 3
    )     
		    as kurtosis
		    from inventory;



#FIRST MOMENT BUSINESS DECISION
#QTY_IN_OPUN
#MEAN
select avg(Qty_in_OPUn) as mean from inventory;

#MEDIAN
select Qty_in_OPUn as median
from (
      select Qty_in_OPUn, row_number() 
      over (order by Qty_in_OPUn) as row_num,
      count(*) over () as total_count
      from inventory
	) as subquery
    where row_num = (total_count + 1) / 2 or row_num = (total_count + 2) / 2; 

#MODE
select Qty_in_OPUn , count(Qty_in_OPUn) 
as MODE from inventory group by Qty_in_OPUn 
order by MODE 
desc limit 1;


#SECOND MOMENT BUSINESS DECISION
#STANDARD DEVIATION
select stddev(Qty_in_OPUn) as std_dev
from inventory;

#RANGE
select max(Qty_in_OPUn) - min(Qty_in_OPUn) as range_data
from inventory;

#VARIANCE
select variance(Qty_in_OPUn) as variance_data
from inventory;


#THIRD MOMENT BUSINESS DECISION
#SKEWNESS
select
    (
        sum(power(Qty_in_OPUn - (select avg(Qty_in_OPUn) 
        from inventory), 3)) / 
        (count(*) * power((select stddev(Qty_in_OPUn) 
        from inventory), 3))
    ) 
        as skewness
        from inventory;


#FOURTH MOMENT BUSINESS DECISION
#KURTOSIS
select 
    (
	      (sum(power(Qty_in_OPUn - (select avg(Qty_in_OPUn) from inventory), 4)) / 
	      (count(*) * power((select stddev(Qty_in_OPUn) from inventory), 4))) - 3
    )     
		    as kurtosis
		    from inventory;



#FIRST MOMENT BUSINESS DECISION
#QTY_IN_ORDER_UNIT
#MEAN
select avg(Qty_in_order_unit) as mean from inventory;     

#MEDIAN
select Qty_in_order_unit as median
from (
      select Qty_in_order_unit, row_number() 
      over (order by Qty_in_order_unit) as row_num,
      count(*) over () as total_count
      from inventory
	) as subquery
	  where row_num = (total_count + 1) / 2 or row_num = (total_count + 2) / 2; 

#MODE	
select Qty_in_order_unit, count(Qty_in_order_unit) 
as MODE from inventory group by Qty_in_order_unit 
order by MODE 
desc limit 1;


#SECOND MOMENT BUSINESS DECISION
#STANDARD DEVIATION
select stddev(Qty_in_order_unit) as std_dev
from inventory;

#RANGE
select max(Qty_in_order_unit) - min(Qty_in_order_unit) as range_data
from inventory;

#VARIANCE
select variance(Qty_in_order_unit) as variance_data
from inventory;


#THIRD MOMENT BUSINESS DECISION
#SKEWNESS
select
    (
        sum(power(Qty_in_order_unit - (select avg(Qty_in_order_unit) 
        from inventory), 3)) / 
        (count(*) * power((select stddev(Qty_in_order_unit) 
        from inventory), 3))
    ) 
        as skewness
        from inventory;


#FOURTH MOMENT BUSINESS DECISION
#KURTOSIS
select 
    (
	      (sum(power(Qty_in_order_unit - (select avg(Qty_in_order_unit) 
          from inventory), 4)) / 
	      (count(*) * power((select stddev(Qty_in_order_unit) 
          from inventory), 4))) - 3
    )     
		    as kurtosis
		    from inventory;


#FIRST MOMENT BUSINESS DECISION
#AMOUNT_IN_LC
#MEAN
select avg(Amount_in_LC) as mean from inventory; 

#MEDIAN
select Amount_in_LC as median
from (
       select  Amount_in_LC , row_number() 
       over (order by  Amount_in_LC ) as row_num,
       count(*) over() as total_count 
       from inventory
      ) as subquery
       where row_num = (total_count + 1) / 2 or row_num = (total_count + 2) / 2;

#MODE
select Amount_in_LC, count(Amount_in_LC) 
as MODE from inventory group by Amount_in_LC 
order by MODE 
desc limit 1;


#SECOND MOMENT BUSINESS DECISION
#STANDARD DEVIATION
select stddev(Amount_in_LC) as std_dev
from inventory;

#RANGE
select max(Amount_in_LC) - min(Amount_in_LC) as range_data
from inventory;

#VARIANCE
select variance(Amount_in_LC) as variance_data
from inventory;


#THIRD MOMENT BUSINESS DECISION
#SKEWNESS
select
    (
        sum(power(Amount_in_LC - (select avg(Amount_in_LC) 
        from inventory), 3)) / 
        (count(*) * power((select stddev(Amount_in_LC) 
        from inventory), 3))
    ) 
        as skewness
        from inventory;


#FOURTH MOMENT BUSINESS DECISION
#KURTOSIS
select 
    (
	      (sum(power(Amount_in_LC - (select avg(Amount_in_LC) 
          from inventory), 4)) / 
	      (count(*) * power((select stddev(Amount_in_LC) 
          from inventory), 4))) - 3
    )     
		    as kurtosis
		    from inventory;


#FIRST MOMENT BUSINESS DECISION
#ITEM
#MEAN
select avg(Item) as mean from inventory;

#MEDIAN
select Item as median
from (
       select  Item , row_number() 
       over (order by Item) as row_num,
       count(*) over() as total_count 
       from inventory
      ) as subquery
       where row_num = (total_count + 1) / 2 or row_num = (total_count + 2) / 2;

#MODE
select Item, count(Item) 
as MODE from inventory group by Item
order by MODE 
desc limit 1;


#SECOND MOMENT BUSINESS DECISION
#STANDARD DEVIATION
select stddev(Item) as std_dev
from inventory;

#RANGE
select max(Item) - min(Item) as range_data
from inventory;

#VARIANCE
select variance(Item) as variance_data
from inventory;


#THIRD MOMENT BUSINESS DECISION
#SKEWNESS
select
    (
        sum(power(Item- (select avg(Item) 
        from inventory), 3)) / 
        (count(*) * power((select stddev(Item) 
        from inventory), 3))
    ) 
        as skewness
        from inventory;


#FOURTH MOMENT BUSINESS DECISION
#KURTOSIS
select 
    (
	      (sum(power(Item - (select avg(Item) 
          from inventory), 4)) / 
	      (count(*) * power((select stddev(Item) 
          from inventory), 4))) - 3
    )     
		    as kurtosis
		    from inventory;


#FIRST MOMENT BUSINESS DECISION
#QUANTITY
#MEAN
select avg(Quantity) as mean from inventory;

#MEDIAN
select Quantity as median
from (
       select  Quantity , row_number() 
       over (order by Quantity) as row_num,
       count(*) over() as total_count 
       from inventory
      ) as subquery
       where row_num = (total_count + 1) / 2 or row_num = (total_count + 2) / 2;
       
#MODE
select Quantity, count(Quantity) 
as MODE from inventory group by Quantity
order by MODE 
desc limit 1;


#SECOND MOMENT BUSINESS DECISION
#STANDARD DEVIATION
select stddev(Quantity) as std_dev
from inventory;

#RANGE
select max(Quantity) - min(Quantity) as range_data
from inventory;

#VARIANCE
select variance(Quantity) as variance_data
from inventory;


#THIRD MOMENT BUSINESS DECISION
#SKEWNESS
select
    (
        sum(power(Quantity- (select avg(Quantity) 
        from inventory), 3)) / 
        (count(*) * power((select stddev(Quantity) 
        from inventory), 3))
    ) 
        as skewness
        from inventory;


#FOURTH MOMENT BUSINESS DECISION
#KURTOSIS
select 
    (
	      (sum(power(Quantity - (select avg(Quantity) 
          from inventory), 4)) / 
	      (count(*) * power((select stddev(Quantity) 
          from inventory), 4))) - 3
    )     
		    as kurtosis
		    from inventory;


select count(*) from inventory;
show columns from inventory from pharma;


#DATA CLEANING,DATA PREPROCESSING
#TYPECASTING
use pharma;
create table inventory_typecasted as
select Material, cast(Material_Description as char(100)) as material_desc_str,
    Plant, Storage_Location, Movement_Type, Material_Document, 
    Material_Document_Item, Posting_Date, Qty_in_Unit_of_Entry, Unit_of_Entry, Orders,
    Reference, Movement_Type_Text, Document_Date, Qty_in_OPUn, 
    Order_Price_Unit, Qty_in_order_unit, Company_Code, Entry_Date,
    Time_of_Entry, Amount_in_LC,  Purchase_Order, Item, 
    Ext_Amount_in_Local_Currency, Sales_Value, Sales_Order_Schedule,
    Sales_Order_Item, Cost_Center, Movement_indicator, Consumption,
    Supplier, Base_Unit_of_Measure, Quantity, Material_Document_Year, 
    Reservation, Item_No_Stock_Transfer_Reserv, Debit_Credit_ind, User_name, 
    Trans_Event_Type, Sales_Value_inc_VA, Currency, Original_Line_Item,
    Material_Type, Vendor_code
    from inventory;
    
select *from inventory_typecasted;
describe inventory_typecasted;

#FIND DUPLICATE RECORDS, COUNT OF DUPLICATES
select *from inventory;
select
         Material,Material_Description,Plant,Storage_Location, Movement_Type ,Material_Document, 
         Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, Unit_of_Entry,Orders,
         Reference,Movement_Type_Text,Document_Date,Qty_in_OPUn, Order_Price_Unit,Qty_in_order_unit,
         Company_Code,Entry_Date,Time_of_Entry ,Amount_in_LC,Purchase_Order,Item , 
         Ext_Amount_in_Local_Currency,Sales_Value,Sales_Order_Schedule,Sales_Order_Item,Cost_Center,
         Movement_indicator,Consumption,Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year, 
         Reservation,Item_No_Stock_Transfer_Reserv,Debit_Credit_ind,User_name,Trans_Event_Type,
         Sales_Value_inc_VA,Currency, Original_Line_Item,Material_Type, Vendor_code,
    count(*) as duplicate_count
from inventory
group by 
         Material, Material_Description,Plant,Storage_Location, Movement_Type , Material_Document, 
         Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, Unit_of_Entry,Orders,
         Reference,Movement_Type_Text,Document_Date,Qty_in_OPUn, Order_Price_Unit,Qty_in_order_unit,
         Company_Code,Entry_Date,Time_of_Entry ,Amount_in_LC,Purchase_Order,Item , 
         Ext_Amount_in_Local_Currency,Sales_Value,Sales_Order_Schedule,Sales_Order_Item,Cost_Center,
         Movement_indicator,Consumption,Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year, 
         Reservation,Item_No_Stock_Transfer_Reserv,Debit_Credit_ind,User_name,Trans_Event_Type,
         Sales_Value_inc_VA,Currency, Original_Line_Item,Material_Type, Vendor_code
having count(*) > 1;             #NO DUPLICATES FOUND

#CHECK FOR NULL AND 0's
select 
    Material,Material_Description,Plant,Storage_Location,Movement_Type, 
    Material_Document,Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, 
    Unit_of_Entry,Orders,Reference,Movement_Type_Text,Document_Date,Qty_in_OPUn, 
    Order_Price_Unit,Qty_in_order_unit,Company_Code,Entry_Date,Time_of_Entry, 
    Amount_in_LC,Purchase_Order,Item,Ext_Amount_in_Local_Currency,Sales_Value, 
    Sales_Order_Schedule,Sales_Order_Item,Cost_Center,Movement_indicator,Consumption, 
    Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year,Reservation, 
    Item_No_Stock_Transfer_Reserv,Debit_Credit_ind,User_name,Trans_Event_Type, 
    Sales_Value_inc_VA,Currency,Original_Line_Item,Material_Type,Vendor_code
from inventory
WHERE 
    Material IS NULL OR Material = 0 OR
    Material_Description IS NULL OR Material_Description = 0 OR
    Plant IS NULL OR Plant = 0 OR
    Storage_Location IS NULL OR Storage_Location = 0 OR
    Movement_Type IS NULL OR Movement_Type = 0 OR
    Material_Document IS NULL OR Material_Document = 0 OR
    Material_Document_Item IS NULL OR Material_Document_Item = 0 OR
    Posting_Date IS NULL OR Posting_Date = 0 OR
    Qty_in_Unit_of_Entry IS NULL OR Qty_in_Unit_of_Entry = 0 OR
    Unit_of_Entry IS NULL OR Unit_of_Entry = 0 OR
    Orders IS NULL OR Orders = 0 OR
    Reference IS NULL OR Reference = 0 OR
    Movement_Type_Text IS NULL OR Movement_Type_Text = 0 OR
    Document_Date IS NULL OR Document_Date = 0 OR
    Qty_in_OPUn IS NULL OR Qty_in_OPUn = 0 OR
    Order_Price_Unit IS NULL OR Order_Price_Unit = 0 OR
    Qty_in_order_unit IS NULL OR Qty_in_order_unit = 0 OR
    Company_Code IS NULL OR Company_Code = 0 OR
    Entry_Date IS NULL OR Entry_Date = 0 OR
    Time_of_Entry IS NULL OR Time_of_Entry = 0 OR
    Amount_in_LC IS NULL OR Amount_in_LC = 0 OR
    Purchase_Order IS NULL OR Purchase_Order = 0 OR
    Item IS NULL OR Item = 0 OR
    Ext_Amount_in_Local_Currency IS NULL OR Ext_Amount_in_Local_Currency = 0 OR
    Sales_Value IS NULL OR Sales_Value = 0 OR
    Sales_Order_Schedule IS NULL OR Sales_Order_Schedule = 0 OR
    Sales_Order_Item IS NULL OR Sales_Order_Item = 0 OR
    Cost_Center IS NULL OR Cost_Center = 0 OR
    Movement_indicator IS NULL OR Movement_indicator = 0 OR
    Consumption IS NULL OR Consumption = 0 OR
    Supplier IS NULL OR Supplier = 0 OR
    Base_Unit_of_Measure IS NULL OR Base_Unit_of_Measure = 0 OR
    Quantity IS NULL OR Quantity = 0 OR
    Material_Document_Year IS NULL OR Material_Document_Year = 0 OR
    Reservation IS NULL OR Reservation = 0 OR
    Item_No_Stock_Transfer_Reserv IS NULL OR Item_No_Stock_Transfer_Reserv = 0 OR
    Debit_Credit_ind IS NULL OR Debit_Credit_ind = 0 OR
    User_name IS NULL OR User_name = 0 OR
    Trans_Event_Type IS NULL OR Trans_Event_Type = 0 OR
    Sales_Value_inc_VA IS NULL OR Sales_Value_inc_VA = 0 OR
    Currency IS NULL OR Currency = 0 OR
    Original_Line_Item IS NULL OR Original_Line_Item = 0 OR
    Material_Type IS NULL OR Material_Type = 0 OR
    Vendor_code IS NULL OR Vendor_code = 0;
#COUNT OF ALL NULL AND 0'S 
SELECT 
    SUM(CASE WHEN Material = 0 THEN 1 ELSE 0 END) AS Material_ZeroCount,
    SUM(CASE WHEN Material_Description = 0 THEN 1 ELSE 0 END) AS Material_Description_ZeroCount,
    SUM(CASE WHEN Plant = 0 THEN 1 ELSE 0 END) AS Plant_ZeroCount,
    SUM(CASE WHEN Storage_Location = 0 THEN 1 ELSE 0 END) AS Storage_Location_ZeroCount,
    SUM(CASE WHEN Movement_Type = 0 THEN 1 ELSE 0 END) AS Movement_Type_ZeroCount,
    SUM(CASE WHEN Material_Document = 0 THEN 1 ELSE 0 END) AS Material_Document_ZeroCount,
    SUM(CASE WHEN Material_Document_Item = 0 THEN 1 ELSE 0 END) AS Material_Document_Item_ZeroCount,
    SUM(CASE WHEN Posting_Date = 0 THEN 1 ELSE 0 END) AS Posting_Date_ZeroCount,
    SUM(CASE WHEN Qty_in_Unit_of_Entry = 0 THEN 1 ELSE 0 END) AS Qty_in_Unit_of_Entry_ZeroCount,
    SUM(CASE WHEN Unit_of_Entry = 0 THEN 1 ELSE 0 END) AS Unit_of_Entry_ZeroCount,
    SUM(CASE WHEN Orders = 0 THEN 1 ELSE 0 END) AS Orders_ZeroCount,
    SUM(CASE WHEN Reference = 0 THEN 1 ELSE 0 END) AS Reference_ZeroCount,
    SUM(CASE WHEN Movement_Type_Text = 0 THEN 1 ELSE 0 END) AS Movement_Type_Text_ZeroCount,
    SUM(CASE WHEN Document_Date = 0 THEN 1 ELSE 0 END) AS Document_Date_ZeroCount,
    SUM(CASE WHEN Qty_in_OPUn = 0 THEN 1 ELSE 0 END) AS Qty_in_OPUn_ZeroCount,
    SUM(CASE WHEN Order_Price_Unit = 0 THEN 1 ELSE 0 END) AS Order_Price_Unit_ZeroCount,
    SUM(CASE WHEN Qty_in_order_unit = 0 THEN 1 ELSE 0 END) AS Qty_in_order_unit_ZeroCount,
    SUM(CASE WHEN Company_Code = 0 THEN 1 ELSE 0 END) AS Company_Code_ZeroCount,
    SUM(CASE WHEN Entry_Date = 0 THEN 1 ELSE 0 END) AS Entry_Date_ZeroCount,
    SUM(CASE WHEN Time_of_Entry = 0 THEN 1 ELSE 0 END) AS Time_of_Entry_ZeroCount,
    SUM(CASE WHEN Amount_in_LC = 0 THEN 1 ELSE 0 END) AS Amount_in_LC_ZeroCount,
    SUM(CASE WHEN Purchase_Order = 0 THEN 1 ELSE 0 END) AS Purchase_Order_ZeroCount,
    SUM(CASE WHEN Item = 0 THEN 1 ELSE 0 END) AS Item_ZeroCount,
    SUM(CASE WHEN Ext_Amount_in_Local_Currency = 0 THEN 1 ELSE 0 END) AS Ext_Amount_in_Local_Currency_ZeroCount,
    SUM(CASE WHEN Sales_Value = 0 THEN 1 ELSE 0 END) AS Sales_Value_ZeroCount,
    SUM(CASE WHEN Sales_Order_Schedule = 0 THEN 1 ELSE 0 END) AS Sales_Order_Schedule_ZeroCount,
    SUM(CASE WHEN Sales_Order_Item = 0 THEN 1 ELSE 0 END) AS Sales_Order_Item_ZeroCount,
    SUM(CASE WHEN Cost_Center = 0 THEN 1 ELSE 0 END) AS Cost_Center_ZeroCount,
    SUM(CASE WHEN Movement_indicator = 0 THEN 1 ELSE 0 END) AS Movement_indicator_ZeroCount,
    SUM(CASE WHEN Consumption = 0 THEN 1 ELSE 0 END) AS Consumption_ZeroCount,
    SUM(CASE WHEN Supplier = 0 THEN 1 ELSE 0 END) AS Supplier_ZeroCount,
    SUM(CASE WHEN Base_Unit_of_Measure = 0 THEN 1 ELSE 0 END) AS Base_Unit_of_Measure_ZeroCount,
    SUM(CASE WHEN Quantity = 0 THEN 1 ELSE 0 END) AS Quantity_ZeroCount,
    SUM(CASE WHEN Material_Document_Year = 0 THEN 1 ELSE 0 END) AS Material_Document_Year_ZeroCount,
    SUM(CASE WHEN Reservation = 0 THEN 1 ELSE 0 END) AS Reservation_ZeroCount,
    SUM(CASE WHEN Item_No_Stock_Transfer_Reserv = 0 THEN 1 ELSE 0 END) AS Item_No_Stock_Transfer_Reserv_ZeroCount,
    SUM(CASE WHEN Debit_Credit_ind = 0 THEN 1 ELSE 0 END) AS Debit_Credit_ind_ZeroCount,
    SUM(CASE WHEN User_name = 0 THEN 1 ELSE 0 END) AS User_name_ZeroCount,
    SUM(CASE WHEN Trans_Event_Type = 0 THEN 1 ELSE 0 END) AS Trans_Event_Type_ZeroCount,
    SUM(CASE WHEN Sales_Value_inc_VA = 0 THEN 1 ELSE 0 END) AS Sales_Value_inc_VA_ZeroCount,
    SUM(CASE WHEN Currency = 0 THEN 1 ELSE 0 END) AS Currency_ZeroCount,
    SUM(CASE WHEN Original_Line_Item = 0 THEN 1 ELSE 0 END) AS Original_Line_Item_ZeroCount,
    SUM(CASE WHEN Material_Type = 0 THEN 1 ELSE 0 END) AS Material_Type_ZeroCount,
    SUM(CASE WHEN Vendor_code = 0 THEN 1 ELSE 0 END) AS Vendor_code_ZeroCount
FROM 
    inventory;
    
#DROPPING COLUMNS HAVING MORE THAN 50% OF NULL OR 0 VALUES
alter table inventory drop Orders;
alter table inventory drop Purchase_Order;
alter table inventory drop Movement_indicator;
alter table inventory drop Consumption;

use pharma;
select *from inventory;
select count(*) from inventory;
     
#OUTLIER DETECTION
use pharma;
select 
    Material,Material_Description,Plant,Storage_Location,Movement_Type, 
    Material_Document,Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, 
    Unit_of_Entry,Reference,Movement_Type_Text,Document_Date, 
    Order_Price_Unit,Company_Code,Entry_Date,Time_of_Entry, 
    Amount_in_LC,Cost_Center,Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year,
    Debit_Credit_ind,User_name,Trans_Event_Type,Vendor_code,
    ntile(4) over (order by Amount_in_LC) AS amount_quartile
    from inventory;
    
#In this code,the NTILE() function is used to divide the data into quartiles based on the salary column.The ORDER BY salary clause ensures that the data is sorted by salary before applying the NTILE() function.
#Outlier Treatment (Replacing with Median)
use pharma;
set sql_safe_updates = 0;
update inventory as i
join (
    select
	Material,Material_Description,Plant,Storage_Location,Movement_Type, 
    Material_Document,Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, 
    Unit_of_Entry,Reference,Movement_Type_Text,Document_Date, 
    Order_Price_Unit,Company_Code,Entry_Date,Time_of_Entry, 
    Amount_in_LC,Cost_Center,Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year,
    Debit_Credit_ind,User_name,Trans_Event_Type,Vendor_code,
    ntile(4) over (order by Amount_in_LC) AS amount_quartile
    from inventory
) as subquery on i.Material= subquery.Material
     set i.Amount_in_LC = (
         select avg (Amount_in_LC)
    from (
        select
               Material,Material_Description,Plant,Storage_Location,Movement_Type, 
               Material_Document,Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, 
               Unit_of_Entry,Reference,Movement_Type_Text,Document_Date, 
               Order_Price_Unit,Company_Code,Entry_Date,Time_of_Entry, 
               Amount_in_LC,Cost_Center,Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year,
			   Debit_Credit_ind,User_name,Trans_Event_Type,Vendor_code,
               ntile(4) over (order by Amount_in_LC) AS amount_quartile
               from inventory
    ) as temp
          where amount_quartile = subquery.amount_quartile
)
          where subquery.amount_quartile in (1, 4);

#MISSING VALUES
use pharma;
select *from inventory;
select
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Order_Price_Unit IS NULL THEN 1 ELSE 0 END) AS order_price_missing,
    SUM(CASE WHEN Cost_Center IS NULL THEN 1 ELSE 0 END) AS cost_center_missing,
    SUM(CASE WHEN Supplier IS NULL THEN 1 ELSE 0 END) AS supplier_missing,
	SUM(CASE WHEN Vendor_code IS NULL THEN 1 ELSE 0 END) AS vendor_code_missing
    from inventory;
    
#CATEGORICAL COLUMNS PERFORMING MODE
select *from inventory;

SELECT Order_Price_Unit, COUNT(*) as frequency
FROM inventory
GROUP BY Order_Price_Unit
ORDER BY frequency DESC
LIMIT 1;
update inventory set Order_Price_Unit= '36678'
where Order_Price_Unit is null;

SELECT Cost_Center, COUNT(*) as frequency
FROM inventory
GROUP BY Cost_Center
ORDER BY frequency DESC
LIMIT 1;
update inventory set Cost_Center= '33271'
where Cost_Center is null;

SELECT Supplier, COUNT(*) as frequency
FROM inventory
GROUP BY Supplier
ORDER BY frequency DESC
LIMIT 1;
update inventory set Vendor_code= '36591'
where Supplier is null;

SELECT Vendor_code, COUNT(*) as frequency
FROM inventory
GROUP BY Vendor_code
ORDER BY frequency DESC
LIMIT 1;
update inventory set Vendor_code= '37213'
where Vendor_code is null;

#CHECK UNIQUE VALUES IN DATASET
select *from inventory;

SELECT
    COUNT(DISTINCT Material) AS unique_Material,
    COUNT(DISTINCT Material_Description) AS unique_Material_Description,
    COUNT(DISTINCT Plant) AS unique_Plant,
    COUNT(DISTINCT Storage_Location) AS unique_Storage_Location,
    COUNT(DISTINCT Movement_Type) AS unique_Movement_Type,
    COUNT(DISTINCT Material_Document) AS unique_Material_Document,
    COUNT(DISTINCT Material_Document_Item) AS unique_Material_Document_Item,
    COUNT(DISTINCT Posting_Date) AS unique_Posting_Date,
    COUNT(DISTINCT Qty_in_Unit_of_Entry) AS unique_Qty_in_Unit_of_Entry,
    COUNT(DISTINCT Unit_of_Entry) AS unique_Unit_of_Entry,
    COUNT(DISTINCT Reference) AS unique_Reference,
    COUNT(DISTINCT Movement_Type_Text) AS unique_Movement_Type_Text,
    COUNT(DISTINCT Document_Date) AS unique_Document_Date,
    COUNT(DISTINCT Order_Price_Unit) AS unique_Order_Price_Unit,
    COUNT(DISTINCT Company_Code) AS Company_Code,
    COUNT(DISTINCT Entry_Date) AS unique_Entry_Date,
    COUNT(DISTINCT Amount_in_LC) AS uniqu_Amount_in_LC,
    COUNT(DISTINCT Cost_Center) AS unique_Cost_Center,
    COUNT(DISTINCT Supplier) AS unique_Supplier,
    COUNT(DISTINCT Base_Unit_of_Measure) AS unique_Base_Unit_of_Measure,
    COUNT(DISTINCT Quantity) AS unique_Quantity,
    COUNT(DISTINCT Material_Document_Year) AS unique_Material_Document_Year,
    COUNT(DISTINCT Debit_Credit_ind) AS unique_Debit_Credit_ind,
    COUNT(DISTINCT User_name) AS unique_User_name,
    COUNT(DISTINCT Trans_Event_Type) AS unique_Trans_Event_Type,
    COUNT(DISTINCT Vendor_code) AS unique_Vendor_code
FROM INVENTORY;

select DISTINCT
    Material AS unique_Material, Material_Description AS unique_Material_Description,
    Plant AS unique_Plant, Storage_Location AS unique_Storage_Location,
    Movement_Type AS unique_Movement_Type, Material_Document AS unique_Material_Document,
    Material_Document_Item unique_Material_Document_Item, Posting_Date AS unique_Posting_Date,
    Qty_in_Unit_of_Entry AS unique_Qty_in_Unit_of_Entry, Unit_of_Entry AS unique_Unit_of_Entry,
    Reference AS unique_Reference, Movement_Type_Text AS unique_Movement_Type_Text,
    Document_Date AS unique_Document_Date,Order_Price_Unit AS unique_Order_Price_Unit,
	Company_Code AS Company_Code, Entry_Date AS unique_Entry_Date,
    Amount_in_LC AS uniqu_Amount_in_LC,Cost_Center AS unique_Cost_Center,
    Supplier AS unique_Supplier,Base_Unit_of_Measure AS unique_Base_Unit_of_Measure,
    Quantity AS unique_Quantity,Material_Document_Year AS unique_Material_Document_Year,
    Debit_Credit_ind AS unique_Debit_Credit_ind, User_name AS unique_User_name,
    Trans_Event_Type AS unique_Trans_Event_Type,Vendor_code AS unique_Vendor_code
FROM
    INVENTORY;
    
use pharma; select *from inventory;
select max(Amount_in_LC) from inventory;
select min(Amount_in_LC) from inventory;
select avg(Amount_in_LC) from inventory;

#SCALING
CREATE TABLE inventory_scaled AS
SELECT 
   Material,Material_Description,Plant,Storage_Location,Movement_Type, 
	Material_Document,Material_Document_Item,Posting_Date, 
	Unit_of_Entry,Reference,Movement_Type_Text,Document_Date, 
	Order_Price_Unit,Company_Code,Entry_Date,Time_of_Entry, 
	Cost_Center,Supplier,Base_Unit_of_Measure,Material_Document_Year,
	Debit_Credit_ind,User_name,Trans_Event_Type,Vendor_code,
    (Qty_in_Unit_of_Entry - min_Qty_in_Unit_of_Entry) / (max_Qty_in_Unit_of_Entry - Qty_in_Unit_of_Entry) AS scaled_salary,
    (Amount_in_LC - min_Amount_in_LC) / (max_Amount_in_LC - min_Amount_in_LC) AS scaled_Amount_in_LC,
    (Quantity - min_Quantity) / (max_Quantity - min_Quantity) AS scaled_rating
FROM (
    SELECT 
        Material,Material_Description,Plant,Storage_Location,Movement_Type, 
		Material_Document,Material_Document_Item,Posting_Date,Qty_in_Unit_of_Entry, 
		Unit_of_Entry,Reference,Movement_Type_Text,Document_Date, 
		Order_Price_Unit,Company_Code,Entry_Date,Time_of_Entry, 
		Amount_in_LC,Cost_Center,Supplier,Base_Unit_of_Measure,Quantity,Material_Document_Year,
		Debit_Credit_ind,User_name,Trans_Event_Type,Vendor_code,
        
        (SELECT MIN(Qty_in_Unit_of_Entry) FROM inventory AS min_Qty_in_Unit_of_Entry,
        (SELECT MAX(Qty_in_Unit_of_Entry) FROM inventory) AS max_Qty_in_Unit_of_Entry,
        (SELECT MIN(Amount_in_LC) FROM inventory) AS min_Amount_in_LC,
        (SELECT MAX(Amount_in_LC) FROM inventory) AS max_Amount_in_LC,
        (SELECT MIN(Quantity) FROM inventory) AS min_Quantity,
        (SELECT MAX(Quantity) FROM inventory) AS max_Quantity) 
        FROM inventory
) AS scaled_data;








