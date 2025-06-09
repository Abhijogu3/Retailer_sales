use sql_project_p2;

Select COUNT(*) from Sales;

-- Data Cleaning 

Select * from Sales
WHERE transactions_id is Null;

Select * from Sales
WHERE sale_date is Null;

Select * from Sales
WHERE sale_time is Null;

Select * from Sales
WHERE transactions_id is Null
	or
	sale_time is Null
	or
	sale_date is Null
	or
	gender is Null
	or 
	category is Null
	or
	price_per_unit is Null
	or
	quantiy is Null
	or
	cogs is Null
	or
	total_sale is Null;

	------

Delete from Sales
WHERE transactions_id is Null
	or
	sale_time is Null
	or
	sale_date is Null
	or
	gender is Null
	or 
	category is Null
	or
	price_per_unit is Null
	or
	quantiy is Null
	or
	cogs is Null
	or
	total_sale is Null;

-- Data Exploration 

--How Many sales we have?

select count (*) as total_sales From Sales;

--How many uniqe customers sales we have?

select count (Distinct customer_id) as total_sales From Sales;

select Distinct category From Sales;


-- Data Analysis & Business key problems & answers

-- My Analysis & Findings
--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
--
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in
--the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <= 12, Afternoon Between 12 & 17, Evening >17)

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

Select * from Sales
Where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in
--the month of Nov-2022

SELECT 
*
FROM Sales
WHERE category = 'Clothing'
	and
	FORMAT(sale_date, 'YYYY-MM') = '2022-11'
	And
	quantiy >= 4;

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select
	ROund (AVG(age), 2) as avg_age
FROM Sales
Where category ='Beauty' 

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from Sales
Where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 

Select
	category,
	gender,
	Count (*) as total_trans
From Sales
group by category, gender
ORDER BY gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

WITH MonthlyRankedSales AS (
    SELECT
        YEAR(sale_date) AS years,
        MONTH(sale_date) AS months,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT *
FROM MonthlyRankedSales
WHERE rank = 1
ORDER BY years, months;.

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

Select top 5
	customer_id,
	sum(total_sale) as total_sales
from Sales
group By customer_id
ORder by total_sales desc

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

Select top 5
	category,
	count(distinct customer_id)
from Sales
group By category

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <= 12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale AS (
    SELECT 
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM Sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

---EOP
