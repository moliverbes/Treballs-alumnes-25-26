-- 1.Mostra els clients, el nombre total de pagaments que han fet i la quantitat total pagada, però només d’aquells que hagin fet més de 12 pagaments i hagin pagat en total més de 50 dòlars.
SELECT customer_id,count(payment_id),SUM(amount) FROM payment
GROUP BY customer_id
HAVING count(payment_id) > 12 AND sum(amount) > 50;

-- 2.Mostra, per a cada classificació (rating), les pel·lícules amb la seva durada màxima i mínima registrada, però només en aquells casos en què la durada màxima superi els 150 minuts i la mínima sigui inferior als 90.
SELECT rating,MIN(length) AS "durada_min",MAX(length) AS "durada_max" FROM film
 GROUP BY rating
 having durada_min < 90 AND durada_max > 150;

-- 3.Mostra els empleats, el nombre total de pagaments processats i la quantitat màxima cobrada en un sol pagament, però només d’aquells empleats que hagin processat més de 50 pagaments i amb un pagament màxim superior a 8 dòlars.
SELECT staff_id,count(payment_id),SUM(amount) from payment
GROUP BY staff_id
HAVING COUNT(payment_id) > 50 AND SUM(amount) >8;
-- 4.Per a cada classificació (rating), calcula el promig del replacement_cost i el nombre total de pel·lícules d’aquest rating. Mostra les pel·lícules dels ratings amb més de 100 pel·lícules i un cost mitjà de reemplaçament > 18 dòlars.
SELECT count(film_id),rating,AVG(replacement_cost) FROM film
GROUP BY rating
HAVING AVG(replacement_cost)>18 AND count(film_id) >100;

-- 5.Mostra els clients (customer_id), el pagament mínim i el pagament màxim que han realitzat, però només dels que tinguin almenys 5 pagaments i una diferència (màx − mín) > 5 $.
SELECT payment_id,customer_id,min(amount),max(amount) FROM payment
GROUP BY payment_id
HAVING payment_id > 5 AND MIN(amount)-MAX(amount) > 5;
-- 6.Mostra els clients (customer_id), el nombre de lloguers i la data de lloguer més recent, però només dels que tinguin més de 8 lloguers i una data màxima de lloguer anterior a 2006-01-01.
SELECT  customer_id, rental_id, MIN(return_date) FROM rental
GROUP By rental
HAVING RENTAL_ID > 8 and min(return_date) < "2006-01-01";
-- 7.Mostra les pel·lícules, el nombre de vegades que apareixen a la taula inventory i el cost total de reemplaçament estimat (és a dir, el cost multiplicat pel nombre de còpies), però només d’aquelles pel·lícules amb més de 4 còpies i un cost total superior a 100 dòlars.
SELECT film_id, COUNT(film_id) AS "total_cintes",20*COUNT(film_id) AS "cost_remplacament" FROM inventory
Group BY film_id
having total_cintes > 4 AND cost_remplacament > 100;

-- 8.Mostra els clients, el nombre de vegades que han llogat pel·lícules i la data més recent de lloguer, però només dels que tinguin més de 8 lloguers i una data de lloguer màxima anterior a l’any 2006.
SELECT customer_id, COUNT(rental_date),MAX(rental_date) FROM rental
GROUP BY customer_id
HAVING MAX(rental_date) > 2006
AND COUNT(rental_id) > 8;

-- 9.Per a cada rating, calcula el preu de lloguer mitjà (rental_rate) i el nombre de pel·lícules del grup. Mostra les pel·lícules pertanyents a ratings amb més de 10 pel·lícules i un preu mitjà < 3 $
SELECT rating,AVG(rental_rate) AS lloguer, COUNT(film_id)
FROM film
GROUP BY rating
HAVING COUNT(film_id)
AND AVG(rental_rate) < 3;
-- Mostra els clients (client_id), el nombre total de pagaments i l’import mitjà pagat, però només aquells clients amb més de 10 pagaments i amb un import mitjà inferior a 3 dòlars.
SELECT customer_id , count(amount), AVG(AMOUNT) FROM payment
GROUP BY customer_id
HAVING  count(amount) > 10 AND AVG(amount) < 3;




