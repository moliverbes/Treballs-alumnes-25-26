-- ** Gestió d’una petita clínica ** --

-- 2. Inserció manual de dades --

/*
Insereix manualment:
	· 3 especialitats mèdiques.
	· 3 metges associats a una especialitat.
	· 5 pacients.
	· 3 medicaments.
Després, crea almenys 3 cites mèdiques relacionant pacients i metges.
*/

INSERT INTO especialitats VALUES
	(null, 'Otorrinolaringologia'),
    (null, 'Traumatologia i ortopèdia'),
    (null, 'Geriatria')
;

INSERT INTO metges VALUES 
	(null, 'Vitoria', 'Cavalcanti Noriega', '726 074 815', 'VitoriaCavalcanti@clmallorca.com', 2),
	(null, 'Luiz', 'Cunha Valadez', '640 298 349', 'LuizCunha@clmallorca.com', 1),
    (null, 'Dustin', 'Alva Olmos', '752 763 957', 'DustinAlva@clmallorca.com', 3)
;

INSERT INTO pacients VALUES
	(null, 'Ahinoa', 'Vallejo Barrientos', '1996-10-29', '694 254 986', 'AhinoaVallejo@gmail.com', 'C/Fuente del Gallo, 72'),
	(null, 'Griselda', 'Malave Aragón', '1961-07-31', '789 345 223', 'GriseldaMalave@gmail.com', 'C/Carril de la Fuente, 70'),
	(null, 'Owen', 'Mata Garrido', '1981-05-12', '736 867 539', 'OwenMata@gmail.com', 'C/Pascual Yunquera, 78'),
	(null, 'Prometeo', 'Guardado Velázquez', '1999-03-17', '682 428 904', 'PrometeoGuardado@gmail.com', 'C/Andalucía, 62'),
	(null, 'Gerónimo', 'Parra Bañuelos', '1998-11-27', '780 143 267', 'GeronimoParra@gmail.com', 'C/Plaza Colón, 8')
;

INSERT INTO medicaments VALUES
	(null, 'Paracetamol', '500 mg', 'Bayer', 120 ),
	(null, 'Ibuprofeno', '400 mg', 'Normon', 85 ),
	(null, 'Amoxicilina', '875 mg', 'Sandoz', 40 )
;

INSERT INTO cites VALUES
	(null, 5, 3, '2026-04-20', '10:00:00', 'Completada'),
    (null, 1, 2, '2026-09-15', '14:30:00', 'Pendent'),
	(null, 5, 3, '2026-05-25', '09:20:00', 'Cancel·lada')
;

-- 3. Ús de variables --

/*
Utilitza variables de MySQL per guardar l’identificador d’un pacient i d’un 
metge concrets (els que vulguis depenent de les dades que hagis inserit) 
mitjançant SELECT ... INTO.

Amb aquestes variables, insereix una nova cita mèdica.
*/

SELECT id_pacient
INTO @pacient_id
FROM pacients
WHERE nom LIKE 'Owen';

SELECT id_metge
INTO @metge_id
FROM metges
WHERE nom LIKE 'Vitoria';


INSERT INTO cites VALUES
	(null, @pacient_id, @metge_id, '2026-05-30', CURRENT_TIME(), 'Cancel·lada');


-- 4. Ús de LAST_INSERT_ID() --

/*
Insereix un pacient nou i, immediatament després, crea una cita per a 
aquest pacient utilitzant LAST_INSERT_ID() per recuperar l’identificador 
generat automàticament.
*/

INSERT INTO pacients VALUES
	(null, 'Tesira', 'Tirado Ortiz', '1989-05-30', '719 467 288', 'TesiraTirado@gmail.com', 'C/ Eras, 79' );
    
INSERT INTO cites VALUES
		(null, LAST_INSERT_ID(), 3, '2026-12-17', CURRENT_TIME(), 'Pendent');


-- 5. Transaccions --

/*
Crea una transacció que faci les operacions següents:
	1.Inserir una nova cita.
	2.Inserir una prescripció associada a aquesta cita.
	3.Actualitzar l’estat de la cita a Completada.
	4.Confirma els canvis amb COMMIT.
*/

START TRANSACTION;

INSERT INTO cites VALUES
	(null, 4, 1, CURRENT_DATE(), CURRENT_TIME(), 'Pendent');

SET @cites_id = LAST_INSERT_ID();

INSERT INTO prescripcions VALUES
	(null, @cites_id , 2, 20, 'Prendre 1 comprimit cada 8 hores' );
    
UPDATE cites
SET estat = 'Completada'
WHERE id_cita = @cites_id;

COMMIT;

-- 6. Sentències UPDATE --

/*
Fes les actualitzacions següents:

	·Canvia el telèfon d’un pacient.
	·Modifica la data o l’hora d’una cita.
	·Actualitza el nom d’un medicament o la seva dosi.
    
Abans de cada UPDATE, escriu una consulta SELECT que permeti comprovar 
quins registres es modificaran.
*/

SELECT * FROM pacients
WHERE id_pacient = 3;

UPDATE pacients
SET telefon = '625 128 233'
WHERE id_pacient = 3;

SELECT * FROM cites
WHERE id_cita = 2;

UPDATE cites
SET data_cita = '2026-10-02'
WHERE id_cita = 2;

SELECT * FROM medicaments
WHERE id_medicament = 1;

UPDATE medicaments
SET dosi = '1 g'
WHERE id_medicament = 1;


-- 7. Sentències DELETE --

/*
Elimina:

	·Una cita cancel·lada.
	·Un medicament que no tengui cap prescripció associada.
    
Abans de cada DELETE, escriu una consulta SELECT per comprovar quin 
registre s’eliminarà.
*/

SELECT * FROM cites
WHERE estat = 'Cancel·lada';

DELETE FROM cites
WHERE estat = 'Cancel·lada'
LIMIT 1;

SELECT * FROM medicaments m
LEFT JOIN prescripcions p USING(id_medicament)
WHERE p.id_medicament IS NULL;

DELETE FROM medicaments
WHERE id_medicament = 3;
