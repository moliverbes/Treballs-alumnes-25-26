-- 1. 
SELECT CONCAT(first_name, ' ', last_name) AS nombre_medico, appointment_date, status
FROM staff s
INNER JOIN doctors d ON s.staff_id = d.doctor_id
INNER JOIN appointments	 USING (doctor_id)
ORDER BY nombre_medico	;
-- 2. 
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo, SUM(amount) AS total_facturado
FROM patients 
LEFT JOIN billing USING (patient_id)
WHERE birth_date < '1990-01-01'
GROUP BY patient_id, first_name, last_name
ORDER BY total_facturado DESC;	

-- 3.
SELECT s.supplier_id, s.name, s.contact_person
FROM suppliers s
INNER JOIN orders USING (supplier_id)
WHERE order_date IS NULL
ORDER BY s.name;

-- 4.
SELECT SUM(b.amount) AS Cobros, SUM(o.total_amount) AS Pagos
FROM billing b
INNER JOIN orders o ON b.bill_id= o.order_id;

-- 5.
SELECT m.name
FROM medications m
WHERE medication_id IN (
	SELECT medication_id FROM prescriptions)
	ORDER BY name ASC;

-- 6.
SELECT * FROM lab_results lr
WHERE result_value > ANY (
	SELECT normal_min FROM lab_tests lt 
	WHERE lt.test_id = lr.test_id);

 -- 7.
 SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo
FROM patients
WHERE patient_id IN (
    SELECT patient_id 
    FROM billing 
    WHERE amount < (
		SELECT AVG(amount) FROM billing 
        WHERE status = 'Paid'))
ORDER BY nombre_completo;

-- 8.
SELECT num_resultados, COUNT(patient_id) AS cantidad_pacientes
FROM (
    SELECT patient_id, COUNT(*) AS num_resultados 
    FROM lab_results 
    GROUP BY patient_id
) AS conteo
GROUP BY num_resultados;

-- 9. 
SELECT * FROM order_items
WHERE quantity > ANY (
	SELECT AVG(quantity) AS cantidad_media FROM order_items); 
    
		