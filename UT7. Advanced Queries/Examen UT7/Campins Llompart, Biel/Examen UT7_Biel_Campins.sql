/*Resol sense utilitzar subconsultes (0.75 punts/exercici)*/
/* 1. Mostra el nom i cognom dels metges juntament amb la data de les seves 
cites (appointments) i l’estat d’aquestes. */
SELECT CONCAT(s.first_name,' ', s.last_name) AS 'nom_complet', a.appointment_date, a.status FROM staff s
JOIN doctors d ON s.staff_id = d.doctor_id
JOIN appointments a ON d.doctor_id = a.doctor_id;

/* 2. Mostra el nom complet dels pacients, tenguin o no registres de facturació 
(billing), juntament amb la suma total facturada. 
Mostra només els pacients nascuts abans de 1990. 
Ordena pel total facturat de més a menys. */
SELECT CONCAT(p.first_name,' ', p.last_name) AS 'nom_complet',SUM(b.amount) AS 'suma_total' FROM patients p
JOIN billing b USING (patient_id)
WHERE birth_date < '1990-01-01'
GROUP BY patient_id
ORDER BY suma_total;

/* 3. Mostra supplier_id, name i contact_person de tots els proveïdors que no 
tenen cap comanda (order) registrada. 
Ordena per nom. */
SELECT s.supplier_id, s.name, s.contact_person FROM suppliers s
LEFT JOIN orders o ON s.supplier_id = o.supplier_id
WHERE o.order_id IS NULL
ORDER BY s.name;

/* 4. Mostra el total d’imports facturats (billing) i el total d’imports de 
comandes (orders), en dues files separades amb una columna que 
indiqui el tipus (“Cobros” o “Pagaments”). */
SELECT 'Cobros' AS tipus, SUM(amount) AS total
FROM billing
UNION ALL
SELECT 'Pagaments' AS tipus, SUM(total_amount) AS total
FROM orders;

/*Resol utilitzant subconsultes (1.15punts/exercici)*/
/* 5. Mostra el nom dels medicaments que han estat prescrits (prescriptions) 
en alguna consulta. Ordena’ls alfabèticament. */
SELECT name FROM medications 
WHERE medication_id IN (SELECT medication_id FROM prescriptions)
ORDER BY name;

/* 6. Mostra tots els camps dels resultats de laboratori (lab_results) on el seu 
valor sigui major que algun valor normal mínim definit a les proves (lab_tests). */
SELECT * FROM lab_results lr
WHERE result_value > ANY (SELECT normal_min FROM lab_tests lt where lr.test_id = lt.test_id);

/* 7. Mostra el nom complet dels pacients que tenen factures amb un import 
inferior a la mitjana de les factures pagades. Ordena pel nom del pacient. */
SELECT CONCAT(first_name,' ', last_name) AS 'nom_complet' FROM patients 
JOIN billing USING (patient_id)
WHERE amount < (SELECT AVG(amount) FROM billing WHERE status = 'Paid')
ORDER BY nom_complet;

/* 8. Mostra quants pacients tenen 1 resultat de laboratori, 2, 3, etc. */
SELECT total_resultats, COUNT(*) AS 'num_pacients' FROM 
(SELECT patient_id, COUNT(*) AS 'total_resultats' FROM lab_results
    GROUP BY patient_id) AS subquery
GROUP BY total_resultats;

/* 9. Mostra tots els camps de les línies de comanda (order_items) en què la 
quantitat demanada és superior a la mitjana de quantitats demanades 
d’aquell mateix medicament. */
SELECT * FROM order_items oi1
WHERE quantity > (SELECT AVG(quantity) FROM order_items oi2 WHERE oi1.medication_id = oi2.medication_id);

/* 10. Classifica els pacients segons la seva despesa total en: 
a. Menys de 100 € 
b. Entre 100 i 500 € 
c. Més de 500 € 
I mostra quants pacients hi ha en cada grup. */
SELECT
    CASE
        WHEN total_despesa < 100 THEN 'Menys de 100 €'
        WHEN total_despesa BETWEEN 100 AND 500 THEN 'Entre 100 i 500 €'
        ELSE 'Més de 500 €'
    END AS grup_despesa,
    COUNT(*) AS num_pacients
FROM 
(SELECT patient_id, SUM(amount) AS total_despesa FROM billing 
GROUP BY patient_id) AS t
GROUP BY grup_despesa;
