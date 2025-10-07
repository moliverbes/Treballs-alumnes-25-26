-- 1- Mostra totes les columnes de totes les pel·lícules
SELECT *
FROM film;

-- 2- Mostra id, títol i descripció de les pel·lícules amb rating PG-13
SELECT film_id, title, description, rating
FROM film
WHERE rating LIKE "PG-13";

-- 3- Mostra totes les pel·lícules amb any de llançament (release_year) posterior a 2005
SELECT *
FROM film
WHERE release_year > 2005;

-- 4- Mostra nom i lllinatges de tots els actors
SELECT first_name, last_name
FROM actor;

-- 5- Selecciona totes les pel·lícules amb una durada (length) inferior a 90 minuts.
SELECT *
FROM film
WHERE length < 90;

-- 6- Mostra el títol i any de llançament de totes les pel·lícules ordenades ascendentment.
SELECT title, release_year
FROM film
ORDER BY title ASC;

-- 7- Mostra el títol i la durada de les pel·lícules que tenguin una durada entre 50 i 100 minuts.
SELECT title, length
FROM film
WHERE length BETWEEN 50 AND 100;

-- 8- Mostra el títol i preu de les pel·lícules amb un preu de lloguer (rental_rate) major a 4.00$
SELECT title, rental_rate
FROM film
WHERE rental_rate > 4.00;

-- 9- Selecciona tots els actors amb un cognom que comença amb 'S'.
SELECT *
FROM actor
WHERE last_name LIKE "S%";

-- 10- Recupera els títols de totes les pel·lícules amb una classificació igual a 'PG'.
SELECT title, rating
FROM film
WHERE rating LIKE "PG";

-- 11- Mostra el nom de totes les categories ordenades alfabèticament.
SELECT name
FROM category
ORDER BY name ASC;

-- 12- Recupera tots els clients que tenen una adreça de correu electrònic amb 'gmail.com'.
SELECT *
FROM customer
WHERE email LIKE "%gmail.com";

-- 13- Mostra el títol i la durada de totes les pel·lícules amb una durada superior a 2 hores.
SELECT title, length
FROM film
WHERE length > 120;

-- 14- Obté el títol i l'any de llançament de les pel·lícules llançades entre 2005 i 2010.
SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- 15- Mostra el nom i el preu de lloguer de totes les pel·lícules amb un preu de lloguer superior a 2$.
SELECT title, rental_rate
FROM film
WHERE rental_rate > 2;

-- 16- Obté el títol, la durada i la classificació de les pel·lícules amb una durada superior a 2 hores i classificació 'R'.
SELECT title, length, rating
FROM film
WHERE length > 120 AND rating LIKE "R";

-- 17- Mostra els títols de les pel·lícules amb el terme 'action' o 'comedy' en la descripció.
SELECT title, description
FROM film
WHERE description LIKE "%action%" OR description LIKE "%comedy%";

-- 18- Recupera els actors que tenen una 'a' en el seu nom i una 'e' en el seu cognom.
SELECT *
FROM actor
WHERE first_name LIKE "%a%" AND last_name LIKE "%e%";

-- 19- Mostra els títols de les pel·lícules llançades després del 2000 amb una classificació 'PG' o 'G'.
SELECT title, release_year, rating
FROM film
WHERE release_year > 2000 AND rating LIKE "PG" OR rating LIKE "G";