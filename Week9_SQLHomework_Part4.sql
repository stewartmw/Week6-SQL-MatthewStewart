USE sakila;

-- Part 4a - List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(*) AS num_of_lastName
FROM actor
GROUP BY 1;

-- Part 4b - List last names of actors and the number of actors who have that last name,
-- but only for names that are shared by at least two actors

SELECT last_name, COUNT(*) AS num_of_lastName
FROM actor
GROUP BY 1
HAVING num_of_lastName >= 2;

-- Part 4c - The actor HARPO WILLIAMS was accidentally entered in the actor table
-- as GROUCHO WILLIAMS. Write a query to fix the record.

-- Making sure there is only one Groucho Williams
SELECT COUNT(*) FROM actor
WHERE first_name = 'groucho' AND last_name = 'williams'; -- yes, only one

-- Make update
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'groucho' AND last_name = 'williams';

-- Check for number of Harpo first names
SELECT COUNT(*) FROM actor
WHERE first_name = 'harpo'; -- only one

-- Part 4d - Perhaps we were too hasty in changing GROUCHO to HARPO.
-- It turns out that GROUCHO was the correct name after all! In a single query,
-- if the first name of the actor is currently HARPO, change it to GROUCHO.

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'harpo';