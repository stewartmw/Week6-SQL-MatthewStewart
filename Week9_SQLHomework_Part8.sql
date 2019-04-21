USE sakila;

-- Part 8a - In your new role as an executive, you would like to have an easy way of viewing
-- the Top five genres by gross revenue. Use the solution from the problem above to create a view.
-- If you haven't solved 7h, you can substitute another query to create a view.

CREATE VIEW top_five_genres AS
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

-- Part 8b - How would you display the view that you created in 8a?

SELECT * FROM top_five_genres;

-- Part 8c - You find that you no longer need the view top_five_genres. Write a query to delete it.

DROP VIEW IF EXISTS top_five_genres;