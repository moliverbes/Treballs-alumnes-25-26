-------------------------------------------------------------------------------------------------------
-- 1Mostra totes les columnes de totes les pel·lícules
select * from film;
-------------------------------------------------------------------------------------------------------
-- 2Mostra id, títol i descripció de les pel·lícules amb rating PG-13
select film_id, title, description  from film
where rating like "PG-13";
-------------------------------------------------------------------------------------------------------
-- 3Mostra totes les pel·lícules amb any de llançament (release_year) 
select * from film
where release_year  > 2005;
-------------------------------------------------------------------------------------------------------
-- 4Mostra nom i llinatges de tots els actors
select first_name, last_name from actor;
-------------------------------------------------------------------------------------------------------
-- 5Selecciona totes les pel·lícules amb una durada (length) inferior a 90 minuts.
select * from film
where length < 90;
-------------------------------------------------------------------------------------------------------
-- 6Mostra el títol i any de llançament de totes les pel·lícules ordenades ascendentment.
select title, release_year from film;
-------------------------------------------------------------------------------------------------------
-- 7.Mostra el títol i la durada de les pel·lícules que tenguin una durada entre 50 i 100 minuts.
select title,length from film
where length between 50 and 100;
-------------------------------------------------------------------------------------------------------
-- 8Mostra el títol i preu de les pel·lícules amb un preu de lloguer (rental_rate) major a 4.00$
select title, rental_rate from film
where rental_rate >4.00;
-------------------------------------------------------------------------------------------------------
-- 9Selecciona tots els actors amb un cognom que comença amb 'S'.
select last_name, first_name from actor
where last_name like "S%";
-------------------------------------------------------------------------------------------------------
-- 10Recupera els títols de totes les pel·lícules amb una classificació igual a 'PG'.
select title, rating from film
where rating like "PG";
-------------------------------------------------------------------------------------------------------
-- 11Mostra el nom de totes les categories ordenades alfabèticament.
select special_features from film
order by special_features ASC;
-------------------------------------------------------------------------------------------------------
-- 12Recupera tots els clients que tenen una adreça de correu electrònic amb 'gmail.com'.
select* from customer
where email like "%gmail.com";
-------------------------------------------------------------------------------------------------------
-- 13Mostra el títol i la durada de totes les pel·lícules amb una durada superior a 2 hores.
select title,length from film
where length >140;
-------------------------------------------------------------------------------------------------------
-- 14Obté el títol i l'any de llançament de les pel·lícules llançades entre 2005 i 2010.
select title, release_year from film
where release_year between 2005 and 2010;
-------------------------------------------------------------------------------------------------------
-- 15Mostra el nom i el preu de lloguer de totes les pel·lícules amb un preu de lloguer superior a 2$.
select title, rental_rate from film
where rental_rate >2.00;
-------------------------------------------------------------------------------------------------------
-- 16Obté el títol, la durada i la classificació de les pel·lícules amb una durada superior a 2 hores i classificació 'R'.
select title,length, rating from film
where length >140;
-------------------------------------------------------------------------------------------------------
-- 17Mostra els títols de les pel·lícules amb el terme 'action' o 'comedy' en la descripció.
select title, description from film
where description like "%action%" or description like "%comedy%";
-------------------------------------------------------------------------------------------------------
-- Recupera els actors que tenen una 'a' en el seu nom i una 'e' en el seu cognom.
select first_name,last_name from actor
where first_name like"%a%" and last_name like "%e%";
-------------------------------------------------------------------------------------------------------
-- 19Mostra els títols de les pel·lícules llançades després del 2000 amb una classificació 'PG' o 'G'.
select title, rating, release_year from film
where rating like "PG" or rating like"G" and release_year > 2000;
-------------------------------------------------------------------------------------------------------