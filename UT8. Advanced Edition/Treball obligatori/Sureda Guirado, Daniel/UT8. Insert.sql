-- 2 Inserció Manual de dades

insert into especialitats values (
null, 'Dermatòleg');
insert into especialitats values(
null, 'Oculista');
insert into especialitats values(
null, 'Dentista');

select * from especialitats;

-- 3 metges associats
insert into metges values(
null, 'Yan', 'Moreno', '260158399','yan@gmail.com', 1);

insert into metges values(
null, 'Biel', 'Ferrer', '591256702', 'biel@gmail.com', 2);

insert into metges values(
null, 'Rein', 'Hardt', '491023586', 'juan@gmail.com', 3);

 -- 5 pacients 
insert into pacient values(
null, 'Xisco', 'Packet', '2000-05-25', '325679345', 'xisco@gmail.com', 'C/New queen street');
insert into pacient values(
null, 'Oliver', 'Benji', '2001-04-12', '145637800', 'oliver@gmail.com', 'Av.Samoa');
insert into pacient values(
null, 'Ash', 'Ketchum', '2005-11-11', '224669049', 'ash@gmail.com', 'Av.KingsRow');
insert into pacient values(
null, 'Mark', 'Evans', '2006-09-25', '331890453', 'mark@gmail.com', 'Av.Paraiso');
insert into pacient values(
null, 'Coco', 'Melón', '1998-04-24', '671456367', 'coco@gmail.com', 'C/Carrer67');

-- 3 medicaments
insert into medicaments values(
null,'Chocolate','50 g','Bayern','25');
insert into medicaments values(
null,'Omeprazol','1 g', 'Madrid','10');
insert into medicaments values(
null,'Naproxeno','20 mg','Aquí','37');

select * from medicaments;

insert into cites values(
null, 2,1,'2026-02-21','16:00:00','Completada');
insert into cites values(
null, 1,2,'2026-05-21','12:30:00','Pendent');
insert into cites values (
null, 3,3 ,'2026-01-12','08:00:00','Cancel·lada');

select * from cites;
select * from metges;
select * from pacient;
select * from prescripcions;
 -- Part 3 Variables
 
select id_pacient into @coco
from pacient
where email= 'coco@gmail.com';

select id_metge into @rein
from metges 
where email= 'juan@gmail.com';

insert into cites values(
null, @coco, @rein,'2026-08-01','14:00:00','Pendent');

select * from cites;

-- Part 4 last_insert_id

insert into pacient values(
null, 'patricio','estrella','1999-07-23','259148649','patricio@gmail.com','Roca bajo el mar');

insert into cites values(
null, last_insert_id(),1,'2026-05-26','08:00:00','Pendent');

-- Part 5 transaccions

start transaction;

insert into cites values(
null,6, 2,'2026-11-24','10:00:00','Cancel·lada');

set @id_cita = last_insert_id();

insert into prescripcions values(
null,@id_cita, 2,3,'Una cada dia');

update cites
set estat = 'Completada'
where id_cita = @id_cita;

commit;

-- PART 6 UPDATE

select * from pacient;

update pacient
set telefon = '347823233'
where id_pacient = 1;

select * from cites;

update cites 
set data_cita = '2026-11-18'
where id_cita = 2;

select * from medicaments;

update medicaments 
set dosi = '10mg'
where id_medicament = 2;

-- Sentències DELETE

select * from cites;

delete from cites
where id_cita= 3;

select * from prescripcions ;

delete from medicaments 
where id_medicament = 3;

-- Part 8 Càrrega de dades d'un CSV amb LOAD DATA

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pacients2.csv'
INTO TABLE pacient
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from pacients;

-- Part 9 Càrrega amb JSON
insert into medicaments (id_medicament, nom, dosi, fabricant,stock)
select id_medicament, nom, dosi, fabricant, stock
FROM JSON_TABLE(
convert (
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/medicaments2.json')
    using utf8mb4),
    '$[*]' COLUMNS (
       id_medicament int PATH '$.id_medicament',
	nom varchar(100) path '$.nom',
    dosi varchar(50) path '$.dosi',
    fabricant varchar(100) path'$.fabricant',
    stock int path '$.stock'
)
) as t;

select * from medicaments;

-- Part 10 CSVConvert

INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,10,'2026-06-01','09:30:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (2,14,'2026-06-01','11:15:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (3,10,'2026-06-02','10:00:00','Completada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (4,22,'2026-06-03','17:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (5,14,'2026-06-04','12:30:00','Cancel·lada');





