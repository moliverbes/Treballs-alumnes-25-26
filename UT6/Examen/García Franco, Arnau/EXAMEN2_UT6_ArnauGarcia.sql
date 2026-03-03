USE Escacs;
-- Modificacions Escacs Arnau Garica
/*1. Afegeix una restricció UNIQUE a la columna timestamp de la taula
Moviment per assegurar-nos que no es puguin registrar dos moviments
en el mateix instant. */
ALTER TABLE moviment
MODIFY COLUMN timestamp  DATETIME UNIQUE;

/*2. Modifica la taula Peça per permetre que el camp id_posicio accepti
valors NULL */
ALTER TABLE peça
MODIFY  id_posicio TINYINT NULL;

/*A la taula Peça volem canviar la clau forana que apunta a la taula
Posició. Llavors, heu de fer: */
-- a. Eliminar la columna id_posicio de Peça
ALTER TABLE peça
DROP FOREIGN KEY peça_ibfk_1;
ALTER TABLE peça
DROP id_posicio;
/*b. Eliminam les columnes fila i columna de Posició i cream una que
es digui casella que emmagatzemi els dos valors junts. És a dir, els
valors de casella podran ser “A1”, “H2”, “B3”,... Aquesta nova
columna no pot tenir el valor NULL i ha de ser única.*/
ALTER TABLE posicio
DROP fila;
ALTER TABLE posicio
DROP columna;
ALTER TABLE posicio
ADD COLUMN casella ENUM('A1','A2','A3','B1', 'B2', 'C1', 'C2', 'D1', 'D2', 'E1','E2', 'H1', 'H2') NOT NULL UNIQUE;
/*c. Crea una nova columna casella a Peça i que sigui la clau forana
que apunti a l’anterior.*/
ALTER TABLE peça 
ADD COLUMN casella ENUM ('A1','A2','A3','B1', 'B2', 'C1', 'C2', 'D1', 'D2', 'E1','E2', 'H1', 'H2') NOT NULL UNIQUE;
ALTER TABLE peça
ADD CONSTRAINT
FOREIGN KEY (casella) REFERENCES posicio (casella) ;
/*4. Afegeix un nou atribut a la taula Posició que indiqui de quin color és la
casella i que no permeti valors NULL.*/
ALTER TABLE posicio 
ADD COLUMN color_casella ENUM('blanc', 'negre') NOT NULL;
/*5. Afegeix una restricció sobre la columna segons de la taula Moviment, que
no permeti que tengui un valor major a 60.0*/
-- Tenim un check que no permet valors majors a 120 i aquest check no permet valors majors que 60, per tant podem borrar el primer check en el meu cas no se com fer-ho
-- ALTER TABLE moviment
-- DROP segons;
-- ALTER TABLE moviment
-- DROP moviment_chk_1;
ALTER TABLE moviment
MODIFY COLUMN segons DECIMAL(4.1) CONSTRAINT CHECK(segons > 60.0);
/*6. Canvia el nom de la taula Peça per Peces.*/
ALTER TABLE peça
RENAME peces;
