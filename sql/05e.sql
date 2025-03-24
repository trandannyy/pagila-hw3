/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */

WITH american_circus_categories AS (
  SELECT category_id
  FROM film_category
  WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
),
similar_movies AS (
  SELECT f.title, COUNT(DISTINCT fc.category_id) AS shared_categories
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  WHERE fc.category_id IN (SELECT category_id FROM american_circus_categories)
  GROUP BY f.title
  HAVING COUNT(DISTINCT fc.category_id) = 2 OR f.title = 'AMERICAN CIRCUS'
)
SELECT title FROM similar_movies
ORDER BY title;


--SELECT title
--FROM film
--WHERE film_id IN (
--  SELECT DISTINCT f2.film_id
--  FROM film_category f1
--  JOIN film_category f2 ON f1.category_id = f2.category_id
--  WHERE f1.film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
--    AND f2.film_id != (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
--  GROUP BY f2.film_id
--  HAVING (COUNT(DISTINCT f1.category_id) = 2) OR (title = 'AMERICAN CIRCUS')
--)
--
--ORDER BY title;
