-- Part 2
INSERT INTO especialitats 
VALUES (NULL, 'Oculista'),
(NULL, 'Dentista'),
(NULL, 'Dermatòleg');

SELECT * FROM especialitats;

INSERT INTO metges 
VALUES (NULL, 'Biel', 'Ferrer', '543679075', 'bielito@gmail.com', 1),
(NULL, 'Paco', 'Estancio', '543678777', 'paquito@gmail.com', 2),
(NULL, 'John', 'Pork', '543222777', 'guasap@gmail.com', 3);

INSERT INTO pacients
VALUES (NULL, 'Xisco', 'Packet', '2000-01-01', '092345123', 'xisquillo@gmail.com', 'C/ Junkertown 13'),
(NULL, 'Widow', 'Maker', '2000-02-02', '075545123', 'widow@gmail.com', 'C/ Samoa 34'),
(NULL, 'Mei', 'Fresca', '2000-03-03', '090345113', 'mei@gmail.com', 'C/ Península antártica 13'),
(NULL, 'Zen', 'Nyata', '2000-04-04', '028855346', 'zen@gmail.com', 'C/ Runasapi 78'),
(NULL, 'Sierra', 'Melo', '2000-05-05', '092340886', 'sierra@gmail.com', 'C/ Paraíso 2');

INSERT INTO medicaments
VALUES (NULL, 'Paracetamol', '500 mg', 'Perú', 10),
(NULL, 'Dormilina', '250 mg', 'Bellingham', 20),
(NULL, 'Diclofenaco', '1000 mg ', 'Aquí', 20);

INSERT INTO cites
VALUES (NULL, 3, 2, '2026-05-21', '12:00:00', 'Pendent'),
(NULL, 1, 3, '2026-05-25', '15:00:00', 'Cancel·lada'),
(NULL, 5, 1, '2026-05-10', '14:00:00', 'Completada');

-- Part 3
SELECT id_pacient INTO @xisco
FROM pacients
WHERE email = 'xisquillo@gmail.com';

SELECT id_metge INTO @paco
FROM metges
WHERE email = 'paquito@gmail.com';

INSERT INTO cites
VALUES (NULL, @xisco, @paco, '2026-06-01', '09:00:00', 'Pendent');

SELECT * FROM cites;

-- Part 4
INSERT INTO pacients
VALUES (NULL, 'Bob', 'Esponja', '1999-01-01', '666999777', 'esponjita@gmail.com', 'C/ Piña debajo del mar');

INSERT INTO cites
VALUES (NULL, last_insert_id(), 2, '2026-10-10', '10:00:0', 'Pendent');

-- Part 5
START TRANSACTION;

INSERT INTO cites
VALUES(NULL, 6, 1, '2027-02-01', '14:00:00', 'Cancel·lada');

SET @id_cita = last_insert_id();

INSERT INTO prescripcions 
VALUES(NULL, @id_cita, 2, 3, 'Una al día');

UPDATE cites
SET estat = 'Completada'
WHERE id_cita = @id_cita;

COMMIT;

-- Part 6
SELECT * FROM pacients;

UPDATE pacients
SET telefon = '223366441'
WHERE id_pacient = 1;

SELECT * FROM cites;

UPDATE cites
SET hora_cita = '15:30:00'
WHERE id_cita = 2;

SELECT * FROM medicaments;

UPDATE medicaments
SET dosi = '750 mg'
WHERE id_medicament = 1;

-- Part 7
SELECT * FROM cites;

DELETE FROM cites
WHERE id_cita = 2;

SELECT * FROM prescripcions;

SELECT * FROM medicaments;

DELETE FROM medicaments
WHERE id_medicament = 3;

-- Part 8
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pacients2.csv'
INTO TABLE pacients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM pacients;

-- Part 9
INSERT INTO medicaments (id_medicament, nom, dosi, fabricant, stock)
SELECT id_medicament, nom, dosi, fabricant, stock
FROM JSON_TABLE(
convert( LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/medicaments2.json')
    USING utf8mb4),
    '$[*]' COLUMNS (
		id_medicament INT PATH '$.id_medicament',
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS t;

SELECT * FROM medicaments;

-- Part 10
DESCRIBE cites;

INSERT INTO cites(id_cita,id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (NULL,1,10,'2026-06-01','09:30:00','Pendent');
INSERT INTO cites(id_cita,id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (NULL,2,11,'2026-06-01','11:00:00','Pendent');
INSERT INTO cites(id_cita,id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (NULL,3,10,'2026-06-02','10:15:00','Completada');
INSERT INTO cites(id_cita,id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (NULL,4,12,'2026-06-02','16:45:00','Cancel·lada');
INSERT INTO cites(id_cita,id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (NULL,5,11,'2026-06-03','12:00:00','Pendent');





