# 1. Muestra todas las columnas de todas las películas.
select * from film;

# 2. Muestra id, título y descripción de las películas con rating PG-13.
select film_id, title, description, rating from film
where rating = 'PG-13';

# 3. Muestra todas las películas con año de lanzamiento (release_year) posterior a 2005.
select * from film
where release_year > 2005;

# 4. Muestra nombre y apellidos de todos los actores.
select first_name, last_name
from actor;

# 5. Selecciona todas las películas con una duración inferior a 90 minutos.
select * from film
where length < 90;

# 6. Muestra el título y año de lanzamiento de todas las películas ordenadas ascendentemente.
select title, release_year
from film
order by release_year asc;

# 7. Muestra el título y la duración de las películas que tengan una duración de entre 50 y 100 minutos.
select title, length
from film
where length between 50 and 100;

# 8. Muestra el título y precio de las películas con un precio de alquiler (rental_rate) mayor a 4.00$.
select title, rental_rate
from film
where rental_rate > (4.00);

# 9. Selecciona todos los actores cuyo apellido comienza con 'S'.
select first_name, last_name
from actor
where last_name like 'S%';

# 10. Recupera los títulos de todas las películas con una clasificación igual a 'PG'.
select title
from film
where rating = 'PG';

# 11. Muestra el nombre de todas las categorías ordenadas alfabéticamente.
select name 
from category
order by name asc;

# 12. Recupera a todos los clientes que tienen una dirección de correo electrónico con 'gmail.com'.
select first_name, last_name 
from customer
where email like '%gmail.com'; # como nadie tiene su email terminado en gmail.com (debido a que todos terminan con 'sakilacustomer.org') no aparece ningún cliente.

# 13. Muestra el título y la duración de todas las películas con una duración superior a 2 horas.
select title, length
from film
where length > 120;

# 14. Obtiene el título y el año de lanzamiento de las películas lanzadas entre 2005 y 2010.
select title, release_year 
from film
where release_year between (2005) and (2010);

# 15. Muestra el nombre y el precio de alquiler de todas las películas con un precio de alquiler superior a 2$.
select title, rental_rate
from film
where rental_rate > (2.00);

# 16. Obtiene el título, duración y clasificación de las películas con una duración superior a 2 horas y clasificación 'R'.
select title, length, rating
from film
where length > 120 and rating like 'R';

# 17. Muestra los títulos de las películas con el término 'action' o 'comedy' en la descripción.
select title
from film
where description like '%action%' or description like '%comedy%';

# 18. Recupera a los actores que tienen una 'a' en su nombre y una 'e' en su apellido.
select first_name, last_name
from actor
where first_name like '%A%' and last_name like '%E%';

# 19. Muestra los títulos de las películas lanzadas después de 2000 con una clasificación 'PG' o 'G'.
select title, release_year, rating
from film
where release_year > 2000 and (rating = 'PG' or rating = 'G');