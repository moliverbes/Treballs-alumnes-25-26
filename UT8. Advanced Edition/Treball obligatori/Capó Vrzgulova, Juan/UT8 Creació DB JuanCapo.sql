CREATE DATABASE ClinicaDB;

USE ClinicaDB;

CREATE TABLE especialitats (
id_especialitat INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE metges (
id_metge INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
cognoms VARCHAR(80) NOT NULL,
telefon VARCHAR(15) NOT NULL,
email VARCHAR(100) UNIQUE,
id_especialitat INT NOT NULL
);

CREATE TABLE pacients (
id_pacient INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
cognoms VARCHAR(80) NOT NULL,
data_naxement DATE NOT NULL,
telefon VARCHAR(15) NOT NULL,
email VARCHAR(100) UNIQUE,
adreca VARCHAR(150) NULL
);

CREATE TABLE cites (
id_cita INT PRIMARY KEY AUTO_INCREMENT,
id_pacient INT NOT NULL,
id_metge INT NOT NULL,
data_cita DATE NOT NULL,
hora_cita TIME NOT NULL,
estat ENUM('Pendent', 'Completada', 'Cancel·lada') DEFAULT 'Pendent'
);

CREATE TABLE medicaments (
id_medicament INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(100) NOT NULL UNIQUE,
dosi VARCHAR(50) NOT NULL,
fabricant VARCHAR(100) NOT NULL,
stock INT DEFAULT 0 CHECK(stock >= 0)
);

CREATE TABLE prescripcions (
id_prescripcio INT PRIMARY KEY AUTO_INCREMENT,
id_cita INT NOT NULL,
id_medicament INT NOT NULL,
quantitat INT NOT NULL CHECK(quantitat > 0),
indicacions VARCHAR(200) NULL
);

ALTER TABLE metges
MODIFY id_especialitat INT NULL;

ALTER TABLE metges
ADD CONSTRAINT fk_especialitats_metges
FOREIGN KEY(id_especialitat) REFERENCES especialitats(id_especialitat)
ON DELETE SET NULL;

ALTER TABLE cites
ADD CONSTRAINT fk_pacients_cites
FOREIGN KEY(id_pacient) REFERENCES pacients(id_pacient);

ALTER TABLE cites
ADD CONSTRAINT fk_metges_cites
FOREIGN KEY(id_metge) REFERENCES metges (id_metge);

ALTER TABLE prescripcions
ADD CONSTRAINT fk_cites_prescripcions
FOREIGN KEY(id_cita) REFERENCES cites (id_cita);

ALTER TABLE prescripcions
ADD CONSTRAINT fk_medicaments_prescripcions
FOREIGN KEY(id_medicament) REFERENCES medicaments(id_medicament);
