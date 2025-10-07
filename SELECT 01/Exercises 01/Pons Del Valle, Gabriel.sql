-- 1. Mostra totes les columnes de totes les pel·lícules
SELECT * FROM Film;

-- 2. Mostra id, títol i descripció de les pel·lícules amb rating PG-13
Select title, description from film
Where rating LIKE 'PG-13';

-- 3.Mostra totes les pel·lícules amb any de llançament (release_year) posterior a 2005
SELECT * FROM film
WHERE release_year > 2005;

-- 4. Mostra nom i llinatges de tots els actors
SELECT first_name, last_name
FROM actor;

-- 5. Selecciona totes les pel·lícules amb una durada (length) inferior a 90 minuts.
SELECT * from film
WHERE length < 80;

-- 6. Mostra el títol i any de llançament de totes les pel·lícules ordenades ascendentment.
SELECT title, release_year 
FROM Film
order by title, release_year desc;	

-- 7.Mostra el títol i la durada de les pel·lícules que tenguin una durada entre 50 i 100 minuts.
SELECT title, length from film
where length between 50 and 100;

-- 8.Mostra el títol i preu de les pel·lícules amb un preu de lloguer (rental_rate) major a 4.00$
SELECT title, rental_rate from film
WHERE rental_rate > '4';

-- 9. Selecciona tots els actors amb un cognom que comença amb 'S'.
SELECT last_name from actor
WHERE last_name like 'S%';

-- 10. Recupera els títols de totes les pel·lícules amb una classificació igual a 'PG'.
SELECT title, rating from film
Where rating like 'PG';

-- 11.Mostra el nom de totes les categories ordenades alfabèticament.
SELECT name from category
order by name ASC;

-- 12.Recupera tots els clients que tenen una adreça de correu electrònic amb 'gmail.com'.

SELECT first_name, email from customer
where email like '%gmail.com';

-- 13. Mostra el títol i la durada de totes les pel·lícules amb una durada superior a 2 hores.
SELECT title, length from film
WHERE length > 120;

-- 14.Obté el títol i l'any de llançament de les pel·lícules llançades entre 2005 i 2010.
SELECT title, release_year from film
WHERE Release_year between 2005 and 2010;

-- 15. Mostra el nom i el preu de lloguer de totes les pel·lícules amb un preu de lloguer superior a 2$
SELECT title, rental_rate FROM film
WHERE rental_rate > 2;

-- 16. 	Obté el títol, la durada i la classificació de les pel·lícules amb una durada superior a 2 hores i classificació 'R'.
SELECT title, length, rating from film 
WHERE RATING LIKE 'R';

-- 17. Mostra els títols de les pel·lícules amb el terme 'action' o 'comedy' en la descripció.
SELECT title, description FROM film
Where description BETWEEN 'comedy' and 'action';

-- 18. Recupera els actors que tenen una 'a' en el seu nom i una 'e' en el seu cognom.	
SELECT first_name, last_name FROM Actor
WHERE first_name like '%a%' and last_name like '%e';

-- 19. Mostra els títols de les pel·lícules llançades després del 2000 amb una classificació 'PG' o 'G'	
SELECT title, release_year, rating from film
WHERE release_year > 2000 and rating like 'PG' or 'G';







