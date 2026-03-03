-- 1
alter table patient 
modify column email varchar (100) not null unique;

-- 2
alter table consultation
rename column consultation_notes to notes;

-- 3
alter table appointment 
modify column  status enum('Scheduled', 'Completed', 'Cancelled', 'NoShow') default 'NoShow';


-- 4
alter table patient
modify column first_name varchar(100) not null;
alter table doctor
modify column first_name varchar(100) not null;

-- 5 No funciona Be ja que es una Foren Key 
alter table patient
modify column patient_id int;

-- 6 No es pot eliminar Ja que aquesta PK es una FK a una altra taula
drop table epecialties;


-- 7
alter table doctor
add column image blob;

-- 8
alter table appointment
add check (appointment_date > date '2019-12-31');

-- 9
alter table appointment
add check (appointment_time between '8:00:00' and '14:45:00');

-- 10
alter table appointment
modify column doctor_id INT;

alter table appointment
drop constraint appointment_ibfk_2;

alter table appointment
add foreign key (doctor_id) references doctor(doctor_id)
on delete set null;

