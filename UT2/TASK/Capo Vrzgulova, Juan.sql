-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades:
-- Nom complet: Núria Vidal
-- Telèfon: 611112223
-- Correu: nuria.vidal@example.com
-- Adreça: C/ Balmes 10, Manresa
-- Client actiu: Sí
INSERT INTO clients (nom, telefon, correu, adreca)
VALUES ("Núria Vidal", 611112223, "nuria.vidal@example.com", "C/ Balmes 10, Manresa");

SELECT * FROM clients;

-- 2. Afegeix un altre client amb aquestes dades:
-- Nom: Toni Ferrer
-- Telèfon: 612345678
-- Correu: toni.ferrerp@example.com
-- Adreça: Av. Falsa 123, Manresa
-- Actiu: Sí

-- No es pot ficar un telefon duplicat
INSERT INTO clients (nom, telefon, correu, adreca)
VALUES ("Toni Ferrer", 612345678, "toni.ferrerp@example.com", "Av. Falsa 123, Manresa");

SELECT * FROM clients;

-- 3. Afegeix un nou vehicle al registre, indicant:
-- Matrícula: 7777ZZZ
-- Marca: Renault
-- Propietari: Maria Soler
INSERT INTO vehicles (id_client,matricula, marca)
VALUES (2,"7777ZZZ", "Renault" );

SELECT * FROM vehicles;

-- 4. Afegeix un nou client amb les dades següents: Nom: Joana Mateu Telèfon: 600000000  Correu: joana.mateu@example.com  Adreça: C/ Sense Nom, 1  Actiu: Sí
INSERT INTO clients (nom, telefon, correu, adreca)
VALUE ("Joana Mateu", 600000000, "joana.mateu@example.com", "C/ Sense Nom, 1" );

SELECT * FROM clients;

-- 5. Insereix dues feines noves en una sola operació: 
-- 1. Feina 1  Vehicle amb matrícula 9012GHI  descripció Alineació direcció  inici el 22/10/2025 a les 09:30 d. import 45.00 € e. pendent de finalitzar.
-- 2. Feina 2 a. Vehicle amb matrícula 5678DEF b. descripció Canvi bugiesc. Inici el 22/10/2025 a les 10:15 d. import 30.00 € e. pendent de finalitzar.

-- No es pot ficar les dades ja que el format de la data no és el mateix
INSERT INTO treballs (descripcio, data_inici, hora_inici, preu)
VALUES ("Alineació direcció", "22/10/2025", "09:30", 45.00), 
("Canvi bugiesc.", "22/10/2025", "10:15", 30.00);

SELECT * FROM treballs;

-- 6. Afegeix una nova factura: per a la feina amb codi 2 Data d’emissió: el dia actual Total: 180.00 € Estat de pagament: No pagada Comentaris: Revisió general i pneumàtics

-- No es pot ficar ja que no pot tenir més d'una factura en la mateixa entitat
INSERT INTO factures (id_treball, total, pagada, comentaris )
VALUES (2, 180.00, 0, "Revisió general i pneumàtics");

SELECT * FROM factures;

-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades.
UPDATE treballs
SET preu = preu * 0.10
WHERE finalitzat = 0;

SELECT * FROM treballs;

-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.
UPDATE clients 
SET telefon = 699999999
WHERE nom LIKE 'Maria Soler';

SELECT * FROM clients;

-- 9. Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari Pagada amb targeta (actualitzat). No s’ha d’eliminar el comentari
-- anterior. S’hi ha d’afegir aquest.
UPDATE factures
SET pagada = 1,
comentaris = CONCAT(comentaris, ' Pagada amb targeta (actualitzat)')
WHERE id_factura = 2;

SELECT * FROM factures;

-- 10. Eliminar el client amb codi 1.
-- No es pot eliminar ja que intentam eliminar una foreign key
DELETE FROM clients 
WHERE id_client = 1;

SELECT * FROM clients;

-- 11. Elimina totes les factures que ja constin com a pagades.
DELETE FROM factures
WHERE pagada = 1;

SELECT * FROM factures;

-- 12. Esborra el vehicle amb matrícula 7777ZZZ
DELETE FROM vehicles
WHERE matricula = '7777ZZZ';

SELECT * FROM vehicles;