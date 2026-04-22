-- Mark Pires Guimaraes --

-- 1  Muestra el nombre y apellidos de los médicos junto a la fecha de sus citas (appointments) y el estado de estas. --
SELECT doctor_id, first_name, last_name, appointment_date, status FROM doctors
JOIN appointments USING (doctor_id)
JOIN staff ON staff_id = doctor_id;

-- 2 Muestra el nombre completo de los pacientes, tengan o no registros de facturación (billing), junto a la suma total facturada.
-- Muestra sólo los pacientes nacidos antes de 1990.
-- Ordena por el total facturado de mayor a menor.
SELECT CONCAT_WS(" ", first_name, last_name) AS "nom_completo", (amount) AS "total_facturada" FROM patients
LEFT JOIN billing USING(patient_id)
WHERE birth_date < "1990-01-01" 
ORDER BY total_facturada DESC;

-- 3 Muestra supplier_id, name y contact_person de todos los proveedores que no tengan ningún pedido (order) registrado.
-- Ordena por nombre.
SELECT supplier_id, name, contact_person FROM orders
LEFT JOIN suppliers USING(supplier_id)
WHERE status IS NULL;

-- 4 Muestra el total de importes facturados (billing) y el total de importes de pedidos (orders), en dos filas separadas con una columna que indique el tipo (“Cobros” o “Pagos”).
 SELECT SUM(amount) AS "total_importes", "Billing" AS tipus FROM billing
 UNION
 SELECT SUM(total_amount), "Orders" FROM orders;
 
 -- 5 Muestra el nombre de los medicamentos que han sido prescritos (prescriptions) en alguna consulta. Ordénalos alfabéticamente. --
SELECT medication_id, name FROM medications
JOIN prescriptions USING(medication_id)
WHERE name = ANY 
	(SELECT medication_id FROM prescriptions)
ORDER BY name DESC;

-- 6 Muestra todos los campos de los resultados de laboratorio (lab_results) los cuales su valor sea mayor que algún valor normal mínimo definido en las pruebas (lab_tests).
SELECT * FROM lab_results
JOIN lab_tests
WHERE result_value > ANY
(SELECT normal_min FROM lab_tests);

-- 7 Muestra el nombre completo de los pacientes que tengan facturas con un importe inferior a la media de las facturas pagadas.
-- Ordena por nombre del paciente.
SELECT DISTINCT CONCAT_WS(" ", first_name, last_name) AS "nom_complet" FROM patients
JOIN billing USING(patient_id)
WHERE amount < 
(SELECT AVG(amount) FROM billing)
ORDER BY nom_complet;

-- 8 Muestra cuántos pacientes tienen 1 resultado de laboratorio, 2, 3, etc. 
SELECT total_resultados, COUNT(*) AS total_pacients FROM
(SELECT patient_id, COUNT(*) AS total_resultados FROM lab_results
GROUP BY patient_id) AS subquery
GROUP BY total_resultados;

-- 9 Muestra todos los campos de las líneas de pedidos (order_items) en que la cantidad pedida es superior a la media de cantidades pedidas de ese mismo medicamento.
SELECT * FROM order_items o1 
JOIN medications USING(medication_id)
WHERE quantity > 
	(SELECT AVG(quantity) FROM order_items o2
    WHERE o1.medication_id = o2.medication_id);

-- 10  (1.25 puntos) Clasifica los pacientes según su gasto total en:
-- a. Menos de 100 €
-- b. Entre 100 y 500 €
-- c. Más de 500 €
-- Muestra cuántos pacientes hay en cada grupo.

SELECT DISTINCT
	CASE
		WHEN gasto_total < 100 THEN "Menos de 100 €"
        WHEN gasto_total BETWEEN 100 AND 500 THEN "Entre 100 y 500 €"
        ELSE "Mas de 500 €"
        END AS total_despesas, COUNT(*) AS "total_patients" FROM
        (SELECT patient_id, SUM(amount) AS gasto_total FROM billing
        GROUP BY patient_id) AS subquery
        GROUP BY gasto_total;
        