CREATE DATABASE Escacs;
USE Escacs;

CREATE TABLE Posicio(
	id_posicio TINYINT,
    fila CHAR(1) NOT NULL CHECK(fila BETWEEN 'A' AND 'H'),
    columna TINYINT NOT NULL CHECK(columna BETWEEN 1 AND 8 ),
	PRIMARY KEY (id_posicio)
);
CREATE TABLE Peça(
	id_peça TINYINT,
    tipus ENUM('rei','dama','torre','alfil','cavall','peó') NOT NULL,
    color ENUM('blanc','negre') NOT NULL,
    id_posicio TINYINT UNIQUE,
    imatge BLOB,
    PRIMARY KEY (id_peça),
    FOREIGN KEY (id_posicio) REFERENCES Posicio (id_posicio) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE TABLE Moviment(
	id_moviment INT,
    id_peça TINYINT NOT NULL,
    id_posicio_inicial TINYINT NOT NULL,
    id_posicio_final TINYINT NOT NULL,
    segons DECIMAL(4,1) CHECK (segons <120) DEFAULT 0.0,	
    descripcio TEXT,
    timestamp DATETIME ,
    PRIMARY KEY(id_moviment),
    FOREIGN KEY (id_peça) REFERENCES Peça(id_peça) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_posicio_inicial) REFERENCES Posicio(id_posicio)ON UPDATE CASCADE,
	FOREIGN KEY (id_posicio_final) REFERENCES Posicio(id_posicio)ON UPDATE CASCADE
);
