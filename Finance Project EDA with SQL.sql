-- MELCHIZEDEK ACKAH-BLAY
-- FINANCE PROJECT: DATA EXPLORATION ANALYSIS PORTION WITH SQL
-- 06-17-2024

-- creating database
CREATE DATABASE youth;
USE youth;

-- looking at the dataset
SELECT * 
FROM data;

-- cleaning the data
DELETE FROM data
WHERE `Customer Age` > 25;

ALTER TABLE data DROP COLUMN Column1;
ALTER TABLE data DROP COLUMN `index`;

ALTER TABLE data RENAME COLUMN `Customer Age` TO Age;
ALTER TABLE data RENAME COLUMN `Customer Gender` TO Gender;
ALTER TABLE data RENAME COLUMN `Product Category` TO Product_Category;
ALTER TABLE data RENAME COLUMN `Sub Category` TO Sub_Category;
ALTER TABLE data RENAME COLUMN `Unit Cost` TO Unit_Cost;
ALTER TABLE data RENAME COLUMN `Unit Price` TO Unit_Price;
ALTER TABLE data RENAME COLUMN `Customer Gender` TO Gender;


-- 1. What is the range of dates in the dataset?
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM data;
-- The dataset ranges from 01/01/15 to 12/31/15



-- 2. How many records are there per year?
SELECT year, COUNT(Country) AS Number_of_Observations
FROM data
GROUP BY year
ORDER BY Number_of_Observations;
-- There are 2,878 records from 2015 and 3,198 records from 2016



-- 3. Are there any seasonal trends in revenue or quantity sold?
ALTER TABLE data ADD COLUMN quarter INT;

UPDATE data
SET quarter = QUARTER(STR_TO_DATE(Date, '%m/%d/%Y'));

SELECT quarter, SUM(Revenue) AS Revenue
FROM data 
GROUP BY quarter
ORDER BY Revenue DESC;

SELECT quarter, SUM(Quantity) AS Quantity
FROM data
GROUP BY quarter
ORDER BY Quantity DESC;
-- The 4th quarter has the highest revenue and product quantity



-- 4. How does revenue vary by month or quarter?
SELECT month, SUM(revenue) AS revenue
FROM data
GROUP BY month
ORDER BY revenue DESC;
-- December and October has the highest revenue whereas July and August have the lowest



-- 5. Are there any significant spikes or dips in revenue over time?
SELECT month, AVG(revenue) AS average_revenue
FROM data
GROUP BY month
ORDER BY average_revenue;
-- Revenue on average is high during ending and starts of the year, during the summer months of August and June, they dip down and rise back up early Fall



-- 6. What is the distribution of customer ages?
SELECT MIN(Age) AS Minimum_Age, AVG(Age) AS Average_Age, MAX(Age) AS Maximum_Age
FROM data;
-- The minimum age is 17, the average age is 21.69 and the maximum age is 25



-- 7. How does customer age correlate with revenue or quantity purchased?
SELECT age, SUM(revenue) AS revenue
FROM data
GROUP BY age
ORDER BY revenue DESC;
-- Generally, the older an individual is, the higher the revenue they generate
SELECT age, SUM(Quantity) AS Quantity
FROM data
GROUP BY age
ORDER BY Quantity DESC;
-- Similarly, the older an individual is, the higher the quantity of products they purchase



-- 8. What is the gender distribution of customers?
SELECT Gender, COUNT(Gender) AS Total
FROM data
GROUP BY Gender;
-- There are 2,828 females and 3,248 males



-- 9. Do different genders show preferences for certain product categories or states?
SELECT Gender, Product_Category, COUNT(Product_Category) AS Count
FROM data
GROUP BY Gender, Product_Category
ORDER BY Count DESC;
-- Both genders have the biggest preference for Accessories
SELECT Gender, State, COUNT(State) AS Count
FROM data
GROUP BY Gender, State
ORDER BY Count DESC;
-- State wise, both genders have the biggest preference for California



-- 10. Are there any trends in customer demographics over time?
SELECT year, month, gender, COUNT(Gender) AS Gender
FROM data
GROUP BY year, month, gender
ORDER BY Gender DESC;
-- 2015, overall had the lowest number of people from both genders especially in the first half of the year
-- Where as the ending months of 2015 and second quarter of 2016saw the highest number of people from both genders



-- 11. Which countries have the highest revenue?
SELECT Country, SUM(Revenue) AS Revenue
FROM data
GROUP BY Country
ORDER BY Revenue DESC;
-- The United States has the highest revenue



-- 12. How does revenue vary across different states or regions?
SELECT State, SUM(Revenue) AS Revenue
FROM data
GROUP BY State
ORDER BY Revenue DESC;
-- California - USA, England - United Kingdom, Washington - USA have the highest revenues state / region wise



-- 13. Are there differences in product preferences between countries or states?
SELECT Country, State, Product_Category, COUNT(Product_Category) AS Count
FROM data
GROUP BY Country, State, Product_Category
ORDER BY Count DESC;
-- California - USA, England - United Kingdom, Washington - USA have the largest preferences for Accessories out of all other state/region combinations. 
-- England - United Kingdom and California - United States also have the largest preferences for Bikes
-- California - USA also has the largest preference for Clothing



-- 14. What is the distribution of customers across countries and states?
SELECT Country, State, COUNT(Product_Category) AS Count
FROM data
GROUP BY Country, State
ORDER BY Count DESC;
-- California - USA and England - United Kingdom have the biggest share of customers



-- 15. Are there any anomalies or outliers in geographic data?
	-- Yes, I would say California-USA is very over-represented with more people that on average than other regions 5X their data



-- 16. What are the top-selling product categories?
SELECT Product_Category, COUNT(Product_Category) AS Count
FROM data
GROUP BY Product_Category
ORDER BY Count DESC;
-- The top selling product categories are Accessories, Clothing, and Bikes in first, second, and third place respectively



-- 17. How does unit price vary across different product categories?
SELECT Product_Category, AVG(Unit_Price) AS Average_Unit_Price
FROM data
GROUP BY Product_Category
ORDER BY Average_Unit_Price;
-- Similar to the top selling rankings, the product categories with the highest unit prices are Accessories, Clothing, and Bikes first, second, and third place respectively



-- 18. Which sub-categories contribute the most to revenue?
SELECT Sub_Category, SUM(Revenue) AS Total_Revenue
FROM data
GROUP BY Sub_Category
ORDER BY Total_Revenue DESC;
-- The sub-categories that generate the most revenue are Mountain Bikes, Tires and Tubes, Road Bikes, Helmets and Jerseys from first to fifth place respectively



-- 19. Is there a correlation between unit cost and unit price?
SELECT Unit_Cost, Unit_Price
FROM data
ORDER BY Unit_Cost DESC;
-- Generally, the bigger the unit cost, the bigger the unit price



-- 20. How does cost-to-revenue ratio vary across products?
SELECT Sub_Category, AVG((Unit_Cost/Revenue))AS average_cost_revenue_ratio
FROM data
GROUP BY Sub_Category
ORDER BY average_cost_revenue_ratio DESC;
-- Mountain Bikes, Touring Bikes, Road Bikes, Gloves, and Hydration Packs have the highest average cost/revenue ratio



-- 21. What is the distribution of quantities sold?
SELECT MIN(Quantity) AS Min, AVG(Quantity) AS Average, MAX(Quantity) AS Max
FROM data;
-- The minimum quantity in the data is 1, the average is 1.99, and the maximum is 3



-- 22. How does unit price affect quantity sold?
SELECT Unit_Price, SUM(Quantity) AS Quantity 
FROM data
GROUP BY Unit_Price
ORDER BY Quantity DESC;
-- Generally, the smaller the unit price, the more greater the quantities sold



-- 23. Are there any pricing trends based on month or product category?
SELECT Month, AVG(Unit_Price) AS Average_Price
FROM data
GROUP BY Month
ORDER BY Average_Price DESC;
-- Prices are highest in July, February, and December. Prices are lowest in August, October, and June



-- 24. How does unit cost compare across different products?
SELECT Sub_Category, AVG(Unit_Price) AS Average_Unit_Price
FROM data
GROUP BY Sub_Category
ORDER BY Average_Unit_Price DESC;
-- Mountain Bikes have the highest average unit price followed by Touring Bikes, Road Bikes, and Hydration Packs
-- 'Bottles and Cages' have the lowest average unit price followed closely by by socks, caps, and cleaners. 



-- 25. Are there any outliers in cost or unit price data?
SELECT Unit_Price
FROM data
ORDER BY Unit_Price DESC; 

SELECT Unit_Cost
FROM data
ORDER BY Unit_Cost DESC; 
-- Unit Price and Cost are fairly normally distributed



-- 26. What is the overall revenue trend over the years?
SELECT year, SUM(Revenue) AS Revenue
FROM data
GROUP BY year
ORDER BY Revenue DESC;
-- Total revenue decreased from 2015 to 2016



-- 27. How does revenue compare with costs on a monthly or quarterly basis?
SELECT Month, AVG (Revenue/Unit_Cost) AS Average_Revenue_per_unit_cost 
FROM data
GROUP BY Month
ORDER BY Average_Revenue_per_unit_cost DESC;
-- Average revenue/Cost ratio is generally decreases throughout the months
SELECT Quarter, AVG (Revenue/Unit_Cost) AS Average_Revenue_per_unit_cost 
FROM data
GROUP BY Quarter
ORDER BY Average_Revenue_per_unit_cost DESC;
-- Similarly, Average revenue/Cost ratio is generally decreases throughout the quarters



-- 28. Is there a seasonal pattern in revenue or cost?
SELECT quarter, AVG(Revenue) AS Revenue
FROM data
GROUP BY quarter
ORDER BY Revenue DESC;
-- Average revenue is highest in the first quarter of the year and then goes down gradually for the next to quarters and rises back up in the 4th quarter



-- 29. What is the profit margin for each product category?
SELECT Product_Category, AVG(Revenue-Unit_Cost) AS Profit
FROM data
GROUP BY Product_Category
ORDER BY Profit DESC;
-- Bikes have an average profit of 618.1, Clothing have an average profit of 298.26 and Accessories have an average profit of 157.61



-- 30. Are there any products with consistently high or low profitability?
	-- The most expensive product categories have the highest average profit
    
    
    
-- 31. How does customer age correlate with revenue or quantity purchased?
SELECT Age, AVG(Revenue) AS Revenue, AVG(Quantity) AS Quantity
FROM data
GROUP BY Age
ORDER BY Revenue DESC, Quantity DESC;
-- Generally, the older an individual is, the higher the revenue they generate and the quantity of products they purchase on average



-- 32. Are there correlations between unit price and revenue?
SELECT Unit_Price, AVG(Revenue) AS Revenue
FROM data
GROUP BY Unit_Price
ORDER BY Unit_Price DESC;
-- Generally, the bigger the unit price, the bigger the average revenue generated by the product



-- 33. Is there a relationship between customer gender and product preferences?
SELECT Gender, Sub_Category, COUNT(Sub_Category) AS Count
FROM data
GROUP BY Gender, Sub_Category
ORDER BY Count DESC;
-- Both men and women have the biggest preference for Tires and Tubes in first place, Bottles and Cages in second place and Helmets in third palce



-- 34. How do cost and revenue correlate across different product categories?
SELECT Product_Category, AVG(Unit_Cost) AS Average_Unit_cost, AVG(Revenue) AS Average_Revenue
FROM data
GROUP BY Product_Category
ORDER BY Average_Unit_cost DESC, Average_Revenue DESC;
-- Bikes have the highest average unit cost and average revenue followed by clothing and accessories



-- 35. What is the average purchase quantity per customer?
SELECT AVG(Quantity) AS Average_Purchase_Quantity
FROM data;
-- The average purchase quantity is 1.99



-- 36. How often do customers from different states make purchases?
SELECT State, AVG(Quantity) AS Quantity
FROM data
GROUP BY State
ORDER BY Quantity DESC;
-- Texas customers purchase 3 items on average which is the highest. Wyoming custmoers have the smallest average quantity at 1



-- 37. Are there any patterns in repeat purchases by customers?
	-- Unsure, because there is no name column in the table or any id that would otherwise reveal a specific individual
    
    
    
-- 38. How does average purchase size vary across different product categories?
SELECT Product_Category, AVG(Quantity) AS Average_Quantity
FROM data
GROUP BY Product_Category
ORDER BY Average_Quantity DESC;
-- Bikes have the biggest average purchase size followed by clothing and accessories



-- 39. Are there seasonal trends in customer purchasing behavior?
ALTER TABLE data ADD COLUMN season VARCHAR(10);

UPDATE data
SET season = CASE
WHEN Month = 'December' OR Month = 'January' OR Month = 'February' THEN 'Winter'
WHEN Month = 'March' OR Month = 'April' OR Month = 'May' THEN 'Spring'
WHEN Month = 'June' OR Month = 'June' OR Month = 'August' THEN 'Summer'
WHEN Month = 'September' OR Month = 'October' OR Month = 'November' THEN 'Fall'
END;

SELECT season, COUNT(season) AS Count
FROM data
GROUP BY season
ORDER BY Count DESC;
-- Customers shop the most in the Spring and the Fall months followed by Winter and very little in the Summer months



-- 40. How does revenue distribution differ between genders?
SELECT Gender, SUM(Revenue) AS Total_Revenue
FROM data
GROUP BY Gender
ORDER BY Total_Revenue DESC;
-- Males generate the most revenue

SELECT Gender, AVG(Revenue) AS Average_Revenue
FROM data
GROUP BY Gender
ORDER BY Average_Revenue DESC;
-- Males also generate the highest avergae revenue



-- 41. Are there significant differences in purchasing behavior between age groups?
	-- Yes, from earlier queries it was found that the older an individual is, the more items they purchase and the higher the revenue generated.alter



-- 42. Which product categories show the highest growth rates over time?
SELECT year, Product_Category, AVG(Revenue) AS Average_Revenue
FROM data
GROUP BY year, Product_Category
ORDER BY Average_Revenue DESC;
-- Bikes product category was the only category to grow from 2015 to 2016 from an average revenue of 1455.54 to 1508.38 



-- 43. How does unit price compare across different product categories and years?
SELECT year, Product_Category, AVG(Unit_Price) AS Average_Unit_Price
FROM data
GROUP BY year, Product_Category
ORDER BY Average_Unit_Price DESC;
-- The unit price of all product categories decreased from 2015 to 2016



-- 44. What are the key insights gained from comparing revenue and cost trends?
	-- Costly products generate the highest revenue



-- 45. Based on revenue trends, which months or quarters are the strongest for sales?
SELECT Month, SUM(Revenue) AS Total_Sales
FROM data
GROUP BY Month
ORDER BY Total_Sales DESC;
-- December, October, May, and April are the strongest months for sales. They have the highest accumulated sales from 2015 - 2016
SELECT quarter, SUM(Revenue) AS Total_Sales
FROM data
GROUP BY quarter
ORDER BY Total_Sales DESC;
-- The 4th and 2nd quarters are the strongest quarters for sales from 2015 to 2016



-- 46. Are there opportunities to optimize pricing based on unit cost and profitability?
	-- From my exploratory data analysis so far, higher cost correlates with revenue hence profitablity. So increasing the price of a product would result in better profitability. 
    -- Additionally, products that have to do with bikes or bike parts have high profitability.
    -- In short, a seller should prioritize selling bike related items at a reasonably high price for good profitability
    
    
    
-- 47. How can geographic insights inform marketing and distribution strategies?
	-- Companies can decide to expand their business in California and England given that those two places are where most revenue is generated, by quite a margin as well
    
    

-- 48. What are the implications of customer demographics on product development?
	-- Using insights from customer demographics, companies can decide which ages to advertise to. Additionally, it can guide their decision making when it comes to producing new products

-- 49. How can historical data trends guide future business decisions?
	-- Based on patterns and data from previous years including but not limited to profits and revenue data, companies can decide which products are worthy of prioritizing, production and markting wise. Additionally, they can compare how they did against their competitors and analyze what made their competitors perform better or worse than them and adapt accordingly


