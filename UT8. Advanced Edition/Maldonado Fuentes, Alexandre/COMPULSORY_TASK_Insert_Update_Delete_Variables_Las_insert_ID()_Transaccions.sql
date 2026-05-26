/*PART 2 INSERCIÓ MANUAL DE DADES */

/*especialitats*/
INSERT INTO especialitats VALUES 
(null,'Oftalmologia'),
(null,'Cardiologia'),
(null,'Pediatra'); 

SELECT * FROM especialitats;
/*metges*/
INSERT INTO metges VALUES
(null,'Alexandre', 'Maldonado','642346977','alexmaldoando@gmail.com',1),
(null,'Gerard', 'Pons','634445403','gerardpons@gmail.com',2),
(null,'Biel', 'Campins','658422113','bielcampins@gmail.com',3);

SELECT * FROM metges;

/*pacients*/
INSERT INTO pacients VALUES
(null,'Alexandre','Maldonado','2005-09-12','779643246','alexmaldonado@host.com','C/ PIUS XII'),
(null,'Gerard','Pons','2007-01-19','304544436','gerardpons@host.com','C/ Joan Alvover'),
(null,'Biel','Campins','2006-10-5','311224856','bielcampins@host.com','C/ Can Gerard'),
(null,'Alvaro','Sevillano','2006-5-25','625354877','alvarosevillano@host.com','C/ Ramon Desbrull'),
(null,'Joan','Miquel','2005-01-12','654987321','joanmiquel@host.com','C/ Ramon Desbrull');

SELECT * FROM pacients;
/*Medicaments*/

INSERT INTO medicaments VALUE
(null,'Paracetamol','50mg','FabricaAlex',2),
(null,'Ibuprofeno','100mg','FabricaAlex',4),
(null,'Metamizol ','80mg','FabricaAlex',3);

SELECT * FROM medicaments;

/*Cites*/

INSERT INTO cites VALUES 
(null,1,2,'2027-5-25','12:30',1),
(null,4,1,'2027-5-28','13:30',3),
(null,3,3,'2027-5-2','12:30',2);

SELECT * FROM cites;

/*PART 3 ÚS DE VARIABLES*/

SELECT id_pacient INTO @pacient_id
FROM pacients
WHERE id_pacient = 1;

SELECT id_metge INTO @metge_id
FROM metges
WHERE id_metge = 2;

INSERT INTO cites (id_pacient, id_metge, data_cita, hora_cita, estat)
VALUES (@pacient_id, @metge_id, '2027-06-15', '10:30', 'Pendent');


SELECT * FROM cites;

/*PART 4 ÚS DE LAST_INSERT_ID()*/

INSERT INTO pacients VALUES 
(null,'Indiana','Jons','1970-05-05','985432167','indianajons@host.com','C/ Reliquia');

INSERT INTO cites VALUES 
(null, LAST_INSERT_ID(),3,'2028-08-12','10:00',1);

/*PART 5 TRANSACCIONS*/

START TRANSACTION;

INSERT INTO cites VALUES 
(null, 1,2,CURDATE(),'10:00',1);

SELECT * FROM cites;

SELECT id_cita INTO @idcita
FROM cites
WHERE id_cita = LAST_INSERT_ID();

INSERT INTO prescriptions VALUES
(null,@idcita,3,23,'Prende només amb receta');

SELECT * FROM prescriptions;

UPDATE cites
SET estat = 2
WHERE id_cita = @idcita;

SELECT * FROM cites;

COMMIT;


/*PART 6 SENTÈNCIES UPDATE*/
SELECT * FROM pacients;

UPDATE pacients
SET telefon = 999999999
WHERE id_pacient = 1;

SELECT * FROM cites;

UPDATE cites
SET data_cita = CURDATE(), hora_cita = '12:00'
WHERE id_cita = 1;

SELECT * FROM medicaments;

UPDATE medicaments
SET nom = 'Amoxicilina'
WHERE id_medicament = 1;

/*PART 7 SENTÈNCIES DELETE*/
SELECT * FROM cites;

DELETE FROM cites
WHERE id_cita = 2;

SELECT * FROM prescriptions;
SELECT * FROM medicaments;

DELETE FROM medicaments 
WHERE id_medicament = 1;
