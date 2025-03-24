/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT name, title, "total rentals"
FROM category
JOIN LATERAL (
    SELECT film_id, title, rank () OVER (ORDER BY count(*) DESC) as rank, count(*) as "total rentals"
    FROM film_category
    JOIN film USING (film_id)
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    WHERE category.category_id = film_category.category_id
    GROUP BY film_id, title
    ORDER BY count(*) DESC, title DESC
    LIMIT 5
) t ON TRUE
ORDER BY name, "total rentals" DESC, title;

-- WITH best_sellers AS (
--     SELECT film_id, name, title, COUNT(rental_id) AS "total rentals",
--     ROW_NUMBER() OVER (PARTITION BY name ORDER BY COUNT(rental_id) DESC) AS "rank"
--     FROM category
--     JOIN film_category USING (category_id)
--     JOIN film USING (film_id)
--     JOIN inventory USING (film_id)
--     JOIN rental USING (inventory_id)
--     JOIN payment USING (rental_id)
--     GROUP BY name, title, film_id
--     ORDER BY title DESC
-- )
-- 
-- SELECT name, title, "total rentals"
-- FROM best_sellers
-- WHERE "rank" <= 5
-- ORDER BY name, "total rentals" DESC, title;


