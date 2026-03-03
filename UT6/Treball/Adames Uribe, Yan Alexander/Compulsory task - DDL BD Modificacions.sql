-- 1. Fes que la columna email de la taula patients sigui obligatòria i no es pugui repetir.
ALTER TABLE patients
	MODIFY COLUMN email VARCHAR(100) UNIQUE NOT NULL;

-- 2. Canvia el nom de la columna consultations_notes a notes.
ALTER TABLE consultations
	RENAME COLUMN consultation_notes TO notes;

-- 3. Modifica la columna status de la taula appointments perquè inclogui un nou valor NoShow, i que aquest sigui el valor per defecte.
ALTER TABLE appointments
	MODIFY COLUMN status ENUM('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'NoShow';

-- 4. Fes que les columnes first_name de les taules patients i doctors passin a poder tenir una longitud de 100 caràcters.
ALTER TABLE patients
	MODIFY COLUMN first_name VARCHAR(100) NOT NULL;

ALTER TABLE doctors
	MODIFY COLUMN first_name VARCHAR(100) NOT NULL;

-- 5.Elimina el AUTO_INCREMENT de la clau consultation_id.
ALTER TABLE consultations
	MODIFY COLUMN consultation_id INT;

-- 6. Elimina la taula d’especialitats
-- No es pot eliminar ya que és una FK a la taula doctors.
DROP TABLE specialities;

-- 7. Afegeix una columna a la taula doctors que ens permeti desar una fotografia del metge.
ALTER TABLE doctors
	ADD COLUMN  foto BLOB;

-- 8. Assegura’t que la columna appointment_date  no permeti dates anteriors a l’any 2020.
ALTER TABLE appointments
	ADD CHECK(appointment_date > DATE '2019-12-31');

-- 9. Les cites mèdiques només es poden donar de 08:00 a 14:45.
ALTER TABLE appointments
	ADD CHECK(appointment_time BETWEEN '08:00:00' AND '14:45:00');

-- 10. Fes que, si eliminam el registre d’un metge, el doctor_id corresponent de la taula appointments es quedi a NULL.
ALTER TABLE appointments
	MODIFY COLUMN doctor_id INT;

ALTER TABLE appointments
	DROP CONSTRAINT appointments_ibfk_2;

ALTER TABLE appointments
	ADD FOREIGN KEY(doctor_id) REFERENCES doctors(doctor_id)
	ON DELETE SET NULL;