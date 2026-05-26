-- Part 8
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Part8.csv'
INTO TABLE pacients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Part 9
INSERT INTO medicaments (id_medicament, nom, dosi, fabricant, stock)
SELECT id_medicament, nom, dosi, fabricant, stock
FROM JSON_TABLE(
    CONVERT(
        LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Part9.json')
        USING utf8mb4
    ),
    '$[*]' COLUMNS (
        id_medicament INT PATH '$.id_medicament',
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS t;

-- Part 10
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,2,'2026-06-10','09:00:00','Completada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (3,1,'2026-06-11','10:30:00','Cancel·lada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,3,'2026-06-12','11:15:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (5,2,'2026-06-13','16:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (4,3,'2026-06-14','18:45:00','Completada');