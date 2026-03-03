-- MODIFICACIONS --

-- ACTIVITAT 1 --
ALTER TABLE moviment
MODIFY COLUMN timestamp DATETIME UNIQUE;

-- ACTIVITAT 2 --
ALTER TABLE peça
MODIFY COLUMN id_posicio TINYINT UNIQUE;

-- Aquesta columna ja era null de forma predeterminada.

-- ACTIVITAT 3 --
ALTER TABLE peça
DROP CONSTRAINT peça_ibfk_1,
DROP COLUMN id_posicio ;

ALTER TABLE posicio
DROP COLUMN fila,
DROP COLUMN columna;

CREATE TABLE casella(
id_casella INT PRIMARY KEY,
posicio_tablero VARCHAR(2) NOT NULL UNIQUE
);

ALTER TABLE peça
ADD COLUMN id_casella INT,
ADD CONSTRAINT FOREIGN KEY (id_casella) REFERENCES casella(id_casella);

-- Se ha eliminat se referencia que tenia de la clau forana de peça per poder, eliminar la id, de aquesta,
-- A continuacio se han eliminat de la taula de posicio, les columnes "files" i "columnes"
-- Cream la taula casella amb una columna que emegatezema la posicio exacta.
-- Finalment cream a peça una columna id_casella, i cream una foregin key, refernciant a la taula. 

-- ACTIVITAT 4 --
ALTER TABLE posicio
ADD COLUMN color_casella VARCHAR(100) NOT NULL;

-- ACTIVITAT 5 --
ALTER TABLE moviment
DROP CONSTRAINT moviment_chk_1,
MODIFY COLUMN segons DECIMAL(4,1) CHECK (segons <= 60.0);

-- Primer hem de eliminar, el check anterior, ja que es menys restrictiu, i en crear aquest, ja no es necesari.

-- ACTIVITAT 6 --
RENAME TABLE peça TO peces;
