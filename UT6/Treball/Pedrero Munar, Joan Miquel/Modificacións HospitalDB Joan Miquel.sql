-- 1
ALTER TABLE patients
MODIFY email VARCHAR(100) NOT NULL UNIQUE;

-- 2
ALTER TABLE consultations
CHANGE consultation_notes notes TEXT;

-- 3
ALTER TABLE appointments
MODIFY status ENUM('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'NoShow';

-- 4
ALTER TABLE patients
MODIFY first_name VARCHAR(100) NOT NULL;

ALTER TABLE doctors
MODIFY first_name VARCHAR(100) NOT NULL;

-- 5
ALTER TABLE consultations
MODIFY consultation_id INT;

-- 6 Dona error degut a que no es pot borrar una clau primaria no es pot borrar si es clau forana a una altre taula
ALTER TABLE doctors 
DROP COLUMN speciality_id;
DROP TABLE specialities;

-- 7
ALTER TABLE doctors
ADD photo LONGBLOB;

-- 8
ALTER TABLE appointments
MODIFY appointment_date DATE NOT NULL CHECK (appointment_date > '2019-12-31');

-- 9
ALTER TABLE appointments
MODIFY appointment_time TIME NOT NULL CHECK (appointment_time BETWEEN '08:00:00' AND '14:45:00');

-- 10
ALTER TABLE appointments
MODIFY doctor_id INT NULL;

ALTER TABLE appointments
ADD FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id)
ON DELETE SET NULL;