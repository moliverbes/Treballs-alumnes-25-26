-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades:
Insert into clients (nom, telefon, correu, adreca, client_actiu)
Values ( 'Núria Vidal', 611112223, 'nuria.vidal@example.com', 'C/ Balmes 10, Manresa', 1);

-- 2. Afegeix un altre client amb aquestes dades:
Insert into clients (nom, telefon, correu, adreca, client_actiu)
Values ( 'Toni Ferrer', 612345678, 'toni.ferrerp@example.com', 'Av. Falsa 123, Manresa', 1);
-- No se pot afegir aquest client ja que te el telefon duplicat i es un item que no pot estar duplicat.alter

-- 3. Afegeix un nou vehicle al registre, indicant:
Insert Into vehicles (matricula, marca, id_client)
Values ('7777ZZZ', 'Renault', 2);

-- 4. Afegeix un nou client sense indicar el seu nom, amb les dades següents:
Insert into clients (telefon, correu, adreca, client_actiu)
Values ( 600000000, 'joana.mateu@example.com ', 'C/ Sense Nom, 1' , 1);
-- No se pot afegir ja que sense nom no es posible.

-- 5. Insereix dues feines noves en una sola operació: 
Insert Into treballs (id_vehicle, descripcio, data_inici, hora_inici, preu, finalitzat)
Values (3, 'Alineació direcció', 2025-10-22, '09:30:00' , 45.00, 0),
(2, 'Canvi bugies', 2025-10-22, '10:15:00', 30.00, 0) ; 

-- 6. Afegeix una nova factura: 
Insert Into factures ( id_treball, total, pagada, comentaris)
Values (2, 180.00, 0, 'Revisió general i pneumàtics');	
-- No se pot fer ja que el id_treball ja esta agafat.alter

-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades. 
Update factures
Set total = (total * 1.1)
Where pagada = 0;

-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999. 
Update clients
Set telefon = 699999999
Where id_client = 2;

-- 9 Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari Pagada amb targeta 
-- (actualitzat). No s’ha d’eliminar el comentari anterior. S’hi ha d’afegir aquest. 
Update factures
Set pagada = 1, comentaris = CONCAT('Pagada amb targeta')
Where id_factura = 2;

--  10 Eliminar el client amb codi 1. 
DELETE from clients
Where id_client = 1;
-- No se pot eliminar ja que es un element arrel.

-- 11. Elimina totes les factures que ja constin com a pagades. 
Delete from factures
Where  pagada = 1;

-- 12. Esborra el vehicle amb matrícula 7777ZZZ. 
Delete From vehicles 
Where matricula = '7777ZZZ';
