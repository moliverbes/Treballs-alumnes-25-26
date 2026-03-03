CREATE DATABASE IF NOT EXISTS Escacs;

USE Escacs;

CREATE TABLE posicio(
id_posicio TINYINT PRIMARY KEY,
fila CHAR(1) NOT NULL CHECK (fila BETWEEN 'A' AND 'H'),
columna TINYINT NOT NULL CHECK (columna BETWEEN 1 AND 8)
);

CREATE TABLE peça(
id_peça TINYINT PRIMARY KEY,
tipus ENUM('rei','dama','torre','alfil','cavall','peó') NOT NULL,
color ENUM('blanc','negre') NOT NULL,
id_posicio TINYINT UNIQUE,
imatge BLOB
);

CREATE TABLE moviment(
id_moviment INT PRIMARY KEY,
id_peça TINYINT NOT NULL,
id_posicio_inicial TINYINT NOT NULL,
id_posicio_final TINYINT NOT NULL,
segons DECIMAL(4,1) CHECK (segons <= 120) DEFAULT '0.0',
descripcio TEXT,
timestamp DATETIME
);

ALTER TABLE moviment
ADD CONSTRAINT fk_moviment_peça
FOREIGN KEY (id_peça) REFERENCES peça(id_peça)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE moviment
ADD CONSTRAINT fk_moviment_posicio_inicial
FOREIGN KEY (id_posicio_inicial) REFERENCES posicio(id_posicio)
ON UPDATE CASCADE;

ALTER TABLE moviment
ADD CONSTRAINT fk_moviment_posicio_final
FOREIGN KEY (id_posicio_final) REFERENCES posicio(id_posicio)
ON UPDATE CASCADE;

ALTER TABLE peça 
ADD CONSTRAINT fk_peça_posicio
FOREIGN KEY (id_posicio) REFERENCES posicio(id_posicio)
ON DELETE SET NULL
ON UPDATE CASCADE;

