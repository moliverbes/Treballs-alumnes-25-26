/*PART 2*/
/* Inserció de dades a la base */
INSERT INTO especialitats(nom) 
VALUES
	('cardioleg'),
    ('peuoleg'),
    ('oreoleg');
SELECT * FROM especialitats;

INSERT INTO metges(nom, cognoms, telefon, email, id_especialitat)
VALUES
	('Juan', 'Manguera', '971123456', 'juan@email.com', 1),
    ('Biel', 'Campos', '971123456', 'biel@email.com', 2),
    ('Yan', 'Mendolls', '971123456', 'yan@email.com', 3);
SELECT * FROM metges;

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) 
VALUES
	('Maria', 'Garcia', '1983-05-12', '971123456', 'maria@email.com', 'C/ Major 12, Inca'),
	('Joan', 'Ferrer', '1990-07-25', '971123456', 'joan@email.com', 'Av. Jaume I 45, Palma'),
	('Aina', 'Serra', '1987-11-03', '971123456', 'aina@email.com', 'C/ Sant Bartomeu 8, Inca'),
	('Pepe', 'Riera', '2002-01-19', '971123456', 'pepe@email.com', NULL),
	('Laura', 'Ruiz', '1995-05-30', '971123456', 'laura@email.com', 'C/ Llevant 22, Manacor');
SELECT * FROM pacients;

INSERT INTO medicaments (nom, dosi, fabricant, stock) VALUES
	('Paracetamol', '500 mg', 'Cinta', 135),
	('Ibuprofeno', '600 mg', 'Super Pharma', 90),
	('Amoxicilina', '750 mg', 'Sancho', 45);
SELECT * FROM medicaments;

/* PART 3 */
SELECT id_pacient INTO @id_pacient
FROM pacients
WHERE email = 'pepe@email.com';
SELECT id_metge INTO @id_metge
FROM metges
WHERE email = 'yan@email.com';

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita)
VALUES (@id_pacient, @id_metge, '2026-05-19', '18:00:00');
SELECT * FROM cites;

/* EXERCICI 4 */

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca)
VALUES ('Andreu', 'Campins Vidal', '2007-01-13', '971123456', 'andreuet@email.com', 'C/ ちょっとした冗談');

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita)
VALUES (LAST_INSERT_ID(), 2, '2026-05-20', '19:00:00');
SELECT * FROM pacients;
SELECT * FROM cites;

/* EXERCICI 5 */

START TRANSACTION;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (5, 3, '2026-06-1', '17:00:00', 'Pendent');

SET @id_nova_cita = LAST_INSERT_ID();

INSERT INTO prescripcions (id_cita, id_medicament, quantitat, indicacions)
VALUES (@id_nova_cita, 3, 21, '1 comprimit cada 8 hores durant 7 dies');

UPDATE cites SET estat = 'Completada'
WHERE id_cita = @id_nova_cita;

COMMIT;
SELECT * FROM cites;

/* EXERCICI 6 */
SELECT id_pacient, nom, cognoms, telefon
FROM pacients
WHERE email = 'laura@email.com';
UPDATE pacients
SET telefon = '971000000'
WHERE email = 'laura@email.com';
SELECT id_pacient, telefon FROM pacients WHERE email = 'laura@email.com';

SELECT * FROM cites
WHERE id_cita = 1;

UPDATE cites
SET data_cita = '2026-05-18', hora_cita = '10:00:00'
WHERE id_cita = 1;

SELECT *
FROM medicaments
WHERE id_medicament = 2;
UPDATE medicaments
SET nom = 'Ibupropano', dosi = '6000 mg'
WHERE id_medicament = 2;

/* EXERCICI 7 */
INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (1, 1, '2026-05-20', '09:00:00', 'Cancel·lada');

SELECT id_cita, id_pacient, id_metge, data_cita, estat
FROM cites
WHERE estat = 'Cancel·lada';

DELETE FROM cites
WHERE id_cita = 4;

SELECT * FROM cites WHERE id_cita = 4;

SELECT m.id_medicament, m.nom, m.dosi
FROM medicaments m
LEFT JOIN prescripcions p ON m.id_medicament = p.id_medicament
WHERE p.id_medicament IS NULL;

SELECT id_medicament, nom FROM medicaments 
WHERE id_medicament = 1;

DELETE FROM medicaments
WHERE id_medicament = 1;

SELECT * FROM medicaments
WHERE nom = 'Paracetamol';