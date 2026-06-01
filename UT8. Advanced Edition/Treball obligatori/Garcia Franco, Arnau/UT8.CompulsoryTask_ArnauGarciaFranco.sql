
-- PART 2 Inserció manual de dades 

/* Insereix manualment:
3 especialitats mèdiques.
3 metges associats a una especialitat.
5 pacients.
3 medicaments.
Després, crea almenys 3 cites mèdiques relacionant pacients i metges. */ 
-- 3 especialitats
INSERT INTO especialitats (nom)
VALUES ('psicoleg'), ('pediatra'), ('infermer');
-- 3 metges associats

INSERT INTO metges (nom, cognoms, telefon, email, id_especialitat)
VALUES ('Alfredo', 'fer', '666565638', 'fer@gmail.com', 1), 
 ('Laura', 'Bibiloni', '666565628', 'lb@gmail.com', 3), ('Oscar', 'Franco', '663565628', 'ofb@gmail.com', 3);
 -- 5 pacients
 
INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) VALUES

('Laura', 'González Fernández', '1985-03-15', '612345678', 'laura.gonzalez@email.com', 'Carrer de la Pau 23, Barcelona'),
('Marc', 'Rodríguez López', '1992-07-22', '623456789', 'marc.rodriguez@email.com', 'Avda. Diagonal 456, Barcelona'),
('Elena', 'Martínez Sánchez', '1978-11-05', '634567890', 'elena.martinez@email.com', 'Plaça Catalunya 7, Barcelona'),
('Jordi', 'Pérez Gómez', '1995-12-10', '645678901', NULL, 'Carrer Balmes 89, Barcelona'),
('Marta', 'Sánchez Ruiz', '1982-09-18', '656789012', 'marta.sanchez@email.com', 'Carrer Aragó 345, Barcelona');

-- 3 medicaments

INSERT INTO medicaments (nom, dosi, fabricant, stock) VALUES
('Paracetamol', '500 mg', 'Farmàcia SA', 100),
('Ibuprofè', '400 mg', 'Laboratoris ABC', 75),
('Amoxicil·lina', '500 mg', 'Pharma SL', 50);
-- Insereix  3 cites med

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat) VALUES
(1, 1, '2024-06-20', '09:30:00', 'Pendent'),
(2, 2, '2024-06-20', '11:00:00', 'Pendent'),
(3, 1, '2024-06-21', '10:15:00', 'Completada');

-- PART 3 Variables
-- Pacient

SELECT id_pacient INTO @id_pacient_var
FROM pacients
WHERE nom = 'Laura' AND cognoms = 'González Fernández';
-- Metge	

SELECT m.id_metge INTO @id_metge_var
FROM metges m
JOIN especialitats e ON m.id_especialitat = e.id_especialitat
WHERE m.nom = 'Laura' AND m.cognoms = 'Bibiloni';

-- Insereix variables a una nova cita

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (@id_pacient_var, @id_metge_var, '2024-07-15', '10:30:00', 'Pendent');

/* Part 4. Ús de LAST_INSERT_ID()
Insereix un pacient nou i, immediatament després, 
crea una cita per a aquest pacient utilitzant LAST_INSERT_ID() per recuperar l’identificador generat automàticament. */

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca)
VALUES ('Anna', 'Martínez Soler', '1990-05-15', '611223344', 'anna.martinez@email.com', 'Carrer Gran Via 123, Barcelona');
INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (LAST_INSERT_ID(), 1, '2024-12-15', '10:30:00', 'Pendent');
-- Part 5. Transaccions
-- Iniciar la transacció
START TRANSACTION;

--  Inserir una nova cita 
INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (1, 1, CURDATE(), '15:30:00', 'Pendent');

--  Inserir una prescripció associada a la cita acabada d'inserir
INSERT INTO prescriptions (id_cita, id_medicament, quantitat, indicacions)
VALUES (LAST_INSERT_ID(), 1, 10, 'Prendre 1 comprimit cada 8 hores durant 3 dies');

--  Actualitzar l'estat de la cita a 'Completada'
UPDATE cites 
SET estat = 'Completada' 
WHERE id_cita = LAST_INSERT_ID();
COMMIT;
-- Part 6. Sentències UPDATE
/* Fes les actualitzacions següents:
Canvia el telèfon d’un pacient.
Modifica la data o l’hora d’una cita.
Actualitza el nom d’un medicament o la seva dosi.
Abans de cada UPDATE, escriu una consulta SELECT que permeti comprovar quins registres es modificaran. */
USE clinicadb;
SELECT * FROM pacients;
UPDATE  pacients
SET telefon = '6555538'
WHERE id_pacient = 1;

SELECT * FROM cites;

UPDATE cites
SET data_cita = current_date()
WHERE id_cita = 1;

SELECT * FROM medicaments;
UPDATE medicaments
SET nom = 'Lorazepam'
WHERE id_medicament = 1;

-- Part 7. DELETE
/* Elimina:
Una cita cancel·lada.
Un medicament que no tengui cap prescripció associada.
Abans de cada DELETE, escriu una consulta SELECT per comprovar quin registre s’eliminarà. */
SELECT * FROM cites;
DELETE FROM cites where id_cita = 1;
SELECT * FROM medicaments;
DELETE FROM medicaments WHERE id_medicament = 2;



