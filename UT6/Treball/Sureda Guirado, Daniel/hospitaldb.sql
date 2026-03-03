create database HospitalDB;

use HospitalDB;

create table patients(
patient_id int primary key auto_increment,
first_name varchar(50)not null,
last_name varchar (100)not null,
birth_date date,
gender enum ('Male','Female','Other'),
phone varchar(20),
email varchar (100) check (email like '%@%'),
address varchar(200) default 'N/A'
);

create table appointments(
appointment_id int primary key auto_increment,
patient_id int not null,
doctor_id int not null,
appointment_date date not null check (appointment_date > '31-12-22'),
appointment_time time not null check (appointment_time between '8:00:00' and '20:00:00'),
status enum ('Scheduled','Completed','Cancelled')
);

create table doctors(
doctor_id int primary key auto_increment,
first_name varchar(50)not null,
last_name varchar(100) not null,
license_number varchar(20) not null unique,
specialty_id int,
phone varchar(20),
email varchar(100) check (email like '%@%')
);

create table consultations (
consultation_id int primary key auto_increment,
patient_id int not null,
doctor_id int not null,
consultation_date date not null,
consultation_notes text
);

create table specialties (
specialty_id int primary key auto_increment,
name varchar (100) not null unique,
description text
);


alter table appointments 
add constraint fk_appointments_patient
foreign key (patient_id) references patients(patient_id);

alter table appointments
add constraint fk_appointments_doctor
foreign key (doctor_id) references doctors(doctor_id);

alter table doctors 
add constraint fk_doctors_specialties
foreign key (doctor_id) references specialties(specialty_id);

alter table consultations
add constraint fk_consultations_patients
foreign key (patient_id) references patients(patient_id);

alter table consultations 
add constraint fk_consultations_doctors
foreign key (doctor_id) references doctors(doctor_id)



