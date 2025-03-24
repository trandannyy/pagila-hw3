/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH rental_history AS (
  SELECT customer_id, film_id,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY rental_date DESC) AS rental_num
  FROM rental
  JOIN inventory USING (inventory_id)
)
SELECT DISTINCT rh.customer_id, c.first_name, c.last_name
FROM rental_history rh
JOIN customer c ON rh.customer_id = c.customer_id
JOIN film_category fc ON rh.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action' AND rh.rental_num <= 5
GROUP BY rh.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT rh.film_id) >= 4
ORDER BY rh.customer_id;
