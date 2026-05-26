-- Parte 2 inserts --
INSERT INTO especialitats (nom) VALUES ('Pediatria'), ('Cardiologia'), ('Dermatologia');

INSERT INTO metges (nom, cognoms, telefon, email, id_especialitat) VALUES 
('Sergio', 'Ramos Garcia', '600111222', 'sergio.ramos@clinica.com', 1),
('Andres', 'Iniesta Lujan', '600333444', 'andres.iniesta@clinica.com', 2),
('Iker', 'Casillas Fernandes', '600555666', 'iker.casillas@clinica.com', 3);

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) VALUES
('Laura', 'Vidal Bosch', '1990-05-12', '611222333', 'laura.vidal@email.com', 'Carrer 15'),
('Pere', 'Barceló Mir', '1985-11-23', '611444555', 'pere.barcelo@email.com', 'Carrer 4'),
('Anna', 'Serra Ferrer', '2002-02-02', '611666777', 'anna.serra@email.com', NULL),
('Lluís', 'Mas Carrió', '1973-08-19', '611888999', 'lluis.mas@email.com', 'Carrer 8'),
('Maria', 'Ramon Pons', '1995-12-30', '611000111', 'maria.ramon@email.com', 'Carrer 23');

INSERT INTO medicaments (nom, dosi, fabricant, stock) VALUES
('Paracetamol', '1g', 'Kern Pharma', 100),
('Ibuprofèn', '600mg', 'Basi', 50),
('Amoxicil·lina', '500mg', 'Sandoz', 30);

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) VALUES
(1, 1, '2026-06-01', '09:30:00', 'Pendent'),
(2, 2, '2026-06-01', '10:00:00', 'Pendent'),
(3, 3, '2026-06-02', '11:15:00', 'Cancel·lada');

-- Parte 3 Uso de variables --
SELECT id_pacient INTO @pacient_id FROM pacients 
WHERE email = 'laura.vidal@email.com';

SELECT id_metge INTO @metge_id FROM metges 
WHERE email = 'sergio.ramos@clinica.com';

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (@pacient_id, @metge_id, '2026-06-10', '16:00:00', 'Pendent');

-- Parte 4 uso de LAST_INSERT_ID() -- 
INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) 
VALUES ('Toni', 'Soler Costa', '1988-04-14', '622111222', 'toni.soler@email.com', 'Carrer 45');

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (LAST_INSERT_ID(), 1, '2026-06-12', '12:00:00', 'Pendent');

-- Parte 5 transactions --
START TRANSACTION;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (4, 2, '2026-06-15', '17:30:00', 'Pendent');

SET @nova_cita_id = LAST_INSERT_ID();

INSERT INTO prescripcions (id_cita, id_medicament, quantitat, indicacions) 
VALUES (@nova_cita_id, 2, 1, 'Prendre cada 8 hores després dels àpats');

UPDATE cites SET estat = 'Completada' WHERE id_cita = @nova_cita_id;

COMMIT;

-- Parte 6 sentecias updates --
SELECT id_pacient, nom, cognoms, telefon FROM pacients 
WHERE id_pacient = 1;
UPDATE pacients SET telefon = '699999999' WHERE id_pacient = 1;

SELECT id_cita, data_cita, hora_cita FROM cites 
WHERE id_cita = 1;
UPDATE cites SET data_cita = '2026-06-05', hora_cita = '09:45:00' WHERE id_cita = 1;

SELECT id_medicament, nom, dosi FROM medicaments 
WHERE id_medicament = 1;
UPDATE medicaments SET dosi = '500mg' WHERE id_medicament = 1;

-- Parte 7 Sentecias delete 
SELECT id_cita, id_pacient, estat FROM cites 
WHERE estat = 'Cancel·lada';
DELETE FROM cites WHERE estat = 'Cancel·lada'
LIMIT 1;

SELECT id_medicament, nom FROM medicaments 
WHERE id_medicament NOT IN (SELECT DISTINCT id_medicament FROM prescripcions);
DELETE FROM medicaments WHERE id_medicament = 3
LIMIT 1;