CREATE DATABASE IF NOT EXISTS HospitalDB;

USE HospitalDB;

CREATE TABLE patients(
patient_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(100) NOT NULL,
birth_date DATE,
gender ENUM('Male','Female','Other'),
phone VARCHAR(20),
email VARCHAR(100) CHECK (email LIKE '%@%'),
address VARCHAR(200) DEFAULT 'N/A'
);

CREATE TABLE appointments(
appointment_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
appointment_date DATE NOT NULL CHECK (appointment_date > '31-12-22'),
appointment_time TIME NOT NULL CHECK (appointment_time BETWEEN '8:00:00' AND '20:00:00'),
status ENUM('Scheduled', 'Completed', 'Cancelled')
);

CREATE TABLE doctors(
doctor_id INT PRIMARY KEY AUTO_INCREMENT,
fist_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
license_number VARCHAR(20) NOT NULL UNIQUE,
specialty_id INT NOT NULL,
phone VARCHAR(50),
email VARCHAR(100) CHECK (email LIKE '%@%')
);

CREATE TABLE consultations(
consultation_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
consultation_date DATE NOT NULL,
consultation_notes TEXT
);

CREATE TABLE specialties(
specialty_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL UNIQUE,
description TEXT
);

ALTER TABLE appointments
ADD CONSTRAINT fk_appointments_patient
FOREIGN KEY (patient_id) REFERENCES patients(patient_id);
 
ALTER TABLE appointments
ADD CONSTRAINT fk_appointments_doctor
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id);
 
 ALTER TABLE doctors
 ADD CONSTRAINT fk_doctors_specialties
 FOREIGN KEY (doctor_id) REFERENCES specialties(specialty_id);
 
 ALTER TABLE consultations
 ADD CONSTRAINT fk_consultations_patients
 FOREIGN KEY (patient_id) REFERENCES patients(patient_id);
 
 ALTER TABLE consultations
 ADD CONSTRAINT fk_consultations_doctors
 FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id);
 
 
