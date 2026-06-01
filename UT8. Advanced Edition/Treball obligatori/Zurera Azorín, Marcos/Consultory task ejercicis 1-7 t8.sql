-- Part 2. Inserció manual de dades

USE ClinicaDB;

INSERT INTO especialitats (nom) VALUES 
('Cardiologia'),
('Pediatria'),
('Dermatologia');

INSERT INTO metges (nom, cognoms, telefon, email, id_especialitat) VALUES 
('Carlos', 'Gomez Ruiz', '600111222', 'carlos.gomez@clinica.com', 1),
('Laura', 'Marti Soler', '600333444', 'laura.marti@clinica.com', 2),
('David', 'Serra Pons', '600555666', 'david.serra@clinica.com', 3);

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) VALUES 
('Joan', 'Perez Mas', '1985-04-12', '611222333', 'joan.perez@email.com', 'Carrer Major 15'),
('Maria', 'Barcelo Vidal', '1990-11-23', '622333444', 'maria.barcelo@email.com', 'Avinguda del Sol 4'),
('Antoni', 'Riera Costa', '1972-08-05', '633444555', 'antoni.riera@email.com', 'Carrer Nou 8'),
('Marta', 'Font Oliver', '2005-01-30', '644555666', 'marta.font@email.com', NULL),
('Francesc', 'Vila Serra', '1968-06-17', '655666777', 'francesc.vila@email.com', 'Placa de l Esglesia 1');

INSERT INTO medicaments (nom, dosi, fabricant, stock) VALUES 
('Ibuprofeno', '600mg', 'Kern Pharma', 50),
('Amoxicilina', '500mg', 'Normon', 30),
('Paracetamol', '1g', 'Cinfa', 100);

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) VALUES 
(1, 1, '2026-06-01', '09:30:00', 'Pendent'),
(2, 2, '2026-06-01', '10:15:00', 'Completada'),
(3, 3, '2026-06-02', '11:00:00', 'Pendent');

-- Part 3. Ús de variables
SELECT id_pacient INTO @var_pacient_id FROM pacients WHERE email = 'joan.perez@email.com' LIMIT 1;
SELECT id_metge INTO @var_metge_id FROM metges WHERE email = 'laura.marti@clinica.com' LIMIT 1;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (@var_pacient_id, @var_metge_id, '2026-06-10', '16:00:00', 'Pendent');

-- Part 4. Ús de LAST_INSERT_ID()
INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) 
VALUES ('Pere', 'Mascaro Pons', '1995-07-08', '677888999', 'pere.mascaro@email.com', 'Carrer de la Pau 22');

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (LAST_INSERT_ID(), 1, '2026-06-11', '12:30:00', 'Pendent');

-- Part 5. Transaccions

START TRANSACTION;
INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (1, 2, '2026-06-15', '17:00:00', 'Pendent');
SET @id_nueva_cita = LAST_INSERT_ID();
INSERT INTO prescripcions (id_cita, id_medicament, quantitat, indicacions) 
VALUES (@id_nueva_cita, 1, 2, 'Prendre cada 8 hores després dels àpats');
UPDATE cites 
SET estat = 'Completada' 
WHERE id_cita = @id_nueva_cita;
COMMIT;

-- Part 6. Sentències UPDATE
SELECT id_pacient, nom, cognoms, telefon FROM pacients WHERE id_pacient = 1;
UPDATE pacients 
SET telefon = '699999999' 
WHERE id_pacient = 1;
SELECT id_cita, id_pacient, data_cita, hora_cita FROM cites WHERE id_cita = 1;
UPDATE cites 
SET data_cita = '2026-06-20', hora_cita = '18:30:00' 
WHERE id_cita = 1;
SELECT id_medicament, nom, dosi FROM medicaments WHERE id_medicament = 1;
UPDATE medicaments 
SET nom = 'Ibuprofeno Kern', dosi = '400mg' 
WHERE id_medicament = 1;

-- Part 7. Sentències DELETE

SELECT id_cita, id_pacient, id_metge, estat FROM cites WHERE estat = 'Cancel·lada';

DELETE FROM cites 
WHERE estat = 'Cancel·lada' 
LIMIT 1;

SELECT id_medicament, nom FROM medicaments 
WHERE id_medicament NOT IN 
	(SELECT DISTINCT id_medicament FROM prescripcions);

DELETE FROM medicaments 
WHERE id_medicament NOT IN 
	(SELECT * FROM (SELECT DISTINCT id_medicament FROM prescripcions) AS t)
	LIMIT 1;
