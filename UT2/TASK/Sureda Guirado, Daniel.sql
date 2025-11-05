-- 1. Afegeix un nou registre al fitxer de clients amb totes les dades:
-- Nom complet: Núria Vidal
-- Telèfon: 611112223
-- Correu: nuria.vidal@example.com
-- Adreça: C/ Balmes 10, Manresa
-- Client actiu: Sí
insert into  clients (nom,telefon,correu,adreca)
values ("Núria Vidal",611112223,"nuria.vidal@example.com","C/ Balmes 10, Manresa");
select * from clients;

-- 2. Afegeix un altre client amb aquestes dades:
-- Nom: Toni Ferrer
-- Telèfon: 612345678
-- Correu: toni.ferrerp@example.com
-- Adreça: Av. Falsa 123, Manresa
-- Actiu: Sí

-- No es pot ficar un telefon duplicat
insert into  clients (nom,telefon,correu,adreca)
values ("Toni Ferrer",612345678,"toni.ferrerp@example.com","Av. Falsa 123, Manresa");
select * from clients;

-- 3. Afegeix un nou vehicle al registre, indicant:
-- Matrícula: 7777ZZZ
-- Marca: Renault
-- Propietari: Maria Soler
insert into  vehicles (id_client,matricula,marca)
values (2,"7777ZZZ","Renault" );
select * from vehicles;

-- 4. Afegeix un nou client amb les dades següents: Nom: Joana Mateu Telèfon: 600000000  Correu: joana.mateu@example.com  Adreça: C/ Sense Nom, 1  Actiu: Sí
insert into clients (nom,telefon,correu,adreca)
values ("Joana Mateu",600000000, "joana.mateu@example.com","C/ Sense Nom, 1" );
select * from clients;

-- 5. Insereix dues feines noves en una sola operació: 
-- 1. Feina 1  Vehicle amb matrícula 9012GHI  descripció Alineació direcció  inici el 22/10/2025 a les 09:30 d. import 45.00 € e. pendent de finalitzar.
-- 2. Feina 2 a. Vehicle amb matrícula 5678DEF b. descripció Canvi bugiesc. Inici el 22/10/2025 a les 10:15 d. import 30.00 € e. pendent de finalitzar.

-- El format de dades no és igual
insert into  treballs (descripcio, data_inici, hora_inici, preu)
values ("Alineació direcció", "22/10/2025", "09:30", 45.00), 
("Canvi bugiesc.", "22/10/2025", "10:15", 30.00);
select * from treballs;

-- 6. Afegeix una nova factura: per a la feina amb codi 2 Data d’emissió: el dia actual Total: 180.00 € Estat de pagament: No pagada Comentaris: Revisió general i pneumàtics

-- No pot tenir més d'una factura 
insert into  factures (id_treball,total,pagada,comentaris )
values (2, 180.00, 0,"Revisió general i pneumàtics");

select * from factures;

-- 7. Augmenta un 10 % l’import de totes les feines que encara no estan finalitzades.
update treballs
set preu = preu * 0.10
where finalitzat = 0;
select * from treballs;

-- 8. Modifica el registre de la clienta Maria Soler perquè tingui el telèfon 699999999.
update clients 
set telefon = 699999999
where nom like 'Maria Soler';
select * from clients;

-- 9. Actualitza la factura amb codi 2 per marcar-la com a pagada i afegeix el comentari Pagada amb targeta (actualitzat). No s’ha d’eliminar el comentari
-- anterior. S’hi ha d’afegir aquest.
update factures
set pagada = 1,
comentaris = CONCAT(comentaris, ' Pagada amb targeta (actualitzat)')
where id_factura = 2;
select * from factures;

-- 10. Eliminar el client amb codi 1.
-- No es pot eliminar ja que intentam eliminar una clau foràna
delete from clients 
WHERE id_client = 1;
select * from clients;

-- 11. Elimina totes les factures que ja constin com a pagades.
delete from factures
where pagada = 1;
select * from factures;

-- 12. Esborra el vehicle amb matrícula 7777ZZZ
delete from vehicles
where matricula = '7777ZZZ';
select * from vehicles;