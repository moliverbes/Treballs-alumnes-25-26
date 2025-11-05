-- 1 Dona d’alta una persona sòcia amb:
Insert into socis (dni, nom, telefon, correu)
Values ( '12345678A', 'Anna Serra', '600123123', 'anna.serra@example.com');

-- 2 Dona d’alta una persona sòcia aportant només:
Insert into socis (nom)
Values ('Marc Pons');
-- no se podria ja que minim necesita el dni per poder insertar les seves dades.

-- 3 Dona d’alta una persona sòcia amb:
Insert into socis (dni, nom, telefon, correu)
Values ( '11111111A', 'Joana Puig', '600555777', 'joana.puig@example.com');
-- no se pot donar de alta ya que ya hi ha una persona amb aquest mateix dni.

-- 4 Afegeix una categoria nova:
Insert into categories (nom, descripcio)
Values ('Misteri', 'Trames i enigmes');

-- 5 Afegeix una categoria nova:
Insert into categories (nom, descripcio)
Values ( 'Ciència', 'coneixement científic');
-- no se por afeguir ya que el nom ciencia ya esta utilizat y no se pot duplicar

-- 6 Dona d’alta un llibre amb:
Insert into llibres (titol, autor, any_publicacio, exemplars)
Values ( 'Criptografia pràctica', 'J. Katz', 2016, 2) ;
Update llibres 
set id_categoria = 2
Where titol = 'Criptografia pràctica';

-- 7 Dona d’alta un llibre amb:
Insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
Values ('El vell arxivador', 'M. Antic', 1875, 1, 1);
-- No se pot degut a que el any es molt antic.

-- 8 Dona d’alta un llibre amb:
Insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
Values ('Zeros i uns', 'L. Bit', 2021, -3, 2);
-- No se pot fer ja que es imposible tenir -3 exemplars.

-- 9 Dona d’alta un llibre amb:
Insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
Values ('Pensar ràpid', 'D. Kahneman', 2011, 2); 
-- Demana un id de una categoria que no existeix

-- 10 Registra un préstec per a:
Insert into prestecs( id_soci, id_llibre)
Value (3, 1);

-- 11 Registra un préstec per a:
Insert into prestecs( id_soci, id_llibre, data_retorn )
Values ( 2, 2, '2025-09-30');
-- no pot se ja que la data de retorn esta asignada per el dia 2025-10-02


-- 12 Registra un préstec per a:
Insert into prestecs( id_soci, id_llibre, data_retorn )
Values (9 ,2);
-- No se pot fer ya que aquest dni no existeix

-- 13 Actualitza un préstec existent per marcar-lo com retornat
Update prestecs
set estat = 'retornat',
data_retorn = '2025-11-05'
Where id_soci = 1;

-- 14 Modifica la data de devolució d’un préstec existent
Update prestecs
set data_retorn = '2025-09-20'
Where id_soci = 2;
-- no se pot fer ya que se diu que a retornat la peli dia 2025-09-20 cuan el prestec y ha fet dia 2025-09-25


-- 15 Canvia l’adreça electrònica de la persona 
Update socis
set correu = 'pere.nou@example.com'
Where nom = 'Pere Roca';

-- 16 Canvia l’adreça electrònica de la persona
Update socis 
set correu = 'joan.puig@example.com'
Where nom = 'Marta Vidal';
-- No se pot fer degut que el correu que volem posar ya esta elegit y no es por duplicar.

-- 17 Actualitza la quantitat d’exemplars del llibre
Update llibres
set exemplars = 4
Where titol = 'Bases de dades per a tothom';

-- 18 Actualitza la quantitat d’exemplars del llibre
Update llibres
set exemplars = -1
Where titol = 'El bosc dels llibres';
-- No se pot fer ja que no es pot tenir exemplars en negatiu

-- 19 Elimina la categoria amb el nom “Ciència”.
Delete from categories 
Where nom = 'Ciència';
-- no se pot esborrar ya que es una dada arrell, altres dades depenen d'aquesta dada

-- 20 Elimina la persona sòcia identificada per document d’identitat “11111111A”.
Delete from socis
Where dni = '11111111A';
-- no se pot esborrar ya que es una dada arrell, altres dades depenen d'aquesta dada



Describe prestecs;
SELECT * FROM categories;
Select * From socis;
SELECT * FROM prestecs;
SELECT * FROM llibres;