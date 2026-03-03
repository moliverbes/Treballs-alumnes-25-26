-- 1
ALTER TABLE moviment
MODIFY timestamp DATETIME UNIQUE;

-- 2 
ALTER TABLE peça 
DROP CONSTRAINT fk_peça_posicio;

ALTER TABLE peça
DROP COLUMN id_posicio;

ALTER TABLE peça
ADD COLUMN id_posicio TINYINT UNIQUE NULL;

ALTER TABLE peça
ADD CONSTRAINT fk_peça_posicio
FOREIGN KEY (id_posicio) REFERENCES posicio(id_posicio);

DESCRIBE peça;

-- 3
ALTER TABLE peça
DROP CONSTRAINT fk_peça_posicio;

ALTER TABLE peça
DROP COLUMN id_posicio;

ALTER TABLE posicio
DROP COLUMN fila;

ALTER TABLE posicio
DROP COLUMN columna;

ALTER TABLE posicio
ADD COLUMN casella VARCHAR(2) NOT NULL UNIQUE;

ALTER TABLE peça
ADD COLUMN casella VARCHAR(2);

ALTER TABLE peça
ADD CONSTRAINT fk_peça_posicio
FOREIGN KEY (casella) REFERENCES posicio(casella);

-- 4
ALTER TABLE posicio
ADD COLUMN color_casella ENUM('blanc','negre') NOT NULL;

-- 5 Eliminamos el check ya que si lo limitamos a 60 no sirve de nada el otro check de 120
ALTER TABLE moviment
DROP CONSTRAINT moviment_chk_1;

ALTER TABLE moviment
MODIFY segons DECIMAL(4,1) CHECK (segons <= 60) DEFAULT '0.0';

-- 6
ALTER TABLE peça
RENAME TO peces;