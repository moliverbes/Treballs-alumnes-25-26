/* EXERCICI 8 Càrrega des de CSV */
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/asesinos_dbd.csv'
INTO TABLE pacients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(nom, cognoms, data_naixement, telefon, email, adreca);

SELECT id_pacient, nom, cognoms, email, adreca 
FROM pacients 
WHERE telefon = '971666666';

/* EXERCICI 9 - Càrrega des de JSON */
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
) AS jt;
SELECT * FROM medicaments;

/* EXERCICI 10 CSV CONVERT */
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,1,'2026-06-03','09:30:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (2,2,'2026-06-03','10:15:00','Completada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (3,3,'2026-06-04','11:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (4,1,'2026-06-05','16:45:00','Cancel·lada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (5,4,'2026-06-06','08:20:00','Pendent');
SELECT * FROM cites;