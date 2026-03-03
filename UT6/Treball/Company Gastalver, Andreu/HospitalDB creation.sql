CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

CREATE TABLE patients (
	patient_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(20),
    email VARCHAR(100) CHECK (email LIKE '%@%'),
    address VARCHAR(200) DEFAULT 'N/A',
    PRIMARY KEY (patient_id)
);

CREATE TABLE specialties (
	speciality_id INT AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    PRIMARY KEY (speciality_id)
);

CREATE TABLE doctors (
	doctor_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) CHECK (email LIKE '%@%'),
    speciality_id INT,
    PRIMARY KEY (doctor_id),
    FOREIGN KEY (speciality_id) REFERENCES specialties(speciality_id)
    );
    
    CREATE TABLE appointments (
		appointment_id INT AUTO_INCREMENT,
        patient_id INT,
        doctor_id INT,
        appointment_date DATE CHECK (appointment_date > '2022-12-31'),
        appointment_time TIME CHECK (appointment_time BETWEEN '08:00:00' AND '20:00:00'),
        status ENUM('Scheduled','Completed','Cancelled'),
        PRIMARY KEY (appointment_id),
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id) 
			ON DELETE RESTRICT 
            ON UPDATE CASCADE,
        FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
    );
    
    CREATE TABLE consultations (
		consultation_id INT AUTO_INCREMENT,
        patient_id int,
        doctor_id INT,
        consultation_date DATE NOT NULL,
        consultation_notes TEXT,
        PRIMARY KEY (consultation_id),
        FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
        FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
    );