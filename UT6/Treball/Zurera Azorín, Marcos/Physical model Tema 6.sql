Create database if not exists HostipatDB;

Create table especialties (
specialty_id INT AUTO_INCREMENT PRIMARY KEY,
name Varchar(100) NOT NULL Unique,
description TEXT
);

Create table doctors (
doctor_id INT AUTO_INCREMENT PRIMARY KEY,
first_name Varchar(50),
last_name Varchar(100),
license_number Varchar(20) NOT NULL Unique,
specialty_id INT,
phone varchar(20),
email varchar(100)
);

Create table consultations (
consulation_id INT AUTO_INCREMENT PRIMARY KEY,
patient_id INT,
doctor_id INT,
consultation_date DATE,
consultation_notes TEXT
);

Create table patients (
patient_id INT AUTO_INCREMENT PRIMARY KEY,
first_name Varchar(50),
last_name Varchar(100),
birth_date DATE,
gender ENUM ('Male', 'Female', 'Other'),
phone Varchar(20),
email Varchar (100) CHECK (email like '%@%'	),
address Varchar(200) default 'N/A'
);

Create table appointments (
appointment_id INT AUTO_INCREMENT PRIMARY KEY, 
patient_id INT,
doctor_id INT,
appointment_date DATE CHECK (appointment_date > '2022-12-31'),
appointment_time TIME CHECK (appointment_time BETWEEN '08:00:00' AND '20:00:00'),
status ENUM ('Scheduled', 'Completed', 'Cancelled'),
FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

