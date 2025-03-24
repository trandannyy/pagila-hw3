/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
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
GROUP BY title
HAVING COUNT(actor_id) >= 2
ORDER BY title;
