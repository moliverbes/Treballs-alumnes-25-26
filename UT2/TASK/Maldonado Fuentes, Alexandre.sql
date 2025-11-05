-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades: 
-- ●Nom complet: Núria Vidal ● Telèfon: 611112223 ● Correu: nuria.vidal@example.com ● Adreça: C/ Balmes 10, Manresa ● Client actiu: Sí
SELECT * FROM Clients;
INSERT INTO Clients (id_client, nom, telefon, correu, adreca, client_actiu)
VALUE
(4,'Núria Vidal',611112223,'nuria.vidal@example.com','C/ Balmes 10, Manresa',1);

-- 2. Afegeix un altre client amb aquestes dades:
-- ● Nom: Toni Ferrer ● Telèfon: 612345678 ● Correu: toni.ferrerp@example.com ● Adreça: Av. Falsa 123, Manresa ● Actiu: Sí
INSERT INTO Clients (nom, telefon, correu, adreca, client_actiu)
VALUE
('Toni Ferrer',612345678,'toni.ferrer@example.com','AV. Falsa 123, Manresa',1);
DESCRIBE Clients;
-- No pot haber un telefon duplicat.alte


-- 3. Afegeix un nou vehicle al registre, indicant: ● Matrícula: 7777ZZZ ● Marca: Renault ● Propietari: Maria Soler
SELECT * FROM Vehicles 
WHERE id_client = 2;
INSERT INTO Vehicles (matricula, marca, id_client)
VALUE 
('7777ZZZ', 'Renault', 2);
DESCRIBE Vehicles;
-- 4. Afegeix un nou client sense indicar el seu nom, amb les dades següents:
--  ● Nom: Joana Mateu ● Telèfon: 600000000 ● Correu: joana.mateu@example.com ● Adreça: C/ Sense Nom, 1 ● Actiu: Sí
-- No es posible ja que el nom no pot ser null
SELECT * FROM Clients;
INSERT INTO Clients (nom,telefon,correu,adreca,client_actiu)
VALUE 
('Joana Mateu',600000000,'joana.mateu@example.com','C/ Sense Nom, 1',1);

-- 5. Insereix dues feines noves en una sola operació:
-- 1. Feina 1 a. Vehicle amb matrícula 9012GHI b. descripció Alineació direcció c. inici el 22/10/2025 a les 09:30 d. import 45.00 € e. pendent de finalitzar.
-- 2. Feina 2 a. Vehicle amb matrícula 5678DEF b. descripció Canvi bugies c. Inici el 22/10/2025 a les 10:15 d. import 30.00 € e. pendent de finalitzar.
SELECT * FROM Treballs;
SELECT * FROM Vehicles;
INSERT INTO Treballs (id_vehicle,descripcio, data_inici, hora_inici, preu,finalitzat)
VALUE 
(3,'Alineació direcció','2025-10-22','09:30',45.00,0),
(2,'Canvi bugies','2025-10-22','10:15',30.00,0);


-- 6. Afegeix una nova factura: ● per a la feina amb codi 2 ● Data d’emissió: el dia actual 
-- ● Total: 180.00 € ● Estat de pagament: No pagada ● Comentaris: Revisió general i pneumàtics
SELECT * FROM Factures;
INSERT INTO Factures (id_treball,data_emissio,total,pagada,comentaris)
VALUE 
(2,CURRENT_TIMESTAMP,180.00,'0','Revisió general i pneumàtics');
-- -----No se pot ja que el codi de id_treball que en aquest cas haruia de ser dos (2) esta duplicat.

-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades.

SELECT * FROM Treballs;

UPDATE Treballs SET preu = preu*1.10
WHERE finalitzat = 0 ;

-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.

SELECT * FROM Clients;
UPDATE Clients 
SET telefon = 699999999
WHERE id_client=2;

-- 9. Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari Pagada amb targeta (actualitzat). 
-- No s’ha d’eliminar el comentari anterior. S’hi ha d’afegir aquest.
SELECT * FROM Factures;
UPDATE Factures
SET pagada = 1 AND comentaris = 'Pagada amb targeta'
WHERE id_factura = 2; 

-- 10. Eliminar el client amb codi 1.
DELETE FROM Clients
WHERE id_client=1;
SELECT * FROM Clients;
-- No puc eliminar el Client amb el codi numero 1 perque se haria de transformar totes les taules.
-- 11. Elimina totes les factures que ja constin com a pagades.
DELETE FROM Factures 
WHERE pagada = 1;
SELECT * FROM Factures;
-- 12. Esborra el vehicle amb matrícula 7777ZZZ.
SELECT * FROM Vehicles;
DELETE FROM Vehicles
WHERE id_vehicle = 5;