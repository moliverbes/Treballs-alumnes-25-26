-- 1. Dona d’alta una persona sòcia amb:
--    document d’identitat “12345678A”
--    nom “Anna Serra”
--    telèfon “600123123”
--    adreça electrònica “anna.serra@example.com”
--    La data d’alta ha de quedar establerta automàticament.
INSERT INTO socis(dni, nom, telefon, correu)
VALUES ("12345678A","Anna Serra","600123123","anna.serra@example.com");

-- 2. Dona d’alta una persona sòcia aportant només:
--    nom “Marc Pons”.
INSERT INTO socis(nom)
VALUES ("Marc Pons");
-- Dona error perque dni no té cap valor.

-- 3. Dona d’alta una persona sòcia amb:
--    document d’identitat “11111111A”
--    nom “Joana Puig”
--    telèfon “600555777”
--    adreça electrònica “joana.puig@example.com”.
INSERT INTO socis(dni,nom,telefon,correu)
VALUES ("11111111A","Joana Puig","600555777","joana.puig@example.com");
-- Dona error perque el dni esta duplicat.

-- 4. Afegeix una categoria nova:
--    nom “Misteri”
--    descripció “Trames i enigmes”.
INSERT INTO categories(nom, descripcio)
VALUES ("Misteri","Trames i enigmes");

-- 5. Afegeix una categoria nova:
--    nom “Ciència”
--    descripció “Coneixement científic”.
INSERT INTO categories(nom, descripcio)
VALUES ("Ciència","Coneixement científic");
-- Dona error perque el nom de categoria Ciència esta duplicat.

-- 6. Dona d’alta un llibre amb:
--    títol “Criptografia pràctica”
--    autoria “J. Katz”
--    any de publicació 2016
--    quantitat d’exemplars 2
--    assignat a la categoria anomenada “Ciència”.
INSERT INTO llibres(titol, autor, any_publicacio, exemplars, id_categoria)
VALUES ("Criptografia pràctica","J. Katz","2016",2,"2");

-- 7. Dona d’alta un llibre amb:
--    títol “El vell arxivador”
--    autoria “M. Antic”
--    any de publicació 1875
--    quantitat d’exemplars 1
--    assignat a la categoria “Novel·la”.
INSERT INTO llibres(titol, autor, any_publicacio, exemplars, id_categoria)
VALUES ("El vell arxivador","M. Antic","1875",1,"1");
-- Dona error perque el valor a l'any de publicació esta fora del rang.

-- 8. Dona d’alta un llibre amb:
--    títol “Zeros i uns”
--    autoria “L. Bit”
--    any de publicació 2021
--    quantitat d’exemplars −3
--    assignat a la categoria “Ciència”.
INSERT INTO llibres(titol, autor, any_publicacio, exemplars, id_categoria)
VALUES ("Zeros i uns","L. Bit","2021",-3,"2");
-- Dona error perque no cumpleix les normes establertes a la columna exemplars.

-- 9. Dona d’alta un llibre amb:
--    títol “Pensar ràpid”
--    autoria “D. Kahneman”
--    any de publicació 2011
--    quantitat d’exemplars 2
--    assignat a la categoria “Filosofia”.
INSERT INTO llibres(titol, autor, any_publicacio, exemplars, id_categoria)
VALUES ("Pensar ràpid","D. Kahneman","2011",2,NULL);

-- 10. Registra un préstec per a:
--     persona amb document “33333333C”
--     llibre titulat “Bases de dades per a tothom”
--     La data de cessió ha de quedar establerta automàticament
--     l’estat inicial per defecte.
INSERT INTO prestecs(id_soci, id_llibre)
VALUES (3,1);

-- 11. Registra un préstec per a:
--     persona amb document “22222222B”
--     llibre titulat “La porta dels enigmes”
--     data de devolució “2025-09-30”.
INSERT INTO prestecs(id_soci, id_llibre, data_prestec)
VALUES (2,3,"2025-09-30");

-- 12. Registra un préstec per a:
--     persona amb document “99999999Z”
--     llibre titulat “El bosc dels llibres”.
INSERT INTO prestecs(id_soci, id_llibre)
VALUES (NULL,2,"2025-09-30");
-- Dona error perque no pot estar en NULL la columna id_soci

-- 13. Actualitza un préstec existent per marcar-lo com retornat. El que correspon al soci amb document “11111111A” i llibre “La porta dels enigmes”:
--     fixa l’estat a “retornat”
--     data de devolució a “2025-11-05”.
UPDATE prestecs
SET estat = "retornat"
WHERE id_soci=1 AND id_llibre = 3;

-- 14. Modifica la data de devolució d’un préstec existent. El que correspon al soci amb document “22222222B” i al llibre “El bosc dels llibres”:
--     estableix la data de devolució a “2025-09-20”.
UPDATE prestecs
SET data_prestec = "2025-09-20"
WHERE id_soci = 2 AND id_llibre = 2; 

-- 15. Canvia l’adreça electrònica de la persona amb nom “Pere Roca”:
--     nova adreça “pere.nou@example.com”.
UPDATE socis
SET correu = "pere.nou@example.com"
WHERE nom LIKE "Pere Roca";

-- 16. Canvia l’adreça electrònica de la persona amb nom “Marta Vidal”:
--     nova adreça “joan.puig@example.com”.
UPDATE socis
SET correu = "joan.puig@example.com"
WHERE nom LIKE "Marta Vidal";
-- Dona error perque el correu esta duplicat.

-- 17. Actualitza la quantitat d’exemplars del llibre amb títol “Bases de dades per a tothom”:
--     deixa el total d’exemplars en 4.
UPDATE llibres
SET exemplars = 4
WHERE titol LIKE "Bases de dades per a tothom";

-- 18. Actualitza la quantitat d’exemplars del llibre amb títol “El bosc dels llibres”:
--     deixa el total d’exemplars en −1.
UPDATE llibres
SET exemplars = -1
WHERE titol LIKE "El bosc dels llibres";
-- Dona error perque no compleix amb les condicions de la columna exemplars, ya que no pot tenir valors negatius.

-- 19. Elimina la categoria amb el nom “Ciència”.
DELETE FROM categories
WHERE nom LIKE "Ciència";
-- Dona error perque la columna id_categoria es una fk que s'esta emprant a la taula llibres.

-- 20. Elimina la persona sòcia identificada per document d’identitat “11111111A”.
DELETE FROM socis
WHERE dni LIKE "11111111A";
-- Dona error perque la columna soci es una fk que s'esta emprant a la taula prestecs.