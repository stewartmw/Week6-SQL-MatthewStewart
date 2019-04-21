USE sakila;

-- Part 7a - The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- As an unintended consequence, films starting with the letters K and Q
-- have also soared in popularity. Use subqueries to display the titles of movies starting with
-- the letters K and Q whose language is English.

SELECT title FROM film
WHERE
	(title LIKE 'K%' OR title LIKE 'Q%')
    AND
    language_id IN (
		SELECT language_id FROM language
		WHERE name = 'English'
	);

-- Part 7b - Use subqueries to display all actors who appear in the film Alone Trip.

SELECT (
	SELECT title FROM film
	WHERE title = 'Alone Trip'
	) AS movie_title,
	first_name AS actor_firstName,
    last_name AS actor_lastName
FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
    WHERE film_id IN (
		SELECT film_id FROM film
        WHERE title = 'Alone Trip'
	)
);

-- Part 7c - You want to run an email marketing campaign in Canada,
-- for which you will need the names and email addresses of all Canadian customers.
-- Use joins to retrieve this information.

SELECT
	first_name,
    last_name,
    email,
    country
FROM customer
JOIN address
	ON customer.address_id = address.address_id
JOIN city
	ON address.city_id = city.city_id
JOIN country
	ON city.country_id = country.country_id
WHERE country = 'Canada'
ORDER BY 2;

-- Part 7d - Sales have been lagging among young families, and you wish to target
-- all family movies for a promotion. Identify all movies categorized as family films.

SELECT
	film_id,
    title,
    name AS film_type
FROM film
JOIN film_category
	USING (film_id)
JOIN category
	ON film_category.category_id = category.category_id
WHERE name = 'Family';

-- Part 7e - Display the most frequently rented movies in descending order.

-- See comments below regarding the sub-query being the starting point for this overall query.
-- Once we have grouped by inventory_id, we can see more clearly the one-to-many relationship from film_id to inventory_id.
-- Using the results of the sub-query, we then group by film_id in order to get the total number times each movie was rented.
SELECT
	film_id,
    title,
    SUM(num_of_rentals) AS total_rentals
FROM (
-- Sub-query - The following sub-query is really the starting point for the overall query.
-- Since we have to start with the rental table, which only has an inventory_id,
-- we first have to group by inventory_id to find the number of times each individual inventory item was rented.
	SELECT
		inventory_id,
		inventory.film_id,
		title,
		COUNT(*) AS num_of_rentals
	FROM rental
	JOIN inventory
		USING (inventory_id)
	JOIN film
		USING (film_id)
	GROUP BY inventory_id
) AS temp
GROUP BY film_id
-- Use the following ORDER BY to identify the most frequently-rented movies.
ORDER BY total_rentals DESC;

-- Part 7f - Write a query to display how much business, in dollars, each store brought in.

SELECT
	store_id,
    CONCAT('$', FORMAT(SUM(amount), 2)) AS total_business
FROM payment
JOIN staff
	USING (staff_id)
GROUP BY 1;

-- Part 7g - Write a query to display for each store its store ID, city, and country.

SELECT
	store_id,
    city,
    country
FROM store
JOIN address
	USING (address_id)
JOIN city
	USING (city_id)
JOIN country
	USING (country_id);

-- Part 7h - List the top five genres in gross revenue in descending order.
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT
    name AS category_name,
    CONCAT('$', FORMAT(SUM(amount), 2)) AS gross_revenue
FROM payment
JOIN rental
	USING (rental_id)
JOIN inventory
	USING (inventory_id)
JOIN film_category
	USING (film_id)
JOIN category
	USING (category_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;