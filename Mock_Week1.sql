--Top Travellers leetcode 1407

SELECT u.name, IFNULL(SUM(r.distance),0) AS travelled_distance
FROM Users u LEFT JOIN Rides r ON u.id = r.user_id
GROUP BY r.user_id
order by travelled_distance desc, name;

--Apple and oranges leetcode 1445

WITH CTE1 AS (
    SELECT sale_date, sold_num
    FROM Sales
    WHERE fruit= 'apples'
    ORDER BY sale_date;
), 
CTE2 AS (
    SELECT sale_date, sold_num
    FROM Sales
    WHERE fruit= 'oranges'
    ORDER BY sale_date
)
SELECT t1.sale_date, t1.sold_num - (SELECT t2.sold_num FROM CTE2 AS t2 WHERE t1.sale_date = t2.sale_date) AS diff
FROM CTE1 AS t1;