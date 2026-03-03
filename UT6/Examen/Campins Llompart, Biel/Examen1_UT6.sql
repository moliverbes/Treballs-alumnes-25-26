-- Creació base de dades
CREATE DATABASE Escacs;
USE Escacs;

CREATE TABLE posicio(
	id_posicio TINYINT PRIMARY KEY NOT NULL UNIQUE,
    fila CHAR(1) NOT NULL ,
    columna TINYINT NOT NULL ,
    CONSTRAINT check_fila CHECK(fila BETWEEN 'A' AND 'H'),
    CONSTRAINT check_columna CHECK (columna BETWEEN '1' AND '8'));

CREATE TABLE peça (
    id_peça TINYINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipus ENUM('rei','dama','torre','alfil','cavall','peó') NOT NULL,
    color ENUM('blanc','negre') NOT NULL,
    id_posicio TINYINT UNIQUE,
    imatge blob,
    CONSTRAINT fk_peça_posicio
        FOREIGN KEY (id_posicio)
        REFERENCES posicio(id_posicio)
        ON DELETE SET NULL
        ON UPDATE CASCADE);

CREATE TABLE moviment (
    id_moviment INT PRIMARY KEY AUTO_INCREMENT,
    id_peça TINYINT NOT NULL,
    id_posicio TINYINT NOT NULL,
    segons DECIMAL(4,1) DEFAULT (0.0),
    descripcio TEXT,
    timestamp DATETIME,
    CONSTRAINT check_segons CHECK (segons <= 120),
    CONSTRAINT fk_moviment_peça
        FOREIGN KEY (id_peça)
        REFERENCES Peça(id_peça)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_moviment_posicio
        FOREIGN KEY (id_posicio)
        REFERENCES Posicio(id_posicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE);


-- DROP DATABASE Escacs;