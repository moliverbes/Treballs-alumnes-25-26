-- 1
ALTER TABLE patients
MODIFY email VARCHAR(100) NOT NULL UNIQUE;

-- 2 
ALTER TABLE consultations
RENAME COLUMN consultation_date TO notes;

-- 3
ALTER TABLE appointments
MODIFY status ENUM('Scheduled', 'Completed', 'Cancelled', 'NoShow') DEFAULT 'NoShow';

-- 4
ALTER TABLE patients
MODIFY first_name VARCHAR(100);

ALTER TABLE doctors
MODIFY first_name VARCHAR(100);

-- 5 No es pot canviar ja que es una FK
ALTER TABLE patients
MODIFY patient_id INT;

-- 6 No es pot eliminar ja que té una FK
ALTER TABLE specialties
DROP specialties;

-- 7 
ALTER TABLE doctors
ADD COLUMN image BLOB;

-- 8
ALTER TABLE appointments
ADD CONSTRAINT chk_dates
CHECK (YEAR(appointment_date) > 2020);

-- 9
ALTER TABLE consultations
ADD CONSTRAINT chk_consultations_hour
CHECK (HOUR(consultation_date) BETWEEN '08:00' AND '14:45'); 


-- 10
ALTER TABLE appointments
MODIFY doctor_id INT NULL;

ALTER TABLE appointments
DROP FOREIGN KEY fk_appointments_doctor;

ALTER TABLE appointments
ADD CONSTRAINT fk_appointments_doctors
FOREIGN KEY (appointment_id) REFERENCES doctors(doctor_id);

