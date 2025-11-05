-- Mark Pires Guimaraes --

-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades:

INSERT INTO clients (nom, telefon, correu, adreca, client_actiu)
VALUE("Núria Vidal", "611112223", "nuria.vidal@example.com", "C/ Balmes 10, Manresa", "1");

-- 2.Afegeix un altre client amb aquestes dades:

INSERT INTO clients (nom, telefon, correu, adreca, client_actiu)
VALUE("Toni Ferrer", 612345678, "toni.ferrerp@example.com", "Av. Falsa 123, Manresa", "1");
 
-- No deja porque el numero de telefon esta duplicat --
-- 3.Afegeix un nou vehicle al registre, indicant:

INSERT INTO vehicles (matricula, marca, id_client)
VALUE ("7777ZZZ", "Renault", "2");

-- 4. Afegeix un nou client indicando amb les dades següents:

INSERT INTO clients (nom, telefon, correu, adreca, client_actiu)
VALUE ("Joana Mateu", "600000000",  "joana.mateu@example.com", "C/ Sense Nom, 1", "1");

-- 5.Insereix dues feines noves en una sola operació:

INSERT INTO treballs (id_treball, id_vehicle, descripcio, data_inici, hora_inici, preu, finalitzat)
VALUE 
("5", "3", "Alineació direcció", "2025-10-22", "09:30:00", "45.00", 0),
("6", "2", "Canvi Bugies", "2025-10-22", "10:15:00", "30.00", 0);    

-- 6.Afegeix una nova factura:

INSERT INTO factures (id_treball, data_emissio, total, pagada, comentaris)
VALUE (2, "2025-10-28", 180.00, 0, "Revisió general i pneumàtics");
-- Me da error porque ya tiene otra factura con la misma id --

-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades.

UPDATE factures
SET total = total * 1.10
WHERE pagada = 0;

-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.

UPDATE clients
SET telefon = 699999999
WHERE nom = "Maria Soler";

-- 9.Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari Pagada amb targeta (actualitzat). No s’ha d’eliminar el comentari anterior. S’hi ha d’afegir aquest.

UPDATE factures
SET pagada = 1,
comentaris = CONCAT(comentaris, "Pagada amb targeta(actualitzat)")
WHERE id_factura = 2;

-- 10.Eliminar el client amb codi 1.
 
 DELETE FROM clients
 WHERE id_client = 1;

-- No deja borrar porque el client tiene facturas --
-- 11.Elimina totes les factures que ja constin com a pagades.

DELETE FROM factures
WHERE pagada = 1;

-- 12.Esborra el vehicle amb matrícula 7777ZZZ

DELETE FROM vehicles
WHERE matricula = "7777ZZZ";