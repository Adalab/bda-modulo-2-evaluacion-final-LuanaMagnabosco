USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. */

SELECT DISTINCT title
FROM  film;

/* 2 Muestra los nombres de todas las películas que tengan una clasiﬁcación de "PG-13". */

SELECT title
FROM film
WHERE rating = "PG-13";

/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción. */

SELECT title,
description
FROM film
WHERE description LIKE '%amazing%';

/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. */

SELECT title
FROM film
WHERE rating > 120;

/* 5. Recupera los nombres de todos los actores. */

SELECT first_name
FROM actor;

/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido. */

SELECT 
	first_name,
    last_name
FROM actor
WHERE last_name LIKE '%Gibson%';


/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. */

SELECT first_name 
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasiﬁcación. */

SELECT title AS 'Título',
rating AS 'Clasificación'
FROM film
WHERE rating NOT LIKE "R" OR "PG-13";


/* 9. Encuentra la cantidad total de películas en cada clasiﬁcación de la tabla film y muestra la clasiﬁcación junto con el recuento. */

SELECT COUNT(title) AS 'Total peliculas',
rating AS 'Clasificación'
FROM film
GROUP BY rating;

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT 
	customer.customer_id AS 'Id Cliente',
	customer.first_name AS 'Nombre',
	customer.last_name AS 'Apellido',
	COUNT(rental.rental_id) AS 'Cantidad de peliculas alquiladas'
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY 
	customer.customer_id, 
    customer.first_name, 
    customer.last_name;

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres. */

/* 12. Encuentra el promedio de duración de las películas para cada clasiﬁcación de la tabla film y muestra la clasiﬁcación junto con el promedio de duración. */

SELECT 
	film.rating AS 'Clasificación',
	AVG(film.length) AS 'Promedio'
    
FROM film
GROUP BY film.rating;

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". */

/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción. */

/* 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. */

/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */

/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family". */

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film. */

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. */

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado. */

/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores. */

/* 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film. */

/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. */