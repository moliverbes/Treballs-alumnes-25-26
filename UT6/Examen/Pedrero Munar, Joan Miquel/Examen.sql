CREATE DATABASE Escacs;
USE Escacs;

CREATE TABLE posicio(
id_posicio TINYINT PRIMARY KEY,
fila CHAR(1) NOT NULL CHECK (fila BETWEEN 'A' AND 'H'),
columna TINYINT NOT NULL CHECK (columna BETWEEN 1 AND 8)
);

CREATE TABLE peça(
id_peça TINYINT PRIMARY KEY,
tipus ENUM ('rei', 'dama', 'torre', 'alfil', 'cavall', 'peo') NOT NULL,
color ENUM ('blanc', 'negre') NOT NULL,
id_posicio TINYINT UNIQUE,
imatge BLOB,

CONSTRAINT peça_ibfk_1 FOREIGN KEY (id_posicio) REFERENCES posicio (id_posicio) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE moviment(
id_moviment INT PRIMARY KEY,
id_peça TINYINT NOT NULL,
id_posicio_inicial TINYINT NOT NULL,
id_posicio_final TINYINT NOT NULL,
segons DECIMAL CHECK (segons < 120) DEFAULT 0.0,
descripcio TEXT,
timestamp DATETIME,

FOREIGN KEY (id_peça) REFERENCES peça (id_peça) ON DELETE RESTRICT ON UPDATE CASCADE
);
