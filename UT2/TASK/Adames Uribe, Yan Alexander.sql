-- 1) Afegeix un nou registre al fitxer de clients amb totes les dades:
--    Nom complet: Núria Vidal
--    Telèfon: 611112223
--    Correu: nuria.vidal@example.com
--    Adreça: C/ Balmes 10, Manresa
--    Client actiu: Sí
INSERT INTO clients(nom, telefon, correu, adreca)
VALUES ("Núria Vidal","611112223","nuria.vidal@example.com","C/ Balmes 10, Manresa");

-- 2) Afegeix un altre client amb aquestes dades:
--    Nom: Toni Ferrer
--    Telèfon: 612345678
--    Correu: toni.ferrerp@example.com
--    Adreça: Av. Falsa 123, Manresa
--    Actiu: Sí
INSERT INTO clients(nom, telefon, correu, adreca)
VALUES ("Toni Ferrer","612345678","toni.ferrerp@example.com","Av. Falsa 123, Manresa");
-- Dona error perque el telefón està duplicat.

-- 3) Afegeix un nou vehicle al registre, indicant:
--    Matrícula: 7777ZZZ
--    Marca: Renault
--    Propietari: Maria Soler
INSERT INTO vehicles(matricula, marca, id_client)
VALUES ("7777ZZZ","Renault",2);

-- 4) Afegeix un nou client sense indicar el seu nom, amb les dades següents:
--    Nom: Joana Mateu
--    Telèfon: 600000000
--    Correu: joana.mateu@example.com
--    Adreça: C/ Sense Nom, 1
--    Actiu: Sí
INSERT INTO clients(nom, telefon, correu, adreca)
VALUES ("Joana Mateu","600000000","joana.mateu@example.com","C/ Sense Nom, 1");

-- 5) Insereix dues feines noves en una sola operació:
--    Feina 1:
--      Vehicle matrícula: 9012GHI
--      Descripció: Alineació direcció
--      Inici: 22/10/2025 09:30
--      Import: 45.00 €
--      Estat: pendent de finalitzar
--    Feina 2:
--      Vehicle matrícula: 5678DEF
--      Descripció: Canvi bugies
--      Inici: 22/10/2025 10:15
--      Import: 30.00 €
--      Estat: pendent de finalitzar
INSERT INTO treballs(id_vehicle, descripcio, data_inici, hora_inici, preu)
VALUES (3,"Alineació direcció","22/10/2025","09:30",45.00),
	(2,"Canvi bugies","22/10/2025","10:15",30.00);
-- Dona error perque la data no esta en el format corresponent.

-- 6) Afegeix una nova factura:
--    Per a la feina amb codi 2
--    Data d’emissió: (dia actual)
--    Total: 180.00 €
--    Estat de pagament: No pagada
--    Comentaris: Revisió general i pneumàtics
INSERT INTO factures(id_treball, total, comentaris)
VALUES (2,180.00,"Revisió general i pneumàtics");
-- Dona error estaria duplicant el id_treball amb codi 2 y la columna es UNIQUE.

-- 7) Augmenta un 10% l’import de totes les feines que encara no estan finalitzades.
UPDATE treballs
SET preu= preu*1.10
WHERE finalitzat= 0;

-- 8) Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.
UPDATE clients
SET telefon= "699999999"
WHERE nom LIKE "Maria Soler";

-- 9) Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari:
--    "Pagada amb targeta (actualitzat)". No s’ha d’eliminar el comentari anterior; s’ha d’afegir aquest.
UPDATE factures
SET pagada= 1, comentaris= "Pagada amb targeta (actualitzat)"
WHERE id_factura= 2;

-- 10) Eliminar el client amb codi 1.
DELETE FROM clients
WHERE id_client= 1;
-- Dona error perque id_client = 1 té vehicles associats a la taula vehicles ya que es una FK

-- 11) Elimina totes les factures que ja constin com a pagades.
DELETE FROM factures
WHERE pagada= 1;

-- 12) Esborra el vehicle amb matrícula 7777ZZZ.
DELETE FROM vehicles
WHERE matricula LIKE "7777ZZZ";