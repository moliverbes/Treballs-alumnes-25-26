create database hospitaldb;
use hospitaldb;

create table specialities (
    speciality_id int primary key auto_increment,
    name varchar(100) not null unique,
    description text
);

create table patients (
    patient_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(100) not null,
    birth_date date,
    gender enum('Male','Female','Other'),
    phone varchar(20),
    email varchar(100) check (email like '%@%'),
    address varchar(200) default 'N/A'
);

create table doctors (
    doctor_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(100) not null,
    license_number varchar(20) unique not null,
    speciality_id int,
    phone varchar(20),
    email varchar(100) check (email like '%@%'),
    foreign key (speciality_id) references specialities(speciality_id)
);

create table appointments (
    appointment_id int primary key auto_increment,
    patient_id int not null,
    doctor_id int not null,
    appointment_date date check (appointment_date > '2022-12-31'),
    appointment_time time check (appointment_time between '08:00:00' and '20:00:00'),
    status enum('Scheduled','Completed','Cancelled'),
    foreign key (patient_id) references patients(patient_id) on delete restrict on update cascade,
    foreign key (doctor_id) references doctors(doctor_id)
);

create table consultations (
    consultation_id int primary key auto_increment,
    patient_id int,
    doctor_id int,
    consultation_date date,
    consultation_notes text,
    foreign key (patient_id) references patients(patient_id),
    foreign key (doctor_id) references doctors(doctor_id)
);


-- Modificaciones
#1 Haz que la columna email de la mesa patients sea obligatoria y no se pueda repetir.
alter table patients
modify email varchar(100) not null unique;

#2 Cambia el nombre de la columna consultations_notes a notas.
alter table consultations
change consultation_notes notes text;

#3 Modifica la columna status de la tabla appointments para que incluya un nuevo valor NoShow, y que éste sea el valor por defecto.
alter table appointments
modify status enum('Scheduled','Completed','Cancelled','NoShow') default 'NoShow';

#4 Haz que las columnas first_name de las tablas patients y doctors pasen a poder tener una longitud de 100 caracteres.
alter table patients
modify first_name varchar(100);

alter table doctors
modify first_name varchar(100) not null;

#5 Elimina el AUTO_INCREMENT de la clave consultation_id.
alter table consultations
modify consultation_id int;

#6 Elimina la mesa de especialidades
alter table doctors
drop foreign key doctors_ibfk_1;

alter table doctors
drop column speciality_id;

drop table specialities;

#7 Añade una columna a la mesa doctores que nos permita guardar una fotografía del médico.
alter table doctors
add photo blob;

#8 Asegúrate de que la columna appointment_date no permita fechas anteriores al año 2020.
alter table appointments
modify appointment_date date check (appointment_date >= '2020-01-01');

#9 Las citas médicas sólo pueden darse de 08:00 a 14:45
alter table appointments
modify appointment_time time check (appointment_time between '08:00:00' and '14:45:00');

#10 Haz que, si eliminamos el registro de un médico, el doctor_id correspondiente de la tabla appointments se quede en NULL.
alter table appointments
modify doctor_id int null;

alter table appointments
drop foreign key appointments_ibfk_1;

alter table appointments
add foreign key (doctor_id) references doctors(doctor_id) on delete set null on update cascade;