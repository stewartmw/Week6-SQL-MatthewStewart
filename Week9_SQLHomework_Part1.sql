USE sakila;

-- Part 1a - Display the first and last names of all actors from the table actor.

SELECT first_name, last_name
FROM actor;

-- Part 1b - Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.

SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name'
FROM actor;