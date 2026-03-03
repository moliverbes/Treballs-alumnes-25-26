create database Escacs;
use Escacs;

create table posicio(
id_posicio tinyint  primary key,
fila enum('A','B','C','D','E','F','G','H') not null,
columna tinyint not null
);

create table peça(
id_peça tinyint primary key ,
tipus enum('rei', 'dama', 'torre', 'alfil', 'cavall' , 'peó') not null,
color enum ('blanc', 'negre') not null,
id_posicio tinyint unique ,
imatge blob,
foreign key (id_posicio) references posicio (id_posicio)

);

create table moviment(
id_moviment tinyint ,
id_peça  tinyint,
id_posicio_inicial tinyint,
id_pocicio_final tinyint,
segons decimal(4,1) check (segons <= 120.0) default 0.0,
descripcio text,
timestamp datetime,
primary key (id_moviment),
foreign key (id_peça) references peça (id_peça),
foreign key (id_posicio_inicial) references posicio (id_posicio),
foreign key (id_pocicio_final) references posicio (id_posicio)
);
