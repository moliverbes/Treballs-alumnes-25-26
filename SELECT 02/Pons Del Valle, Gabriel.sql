-- 1. Mostra el nom i cognom dels actors de la taula actor.
SELECT first_name, last_name FROM actor;

-- 2. Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.
SELECT concat(first_name, " ", last_name) AS actor_complet FROM actor;

-- 3.Mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.
SELECT title, length FROM film
WHERE length > 120;

-- 4. Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.
SELECT title, rating FROM Film
WHERE rating NOT LIKE 'PG-13';

-- 5. Mostra tots els clients (customer) el cognom dels quals comença per “S”.
SELECT last_name FROM customer
WHERE last_name LIKE 'S%';

-- 6. Mostra els actors el nom dels quals conté la lletra “LL”.
SELECT first_name FROM actor
WHERE first_name LIKE '%LL%';

-- 7. Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.
SELECT title, length FROM film 
WHERE length BETWEEN 90 AND 120;

-- 8. Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').
SELECT title, rating FROM film
WHERE rating IN ('PG', 'R', 'NC-17');

-- 9.  Mostra les pel·lícules on el camp special_features sigui NULL.
SELECT title, special_features FROM film
WHERE special_features IS NULL;

-- 10. Mostra tots els actors ordenats pel cognom en ordre ascendent.
SELECT first_name, last_name FROM actor
ORDER BY last_name ASC;

-- 11. Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.
SELECT title, release_year FROM film
order by release_year DESC;

-- 12. Mostra les pel·lícules amb durada major de 100 minuts i classificació “PG”.
SELECT title, length, rating FROM film
WHERE length > 100 AND rating LIKE 'PG';

-- 13. Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.
SELECT title, length, rating FROM film
WHERE length < 90 AND rating LIKE 'R';

-- 14. Mostra totes les pel·lícules que no tenen classificació “G”.
SELECT title, rating FROM film
WHERE rating NOT LIKE 'G';

-- 15. Funcions de manipulació de cadenes

-- 16. Mostra el títol de les pel·lícules en majúscules.
SELECT UPPER(title) FROM film;

-- 17. Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.
SELECT LOWER(title), rating FROM film
WHERE rating LIKE 'PG-13';

-- 18. Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.
SELECT title, length AS 'longitud' FROM film;

-- 19. Mostra els 3 primers caràcters del títol de cada pel·lícula.
SELECT substring(title, 1, 3) FROM film;

-- 20. Mostra els noms i cognoms dels actors concatenats amb un espai al mig.
SELECT concat(first_name, " ", last_name) AS nom_complet FROM actor








 