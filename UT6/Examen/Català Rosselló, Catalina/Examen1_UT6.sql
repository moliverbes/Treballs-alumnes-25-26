CREATE DATABASE Escacs;
USE Escacs;

CREATE TABLE posicio(
id_posicio TINYINT PRIMARY KEY ,
fila CHAR(1) NOT NULL CHECK (fila LIKE ('A' OR 'B' OR 'C' OR 'D' OR 'E' OR 'F' OR 'G' OR 'H')),
columna TINYINT CHECK (columna >= 1 AND columna <=8)
);

CREATE TABLE peça(
id_peça TINYINT PRIMARY KEY,
tipus ENUM('rei','dama', 'torre', 'alfil', 'cavall', 'peó') NOT NULL,
color ENUM('blanc', 'negre') NOT NULL,
id_posicio TINYINT UNIQUE,
imatge BLOB,
FOREIGN KEY (id_posicio) REFERENCES posicio(id_posicio) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE moviment(
id_moviment INT PRIMARY KEY,
id_peça TINYINT NOT NULL,
id_posicio_inicial TINYINT NOT NULL,
id_posicio_final TINYINT NOT NULL,
segons DECIMAL(4,1) CHECK (segons <= 120) DEFAULT 0.0,
descripcio TEXT,
timestamp DATETIME,

FOREIGN KEY (id_peça) REFERENCES peça(id_peça) ON UPDATE CASCADE,
FOREIGN KEY (id_posicio_inicial) REFERENCES posicio(id_posicio) ON UPDATE CASCADE,
FOREIGN KEY (id_posicio_final) REFERENCES posicio(id_posicio) ON UPDATE CASCADE
);

