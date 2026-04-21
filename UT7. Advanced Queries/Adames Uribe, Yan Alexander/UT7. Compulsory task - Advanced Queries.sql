-- 1
SELECT first_name, last_name, appointment_date, status
FROM patients
JOIN appointments USING(patient_id)
WHERE YEAR(appointment_date) = 2024 AND status LIKE 'Completed'
ORDER BY appointment_date, last_name ASC;

-- 2
SELECT room_number, room_type,
COALESCE(first_name, 'Sense assignar') AS first_name, admission_date
FROM rooms
LEFT JOIN room_assignments USING (room_id)
LEFT JOIN patients USING(patient_id)
WHERE discharge_date IS NULL
ORDER BY room_type, room_number;

-- 3
SELECT patient_id, CONCAT_WS(' ', first_name, last_name) AS nom_complet, email
FROM patients p
LEFT JOIN insurance_policies ip USING(patient_id)
WHERE ip.patient_id IS NULL
ORDER BY patient_id;
SELECT * FROM insurance_policies;

-- 4
SELECT name, COUNT(order_id) AS nombre_comandes
FROM suppliers
JOIN orders USING(supplier_id)
WHERE status LIKE 'Received'
GROUP BY supplier_id
HAVING nombre_comandes >= 2
ORDER BY nombre_comandes DESC
LIMIT 5;

-- 5
SELECT name, quantity, ROUND(unit_price, 1) AS unit_price_arrodonit
FROM medications
JOIN order_items USING(medication_id)
WHERE quantity > 5
ORDER BY quantity DESC;

-- 6
SELECT staff_type, staff_id, start_date, facility_name
FROM staff_facility_assignments
JOIN hospital_facilities
ORDER BY facility_name;

-- 7
SELECT hf.facility_id, hf.facility_name, hf.facility_type
FROM hospital_facilities hf
LEFT JOIN staff_facility_assignments sfa USING(facility_id)
WHERE sfa.facility_id IS NULL;

-- 8
SELECT CONCAT_WS(' ', first_name, last_name) AS nom_complet, 'Doctor'
FROM staff
WHERE staff_type = 'Doctor'
UNION
SELECT CONCAT_WS(' ', first_name, last_name) AS nom_complet, 'Nurse'
FROM staff
WHERE staff_type = 'Nurse'
ORDER BY nom_complet;

-- 9
SELECT name, COUNT(doctor_id) AS nombre_doctors
FROM specialties
JOIN doctors USING(specialty_id)
GROUP BY name
HAVING nombre_doctors >= 1
ORDER BY nombre_doctors DESC, name;

-- 10
SELECT CONCAT_WS(' ', first_name, last_name), room_number, room_type, admission_date,
DATEDIFF(CURRENT_DATE, admission_date) AS dies_ingressat
FROM patients
JOIN room_assignments USING(patient_id)
JOIN rooms USING(room_id)
WHERE discharge_date IS NULL
ORDER BY dies_ingressat DESC;

-- 11
SELECT license_number, UPPER(name) AS name_majuscules
FROM doctors
JOIN specialties USING(specialty_id)
WHERE name LIKE '%logia%'
ORDER BY license_number;

-- 12
SELECT room_number, COUNT(bed_id) AS nombre_llits
FROM rooms
JOIN beds USING(room_id)
GROUP BY room_id
HAVING nombre_llits >= 2
ORDER BY nombre_llits DESC, room_number;

-- 13
SELECT p.patient_id, CONCAT_WS(' ', p.first_name, p.last_name) AS nom_complet, p.phone
FROM patients p
LEFT JOIN lab_results lr USING(patient_id)
WHERE lr.patient_id IS NULL
ORDER BY nom_complet;

-- 14
SELECT 'Consulta' AS tipus_registre, patient_id, doctor_id,
consultation_date AS data_registre
FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION
SELECT 'Cita_cancel·lada' AS tipus_registre, patient_id, doctor_id,
appointment_date AS data_registres
FROM appointments
WHERE YEAR(appointment_date) = 2023 AND status = 'Cancelled'
ORDER BY data_registre;

-- 15
SELECT name, COUNT(order_id) AS nombre_comandes,
ROUND(AVG(total_amount), 2) AS import_mitjà
FROM suppliers
JOIN orders USING(supplier_id)
GROUP BY name
HAVING import_mitjà > 90
ORDER BY import_mitjà DESC;

-- 16
SELECT patient_id, first_name, last_name
FROM patients
WHERE patient_id IN (
SELECT patient_id 
FROM billing
WHERE status = 'Paid');

-- 17
SELECT name, unit_price
FROM medications
JOIN order_items USING(medication_id)
WHERE unit_price > ANY (
SELECT unit_price FROM order_items
WHERE order_id = 1);

-- 18
SELECT patient_id, first_name, last_name, amount
FROM patients
JOIN billing USING(patient_id)
WHERE amount > ALL (
SELECT amount FROM billing
WHERE patient_id = 1);

-- 19
SELECT patient_id, first_name, last_name, amount
FROM patients
JOIN billing USING(patient_id)
WHERE amount > ALL (
SELECT AVG(amount) FROM billing);

-- 20
SELECT order_id, total_amount
FROM orders
WHERE total_amount = (
SELECT MAX(total_amount) FROM orders);

-- 21
SELECT result_id, result_value
FROM lab_results
WHERE result_value < ALL (
SELECT MIN(result_value) FROM lab_results);

-- 22
SELECT total_consultes, COUNT(*) AS total_pacients FROM (
SELECT patient_id, COUNT(*) AS total_consultes
FROM consultations
GROUP BY patient_id) AS subquery
GROUP BY total_consultes;

-- 23
SELECT
	CASE
		WHEN import_total < 200 THEN 'Menys de 200 €'
        WHEN import_total BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
        ELSE 'Més de 500 €'
	END AS tram_import,
    COUNT(*) AS nombre_comandes FROM (
SELECT order_id, SUM(total_amount) AS import_total
FROM orders
GROUP BY order_id) AS subquery
GROUP BY tram_import;

-- 24
SELECT * FROM consultations c1
WHERE consultation_date = (
SELECT MAX(consultation_date) FROM consultations c2
WHERE c2.patient_id = c1.patient_id);