-- 1 Mostra el nom i llinatges dels pacients, la data de la cita i l’estat de totes les cites completades de l’any 2024.
-- Ordena el resultat per data de cita descendent i, en cas d’empat, per llinatge ascendent.
SELECT CONCAT(first_name,' ', last_name) as 'NOM_COMPLET', appointment_date, status FROM patients
LEFT JOIN appointments USING (patient_id)
WHERE status = 'Completed' AND
appointment_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY appointment_date asc;

-- 2 Mostra totes les habitacions (room_number, room_type) i, si està assignada, el nom del pacient i data d’admissió. 
-- Si no està assignada, mostra el text ‘Sense assignar’. Mostra només les assignacions encara actives (discharge_date IS NULL).
-- Ordena per room_type i després per room_number.

SELECT room_number, room_type, CONCAT(first_name,' ', last_name) AS 
llinatge_pacient, admission_date FROM rooms r
LEFT JOIN room_assignments ra ON r.room_id = r.room_id AND ra.discharge_date IS NULL
LEFT JOIN patients p ON ra.patient_id = p.patient_id
ORDER BY r.room_type ASC, r.room_number ASC;

-- 3 Llista els pacients que no tenen cap pòlissa d’assegurança associada. Mostra patient_id, nom complet i email. Ordena pel patient_id.
SELECT patient_id, CONCAT(first_name, ' ', last_name), email FROM patients
LEFT JOIN insurance_policies USING (patient_id)
WHERE policy_id IS NULL
ORDER BY patient_id;

-- 4 Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received'). Mostra el nom del proveïdor i el nombre de comandes.
-- Mostrar només els proveïdors amb 2 o més comandes rebudes. Ordena de més a menys comandes rebudes
SELECT s.name, COUNT(o.order_id) AS nombre_comandes FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
WHERE o.status = 'Received'
GROUP BY s.supplier_id, s.name
HAVING COUNT(o.order_id) >= 2
ORDER BY nombre_comandes DESC
LIMIT 5;

-- 5 Mostra el nom del medicament, la quantitat i el preu unitari arrodonit a 1 decimal de totes les línies de comanda on la quantitat 
-- sigui superior a 5. Ordena per quantitat descendent.
SELECT name, quantity, ROUND(unit_price,1) AS Preu_arrodonit FROM medications
INNER JOIN order_items USING (medication_id)
WHERE quantity > 5
ORDER BY quantity desc;

-- 6 Mostra totes les assignacions de personal a instal·lacions amb el nom de la instal·lació, el staff_type, el staff_id i la start_date.
-- Ordena pel nom de la instal·lació
SELECT f.facility_name, a.staff_type, a.staff_id, a.start_date
FROM hospital_facilities f
INNER JOIN staff_facility_assignments a ON f.facility_id = a.facility_id
ORDER BY f.facility_name ASC;

-- 7 Mostra les instal·lacions que no tenen cap assignació de personal. Mostra facility_id, facility_name i facility_type.
SELECT f.facility_id, f.facility_name, f.facility_type
FROM hospital_facilities f
LEFT JOIN staff_facility_assignments a ON f.facility_id = a.facility_id
WHERE a.assignment_id IS NULL;

-- 8 Fes una consulta amb UNION que mostri en una sola llista: els noms complets dels doctors, i els noms complets de les infermeres.
-- En ambdós casos, la columna ha de sortir amb el mateix àlies, per exemple nom_complet, i una segona columna que indiqui el tipus 
-- de personal ('Doctor' o 'Nurse'). Ordena el resultat final pel nom complet.
(SELECT CONCAT(s.first_name, ' ', s.last_name) AS nom_complet, 'Doctor' AS tipus FROM staff s
 INNER JOIN doctors d ON s.staff_id = d.doctor_id)
UNION
(SELECT CONCAT(s.first_name, ' ', s.last_name) AS nom_complet, 'Nurse' AS tipus FROM staff s
 INNER JOIN nurses n ON s.staff_id = n.nurse_id)
ORDER BY nom_complet ASC;

-- 9 Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat. Mostra només les especialitats que tenen 
-- exactament 1 doctor o més. Ordena pel nombre de doctors descendent i després pel nom de l’especialitat.
SELECT s.name, COUNT(d.doctor_id) AS nombre_doctors
FROM specialties s
INNER JOIN doctors d ON s.specialty_id = d.specialty_id
GROUP BY s.specialty_id, s.name
HAVING nombre_doctors >= 1
ORDER BY nombre_doctors DESC, s.name ASC;

-- 10 Mostra els pacients ingressats amb: nom complet del pacient, número d’habitació, tipus d’habitació, data d’ingrés, i el nombre de 
-- dies ingressat fins a la data actual. Només s’han de mostrar ingressos actius (discharge_date IS NULL). Empra una funció de dates per 
-- calcular els dies d’ingrés. Ordena pels dies ingressats de major a menor.
SELECT CONCAT(p.first_name, ' ', p.last_name) AS nom_pacient, r.room_number, r.room_type, ra.admission_date, 
DATEDIFF(CURDATE(), ra.admission_date) AS dies_ingressat FROM patients p
INNER JOIN room_assignments ra ON p.patient_id = ra.patient_id
INNER JOIN rooms r ON ra.room_id = r.room_id
WHERE ra.discharge_date IS NULL
ORDER BY dies_ingressat DESC;

-- 11 Mostra els metges amb el seu número de llicència i el nom de l’especialitat, però només aquells en què el nom de l’especialitat 
-- conté la paraula “logia”. Aplica una funció de text per mostrar el nom de l’especialitat en majúscules. Ordena pel número de llicència.
SELECT d.license_number, UPPER(s.name) AS especialitat_majuscules
FROM doctors d
INNER JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE s.name LIKE '%logia%'
ORDER BY d.license_number ASC;

-- 12 Mostra les habitacions i el nombre total de llits que té cadascuna. Mostra només les habitacions amb 2 o més llits.
-- Ordena primer pel nombre de llits descendent i després pel número d’habitació.
SELECT r.room_number, COUNT(b.bed_id) AS total_llits FROM rooms r
INNER JOIN beds b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_number
HAVING total_llits >= 2
ORDER BY total_llits DESC, r.room_number ASC;

-- 13 Mostra els pacients que no tenen cap resultat de laboratori registrat. Mostra patient_id, nom complet i telèfon.  
-- Ordena pel nom complet.
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS nom_complet, p.phone FROM patients p
LEFT JOIN lab_results lr ON p.patient_id = lr.patient_id
WHERE lr.result_id IS NULL
ORDER BY nom_complet ASC;

-- 14 Fes una consulta amb UNION que retorni: totes les consultes mèdiques de l’any 2023, i totes les cites cancel·lades de l’any 2023.
-- Les dues parts de la consulta han de retornar aquestes columnes: tipus_registre, patient_id, doctor_id, data_registre.A la primera part,
--  tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'. Ordena el resultat per data_registre.
(SELECT 'Consulta' AS tipus_registre, patient_id, doctor_id, consultation_date AS data_registre FROM consultations
 WHERE YEAR(consultation_date) = 2023)
UNION
(SELECT 'Cita cancel·lada' AS tipus_registre, patient_id, doctor_id, appointment_date AS data_registre FROM appointments
 WHERE status = 'Cancelled' 
   AND YEAR(appointment_date) = 2023)
ORDER BY data_registre ASC;

-- 15 Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
-- Mostra només els proveïdors amb una mitjana d’import superior a 90 euros. Ordena per import mitjà descendent.
SELECT s.name AS vendor_name, COUNT(o.order_id) AS total_comandes, ROUND(AVG(o.total_amount), 2) AS import_mitja
FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.name
HAVING import_mitja > 90
ORDER BY import_mitja DESC;

-- 16 Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'.
SELECT patient_id, first_name, last_name FROM patients
WHERE patient_id IN (
    SELECT patient_id 
    FROM billing 
    WHERE status = 'Paid'
);

-- 17 Mostra els medicaments que tenen un preu unitari (order_items.unit_price) superior a qualsevol dels preus de la comanda amb  order_id = 1.
SELECT name, description FROM medications
WHERE medication_id IN (
    SELECT medication_id FROM order_items
    WHERE unit_price > ANY (
        SELECT unit_price 
        FROM order_items 
        WHERE order_id = 1
    )
);
-- 18 Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient 1.
SELECT DISTINCT p.patient_id, p.first_name, p.last_name FROM patients p
INNER JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > ALL (
    SELECT amount 
    FROM billing 
    WHERE patient_id = 1
);
-- 19 Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures.
SELECT DISTINCT p.patient_id, p.first_name, p.last_name FROM patients p
INNER JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > (
    SELECT AVG(amount) 
    FROM billing
);
-- 20 Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes.
SELECT order_id, supplier_id, total_amount, order_date FROM orders
WHERE total_amount = (
    SELECT MAX(total_amount) 
    FROM orders
);

-- 21 Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats.
SELECT lr.result_id, lr.patient_id, lt.test_name, lr.result_value FROM lab_results lr
INNER JOIN lab_tests lt ON lr.test_id = lt.test_id
WHERE lr.result_value = (
    SELECT MIN(result_value) 
    FROM lab_results
);

-- 22 Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc.
SELECT num_consultes, COUNT(patient_id) AS nombre_pacients
FROM (
	SELECT patient_id, COUNT(*) AS num_consultes
    FROM consultations
    GROUP BY patient_id
) AS resum_consultes
GROUP BY num_consultes
ORDER BY num_consultes ASC;

-- 23 Mostra el nombre de comandes segons l’import total de cada comanda, classificades en els següents trams: Menys de 200 €, Entre 200 € i 500 €, Més de 500 €
-- Mostra quantes comandes hi ha en cada tram.
SELECT 
    CASE 
        WHEN total_amount < 200 THEN 'Menys de 200 €'
        WHEN total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
        ELSE 'Més de 500 €'
    END AS tram_import,
    COUNT(order_id) AS quantitat_comandes
FROM orders
GROUP BY tram_import;

-- 24 Mostra les consultes mèdiques (consultations) que són les més recents de cada pacient.
SELECT consultation_id, patient_id, doctor_id, consultation_date, consultation_notes
FROM consultations c1
WHERE consultation_date = (
    SELECT MAX(consultation_date) FROM consultations c2
    WHERE c2.patient_id = c1.patient_id
)
ORDER BY patient_id;