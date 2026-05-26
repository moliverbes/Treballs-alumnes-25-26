-- Part 8. Càrrega de dades des d’un CSV amb LOAD DATA

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nous_pacients.csv'
INTO TABLE pacients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(nom, cognoms, data_naixement, telefon, email, adreca);

-- Part 9. Càrrega de dades des d’un JSON
INSERT INTO medicaments (nom, dosi, fabricant, stock)
SELECT nom, dosi, fabricant, stock
FROM JSON_TABLE(
   CONVERT(
    LOAD_FILE('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\nous_medicaments.json')
    USING utf8mb4),
    '$[*]' COLUMNS (
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS j;
-- Part 10. Ús de CSVConvert
-- Arxiu sense convertir
id_pacient,id_metge,data_cita,hora_cita,estat
1,2,"2026-07-01","09:00:00","Pendent"
2,3,"2026-07-01","10:00:00","Pendent"
3,1,"2026-07-02","11:30:00","Pendent"
4,2,"2026-07-02","16:00:00","Pendent"
5,3,"2026-07-03","17:15:00","Pendent"

-- Arxiu pasar per CSVconvert
INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) VALUES 
(1, 2, '2026-07-01', '09:00:00', 'Pendent'),
(2, 3, '2026-07-01', '10:00:00', 'Pendent'),
(3, 1, '2026-07-02', '11:30:00', 'Pendent'),
(4, 2, '2026-07-02', '16:00:00', 'Pendent'),
(5, 3, '2026-07-03', '17:15:00', 'Pendent');

