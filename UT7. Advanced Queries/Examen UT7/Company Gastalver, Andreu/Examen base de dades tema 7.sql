/* Resuelve sin utilizar subconsultas (0.75 puntos/ejercicio) */

/* 1. */
SELECT s.first_name, s.last_name, a.appointment_date, a.status
FROM appointments a
JOIN doctors d ON
a.doctor_id = d.doctor_id
JOIN staff s ON
d.doctor_id = s.staff_id;

/* 2. */
SELECT CONCAT(p.first_name, '', p.last_name) as nom_complet, b.bill_id, SUM(b.amount) as total_facturat
FROM patients p 
JOIN billing b ON
p.patient_id = b.patient_id
WHERE birth_date < '1990-01-01'
GROUP BY p.patients.id
ORDER BY total_facturat DESC;

/* 3. */
SELECT s.supplier_id, s.name, s.contact_person
FROM suppliers s
JOIN orders o ON
s.supplier_id = o.supplier_id
WHERE order_id IS NULL
ORDER BY s.name;

/* 4. Muestra en dos filas separadas:
 - el total de importes facturados (billing)
 - el total de importes de pedidos (orders)
 Muestra también en cada una de las filas una columna que indique el tipo (“Cobros” o “Pagos”). */

SELECT SUM(b.amount) AS Cobros
FROM billing b

UNION

SELECT SUM(o.total_amount) AS Pagos
FROM orders o;

/* Resuelve utilizando subconsultas (1.15puntos/ejercicio) */

/* 5. */


/* 6. */
SELECT * FROM lab_results lr
WHERE (
	SELECT result_value
    FROM lab_tests
    WHERE result_value > normal_min
);

/* 7. */
SELECT CONCAT(p.first_name, '', p.last_name) AS nom_complet
FROM patients p 
WHERE (
	SELECT bill_id FROM billing
	ORDER BY nom_complet ASC
);

/* 8. 


/* 9. 

/* 10. 