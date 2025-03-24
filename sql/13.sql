/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

WITH actor_movies AS (
    SELECT actor_id, first_name, last_name, f.film_id, f.title,
    ROW_NUMBER() OVER (PARTITION BY actor_id ORDER BY SUM(amount) DESC) AS "rank", SUM(amount) AS revenue
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film f USING (film_id)
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    JOIN payment USING (rental_id)
    GROUP BY actor_id, f.film_id, f.title
)
SELECT * FROM actor_movies
WHERE "rank" <= 3
ORDER BY actor_id;

-- SELECT a.actor_id, a.first_name, a.last_name, mr.film_id, mr.title, mr.movie_ranking AS "rank", revenue
-- FROM actor a
-- LEFT JOIN LATERAL (
--     SELECT actor_id, film_id, title, ROW_NUMBER() OVER (PARTITION BY actor_id ORDER BY SUM(amount) DESC) AS movie_ranking, SUM(amount) as revenue
--     FROM film_actor
--     JOIN film USING (film_id)
--     JOIN inventory USING (film_id)
--     JOIN rental USING (inventory_id)
--     JOIN payment USING (rental_id)
--     GROUP BY actor_id, film_id, title
-- ) mr ON true
-- WHERE mr.movie_ranking <= 3
-- ORDER BY actor_id;

