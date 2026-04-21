-- 1 Mostra el nom i llinatges dels pacients, la data de la cita i l’estat de totes les
--  cites completades de l’any 2024. Ordena el resultat per data de cita descendent 
-- i, en cas d’empat, per llinatge ascendent.

select first_name, last_name, appointment_date, status from patients
join appointments using(patient_id)
where status like 'Completed' and year(appointment_date) = 2024
order by appointment_date desc, last_name asc;

-- 2 Mostra totes les habitacions (room_number, room_type) i, si està assignada,
-- el nom del pacient i data d’admissió. Si no està assignada, mostra el text 
-- ‘Sense assignar’. Mostra només les assignacions encara actives 
-- (discharge_date IS NULL). Ordena per room_type i després per room_number.

select room_number, room_type, assignment_id, first_name, last_name, coalesce(admission_date, 'Sense assignar'), discharge_date 
from rooms
join room_assignments using(room_id)
join patients using(patient_id)
where discharge_date is null
order by  room_type, room_number;

-- 3 Llista els pacients que no tenen cap pòlissa d’assegurança associada.
-- Mostra patient_id, nom complet i email.
-- Ordena pel patient_id.

select CONCAT_WS(' ', first_name, last_name) as Nom_Complet, email, policy_id  from patients
left join insurance_policies using(patient_id)
where policy_id is null
order by patient_id;


-- 4 Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received').
-- Mostra el nom del proveïdor i el nombre de comandes.
-- Mostrar només els proveïdors amb 2 o més comandes rebudes.
-- Ordena de més a menys comandes rebudes

select name, count(order_id) from suppliers
join orders using(supplier_id)
where status = 'Recived'
group by supplier_id
having count(order_id) >= 2
order by count(order_id) desc
limit 5;


-- 5 Mostra el nom del medicament, la quantitat i el preu unitari arrodonit a 1 
-- decimal de totes les línies de comanda on la quantitat sigui superior a 5.
-- Ordena per quantitat descendent.

select name, quantity, round(unit_price, 1) from medications
join order_items using(medication_id)
where quantity > 5
order by quantity desc;

-- 6 Mostra totes les assignacions de personal a instal·lacions amb el nom de 
-- la instal·lació, el staff_type, el staff_id i la start_date. 
-- Ordena pel nom de la instal·lació

select facility_name, staff_type, staff_id, start_date from staff_facility_assignments
join hospital_facilities using(facility_id)
order by facility_name;


-- 7 Mostra les instal·lacions que no tenen cap assignació de personal.
-- Mostra facility_id, facility_name i facility_type.
select facility_id, facility_name, facility_type from hospital_facilities
left join staff_facility_assignments using(facility_id)
order by facility_name;


-- 8 Fes una consulta amb UNION que mostri en una sola llista:
-- els noms complets dels doctors, i els noms complets de les infermeres.
-- En ambdós casos, la columna ha de sortir amb el mateix àlies, per exemple nom_complet,
-- i una segona columna que indiqui el tipus de personal ('Doctor' o 'Nurse').
-- Ordena el resultat final pel nom complet.

select CONCAT_WS(' ',first_name, last_name) as nom_complet, staff_type from staff
where staff_type = 'Doctor'
union 
select CONCAT_WS(' ',first_name, last_name) as nom_complet, staff_type from staff
where staff_type = 'Nurse'
order by nom_complet;

-- 9 Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat.
-- Mostra només les especialitats que tenen exactament 1 doctor o més.
-- Ordena pel nombre de doctors descendent i després pel nom de l’especialitat.

select s.name, count(d.doctor_id) from specialties s
inner join doctors d on s.specialty_id = d.specialty_id
group by s.specialty_id
having count(d.doctor_id) >= 1
order by count(doctor_id) desc, s.name;

-- 10 Mostra els pacients ingressats amb:
-- nom complet del pacient,
-- número d’habitació,
-- tipus d’habitació,
-- data d’ingrés,
-- i el nombre de dies ingressat fins a la data actual.
select CONCAT_WS(' ', patients.first_name, patients.last_name),
rooms.room_number,
rooms.room_type,
room_assignments.admission_date,
DATEDIFF(CURDATE(), room_assignments.admission_date)
from room_assignments
inner join patients using (patient_id)
inner join rooms using (room_id)
where room_assignments.discharge_date is null
order by 5 desc;

-- 11
-- Mostra els metges amb el seu número de llicència i el nom de l’especialitat, 
-- però només aquells en què el nom de l’especialitat conté la paraula “logia”.
-- Aplica una funció de text per mostrar el nom de l’especialitat en majúscules.
-- Ordena pel número de llicència.

select doctors.license_number,
       UPPER(specialties.name)
from doctors
inner join specialties using (specialty_id)
where specialties.name like '%logia%'
order by doctors.license_number;

-- 12
-- Mostra les habitacions i el nombre total de llits que té cadascuna.
-- Mostra només les habitacions amb 2 o més llits.
-- Ordena primer pel nombre de llits descendent i després pel número d’habitació.

select room_number,
COUNT(bed_id)
from rooms
join beds using (room_id)
group by room_id
having COUNT(bed_id) >= 2
order by COUNT(bed_id) desc, room_number;

-- 13
-- Mostra els pacients que no tenen cap resultat de laboratori registrat.
-- Mostra patient_id, nom complet i telèfon.
-- Ordena pel nom complet.
-- Fes una consulta amb UNION que retorni:
-- totes les consultes mèdiques de l’any 2023, i
-- totes les cites cancel·lades de l’any 2023.
-- Les dues parts de la consulta han de retornar aquestes columnes:
-- tipus_registre, patient_id, doctor_id, data_registre.
-- A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'.
-- Ordena el resultat per data_registre.

select patients.patient_id,
CONCAT_WS(' ', patients.first_name, patients.last_name),
patients.phone
from patients
left join lab_results using (patient_id)
where lab_results.result_id is null;
-- 14
-- Fes una consulta amb UNION que retorni:
-- totes les consultes mèdiques de l’any 2023, i
-- totes les cites cancel·lades de l’any 2023.
-- Les dues parts de la consulta han de retornar aquestes columnes:
-- tipus_registre, patient_id, doctor_id, data_registre.
-- A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'.
-- Ordena el resultat per data_registre

SELECT 'Consulta',
patient_id,
doctor_id,
consultation_date
FROM consultations
WHERE YEAR(consultation_date) = 2023

UNION

SELECT 'Cita cancel·lada',
patient_id,
doctor_id,
appointment_date
FROM appointments
WHERE YEAR(appointment_date) = 2023 AND status = 'Cancelled'

-- 15
-- Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
-- Mostra només els proveïdors amb una mitjana d’import superior a 90 euros.
-- Ordena per import mitjà descendent.

select suppliers.name,
COUNT(order_id),
ROUND(avg(total_amount), 2)
from suppliers
inner join orders using (supplier_id)
group by supplier_id
having avg(total_amount) > 90
order by 3 desc;

-- 16
-- Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'.

select patient_id, CONCAT_WS(' ', first_name,last_name)
from patients
where patient_id in 
(select patient_id from billing where status = 'Paid');

-- 17

-- Mostra els medicaments que tenen un preu unitari (order_items.unit_price) 
-- superior a qualsevol dels preus de la comanda amb  order_id = 1.

select name, unit_price
from medications
join order_items using(medication_id)
where unit_price > any (
select unit_price from order_items
where order_id = 1);

-- 18
-- Mostra els pacients que tenen alguna factura amb un 
-- import superior a totes les factures d’un pacient 1.

select patients.patient_id,
CONCAT_WS(' ', first_name,last_name)
from patients
where patient_id in (select patient_id 
from billing 
where amount > all (select amount 
from billing 
where patient_id = 1));

-- 19
-- Mostra els pacients que tenen alguna factura amb un
-- import superior a la mitjana de totes les factures.

select patients.patient_id,
CONCAT_WS(' ', first_name,last_name)
from patients
where patient_id in (select patient_id 
from billing 
where amount > (select avg(amount) from billing));


-- 20
-- Mostra les comandes (orders) que tenen un import total
-- igual al màxim import de totes les comandes

select order_id, total_amount 
from orders 
where total_amount = (SELECT MAX(total_amount) from orders);

-- 21 
-- Mostra els resultats de laboratori que tenen un 
-- valor inferior al valor mínim de tots els resultats.

select result_id, result_value
from lab_results
where result_value < (select MIN(result_value) 
from lab_results);

/* 22 mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc. */
select num_consultes, count(*) as nombre_pacients
from(
select patient_id, count(*) as num_consultes
from consultations
group by patient_id
) as t_consultes
group by num_consultes;

/* 23 mostra el nombre de comandes segons l’import total de cada comanda,
 classificades en els següents trams:
menys de 200 €
entre 200 € i 500 €
més de 500 €
mostra quantes comandes hi ha en cada tram. */
select tram_import, count(*) as nombre_comandes
from ( select 
case 
when total_amount < 200 then 'menys de 200 €'
when total_amount between 200 and 500 then 'entre 200 € i 500 €'
else 'més de 500 €'
end as tram_import
from orders
) as t_trams
group by tram_import;

/* 24 mostra les consultes mèdiques (consultations) que són les més recents de cada pacient. */
select * from consultations c1
where consultation_date = (
select max(consultation_date)
from consultations c2
where c2.patient_id = c1.patient_id);