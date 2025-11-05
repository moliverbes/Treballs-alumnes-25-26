use Biblioteca_petita;
-- Dona d’alta una persona sòcia amb: document d’identitat “12345678A”
-- nom “Anna Serra” telèfon “600123123” adreça electrònica “anna.serra@example.com” La data d’alta ha de quedar establerta automàticament.

INSERT INTO Socis (dni, nom, telefon,correu)
VALUE 
	('12345678A','Anna Serra','600123123','anna.serra@example.com');
    
    
-- Dona d’alta una persona sòcia aportant només: nom “Marc Pons”.
INSERT INTO Socis (nom)
VALUE 
	('Marc Pons');
-- No es possible perque la columna dni, data_alta, nom, e id_soci no poden ser nulls

describe Socis;

-- 3Dona d’alta una persona sòcia amb: document d’identitat “11111111A” nom “Joana Puig” telèfon “600555777” adreça electrònica “joana.puig@example.com”.
INSERT INTO Socis (dni, nom, telefon,correu)
VALUE 
	('11111111A','Joana Puig','600555777','joana.puig@example.com');
-- Ya hi ha un registre amb aquest dni

-- 4 Afegeix una categoria nova: nom “Misteri” descripció “Trames i enigmes”.

INSERT INTO Categories (nom, descripcio)
VALUE 
('Misteri','Trames i enigmes');
SELECT dni FROM Socis;

-- 5 Afegeix una categoria nova: nom “Ciència” descripció “Coneixement científic”.

INSERT INTO Categories (nom, descripcio)
VALUE
('Ciència','Coneixament científic');
-- ya hi ha un nom que es diu Ciencia a la taula categoria

-- 6 Dona d’alta un llibre amb: títol “Criptografia pràctica” autoria “J. Katz” any de publicació 2016 quantitat d’exemplars 2 assignat a la categoria anomenada “Ciència”.
INSERT INTO Llibres (titol, autor, any_publicacio, exemplars)
VALUE
	('Criptografia pràctica','J.Katz',2016,2);

-- 7Dona d’alta un llibre amb: títol “El vell arxivador” autoria “M. Antic” any de publicació 1875 quantitat d’exemplars 1 assignat a la categoria “Novel·la”.
INSERT INTO Llibres (titol, autor, any_publicacio, exemplars)
VALUE 
	 ('El vell arxivador','M.Antic',1875,1);
SELECT *FROM Llibres;
describe Llibres;

CREATE TABLE `Llibres` (
  `id_llibre` int NOT NULL AUTO_INCREMENT,
  `titol` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `autor` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `any_publicacio` year DEFAULT NULL,
  `exemplars` int DEFAULT '1',
  `id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_llibre`),
  KEY `fk_categoria` (`id_categoria`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `Categories` (`id_categoria`),
  CONSTRAINT `Llibres_chk_1` CHECK ((`any_publicacio` >= 1900)),
  CONSTRAINT `Llibres_chk_2` CHECK ((`exemplars` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Com podem veure es minim que arriba sa base de dades es1 990 cap adalt

-- 8 Dona d’alta un llibre amb: títol “Zeros i uns” autoria “L. Bit” any de publicació 2021 quantitat d’exemplars −3 assignat a la categoria “Ciència”.

INSERT INTO Llibres (titol,autor,any_publicacio,exemplars)
	VALUE
			('Zeros i uns','L.Bit',2021,'-3');
CREATE TABLE `Llibres` (
  `id_llibre` int NOT NULL AUTO_INCREMENT,
  `titol` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `autor` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `any_publicacio` year DEFAULT NULL,
  `exemplars` int DEFAULT '1',
  `id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_llibre`),
  KEY `fk_categoria` (`id_categoria`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `Categories` (`id_categoria`),
  CONSTRAINT `Llibres_chk_1` CHECK ((`any_publicacio` >= 1900)),
  CONSTRAINT `Llibres_chk_2` CHECK ((`exemplars` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Es mínim que pot haber d'exemplar es 0 i l'enunciat posa menys 3 (-3).7
UPDATE Llibres
SET exemplars = -1
WHERE id_llibre = 1;
-- 9 Dona d’alta un llibre amb: títol “Pensar ràpid” autoria “D. Kahneman” any de publicació 2011 quantitat d’exemplars 2 assignat a la categoria “Filosofia”.
INSERT INTO Llibres (titol,autor,any_publicacio,exemplars)
VALUE 
('Pensar ràpid','D.kahneman',2011,2);
-- 10 Registra un préstec per a: persona amb document “33333333C” llibre titulat “Bases de dades per a tothom” 
-- La data de cessió ha de quedar establerta automàticament l’estat inicial per defecte.

INSERT INTO Prestecs (data_retorn)
value
(CURRENT_TIMESTAMP);

SELECT * FROM Prestecs;
SELECT * FROM Llibres;
SELECT * FROM Socis;

-- 11 Registra un préstec per a: persona amb document “22222222B” llibre titulat “La porta dels enigmes” data de devolució “2025-09-30”.
-- No se pot fer perque la data de prestec ha de ser actual superant la data de devolució ;

-- 12 Registra un préstec per a: persona amb document “99999999Z” llibre titulat “El bosc dels llibres”.
-- No se pot crear perque aquesta persona no existeix;


-- 13 Actualitza un préstec existent per marcar-lo com retornat. El que correspon al soci amb document “11111111A” i llibre “La porta dels enigmes” 
-- fixa l’estat a “retornat” data de devolució a “2025-11-05”.
UPDATE Prestecs 
SET data_retorn= '2025-11-05', estat = 'retornat'
WHERE id_prestec = 1;
-- 14 Modifica la data de devolució d’un préstec existent. El que correspon al soci amb document “22222222B” i al llibre “El bosc dels llibres” 
-- estableix la data de devolució a “2025-09-20”.
-- Imposible ja que la data_prestec es del 2025-09-25 i no pot ser que retorni algo que encara no ha rebut

-- 15. Canvia l’adreça electrònica de la persona amb nom “Pere Roca” - nova adreça “pere.nou@example.com”.
SELECT * FROM Socis;
UPDATE Socis
SET correu = 'pere.nou@exemple.com'
WHERE id_soci = 1;

-- 16. Canvia l’adreça electrònica de la persona amb nom “Marta Vidal” - nova adreça “joan.puig@example.com”.
UPDATE Socis 
SET correu = 'joan.puig@example.com'
WHERE id_soci = 2;

-- 17. Actualitza la quantitat d’exemplars del llibre amb títol “Bases de dades per a tothom” - deixa el total d’exemplars en 4.
SELECT * FROM Llibres;
UPDATE Llibres
SET exemplars = 4
WHERE id_llibre = 1;

-- 18. Actualitza la quantitat d’exemplars del llibre amb títol “El bosc dels llibres” - deixa el total d’exemplars en −1.
CREATE TABLE `Llibres` (
  `id_llibre` int NOT NULL AUTO_INCREMENT,
  `titol` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `autor` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `any_publicacio` year DEFAULT NULL,
  `exemplars` int DEFAULT '1',
  `id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_llibre`),
  KEY `fk_categoria` (`id_categoria`),
  CONSTRAINT `fk_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `Categories` (`id_categoria`),
  CONSTRAINT `Llibres_chk_1` CHECK ((`any_publicacio` >= 1900)),
  CONSTRAINT `Llibres_chk_2` CHECK ((`exemplars` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- No pot haber exemplar menors que 0
-- 19. Elimina la categoria amb el nom “Ciència”.
SELECT * FROM Categories;
CREATE TABLE `Categories` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Sense descripció',
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nom` (`nom`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DESCRIBE Categories;
-- No se pot eliminar Ciencìes de la categories de la columna nom perque no pot ser null.
-- 20. Elimina la persona sòcia identificada per document d’identitat “11111111A”
SELECT * FROM Socis;
CREATE TABLE `Socis` (
  `id_soci` int NOT NULL AUTO_INCREMENT,
  `dni` char(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefon` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correu` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_alta` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`id_soci`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `correu` (`correu`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- Imposible ja que id_soci no pot ser null
DELETE FROM Socis
WHERE id_soci = 1;


