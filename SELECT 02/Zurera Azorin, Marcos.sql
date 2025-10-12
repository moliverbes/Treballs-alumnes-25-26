-- 1 Mostra el nom i cognom dels actors de la taula actor.

SELECT first_name, last_name FROM actor;

-- 2 Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.

SELECT concat_ws(' ',first_name, last_name) as 'actor_complet' FROM actor;

-- 3 mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.

Select title, length FROM film
Where length > 120;

-- 4 Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.

SELECT TITLE, RATING from FILM	
where RATING NOT LIKE 'PG-13';

-- 5 Mostra tots els clients (customer) el cognom dels quals comença per “S”.

SELECT * FROM customer
WHERE last_name like 's%';

-- 6 Mostra els actors el nom dels quals conté la lletra “LL”.

SELECT first_name, last_name FROM customer
WHERE first_name like '%ll%';

-- 7 Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.

SELECT title, length FROM film
WHERE length between 90 and 120;

-- 8 Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').

SELECT title, rating FROM film
Where rating in ('PG', 'R', 'NC-17');

-- 9 Mostra les pel·lícules on el camp special_features sigui NULL.

Select * FROM film
WHERE special_features is null;

-- 10 Mostra tots els actors ordenats pel cognom en ordre ascendent.

SELECT last_name, first_name FROM actor
order by last_name asc;

-- 11 Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.

SELECT title, release_year FROM film
order by release_year desc;

-- 12 Mostra les pel·lícules amb durada major de 100 minuts i classificació “PG”.

SELECT title, length, rating FROM film
Where length > 100 and rating = 'PG';

-- 13 Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.

SELECT title, length, rating FROM film
Where length < 90 and rating = 'R';

-- 14 Mostra totes les pel·lícules que no tenen classificació “G”.

SELECT title, rating From film
Where rating != 'G';

-- 15 Mostra el títol de les pel·lícules en majúscules.

SELECT Upper(title) as Titulo FROM film;

-- 16 Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.

Select Lower(title) as Titulo, rating FRom film
Where rating = 'PG-13';

-- 17 Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.

Select Concat_ws(' ', title, length) as Titulo_y_duracion from film;

-- 18 Mostra els 3 primers caràcters del títol de cada pel·lícula.

Select substring(title,1,3) as Titulo from film;

-- 19 Mostra els noms i cognoms dels actors concatenats amb un espai al mig.

SELECT concat_ws(' ',first_name, last_name) as Nombre_completo FROM actor;
