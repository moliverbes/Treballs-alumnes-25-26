

-- archiu csv
SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nous.csv"  
INTO TABLE pacients
FIELDS TERMINATED BY ','      
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(nom, cognoms, data_naixament, telefon, email, adreca);

-- archiu json
INSERT INTO medicaments (nom, dosi, fabricant, stock)
SELECT nom, dosi, fabricant, stock
FROM JSON_TABLE(
    CONVERT(
        LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nous_medicaments.json')
        USING utf8mb4
    ),
    '$[*]' COLUMNS (
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS j;

--  amb CSVConvert
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES
 (1,2,'2026-07-15','09:30:00','Pendent')
,(2,3,'2026-07-16','10:45:00','Pendent')
,(3,1,'2026-07-17','11:15:00','Pendent')
,(4,2,'2026-07-18','12:00:00','Pendent')
,(5,3,'2026-07-19','13:30:00','Pendent');
