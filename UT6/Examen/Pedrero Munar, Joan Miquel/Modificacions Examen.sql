-- La myaoria estan malament,perque necesit constraint
-- 1
ALTER TABLE moviment
MODIFY timestamp DATETIME UNIQUE;

-- 2 Aquesta hem dona malament no l'he sabut solucionar

ALTER TABLE peça
DROP id_posicio;

ALTER TABLE peça
ADD COLUMN id_posicio TINYINT NOT NULL; -- Malament perque no he pogut eliminar la id_posicio enterior

-- 3 Malament
-- a
ALTER TABLE peça
DROP COLUMN id_posicio;

-- b
ALTER TABLE posicio
DROP COLUMN fila;

ALTER TABLE posicio
DROP COLUMN columna;

ALTER TABLE posicio
ADD casella TINYINT NOT NULL UNIQUE; -- Cada columna nomes pot tenir un valor, en aquest cas li he posat TINYINT, pero no amb deixa afegir un altre valor

-- c
ALTER TABLE peça
ADD FOREIGN KEY (casella) REFERENCES casella (casella);

-- 4 Malament
ALTER TABLE posicio
MODIFY casella TINYINT NOT NULL UNIQUE;

-- 5
ALTER TABLE moviment
MODIFY segons DECIMAL CHECK (segons < 60);

-- 6 Malament
ALTER TABLE peça
RENAME TABLE peça TO peces;