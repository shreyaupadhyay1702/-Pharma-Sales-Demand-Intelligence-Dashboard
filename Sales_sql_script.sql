USE Sales;
SELECT * FROM cleaned_sales_daily ;


SELECT datum , drug_category , sales_volume, 
CASE 
WHEN Month IN (1,2,3) THEN 'Q1'
WHEN Month IN (4,5,6) THEN 'Q2'
WHEN Month IN (7,8,9) THEN 'Q3'
ELSE 'Q4'
END AS Quater_name ,



SUM(sales_volume) OVER( 
PARTITION BY Drug_Category 
ORDER BY datum) AS Running_Total,


 
AVG(sales_volume) OVER (
PARTITION BY drug_category 
ORDER BY datum 
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
) AS Ma_7_days ,




CASE 
WHEN Sales_Volume > (
SELECT AVG(Sales_volume)
FROM cleaned_sales_daily) THEN 'High Demand'
ELSE 'Normal demand'
END AS Sales_category_flag
FROM cleaned_sales_daily;
