-- 1. Mostra el nom i cognom dels actors de la taula actor.
SELECT first_name, last_name
FROM actor;

-- 2. Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.
SELECT CONCAT_WS(" ", first_name, last_name) AS actor_complet FROM actor;

-- 3. Mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.
SELECT *
FROM film
WHERE length > 120;

-- 4. Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.
SELECT *
FROM film
WHERE rating NOT LIKE "PG-13";

-- 5. Mostra tots els clients (customer) el cognom dels quals comença per “S”.
SELECT *
FROM customer
WHERE last_name LIKE "S%";

-- 6. Mostra el nom complet dels actors el nom dels quals conté la lletra “LL”.
SELECT CONCAT_WS(" ", first_name, last_name) AS nom_complet
FROM actor
WHERE first_name LIKE "%LL%";

-- 7. Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.
SELECT *
FROM film
WHERE length BETWEEN 90 AND 120;

-- 8. Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').
SELECT *
FROM film
WHERE rating IN ('PG', 'R', 'NC-17');

-- 9. Mostra les pel·lícules on el camp special_features sigui NULL.
SELECT *
FROM film
WHERE special_features IS NULL;

-- 10. Mostra el nom complet de tots els actors ordenats pel cognom en ordre ascendent.
SELECT CONCAT_WS(" ", first_name, last_name) AS nom_complet
FROM actor
ORDER BY last_name ASC;

-- 11. Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.
SELECT *
FROM film
ORDER BY release_year DESC;

-- 12. Mostra les pel·lícules amb durada major de 100 minuts i classificació “PG”.
SELECT *
FROM film
WHERE length > 100 AND rating LIKE "PG";

-- 13. Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.
SELECT *
FROM film
WHERE length < 90 AND rating LIKE "R";

-- 14. Mostra totes les pel·lícules que no tenen classificació “G”.
SELECT *
FROM film
WHERE rating NOT LIKE "G";

-- 15. Mostra el títol de les pel·lícules en majúscules.
SELECT UPPER(title)
FROM film;

-- 16. Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.
SELECT LOWER(title)
FROM film
WHERE rating LIKE "PG-13";

-- 17. Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.
SELECT length(title)
FROM film;

-- 18. Mostra els 3 primers caràcters del títol de cada pel·lícula.
SELECT SUBSTRING(title,1,3)
FROM film;

-- 19. Mostra els noms i cognoms dels actors concatenats amb un espai al mig.
SELECT CONCAT_WS(" ", first_name, last_name)
FROM actor;