-- 1 Dona d’alta una persona sòcia amb:
-- document d’identitat “12345678A”
-- nom “Anna Serra”
-- telèfon “600123123”
-- adreça electrònica “anna.serra@example.com”
-- La data d’alta ha de quedar establerta automàticament.

insert into socis
(dni, nom, telefon, correu)
values ('12345678A','Anna Serra',600123123,'anna.serra@example.com');

select * from socis
where nom like 'Anna Serra';

-- 2 Dona d’alta una persona sòcia aportant només:
-- nom Marc Pons

insert into socis
(dni,nom)
values ('1212121B','Marc Pons');

select * from socis
where nom like 'Marc Pons';

-- 3 Dona d’alta una persona sòcia amb:
-- document d’identitat “11111111A”
-- nom “Joana Puig”
-- telèfon “600555777”
-- adreça electrònica “joana.puig@example.com”.

insert into socis
(dni, nom, telefon, correu)
values('1111111A', 'Joana Puig', 600555777, 'joana.puig@example.com');

select * from socis
where nom like 'Joana Puig';

-- 4 Afegeix una categoria nova:
-- nom “Misteri”
-- descripció “Trames i enigmes”.

insert into categories
(nom, descripcio)
values('Misteri', 'Trames i enigmes');

select * from categories
where nom like 'Misteri';

-- 5 Afegeix una categoria nova:
-- nom “Ciència”
-- descripció “Coneixement científic”.

insert into categories
(nom, descripcio)
values ('Ciencia', 'coneixement cientific');

select * from categories 
where nom like 'Ciencia';


-- 6 Dona d’alta un llibre amb:
-- títol “Criptografia pràctica”
-- autoria “J. Katz”
-- any de publicació 2016
-- quantitat d’exemplars 2
-- assignat a la categoria anomenada “Ciència”.

insert into llibres
(titol, autor, any_publicacio, exemplars, id_categoria)
values('Criptografia pràctica', 'J. Katz', 2016, 2, 2);

select * from llibres
where titol like 'Criptografia pràctica';

-- 7 Dona d’alta un llibre amb:
-- títol “El vell arxivador”
-- autoria “M. Antic”
-- any de publicació 1875
-- quantitat d’exemplars 1
-- assignat a la categoria “Novel·la”.
 
insert into llibres 
(titol, autor, any_publicacio, exemplars, id_categoria)
values('El vell arxivador', 'M. Antic',1875, 1,1);
-- No es pot fer, la data mínima es del 1900

-- 8 Dona d’alta un llibre amb:
-- títol “Zeros i uns”
-- autoria “L. Bit”
-- any de publicació 2021
-- quantitat d’exemplars −3
-- assignat a la categoria “Ciència”.


insert into llibres
(titol, autor, any_publicacio, exemplars, id_categoria)
values('Zeros i uns', 'L. Bit', 2021, '-3', 2);
-- No es pot fer ja que el check ha de ser mínim de 0


-- 9 Dona d’alta un llibre amb:
-- títol “Pensar ràpid”
-- autoria “D. Kahneman”
-- any de publicació 2011
-- quantitat d’exemplars 2
-- assignat a la categoria “Filosofia”.

insert into llibres
(titol, autor, any_publicacio, exemplars, id_categoria)
values('Pensar ràpid', 'D. Kahneman', 2011, 2);
-- No es pot fer ja que no hi ha una categoria de filosofia


-- 10  Registra un préstec per a:
-- persona amb document “33333333C”
-- llibre titulat “Bases de dades per a tothom”
-- La data de cessió ha de quedar establerta automàticament
-- l’estat inicial per defecte.

insert into prestecs
(id_soci, id_llibre)
values(3, 1);
-- L'id del soci és 3 i el del llibre és 1

-- 11 Registra un préstec per a:
-- persona amb document “22222222B”
-- llibre titulat “La porta dels enigmes”
-- data de devolució “2025-09-30”.

insert into prestecs
(id_soci, id_llibre, data_retorn)
values(2, 3, '2025-09-30');
-- No es pot fer ja que el check de les dates no ho permet

select * from llibres;

-- 12 Registra un préstec per a:
-- persona amb document “99999999Z”
-- llibre titulat “El bosc dels llibres”.

insert into prestecs
(id_soci, id_llibre);
-- no es pot fer, la persona amb aquestes dades no està registrada

-- 13 Actualitza un préstec existent per marcar-lo com retornat. El que
-- correspon al soci amb document “11111111A” i llibre “La porta dels enigmes”
-- fixa l’estat a “retornat”
-- data de devolució a “2025-11-05”.

update prestecs 
set estat = "retornat"
where id_soci=1 and id_llibre = 3;

-- 14 Modifica la data de devolució d’un préstec existent. 
-- El que correspon al soci amb document “22222222B” i al llibre “El bosc dels llibres”:
update prestecs
set data_prestec = "2025-09-20"
where id_soci= 2 and id_llibre = 2;

-- 15. Canvia l’adreça electrònica de la persona amb nom “Pere Roca”:
--  nova adreça “joan.puig@example.com”.

update socis 
set correu = "pere.nou@example.com"
where nom like "Pere Roca";

-- 16. Canvia l’adreça electrònica de la persona amb nom “Marta Vidal”:
--  nova adreça “joan.puig@example.com”.

update socis 
set correu = "joan.puig@example.com"
where nom like "Marta Vidal";
-- No es pot fer, el correu està duplicat

-- 17 Actualitza la quantitat d’exemplars del llibre amb títol “Bases de dades per a tothom”:
-- deixa el total d’exemplars en 4.

update llibres 
set exempkars = 4
where titol like "Bases de dades per a tothom";

-- 18. Actualitza la quantitat d’exemplars del llibre amb títol “El bosc dels llibres”:
--    deixa el total d’exemplars en −1.
 update llibres 
 set exemplars = -1
 where titol like "El bosc dels llibres";
-- No es por fer, no pot haver exemplars menors a 0

-- 19 Elimina la categoria amb el nom “Ciència”.
delete from categories
where nom like "Ciència"; 
-- No es por fer, la columna es una fk que s'està empran a la taula

-- 20. Elimina la persona sòcia identificada per document d’identitat “11111111A”.

delete from socis 
where dni like "1111111A";




