/*
 * Compute the country with the most customers in it. 
 */

SELECT country
FROM country
LEFT JOIN (
    SELECT country, COUNT(customer_id) AS c
    FROM customer
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    GROUP BY country
) s1 USING (country)
WHERE s1.c IS NOT NULL
ORDER BY s1.c DESC
LIMIT 1;
