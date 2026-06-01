-- Part 8

LOAD DATA INFILE 'C:/SQL server/Part 8 csv.csv'
INTO TABLE pacients
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(nom, cognoms, data_naixement, telefon, email, adreca);

-- Part 9

INSERT INTO medicaments (nom, dosi, fabricant, stock)
SELECT nom, dosi, fabricant, stock
FROM JSON_TABLE(
	CONVERT (
		LOAD_FILE('C:/SQL server/Part 9 json.json') 
		USING utf8mb4),
	'$[*]' COLUMNS (
        nom VARCHAR(100) PATH '$.nom',
        dosi VARCHAR(50) PATH '$.dosi',
        fabricant VARCHAR(100) PATH '$.fabricant',
        stock INT PATH '$.stock')
) AS t;

-- Part 10

INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,2,'2026-08-01','10:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (2,3,'2026-08-02','11:30:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (3,1,'2026-08-03','09:15:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (4,2,'2026-08-04','12:45:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (5,3,'2026-08-05','16:20:00','Pendent');