-- 1 Mostra totes les columnes de totes les pel·lícules
SELECT * FROM film;

-- 2 Mostra id, títol i descripció de les pel·lícules amb rating PG-13
Select film_id, title, description, rating From film
where rating like 'PG-13';  

-- 3 Mostra totes les pel·lícules amb any de llançament (release_year) posterior a 2005
Select * From film
Where release_year > 2005;

-- 4 Mostra nom i lllinatges de tots els actors
SELECT first_name, last_name FROM actor;

-- 5 Selecciona totes les pel·lícules amb una durada (length) inferior a 90 minuts.
SELECT * FROM film
Where length < 90
order by length;

-- 6 Mostra el títol i any de llançament de totes les pel·lícules ordenades ascendentment.
SELECT title, release_year FROM film
order by title, release_year;

-- 7 Mostra el títol i la durada de les pel·lícules que tenguin una durada entre 50 i 100 minuts.
Select title, length from film
Where length between 50 and 100;

-- 8 Mostra el títol i preu de les pel·lícules amb un preu de lloguer (rental_rate) major a 4.00$
SELECT title, rental_rate from film
Where rental_rate > 4;

-- 9 Selecciona tots els actors amb un cognom que comença amb 'S'.
Select * From actor
Where last_name like 'S%'; 

-- 10 Recupera els títols de totes les pel·lícules amb una classificació igual a 'PG'.
SELECT * From film
Where rating like 'PG';

-- 11 Mostra el nom de totes les categories ordenades alfabèticament.
SELECT * FROM film
order by title asc; 

-- 12 Recupera tots els clients que tenen una adreça de correu electrònic amb 'gmail.com'
SELECT * FROM customer
Where address_id like 'gmail.com';

-- 13 Mostra el títol i la durada de totes les pel·lícules amb una durada superior a 2 hores.
SELECT title, length FROM film
WHERE length > 120;

-- 14 Obté el títol i l'any de llançament de les pel·lícules llançades entre 2005 i 2010.
SELECT title, release_year from film
Where release_year between 2005 and 2010; 

-- 15 Mostra el nom i el preu de lloguer de totes les pel·lícules amb un preu de lloguer superior a 2$.
Select title, rental_rate FROM film
Where rental_rate > 2;
-- 16 Obté el títol, la durada i la classificació de les pel·lícules amb una durada superior a 2 hores i classificació 'R'.
Select title, length, rating FROM film
Where length > 120 and rating = 'R';
-- 17 Mostra els títols de les pel·lícules amb el terme 'action' o 'comedy' en la descripció.
Select title FROM film
Where title like '% action %' or title like '% comedy %';
-- 18 Recupera els actors que tenen una 'a' en el seu nom i una 'e' en el seu cognom.
Select actor_id, first_name, last_name From actor
where first_name like '%a%' and last_name like '%e%';
-- 19 Mostra els títols de les pel·lícules llançades després del 2000 amb una classificació 'PG' o 'G'.
Select title, release_year, rating FROM film
Where release_year > 2000 and rating = 'PG' or Rating = 'G';

