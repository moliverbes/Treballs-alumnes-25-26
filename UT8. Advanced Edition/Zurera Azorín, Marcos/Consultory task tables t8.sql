CREATE DATABASE IF NOT EXISTS ClinicaDB;
USE ClinicaDB;
CREATE TABLE especialitats (
    id_especialitat INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_especialitat),
    CONSTRAINT UQ_especialitat_nom UNIQUE (nom)
);

CREATE TABLE metges (
    id_metge INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(80) NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    id_especialitat INT,
    PRIMARY KEY (id_metge),
    CONSTRAINT UQ_metges_email UNIQUE (email),
    CONSTRAINT FK_metges_especialitat 
        FOREIGN KEY (id_especialitat) 
        REFERENCES especialitats(id_especialitat)
        ON DELETE SET NULL 
);
       
CREATE TABLE pacients (
    id_pacient INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(80) NOT NULL,
    data_naixement DATE NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    adreca VARCHAR(150) NULL,
    PRIMARY KEY (id_pacient),
    CONSTRAINT UQ_pacients_email UNIQUE (email)
);

CREATE TABLE cites (
    id_cita INT AUTO_INCREMENT,
    id_pacient INT NOT NULL,
    id_metge INT NOT NULL,
    data_cita DATE NOT NULL,
    hora_cita TIME NOT NULL,
    estat VARCHAR(20) DEFAULT 'Pendent',
    PRIMARY KEY (id_cita),
    CONSTRAINT CHK_cites_estat CHECK (estat IN ('Pendent', 'Completada', 'Cancel·lada')),
    CONSTRAINT FK_cites_pacient FOREIGN KEY (id_pacient) REFERENCES pacients(id_pacient),
    CONSTRAINT FK_cites_metge FOREIGN KEY (id_metge) REFERENCES metges(id_metge)
);

CREATE TABLE medicaments ( 
	id_medicament INT AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    dosi VARCHAR(50) NOT NULL, 
    fabricant VARCHAR(100) NOT NULL, 
    stock INT DEFAULT 0,
    PRIMARY KEY (id_medicament),
        CONSTRAINT UQ_medicaments_email UNIQUE (nom),
        CONSTRAINT CHK_medicaments_stock CHECK (stock >= 0)
);

CREATE TABLE prescripcions (
	id_prescripcio INT AUTO_INCREMENT,
    id_cita INT NOT NULL,
    id_medicament INT NOT NULL, 
    quantitat INT NOT NULL,
    indicacions VARCHAR(200) NULL,
    PRIMARY KEY (id_prescripcio),
		CONSTRAINT CHK_prescripcions_quantitat CHECK (quantitat > 0),
		CONSTRAINT FK_prescripcions_cita FOREIGN KEY (id_cita) REFERENCES cites(id_cita),
		CONSTRAINT FK_prescripcions_medicament FOREIGN KEY (id_medicament) REFERENCES medicaments(id_medicament)
);

