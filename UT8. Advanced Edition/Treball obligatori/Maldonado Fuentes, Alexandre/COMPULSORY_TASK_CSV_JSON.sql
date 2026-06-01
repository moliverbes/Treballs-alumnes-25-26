/*PART 8 CÀRREGA DE DADES DES D'UN CSV AMB LOAD DATA*/

LOAD DATA INFILE 'C:/MYSQL/Paciente_antonio.csv'
INTO TABLE pacients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT * FROM pacients;

/*PART 9 CÀRREGA DE DADES D'UN JSON */

INSERT INTO medicaments (id_medicament,nom,dosi,fabricant,stock)
SELECT id_medicament,nom,dosi,fabricant,stock
FROM JSON_TABLE(
    CONVERT (
        LOAD_FILE('C:/MYSQL/Medicamentos.json')
        USING utf8mb4),
    '$[*]' COLUMNS (
		id_medicament INT PATH '$.id_medicament',
        nom VARCHAR(20) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock'
    )
) AS t;

/*PART 10 ÚS DE CSVCONVERT*/

SELECT * FROM cites;

INSERT INTO cites(id_cita,id_pacient,id_metge,data_cita,hora_cita,estat) VALUES
 (9,2,3,'2028-06-23','14:30','1')
,(10,5,1,'2028-06-24','09:15','2')
,(11,9,2,'2028-06-25','11:45','1')
,(12,3,3,'2028-06-26','16:00','3')
,(13,11,1,'2028-06-27','08:30','1');



