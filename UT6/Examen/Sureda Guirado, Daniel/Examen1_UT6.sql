create database if not exists Escacs;
use Escacs;
create table posicio(
id_posicio tinyint primary key,
fila char(1) not null check (fila between 'A' and 'H'),
columna tinyint not null check (columna between 1 and 8)
);

create table peça(
id_peça tinyint primary key,
tipus enum ('Rei','Dama','Torre','Alfil','Cavall','Peó') not null,
color enum('Blanc','Negre') not null, 
id_posicio tinyint,
imatge blob,
foreign key (id_posicio) references posicio(id_posicio)
on delete set null
on update cascade
);

create table moviment(
id_moviment int primary key,
id_peça tinyint not null,
id_posicio_inicial tinyint not null,
id_posicio_final tinyint not null,
segons decimal (4,1) check (segons < 120) default (0.0),
descripcio text,
timestamp datetime

);

alter table moviment
add constraint fk_moviment_peça
foreign key (id_peça) references peça(id_peça);

