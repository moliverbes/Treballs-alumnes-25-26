/*
1. Afegeix un nou registre al fitxer de clients amb totes les dades:
	● Nom complet: Núria Vidal
	● Telèfon: 611112223
	● Correu: nuria.vidal@example.com
	● Adreça: C/ Balmes 10, Manresa
	● Client actiu: Sí
*/

INSERT INTO Clients
	(nom, telefon, correu, adreca, client_actiu)

VALUES ('Núria Vidal', 611112223, 'nuria.vidal@example.com', 'C/ Balmes 10, Manresa', 1);

SELECT * FROM Clients;

/*
2. Afegeix un altre client amb aquestes dades:
	● Nom: Toni Ferrer
	● Telèfon: 612345678
	● Correu: toni.ferrerp@example.com
	● Adreça: Av. Falsa 123, Manresa
	● Actiu: Sí
*/

INSERT INTO Clients
	(nom, telefon, correu, adreca, client_actiu)

VALUES
	('Toni Ferrer', 612345678, 'toni.ferrerp@example.com', 'Av. Falsa 123, Manresa', 1);

SELECT * FROM Clients;
DESCRIBE Clients;

-- Ens apareix un error perquè el camp telefon té una restricció UNIQUE, i el
-- valor que volem inserir ja existeix a la taula Clients. 

/*
3. Afegeix un nou vehicle al registre, indicant:
	● Matrícula: 7777ZZZ
	● Marca: Renault
	● Propietari: Maria Soler
*/

INSERT INTO Vehicles
	(matricula, marca, id_client)

VALUES 
	('7777ZZZ', 'Renault', 2);

SELECT * FROM Vehicles;

/*
4. Afegeix un nou client amb les dades següents:
● Nom: Joana Mateu
● Telèfon: 600000000
● Correu: joana.mateu@example.com
● Adreça: C/ Sense Nom, 1
● Actiu: Sí
*/

INSERT INTO Clients
	(nom, telefon, correu, adreca, client_actiu)

VALUES 
	('Joana Mateu', 600000000, 'joana.mateu@example.com', 'C/ Sense Nom, 1', 1);
    
SELECT * FROM Clients;

/*
5. Insereix dues feines noves en una sola operació:
	1. Feina 1
		a. Vehicle amb matrícula: 9012GHI
		b. Descripció: Alineació direcció
		c. Inici el 22/10/2025 a les 09:30
		d. Import: 45.00 €
		e. Pendent de finalitzar.
        
	2. Feina 2
		a. Vehicle amb matrícula: 5678DEF
		b. Descripció: Canvi bugies
		c. Inici el 22/10/2025 a les 10:15
		d. Import: 30.00 €
		e. Pendent de finalitzar.
*/

INSERT INTO Treballs
	(id_vehicle, descripcio, data_inici, hora_inici, preu, finalitzat)

VALUES
	(3, 'Alineació direcció', '2025-10-22', '09:30:00', 45.00, 0),
    (2, 'Canvi bugies', '2025-10-22', '10:15:00', 30.00, 0 );

SELECT * FROM Treballs;

/*
6. Afegeix una nova factura:
	● Per a la feina amb codi 2
	● Data d’emissió: el dia actual
	● Total: 180.00 €
	● Estat de pagament: No pagada
	● Comentaris: Revisió general i pneumàtics
*/

INSERT INTO Factures
	(id_treball, data_emissio, total, pagada, comentaris)
    
VALUES (2, CURRENT_DATE() ,180.00, 0, 'Revisió general i pneumàtics');

SELECT * FROM Factures;
DESCRIBE Factures;

-- Ens apareix un error perquè el camp id_treball té una restricció UNIQUE, i el
-- valor que volem inserir ja existeix a la taula Factures. 

/*
7. Augmenta un 10 % l’import de totes les feines que encara no estan
finalitzades.
*/

UPDATE Treballs
SET preu = preu*1.1
WHERE finalitzat = 0;

SELECT * FROM Treballs
WHERE finalitzat = 0;

/*
8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon
699999999.
*/

UPDATE Clients
SET telefon = 699999999
WHERE nom LIKE 'Maria Soler';

SELECT * FROM Clients
WHERE nom LIKE 'Maria Soler';

/*
9. Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el
comentari Pagada amb targeta (actualitzat). No s’ha d’eliminar el comentari
anterior. S’hi ha d’afegir aquest.
*/

UPDATE Factures
SET pagada = 1, comentaris = CONCAT_WS(' ', comentaris, 'Pagada amb targeta.') 
WHERE id_factura = 2;

SELECT * FROM Factures
WHERE id_factura = 2;

/*
10. Eliminar el client amb codi 1.
*/

DELETE FROM Clients
WHERE id_client = 1;

SELECT * FROM Clients;

-- No es pot eliminar el client perquè està referenciat a les altres taules
-- mitjançant una clau forana (FOREIGN KEY). Això impedeix l’eliminació per
-- mantenir la integritat de les dades.

/*
11. Elimina totes les factures que ja constin com a pagades.
*/

DELETE FROM Factures
WHERE pagada = 1;

SELECT * FROM Factures;

/*
12. Esborra el vehicle amb matrícula 7777ZZZ.
*/

DELETE FROM Vehicles
WHERE matricula LIKE '7777ZZZ';

SELECT * FROM Vehicles;

