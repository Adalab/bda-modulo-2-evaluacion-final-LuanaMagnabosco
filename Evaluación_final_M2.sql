USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. */

SELECT DISTINCT title
FROM  film;

/* 2 Muestra los nombres de todas las películas que tengan una clasiﬁcación de "PG-13". */

SELECT title
FROM film
WHERE rating = "PG-13";

/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción. */

SELECT 
	title AS 'Movie',
	description AS 'Description'
FROM film
WHERE description LIKE '%amazing%';

/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. */

SELECT 
	title AS 'Movie',
    length AS 'Length'
FROM film
WHERE length > 120
ORDER BY length;

/* 5. Recupera los nombres de todos los actores. */

SELECT 
	first_name AS 'Actor name'
FROM actor;

/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido. */

SELECT 
	actor.first_name AS 'Actor name',
    actor.last_name AS 'Actor last name'
FROM actor
WHERE last_name LIKE '%Gibson%';


/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. */

SELECT 
	first_name AS 'Actor name' 
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasiﬁcación.*/

SELECT 
	title AS 'Movie',
	rating AS 'Rating'
FROM film
WHERE rating NOT LIKE "R" OR "PG-13";


/* 9. Encuentra la cantidad total de películas en cada clasiﬁcación de la tabla film y muestra la clasiﬁcación junto con el recuento. */

SELECT 
	COUNT(title) AS 'Total movies',
	rating AS 'Rating'
FROM film
GROUP BY rating;

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT 
	customer.customer_id AS 'Customer Id',
	customer.first_name AS 'Name',
	customer.last_name AS 'Last Name',
	COUNT(rental.rental_id) AS 'Movies rented'
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY 
	customer.customer_id, 
    customer.first_name, 
    customer.last_name;

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres. */

SELECT
    category.name AS 'Category',
    COUNT(rental.rental_id) AS 'Rental'
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name;


/* 12. Encuentra el promedio de duración de las películas para cada clasiﬁcación de la tabla film y muestra la clasiﬁcación junto con el promedio de duración. */

SELECT 
	film.rating AS 'Rating',
	AVG(film.length) AS 'Averege'
FROM film
GROUP BY film.rating;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". */

SELECT
	actor.first_name AS 'Actor name',
    actor.last_name AS 'Actor last name'
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id 
WHERE film.title = "Indian Love";

/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción. */

SELECT 
	title AS 'Movie'
FROM film 
WHERE description LIKE '%dog%' OR description LIKE '%cat%'; 

/* 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. */

SELECT
    actor.first_name AS 'Actor name',
    actor.last_name AS 'Actor last name'
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;

/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */

SELECT 
	title AS 'Movie',
    release_year AS 'Release year'
FROM film
WHERE release_year BETWEEN 2005 AND 2010
ORDER BY release_year;


/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family". */

SELECT 
	film.title AS 'Movie'
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

SELECT
	actor.first_name AS 'Actor name',
    actor.last_name AS 'Actor last name'
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY
	actor.actor_id,
    actor.first_name,
    actor.last_name
HAVING COUNT(film_actor.film_id) > 10;

/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film. */

SELECT
	title AS 'Movie',
    film.rating AS 'Rating',
    film.length AS 'Length'
FROM film
WHERE film.rating = 'R' AND film.length > 120;

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. */

SELECT
	category.name AS 'Category',
    AVG(film.length) AS 'Averege'
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING AVG(film.length)> 120;


/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado. */

SELECT
    actor.first_name AS 'Actor name',
    actor.last_name AS 'Actor last name',
    COUNT(film_actor.film_id) AS num_peliculas
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY 
	actor.actor_id, 
    actor.first_name, 
    actor.last_name
HAVING
    COUNT(film_actor.film_id) >= 5;
    
/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

SELECT DISTINCT
	film.title AS 'Movie'
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE inventory.inventory_id IN (
	SELECT rental.rental_id
FROM rental
WHERE film.rental_duration > 5
);

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores. */

SELECT 
    actor.first_name AS 'Actor fn',
    actor.last_name AS 'Actor ln'
FROM actor
WHERE actor.actor_id NOT IN (
	SELECT film_actor.actor_id
	FROM film_actor
	INNER JOIN film_category ON film_actor.film_id = film_category.film_id
	INNER JOIN category ON film_category.category_id = category.category_id
	WHERE category.name = 'Horror'
    );


/* 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film. */

SELECT 
	film.title AS 'Film',
    category.name AS 'Category',
    film.length AS 'Length'
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name LIKE 'Comedy'  AND  film.length > 180;


/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. 
Este ejercicio no he sabido resolverlo, lo he buscado en una consulta externa por no dejarlo sin hacer */

SELECT 
    a1.first_name AS 'Actor 1 Nombre',
    a1.last_name AS 'Actor 1 Apellido',
    a2.first_name AS 'Actor 2 Nombre',
    a2.last_name AS 'Actor 2 Apellido',
    COUNT(*) AS 'Número de Películas Juntas'
FROM 
    film_actor fa1
INNER JOIN 
    film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
INNER JOIN 
    actor a1 ON fa1.actor_id = a1.actor_id
INNER JOIN 
    actor a2 ON fa2.actor_id = a2.actor_id
GROUP BY 
    a1.actor_id, a2.actor_id
HAVING 
    COUNT(*) >= 1
ORDER BY 
    'Número de Películas Juntas' DESC;
