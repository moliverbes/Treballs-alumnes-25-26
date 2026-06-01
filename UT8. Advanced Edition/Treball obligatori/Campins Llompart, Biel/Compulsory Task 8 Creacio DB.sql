CREATE DATABASE ClinicaDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
 USE ClinicaDB;
 
CREATE TABLE especialitats(
id_especialitat INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL UNIQUE);

CREATE TABLE metges (
    id_metge INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(80) NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    email VARCHAR(100) NULL, 
    id_especialitat INT, 
    CONSTRAINT fk_metges_especialitats
        FOREIGN KEY (id_especialitat) REFERENCES especialitats(id_especialitat)
        ON DELETE SET NULL);

 CREATE TABLE pacients(
id_pacient INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
cognoms VARCHAR(80) NOT NULL,
data_naixement DATE NOT NULL,
telefon VARCHAR(15) NOT NULL,
email VARCHAR(100) UNIQUE,
adreca VARCHAR(150) NULL);

CREATE TABLE cites(
id_cita INT PRIMARY KEY AUTO_INCREMENT,
id_pacient INT NOT NULL,
id_metge INT NOT NULL,
data_cita DATE NOT NULL,
hora_cita TIME NOT NULL,
estat VARCHAR(20) DEFAULT 'Pendent' CHECK(estat IN ('Pendent', 'Completada', 'Cancel·lada')),
    CONSTRAINT fk_cites_pacients
        FOREIGN KEY (id_pacient) REFERENCES pacients(id_pacient)
        ON DELETE RESTRICT, 
    CONSTRAINT fk_cites_metges
        FOREIGN KEY (id_metge) REFERENCES metges(id_metge)
        ON DELETE RESTRICT);

CREATE TABLE medicaments(
id_medicament INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(100) NOT NULL UNIQUE,
dosi VARCHAR(50) NOT NULL,
fabricant VARCHAR(100) NOT NULL,
stock INT DEFAULT 0 CHECK(stock >= 0));

CREATE TABLE prescripcions(
id_prescripcio INT PRIMARY KEY AUTO_INCREMENT,
id_cita INT NOT NULL,
id_medicament INT NOT NULL,
quantitat INT NOT NULL CHECK (quantitat > 0),
indicacions VARCHAR(200) NULL,
    CONSTRAINT fk_prescripcions_cites
        FOREIGN KEY (id_cita) REFERENCES cites (id_cita)
        ON DELETE RESTRICT, 
    CONSTRAINT fk_prescripcions_medicaments
        FOREIGN KEY (id_medicament) REFERENCES medicaments (id_medicament)
        ON DELETE RESTRICT);

-- DROP DATABASE ClinicaDB;