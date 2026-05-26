create database ClinicaDB;
use ClinicaDB;

# PARTE 1
# Tabla Especialitats
create table especialitats (
    id_especialitat int auto_increment primary key,
    nom varchar(50) not null unique
);

#Tabla Megtes
create table metges (
	id_metge int auto_increment primary key,
    nom varchar(50) not null,
    cognoms varchar(80) not null,
    telefon varchar(15) not null,
    email varchar(100) unique,
    id_especialitat int not null,
    foreign key (id_especialitat) references especialitats(id_especialitat) on delete restrict on update cascade
);

# Tabla Pacients
create table pacients (
	id_pacient int auto_increment primary key,
	nom varchar(50) not null,
	cognoms varchar(80) not null,
	data_naixement date not null,
	telefon varchar(15) not null,
	email varchar(100) unique,
	adreca varchar(150)
);

# Tabla Cites
create table cites (
    id_cita int auto_increment primary key,
    id_pacient int not null,
    id_metge int not null,
    data_cita date not null,
    hora_cita time not null,
    estat varchar(20) default 'Pendent',
    foreign key (id_pacient) references pacients(id_pacient),
    foreign key (id_metge) references metges(id_metge),
    constraint chk_estat check (estat in ('Pendent', 'Completada', 'Cancel·lada'))
);

# Tabla Medicaments
create table medicaments (
    id_medicament int auto_increment primary key,
    nom varchar(100) not null unique,
    dosi varchar(50) not null,
    fabricant varchar(100) not null,
    stock int default 0,
    constraint chk_stock check (stock >= 0)
);

#Tabla Prescripcions
create table prescripcions (
    id_prescripcio int auto_increment primary key,
    id_cita int not null,
    id_medicament int not null,
    quantitat int not null,
    indicacions varchar(200),
    foreign key (id_cita) references cites(id_cita),
    foreign key (id_medicament) references medicaments(id_medicament),
    constraint chk_quantitat check (quantitat > 0)
);