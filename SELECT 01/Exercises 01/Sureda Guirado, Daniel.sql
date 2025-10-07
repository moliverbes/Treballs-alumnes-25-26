-- 1. Mostra totes les columnes de totes les pel·lícules
SELECT * FROM FILM;
-- 2. Mostra id, títol i descripció de les pel·lícules amb rating PG-13
SELECT FILM_ID, TITLE, DESCRIPTION, RATING
FROM film
WHERE RATING = 'PG-13';
-- 3. Mostra totes les pel·lícules amb any de llançament (release_year) posterior a 2005
SELECT * FROM film
WHERE RELEASE_YEAR > 2005;
-- 4. Mostra nom i lllinatges de tots els actors
SELECT FIRST_NAME, LAST_NAME
FROM ACTOR;
-- 5. Selecciona totes les pel·lícules amb una durada (length) inferior a 90 minuts.
SELECT * FROM film
where length < 90;
-- 6. Mostra el títol i any de llançament de totes les pel·lícules ordenades ascendentment.
select title, release_year
from film;
-- 7. Mostra el títol i la durada de les pel·lícules que tenguin una durada entre 50 i 100 minuts.
select title, length
from film
where length between 50 and 100;
-- 8. Mostra el títol i preu de les pel·lícules amb un preu de lloguer (rental_rate) major a 4.00$
select title, rental_rate 
from film
where rental_rate > 4.00;
-- 9. Selecciona tots els actors amb un cognom que comença amb 'S'.
select * from actor 
where last_name like 's%';
-- 10. Recupera els títols de totes les pel·lícules amb una classificació igual a 'PG'.
select title
from film
where rating like 'pg';
-- 11. Mostra el nom de totes les categories ordenades alfabèticament.
select name from category
order by name;
-- 12. Recupera tots els clients que tenen una adreça de correu electrònic amb 'gmail.com'.
select * from customer
where email like '%gmail.com';
-- 13. Mostra el títol i la durada de totes les pel·lícules amb una durada superior a 2 hores.
select title, length
from film
where length > 120;
-- 14. Obté el títol i l'any de llançament de les pel·lícules llançades entre 2005 i 2010.
select title, release_year 
from film
where release_year between 2005 and 2010;
-- 15. Mostra el nom i el preu de lloguer de totes les pel·lícules amb un preu de lloguer superior a 2$.
select  title, rental_rate
from film
where rental_rate > 2;
-- 16. Obté el títol, la durada i la classificació de les pel·lícules amb una durada superior a 2 hores i classificació 'R'.
select title, length, rating
from film
where length > 120 and rating like 'r';
-- 17. Mostra els títols de les pel·lícules amb el terme 'action' o 'comedy' en la descripció.
select title
from film
where description like '%action%' or '%comedy%';
-- 18. Recupera els actors que tenen una 'a' en el seu nom i una 'e' en el seu cognom.
select first_name, last_name 
from actor
where first_name like '%a%' and last_name like '%e%';
-- 19. Mostra els títols de les pel·lícules llançades després del 2000 amb una classificació 'PG' o 'G'.
select title
from film
where release_year > 2000 and rating like 'pg' or 'g';