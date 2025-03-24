/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */

SELECT title, actors
FROM nicer_but_slower_film_list
WHERE category = 'Documentary'
AND rating = 'G'
ORDER BY title, actors;

-- SELECT DISTINCT film.title, actors
-- FROM film
-- JOIN film_category USING (film_id)
-- JOIN category USING (category_id)
-- JOIN LATERAL (
--     SELECT DISTINCT title, actors
--     FROM nicer_but_slower_film_list
-- ) AS l USING (title)
-- WHERE rating = 'G' AND name = 'Documentary'
-- ORDER BY film.title;

