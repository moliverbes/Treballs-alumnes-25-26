CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

CREATE TABLE patients (
	patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender ENUM('Male','Female','Other'),
    phone VARCHAR(20),
    email VARCHAR(100) CHECK(email LIKE '%@%'),
    address VARCHAR(200) DEFAULT 'N/A'
);

CREATE TABLE specialities (
	speciality_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE doctors (
	doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    speciality_id INT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY(speciality_id) REFERENCES specialities(speciality_id)
);

CREATE TABLE consultations (
	consultation_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    consultation_date DATE NOT NULL,
    consultation_notes TEXT,
    FOREIGN KEY(patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE appointments (
	appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL CHECK(appointment_date > DATE '2022-12-31'),
    appointment_time TIME NOT NULL CHECK(appointment_time >= TIME '08:00:00' AND appointment_time <= TIME '20:00:00'),
    status ENUM('Scheduled','Completed','Cancelled'),
    FOREIGN KEY(patient_id) REFERENCES patients(patient_id)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
    FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
);