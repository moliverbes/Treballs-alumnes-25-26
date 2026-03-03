CREATE DATABASE HospitalDB;
USE HospitalDB;
-- Creació de la BSD

CREATE TABLE specialities (
    speciality_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialty_id INT,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) CHECK (email LIKE '%@%'),
    FOREIGN KEY (specialty_id) REFERENCES specialities(speciality_id)
);

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) CHECK (email LIKE '%@%'),
    address VARCHAR(200) DEFAULT 'N/A'
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL,
    CONSTRAINT chk_date CHECK (appointment_date > '2022-12-31'),
    CONSTRAINT chk_time CHECK (appointment_time >= '08:00:00' AND appointment_time <= '20:00:00'),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE consultations (
    consultation_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    consultation_date DATE NOT NULL,
    consultations_notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
-- modificacions
-- 1.Fes que la columna email de la taula patients sigui obligatòria i no es pugui repetir.
ALTER TABLE patients
MODIFY email VARCHAR(100) NOT NULL UNIQUE CHECK (email LIKE '%@%');
-- 2.	2. Canvia el nom de la columna consultations_notes a notes.
ALTER TABLE consultations
CHANGE consultations_notes notes TEXT;
-- 3. Modifica la columna status de la taula appointments perquè inclogui un nou valor NoShow, i que aquest sigui el valor per defecte.
ALTER TABLE appointments
MODIFY status ENUM('Scheduled', 'Completed', 'Cancelled', 'NoShow') DEFAULT 'NoShow';
-- 4. Fes que les columnes first_name de les taules patients i doctors passin a poder tenir una longitud de 100 caràcters.
ALTER TABLE patients
MODIFY first_name VARCHAR(100) NOT NULL;

ALTER TABLE doctors
MODIFY first_name VARCHAR(100) NOT NULL;
-- 5. Elimina el AUTO_INCREMENT de la clau consultation_id.
ALTER TABLE consultations
MODIFY consultation_id INT NOT NULL;
-- 6 Elimina la taula d’especialitats

ALTER TABLE doctors
DROP FOREIGN KEY speciality_id;

ALTER TABLE doctors
DROP COLUMN specialty_id;

DROP TABLE specialities;
-- 7 Afegeix una columna a la taula doctors que ens permeti desar una fotografia del metge.
ALTER TABLE doctors
ADD COLUMN photo BLOB;
-- 8 Assegura’t que la columna appointment_date  no permeti dates anteriors a l’any 2020.
ALTER TABLE appointments
DROP CONSTRAINT chk_date;

ALTER TABLE appointments
ADD CONSTRAINT chk_date CHECK (appointment_date >= '2020-01-01');
-- 9 Les cites mèdiques només es poden donar de 08:00 a 14:45
ALTER TABLE appointments
DROP CONSTRAINT chk_time;

ALTER TABLE appointments
ADD CONSTRAINT chk_time CHECK (appointment_time >= '08:00:00' AND appointment_time <= '14:45:00');
-- 10 Fes que, si eliminam el registre d’un metge, el doctor_id corresponent de la taula appointments es quedi a NULL.
ALTER TABLE appointments
DROP FOREIGN KEY doctor_id;

ALTER TABLE appointments
MODIFY doctor_id INT;

ALTER TABLE appointments
ADD CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL;