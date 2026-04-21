-- Mark Pires Guimaraes --
-- 1 Mostra el nom i llinatges dels pacients, la data de la cita i l’estat de totes les cites completades de l’any 2024.Ordena el resultat per data de cita descendent i, en cas d’empat, per llinatge ascendent. --
SELECT first_name, last_name, appointment_date, status FROM patients
JOIN appointments USING (patient_id)
WHERE status = "Completed" AND appointment_date LIKE "%2024%"
ORDER BY appointment_date DESC, last_name ASC;

-- 2 Mostra totes les habitacions (room_number, room_type) i, si està assignada, el nom del pacient i data d’admissió. Si no està assignada, mostra el text ‘Sense assignar’. Mostra només les assignacions encara actives (discharge_date IS NULL). Ordena per room_type i després per room_number. --
SELECT r.room_number, r.room_type, COALESCE(CONCAT_WS(' ', p.first_name, p.last_name), 'Sense assignar') AS nom_pacient,
COALESCE(CAST(ro.admission_date AS CHAR), 'Sense assignar') AS data_admissio
FROM rooms r
LEFT JOIN room_assignments ro ON r.room_id = ro.room_id AND ro.discharge_date IS NULL
LEFT JOIN patients p USING(patient_id)
ORDER BY r.room_type, r.room_number;

-- 3 Llista els pacients que no tenen cap pòlissa d’assegurança associada. Mostra patient_id, nom complet i email. Ordena pel patient_id. --
SELECT patient_id, CONCAT_WS(" ", first_name,last_name) AS "nom_complet", email FROM patients
LEFT JOIN insurance_policies using(patient_id)
WHERE policy_id IS NULL 
ORDER BY patient_id;

-- 4 Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received').Mostra el nom del proveïdor i el nombre de comandes. Mostrar només els proveïdors amb 2 o més comandes rebudes. Ordena de més a menys comandes rebudes --
SELECT name, COUNT(order_id) AS "num_de_comandes" FROM suppliers
JOIN orders USING(supplier_id)
WHERE status = "Received"
GROUP BY supplier_id
HAVING num_de_comandes >= 2
ORDER BY num_de_comandes DESC 
LIMIT 5;

-- 5 Mostra el nom del medicament, la quantitat i el preu unitari arrodonit a 1 decimal de totes les línies de comanda on la quantitat sigui superior a 5. Ordena per quantitat descendent. --
SELECT name, quantity, ROUND(unit_price, 1) AS "preu_unitari_arrodonit" FROM medications
JOIN order_items USING(medication_id)
WHERE quantity > 5 
ORDER BY quantity DESC;

-- 6 Mostra totes les assignacions de personal a instal·lacions amb el nom de la instal·lació, el staff_type, el staff_id i la start_date.Ordena pel nom de la instal·lació --
SELECT facility_name, s.staff_type, staff_id, start_date FROM hospital_facilities hf
JOIN staff_facility_assignments ON assignment_id = hf.facility_id
JOIN staff s USING(staff_id)
ORDER BY facility_name;

-- 7 Mostra les instal·lacions que no tenen cap assignació de personal. Mostra facility_id, facility_name i facility_type. --
SELECT  facility_id, facility_name, facility_type FROM hospital_facilities 
JOIN staff_facility_assignments USING(facility_id)
WHERE assignment_id IS NULL;

-- 8 Fes una consulta amb UNION que mostri en una sola llista: els noms complets dels doctors, i els noms complets de les infermeres. En ambdós casos, la columna ha de sortir amb el mateix àlies, per exemple nom_complet, i una segona columna que indiqui el tipus de personal ('Doctor' o 'Nurse'). Ordena el resultat final pel nom complet. --
SELECT CONCAT_WS(" ", first_name, last_name) AS "nom_complet", "Doctor" AS "tipus" FROM staff
WHERE staff_type = "Doctor"
UNION
SELECT CONCAT_WS(" ", first_name, last_name) AS "nom_complet", "Nurse" AS "tipus" FROM staff
WHERE staff_type = "Nurse"
ORDER BY nom_complet;

-- 9 Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat. --
-- Mostra només les especialitats que tenen exactament 1 doctor o més.-- 
-- Ordena pel nombre de doctors descendent i després pel nom de l’especialitat. --
SELECT name, COUNT(doctor_id) AS "num_de_doctors" FROM specialties s
INNER JOIN doctors USING(specialty_id)
GROUP BY s.specialty_id
HAVING num_de_doctors >= 1
ORDER BY name;

-- 10 Mostra els pacients ingressats amb: nom complet del pacient, número d’habitació, tipus d’habitació, data d’ingrés, i el nombre de dies ingressat fins a la data actual. --
-- Només s’han de mostrar ingressos actius (discharge_date IS NULL). --
-- Empra una funció de dates per calcular els dies d’ingrés. --
-- Ordena pels dies ingressats de major a menor. --
SELECT CONCAT_WS(" ", first_name, last_name) AS "nom_complet" , room_number, room_type, admission_date, 
DATEDIFF(CURDATE(), admission_date) AS "dies_ingressat"
FROM room_assignments
JOIN patients USING(patient_id)
JOIN rooms USING(room_id)
WHERE discharge_date IS NULL
ORDER BY dies_ingressat DESC;

-- 11 Mostra els metges amb el seu número de llicència i el nom de l’especialitat, però només aquells en què el nom de l’especialitat conté la paraula “logia”. Aplica una funció de text per mostrar el nom de l’especialitat en majúscules. Ordena pel número de llicència. --
SELECT license_number, UPPER(s.name) AS "especialitat_majuscules"
FROM doctors 
JOIN specialties s USING(specialty_id)
WHERE s.name LIKE '%logia%'
ORDER BY license_number;

-- 12 Mostra les habitacions i el nombre total de llits que té cadascuna. Mostra només les habitacions amb 2 o més llits. Ordena primer pel nombre de llits descendent i després pel número d’habitació. --
SELECT room_number, COUNT(bed_id) AS "total_llits"
FROM rooms
JOIN beds USING(room_id)
GROUP BY room_id
HAVING total_llits >= 2
ORDER BY total_llits DESC, room_number ASC;

-- 13 Mostra els pacients que no tenen cap resultat de laboratori registrat. Mostra patient_id, nom complet i telèfon. Ordena pel nom complet. --
SELECT patient_id, CONCAT_WS(" ", first_name, last_name) AS "nom_complet", phone FROM patients
LEFT JOIN lab_results USING(patient_id)
WHERE result_id IS NULL
ORDER BY nom_complet;

-- 14 Fes una consulta amb UNION que retorni: totes les consultes mèdiques de l’any 2023, i totes les cites cancel·lades de l’any 2023. --
-- Les dues parts de la consulta han de retornar aquestes columnes: tipus_registre, patient_id, doctor_id, data_registre. A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'. --
-- Ordena el resultat per data_registre. --
SELECT "Consulta" AS tipus_registre, patient_id, doctor_id, consultation_date AS "data_registre" FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION
SELECT "Cita cancel·lada" AS tipus_registre, patient_id, doctor_id, appointment_date AS "data_registre" FROM appointments
WHERE status = "Cancelled" AND YEAR(appointment_date) = 2023
ORDER BY data_registre;

-- 15 Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
-- Mostra només els proveïdors amb una mitjana d’import superior a 90 euros. --
-- Ordena per import mitjà descendent. --
SELECT name, COUNT(order_id) AS "total_comandes", ROUND(AVG(total_amount), 2) AS "import_mitja"
FROM suppliers s
JOIN orders ON order_id = s.supplier_id
GROUP BY s.supplier_id
HAVING import_mitja > 90
ORDER BY import_mitja DESC;

-- 16 Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'. --
SELECT distinct patient_id, CONCAT_WS(" ", first_name, last_name) AS nom_complet FROM patients
JOIN billing USING (patient_id)
WHERE patient_id IN (
    SELECT patient_id FROM billing 
    WHERE status = 'Paid');

-- 17 Mostra els medicaments que tenen un preu unitari (order_items.unit_price) superior a qualsevol dels preus d’una comanda concreta (per exemple, order_id = 1). --
SELECT name, unit_price FROM medications
JOIN order_items USING (medication_id)
WHERE unit_price > ANY (
    SELECT unit_price FROM order_items
    WHERE order_id = 1);

-- 18 Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient concret (per exemple, patient_id = 1). --
SELECT DISTINCT patient_id, CONCAT_WS(" ", first_name, last_name) AS nom_complet FROM patients
JOIN billing USING(patient_id)
WHERE amount > ALL (
    SELECT amount FROM billing 
    WHERE patient_id = 1);

-- 19 Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures. --
SELECT DISTINCT patient_id, CONCAT_WS(" ", first_name, last_name) AS nom_complet FROM patients
JOIN billing USING(patient_id)
WHERE amount > (
    SELECT AVG(amount) FROM billing);
    
-- 20 Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes. --
SELECT * FROM orders 
WHERE total_amount = (
    SELECT MAX(total_amount) FROM orders);

-- 21 Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats. --
SELECT * FROM lab_results
WHERE result_value < (
    SELECT MIN(result_value) FROM lab_results);
    
-- 22 Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc. --
SELECT total_consultes, COUNT(*) AS total_pacients FROM
	(SELECT patient_id, COUNT(*) AS total_consultes
    FROM consultations
    GROUP BY patient_id) AS subquery
GROUP BY total_consultes;

-- 23 Mostra el nombre de comandes segons l’import total de cada comanda, classificades en els següents trams:
-- Menys de 200 €
-- Entre 200 € i 500 €
-- Més de 500 €
-- Mostra quantes comandes hi ha en cada tram.
SELECT 
	CASE
		WHEN total_despesas < 100 THEN "Menys de 100 €"
        WHEN total_despesas BETWEEN 200 AND 500 THEN "Entre 200 € i 500 €"
        ELSE "Mes de 500 €"
        END AS tram_imports,
	COUNT(*) AS total_comandas FROM
	(SELECT order_id, SUM(total_amount) AS total_despesas FROM orders
    GROUP BY order_id) AS subquery
GROUP BY total_despesas
ORDER BY total_despesas;

-- 24 Mostra les consultes mèdiques (consultations) que són les més recents de cada pacient. --
SELECT c1.patient_id, c1.consultation_date FROM consultations c1
WHERE c1.consultation_date = (
    SELECT MAX(c2.consultation_date) FROM consultations c2
    WHERE c2.patient_id = c1.patient_id)
ORDER BY c1.patient_id;
 

