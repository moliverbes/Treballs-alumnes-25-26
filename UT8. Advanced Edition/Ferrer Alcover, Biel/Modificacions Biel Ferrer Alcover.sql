
-- PART 2
insert  into especialitats
values (null, 'Dentiste'),
(null, 'Dermatolog '),
(null, 'Psicoleg');

insert into metges
values(null, 'Juan', 'Toad', '234232323', 1),
(null, 'Gengi', 'Ferrer', '556232323', 2),
(null, 'Maria', 'DB', '234205393', 3);

insert into pacients 
values (null, 'Rayo', 'McQueen', '2006-05-07', '666666666', 'McQueen@gmail.com', 'Ruta66'),
(null, 'Mario', 'Roitg', '2001-07-09', '555555555', 'Roitg@gmail.com', 'Madrit'),
(null, 'Tomeu', 'Roitg', '1961-11-09', '283458719', 'Tomeu@gmail.com', 'Peru'),
(null, 'Miquel', 'Torres', '1991-12-04', '603858719', 'Miquel@gmail.com', 'Lloseta'),
(null, 'Xisca', 'Reus', '2011-1-3', '603857201', 'Reus@gmail.com', 'Biniama');

insert into medicaments
values (null, 'Concerta', '50ml','Janssen', '6'),
(null, 'Paracetamol', '26ml','Heisembert', '30'),
(null, 'Estimulant', '6ml','AnaSL', '17');

insert into cites
values (null, 1,3, '2026-05-19', '21:37:00','Pendent'),
(null, 2,1, '2025-05-19', '16:37:00','Completada'),
(null, 5,2, '2015-06-03', '06:59:00','Cancel·lada');


-- PART 3
select id_pacient into @Rayo from pacients
where id_pacient = 1;
select id_metge into @Juan from metges
where id_metge = 1;
insert into cites
values (null,@Rayo,@Juan,'2024-07-19','12:15:00', 'Completada');
-- PART 4

insert into pacients 
values (null, 'Barack ', 'Obama', '1961-08-02', '6391932', 'Barack@gmail.com', 'Estats Separats');
insert into cites
values (null,last_insert_id(),2,'2026-01-07','16:40:00', 'Pendent');

select * from cites;
select * from pacients;


-- PART 5
START TRANSACTION;
INSERT INTO cites
VALUES(NULL,1,1,'2023-02-11','21:45:00','Pendent');

SET @id_cita = LAST_INSERT_ID();

INSERT INTO prescripcions
VALUES(NULL,@id_cita,1,1,'Tomar cada uno cada ocho horas');

UPDATE cites SET estat = 'Completada'
WHERE id_cita = @id_cita;
COMMIT;

-- PART 6
select * from pacients
where id_pacient = 2;

update pacients set telefon = '123456789' 
where id_pacient = 2;
--
select * from cites
where id_cita = 2;

update cites set data_ciata = '2025-03-11'
where id_cita = 2;
--
select * from medicaments
where id_medicament = 3;
update medicaments set nom = 'Ibuprofeno'
where id_medicament = 3;

-- PART 7
select * from cites
where estat = 'Cancel·lada';
delete  from  cites 
where id_cita = 3;
-- 
select * from prescripcions;
select * from medicaments;

delete  from  medicaments 
where id_medicament = 3;

-- PART 8

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Part8.csv'
INTO TABLE pacients
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_pacient, nom, cognoms, data_naixement, telefon, email, adreca)
SET id_pacient = NULL;

-- PART 9

INSERT INTO medicaments (nom, dosi, fabricant, stock)
SELECT nom, dosi, fabricant, stock
FROM JSON_TABLE(
    CONVERT(
        LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/medicaments.json')
        USING utf8mb4
    ),
    '$[*]' COLUMNS (
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS t;


-- PART 10


-- PART 10
INSERT INTO cites(id_pacient,id_metge,data_ciata,hora_cita) VALUES (1,1,'2026-06-01','09:30:00');
INSERT INTO cites(id_pacient,id_metge,data_ciata,hora_cita) VALUES (1,2,'2026-06-01','10:15:00');
INSERT INTO cites(id_pacient,id_metge,data_ciata,hora_cita) VALUES (6,2,'2026-06-02','11:00:00');
INSERT INTO cites(id_pacient,id_metge,data_ciata,hora_cita) VALUES (6,1,'2026-06-02','12:30:00');
INSERT INTO cites(id_pacient,id_metge,data_ciata,hora_cita) VALUES (1,1,'2026-06-03','16:00:00');