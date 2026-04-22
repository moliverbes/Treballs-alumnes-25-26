/*1.Muestra el nombre y apellidos de los médicos junto a la fecha de sus
citas (appointments) y el estado de estas.*/
SELECT first_name, last_name, appointment_date, status
FROM doctors
JOIN staff ON staff.staff_id = doctors.doctor_id
JOIN appointments USING(doctor_id);

/*2.Muestra el nombre completo de los pacientes, tengan o no registros de
facturación (billing), junto a la suma total facturada.
Muestra sólo los pacientes nacidos antes de 1990.
Ordena por el total facturado de mayor a menor.*/

SELECT CONCAT_WS(' ', first_name, last_name) AS 'nombre_completo', 
 SUM(amount) AS total_facturada
FROM patients
LEFT JOIN billing USING(patient_id)
WHERE YEAR(birth_date) < '1990-01-01'
GROUP BY nombre_completo
ORDER BY total_facturada ASC;

/*3.Muestra supplier_id, name y contact_person de todos los proveedores
que no tengan ningún pedido (order) registrado.
Ordena por nombre.*/

SELECT supplier_id, name, contact_person
FROM suppliers
INNER JOIN orders USING(supplier_id)
ORDER BY name;


/*4.Muestra el total de importes facturados (billing) y el total de importes de
pedidos (orders), en dos filas separadas con una columna que indique el
tipo (“Cobros” o “Pagos”)*/

SELECT 'Cobros' AS tipo, COALESCE(SUM(amount), 0) AS total FROM billing
UNION ALL
SELECT 'Pagos' AS tipo, COALESCE(SUM(total_amount), 0) AS total FROM orders;



/*5.Muestra el nombre de los medicamentos que han sido prescritos
(prescriptions) en alguna consulta.
Ordénalos alfabéticamente.*/


SELECT name
FROM medications
WHERE medication_id IN (
    SELECT DISTINCT medication_id
    FROM prescriptions
    JOIN consultations USING(consultation_id)
)
ORDER BY name ASC;


/*6.Muestra todos los campos de los resultados de laboratorio (lab_results)
los cuales su valor sea mayor que algún valor normal mínimo definido en
las pruebas (lab_tests).*/

SELECT * 
FROM lab_results
WHERE result_value >ANY (
	SELECT normal_min FROM lab_tests) ;

    
    
/*7.Muestra el nombre completo de los pacientes que tengan facturas con
un importe inferior a la media de las facturas pagadas.
Ordena por nombre del paciente*/


SELECT CONCAT_WS(' ', first_name, last_name) AS 'nombre_completo', amount AS factura_pagada
FROM patients
JOIN billing USING(patient_id)
WHERE amount < (
	SELECT AVG(amount) FROM billing)
ORDER BY nombre_completo;

/*8.Muestra cuántos pacientes tienen 1 resultado de laboratorio, 2, 3, etc.*/

SELECT 
    cantidad_resultados,
    COUNT(*) AS numero_de_pacientes
FROM (
    SELECT patient_id, COUNT(*) AS cantidad_resultados
    FROM lab_results
    GROUP BY patient_id
) AS resultados_por_paciente
GROUP BY cantidad_resultados
ORDER BY cantidad_resultados;


/*9.Muestra todos los campos de las líneas de pedidos (order_items) en que
la cantidad pedida es superior a la media de cantidades pedidas de ese
mismo medicamento.*/

SELECT oi.*
FROM order_items oi
WHERE oi.quantity > (
    SELECT AVG(quantity)
    FROM order_items
    WHERE medication_id = oi.medication_id
);


/*10.) Clasifica los pacientes según su gasto total en:
a. Menos de 100 €
b. Entre 100 y 500 €
c. Más de 500 €
Muestra cuántos pacientes hay en cada grupo.*/

SELECT gasta, COUNT(*) 
FROM patients
WHERE (
	SELECT 
		CASE 
			


























































