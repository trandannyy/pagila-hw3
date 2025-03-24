/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

SELECT country, total_payments
FROM country
LEFT JOIN (
    SELECT country, SUM(amount) as "total_payments"
    FROM payment
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    GROUP BY country
) s1 USING (country)
WHERE s1.country IS NOT NULL
ORDER BY total_payments DESC, country;
