-- Product sales Analysis III leetcode 1070

SELECT product_id, year AS first_year, quantity, price
FROM Sales 
WHERE (product_id,year) IN (
    SELECT product_id,MIN(year) AS year FROM Sales GROUP BY product_id);

--Customer who bought all products leetcode 1045

SELECT customer_id FROM Customer GROUP BY customer_id
Having COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product);