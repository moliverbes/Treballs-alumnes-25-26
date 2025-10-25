-- 1 Mostra els clients, el nombre total de pagaments que han fet i la quantitat total pagada, 
-- però només d’aquells que hagin fet més de 12 pagaments i hagin pagat en total més de 50 dòlars.
SELECT customer_id, SUM(amount) as 'Total_pagado', count(payment_id) as 'Total_pagamientos' FROM payment
Group by customer_id
Having total_pagado > 50 and total_pagamientos > 12;

-- 2 Mostra, per a cada classificació (rating), les pel·lícules amb la seva durada màxima i mínima registrada, 
-- però només en aquells casos en què la durada màxima superi els 150 minuts i la mínima sigui inferior als 90.
SELECT Max(length) as 'Duracion_maxima', Min(length) as 'Duracion_minima', rating FROM film
GROUP BY rating
Having Duracion_maxima > 150 and Duracion_minima < 90;

-- 3 Mostra els empleats, el nombre total de pagaments processats i la quantitat màxima cobrada en un sol pagament, 
-- però només d’aquells empleats que hagin processat més de 50 pagaments i amb un pagament màxim superior a 8 dòlars.
SELECT staff_id, SUM(amount) as 'Total_pagado', count(payment_id) as 'Total_pagos' FROM payment
Group by staff_id
Having total_pagado > 8 and total_pagos > 50;

-- 4 Per a cada classificació (rating), calcula el promig del replacement_cost i el nombre total de pel·lícules d’aquest rating. 
-- Mostra les pel·lícules dels ratings amb més de 100 pel·lícules i un cost mitjà de reemplaçament > 18 dòlars.
SELECT rating, count(replacement_cost) as 'Total_peliculas', avg(replacement_cost) as 'Promedio_peliculas' FROM film
Group by rating
HAVING Total_peliculas > 100 and Promedio_peliculas > 18;

-- 5 Mostra els clients (customer_id), el pagament mínim i el pagament màxim que han realitzat, 
-- però només dels que tinguin almenys 5 pagaments i una diferència (màx − mín) > 5 $.
SELECT customer_id, MAX(amount) as 'Pago_maximo', MIN(amount) as 'Pago_minimo', count(payment_id) as 'total_pagos'
FROM payment
GROUP BY customer_id
Having total_pagos >= 5 and (Pago_maximo - Pago_minimo) > 5;

-- 6 Mostra els clients (customer_id), el nombre de lloguers i la data de lloguer més recent, 
-- però només dels que tinguin més de 8 lloguers i una data màxima de lloguer anterior a 2006-01-01.
SELECT customer_id, COUNT(rental_id) as 'Total_pagos', MAX(rental_date) as 'Fecha_mas_reciente' FROM rental
GROUP BY customer_id
Having Total_pagos > 8 and Fecha_mas_reciente > '2006-01-01';

-- 7 Mostra les pel·lícules, el nombre de vegades que apareixen a la taula inventory i el cost total de reemplaçament estimat, 
-- considerant que cada còpia té un cost constant de 20 $, però només d’aquelles pel·lícules amb més de 4 còpies i 
-- un cost total superior a 100 $
SELECT film_id, count(film_id) as 'total_cintes', 20*COUNT(film_id) as 'cost_remplacament'
From inventory
Group by film_id
Having total_cintes > 4 and cost_remplacament > 100;

-- 8 Mostra els clients, el nombre de vegades que han llogat pel·lícules i la data més recent de lloguer, 
-- però només dels que tinguin més de 8 lloguers i una data de lloguer màxima anterior a l’any 2006
SELECT customer_id, count(rental_id) as 'Total_alquileres', Max(rental_date) as 'Fecha_mas_reciente' FROM rental
GROUP BY customer_id
Having Total_alquileres > 8 and Fecha_mas_reciente < '2006-01-01';

-- 9 Per a cada rating, calcula el preu de lloguer mitjà (rental_rate) i el nombre de pel·lícules del grup. 
-- Mostra les pel·lícules pertanyents a ratings amb més de 10 pel·lícules i un preu mitjà < 3 $
SELECT rating, count(rating) as 'Numero_peliculas', avg(rental_rate) as 'Media_precio' FROM film
GROUP BY rating
Having Numero_peliculas > 10 and Media_precio < 3;

-- 10 Mostra les pel·lícules, el nombre total de còpies en inventari i el preu de lloguer mitjà, 
-- però només de les pel·lícules amb més de 10 còpies i amb un preu mitjà inferior a 3 dòlars.
SELECT title, SUM(film_id) as 'Total_peliculas', avg(replacement_cost) as 'Media_alquiler'
FROM film
group by title
Having Media_alquiler < 3;
