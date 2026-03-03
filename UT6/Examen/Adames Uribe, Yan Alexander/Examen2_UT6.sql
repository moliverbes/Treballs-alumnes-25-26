-- 1
ALTER TABLE moviment
	MODIFY COLUMN timestamp DATETIME UNIQUE;
-- 2
-- No feia falta fer un alter table perquè en les restriccions ya acceptava valors NULL. Igualment per modificar això es no posar NOT NULL si la columna el tenia.
ALTER TABLE peça
	MODIFY COLUMN id_posicio TINYINT;

-- 3a
ALTER TABLE peça
	DROP CONSTRAINT peça_ibfk_1;

ALTER TABLE peça
	DROP COLUMN id_posicio;

-- 3b
ALTER TABLE posicio
	DROP COLUMN fila;

ALTER TABLE posicio
	DROP COLUMN columna;

ALTER TABLE posicio
	ADD COLUMN casella SET('A1','A2','A3','B1','B2','B3','C1','C2','C3') NOT NULL UNIQUE;

-- 3c
ALTER TABLE peça
	ADD COLUMN casella SET('A1','A2','A3','B1','B2','B3','C1','C2','C3') NOT NULL UNIQUE,
    ADD FOREIGN KEY(casella) REFERENCES posicio(casella);

-- 4
ALTER TABLE posicio
	ADD COLUMN color ENUM('blanc','marró') NOT NULL;

-- 5
ALTER TABLE moviment
	ADD CHECK(segons <= 60.0);

ALTER TABLE moviment
	DROP CONSTRAINT moviment_chk_1;

-- 6
RENAME TABLE peça TO peces;