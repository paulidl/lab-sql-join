-- Lab | SQL Join: In this lab, you will be using the Sakila database of movie rentals.

USE sakila;
-- Instructions

-- 1. List the number of films per category.

SELECT * FROM sakila.category;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.film;

SELECT name AS category, count(title)
FROM sakila.category c
JOIN sakila.film_category fc ON c.category_id = fc.category_id
JOIN sakila.film f ON f.film_id = fc.film_id
GROUP BY name
ORDER BY count(title) ASC;

-- 2. Display the first and the last names, as well as the address, of each staff member.

SELECT * FROM sakila.staff;	  -- address_id
SELECT * FROM sakila.address; -- address_id

SELECT first_name, last_name, address
FROM sakila.staff s
LEFT JOIN sakila.address a ON a.address_id = s.address_id;

-- 3. Display the total amount rung up by each staff member in August 2005.

SELECT * FROM sakila.payment; -- staff_id
SELECT * FROM sakila.staff;  -- staff_id

SELECT s.staff_id, sum(amount) as total_amount_rung, 
FROM sakila.staff s 
JOIN sakila.payment p ON s.staff_id = p.staff_id
WHERE MONTH(p.payment_date) = 8 AND YEAR(p.payment_date) = 2005
GROUP BY staff_id;

-- 4. List all films and the number of actors who are listed for each film.

SELECT * FROM sakila.film; 			-- film_id, title
SELECT * FROM sakila.film_actor;    -- film_id, actor_id

SELECT f.title, count(fa.actor_id) as number_of_actors 
FROM sakila.film f
JOIN sakila.film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY count(fa.actor_id) DESC;

-- 5. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. 
-- List the customers alphabetically by their last names.

SELECT * FROM sakila.payment; 		-- customer_id, amount
SELECT * FROM sakila.customer;	    -- customer_id, last_name, first_name

SELECT c.last_name, c.first_name, sum(p.amount) AS total_amount_paid
FROM sakila.customer c
JOIN sakila.payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;
