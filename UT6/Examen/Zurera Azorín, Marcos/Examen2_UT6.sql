ALTER TABLE moviment 
ADD CONSTRAINT UNIQUE (timestamp);

ALTER TABLE peça 
MODIFY COLUMN id_posicio TINYINT NULL;

ALTER TABLE peça 
DROP FOREIGN KEY peça_ibfk_1; 

ALTER TABLE peça 
DROP COLUMN id_posicio;

ALTER TABLE posicio 
DROP COLUMN fila, 
DROP COLUMN columna;

ALTER TABLE posicio 
ADD COLUMN casella VARCHAR(64) NOT NULL UNIQUE;

ALTER TABLE peça 
ADD COLUMN casella VARCHAR(64);
	
ALTER TABLE peça 
ADD CONSTRAINT fk_peça_casella 
FOREIGN KEY (casella) REFERENCES posicio(casella)
ON DELETE SET NULL 
ON UPDATE CASCADE;

ALTER TABLE posicio 
ADD COLUMN color_casella ENUM('blanc', 'negre') NOT NULL;

ALTER TABLE moviment 
DROP CHECK chk_segons; 

ALTER TABLE moviment 
ADD CONSTRAINT chk_segons_60 CHECK (segons < 60.0);

RENAME TABLE peça TO peces;