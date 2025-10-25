-- 1.Mostra el nom i cognom dels actors de la taula actor.
select last_name, first_name FROM actor;
-- 2. Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.
SELECT CONCAT(last_name,' ' , first_name) AS 'nom_complet' FROM actor;
-- 3.mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.
SELECT * FROM film
where length < 120;
-- 4.Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.
select * FROM film
where rating != 'PG-13';
-- 5.Mostra tots els clients (customer) el cognom dels quals comença per “S”.
SELECT * FROM customer
where last_name like 'S%';
-- 6 Mostra els actors el nom dels quals conté la lletra “LL”.
SELECT * FROM actor
where first_name like '%LL%';
-- 7.Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.
select * from film
where length between 90 and 120;
-- 8.Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').
SELECT * FROM FILM 
WHERE rating IN ('PG', 'R', 'NC-17');
-- 9.Mostra les pel·lícules on el camp special_features sigui NULL.
SELECT * FROM film
WHERE special_features IS NULL;
-- 10.Mostra tots els actors ordenats pel cognom en ordre ascendent.
select * FROM actor
order by las_name asc;
-- 11. Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.
SELECT * FROM film
order by release_year desc;
-- 12 Mostra les pel·lícules amb durada major de 100 minuts i classificació “PG”.
SELECT * FROM film
where length > 100 AND rating like 'PG';
-- 13.Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.
SELECT *FROM film
where length > 90 OR rating like 'R';
-- 14. Mostra totes les pel·lícules que no tenen classificació “G”.
SELECT *FROM film
WHERE rating NOT LIKE 'G';
-- MANIPULACIO DE CADENES
-- 15 Mostra el títol de les pel·lícules en majúscules
SELECT UPPER(title) FROM film;
-- 16 Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.
SELECT LOWER(title) FROM film
WHERE rating like 'PG-13';
-- 17 Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.
select  title, length AS 'longuitud' FROM film;
-- 18 Mostra els 3 primers caràcters del títol de cada pel·lícula.
SELECT substring(title, 1, 3) FROM film;
-- Mostra els noms i cognoms dels actors concatenats amb un espai al mig.
SELECT CONCAT(first_name,' ', last_name) AS nom_complet FROM actor;