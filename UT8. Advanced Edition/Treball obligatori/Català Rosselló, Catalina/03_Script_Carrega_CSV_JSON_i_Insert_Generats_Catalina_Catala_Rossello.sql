-- ** Gestió d’una petita clínica ** --

-- 8. Càrrega de dades des d’un CSV amb LOAD DATA --

/*
Crea un arxiu CSV amb nous pacients i carrega’l dins la taula pacients 
utilitzant LOAD DATA INFILE.

L’arxiu ha de contenir almenys 5 pacients nous.
*/


LOAD DATA INFILE '/var/lib/mysql-files/01_pacients.csv'
INTO TABLE pacients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nom,cognoms,data_naixement,telefon,email,adreca);

SELECT * FROM pacients;


-- 9. Càrrega de dades des d’un JSON --

/*
Crea un arxiu JSON amb nous medicaments.

Després, converteix les dades del JSON en sentències INSERT i insereix-les 
dins la taula medicaments.

L’arxiu ha de contenir almenys 4 medicaments nous.
*/

INSERT INTO medicaments (nom, dosi, fabricant, stock)
SELECT nom, dosi, fabricant, stock
FROM JSON_TABLE(
    CONVERT (
        LOAD_FILE('/var/lib/mysql-files/02_medicaments.json')
        USING utf8mb4),
    '$[*]' COLUMNS (
        nom VARCHAR(100) PATH '$.nom',
		dosi VARCHAR(50) PATH '$.dosi',
		fabricant VARCHAR(100) PATH '$.fabricant',
		stock INT PATH '$.stock'
    )
) AS t;

SELECT * FROM medicaments;


-- 10. Ús de CSVConvert --

/*
Crea un altre arxiu CSV amb 5 cites mèdiques noves.

Utilitza la web CSVConvert per transformar aquest CSV en sentències INSERT.

Després:
	1.Copia les sentències generades.
	2.Afegeix-les al teu guió SQL.
	3.Executa-les sobre la base de dades.
*/

INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (9,2,'2026-05-21','10:30','Cancel·lada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (7,1,'2026-05-24','14:10','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (6,3,'2026-05-20','08:15','Completada');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (11,2,'2026-06-14','11:45','Pendent');
INSERT INTO cites(id_pacient,id_metge,data_cita,hora_cita,estat) VALUES (3,3,'2026-05-22','16:45','Cancel·lada');

SELECT * FROM cites;