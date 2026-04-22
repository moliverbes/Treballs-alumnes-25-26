-- EXAMEN UT7 Arnau Garcia Franco
USE hospitaldb;
/* 1. Mostra el nom i cognom dels metges juntament amb la data de les seves
cites (appointments) i l’estat d’aquestes. */
SELECT stf.first_name, stf.last_name, a.appointment_date, a.status FROM staff stf
JOIN doctors d ON d.doctor_id = stf.staff_id
JOIN appointments a ON a.doctor_id = d.doctor_id;

/* 2. Mostra el nom complet dels pacients, tenguin o no registres de facturació
(billing), juntament amb la suma total facturada.
Mostra només els pacients nascuts abans de 1990.
Ordena pel total facturat de més a menys. */
SELECT CONCAT (p.first_name, ' ', p.last_name) AS nom_complet, SUM(b.amount) AS suma_total_facturada, p.birth_date FROM billing b
 LEFT JOIN patients p ON p.patient_id = b.patient_id
 WHERE p.birth_date < '1990-01-01'
GROUP BY p.patient_id
ORDER BY suma_total_facturada DESC;

/*3.  Mostra supplier_id, name i contact_person de tots els proveïdors que no
tenen cap comanda (order) registrada.
Ordena per nom. */
SELECT su.supplier_id, su.name, su.contact_person FROM orders o
LEFT JOIN suppliers su ON su.supplier_id = o.supplier_id
WHERE o.order_id IS NULL
ORDER BY su.name;

/* 4.Mostra el total d’imports facturats (billing) i el total d’imports de
comandes (orders), en dues files separades amb una columna que
indiqui el tipus (“Cobros” o “Pagaments”). */

SELECT SUM(amount) AS total_imports_facturats, 'billing' AS tipus FROM billing
UNION 
SELECT SUM(total_amount) AS total_imports_facturats, 'orders' AS tipus FROM orders;

/* 5.Mostra el nom dels medicaments que han estat prescrits (prescriptions)
en alguna consulta.
Ordena’ls alfabèticament. */
SELECT  name FROM medications
		WHERE medication_id = ANY (SELECT medication_id FROM prescriptions)
        ORDER BY name;

/* 6. Mostra tots els camps dels resultats de laboratori (lab_results) on el seu
valor sigui major que algun valor normal mínim definit a les proves
(lab_tests). */
SELECT lr.result_id, lr.patient_id, lr.test_id, lr.result_date, lr.result_value FROM lab_results lr
WHERE lr.result_value > ANY (SELECT lt.normal_min FROM lab_tests lt);

/* 7. Mostra el nom complet dels pacients que tenen factures amb un import
inferior a la mitjana de les factures pagades.
Ordena pel nom del pacient.*/
SELECT  CONCAT(p.first_name, ' ', p.last_name) AS nom_complet FROM patients p
JOIN billing b ON b.patient_id = p.patient_id
WHERE b.amount  <  (SELECT AVG(b.amount) AS mitjana_factures FROM billing)
ORDER BY nom_complet;
/* 9. Mostra tots els camps de les línies de comanda (order_items) en què la
quantitat demanada és superior a la mitjana de quantitats demanades
d’aquell mateix medicament. */
SELECT ord1.order_item_id, ord1.order_id, ord1.medication_id, ord1.quantity, ord1.unit_price FROM order_items ord1
WHERE ord1.quantity > (SELECT AVG(ord2.quantity) FROM order_items ord2
							WHERE ord2.order_id = ord1.order_id);

                             