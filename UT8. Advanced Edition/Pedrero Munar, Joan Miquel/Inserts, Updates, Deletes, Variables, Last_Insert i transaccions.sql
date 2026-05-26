-- Part 2

INSERT INTO especialitats (nom) 
VALUES ('Pediatria'), ('Dermatologia'), ('Cardiologia');

INSERT INTO metges (nom, cognoms, telefon, email, id_especialitat)
VALUES ('Joan Miquel', 'Pedrero Munar', '123456789', 'joan.miquel@clinica.com', 1),
('Mark', 'Pires Guimaraes', '222222222', 'Mark.pires@clinica.com', 2),
('Alvaro', 'Gutierrez Gimenez', '333333333', 'Alvaro.gutierrez@clinica.com', 3);

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca)
VALUES ('Miquel', 'Ferrer', '2001-04-27', '444444444', 'miquel.ferrer@gmail.com', 'Carrer 1'),
('Marta', 'Lopez', '1985-08-20', '555555555', 'marta.lopez@gmail.com', 'Carrer 2'),
('Pere', 'Gomez', '2000-11-10', '666666666', 'pere.gomez@email.com', 'Carrer 3'),
('Carme', 'Riera', '1975-02-25', '777777777', 'carme.riera@email.com', 'Carrer 4'),
('Toni', 'Roig', '1995-07-30', '888888888', 'toni.roig@email.com', 'Carrer 5');

INSERT INTO medicaments (nom, dosi, fabricant, stock)
VALUES ('Ibuprofeno', '600mg', 'Cameva', 150),
('Paracetamol', '1g', 'Cameva', 150),
('Frenadol', '500mg', 'Cameva', 150);

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (1, 1, '2026-06-01', '09:00:00', 'Pendent'),
(2, 2, '2026-06-02', '10:30:00', 'Pendent'),
(3, 3, '2026-06-03', '11:15:00', 'Pendent');

-- Part 3

SELECT id_pacient INTO @pacient_id FROM pacients 
WHERE nom = 'Miquel' 
LIMIT 1;
SELECT id_metge INTO @metge_id FROM metges 
WHERE nom = 'MarK' 
LIMIT 1;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (@pacient_id, @metge_id, '2026-06-10', '16:00:00', 'Pendent');

-- Part 4

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca)
VALUES ('Andreu', 'Garcia', '1992-05-01', 112233445, 'andreu.garcia@gmail.com', 'carrer 7');

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (LAST_INSERT_ID(), 1, '2026-08-04', '11:00:00', 'Pendent');

-- Part 5

START TRANSACTION;
INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (1, 1, '2026-06-20', '12:00:00', 'Pendent');

INSERT INTO prescripcions (id_cita, id_medicament, quantitat) 
VALUES (LAST_INSERT_ID(), 1, 2);

UPDATE cites 
SET estat = 'Completada' 
WHERE id_cita = LAST_INSERT_ID();
COMMIT;

-- Part 6

SELECT * FROM pacients 
WHERE nom = 'Marta';

UPDATE pacients
SET telefon = '120340560'
WHERE nom LIKE 'Marta';

SELECT * FROM cites 
WHERE id_cita = 1;

UPDATE cites
SET hora_cita = '09:45:00' 
WHERE id_cita = 1;

SELECT * FROM medicaments 
WHERE nom = 'Ibuprofeno';

UPDATE medicaments 
SET dosi = '400mg' 
WHERE nom = 'Ibuprofeno';

-- Part 7

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (1, 2, '2026-07-01', '10:00:00', 'Cancel·lada');

SELECT * FROM cites 
WHERE estat = 'Cancel·lada';

DELETE FROM cites 
WHERE estat = 'Cancel·lada';

SELECT * FROM medicaments m
LEFT JOIN prescripcions p ON m.id_medicament = p.id_medicament
WHERE id_prescripcio IS NULL;

DELETE FROM medicaments WHERE id_medicament = (
SELECT id FROM (
SELECT m.id_medicament AS id FROM medicaments m LEFT JOIN prescripcions p ON m.id_medicament = p.id_medicament 
WHERE p.id_prescripcio IS NULL 
LIMIT 1) AS tmp
);