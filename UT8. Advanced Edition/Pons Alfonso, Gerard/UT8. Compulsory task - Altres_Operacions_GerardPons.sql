-- Inserts
INSERT INTO especialitats (nom) VALUES 
('Cardiologia'),
('Dermatologia'),
('Pediatria');

INSERT INTO metges (nom, cognoms, telefon, email, id_especialitat) VALUES 
('Joan', 'Martínez López', '654321123', 'jmlopez@clinic', 1),
('Maria', 'García Ruiz', '654321456', 'mgaruiz@clinic', 2),
('Carles', 'Roca Ferrer', '654321789', 'crofer@clinic', 3);

INSERT INTO pacients (nom, cognoms, data_naixament, telefon, email, adreca) VALUES 
('Anna', 'Solé Vidal', '1990-05-15', '678123456', 'annasv@mail', 'Carrer Major 123'),
('Pere', 'Nadal Font', '1985-08-22', '678234567', 'perenf@mail', 'Avinguda Diagonal 45'),
('Laura', 'Pujol Bosch', '2000-12-10', '678345678', 'laupb@mail', 'Plaça Catalunya 7'),
('Marc', 'Vila Casas', '1975-03-07', '678456789', 'marvc@mail', 'Carrer Girona 89'),
('Elena', 'Serra Reig', '1995-09-30', '678567890', 'elesr@mail', 'Carrer Balmes 34');

INSERT INTO medicaments (nom, dosi, fabricant, stock) VALUES 
('Paracetamol', '500mg', 'LabFarma', 100),
('Ibuprofè', '400mg', 'SaludMed', 75),
('Amoxicil·lina', '500mg', 'AntibioLab', 50);

SELECT id_metge, nom, cognoms FROM metges;
SELECT id_pacient, nom, cognoms FROM pacients;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) VALUES 
(1, 1, '2026-05-20', '10:30:00', 'Pendent'),     
(2, 2, '2026-05-21', '11:15:00', 'Pendent'),     
(3, 3, '2026-05-22', '09:45:00', 'Completada'); 

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (5, 3, '2026-05-30', '09:00:00', 'Cancel·lada');

INSERT INTO prescripcions (id_cita, id_medicament, quantitat, indicacions) VALUES 
(1, 1, 2, 'Pren un comprimit cada 8 hores'),
(2, 2, 1, 'Pren després dels àpats'),
(3, 3, 5, 'Pren cada 12 hores durant 5 dies'); 

-- us de variables
SELECT id_pacient INTO @patient_id
FROM pacients 
WHERE nom = 'Laura' AND cognoms = 'Pujol Bosch';

SELECT id_metge INTO @doctor_id
FROM metges 
WHERE nom = 'Carles' AND cognoms = 'Roca Ferrer';

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (@patient_id, @doctor_id, '2026-06-01', '15:30:00', 'Pendent');

-- us de last_isert_id
INSERT INTO pacients (nom, cognoms, data_naixament, telefon, email, adreca) 
VALUES ('Marta', 'Fernández Gómez', '1988-07-25', '678901234', 'marfergo@mail', 'Carrer Aragó 56');

SELECT LAST_INSERT_ID() AS new_patient_id;
SET @new_patient_id = LAST_INSERT_ID();

SELECT id_pacient, nom, cognoms, data_naixament, telefon, email, adreca 
FROM pacients 
WHERE id_pacient = @new_patient_id;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (@new_patient_id, 2, '2026-06-05', '11:30:00', 'Pendent');

-- transaccions 

START TRANSACTION;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) 
VALUES (1, 1, '2026-06-15', '14:30:00', 'Pendent');

SET @new_cita_id = LAST_INSERT_ID();

INSERT INTO prescripcions (id_cita, id_medicament, quantitat, indicacions) 
VALUES (@new_cita_id, 1, 2, 'Pren un comprimit cada 8 hores durant 2 dies');

UPDATE cites 
SET estat = 'Completada' 
WHERE id_cita = @new_cita_id;
COMMIT;

-- UPDATES
SELECT id_pacient, nom, cognoms, telefon, email 
FROM pacients 
WHERE cognoms = 'Solé Vidal' OR nom = 'Anna';

UPDATE pacients 
SET telefon = '678111222' 
WHERE id_pacient = 1;

SELECT c.id_cita, p.nom, p.cognoms,m.nom, m.cognoms,c.data_cita,c.hora_cita, c.estat
FROM cites c
JOIN pacients p ON c.id_pacient = p.id_pacient
JOIN metges m ON c.id_metge = m.id_metge
WHERE c.id_cita = 1;

UPDATE cites 
SET data_cita = '2026-07-01'
WHERE id_cita = 1;

SELECT id_medicament, nom, dosi, fabricant, stock 
FROM medicaments 
WHERE id_medicament = 1;

UPDATE medicaments 
SET nom = 'Acetamina' 
WHERE id_medicament = 1;


-- Sentencies DELETE
SELECT id_cita, id_pacient, id_metge, data_cita, hora_cita, estat
FROM cites
WHERE estat = 'Cancel·lada';

DELETE FROM cites WHERE id_cita = 7;

SELECT * FROM cites WHERE estat = 'Cancel·lada';

SELECT m.id_medicament, m.nom, m.dosi, m.fabricant, m.stock
FROM medicaments m
LEFT JOIN prescripcions p ON m.id_medicament = p.id_medicament
WHERE p.id_medicament IS NULL;

INSERT INTO medicaments (nom, dosi, fabricant, stock) 
VALUES ('MedicamentProva', '100mg', 'LabTest', 10);

DELETE FROM medicaments WHERE id_medicament = 4;