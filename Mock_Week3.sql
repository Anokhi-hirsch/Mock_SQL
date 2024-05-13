--Tournament Winners leetcode 1194

SELECT group_id, player_id
FROM (
    SELECT p.player_id, p.group_id, 
    RANK() OVER (PARTITION BY group_id ORDER BY SUM(CASE WHEN p.player_id = m.first_player THEN m.first_score ELSE m.second_score END) DESC, p.player_id ASC) AS 'rnk'
    FROM Players p
    JOIN Matches m ON p.player_id IN (m.first_player , m.second_player)
    ORDER BY p.group_id, p.player_id
) AS t
WHERE rnk=1;

--Or using CTE
WITH CTE AS (
    SELECT p.group_id, p.player_id, 
    RANK() OVER (PARTITION BY p.group_id ORDER BY SUM(CASE WHEN p.player_id = m.first_player THEN m.first_score ELSE m.second_score END) DESC, p.player_id ASC) AS rnk
    FROM Players p
    JOIN Matches m ON p.player_id IN (m.first_player, m.second_player)
    GROUP BY p.group_id, p.player_id
)
SELECT group_id, player_id
FROM CTE
WHERE rnk = 1;

--Market Analysis II Leetcode 1159

WITH CTE1 AS(
    SELECT seller_id, item_id, RANK() OVER (PARTITION BY seller_id ORDER BY order_date) AS rnk
    FROM Orders
),
CTE2 AS(
    SELECT CTE1.seller_id, Items.item_brand
    FROM CTE1
    JOIN Items ON CTE1.item_id = Items.item_id
    WHERE rnk=2
)
SELECT Users.user_id AS seller_id, IF( Users.favorite_brand = CTE2.item_brand, 'yes', 'no') AS 2nd_item_fav_brand
FROM Users
LEFT JOIN CTE2 ON Users.user_id = CTE2.user_id;

