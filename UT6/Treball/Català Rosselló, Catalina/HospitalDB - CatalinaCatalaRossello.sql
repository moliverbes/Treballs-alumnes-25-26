-- Model relacional gràfic i informació necessària per escriure el codi SQL --

CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE specialities (
specialty_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL UNIQUE,
description TEXT
);

CREATE TABLE doctors (
doctor_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(100) NOT NULL,
license_number VARCHAR(20) NOT NULL UNIQUE,
specialty_id INT NOT NULL,
phone VARCHAR(20),
email VARCHAR(100) CHECK (email LIKE '%@%'),
FOREIGN KEY (specialty_id ) REFERENCES specialities(specialty_id)
);

CREATE TABLE patients(
patient_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(100) NOT NULL,
birth_date DATE,
gender ENUM('Male', 'Female', 'Other'),
phone VARCHAR(20),
email VARCHAR(100) CHECK (email LIKE '%@%'),
address VARCHAR(200) DEFAULT 'N/A'
);

CREATE TABLE appointments(
appointment_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
appointment_date DATE NOT NULL CHECK (appointment_date > '2022-12-31'),
appointment_time TIME NOT NULL CHECK (hour(appointment_time) BETWEEN 8 AND 20),
status ENUM('Scheduled', 'Completed', 'Cancelled'),

FOREIGN KEY (patient_id) REFERENCES  patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE consultations(
consultation_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
consultation_date DATE NOT NULL,
consultation_notes TEXT,

FOREIGN KEY (patient_id) REFERENCES  patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);


-- Modificacions --


/*1. Fes que la columna email de la taula patients sigui obligatòria i no es pugui repetir.*/

ALTER TABLE patients
MODIFY COLUMN email VARCHAR(100) NOT NULL UNIQUE;


/*2. Canvia el nom de la columna consultations_notes a notes.*/

ALTER TABLE consultations
RENAME COLUMN consultation_notes TO notes;


/*3. Modifica la columna status de la taula appointments perquè inclogui un nou valor NoShow, i que aquest sigui el valor per defecte.*/

ALTER TABLE appointments
MODIFY COLUMN status ENUM('Scheduled', 'Completed', 'Cancelled', 'NoShow') DEFAULT 'NoShow';


/*4. Fes que les columnes first_name de les taules patients i doctors passin a poder tenir una longitud de 100 caràcters.*/

ALTER TABLE patients
MODIFY COLUMN first_name VARCHAR(100) NOT NULL;

ALTER TABLE doctors
MODIFY COLUMN first_name VARCHAR(100) NOT NULL;


/* 5. Elimina el AUTO_INCREMENT de la clau consultation_id.*/

ALTER TABLE consultations
MODIFY COLUMN consultation_id INT;


/* 6. Elimina la taula d’especialitats*/

-- En intentar eliminar la taula d’especialitats es produeix un error perquè està vinculada
-- mitjançant una clau forana a la taula metge; per això primer s’elimina aquesta clau i
-- també l’ID associada, ja que deixaria d’apuntar a cap registre i perdria la seva utilitat,
-- i després ja es pot executar el DROP sense cap error.

ALTER TABLE doctors
DROP CONSTRAINT doctors_ibfk_1,
DROP COLUMN specialty_id;

DROP TABLE specialities;


/*7. Afegeix una columna a la taula doctors que ens permeti desar una fotografia del metge.*/

ALTER TABLE doctors
ADD COLUMN Imatge VARCHAR(255);


/*8. Assegura’t que la columna appointment_date  no permeti dates anteriors a l’any 2020.*/

-- Aquest check és innecessari, ja que en crear la base de dades ja es va establir una restricció
-- perquè la columna `appointment_date` sigui posterior al 31-12-2022; la instrucció actual permet
-- dates des de 2021, no des de 2023, reduint així la restricció anterior en lloc de reforçar-la.

ALTER TABLE appointments
MODIFY COLUMN appointment_date DATE NOT NULL CHECK(year(appointment_date) > 2020 );


/*9. Les cites mèdiques només es poden donar de 08:00 a 14:45*/

-- Primer s’elimina el check appointment_time de la taula appointments, ja que entra en
-- contradicció amb el nou que es vol introduir, perquè l’anterior permetia un horari
-- fins a les 20:00 i el nou el limita fins a les 14:45.

ALTER TABLE appointments
DROP CONSTRAINT appointments_chk_2;

ALTER TABLE appointments
MODIFY COLUMN appointment_time TIME NOT NULL CHECK (appointment_time BETWEEN '08:00:00' AND '14:45:00');


/*10. Fes que, si eliminam el registre d’un metge, el doctor_id corresponent de la taula appointments es quedi a NULL.*/

-- En aquesta modificació és necessari eliminar la clau forana de la taula appointments, ja que
-- es vol canviar perquè, en eliminar un registre de la taula doctor, el doctor_id pugui quedar
-- a NULL. Un cop eliminada la clau forana, s’ha de modificar la columna doctor_id perquè
-- accepti valors NULL, ja que, si no, no es podria realitzar perquè la columna no permet valors
-- nuls i entraria en conflicte amb la nova restricció ON DELETE SET NULL. Finalment, es torna a
-- crear la clau forana, però aquest cop amb la nova restricció.

ALTER TABLE appointments
DROP CONSTRAINT appointments_ibfk_2;

ALTER TABLE appointments
MODIFY COLUMN doctor_id INT NULL,
ADD FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL;