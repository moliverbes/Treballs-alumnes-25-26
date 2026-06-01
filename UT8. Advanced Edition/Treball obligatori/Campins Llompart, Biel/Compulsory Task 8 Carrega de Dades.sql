-- Part 8. Càrrega de dades des d’un CSV amb LOAD DATA
SELECT * FROM pacients;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pacients.csv'
INTO TABLE pacients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Part 9. Càrrega de dades des d’un JSON
SELECT * FROM medicaments;
INSERT INTO medicaments (id_medicament, nom, dosi, fabricant, stock)
SELECT *
FROM JSON_TABLE(
    CONVERT(
        LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/medicaments.json')
        USING utf8mb4
    ),
    '$[*]' COLUMNS (
        id_medicament INT PATH '$.id_medicament',
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(100) PATH '$.dosi',
        fabricant VARCHAR(20) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS t;

-- Part 10. Ús de CSVConvert
