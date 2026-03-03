CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE patients(
 patient_id INT AUTO_INCREMENT ,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 birth_date DATE,
 gender ENUM('Male','Female','Other'),
 phone VARCHAR(20),
 email VARCHAR(100) CHECK (email LIKE '%@%'),
 addres VARCHAR(200) DEFAULT 'N/A',
 PRIMARY KEY (patient_id)
);
CREATE TABLE specialties(
 specialty_id INT AUTO_INCREMENT,
 name VARCHAR(100) NOT NULL,
 description TEXT,
 PRIMARY KEY( specialty_id)
);
CREATE TABLE doctors(
doctor_id INT AUTO_INCREMENT, 
specialty_id INT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(100) NOT NULL,
license_number VARCHAR(20) NOT NULL UNIQUE,
phone VARCHAR(20),
email VARCHAR(100),
PRIMARY KEY (doctor_id),
FOREIGN KEY (specialty_id) REFERENCES specialties (specialty_id)
);
CREATE TABLE appointments(
 appointment_id INT AUTO_INCREMENT,
 patient_id INT,
 doctor_id INT,
 appointment_date DATE CHECK (appointment_date > '31-12-22') NOT NULL,
 appointment_time TIME CHECK(appointment_time BETWEEN '8:00' AND '20:00') NOT NULL,
 status ENUM('Scheduled','Completed','Cancelled'),
 PRIMARY KEY (appointment_id),
 FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON UPDATE CASCADE,
 FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) 
);
CREATE TABLE consultations(
 consultation_id INT AUTO_INCREMENT,
 patient_id INT,
 doctor_id INT,
 consultation_date DATE NOT NULL,
 consultation_notes TEXT NOT NULL,
 PRIMARY KEY (consultation_id),
 FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
 FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) 
);



-- 1 --
ALTER TABLE patients
 MODIFY COLUMN email  VARCHAR(100) CHECK (email LIKE '%@%') NOT NULL UNIQUE;
-- 2 --
ALTER TABLE consultations
 RENAME COLUMN consultation_notes TO notes;
-- 3 --
ALTER TABLE appointments
 MODIFY COLUMN status ENUM('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'NoShow';
-- 4 --
ALTER TABLE patients
 MODIFY COLUMN first_name VARCHAR(100) NOT NULL;
ALTER TABLE doctors
 MODIFY COLUMN first_name VARCHAR(100) NOT NULL;
-- 5 --
ALTER TABLE patients
	 DROP PRIMARY KEY ,
     ADD PRIMARY KEY (patient_id);
-- 6 --
DROP TABLE specialties; -- No es pot eliminar ja que la clau primaria pertany a una clau foranea d'una altre taula en aquesta cas la de doctors
-- 7 --  
ALTER TABLE doctors
	ADD COLUMN imatge_doctor VARCHAR(255);
-- 8 -- 
ALTER TABLE appointments
	MODIFY COLUMN appointment_date DATE CHECK (appointment_date > '31-12-22') CHECK (appointment_date > '01-01-20') NOT NULL;
-- 9 -- 
ALTER TABLE appointments
	MODIFY COLUMN appointment_time TIME CHECK(appointment_time BETWEEN '8:00' AND '14:45') NOT NULL;
-- Hem de borrar la primera restricció perque no es consistent amb la actual restricció.
ALTER TABLE appointments
	DROP CONSTRAINT appointments_chk_2;
/*
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'NoShow',
  `doctor_id` int DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE SET NULL,
  CONSTRAINT `appointments_chk_1` CHECK ((`appointment_date` > _utf8mb4'31-12-22')),
  CONSTRAINT `appointments_chk_2` CHECK ((`appointment_time` between '08:00:00' and '20:00:00')),
  CONSTRAINT `appointments_chk_3` CHECK ((`appointment_date` > _utf8mb4'31-12-22')),
  CONSTRAINT `appointments_chk_4` CHECK ((`appointment_date` > _utf8mb4'01-01-20')),
  CONSTRAINT `appointments_chk_5` CHECK ((`appointment_time` between '08:00:00' and '14:45:00'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
*/
-- 10 --

ALTER TABLE appointments
 DROP CONSTRAINT appointments_ibfk_2;
 
ALTER TABLE appointments
 MODIFY COLUMN doctor_id INT NULL,
 ADD FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL;
DESCRIBE appointments;


CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'NoShow',
  `doctor_id` int DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE SET NULL,
  CONSTRAINT `appointments_chk_1` CHECK ((`appointment_date` > _utf8mb4'31-12-22')),
  CONSTRAINT `appointments_chk_3` CHECK ((`appointment_date` > _utf8mb4'31-12-22')),
  CONSTRAINT `appointments_chk_4` CHECK ((`appointment_date` > _utf8mb4'01-01-20')),
  CONSTRAINT `appointments_chk_5` CHECK ((`appointment_time` between '08:00:00' and '14:45:00'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



