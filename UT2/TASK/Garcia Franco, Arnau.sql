/* ================================
   Basic Editing – Compulsory Task
   Base de dades: taller_mecanic
   Autor: [Arnau Garcia Franco]
   ================================= */

/* 🔧 EXERCICI 1:
Afegeix un nou registre al fitxer de clients amb totes les dades:
Nom: Núria Vidal
Telèfon: 611112223
Correu: nuria.vidal@example.com
Adreça: C/ Balmes 10, Manresa
Client actiu: Sí
*/

INSERT INTO clients (nom, telefon, correu, adreca, client_actiu) 
	VALUES ('Nuria Vidal', 611112223,'nuria.vidal@example.com', 'C/ Balmes 10, Manresa', 1);

select *from clients;

/* 🔧 EXERCICI 2:
Afegeix un altre client amb aquestes dades:
Nom: Toni Ferrer
Telèfon: 612345678
Correu: toni.ferrerp@example.com
Adreça: Av. Falsa 123, Manresa
Actiu: Sí
*/

INSERT INTO clients (nom, telefon, correu, adreca, client_actiu) 
	VALUES ('Toni Ferrer', 612345678, 'toni.ferrerp@example.com', 'Av. Falsa 123, Manresa', 1);
    -- Dona error ja que el nº de telefón esta duplicat, per tant no es pot afegir sense modificar la taula, o eliminar l'anterior nº de telefón

/* 🚗 EXERCICI 3:
Afegeix un nou vehicle:
Matrícula: 7777ZZZ
Marca: Renault
Propietari: Maria Soler
*/

INSERT INTO vehicles (matricula, marca, propietari)
	VALUES ('7777ZZZ', 'Renault', 'Maria Soler');
    -- Dona error ja que no existeix la columna 'porpietari' a la taula vehicles, com no tenim la columna no podem afegir informació.

/* 🧩 EXERCICI 4:
Afegeix un nou client sense indicar el seu nom (provoca error).
Nom: Joana Mateu
Telèfon: 600000000
Correu: joana.mateu@example.com
Adreça: C/ Sense Nom, 1
Actiu: Sí
-- Si dona error, comenta per què, no ho corregeixis.
*/

INSERT INTO clients (nom, telefon, correu, adreca, client_actiu)
	VALUES('Joana Mateu', 600000000, 'joana.mateu@example.com', 'C/ Sense Nom, 1', 1);

/* 🛠️ EXERCICI 5:
Insereix dues feines noves en una sola operació:
Feina 1:
 - Vehicle: 9012GHI
 - Descripció: Alineació direcció
 - Inici: 22/10/2025 09:30
 - Import: 45.00 €
 - Estat: pendent

Feina 2:
 - Vehicle: 5678DEF
 - Descripció: Canvi bugies
 - Inici: 22/10/2025 10:15
 - Import: 30.00 €
 - Estat: pendent
*/

INSERT INTO Treballs (id_vehicle, descripcio, data_inici, hora_inici, preu, finalitzat)
VALUES
(
    (SELECT id_vehicle FROM Vehicles WHERE matricula = '9012GHI'),
    'Alineació direcció',
    '2025-10-22',
    '09:30:00',
    45.00,
    FALSE
),
(
    (SELECT id_vehicle FROM Vehicles WHERE matricula = '5678DEF'),
    'Canvi bugies',
    '2025-10-22',
    '10:15:00',
    30.00,
    FALSE
); 
/* 💰 EXERCICI 6:
Afegeix una nova factura:
 - Feina: codi 2
 - Data emissió: avui
 - Total: 180.00 €
 - Estat: No pagada
 - Comentaris: Revisió general i pneumàtics
*/

INSERT INTO factures (id_treball, data_emissio,total, pagada, comentaris)
	VALUES (2, '2025-10-31', 180.00, FALSE , 'Revisió general i pneumàtics');
-- Dona error ja que no podem asignarli una factura nova a un treball ja existent, es pot si es modifica l'anterior o si afegim modificacions externes     

/* 📈 EXERCICI 7:
Augmenta un 10% l’import de totes les feines no finalitzades.
*/

UPDATE treballs
	SET preu = preu *1.10
    where finalitzat = 0;
-- Donara error si no es desabilita si esta el "safe mode" activat

/* 📞 EXERCICI 8:
Modifica el registre de la clienta Maria Soler:
 - Nou telèfon: 699999999
*/

UPDATE clients
	SET telefon = 699999999
    where nom like 'Maria Soler';

/* 💳 EXERCICI 9:
Actualitza la factura amb codi 2:
 - Estat: pagada
 - Afegeix el comentari “Pagada amb targeta (actualitzat)”
   sense eliminar el comentari anterior.
*/

UPDATE factures
	SET pagada = 1, comentaris = CONCAT(comentaris, ',' 'Pagada amb targeta (actualitzada) ')
    where id_factura = 2;
    SELECT * FROM factures;

/* 🗑️ EXERCICI 10:
Elimina el client amb codi 1.
*/

DELETE  FROM clients
where id_client = 1;
-- no podem borrar el client ja que la seva primary key (id_client) fa referenci com a foreign key a altres taules de la bsd.

/* 🧾 EXERCICI 11:
Elimina totes les factures que constin com a pagades.
*/

DELETE FROM factures
where pagada = 1;

/* 🚙 EXERCICI 12:
Esborra el vehicle amb matrícula 7777ZZZ.
*/

DELETE FROM vehicles 
where matricula = '7777ZZZ'; 

