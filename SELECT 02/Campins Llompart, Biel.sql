-- Mostra el nom i cognom dels actors de la taula actor.
SELECT first_name,last_name FROM actor;

-- Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.
SELECT CONCAT_WS(' ', first_name, last_name) as 'actor_complet' FROM actor;

-- Mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.
SELECT * FROM film WHERE length >120;

-- Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.
SELECT * FROM film WHERE rating = "PG-13";

-- Mostra tots els clients (customer) el cognom dels quals comença per “S”.
SELECT * FROM customer WHERE last_name LIKE "S_%";

-- Mostra el nom complet dels actors el nom dels quals conté la lletra “LL”.
SELECT CONCAT_WS(' ', first_name, last_name) as 'actor_complet' FROM actor WHERE first_name LIKE "%LL%";

-- Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.
SELECT * FROM film WHERE length BETWEEN 90 AND 120;

-- Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').
SELECT * FROM film WHERE rating = "PG" OR rating = "R" OR rating = "NC-17";

-- Mostra les pel·lícules on el camp special_features sigui NULL.
SELECT * FROM film WHERE special_features IS null;

-- Mostra el nom complet de tots els actors ordenats pel cognom en ordre ascendent.
SELECT CONCAT_WS(' ', first_name, last_name) as 'actor_complet' FROM actor ORDER BY last_name ASC;

-- Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.
SELECT * FROM film ORDER BY release_year DESC;

-- Mostra les pel·lícules amb durada major de 100 minuts i classificació “PG”.
SELECT * FROM film WHERE length >100 AND rating = "PG";

-- Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.
SELECT * FROM film WHERE length <90 or rating = "R";

-- Mostra totes les pel·lícules que no tenen classificació “G”.
SELECT * FROM film WHERE rating != "G";
SELECT * FROM film WHERE rating NOT LIKE "G";

-- Mostra el títol de les pel·lícules en majúscules.
SELECT UPPER(title) AS "title" FROM film;

-- Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.
SELECT LOWER(title) AS "title",rating FROM film WHERE rating = "PG-13";

-- Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.
SELECT title,length(title) FROM film;

-- Mostra els 3 primers caràcters del títol de cada pel·lícula.
SELECT substring(title,1,3) FROM film;

-- Mostra els noms i cognoms dels actors concatenats amb un espai al mig.
SELECT CONCAT_WS(' ', first_name, last_name) as 'actor_complet' FROM actor;