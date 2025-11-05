# 1.Muestra el identificador y el nombre completo en una sola columna de todos los clientes; ordena por el nombre completo de forma ascendente.
select concat(id_client,' ',nom,' ',cognoms) as id_nom_completo
from clients
order by id_nom_completo asc;

# 2.Lista de los productos con tres columnas llamadas exactamente NOMBRE_PRODUCTO, CATEGORÍA y PRECIO_EUR; ordena por el precio de mayor a menor y limita el resultado a 5 filas.
select nom as nombre_producto, categoria as categoría, preu as precio_eur
from productes
order by precio_eur desc
limit 5;

# 3.Muestra los productos con precio superior a 40; enseña el identificador, el nombre y el precio; ordena por el precio de forma ascendente.
select id_producte, nom as nombre_producto, preu as precio
from productes
where preu > 40
order by preu asc;

# 4.Muestra los clientes cuyo apellido contiene la secuencia de letras 'ra'; ordena alfabéticamente por el campo de apellidos.
select nom as nombre_cliente, cognoms as apellido_cliente
from clients
where cognoms like '%ra%'
order by cognoms asc;

# 5.Muestra el nombre, categoría y precio de los productos con precio entre 20 y 40 (incluidos); ordena primero por el precio y después por el nombre.
select nom as nombre, categoria as categoría, preu as precio
from productes
where preu between 20 and 40
order by preu, nom;

# 6.Muestra el identificador, el nombre y la categoría de los productos cuya categoría sea Electrónica o Libros; ordena por categoría ascendente y por nombre descendente.
select id_producte, nom as nombre_producto, categoria as categoría
from productes
where categoria in ('Electrònica','Llibres')
order by categoria asc, nom desc;

# 7.Muestra de los pedidos el identificador, la fecha y el estado; ordena de la más reciente a la más antigua.
select id_comanda, data_comanda as fecha, estat as estado
from comandes
order by data_comanda desc;

/*
8.Muestra para cada línea de detalle_pedido el identificador de pedido, el código de producto, la cantidad, el precio unitario 
y una columna adicional con el subtotal de la línea; ordena por identificador de pedido y después por el código de producto.
*/
select id_comanda as identificador_pedido, id_producte as codigo_producto, quantitat as cantidad, preu_unitari as precio_unitario, quantitat*preu_unitari as subtotal 
from detall_comanda
order by id_comanda asc, id_producte asc;

/*
9.De productos, muestra el identificador, el nombre en mayúsculas y la longitud del nombre; 
ordena por la longitud de mayor a menor y, en caso de empate, por el nombre en mayúsculas.
*/
select id_producte, upper(nom) as nombre_mayusculas, length(nom) as longitud_nombre
from productes
order by longitud_nombre desc, nombre_mayusculas asc;

# 10.De clientes, muestra el identificador, el nombre y los 5 primeros caracteres del campo de apellidos con el alias prefix_apellidos; ordena por prefijo_apellidos.
select id_client as identificador_cliente, nom as nombre, substring(cognoms,1,5) as prefix_apellidos
from clients
order by prefix_apellidos asc;

/*
11.De productos muestra el identificador, el nombre, el precio y una columna con el precio con un incremento del 21%, redondeado a 2 decimales; 
filtra sólo los productos con stock igual o superior a 10; ordena por el nuevo precio de mayor a menor.
*/
select id_producte as identificador_producto, nom as nombre, preu as precio, round(preu * 1.21, 2) as precio_incrementado, stock
from productes
where stock >= 10
order by precio_incrementado desc;

# 12.De productos, muestra el identificador, nombre, precio y valor entero del precio; filtra sólo los productos con stock impar; ordena por stock de mayor a menor.
select id_producte, nom, preu, round(preu, 0) as valor_entero, stock
from productes
where stock % 2 = 1
order by stock desc;

# 13.De pedidos, muestra el identificador, la fecha y las columnas separadas de año, mes, día y hora obtenidas a partir de la fecha; ordena por fecha ascendente
select id_comanda as identificador_pedido, data_comanda as fecha_pedido, year(data_comanda) as año, month(data_comanda) as mes, day(data_comanda) as dia, time(data_comanda) as hora
from comandes
order by fecha_pedido asc;

# 14.De pedidos, muestra el identificador y la fecha formateada como YYYY-MM en una columna llamada año_mes; ordena por año_mes y después por identificador.
select id_comanda, date_format(data_comanda, '%Y-%m') as año_mes
from comandes
order by año_mes, id_comanda;

# 15.De productos, muestra el identificador, el nombre, la categoría, el precio y el stock aplicando esta condición: no sean de la categoría 'Ropa' y, además, precio < 30 o stock > 30; ordena por categoría y después por precio.
select id_producte, nom, categoria, preu, stock
from productes
where categoria != 'Roba' and (preu < 30 or stock > 30)
order by categoria, preu;

# 16.De productos, muestra todos los registros que tengan precio informado; enseña el identificador y el precio. (Nota: el resultado puede incluir todos los productos si no hay ninguno con valor desconocido.)
select id_producte, preu
from productes
where preu is not null;

# 17.De pedidos, calcula para cada estado el número de pedidos; muestra el estado y el recuento; ordena del mayor número al menor.
select estat as estado, count(*) as recuento
from comandes
group by estat
order by recuento desc;

# 18.De pedidos, calcula el importe medio, el mínimo y el máximo agrupante por estado; ordena por estado ascendente.
select estat as estado, round(avg(import_total), 2) as importe_medio, min(import_total) as importe_minimo, max(import_total) as importe_maximo
from comandes
group by estat
order by estado asc;

# 19.De pedidos, calcula para cada año-mes (YYYY-MM) el número de pedidos, la suma de importes y el importe medio redondeado a 2 decimales; ordena por año-mes ascendente.
select date_format(data_comanda, '%Y-%m') as año_mes, count(*) as num_pedidos, sum(import_total) as suma_importes, round(avg(import_total), 2) as import_medio
from comandes
group by año_mes
order by año_mes asc;

# 20.De la tabla pedidos, muestra para cada estado el número de pedidos y el importe total acumulado de los pedidos realizados durante el año 2024. Ordena de mayor a menor importe total.
select estat as estado, count(*) as num_pedidos, sum(import_total) as importe_total_acumulado
from comandes
where year(data_comanda) = 2024
group by estado
order by importe_total_acumulado desc;

# 21.De pedidos, muestra el identificador, la fecha y el estado para los pedidos entre '2024-06-01' y '2024-07-31' (incluidos); ordena por fecha.
select id_comanda, data_comanda as fecha, estat as estado
from comandes
where data_comanda between '2024-06-01' and '2024-07-31'
order by fecha;

# 22.De clientes, muestra los registros donde el nombre comienza por ‘M’ y tiene exactamente 4 letras; enseña identificador, nombre y apellidos.
select id_client, nom, cognoms
from clients
where nom like 'M___';

/*
23.De detalle_pedido, muestra las 3 líneas con subtotal más alto (donde subtotal
es cantidad por precio unitario); devuelve el identificador de pedido, el código
de producto, cantidad, precio unitario y subtotal; ordena por subtotal
de mayor a menor y limita a 3 filas.
*/
select id_comanda as identificador_pedido, id_producte as codigo_producto, quantitat, preu_unitari, quantitat * preu_unitari as subtotal
from detall_comanda
order by subtotal desc
limit 3;

# 24.Haz una consulta que devuelva una sola fila con tres columnas: la fecha actual, la hora actual y la marca de tiempo actual.
select current_date() as fecha_actual, current_time() as hora_actual, current_timestamp() as marca_tiempo_actual;

/*
25.De la tabla productos, muestra para cada categoría el número de
productos y el precio medio, excluyendo las categorías 'Accesorios' y 'Libros'.
Muestra sólo las categorías que tengan más de un producto y ordena por
precio medio de mayor a menor.
*/
select categoria, count(*) as num_productos, round(avg(preu), 2) as precio_medio
from productes
where categoria not in ('Accessoris', 'Llibres')
group by categoria
having num_productos > 1
order by precio_medio desc;