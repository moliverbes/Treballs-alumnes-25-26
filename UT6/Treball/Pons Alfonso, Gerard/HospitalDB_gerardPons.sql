CREATE DATABASE HospitalDB;
USE HospitalDB;
CREATE TABLE specialities(
specialty_id INT  AUTO_INCREMENT,
name VARCHAR(100) UNIQUE,
description TEXT,
PRIMARY KEY(specialty_id)
);
CREATE TABLE doctors(
doctor_id INT  AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(100) NOT NULL,
license_number VARCHAR(20) NOT NULL UNIQUE,
specialty_id INT,
phone VARCHAR(20),
email VARCHAR(20),
PRIMARY KEY(doctor_id),
FOREIGN KEY(specialty_id) REFERENCES specialities(specialty_id)
);
CREATE TABLE patients(
patient_id INT  AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(100) NOT NULL,
birth_date DATE,
gender ENUM('Male', 'Female', 'Other'),
phone VARCHAR(20),
email VARCHAR(100) CHECK(email LIKE "%@%"),
address VARCHAR(200) DEFAULT 'N/A',
PRIMARY KEY(patient_id)
);
CREATE TABLE appointments(
appointment_id INT  AUTO_INCREMENT,
patient_id INT,
doctor_id INT,
appointment_date DATE NOT NULL CHECK(appointment_date > "31-12-22"),
appointment_time TIME CHECK(appointment_time BETWEEN "8:00" AND "20:00") NOT NULL,
status ENUM('Scheduled', 'Completed', 'Cancelled'),
PRIMARY KEY(appointment_id),
FOREIGN KEY(patient_id) REFERENCES patients(patient_id) ON UPDATE CASCADE,
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id) 
);
CREATE TABLE consultations(
consultation_id INT  AUTO_INCREMENT,
patient_id INT,
doctor_id INT,
consultation_date DATE NOT NULL,
consultation_notes TEXT,
PRIMARY KEY(consultation_id),
FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);

-- 1
ALTER TABLE patients
MODIFY COLUMN email VARCHAR(100) CHECK(email LIKE "%@%") NOT NULL UNIQUE;

-- 2
ALTER TABLE consultations
RENAME COLUMN consultation_notes TO notes;

-- 3
ALTER TABLE appointments
MODIFY COLUMN status ENUM('Scheduled', 'Completed', 'Cancelled', 'NOShow') DEFAULT 'NOShow';

-- 4
ALTER TABLE patients
MODIFY COLUMN first_name VARCHAR(100) NOT NULL;

ALTER TABLE doctors
MODIFY COLUMN first_name VARCHAR(100) NOT NULL;

-- 5
ALTER TABLE consultations
DROP PRIMARY KEY;
ALTER TABLE consultations
ADD PRIMARY KEY (consultation_id); 

-- 6
DROP TABLE specialities; -- No se pot perque altres taules la empren de clau Foranea.

-- 7
ALTER TABLE doctors
ADD COLUMN imagen VARCHAR(255);

-- 8
ALTER TABLE appointments 
MODIFY COLUMN appointment_date DATE NOT NULL CHECK(appointment_date > "01-01-21");
ALTER TABLE appointments
DROP CONSTRAINT chk_appointment_date;

-- 9
ALTER TABLE appointments
MODIFY COLUMN appointment_time TIME CHECK(appointment_time BETWEEN "8:00" AND "14:45") NOT NULL;
ALTER TABLE appointments
DROP CONSTRAINT chk_appointment_time;

-- 10
ALTER TABLE appointments
DROP CONSTRAINT fk_appointments_doctor;
ALTER TABLE appointments
ADD CONSTRAINT FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL;


