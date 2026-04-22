-- 1
SELECT CONCAT_WS(' ',first_name, last_name) AS NOM_COMPLET, appointment_date, status
FROM staff
JOIN doctors d ON staff_id = doctor_id
JOIN appointments a ON a.doctor_id = d.doctor_id;

-- 2
SELECT CONCAT_WS(' ',first_name, last_name) AS NOM_COMPLET, sum(amount) AS TOTAL
FROM patients
LEFT JOIN billing USING(patient_id)
WHERE YEAR(birth_date) < 1990
GROUP BY patient_id
ORDER BY TOTAL DESC;

-- 3
SELECT supplier_id, name, contact_person FROM suppliers s
LEFT JOIN orders o USING(supplier_id)
WHERE o.supplier_id IS NULL
ORDER BY name;

-- 4
SELECT sum(amount) AS TOTAL_FACTURADOS, 'Cobros' AS TIPO
FROM billing
UNION
SELECT sum(total_amount), 'Pagos' AS TIPO
FROM orders;

-- 5
SELECT name FROM medications
WHERE medication_id IN (
SELECT medication_id FROM prescriptions)
ORDER BY name;

-- 6
SELECT * FROM lab_results
WHERE result_value > ANY (
SELECT normal_min FROM lab_tests);

-- 7
SELECT DISTINCT CONCAT_WS(' ',first_name, last_name) AS NOM_COMPLET 
FROM patients
JOIN billing USING(patient_id)
WHERE amount < (
SELECT avg(amount) FROM billing
WHERE status = 'Paid')
ORDER BY NOM_COMPLET;

-- 8
SELECT count(*) AS Nº_PACIENTS, Nº_RESULTAT
FROM (SELECT count(*) AS Nº_RESULTAT 
FROM lab_results
GROUP BY patient_id) AS PACIENTS
GROUP BY Nº_RESULTAT;

-- 9
SELECT * FROM order_items o1
WHERE quantity > (
SELECT avg(quantity) FROM order_items o2 
WHERE o1.medication_id = o2.medication_id);

-- 10
SELECT CASE
WHEN TOTAL < 100 THEN 'Menos de 100 €'
WHEN TOTAL BETWEEN 100 AND 500 THEN 'Entre 100 y 500 €'
ELSE 'Más de 500 €'
END AS TRAMO, COUNT(*) AS Nº_PACIENTES
FROM(
SELECT patient_id, sum(amount) AS TOTAL FROM billing
GROUP BY patient_id ) AS GASTO_TOTAL
GROUP BY TRAMO;
