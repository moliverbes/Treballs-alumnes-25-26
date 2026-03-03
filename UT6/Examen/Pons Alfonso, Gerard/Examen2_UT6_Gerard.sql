-- 1
ALTER TABLE moviment
MODIFY COLUMN timestamp DATETIME UNIQUE;
-- 2
ALTER TABLE peça
DROP FOREIGN KEY peça_ibfk_1;
ALTER TABLE peça
ADD FOREIGN KEY(id_posicio) REFERENCES posicio(id_posicio) ON DELETE SET NULL;
-- 3
ALTER TABLE peça
DROP FOREIGN KEY peça_ibfk_1;
ALTER TABLE peça
DROP id_posicio;
ALTER TABLE posicio
DROP COLUMN fila,
DROP COLUMN columna;
ALTER TABLE posicio
ADD COLUMN casella TINYINT NOT NULL UNIQUE;
ALTER TABLE peça
ADD COLUMN casella TINYINT,
ADD FOREIGN KEY(casella) REFERENCES posicio(casella);

-- 4
ALTER TABLE posicio
ADD COLUMN color ENUM("blanc","negre") NOT NULL;
-- 5
ALTER TABLE moviment 
DROP CONSTRAINT moviment_chk_1;
ALTER TABLE moviment
ADD CONSTRAINT segons CHECK(segons <= 0.60 );
-- 6
RENAME TABLE peça TO peces;

