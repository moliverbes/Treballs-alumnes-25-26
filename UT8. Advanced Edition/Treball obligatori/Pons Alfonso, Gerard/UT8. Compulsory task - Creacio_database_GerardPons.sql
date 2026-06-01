-- Creació base de dades
CREATE DATABASE ClinicaDB;

CREATE TABLE especialitats (
id_especialitat INT AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(50) UNIQUE NOT NULL);

CREATE TABLE metges (
id_metge INT AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(50) NOT NULL,
cognoms VARCHAR(80) NOT NULL,
telefon VARCHAR(20) NOT NULL,
email VARCHAR(15) UNIQUE,
id_especialitat INT,
FOREIGN KEY (id_especialitat) REFERENCES especialitats (id_especialitat) ON DELETE SET NULL );

CREATE TABLE pacients (
id_pacient INT AUTO_INCREMENT PRIMARY KEY,
nom VARCHAR(50) NOT NULL,
cognoms VARCHAR(80) NOT NULL,
data_naixament DATE NOT NULL,
telefon VARCHAR(20) NOT NULL,
email VARCHAR(15) UNIQUE,
adreca VARCHAR(150) NULL
);
 
 CREATE TABLE cites (
 id_cita INT PRIMARY KEY AUTO_INCREMENT,
id_pacient INT NOT NULL,
id_metge INT NOT NULL,
data_cita DATE NOT NULL,
hora_cita TIME NOT NULL,
estat VARCHAR(20) DEFAULT 'Pendent'CHECK (estat IN ('Pendent', 'Completada', 'Cancel·lada')),
FOREIGN KEY (id_pacient) REFERENCES pacients (id_pacient),
FOREIGN KEY (id_metge) REFERENCES metges (id_metge));

CREATE TABLE medicaments (
id_medicament INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(100) NOT NULl UNIQUE,
dosi VARCHAR(50) NOT NULL,
fabricant VARCHAR(100) NOT NULL,
stock INT DEFAULT 0, CHECK (stock >= 0) );

CREATE TABLE prescripcions (
id_prescripcio INT PRIMARY KEY AUTO_INCREMENT,
id_cita INT NOT NULL ,
id_medicament INT NOT NULL,
quantitat INT NOT NULL CHECK (quantitat >= 0),
indicacions VARCHAR(200) NULL,
FOREIGN KEY (id_cita) REFERENCES cites (id_cita),
FOREIGN KEY (id_medicament) REFERENCES medicaments (id_medicament));