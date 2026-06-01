create database ClinicaDB ;
use ClinicaDB ;

create table especialitats(
id_especialitat int PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL UNIQUE
);

create table metges(
id_metge INT primary key auto_increment,
nom varchar(50) not null,
cognoms varchar(80) not null,
telefon varchar(15) not null,
id_especialitat int not null 
);

create table pacients(
id_pacient INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
cognoms VARCHAR(80) NOT NULL,
data_naixement DATE NOT NULL,
telefon VARCHAR(15) NOT NULL,
email VARCHAR(100) UNIQUE,
adreca VARCHAR(150) NULL
);

create table cites(
id_cita int primary key auto_increment,
id_pacient int not null,
id_metge int not null,
data_ciata date not null,
hora_cita time not null,
estat enum ('Pendent', 'Completada', 'Cancel·lada')  default 'Pendent' 
);
create table medicaments(
id_medicament int primary key auto_increment,
nom varchar(100) not null unique,
dosi varchar(50) not null,
fabricant varchar(100) not null,
stock int default 0
);

create table prescripcions (
id_prescripcions int primary key auto_increment,
id_cita int not null,
id_medicament int not null,
quantitat int not null check(quantitat > 0),
indicacions varchar (200) null
);
ALTER TABLE metges MODIFY id_especialitat INT NULL;
alter table metges
add constraint FK_especialitats_metges
foreign key (id_especialitat) references especialitats (id_especialitat)
on delete set null;

alter table cites
add constraint FK_pacients_cites
foreign key (id_pacient) references pacients (id_pacient);

alter table cites
add constraint fk_metges_cites
foreign key (id_metge) references metges(id_metge);

ALTER TABLE prescripcions
ADD CONSTRAINT FK_prescripcions_cites
FOREIGN KEY (id_cita) REFERENCES cites (id_cita);

alter table prescripcions
add constraint fk_prescripcions_medicaments
foreign key (id_medicament) references medicaments(id_medicament);
