CREATE DATABASE HospitalDB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;
USE HospitalDB;

CREATE TABLE specialities (
	speciality_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (100) NOT NULL UNIQUE,
    description TEXT);

CREATE TABLE patients (
	patient_id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	birth_date DATE,
	gender ENUM ("Male", "Female", "Other"),
	phone VARCHAR (20),
	email VARCHAR(100) CHECK (email LIKE "%@%"),
	addres VARCHAR (200) DEFAULT ("N/A"));
    
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(20),
	email VARCHAR(100) CHECK (email LIKE "%@%"),
    speciality_id INT NOT NULL,
	FOREIGN KEY (speciality_id) REFERENCES specialities(speciality_id));
    
CREATE TABLE consultations (
    consultation_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    consultation_date DATE NOT NULL,
    consultation_note TEXT,
    
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id));
    
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM("Scheduled", "Completed", "Cancelled"),
    doctor_id INT,
    patient_id INT NOT NULL,

    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id),

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id));

-- Modificacions

ALTER TABLE patients
MODIFY COLUMN email VARCHAR (100) NOT NULL UNIQUE;

ALTER TABLE consultations
CHANGE COLUMN consultation_note notes TEXT;

ALTER TABLE appointments 
MODIFY COLUMN status ENUM("Scheduled", "Completed", "Cancelled", "NoShow");

ALTER TABLE patients
MODIFY COLUMN first_name VARCHAR (100) NOT NULL;

ALTER TABLE doctors 
MODIFY COLUMN first_name VARCHAR (100) NOT NULL;

ALTER TABLE consultations
MODIFY COLUMN consultation_id INT;

-- 6 DROP TABLE specialities; No es pot dropear perque és una clau forana

ALTER TABLE doctors
ADD COLUMN photo blob;

ALTER TABLE appointments 
MODIFY COLUMN appointment_date DATE NOT NULL CHECK (appointment_date > "2019-12-31");

ALTER TABLE consultations
MODIFY COLUMN consultation_date TIME NOT NULL CHECK (consultation_date BETWEEN "8:00" AND "14:45");

ALTER TABLE appointments
DROP FOREIGN KEY fk_appointment_doctor;

ALTER TABLE appointments
MODIFY doctor_id INT NULL;

ALTER TABLE appointments
ADD CONSTRAINT fk_appointment_doctor
FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id)
ON DELETE SET NULL;

-- DROP DATABASE HospitalDB;
