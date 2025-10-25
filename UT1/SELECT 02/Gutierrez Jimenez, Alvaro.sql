# 1.Muestra el nombre y apellido de los actores de la mesa actor.
select first_name, last_name
from actor;

# 2.Muestra el nombre completo de los actores en una sola columna con el alias actor_completo.
select concat(first_name,' ', last_name) as 'actor_completo'
from actor;

# 3.Muestra todas las películas (film) que tienen una duración (length) superior a 120 minutos.
select title, length
from film
where length > 120;

# 4.Muestra las películas que tienen una clasificación (rating) distinta de PG-13.
select title, rating
from film
where rating != 'PG-13';

# 5.Muestra todos los clientes (customer) cuyo apellido comienza por “S”.
select first_name, last_name
from customer
where last_name like 'S%';

# 6.Muestra el nombre completo de los actores cuyo nombre contiene la letra “LL”.
select concat(first_name,' ', last_name) as 'actor_completo'
from actor
where first_name like '%LL%';

# 7.Muestra las películas que tienen una duración (length) entre 90 y 120 minutos.
select title, length
from film
where length between 90 and 120;

# 8.Muestra las películas que tienen la clasificación (rating) dentro del conjunto ('PG', 'R', 'NC-17').
select title, rating
from film
where rating = 'PG' or rating = 'R' or rating = 'NC-17';

# 9.Muestra las películas donde el campo special_features sea NULL.
select title
from film
where special_features is null;

# 10.Muestra el nombre completo de todos los actores ordenados por el apellido en orden ascendente.
select concat(first_name,' ', last_name) as 'actor_completo'
from actor
order by last_name asc;

# 11.Muestra todas las películas ordenadas por año de lanzamiento (release_year) en orden descendente.
select title, release_year
from film
order by release_year desc;

# 12.Muestra las películas con duración mayor de 100 minutos y clasificación “PG”.
select title, length, rating
from film
where length > 100
and rating = 'PG';

# 13.Muestra las películas con duración menor de 90 minutos o clasificación “R”.
select title, length, rating
from film
where length < 90
or rating = 'R';

# 14.Muestra todas las películas que no tienen clasificación “G”.
select title, rating
from film
where rating != 'G';

# 15.Muestra el título de las películas en mayúsculas.
select upper(title)
from film;

# 16.Muestra el título en minúsculas de las películas con clasificación "PG-13".
select lower(title), rating
from film
where rating = 'PG-13';

# 17.Muestra una columna con la longitud (LENGTH) del título de cada película.
select concat(title,' ', length)
from film;

# 18.Muestra los 3 primeros caracteres del título de cada película.
select title, substring(title,1,3)
from film;

# 19.Muestra los nombres y apellidos de los actores concatenados con un espacio en medio.
select concat(first_name,' ', last_name) as 'actor_completo'
from actor;