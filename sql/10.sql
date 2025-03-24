/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

SELECT * FROM (
    SELECT customer_id,
           first_name || ' ' || last_name AS "name",
           SUM(amount) AS "total_payment",
           ntile(100) OVER(
            ORDER BY SUM(amount)) AS "percentile"
    FROM customer
    JOIN payment USING (customer_id)
    GROUP BY customer_id
) AS s1
WHERE percentile >= 90
ORDER BY name;
