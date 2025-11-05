-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades:
INSERT INTO clients
(nom, telefon, correu, adreca, client_actiu)
VALUES ("Núria Vidal", "611112223", "nuria.vidal@example.com", "C/ Balmes 10, Manresa", "1");

-- 2. Afegeix un altre client amb aquestes dades:
INSERT INTO clients
(nom, telefon, correu, adreca, client_actiu)
VALUES ("Toni Ferrer", "612345678", "toni.ferrerp@example.com", " Av. Falsa 123, Manresa", "1");

-- No es pot afegir a Toni Ferrer, degut a que el seu numero de telefon ja esta a la base de dades.

-- 3. Afegeix un nou vehicle al registre, indicant:
INSERT INTO vehicles
(matricula, marca, id_client)
VALUES ("7777ZZZ", "Renault", "2");

-- 4. Afegeix un client nou, amb les dades següents:
INSERT INTO clients
(nom, telefon, correu, adreca, client_actiu)
VALUES ("Joana Mateu", "600000000", "joana.mateu@example.com", "C/ Sense Nom, 1", "1");

-- 5. Insereix dues feines noves en una sola operació:
-- Feina 1
INSERT INTO treballs
(id_vehicle, descripcio, data_inici, hora_inici, preu, finalitzat)
VALUES (3, "Alineació direcció", "2025-10-22", "09:30:00", 45.00, 0), (2, "Canvi buguies", "2025-10-22", "10:15:00", 30.00, 0);

-- 6. Afegeix una nova factura:
INSERT INTO factures
(id_treball, data_emissio, total, pagada, comentaris)
VALUES (2, current_date(), 180.00, 0, "Revisió general i pneumàtics");

-- No es pot afegir, ja que el numero de treball 2, ja esta asociat a un altre treball.
 
-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades.
UPDATE treballs
SET preu = ROUND(preu*1.10, 2)
WHERE finalitzat = 0;

-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.
UPDATE clients
SET telefon = "699999999"
WHERE id_client = 2;

-- 9. Actualitza la factura amb codi 2 per marcar-la com a pagada i 
-- afegeix el comentari Pagada amb targeta (actualitzat). No s’ha d’eliminar el comentari anterior. S’hi ha d’afegir aquest.
UPDATE factures
SET pagada = 1,
comentaris = "Client recollirà el vehicle demà. Pagada amb targeta (actualitzat)"
WHERE id_factura = 2;

-- 10. Eliminar el client amb codi 1.
DELETE FROM clients
WHERE id_client = 1;

-- No ens deixa, ja que no podem borrar un client que te factures.

-- 11. Elimina totes les factures que ja constin com a pagades.
DELETE FROM factures
WHERE pagada = 1;

-- 12. Esborra el vehicle amb matrícula 7777ZZZ.
DELETE FROM vehicles
WHERE matricula = "7777ZZZ";
