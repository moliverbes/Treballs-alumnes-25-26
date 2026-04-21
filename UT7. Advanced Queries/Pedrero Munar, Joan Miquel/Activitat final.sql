-- 1
SELECT CONCAT_WS(' ', first_name, last_name), appointment_date, status FROM patients
INNER JOIN appointments USING (patient_id)
WHERE status = 'Completed' AND YEAR(appointment_date) = 2024
ORDER BY appointment_date DESC, last_name ASC;

-- 2
SELECT room_number, room_type, COALESCE(CONCAT_WS(' ', first_name, last_name), 'Sense assignar'), admission_date FROM rooms
LEFT JOIN room_assignments USING (room_id)
LEFT JOIN patients USING (patient_id)
WHERE discharge_date IS NULL
ORDER BY room_type ASC, room_number ASC;

-- 3
SELECT patient_id, CONCAT_WS(' ', first_name, last_name), email FROM patients
LEFT JOIN insurance_policies USING (patient_id)
WHERE policy_id IS NULL
ORDER BY patient_id ASC;

-- 4
SELECT name, COUNT(order_id) AS total_comandes FROM suppliers
INNER JOIN orders USING (supplier_id)
WHERE status = 'Received'
GROUP BY supplier_id
HAVING COUNT(order_id) >= 2
ORDER BY total_comandes DESC
LIMIT 5;

-- 5
SELECT name, quantity, ROUND(unit_price, 1) AS preu_unitari FROM order_items
INNER JOIN medications USING (medication_id)
WHERE quantity > 5
ORDER BY quantity DESC;

-- 6
SELECT facility_name, staff_type, staff_id, start_date FROM staff_facility_assignments
INNER JOIN hospital_facilities USING (facility_id)
ORDER BY facility_name ASC;

-- 7
SELECT facility_id, facility_name, facility_type FROM hospital_facilities
LEFT JOIN staff_facility_assignments USING (facility_id)
WHERE assignment_id IS NULL;

-- 8
SELECT CONCAT_WS(' ', first_name, last_name) AS nom_complet, 'Doctor'AS tipus_personal FROM doctors d
INNER JOIN staff s ON d.doctor_id = s.staff_id
UNION
SELECT  CONCAT_WS(' ', first_name, last_name) AS nom_complet, 'Nurse' AS tipus_personal FROM nurses n
INNER JOIN staff s ON n.nurse_id = s.staff_id
ORDER BY nom_complet ASC;

-- 9
SELECT name AS nom_especialitat, COUNT(doctor_id) AS nombre_doctors FROM specialties
INNER JOIN doctors USING (specialty_id)
GROUP BY specialty_id
HAVING COUNT(doctor_id) >= 1
ORDER BY nombre_doctors DESC, nom_especialitat ASC;

-- 10
SELECT CONCAT_WS(' ', first_name, last_name) AS nom_complet, room_number, room_type, admission_date, DATEDIFF(CURDATE(), admission_date) AS dies_ingressat FROM patients
INNER JOIN room_assignments USING (patient_id)
INNER JOIN rooms USING (room_id)
WHERE discharge_date IS NULL
ORDER BY dies_ingressat DESC;

-- 11
SELECT license_number, UPPER(name) AS nom_especialitat FROM doctors
INNER JOIN specialties USING (specialty_id)
WHERE name LIKE '%logia%'
ORDER BY license_number ASC;

-- 12
SELECT room_number, COUNT(bed_id) AS total_llits FROM rooms
INNER JOIN beds USING (room_id)
GROUP BY room_id
HAVING COUNT(bed_id) >= 2
ORDER BY total_llits DESC, room_number ASC;

-- 13
SELECT patient_id, CONCAT_WS(' ', first_name, last_name) AS nom_complet, phone FROM patients
LEFT JOIN lab_results USING (patient_id)
WHERE result_id IS NULL
ORDER BY nom_complet ASC;

-- 14
SELECT 'Consulta' AS tipus_registre, patient_id, doctor_id, consultation_date AS data_registre FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION
SELECT 'Cita cancel·lada' AS tipus_registre, patient_id, doctor_id, appointment_date AS data_registre FROM appointments
WHERE status = 'Cancelled' AND YEAR(appointment_date) = 2023
ORDER BY data_registre ASC;

-- 15
SELECT name, COUNT(order_id) AS total_comandes, ROUND(AVG(total_amount), 2) AS import_mitja FROM suppliers
INNER JOIN orders USING (supplier_id)
GROUP BY supplier_id
HAVING AVG(total_amount) > 90
ORDER BY import_mitja DESC;

-- SUBCONSULTES

-- 16 
SELECT patient_id, CONCAT_WS(' ', first_name, last_name) AS nom_complet FROM patients
WHERE patient_id IN (SELECT patient_id FROM billing 
WHERE status = 'Paid');

-- 17
SELECT DISTINCT name AS nom_medicament, unit_price AS preu_unitari FROM order_items
INNER JOIN medications USING (medication_id)
WHERE unit_price > ANY (SELECT unit_price FROM order_items 
WHERE order_id = 1);

-- 18
SELECT patient_id, CONCAT_WS(' ', first_name, last_name) AS nom_complet FROM patients
WHERE patient_id IN (SELECT patient_id FROM billing 
WHERE amount > ALL (SELECT amount FROM billing 
WHERE patient_id = 1));

-- 19
SELECT DISTINCT patient_id, CONCAT_WS(' ', first_name, last_name) AS nom_complet FROM patients
INNER JOIN billing USING (patient_id)
WHERE amount > (SELECT AVG(amount) FROM billing);

-- 20
SELECT order_id, supplier_id, order_date, total_amount FROM orders
WHERE total_amount = (SELECT MAX(total_amount) FROM orders);

-- 21
SELECT result_id, patient_id, test_id, result_value FROM lab_results
WHERE result_value < (SELECT MIN(result_value) FROM lab_results);

-- 22
SELECT num_consultes, COUNT(*) AS total_pacients FROM 
(SELECT patient_id, COUNT(consultation_id) AS num_consultes FROM consultations 
GROUP BY patient_id) AS subconsulta
GROUP BY num_consultes;

-- 23
SELECT tram_import, COUNT(*) AS total_comandes FROM 
(SELECT order_id, total_amount, CASE 
WHEN total_amount < 200 THEN 'Menys de 200 €'
WHEN total_amount <= 500 THEN 'Entre 200 € i 500 €'
ELSE 'Més de 500 €'
END AS tram_import
FROM orders) AS subconsulta
GROUP BY tram_import;

-- 24
SELECT c1.consultation_id, c1.patient_id, c1.doctor_id, c1.consultation_date, c1.consultation_notes FROM consultations c1
WHERE c1.consultation_date = (
SELECT MAX(c2.consultation_date) FROM consultations c2 
WHERE c1.patient_id = c2.patient_id)
ORDER BY c1.patient_id ASC;