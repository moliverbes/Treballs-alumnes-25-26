/*
1. Da de alta una persona socia con:
documento de identidad “12345678A”
nombre “Anna Serra”
teléfono “600123123”
dirección electrónica “anna.serra@example.com”
La fecha de alta debe quedar establecida automáticamente.
*/
insert into socis (dni, nom, telefon, correu)
values ('12345678A', 'Anna Serra', '600123123', 'anna.serra@example.com');

/*
2. Da de alta una persona socia aportando sólo:
nombre “Marc Pons”.
*/
insert into socis (nom) 
values ('Marc Pons');
-- dni tiene la condición de que no puede estar vacío, por lo que no deja añadir el nombre.

/*
3. Da de alta una persona socia con:
documento de identidad “11111111A”
nombre “Joana Puig”
teléfono "600555777"
dirección electrónica "joana.puig@example.com".
*/
insert into socis (dni, nom, telefon, correu)
values ('11111111A', 'Joana Puig', '600555777', 'joana.puig@example.com');
-- este socio se repite, por lo que el dni también, dando error debido a que dni tiene la función de que no puede ser duplicado.

/*
4. Añade una nueva categoría:
nom “Misteri”
descripció “Trames i enigmes”.
*/
insert into categories (nom, descripcio)
values ('Misteri', 'Trames i enigmes');

/*
5. Añade una nueva categoría:
nom “Ciència”
descripció “Coneixement científic”.
*/
insert into categories (nom, descripcio)
values ('Ciència', 'Coneixement científic');
-- no puede ser añadida debido a que ya hay una categoria llamada "Ciencia" y este tiene establecida la función de unique por lo que no podrán añadirse más categorias con el nombre Ciencias.

/*
6. Da de alta un libro con:
títol “Criptografia pràctica”
autoria “J. Katz”
any de publicació 2016
quantitat d’exemplars 2
assignat a la categoria anomenada “Ciència”.
*/
insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
values ('Criptografia pràctica', 'J. Katz', 2016, 2, 2);

/*
7. Da de alta un libro con:
títol “El vell arxivador”
autoria “M. Antic”
any de publicació 1875
quantitat d’exemplars 1
assignat a la categoria “Novel·la”.
*/
insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
values ('El vell arxivador', 'M. Antic', 1875, 1, 1);
-- “out of range value for column 'any_publicacio'”, da este error ya que el valor 1875 no cabe en el tipo de datos que tiene la columna any_publicacio

/*
8. Da de alta un libro con:
títol “Zeros i uns”
autoria “L. Bit”
any de publicació 2021
quantitat d’exemplars −3
assignat a la categoria “Ciència”.
*/
insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
values ('Zeros i uns', 'L. Bit', 2021, 3, 2);

/*
9. Da de alta un libro con:
títol “Pensar ràpid”
autoria “D. Kahneman”
any de publicació 2011
quantitat d’exemplars 2
assignat a la categoria “Filosofia”.
*/
insert into llibres (titol, autor, any_publicacio, exemplars, id_categoria)
values ('Pensar ràpid', 'D. Kahneman', 2011, 2, 5);
-- al no existir una categoria llamada 'filosofía' no puedo asignarle la id de la categoria (puse 5 porque es la única id que no aparece por lo que supongo que filosofía sea esa id)


/*
10. Registra un préstamo para:
persona con dni “33333333C”
libro titulado “Bases de dades per a tothom”
La fecha de cesión debe quedar establecida automáticamente
el estado inicial por defecto.
*/
insert into prestecs (id_soci, id_llibre)
values ((select id_soci from socis where dni = '33333333C'),
(select id_llibre from llibres where titol = 'Bases de dades per a tothom'));


/*
11. Registra un préstamo para:
persona con documento “22222222B”
libro titulado “La porta dels enigmes”
fecha de devolución "2025-09-30". 
*/
insert into prestecs (id_soci, id_llibre, data_retorn)
values ((select id_soci from socis where dni = '22222222B'),
(select id_llibre from llibres where titol = 'La porta dels enigmes'), '2025-09-30');
-- da error en "chk_dates" ya que la data_retorn debe ser igual o posterior a data_prestec

/*
12. Registra un préstamo para:
persona con documento “99999999Z”
libro titulado "El bosc dels llibres".
*/
insert into prestecs (id_soci, id_llibre)
values ((select id_soci from socis where dni = '99999999Z'),
(select id_llibre from llibres where titol = 'El bosc dels llibres'));
-- da error (id_soci cannot be null) ya que el dni no existe y no está asignado en la tabla de socis

/*
13. Actualiza un préstamo existente para marcarlo como devuelto. Lo que corresponde al socio con documento "11111111A" y libro "La porta dels enigmes"
fija el estado a “retornat”
fecha de devolución a "2025-11-05".
*/
update prestecs
set estat = 'retornat', data_retorn = '2025-11-05'
where id_soci = (select id_soci from socis where dni = '11111111A') and id_llibre = (select id_llibre from llibres where titol = 'La porta dels enigmes');

/*
14. Modifica la fecha de devolución de un préstamo existente. Lo que corresponde al socio con documento "22222222B" y al libro "El bosc dels llibres"
establece la fecha de devolución a “2025-09-20”.
*/
update prestecs
set data_retorn = '2025-09-20'
where id_soci = (select id_soci from socis where dni = '22222222B') and id_llibre = (select id_llibre from llibres where titol = 'El bosc dels llibres');
-- de nuevo el error de "chk_dates" ya que se puso una fecha anterior a data_prestecs

/*
15. Cambia la dirección de correo electrónico de la persona con nombre “Pere Roca” 
nueva dirección “pere.nou@example.com”.
*/
update socis
set correu = 'pere.nou@example.com'
where nom = 'Pere Roca';
-- da error debido a que es un correo ya existente en el usuario Pere Roca

# 16. Cambia la dirección de correo electrónico de la persona con nombre “Marta Vidal” - nueva dirección "joan.puig@example.com".
update socis
set correu = 'joan.puig@example.com'
where nom = 'Marta Vidal';
-- da error para no duplicar correo ya que ese correo está asignado a Joan Puig

# 17. Actualiza la cantidad de ejemplares del libro con título “Bases de datos para todos” - deja el total de ejemplares en 4.
update llibres
set exemplars = 4
where titol = 'Bases de dades per a tothom';
-- da error por "safe mode" para que este cambio no afecte a más registros

# 18. Actualiza la cantidad de ejemplares del libro con título “El bosque de los libros” - deja el total de ejemplares en −1.
update llibres
set exemplars = -1
where titol = 'El bosc dels llibres';
-- el número de ejemplares no puede ser negativo

# 19. Elimina la categoria amb el nom “Ciència”.
delete from categories
where nom = 'Ciència';
-- no se puede eliminar por la restricción que tiene

# 20. Elimina la persona socia identificada por documento de identidad "11111111A".
delete from socis
where dni = '11111111A';
-- no deja elimiar socios que tengan préstamos asociados