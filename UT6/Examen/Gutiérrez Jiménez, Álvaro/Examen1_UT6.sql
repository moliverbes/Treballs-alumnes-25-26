create database escacs;
use escacs;

create table posicio (
    id_posicio tinyint primary key,
    fila char(1) not null constraint chk_fila check (fila between 'A' and 'H'),
    columna tinyint not null constraint chk_columna check (columna between 1 and 8)
);

create table peça (
    id_peça tinyint primary key,
    tipus enum ('rei', 'dama', 'torre', 'alfil', 'cavall', 'peó') not null,
    color enum('blanc', 'negre') not null,
    id_posicio tinyint unique,
    imatge blob,
    foreign key (id_posicio) references posicio(id_posicio) on delete set null on update cascade
);

create table moviment (
    id_moviment int primary key,
    id_peça tinyint not null,
    id_posicio_inicial tinyint not null,
    id_posicio_final tinyint not null,
    segons decimal(4,1) default 0.0 constraint chk_segons check (segons <= 120),
    descripcio text,
    timestamp datetime,
    foreign key (id_peça) references peça(id_peça) on delete restrict on update cascade,
    foreign key (id_posicio_inicial) references posicio(id_posicio) on update cascade,
    foreign key (id_posicio_final) references posicio(id_posicio) on update cascade
);