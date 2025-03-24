/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT title
FROM film_actor
JOIN film USING (film_id)
WHERE actor_id IN (
    SELECT actor_id
    FROM film
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    WHERE title = 'AMERICAN CIRCUS'
)
ORDER BY title;
