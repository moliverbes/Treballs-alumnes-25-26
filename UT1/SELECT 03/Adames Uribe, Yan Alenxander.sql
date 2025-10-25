-- 1. Mostra els clients, el nombre total de pagaments que han fet i la quantitat total pagada, però només d’aquells que hagin fet més de 12 pagaments i hagin pagat en total més de 50 dòlars.
SELECT customer_id, COUNT(payment_id), SUM(amount)
FROM payment
GROUP BY customer_id
HAVING COUNT(amount) > 12 AND SUM(amount) > 50;

-- 2. Mostra les pel·lícules, la durada màxima i la durada mínima registrada per cada classificació (rating), però només d’aquelles pel·lícules que tinguin una durada màxima superior a 150 minuts i una mínima inferior a 90.
SELECT rating, MAX(length), MIN(length)
FROM film
GROUP BY rating
HAVING MAX(length) > 150 AND MIN(length) < 90;

-- 3. Mostra els empleats, el nombre total de pagaments processats i la quantitat màxima cobrada en un sol pagament, però només d’aquells empleats que hagin processat més de 50 pagaments i amb un pagament màxim superior a 8 dòlars.
SELECT staff_id, COUNT(payment_id), MAX(amount)
FROM payment
GROUP BY staff_id
HAVING COUNT(payment_id) > 50 AND MAX(amount) > 8;

-- 4. Per a cada classificació (rating), calcula el promig del replacement_cost i el nombre total de pel·lícules d’aquest rating. Mostra les pel·lícules dels ratings amb més de 100 pel·lícules i un cost mitjà de reemplaçament > 18 dòlars.
SELECT rating, ROUND(AVG(replacement_cost),2), COUNT(film_id)
FROM film
GROUP BY rating
HAVING COUNT(film_id) > 100 AND AVG(replacement_cost) > 18;

-- 5. Mostra els clients (customer_id), el pagament mínim i el pagament màxim que han realitzat, però només dels que tinguin almenys 5 pagaments i una diferència (màx − mín) > 5 $.
SELECT customer_id, MIN(amount), MAX(amount), COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 5 AND MAX(amount) - MIN(amount) > 5;

-- 6. Mostra els clients (customer_id), el nombre de lloguers i la data de lloguer més recent, però només dels que tinguin més de 8 lloguers i una data màxima de lloguer anterior a 2006-01-01.
SELECT customer_id, COUNT(rental_id), MAX(rental_date)
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) > 8 AND MAX(rental_date) < "2006-01-01";

-- 7. Mostra les pel·lícules, el nombre de vegades que apareixen a la taula inventory i el cost total de reemplaçament estimat, considerant que cada còpia té un cost constant de 20 $, però només d’aquelles pel·lícules amb més de 4 còpies i un cost total superior a 100 $
SELECT film_id, COUNT(film_id) AS "Total_cintes", 20*COUNT(film_id) AS "cost_remplaçament"
FROM inventory
GROUP BY film_id
HAVING Total_cintes > 4 AND cost_remplaçament > 100;

-- 8. Mostra els clients, el nombre de vegades que han llogat pel·lícules i la data més recent de lloguer, però només dels que tinguin més de 8 lloguers i una data de lloguer màxima anterior a l’any 2006.
SELECT customer_id, COUNT(rental_id), MAX(rental_date)
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) > 8 AND MAX(rental_date) < "2006-01-01";

-- 9. Per a cada rating, calcula el preu de lloguer mitjà (rental_rate) i el nombre de pel·lícules del grup. Mostra les pel·lícules pertanyents a ratings amb més de 10 pel·lícules i un preu mitjà < 3 $
SELECT rating, AVG(rental_rate), COUNT(film_id)
FROM film
GROUP BY rating
HAVING COUNT(film_id) > 10 AND AVG(rental_rate) < 3;

-- 10. Mostra els clients (client_id), el nombre total de pagaments i l’import mitjà pagat, però només aquells clients amb més de 10 pagaments i amb un import mitjà inferior a 3 dòlars.
SELECT customer_id, COUNT(rental_id) AS "total_pagaments", AVG(amount) "import_mitja"
FROM payment
GROUP BY customer_id
HAVING total_pagaments > 10 AND import_mitja < 3;