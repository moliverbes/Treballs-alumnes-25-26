-- 1 
alter table patients 
modify email varchar(100) not null unique;

-- 2 
alter table consultations
 rename column consultation_notes to notes;
 
-- 3
alter table appointments 
modify column status enum ('Scheduled','Completed','Cancelled','NoShow') default ('NoShow');

-- 4
alter table patients
modify first_name varchar(100);

alter table doctors
modify first_name varchar(100);

-- 5 No es pot canviar, és una FK
alter table patients
modify patient_id int;

-- 6 
-- alter table
-- drop specialties;
-- No es pot fer ja que hi ha FK

-- 7 
alter table doctors
add column foto varchar(255) default 'default_doctor.png';

-- 8 
alter table appointments 
add constraint chk_dades_anteriors
check (year(appointment_date) > 2020);

-- 9 
alter table consultations
add constraint chk_horari_cites
check (hour(consultation_date) between '08:00' and '14:45');

-- 10
alter table appointments
modify doctor_id int null;

alter table appointments 
drop foreign key fk_appointments_doctor;

alter table appointments 
add constraint fk_appointments_doctor
foreign key (doctor_id) references doctors(doctor_id)
on delete set null;


