CREATE DATABASE Escasc;
USE Escasc;

CREATE TABLE posicio (
	id_posicio TINYINT PRIMARY KEY,
    fila CHAR(1) NOT NULL,
    columna TINYINT NOT NULL,
    CHECK (fila BETWEEN "A" AND "H"),
    CHECK (columna BETWEEN 1 AND 8)
);

CREATE TABLE peça (
	id_peça TINYINT PRIMARY KEY,
    tipus ENUM("rei", "dama","torre","alfil","cavall","peo") NOT NULL,
    color ENUM("blanco","negro") NOT NULL,
    id_posicio TINYINT UNIQUE,
    imatge BLOB,
    FOREIGN KEY (id_posicio) REFERENCES posicio (id_posicio)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

CREATE TABLE moviment (
	id_moviment INT PRIMARY KEY,
    id_peça TINYINT NOT NULL UNIQUE,
    id_posicio_inicial TINYINT NOT NULL UNIQUE,
    id_posicio_final TINYINT NOT NULL UNIQUE,
    segons DECIMAL(4,1) DEFAULT 0.0,
    descripcio TEXT,
    timestamp DATETIME,
    FOREIGN KEY (id_peça) REFERENCES peça (id_peça)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    CHECK (segons <= 120)
);