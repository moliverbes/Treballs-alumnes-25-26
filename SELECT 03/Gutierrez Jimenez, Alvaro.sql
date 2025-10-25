/*
1. Muestra a los clientes, el número total de pagos que han realizado y la cantidad total pagada, 
pero sólo de aquellos que hayan realizado más de 12 pagos y hayan pagado en total más de 50 dólares.
*/
select customer_id, count(payment_id) as num_pagos, sum(amount) as cantidad_total
from payment
group by customer_id
having num_pagos > 12 and cantidad_total > 50;

/*
2. Muestra, para cada clasificación (rating), las películas con su duración máxima y mínima registrada, 
pero sólo en aquellos casos en que la duración máxima supere los 150 minutos y la mínima sea inferior a 90.
*/
select max(length) as max_duracion, min(length) as min_duracion, rating
from film
group by rating
having max_duracion > 150 and min_duracion < 90;

/*
3. Muestra a los empleados, el número total de pagos procesados ​​y la cantidad máxima cobrada en un solo pago, 
pero sólo de aquellos empleados que hayan procesado más de 50 pagos y con un pago máximo superior a 8 dólares
*/
select staff_id, count(payment_id) as num_pagos, max(amount) as max_cobrada
from payment
group by staff_id
having num_pagos > 50 and max_cobrada > 8.00;

/*
4. Para cada clasificación (rating), calcula el promedio del replacement_cost y el número total de películas de este rating. 
Muestra las películas de los ratings con más de 100 películas y un coste medio de reemplazo > 18 dólares.
*/
select rating, round(avg(replacement_cost),2) as promedio_coste_reemplazo, count(film_id) as num_peliculas
from film
group by rating
having num_peliculas > 100 and promedio_coste_reemplazo > 18.00;

/*
5. Muestra a los clientes (customer_id), el pago mínimo y el pago máximo que han realizado, 
pero sólo de los que tengan al menos 5 pagos y una diferencia (máx − mín) > 5 $.
*/
select customer_id, count(payment_id) as num_pagos, min(amount) as min_pago, max(amount) as max_pago
from payment
group by customer_id
having num_pagos >= 5 and (max_pago - min_pago) > 5.00;

/*
6. Muestra a los clientes (customer_id), el número de alquileres y la fecha de alquiler más reciente, 
pero sólo de los que tengan más de 8 alquileres y una fecha máxima de alquiler anterior a 2006-01-01.
*/
select customer_id, count(rental_id) as num_alquileres, max(rental_date) as fecha_reciente
from rental
group by customer_id
having num_alquileres > 8 and fecha_reciente < '2006-01-01';

/*
7. Muestra las películas, el número de veces que aparecen en la tabla inventory y el coste total de reemplazo estimado, considerando que cada copia tiene un coste constante de 20$, 
pero sólo de aquellas películas con más de 4 copias y un coste total superior a 100$
*/
select film_id, count(film_id) as total_peliculas, 20*count(film_id) as coste_reemplazo
from inventory
group by film_id
having total_peliculas > 4 and coste_reemplazo > 100.00;

/*
8.Muestra a los clientes, el número de veces que han alquilado películas y la fecha más reciente de alquiler, 
pero sólo de los que tengan más de 8 alquileres y una fecha de alquiler máxima anterior al año 2006.
*/
select customer_id, count(rental_id) as pel_alquiladas, max(rental_date) as fecha_reciente
from rental
group by customer_id
having pel_alquiladas > 8 and fecha_reciente < '2006-01-01';

/*
9. Para cada rating, calcula el precio de alquiler medio (rental_rate) y el número de películas del grupo. 
Muestra las películas pertenecientes a ratings con más de 10 películas y un precio medio < 3 $
*/
select rating, round(avg(rental_rate),2) as precio_medio, count(film_id) as num_peliculas
from film
group by rating
having num_peliculas > 10 and precio_medio < 3.00;

/*
10. Muestra a los clientes (customer_id), el número total de pagos y el importe medio pagado, 
pero sólo aquellos clientes con más de 10 pagos y con un importe medio inferior a 3 dólares.
*/
select customer_id, count(payment_id) as num_pagos, round(avg(amount),2) as media_pagos
from payment
group by customer_id
having num_pagos > 10 and media_pagos < 3.00;