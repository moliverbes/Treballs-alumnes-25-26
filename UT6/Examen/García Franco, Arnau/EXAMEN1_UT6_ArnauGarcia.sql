-- Creacio de la BSD Escacs Arnau Garcia
CREATE DATABASE Escacs;
USE Escacs;

CREATE TABLE posicio (
			id_posicio TINYINT PRIMARY KEY,
            fila CHAR(1) NOT NULL CONSTRAINT CHECK(fila BETWEEN 'A' AND 'H'),
            columna TINYINT NOT NULL CONSTRAINT CHECK(columna BETWEEN 1 AND 8)
            );
            
CREATE TABLE peça (
			id_peça TINYINT PRIMARY KEY UNIQUE,
            tipus ENUM('rei','dama', 'torre', 'alfil', 'cavall','peó') NOT NULL, 
            color ENUM('blanc', 'negre') NOT NULL,
            id_posicio TINYINT,
            imatge BLOB,
          FOREIGN KEY (id_posicio) REFERENCES posicio (id_posicio)  ON DELETE SET NULL 
          ON UPDATE  CASCADE
          );
CREATE TABLE moviment (
			id_moviment INT PRIMARY KEY,
            id_peça TINYINT NOT NULL,
            id_posicio_inicial TINYINT NOT NULL,
            id_posicio_final TINYINT NOT NULL,
            segons DECIMAL (4,1) CONSTRAINT CHECK(segons > 120) DEFAULT 0.0,
            descripcio TEXT,
            timestamp DATETIME,
            FOREIGN KEY (id_peça) REFERENCES peça (id_peça) ON DELETE RESTRICT ON update CASCADE,
            FOREIGN KEY (id_posicio_final) REFERENCES posicio (id_posicio) ON update CASCADE,
			FOREIGN KEY (id_posicio_inicial) REFERENCES posicio (id_posicio) ON update CASCADE
             );
	

            
            
          
           
            