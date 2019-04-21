USE sakila;

-- Part 6a - Use JOIN to display the first and last names, as well as the address,
-- of each staff member. Use the tables staff and address.

-- MS NOTE: I also used the city and country tables because these contain relevant address information.
SELECT
	first_name,
    last_name,
    address,
    address2,
    district,
    city,
    postal_code,
    country
FROM staff
JOIN address
	ON staff.address_id = address.address_id
JOIN city
	ON address.city_id = city.city_id
JOIN country
	ON city.country_id = country.country_id;

-- Part 6b - Use JOIN to display the total amount rung up by each staff member
-- in August of 2005. Use tables staff and payment.

SELECT
    staff_id,
    first_name,
    last_name,
    CONCAT('$', FORMAT(SUM(amount), 2)) AS total_rung_up_aug05
FROM staff
JOIN payment
	USING (staff_id)
WHERE payment_date LIKE '2005-08%'
GROUP BY 1;

-- Part 6c - List each film and the number of actors who are listed for that film.
-- Use tables film_actor and film. Use inner join.

SELECT
	film_id,
    title,
    COUNT(actor_id) AS num_of_actors
FROM film
JOIN film_actor
	USING (film_id)
GROUP BY 1;

-- Part 6d - How many copies of the film Hunchback Impossible exist in the inventory system?
-- Answer: 6

SELECT
	film_id,
    title,
    COUNT(inventory_id) AS num_in_inventory
FROM film
JOIN inventory
	USING (film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY 1;

-- Part 6e - Using the tables payment and customer and the JOIN command,
-- list the total paid by each customer. List the customers alphabetically by last name

SELECT
	customer_id,
    first_name,
    last_name,
    CONCAT('$', FORMAT(SUM(amount), 2)) AS total_paid
FROM customer
JOIN payment
	USING (customer_id)
GROUP BY 1
ORDER BY 3;