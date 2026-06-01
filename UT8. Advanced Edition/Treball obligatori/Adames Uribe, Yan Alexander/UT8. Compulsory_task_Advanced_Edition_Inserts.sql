-- Part 2
INSERT INTO especialitats
VALUES(NULL,'Odontologia'),
(NULL,'Pediatria'),
(NULL,'Urologia');

INSERT INTO metges
VALUES(NULL,'Biel','Herrero','678920287',1),
(NULL,'Daniel','Sudadera','691234567',2),
(NULL,'Juan','Toad','762534490',3);

INSERT INTO pacients
VALUES(NULL,'Lionel','Messi','1987-06-24','617234567','lionel.messi@gmail.com','Aires Malos'),
(NULL,'Cristiano','Ronaldo','1980-02-08','717455645','cristiano.ronaldo@gmail.com','Calle sin mundial'),
(NULL,'Neymar','Junior','1992-02-08','648902345','neymar.junior@gmail.com','Lago de Jaen'),
(NULL,'Lamine','Pañal','2007-07-20','789123456','lamine.pañales@gmail.com','Lejos de madrid'),
(NULL,'Vinicius','Balondeplaya','2000-05-30','639872346','balondeplaya@gmail.com','Junto a la playa');

INSERT INTO medicaments
VALUES(NULL,'Parectamol','500 mg','Yo',170),
(NULL,'Ibuprofeno','600 mg','El vecino',100),
(NULL,'Amoxicilina','750 mg','Andreu',300);

INSERT INTO cites
VALUES(NULL,5,3,'2026-05-25','10:00:00','Pendent'),
(NULL,2,1,'2025-04-16','18:00:00','Completada'),
(NULL,1,1,'2027-09-30','09:00:00','Cancel·lada');

-- Part 3
SELECT id_pacient INTO @Neymar FROM pacients
WHERE id_pacient = 3;

SELECT id_metge INTO @Daniel FROM metges
WHERE id_metge = 2;

INSERT INTO cites VALUES(NULL,@Neymar,@Daniel,'2026-06-15','11:30:00','Pendent');

-- Part 4
INSERT INTO pacients
VALUES(NULL,'Donald','Trompetas','1960-03-10','626778923','donald.trompetista@gmail.com','La casa negra');

INSERT INTO cites
VALUES(NULL,LAST_INSERT_ID(),3,'2026-08-1','13:30:00','Pendent');

-- Part 5
START TRANSACTION;

INSERT INTO cites
VALUES(NULL,1,1,'2023-02-11','21:45:00','Pendent');

SET @id_cita = LAST_INSERT_ID();

INSERT INTO prescripcions
VALUES(NULL,@id_cita,1,1,'Tomar cada uno cada ocho horas');

UPDATE cites
SET estat = 'Completada'
WHERE id_cita = @id_cita;

COMMIT;

-- Part 6
SELECT * FROM pacients
WHERE id_pacient = 2;
UPDATE pacients
SET telefon = '777777777'
WHERE id_pacient = 2;

SELECT * FROM cites
WHERE id_cita = 1;
UPDATE cites
SET data_cita = '2026-06-27'
WHERE id_cita = 1;

SELECT * FROM medicaments
WHERE id_medicament = 3;
UPDATE medicaments
SET dosi = '300 mg'
WHERE id_medicament = 3;

-- Part 7
SELECT * FROM cites
WHERE estat = 'Cancel·lada';

DELETE FROM cites
WHERE id_cita = 3;

SELECT * FROM medicaments
WHERE id_medicament NOT IN(
SELECT id_medicament
FROM prescripcions);

DELETE FROM medicaments
WHERE id_medicament = 2;