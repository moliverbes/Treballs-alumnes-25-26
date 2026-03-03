
create database HospitalDB;
use HospitalDB;


create table patient(
patient_id Int auto_increment,
first_name varchar(50) not null ,
last_name varchar(50) not null,
birth_date date,
gender enum('Male', 'Female', 'Other'),
phone varchar (20),
email varchar (100),
address varchar (200),
primary key (patient_id)
);

create table specialties(
specialty_id int auto_increment,
name varchar (100) unique not null ,
description text,
primary key (specialty_id)
);

create table doctor(
doctor_id int auto_increment,
first_name varchar (50) not null,
license_number varchar(20) unique not null,
specialty_id int,
phone varchar (20),
email varchar (100) check (email like '%@%') ,
primary key (doctor_id),
foreign key (specialty_id) references specialties (specialty_id)
);

create table consultation
(
consultation_id int auto_increment,
patient_id int,
doctor_id int,
consultation_date date not null,
consultation_notes text,
primary key (consultation_id),
foreign key (patient_id) references patient(patient_id),
foreign key (doctor_id) references doctor(doctor_id)
);


create table appointment(
appointment_id int auto_increment,
patient_id Int ,
doctor_id int,
appointment_date date check(appointment_date > date '31-12-22'),
appointment_time time check (appointment_time >= time '8:00' and appointment_time <= '20:00' ) ,
status enum('Scheduled', 'Completed', 'Cancelled'),
primary key (appointment_id),
foreign key (patient_id) references patient (patient_id) on delete restrict,
foreign key (doctor_id) references doctor (doctor_id)
);
