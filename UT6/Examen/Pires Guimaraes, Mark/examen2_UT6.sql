-- 1 --
ALTER TABLE moviment
MODIFY timestamp DATETIME UNIQUE;

-- 2 --
ALTER TABLE peça
MODIFY id_posicio TINYINT NULL;

-- 3 --
ALTER TABLE peça
DROP FOREIGN KEY peça_ibfk_1;

ALTER TABLE posicio
DROP COLUMN fila;

ALTER TABLE posicio
DROP COLUMN columna;

ALTER TABLE posicio
ADD COLUMN casella  TINYINT NOT NULL UNIQUE;

ALTER TABLE peça
ADD COLUMN casella TINYINT,
ADD FOREIGN KEY (casella) REFERENCES posicio (casella);

-- 4 --
ALTER TABLE posicio
ADD COLUMN color VARCHAR(10) NOT NULL;

-- 5 --
ALTER TABLE moviment 
ADD CONSTRAINT `chk_segons` 
CHECK (segons > 60.0);

-- 6 -- 
RENAME TABLE peça to peces; 

