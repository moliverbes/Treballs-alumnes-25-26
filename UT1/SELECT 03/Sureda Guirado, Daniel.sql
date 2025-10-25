-- 1 Mostra els clients, el nombre total de pagaments que han fet i la quantitat total pagada, 
-- però només d’aquells que hagin fet més de 12 pagaments i hagin pagat en total més de 50 dòlars.
select customer_id, count(payment_id), sum(amount)
from payment
group by customer_id
having count(payment_id) > 12 and sum(amount) > 50;

-- 2 Mostra, per a cada classificació (rating), les pel·lícules amb la seva durada màxima i mínima registrada, però 
-- només en aquells casos en què la durada màxima superi els 150 minuts i la mínima sigui inferior als 90.

select min(length) as 'Mínima' ,rating as 'Rating', max(length) as 'Màxima'
from film
group by rating
having max(length) > 150 and min(length) < 90;

-- 3 Mostra els empleats, el nombre total de pagaments processats i la quantitat màxima cobrada en un sol pagament, però 
-- només d’aquells empleats que hagin processat més de 50 pagaments i amb un pagament màxim superior a 8 dòlars.

select staff_id, count(payment_id), max(amount)
from payment
group by staff_id
having count(payment_id) > 50 and max(amount) > 8;

-- 4 Per a cada classificació (rating), calcula el promig del replacement_cost i el nombre total de pel·lícules d’aquest rating. 
-- Mostra les pel·lícules dels ratings amb més de 100 pel·lícules i un cost mitjà de reemplaçament > 18 dòlars.

select rating, avg(replacement_cost) as 'cost substitució', count(film_id) as 'total pel·licules'
from film
group by rating
having avg(replacement_cost) > 18 and count(film_id) > 100;

-- 5 Mostra els clients (customer_id), el pagament mínim i el pagament màxim que han realitzat, però
--  només dels que tinguin almenys 5 pagaments i una diferència (màx − mín) > 5 $.

select customer_id, min(amount), max(amount), count(payment_id)
from payment 
group by customer_id
having count(payment_id) >= 5 and max(amount) - min(amount) > 5;

-- 6 Mostra els clients (customer_id), el nombre de lloguers i la data de lloguer més recent, però 
-- només dels que tinguin més de 8 lloguers i una data màxima de lloguer anterior a 2006-01-01.

select customer_id, count(rental_id), max(rental_date)
from rental
group by customer_id
having count(rental_id) > 8 and  max(rental_date) < '2006-01-01';

-- 7 Mostra les pel·lícules, el nombre de vegades que apareixen a la taula inventory i el cost total de reemplaçament estimat, considerant que 
-- cada còpia té un cost constant de 20 $, però només d’aquelles pel·lícules amb més de 4 còpies i un cost total superior a 100 $

select film_id, count(film_id)as 'Total_cintes', 20*count(film_id) as 'Cost_reemplaçament'
from inventory
group by film_id
 having total_cintes > 4
 and cost_reemplaçament > 100;

-- 8. Mostra els clients, el nombre de vegades que han llogat pel·lícules i la data més recent de lloguer, però 
-- només dels que tinguin més de 8 lloguers i una data de lloguer màxima anterior a l’any 2006.

select customer_id, count(rental_id) as 'Total_lloguers', max(rental_date) as 'Data_Recent'
from rental 
group by customer_id
having total_lloguers > 8
and data_recent  < '2006-01-01';


-- 9 Per a cada rating, calcula el preu de lloguer mitjà (rental_rate) i el nombre de pel·lícules del grup. 
-- Mostra les pel·lícules pertanyents a ratings amb més de 10 pel·lícules i un preu mitjà < 3 $

select rating, avg(rental_rate) as 'Preu_Mitjà', count(film_id) as 'Total_Pelis'
from film
group by rating
having Total_Pelis > 10
and Preu_Mitjà < 3;


-- 10 Mostra els clients (client_id), el nombre total de pagaments i l’import mitjà pagat, però 
-- només aquells clients amb més de 10 pagaments i amb un import mitjà inferior a 3 dòlars.


select customer_id as 'Client_id', count(rental_id), avg(amount) as ' total'
from payment 
group by customer_id
having client_id > 10 
and total < 3; 

