-- PART CSV, JSON y csvconvert
-- PART 8 CSV
SELECT * FROM pacients ;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Arnau_pacients.csv' 
INTO TABLE pacients
FIELDS TERMINATED BY ','
IGNORE 1 LINES;
-- PART 9 JSON
SELECT * FROM medicaments;
INSERT INTO medicaments (id_medicament, nom, dosi, fabricant, stock )
SELECT id_medicament, nom, dosi, fabricant, stock 
FROM JSON_TABLE(
    CONVERT (
        LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/8.9Arnau_medicaments.json')
        USING utf8mb4),
    '$[*]' COLUMNS (
		id_medicament INT PATH '$.id_medicament' ,
                            nom VARCHAR(100) PATH '$.nom',
						    dosi VARCHAR(50)  PATH '$.dosi',
                            fabricant  VARCHAR(100) PATH '$.fabricant',
                            stock INT PATH '$.stock'
    )
) AS t;

-- PART 10 CSVCONVERT
CREATE TABLE citesCSV(
   id_pacient INTEGER  NOT NULL PRIMARY KEY 
  ,id_metge   INTEGER  NOT NULL
  ,data_cita  DATE  NOT NULL
  ,hora_cita  VARCHAR(8) NOT NULL
  ,estat      VARCHAR(11) NOT NULL
);
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (1,1,'2024-12-20','09:00:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (2,2,'2024-12-20','10:30:00','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (3,3,'2024-12-21','11:15:00','Completada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (4,1,'2024-12-22','12:00:00','Cancel·lada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (5,2,'2024-12-23','09:45:00','Pendent');
