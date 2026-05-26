create database clinicadb;
use clinicadb;

create table especialitats(
id_especialitat int primary key auto_increment,
nom varchar(50) not null unique
);

create table metges (
id_metge int primary key auto_increment,
nom varchar(50) not null,
cognoms varchar(80) not null,
telefon varchar(15) not null, 
email varchar(100) unique,
id_especialitat int not null
);

create table pacient (
id_pacient int primary key auto_increment,
nom varchar(50) not null,
cognoms varchar(80) not null, 
data_naixement date not null, 
telefon varchar(15) not null, 
email varchar(100) unique,
adreca varchar(150) null
);

create table cites (
id_cita int primary key auto_increment,
id_pacient int not null,
id_metge int not null,
data_cita date not null,
hora_cita time not null,
estat enum('Pendent','Completada','Cancel·lada') default 'Pendent'
);

create table medicaments (
id_medicament int primary key auto_increment,
nom varchar(100) not null unique,
dosi varchar(50) not null,
fabricant varchar(100) not null,
stock int default 0 check(stock >= 0)
);

create table prescripcions (
id_prescripcio int primary key auto_increment,
id_cita int not null,
id_medicament int not null,
quantitat int not null check(quantitat > 0),
indicacions varchar(200) null
);
alter table metges 
modify id_especialitat int null;

alter table metges 
add constraint fk_especialitat_metges
foreign key (id_especialitat) references especialitats(id_especialitat)
on delete set null;

alter table cites 
add constraint fk_pacients_cites
foreign key (id_pacient) references pacient(id_pacient);

alter table cites
add constraint fk_metges_cites 
foreign key (id_metge) references metges(id_metge);

alter table prescripcions
add constraint fk_cites_prescripcions 
foreign key (id_cita) references cites(id_cita);

alter table prescripcions 
add constraint fk_medicament_prescripcions 
foreign key (id_medicament) references medicaments(id_medicament);