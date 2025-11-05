-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades: Nom complet: Núria Vidal Telèfon: 611112223  Correu: nuria.vidal@example.com Adreça: C/ Balmes 10, Manresa  Client actiu: Sí
insert into clients (nom, telefon, correu, adreca)
values ("Núria Vidal", 611112223, "nuria.vidal@example.com", "C/ Balmes 10, Manresa");
select * from clients;

-- 2. Afegeix un altre client amb aquestes dades: Nom: Toni Ferrer Telèfon: 612345678 Correu: toni.ferrerp@example.com Adreça: Av. Falsa 123, Manresa Actiu: Sí

-- No funciona per que hi ha un telefon duplicat
insert into clients (nom, telefon, correu, adreca)
values ("Toni Ferrer", 612345678, "toni.ferrerp@example.com", "Av. Falsa 123, Manresa");


-- 3. Afegeix un nou vehicle al registre, indicant: Matrícula: 7777ZZZ Marca: Renault Propietari: Maria Soler

insert into vehicles (matricula, marca, id_client)
values ("7777ZZZ", "Renault" , "Maria Soler");
select * from vehicles;

-- 4. Afegeix un nou client sense indicar el seu nom, amb les dades següents: Nom: Joana Mateu Telèfon: 600000000  Correu: joana.mateu@example.com  Adreça: C/ Sense Nom, 1  Actiu: Sí

insert into clients (nom, telefon, correu, adreca)
values ("Joana Mateu", 600000000, "joana.mateu@example.com", "C/ Sense Nom, 1" );

-- 5. Insereix dues feines noves en una sola operació: 1. Feina 1  Vehicle amb matrícula 9012GHI  descripció Alineació direcció  inici el 22/10/2025 a les 09:30 d. import 45.00 € e. pendent de finalitzar. 2. Feina 2 a. Vehicle amb matrícula 5678DEF b. descripció Canvi bugiesc. Inici el 22/10/2025 a les 10:15 d. import 30.00 € e. pendent de finalitzar.

-- No es pot inserir cap dels dos per el format de la data
insert into treballs (id_vehicle, descripcio, data_inici, hora_inici, preu)
values (3, "Alineació direcció", "22/10/2025", "09:30", 45.00 ), 
(2, "Canvi bugiesc.", "22/10/2025", "10:15", 30.00 );

-- 6. Afegeix una nova factura: per a la feina amb codi 2 Data d’emissió: el dia actual Total: 180.00 € Estat de pagament: No pagada Comentaris: Revisió general i pneumàtics

-- no es pot fer ja que ja l'entitat 2 domes pot tenir 1 factura
insert into factures (id_treball, total, pagada, comentaris )
values (2, 180.00, 0, "Revisió general i pneumàtics");

-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades.
update treballs
set preu = preu * 1.10
WHERE finalitzat= 0;


-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.
update clients 
set telefon = 699999999
where nom like "Maria Soler";

-- 9. Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari Pagada amb targeta (actualitzat).
-- No s’ha d’eliminar el comentari anterior. S’hi ha d’afegir aquest.

-- 
update factures 
set pagada = 1,  comentaris =  concat(comentaris, " Pagada amb targeta (actualitzat)")
where id_factura = 2;


-- 10. Eliminar el client amb codi 1.
-- No es pot elimi ja que el id_client es una Foreign Key
delete from clients 
where id_client = 1;

-- 11. Elimina totes les factures que ja constin com a pagades.
delete from factures
where pagada = 1;

-- 12. Esborra el vehicle amb matrícula 7777ZZZ
delete from vehicles
where matricula like "7777ZZZ" ;