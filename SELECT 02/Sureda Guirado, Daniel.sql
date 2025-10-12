-- 1 Mostra el nom i cognom dels actors de la taula actor.
select first_name, last_name 
from actor ;

-- 2 Mostra el nom complet dels actors en una sola columna amb l’àlies actor_complet.
select concat_ws (' ',first_name, last_name) as 'actor_complet'
from actor;

-- 3 Mostra totes les pel·lícules (film) que tenen una durada (length) superior a 120 minuts.

select * from film
where length > 120;

-- 4 Mostra les pel·lícules que tenen una classificació (rating) diferent de PG-13.

select *  from film
 where rating not like 'pg-13';
 
 -- 5 Mostra tots els clients (customer) el cognom dels quals comença per “S”.
select * from customer
where last_name like 's%';

-- 6 Mostra els actors el nom complet dels quals conté la lletra “LL”.
select  concat_ws(' ' ,first_name, last_name)
from actor
where first_name like '%ll%';

-- 7 Mostra les pel·lícules que tenen una durada (length) entre 90 i 120 minuts.

select  * from film
where length between 90 and 120;

-- 8 Mostra les pel·lícules que tenen la classificació (rating) dins del conjunt ('PG', 'R', 'NC-17').

select * from film 
where rating in ('pg','r','nc-17');

-- 9 Mostra les pel·lícules on el camp special_features sigui NULL.

select * from film
where special_features is null;

-- 10 Mostra el nom complet de tots els actors ordenats pel cognom en ordre ascendent.

select concat_ws(' ',first_name, last_name)
from actor
order by last_name asc;

-- 11 Mostra totes les pel·lícules ordenades per any de llançament (release_year) en ordre descendent.

select * from film
order by release_year desc;
-- 12 Mostra les pel·lícules amb durada major de 100 minuts i classificació pg
select * from film 
where length > 100 
and rating like 'pg'
order by release_year desc;

-- 13 Mostra les pel·lícules amb durada menor de 90 minuts o classificació “R”.

select * from film
where length < 90
or rating like  'r';

-- 14 Mostra totes les pel·lícules que no tenen classificació “G”.

select * from film 
where rating not like 'g';

-- 15 Mostra el títol de les pel·lícules en majúscules.

select upper(title)
from film ;

-- 16  Mostra el títol en minúscules de les pel·lícules amb classificació “PG-13”.

select lower(title)
from film
where rating like 'pg-13';

-- 17 Mostra una columna amb la longitud (LENGTH) del títol de cada pel·lícula.

select length(title)
 from film;
 
 -- 18 Mostra els 3 primers caràcters del títol de cada pel·lícula.
 
 select substring(title, 1,3)
 from film ;
 
 -- 19 Mostra els noms i cognoms dels actors concatenats amb un espai al mig.
select concat_ws(' ', first_name, last_name)
from actor;
