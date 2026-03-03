-- 1 --
ALTER TABLE patients
MODIFY email VARCHAR(100);

ALTER TABLE patients
ADD CONSTRAINT unique_email_patients UNIQUE (email);

-- 2 --
ALTER TABLE  consultation
CHANGE consultation_notes notes TEXT;

-- 3 --
ALTER TABLE appointments
MODIFY status ENUM('Scheduled','Completed','Cancelled','NoShow') 
DEFAULT 'NoShow';

-- 4 --
ALTER TABLE patients
MODIFY first_name VARCHAR(100);

ALTER TABLE doctors
MODIFY first_name VARCHAR(100);

-- 5 --
ALTER TABLE consultation
MODIFY consultation_id INT NOT NULL PRIMARY KEY;

-- 6 --
DROP TABLE IF EXISTS specialties;

-- 7 --
ALTER TABLE doctors
ADD COLUMN photo_path VARCHAR(255);

-- 8 --
ALTER TABLE appointments
ADD CONSTRAINT chk_appointment_date 
CHECK (appointment_date >= '2020-01-01');

-- 9 --
ALTER TABLE appointments
ADD CONSTRAINT chk_appointment_time
CHECK (appointment_time BETWEEN '08:00:00' AND '14:45:00');

-- 10 --
ALTER TABLE appointments
DROP FOREIGN KEY fk_patient;

ALTER TABLE appointments
ADD FOREIGN KEY (doctor_id)
REFERENCES doctors(doctor_id)
ON DELETE SET NULL;
