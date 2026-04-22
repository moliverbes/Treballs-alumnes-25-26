-- 1
SELECT first_name, last_name, appointment_date, status
FROM staff
JOIN doctors ON staff_id = doctor_id
JOIN appointments USING (doctor_id);

-- 2
SELECT CONCAT_WS(' ', first_name, last_name) AS nombre_completo,
SUM(amount) AS total_facturado
FROM patients
LEFT JOIN billing USING(patient_id)
WHERE YEAR(birth_date) < 1990
GROUP BY patient_id
ORDER BY total_facturado DESC;

-- 3
SELECT supplier_id, name, contact_person
FROM suppliers s
LEFT JOIN orders o USING(supplier_id)
WHERE o.supplier_id IS NULL
ORDER BY name;

-- 4
SELECT SUM(amount) AS total, 'Cobros' AS tipo
FROM billing
UNION
SELECT SUM(total_amount) AS total, 'Pagos' AS tipo
FROM orders;

-- 5
SELECT name
FROM medications
WHERE medication_id IN (
SELECT medication_id FROM prescriptions
JOIN consultations USING(consultation_id))
ORDER BY name ASC;

-- 6
SELECT * FROM lab_results
WHERE result_value > ANY (
SELECT normal_min FROM lab_tests);

-- 7
SELECT DISTINCT CONCAT_WS(' ', first_name, last_name) AS nombre_completo
FROM patients
JOIN billing USING(patient_id)
WHERE amount < (
SELECT AVG(amount) FROM billing)
ORDER BY nombre_completo;

-- 8
SELECT total_resultados_lab, COUNT(*) AS total_pacientes FROM (
SELECT patient_id, COUNT(*) AS total_resultados_lab
FROM lab_results
GROUP BY patient_id) AS subquery
GROUP BY total_resultados_lab;

-- 9
SELECT * FROM order_items o1
WHERE quantity > (
SELECT AVG(quantity) FROM order_items o2
WHERE o1.medication_id = o2.medication_id);

-- 10
SELECT
	CASE
		WHEN gasto_total < 100 THEN 'Menos de 100 €'
        WHEN gasto_total BETWEEN 100 AND 500 THEN 'Entre 100 y 500 €'
        ELSE 'Más de 500 €'
	END AS tramo_gasto,
    COUNT(*) AS total_pacientes FROM (
SELECT patient_id, SUM(amount) AS gasto_total
FROM billing
GROUP BY patient_id) AS subquery
GROUP BY tramo_gasto;