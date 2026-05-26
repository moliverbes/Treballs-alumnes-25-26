-- Parte 8 CSV --
LOAD DATA INFILE 'C:/SQL/pacients.csv'
INTO TABLE pacients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(nom, cognoms, data_naixement, telefon, email, adreca);

-- Parte 9 JSON --
INSERT INTO medicaments (nom, dosi, fabricant, stock)
SELECT nom, dosi, fabricant, stock
FROM JSON_TABLE(
    CONVERT(
        LOAD_FILE('/var/lib/mysql-files/medicaments.json') 
        USING utf8mb4
    ),
    '$[*]' COLUMNS (
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS t;

-- Parte 10 uso de csvconvert --
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,2,'2026-06-20','10:30:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (2,3,'2026-06-20','11:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (4,1,'2026-06-21','09:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (5,2,'2026-06-21','12:30:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,1,'2026-06-22','16:15:00','Pendent');
