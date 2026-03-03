-- 1
ALTER TABLE patients
	MODIFY email VARCHAR(255) NOT NULL UNIQUE;

-- 2
ALTER TABLE consultations
	RENAME COLUMN consultations TO notes;

-- 3
ALTER TABLE appointments
	MODIFY status ENUM('Scheduled','Completed','Cancelled','NoShow')
	DEFAULT 'NoShow';

-- 4
ALTER TABLE patients
	MODIFY first_name VARCHAR(100) NOT NULL;
ALTER TABLE doctors
	MODIFY first_name VARCHAR(100) NOT NULL;

-- 5
ALTER TABLE consultations
	MODIFY consultation_id INT;

-- 6
DROP TABLE specialties;

-- 7
ALTER TABLE doctors
	ADD photo LONGBLOB;

-- 8
ALTER TABLE appointments
	MODIFY appointment_date DATE
	CHECK (appointment_date >= '2020-01-01');

-- 9
ALTER TABLE appointments
	MODIFY appointment_time TIME
	CHECK (appointment_time BETWEEN '08:00:00' AND '14:45:00');

-- 10
ALTER TABLE appointments
	MODIFY doctor_id INT UNSIGNED NULL;
ALTER TABLE appointments
	DROP FOREIGN KEY appointments_ibfk_2;
ALTER TABLE appointments
	ADD CONSTRAINT fk_doctor
	FOREIGN KEY (doctor_id)
	REFERENCES (doctors_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE;