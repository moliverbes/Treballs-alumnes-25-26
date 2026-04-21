-- 1
select first_name, last_name, appointment_date, status from patients
join appointments using(patient_id)
where year(appointment_date) = 2024 and status = 'Completed'
order by appointment_date desc, last_name asc;

-- 2
select room_number, room_type, first_name, last_name, admission_date from rooms
join room_assignments using(room_id)
join patients using (patient_id)
where discharge_date is null
order by room_type, room_number ;

-- 3 
select patient_id, CONCAT_WS(' ' , first_name, last_name ) as nom_complet , email from patients
left join insurance_policies using(patient_id)
where policy_id is null
order by patient_id;

-- 4
select name , count(order_id) as total_comandes from suppliers
join orders using (supplier_id)
where status = 'Received'
group by supplier_id
having total_comandes > 1
order by total_comandes desc
LIMIT 5;

-- 5
select name, quantity,  round( 4.1) unit_price from medications
join order_items using (medication_id)
where quantity > 5
order by  quantity desc;

-- 6 
SELECT facility_name, staff_type, staff_id, start_date FROM staff_facility_assignments
JOIN hospital_facilities USING(facility_id)
ORDER BY facility_name;

-- 7
select facility_id, facility_name, facility_type from hospital_facilities
left join staff_facility_assignments using (facility_id)
order by facility_name;

-- 8
SELECT CONCAT_WS(' ', s.first_name, s.last_name) AS nom_complet, 'Doctor' AS tipus_personal FROM staff s
JOIN doctors d ON s.staff_id = d.doctor_id
UNION
SELECT CONCAT_WS(' ', s.first_name, s.last_name) AS nom_complet, 'Nurse' AS tipus_personal
FROM staff s
JOIN nurses n ON s.staff_id = n.nurse_id
ORDER BY nom_complet;

-- 9 
SELECT s.name AS especialitat, COUNT(d.doctor_id) AS total_doctors FROM specialties s
JOIN doctors d USING(specialty_id)
GROUP BY s.specialty_id
HAVING total_doctors >= 1
ORDER BY total_doctors DESC, especialitat ASC;

-- 10
select CONCAT(first_name,'  ',last_name) as nom_complet, room_number, room_type, datediff(CURDATE(), admission_date) as dies  from patients
join room_assignments using (patient_id)
join rooms USING(room_id)
where discharge_date IS NULL;

-- 11
SELECT d.license_number, UPPER(s.name) AS especialitat_maj FROM doctors d
JOIN specialties s USING(specialty_id)
WHERE s.name LIKE '%logia%'
ORDER BY d.license_number;

-- 12
SELECT r.room_number, COUNT(b.bed_id) AS total_llits FROM rooms r
JOIN beds b USING(room_id)
GROUP BY r.room_id
HAVING total_llits >= 2
ORDER BY total_llits DESC, r.room_number ASC;

-- 13

SELECT p.patient_id, CONCAT_WS(' ', p.first_name, p.last_name) AS nom_complet, p.phone FROM patients p
LEFT JOIN lab_results lr USING(patient_id)
WHERE lr.result_id IS NULL
ORDER BY nom_complet;

-- 14
SELECT 'Consulta' AS tipus_registre, patient_id, doctor_id, consultation_date AS data_registre FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION
SELECT 'Cita cancel·lada' AS tipus_registre, patient_id, doctor_id, appointment_date AS data_registre
FROM appointments
WHERE YEAR(appointment_date) = 2023 AND status = 'Cancelled'
ORDER BY data_registre;

-- 15
SELECT s.name, COUNT(o.order_id) AS total_comandes, ROUND(AVG(o.total_amount), 2) AS import_mitja FROM suppliers s
JOIN orders o USING(supplier_id)
GROUP BY s.supplier_id
HAVING import_mitja > 90
ORDER BY import_mitja DESC;

-- 16
SELECT * FROM patients 
WHERE patient_id IN (SELECT patient_id FROM billing WHERE status = 'Paid');

-- 17
SELECT * FROM medications 
JOIN order_items USING(medication_id)
WHERE unit_price > ANY (SELECT unit_price FROM order_items WHERE order_id = 1);


-- 18
SELECT DISTINCT patient_id FROM billing 
WHERE amount > ALL (SELECT amount FROM billing WHERE patient_id = 1);

-- 19
SELECT * FROM billing 
WHERE amount > (SELECT AVG(amount) FROM billing);

-- 20
SELECT * FROM orders 
WHERE total_amount = (SELECT MAX(total_amount) FROM orders);

-- 21
SELECT * FROM lab_results 
WHERE result_value < (SELECT MIN(result_value) FROM lab_results);

-- 22
SELECT num_consultes, COUNT(*) AS quantitat_pacients
FROM (SELECT patient_id, COUNT(*) AS num_consultes FROM consultations GROUP BY patient_id) AS t1
GROUP BY num_consultes;

-- 23
SELECT tram, COUNT(*) AS total_comandes
FROM (
SELECT order_id, 
CASE 
WHEN total_amount < 200 THEN 'Menys de 200 €'
WHEN total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
ELSE 'Més de 500 €'
END AS tram
FROM orders
) AS derivat
GROUP BY tram;

-- 24
SELECT * FROM consultations c1
WHERE consultation_date = (
SELECT MAX(consultation_date) 
FROM consultations c2 
WHERE c2.patient_id = c1.patient_id
);
