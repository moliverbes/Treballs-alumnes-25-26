/* 1. Mostra els clients, el nombre total de pagaments que han fet i la quantitat total
 pagada, però només d’aquells que hagin fet més de 12 pagaments i hagin pagat en total més
 de 50 dòlars.
*/

SELECT  customer_id,
	COUNT(payment_id) AS 'Total_pagaments', 
    SUM(amount) AS 'Total_pagada'
FROM payment
GROUP BY customer_id
HAVING Total_pagaments > 12 
	AND Total_pagada > 50;

/* 2. Mostra, per a cada classificació (rating), les pel·lícules amb la seva durada màxima
 i mínima registrada, però només en aquells casos en què la durada màxima superi els 150
 minuts i la mínima sigui inferior als 90.
*/

SELECT rating,
	MAX(length) AS 'Durada_màxima',
    MIN(length) AS 'Durada_mínima'
 FROM film
 GROUP BY rating
 HAVING Durada_màxima > 150 
	AND Durada_mínima < 90;

/* 3. Mostra els empleats, el nombre total de pagaments processats i la quantitat màxima
 cobrada en un sol pagament, però només d’aquells empleats que hagin processat més de 50
 pagaments i amb un pagament màxim superior a 8 dòlars.
*/

SELECT staff_id, 
	COUNT(payment_id) AS 'Pagaments_processats',
	MAX(amount) AS 'Max_cobrat'
FROM payment
GROUP BY staff_id
HAVING Pagaments_processats > 50 
	AND Max_cobrat > 8; 

/* 4. Per a cada classificació (rating), calcula el promig del replacement_cost i el nombre
 total de pel·lícules d’aquest rating. Mostra les pel·lícules dels ratings amb més de 100
 pel·lícules i un cost mitjà de reemplaçament > 18 dòlars.
*/

SELECT rating,
	ROUND(AVG(replacement_cost), 2) AS 'Cost_mitjà_reemplaçament' ,
    COUNT(film_id) AS 'Pel·licules_per_rating'
FROM film
GROUP BY rating
HAVING Pel·licules_per_rating > 100 
	AND Cost_mitjà_reemplaçament > 18;

/* 5. Mostra els clients (customer_id), el pagament mínim i el pagament màxim que han
 realitzat, però només dels que tinguin almenys 5 pagaments i una diferència (màx − mín)
 > 5 $.
*/

SELECT customer_id, 
	COUNT(payment_id) AS 'Pagaments_per_client',
	MIN(amount) AS 'Pagament_mínim',
    MAX(amount) AS 'Pagament_máxim'
FROM payment
GROUP BY customer_id
HAVING Pagaments_per_client >= 5 
	AND (Pagament_máxim-Pagament_mínim)>5;

/* 6. Mostra els clients (customer_id), el nombre de lloguers i la data de lloguer més
 recent, però només dels que tinguin més de 8 lloguers i una data màxima de lloguer
 anterior a 2006-01-01.
*/
SELECT customer_id,
	COUNT(rental_id) AS 'Total_lloguers',
    MAX(rental_date) AS 'Lloguer_més_recent'
FROM rental
GROUP BY customer_id
HAVING Total_lloguers > 8 
 AND Lloguer_més_recent < '2006-01-01';


/* 7. Mostra les pel·lícules, el nombre de vegades que apareixen a la taula inventory i
 el cost total de reemplaçament estimat, considerant que cada còpia té un cost constant
 de 20 $, però només d’aquelles pel·lícules amb més de 4 còpies i un cost total superior
 a 100 $
*/

SELECT film_id, 
	COUNT(film_id) AS 'Total_cintes',
    20*COUNT(film_id) AS 'Cost_reemplaçament' 
FROM inventory
GROUP BY film_id
HAVING Total_cintes > 4
	AND Cost_reemplaçament > 100;

/* 8. Mostra els clients, el nombre de vegades que han llogat pel·lícules i la data més
 recent de lloguer, però només dels que tinguin més de 8 lloguers i una data de lloguer
 màxima anterior a l’any 2006.
*/

SELECT customer_id,
	COUNT(rental_id) AS 'Total_pel·lícules_llogades',
	MAX(rental_date) AS 'Lloguer_més_recent'
FROM rental
GROUP BY customer_id
HAVING Total_pel·lícules_llogades > 8
 AND YEAR(Lloguer_més_recent) < 2006;

/* 9. Per a cada rating, calcula el preu de lloguer mitjà (rental_rate) i el nombre de
 pel·lícules del grup. Mostra les pel·lícules pertanyents a ratings amb més de 10
 pel·lícules i un preu mitjà < 3 $
*/

SELECT rating,
	ROUND(AVG(rental_rate),2) AS 'Mitjà_de_preus',
	COUNT(film_id) AS 'Nombre_de_pel·lícules'
FROM film
GROUP BY rating
HAVING Nombre_de_pel·lícules > 10
	AND Mitjà_de_preus < 3;

/* 10.Mostra els clients (customer_id), el nombre total de pagaments i l’import mitjà
 pagat, però només aquells clients amb més de 10 pagaments i amb un import mitjà
 inferior a 3 dòlars.
 */
 
 SELECT customer_id,
 COUNT(payment_id) AS 'Total_pagaments',
 ROUND(AVG(amount),2) AS 'Mitjà_pagaments'
 FROM payment
 GROUP BY customer_id
 HAVING Total_pagaments > 10
	AND Mitjà_pagaments < 3;
 