-- 1
SELECT CONCAT_WS(first_name, last_name) AS nombre_completo, appointment_date, status FROM staff s
INNER JOIN doctors d ON d.doctor_id = s.staff_id
INNER JOIN appointments USING (doctor_id);

-- 2
SELECT CONCAT_WS(first_name, last_name) AS nombre_completo, SUM(amount) AS total_facturado, birth_date FROM patients
LEFT JOIN billing USING (patient_id)
WHERE YEAR(birth_date) < '1990-01-01'
GROUP BY patient_id 
ORDER BY total_facturado ASC;

-- 3
SELECT supplier_id, name, contact_person FROM suppliers
LEFT JOIN orders USING (supplier_id)
WHERE order_id IS NULL;

-- 4
SELECT SUM(amount) AS total_importes, 'Cobros' AS tipo FROM billing
UNION
SELECT SUM(total_amount) AS total_importes, 'Pagos' AS tipo FROM orders;

-- 5
SELECT name FROM medications
WHERE medication_id IN (SELECT medication_id FROM prescriptions)
ORDER BY name ASC;

-- 6
SELECT result_id, patient_id, test_id, result_date, result_value FROM lab_results
WHERE result_value > ANY (SELECT normal_min FROM lab_tests);

-- 7
SELECT SUM(amount) AS total_importes, CONCAT_WS(first_name, last_name) AS Nombre_completo FROM patients
INNER JOIN billing USING (patient_id)
GROUP BY patient_id
HAVING SUM(amount) < (SELECT AVG(amount) FROM billing
WHERE status LIKE 'Paid')
ORDER BY Nombre_completo;

-- 8
SELECT num_resultados, COUNT(*) AS total_pacients FROM
(SELECT patient_id, COUNT(result_id) AS num_resultados FROM lab_results
GROUP BY patient_id) AS subconsulta
GROUP BY num_resultados;

-- 9
SELECT * FROM order_items
WHERE quantity > ;