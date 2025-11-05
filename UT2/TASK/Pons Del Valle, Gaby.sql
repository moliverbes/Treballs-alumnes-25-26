/** 1. Afegeix un nou registre al fitxer de clients amb totes les dades:
● Nom complet: Núria Vidal
● Telèfon: 611112223
● Correu: nuria.vidal@example.com
● Adreça: C/ Balmes 10, Manresa
● Client actiu: Sí **/

INSERT INTO Clients (nom, telefon, correu, adreca, client_actiu)
VALUES ('Núria Vidal', '611112223', 'nuria.vidal@example.com', 'C/ Balmes 10, Manresa', TRUE);



/** 2. Afegeix un altre client amb aquestes dades:
● Nom: Toni Ferrer
● Telèfon: 612345678
● Correu: toni.ferrerp@example.com
● Adreça: Av. Falsa 123, Manresa
● Actiu: Sí **/
INSERT INTO Clients (nom, telefon, correu, adreca, client_actiu)
VALUES ('Toni Ferrer', '612345678', 'toni.ferrerp@example.com', 'Av. Falsa 123, Manresa', TRUE);
-- Error possible: El telèfon 612345678 ja existeix (Joan Puig).
-- Solució: Canvia el telèfon o elimina la restricció UNIQUE si no és necessària.


/** 3. Afegeix un nou vehicle al registre, indicant:
● Matrícula: 7777ZZZ
● Marca: Renault
● Propietari: Maria Soler **/
-- Alternativa por si vols mantenir UNIQUE
INSERT INTO Clients (nom, telefon, correu, adreca, client_actiu)
VALUES ('Toni Ferrer', '612345679', 'toni.ferrerp@example.com', 'Av. Falsa 123, Manresa', TRUE);


/** 4. Afegeix un nou client sense indicar el seu nom, amb les dades següents:
● Nom: Joana Mateu
● Telèfon: 600000000
● Correu: joana.mateu@example.com
● Adreça: C/ Sense Nom, 1
● Actiu: Sí **/

INSERT INTO Clients (nom, telefon, correu, adreca, client_actiu)
VALUES ('Joana Mateu', '600000000', 'joana.mateu@example.com', 'C/ Sense Nom, 1', TRUE);



/** 5. Insereix dues feines noves en una sola operació:
1. Feina 1
a. Vehicle amb matrícula 9012GHI
b. descripció Alineació direcció
c. inici el 22/10/2025 a les 09:30
d. import 45.00 €
e. pendent de finalitzar.
2. Feina 2
a. Vehicle amb matrícula 5678DEF
b. descripció Canvi bugies
c. Inici el 22/10/2025 a les 10:15
d. import 30.00 €
e. pendent de finalitzar. **/
INSERT INTO Treballs (id_vehicle, descripcio, data_inici, hora_inici, data_fi, preu, finalitzat)
VALUES
-- Vehicle 9012GHI (id_vehicle = 3)
(3, 'Alineació direcció', '2025-10-22', '09:30:00', NULL, 45.00, FALSE),
-- Vehicle 5678DEF (id_vehicle = 2)
(2, 'Canvi bugies', '2025-10-22', '10:15:00', NULL, 30.00, FALSE);


/** 6. Afegeix una nova factura:
● per a la feina amb codi 2
● Data d’emissió: el dia actual
● Total: 180.00 €
● Estat de pagament: No pagada
● Comentaris: Revisió general i pneumàtics **/
INSERT INTO Factures (id_treball, data_emissio, total, pagada, comentaris)
VALUES (2, CURDATE(), 180.00, FALSE, 'Revisió general i pneumàtics'); 

/** 7. Augmenta un 10 % l’import de totes les feines que encara no estan
finalitzades. **/
UPDATE Treballs
SET preu = preu * 1.10
WHERE finalitzat = FALSE;
-- Afecta les feines 3, 5 i 6 (les noves i la revisió pendent)

/** 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999. **/
UPDATE Clients
SET telefon = '699999999'
WHERE nom = 'Maria Soler';

/** 9. Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el
comentari Pagada amb targeta (actualitzat). No s’ha d’eliminar el comentari
anterior. S’hi ha d’afegir aquest.
10. Eliminar el client amb codi 1.
11. Elimina totes les factures que ja constin com a pagades.
12. Esborra el vehicle amb matrícula 7777ZZZ. **/