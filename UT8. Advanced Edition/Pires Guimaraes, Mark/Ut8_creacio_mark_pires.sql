-- UT8 MARK PIRES GUIMARAES --

-- Parte 1 creacio de base de datos y tablas --
CREATE DATABASE IF NOT EXISTS ClinicaDB;
USE ClinicaDB;

CREATE TABLE especialitats (
    id_especialitat INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE metges (
    id_metge INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(80) NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    id_especialitat INT NOT NULL,
    FOREIGN KEY (id_especialitat) REFERENCES especialitats(id_especialitat)
);

CREATE TABLE pacients (
    id_pacient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(80) NOT NULL,
    data_naixement DATE NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    adreca VARCHAR(150) NULL
);

CREATE TABLE cites (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_pacient INT NOT NULL,
    id_metge INT NOT NULL,
    data_cita DATE NOT NULL,
    hora_cita TIME NOT NULL,
    estat VARCHAR(20) DEFAULT 'Pendent' CHECK (estat IN ('Pendent', 'Completada', 'Cancel·lada')),
    FOREIGN KEY (id_pacient) REFERENCES pacients(id_pacient),
    FOREIGN KEY (id_metge) REFERENCES metges(id_metge)
);

CREATE TABLE medicaments (
    id_medicament INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    dosi VARCHAR(50) NOT NULL,
    fabricant VARCHAR(100) NOT NULL,
    stock INT DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE prescripcions (
    id_prescripcio INT AUTO_INCREMENT PRIMARY KEY,
    id_cita INT NOT NULL,
    id_medicament INT NOT NULL,
    quantitat INT NOT NULL CHECK (quantitat > 0),
    indicacions VARCHAR(200) NULL,
    FOREIGN KEY (id_cita) REFERENCES cites(id_cita),
    FOREIGN KEY (id_medicament) REFERENCES medicaments(id_medicament)
);