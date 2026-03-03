CREATE DATABASE escacs;
USE escacs;
CREATE TABLE posicio (
id_posicio TINYINT UNIQUE,
fila CHAR(1) NOT NULL, CHECK(fila LIKE "A""B""C""D""E""F""G""H"),
columna TINYINT NOT NULL, CHECK(columna BETWEEN 1 AND 8),
PRIMARY KEY(id_posicio)  
);
CREATE TABLE peça(
id_peça TINYINT,
tipus ENUM("rei","dama", "torre", "alfil", "cavall" ,"peó") NOT NULL,
color ENUM("blanc","negre") NOT NULL,
id_posicio TINYINT,
imatge BLOB,
PRIMARY KEY(id_peça),
FOREIGN KEY(id_posicio) REFERENCES posicio(id_posicio) ON DELETE SET NULL 
);
CREATE TABLE moviment(
id_moviment INT DEFAULT 0.0,
id_peça TINYINT NOT NULL,
id_posicio_inicial TINYINT NOT NULL,
id_posicio_final TINYINT NOT NULL,
segons DECIMAL(4,1), CHECK(segons <= 120),
descripcio TEXT,
timestamp DATETIME,
PRIMARY KEY(id_moviment),
FOREIGN KEY(id_peça) REFERENCES peça(id_peça) ,
FOREIGN KEY(id_posicio_inicial) REFERENCES posicio(id_posicio) ON UPDATE CASCADE,
FOREIGN KEY(id_posicio_final) REFERENCES posicio(id_posicio) ON UPDATE CASCADE
);