CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE patients (
	patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender ENUM("Male","Female","Other"),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(200) DEFAULT "N/A",
    CHECK (email LIKE "%@%")
);

CREATE TABLE specialties (
	specialty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE,
    description TEXT
);

CREATE TABLE doctors (
	doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    specialty_id INT,
    phone VARCHAR(20),
    email VARCHAR(100),
	CHECK (email LIKE "%@%"),
    FOREIGN KEY (specialty_id) REFERENCES specialties (specialty_id),
    CHECK (email LIKE "%@%")
);

CREATE TABLE appointments (
	appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM("Scheduled","Completed","Cancelled"),
    CHECK (appointment_date > '2020-01-01'),
    CHECK (appointment_time BETWEEN '08:00:00' AND '14:45:00'),
    CONSTRAINT fk_patient
		FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
        
);

CREATE TABLE consultation (
	consultation_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    consultation_date DATE NOT NULL,
    consultation_notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
);
