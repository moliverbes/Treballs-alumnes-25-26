#1.
alter table moviment
add constraint uni_timestamp unique (timestamp);

#2.
alter table peça
modify id_posicio tinyint null;

#3.
alter table peça drop foreign key peça_ibfk_1;

-- a.
alter table peça drop column id_posicio;

-- b.
alter table posicio drop column fila, drop column columna;
alter table posicio add column casella char(2) not null unique;

-- c.
alter table peça add column casella char(2);
alter table peça add foreign key (casella) references posicio(casella) on delete set null on update cascade;

#4.
alter table posicio
add column color enum('blanc', 'negre') not null;

#5.
alter table moviment drop check chk_segons;
alter table moviment add constraint chk_segons_60 check (segons <= 60.0);

#6.
rename table peça to Peces;