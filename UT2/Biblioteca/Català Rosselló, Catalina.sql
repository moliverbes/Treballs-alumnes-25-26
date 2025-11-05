/*
1. Dona d’alta una persona sòcia amb:
	-Document d’identitat “12345678A”
	-Nom “Anna Serra”
	-Telèfon “600123123”
	-Adreça electrònica “anna.serra@example.com”
	-La data d’alta ha de quedar establerta automàticament.
*/

INSERT INTO Socis
	(dni, nom, telefon, correu, data_alta)
    
VALUES
	('12345678A', 'Anna Serra', 600123123,
    'anna.serra@example.com', CURRENT_TIMESTAMP );
    
SELECT * FROM Socis;

/*
2. Dona d’alta una persona sòcia aportant només:
	-Nom “Marc Pons”.
*/

INSERT INTO Socis
	(nom)
    
VALUES
	('Marc Pons');
    
SELECT * FROM Socis;
DESCRIBE Socis;

-- Ens apareix un error perquè el camp dni està definit com a NOT NULL i no
-- té un valor per defecte. Per tant, és obligatori indicar-lo en l’INSERT.

/*
3. Dona d’alta una persona sòcia amb:
	-Document d’identitat “11111111A”
	-Nom “Joana Puig”
	-Telèfon “600555777”
	-Adreça electrònica “joana.puig@example.com”.
*/
INSERT INTO Socis
	(dni, nom, telefon, correu)

VALUES
	('11111111A', 'Joana Puig', 600555777, 'joana.puig@example.com');

SELECT * FROM Socis;
DESCRIBE Socis;

-- Ens apareix un error perquè el camp dni té una restricció UNIQUE, i el
-- valor que volem inserir ja existeix a la taula Socis. El mateix passaria si el
-- correu electrònic també fos duplicat.

/*
4. Afegeix una categoria nova:
	-Nom “Misteri”
	-Descripció “Trames i enigmes”.
*/

INSERT INTO Categories
	(nom, descripcio)

VALUES
	('Misteri', 'Trames i enigmes');

SELECT * FROM Categories;

/*
5. Afegeix una categoria nova:
	-Nom “Ciència”
	-Descripció “Coneixement científic”.
*/

INSERT INTO Categories
	(nom, descripcio)

VALUES
	('Ciència', 'Coneixement científic');

SELECT * FROM Categories;
DESCRIBE Categories;

-- Apareix un error perquè el camp nom de la taula Categories té una
-- restricció UNIQUE, i ja existeix una categoria amb aquest mateix nom.

/*
6. Dona d’alta un llibre amb:
	-Títol “Criptografia pràctica”
	-Autoria “J. Katz”
	-Any de publicació 2016
	-Quantitat d’exemplars 2
	-Assignat a la categoria anomenada “Ciència” (2).
*/

INSERT INTO Llibres
	(titol, autor, any_publicacio, exemplars, id_categoria)

VALUES 
	('Criptografia pràctica', 'J. Katz', 2016, 2, 2);

SELECT * FROM Llibres;

/*
7. Dona d’alta un llibre amb:
	-Títol “El vell arxivador”
	-Autoria “M. Antic”
	-Any de publicació 1875
	-Quantitat d’exemplars 1
	-Assignat a la categoria “Novel·la” (1).
*/

INSERT INTO Llibres
	(titol, autor, any_publicacio, exemplars, id_categoria)

VALUES 
	('El vell arxivador', 'M. Antic', 1875, 1, 1);
    
SELECT * FROM Llibres;

-- Dona error perquè el camp any_publicacio té una restricció CHECK que
-- obliga el valor a ser igual o superior a 1900. En aquest cas, el valor 1875 no
-- la compleix.

/*
8. Dona d’alta un llibre amb:
	-Títol “Zeros i uns”
	-Autoria “L. Bit”
	-Any de publicació 2021
	-Quantitat d’exemplars − 3
	-Assignat a la categoria “Ciència” (2).
*/

INSERT INTO Llibres
	(titol, autor, any_publicacio, exemplars, id_categoria)

VALUES
	('Zeros i uns', 'L. Bit', 2021, 3, 2);
    
SELECT * FROM Llibres;

/*
9. Dona d’alta un llibre amb:
	-Títol “Pensar ràpid”
	-Autoria “D. Kahneman”
	-Any de publicació 2011
	-Quantitat d’exemplars 2
	-Assignat a la categoria “Filosofia”.
*/

INSERT INTO Llibres
	(titol, autor, any_publicacio, exemplars, id_categoria)

VALUES
	('Pensar ràpid', 'D. Kahneman', 2011, 2, 'Filosofia');
    
SELECT * FROM Llibres;

-- Dona error perquè la categoria “Filosofia” no existeix a la taula Categories. 
-- A més, el camp id_categoria és de tipus numèric i ha de rebre un identificador (és a dir, un número),
-- no el nom de la categoria, per text.

-- Encara que aquesta consulta no es pot executar per aquests motius, he mantingut el nom de la categoria
-- dins la sentència per tenir una referència visual de com s’hauria de "realitzar".

/*
10. Registra un préstec per a:
	-Persona amb document “33333333C”
	-Llibre titulat “Bases de dades per a tothom”
	-La data de cessió ha de quedar establerta automàticament
	-L’estat inicial per defecte.
*/

INSERT INTO Prestecs
	(id_soci, id_llibre, data_prestec)
VALUES
	(3, 1, CURRENT_TIMESTAMP);
    
SELECT * FROM Prestecs;

/*
11. Registra un préstec per a:
	-Persona amb document “22222222B”
	-Llibre titulat “La porta dels enigmes”
	-Data de devolució “2025-09-30”.
*/

INSERT INTO Prestecs
	(id_soci, id_llibre, data_retorn)
    
VALUES
	(2, 3, '2025-09-30');
    
SELECT * FROM Prestecs;
DESCRIBE Prestecs;

-- Dona error per dos motius:
-- 1. El camp “data_prestec” és obligatori (NOT NULL) i no s’ha especificat cap valor.
-- 2. La restricció CHECK obliga que “data_retorn” sigui igual o posterior a “data_prestec”,
-- però com que aquesta no està definida, la condició no es pot verificar i genera error.

/*
12. Registra un préstec per a:
	-Persona amb document “99999999Z”
	-Llibre titulat “El bosc dels llibres”.
*/
INSERT INTO Prestecs
	(id_soci, id_llibre)
    
VALUES
	('99999999Z', 2);
    
SELECT * FROM Prestecs;

-- Dona error perquè el dni “99999999Z” no existeix a la taula Socis. 
-- A més, el camp id_soci és de tipus numèric i ha de rebre un identificador (és a dir, un número),
-- no el nom del dni, per text.

-- Encara que aquesta consulta no es pot executar per aquests motius, he mantingut el dni.
-- dins la sentència per tenir una referència visual de com s’hauria de "realitzar".

/*
13. Actualitza un préstec existent per marcar-lo com retornat. El que correspon
al soci amb document “11111111A ” (1) i llibre “La porta dels enigmes” (3)
	-Fixa l’estat a “retornat”
	-Data de devolució a “2025-11-05”.
*/

UPDATE Prestecs
SET estat = 'retornat', data_retorn = '2025-11-05'
WHERE id_soci = 1 AND id_llibre = 3;

SELECT * FROM Prestecs
WHERE id_soci = 1 AND id_llibre = 3;

/*
14. Modifica la data de devolució d’un préstec existent. El que correspon al
soci amb document “22222222B”(2) i al llibre “El bosc dels llibres” (2)
	-Estableix la data de devolució a “2025-09-20”.
*/

UPDATE Prestecs
SET data_retorn = '2025-09-20'
WHERE id_soci = 2 AND id_llibre = 2;

SELECT * FROM Prestecs
WHERE id_soci = 2 AND id_llibre = 2;

-- No es pot actualitzar perquè el camp data_retorn té una restricció CHECK
-- que obliga que sigui NULL o una data igual o posterior a data_prestec. En
-- aquest cas, la data introduïda és anterior a data_prestec, per això dona
-- error.

/*
15. Canvia l’adreça electrònica de la persona amb  nom “Pere Roca” 
	-Nova adreça “pere.nou@example.com”.
*/

UPDATE  Socis
SET correu = 'pere.nou@example.com'
WHERE nom LIKE 'Pere Roca';

SELECT * FROM Socis
WHERE nom LIKE 'Pere Roca';

/*
16. Canvia l’adreça electrònica de la persona amb nom “Marta Vidal”
	-Nova adreça “joan.puig@example.com”.
*/

UPDATE  Socis
SET correu = 'joan.puig@example.com'
WHERE nom LIKE 'Marta Vidal';

SELECT * FROM Socis
WHERE nom LIKE 'Marta Vidal';

-- Ens apareix un error perquè el camp correu té una restricció UNIQUE, i el valor
-- que volem inserir ja existeix a la taula Socis. 

/*
17. Actualitza la quantitat d’exemplars del llibre amb títol “Bases de dades
per a tothom”
	-Deixa el total d’exemplars en 4.
*/

UPDATE Llibres
SET exemplars = 4
WHERE titol LIKE 'Bases de dades per a tothom';

SELECT * FROM Llibres
WHERE titol LIKE 'Bases de dades per a tothom';

/*
18. Actualitza la quantitat d’exemplars del llibre amb títol “El bosc dels llibres”
	-Deixa el total d’exemplars en −1.
*/

UPDATE Llibres
SET exemplars = -1
WHERE titol LIKE 'El bosc dels llibres';

SELECT * FROM Llibres
WHERE titol LIKE 'El bosc dels llibres';

-- Dona error perquè el camp exemplars té una restricció CHECK que obliga
-- que el valor sigui zero o positiu. Com s’intenta assignar un valor negatiu, la
--  base de dades rebutja l’actualització.

/*
19. Elimina la categoria amb el nom “Ciència”
*/

DELETE FROM Categories 
WHERE id_categoria = 2;

SELECT * FROM Categories
WHERE nom = 'Ciència';

-- No es pot eliminar la categoria perquè està referenciada per altres registres
-- a la taula Llibres mitjançant una clau forana (FOREIGN KEY). Això viola la
-- integritat referencial i provoca un error.

/*
20. Elimina la persona sòcia identificada per document d’identitat “11111111A”.
*/

DELETE FROM Socis
WHERE id_soci = 1;

SELECT * FROM Socis
WHERE id_soci = 1;

-- No es pot eliminar el soci perquè està referenciat a la taula Prestecs
-- mitjançant una clau forana (FOREIGN KEY). Això impedeix l’eliminació per
-- mantenir la integritat de les dades.