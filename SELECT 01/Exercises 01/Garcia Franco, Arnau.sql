-- 1.Mostra totes les columnes de totes les pel·lícules
select * from film;
-- 2.Mostra id, títol i descripció de les pel·lícules amb rating PG-13
select film_id, title, description  from film
where rating = 'PG-13' ;
-- 3.Mostra totes les pel·lícules amb any de llançament (release_year) posterior a 2005
SELECT * FROM film
WHERE release_year > '2005' ;
-- 4. Mostra nom i lllinatges de tots els actors
SELECT last_name, first_name FROM actor;
-- 5 Selecciona totes les pel·lícules amb una durada (length) inferior a 90 minuts.
select * from film
where length < 90 ;
-- 6. Mostra el títol i any de llançament de totes les pel·lícules ordenades ascendentment.
select release_year, title from film
order by title asc, release_year asc;
-- 7. Mostra el títol i la durada de les pel·lícules que tenguin una durada entre 50 i 100 minuts.
select title, length from film 
where length  between 50 and 100;

-- 8. Mostra el títol i preu de les pel·lícules amb un preu de lloguer (rental_rate) major a 4.00$
SELECT title, rental_rate FROM film
where rental_rate > 4.00;

-- 9 Selecciona tots els actors amb un cognom que comença amb 'S'.
SELECT * FROM actor
where last_name like 'S%';

-- 10. Recupera els títols de totes les pel·lícules amb una classificació igual a 'PG'.
SELECT title, rating FROM film 
where rating = 'PG';

-- 11.Mostra el nom de totes les categories ordenades alfabèticament.
SELECT name FROM category
order by name ;

-- 12.Recupera tots els clients que tenen una adreça de correu electrònic amb 'gmail.com'.
SELECT * FROM customer
where email like 'gmail.com' ;

-- 13.Mostra el títol i la durada de totes les pel·lícules amb una durada superior a 2 hores.
SELECT title, length FROM film
where length > 120;

-- 14.Obté el títol i l'any de llançament de les pel·lícules llançades entre 2005 i 2010.
SELECT title, release_year FROM film 
where release_year between 2005 and 2010;

-- 15.Mostra el nom i el preu de lloguer de totes les pel·lícules amb un preu de lloguer superior a 2$.
SELECT title, rental_rate from FILM
WHERE rental_rate > 2;

-- 16.Obté el títol, la durada i la classificació de les pel·lícules amb una durada superior a 2 hores i classificació 'R'.
SELECT title, length, rating FROM film
where length > 120 AND rating like 'R';
-- 17.Mostra els títols de les pel·lícules amb el terme 'action' o 'comedy' en la descripció.
SELECT title, description from film
WHERE description like '%action%' or '%comedy%';

-- 18.Recupera els actors que tenen una 'a' en el seu nom i una 'e' en el seu cognom.
SELECT first_name, last_name FROM actor
WHERE first_name like '%a%' and last_name like '%e%';

-- 19 Mostra els títols de les pel·lícules llançades després del 2000 amb una classificació 'PG' o 'G'.
SELECT * from film
where release_year > 2000 and rating like 'PG' OR 'G'
