-- Modificacions

-- 1
ALTER TABLE moviment
ADD CONSTRAINT unique_timestamp UNIQUE (timestamp);

-- 2 
ALTER TABLE peça 
MODIFY id_posicio TINYINT NULL;

-- 3 a
ALTER TABLE peça
DROP FOREIGN KEY fk_peça_posicio;

ALTER TABLE peça
DROP COLUMN id_posicio;

-- 3 b
ALTER TABLE posicio
DROP COLUMN fila,
DROP COLUMN columna;

ALTER TABLE Posicio
ADD casella VARCHAR(2) NOT NULL UNIQUE;

-- 3 c
ALTER TABLE peça
ADD casella VARCHAR(2),
ADD CONSTRAINT fk_peça_casella
    FOREIGN KEY (casella)
    REFERENCES Posicio(casella)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

-- 4
ALTER TABLE Posicio
ADD color_casella ENUM('blanc','negre') NOT NULL;

-- 5
ALTER TABLE Moviment
DROP CONSTRAINT check_segons,
ADD CONSTRAINT check_segons_60 CHECK (segons <= 60.0);

-- 6
RENAME TABLE Peça TO Peces;