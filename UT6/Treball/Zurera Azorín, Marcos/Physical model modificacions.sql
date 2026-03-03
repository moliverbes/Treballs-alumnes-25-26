-- 1 Fes que la columna email de la taula patients sigui obligatòria i no es pugui repetir
Alter table patients
Modify column email Varchar(100) not null unique,
Modify column first_name Varchar(100);

-- 2 Canvia el nom de la columna consultations_notes a notes
Alter table consultations 
CHANGE COLUMN consultation_notes notes TEXT;

-- 3 Modifica la columna status de la taula appointments perquè inclogui un nou valor NoShow, 
-- i que aquest sigui el valor per defecte.
Alter table appointments 
Modify column status ENUM('Scheduled', 'Completed', 'Cancelled', 'NoShow') DEFAULT 'NoShow';

-- 4 Fes que les columnes first_name de les taules patients i doctors passin a poder tenir 
-- una longitud de 100 caràcters.
Alter table doctors
Modify column first_name Varchar(100);

-- 5 Elimina el AUTO_INCREMENT de la clau patient_id.
ALTER TABLE patients 
MODIFY COLUMN patient_id INT;
-- No he podido eliminar el AUTO_INCREMENT directamente porque la columna patient_id está 
-- vinculada a una clave foránea en otra tabla

-- 6 Elimina la taula d’especialitats
Drop table specialitats;
-- Daria error ya que la PK de dicha tabla es la FK de la tabla doctors 


-- 7 Afegeix una columna a la taula doctors que ens permeti desar una fotografia del metge.
ALTER TABLE doctors
ADD COLUMN photo BLOB;

-- 8 Assegura’t que la columna appointment_date  no permeti dates anteriors a l’any 2020.
ALTER TABLE appointments 
DROP CONSTRAINT appointments_chk_1;

ALTER TABLE appointments
ADD CONSTRAINT appointments_chk_1 CHECK (appointment_date >= '2020-01-01');

-- 9 Les cites mèdiques només es poden donar de 08:00 a 14:45
ALTER TABLE appointments 
DROP CONSTRAINT appointments_chk_2;
ALTER TABLE appointments
ADD CONSTRAINT appointments_chk_2 CHECK (appointment_time BETWEEN '08:00:00' and '14:45:00');

-- 10 Fes que, si eliminam el registre d’un metge, el doctor_id corresponent de la taula appointments 
-- es quedi a NULL.
ALTER TABLE appointments 
DROP FOREIGN KEY appointments_ibfk_2;

ALTER TABLE appointments
ADD CONSTRAINT fk_doctor_appointment
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL;
