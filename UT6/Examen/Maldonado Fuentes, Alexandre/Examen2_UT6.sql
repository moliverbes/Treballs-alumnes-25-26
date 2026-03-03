
-- 1
ALTER TABLE	Moviment
	MODIFY COLUMN timestamp DATETIME UNIQUE;
    
    
-- 2
ALTER TABLE Peça
	MODIFY COLUMN id_posicio TINYINT UNIQUE NOT NULL; 

-- 3 
-- a
ALTER TABLE Peça
	DROP CONSTRAINT Peça_ibfk_1;
ALTER TABLE Peça
    DROP COLUMN id_posicio;
-- b
ALTER TABLE Posicio
    DROP COLUMN fila;
ALTER TABLE Posicio
	DROP COLUMN columna;
/*
ALTER TABLE Posicio
	ADD COLUMN casella  NOT NULL UNIQUE; -- No ho he sabut fer

-- c
ALTER TABLE Peça
	ADD FOREIGN KEY (casella) REFERENCES Posicio(casella); -- Si ho he pogut fer(crec) però està relacionada amb la anterior i per això no funciona
 */   
 
 
-- 4
ALTER TABLE Posicio
	ADD COLUMN color_casella ENUM('blanc','negre') NOT NULL;
    
    
-- 5
ALTER TABLE Moviment
	ADD CONSTRAINT segons CHECK (segons <60);
ALTER TABLE Moviment
	DROP CONSTRAINT Moviment_chk_1;
    
    
-- 6
RENAME TABLE Peça TO Peces;
    
    
    
    
    
    