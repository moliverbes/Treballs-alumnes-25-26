CREATE DATABASE IF NOT EXISTS Escacs;
USE Escacs;

CREATE TABLE posicio (
	id_posicio TINYINT,
    fila CHAR(1) NOT NULL,
    columna TINYINT,
    
    CONSTRAINT pk_posicio PRIMARY KEY (id_posicio),
    CONSTRAINT chk_fila CHECK (fila = 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H'),
    CONSTRAINT chk_columna CHECK (columna BETWEEN 1 AND 8)
);

CREATE TABLE peça (
	id_peça TINYINT,
    tipus ENUM('rei', 'dama', 'torre', 'alfil', 'cavall', 'peó') NOT NULL,
    color ENUM('blanc', 'negre') NOT NULL,
    id_posicio TINYINT UNIQUE,
    imatge BLOB,
    
	CONSTRAINT pk_peça PRIMARY KEY (id_peça),
    CONSTRAINT fk_posicio FOREIGN KEY (id_posicio) REFERENCES posicio(id_posicio)
		ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE moviment (
	id_moviment INT,
    id_peça TINYINT NOT NULL,
    id_posicio_inicial TINYINT NOT NULL,
    id_posicio_final TINYINT NOT NULL,
    segons DECIMAL(4,1) DEFAULT 0.0,
    descripcio TEXT,
    timestamp DATETIME,
    
	CONSTRAINT pk_moviment PRIMARY KEY (id_moviment),
    CONSTRAINT fk_peça FOREIGN KEY (id_peça) REFERENCES peça(id_peça)
		ON DELETE RESTRICT
        ON UPDATE CASCADE,
    -- CONSTRAINT fk_posicio_inicial FOREIGN KEY (id_posicio_inicial) REFERENCES moviment(id_posicio),
    -- CONSTRAINT fk_posicio_final FOREIGN KEY (id_posicio_final) REFERENCES moviment(id_posicio_inicial),
    CONSTRAINT chk_segons CHECK (segons <= 120)
);

-- No sabia com fer per crear les foreign keys de posicio inicial i final