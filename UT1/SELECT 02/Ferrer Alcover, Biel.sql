-- 1Mostra el nom i cognom dels actors de la taula actor
select first_name, last_name from actor;
-- 2Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.
select  concat_ws(' ',first_name,last_name) as "actor_complet" from actor;
-- Mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.
select * from film
where length >120;
-- Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.
select * from film
where rating not like "PG-13";
-- Mostra tots els clients (customer) el cognom dels quals comença per “S”.
select * from customer
where last_name like "s%";
-- Mostra el nom complet dels actors el nom dels quals conté la lletra “LL”.
select * from actor
where first_name like "ll%" and last_name like "ll";
-- Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.
select * from film
where length between 90 and 120;
-- Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').
select * from film
where rating in  ("PG","R","NC-17");
-- Mostra les pel·lícules on el camp special_features sigui NULL.
select * from film
where special_features is NULL;
-- Mostra el nom complet de tots els actors ordenats pel cognom en ordre ascendent.
select * from actor
order by first_name and last_name ASC;
-- Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.
select * from film
order by title ASC;
-- Mostra les pel·lícules amb durada major de 100 minuts i classificació “PG”.
select * from film
where length >100 and rating like "PG";
-- Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.
select * from film
where length <90 or rating like "R";
-- Mostra totes les pel·lícules que no tenen classificació “G”.
select * from film
where rating not like "G";
-- Mostra el títol de les pel·lícules en majúscules.
select upper(Title) from film;
-- Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.
select lower(Title) from film
where rating like "PG-13";
-- Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.
select length(Title) from film;
-- Mostra els 3 primers caràcters del títol de cada pel·lícula.
select substring(Title,3) from film;
-- Mostra els noms i cognoms dels actors concatenats amb un espai al mig.
select  concat_ws(' ',first_name,last_name) from actor;



