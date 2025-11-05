/*
1.Añade un nuevo registro al archivo de clientes con todos los datos:
● Nombre completo: Núria Vidal
● Teléfono: 611112223
● Correo: nuria.vidal@example.com
● Dirección: C/ Balmes 10, Manresa
● Cliente activo: Sí
*/
insert into clients (nom, telefon, correu, adreca, client_actiu)
values ('Núria Vidal', '611112223', 'nuria.vidal@example.com', 'C/ Balmes 10, Manresa', 1);


/*
2.Añade otro cliente con estos datos:
● Nombre: Toni Ferrer
● Teléfono: 612345678
● Correo: toni.ferrerp@example.com
● Dirección: av. Falsa 123, Manresa
● Activo: Sí
*/
insert into clients (nom, telefon, correu, adreca, client_actiu)
values ('Toni Ferrer', '612345678', 'toni.ferrerp@example.com', 'Av. Falsa 123, Manresa', 1);
-- número duplicado por lo que no deja añadir a este cliente

/*
3.Añade un nuevo vehículo al registro, indicando:
● Matrícula: 7777ZZZ
● Marca: Renault
● Propietario: Maria Soler
*/
insert into vehicles (matricula, marca, id_client)
values ('7777ZZZ', 'Renault', (select id_client from clients where nom = 'Maria Soler'));

/*
4.Añade un nuevo cliente sin indicar su nombre, con los siguientes datos:
● Nombre: Joana Mateu
● Teléfono: 600000000
● Correo: joana.mateu@example.com
● Dirección: C/ Sin Nombre, 1
● Activo: Sí
*/
insert into clients (telefon, correu, adreca, client_actiu)
values ('600000000', 'joana.mateu@example.com', 'C/ Sense Nom, 1', 1);
-- error debido a que el campo nom no tiene un valor por defecto

/*
5.Inserta dos trabajos nuevos en una sola operación:
1. Trabajo 1
a. Vehículo con matrícula 9012GHI
b. descripción Alineación dirección
c. inicio el 22/10/2025 a las 09:30
d. importe 45.00 €
e. pendiente de finalizar.
2. Trabajo 2
a. Vehículo con matrícula 5678DEF
b. descripción Cambio bujías
c. Inicio el 22/10/2025 a las 10:15
d. importe 30.00 €
e. pendiente de finalizar.
*/
insert into treballs (id_vehicle, descripcio, data_inici, hora_inici, preu, finalitzat)
values 
((select id_vehicle from vehicles where matricula = '9012GHI'), 'Alineació direcció', '2025-10-22', '09:30', 45.00, 0),
((select id_vehicle from vehicles where matricula = '5678DEF'), 'Canvi bugies', '2025-10-22', '10:15', 30.00, 0);

/*
6.Añade una nueva factura:
● para el trabajo con código 2
● Fecha de emisión: el día actual
● Total: 180.00 €
● Estado de pago: No pagada
● Comentarios: Revisión general y neumáticos
*/
insert into factures (id_treball, data_emissio, total, pagada, comentaris)
values (2, current_date(), 180.00, 0, 'Revisió general i pneumàtics');
-- el id_treball está duplicado por lo que no deja añadir esta factura

/*
7.Aumenta un 10% el importe de todos los trabajos que todavía no están
finalizadas.
*/
update treballs
set preu = round(preu * 1.10, 2)
where finalitzat = 0;
-- error por el safe mode, evitando cambios bruscos en la tabla y por lo tanto no actualizará la columna preu

/*
8.Modifica el registro de la clienta Maria Soler para que tenga el teléfono
699999999.
*/
update clients
set telefon = '699999999'
where nom = 'Maria Soler';
-- error por el safe mode

/*
9.Actualiza la factura con código 2 para marcarla como pagada y añade el
comentario Pagada con tarjeta (actualizado). No eliminar el comentario
anterior. Hay que añadir éste.
*/
update factures
set pagada = 1, comentaris = concat(comentaris, ' Pagada amb targeta (actualitzat)')
where id_factura = 2;

/*
10.Eliminar al cliente con código 1.
*/
delete from clients 
where id_client = 1;
-- no puede borrar clientes que tienen facturas, vehículos... asociados todavía

/*
11.Elimina todas las facturas que ya consten como pagadas.
*/
delete from factures 
where pagada = 1;
-- safe update mode de nuevo, no se pueden hacer cambios masivos

/*
12.Borra el vehículo con matrícula 7777ZZZ.
*/
delete from vehicles 
where matricula = '7777ZZZ';