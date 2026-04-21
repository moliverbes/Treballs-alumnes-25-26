-- 1 Mostra el nom i llinatges dels pacients, la data de la cita i 
-- l’estat de totes les cites completades de l’any 2024.
-- Ordena el resultat per data de cita descendent i, en cas d’empat, per llinatge ascendent.
SELECT first_name, last_name, appointment_date, status FROM patients
JOIN appointments USING(patient_id)
WHERE status = 'completed' AND YEAR(appointment_date) = 2024
ORDER BY appointment_date DESC, last_name ASC;


-- 2 Mostra totes les habitacions (room_number, room_type) i, si està assignada, 
-- el nom del pacient i data d’admissió. Si no està assignada, mostra el text ‘Sense assignar’.
SELECT r.room_number,r.room_type,
IF(ra.patient_id IS NULL, 'Sense assignar', CONCAT(p.first_name, ' ', p.last_name)) AS nom_pacient,
IF(ra.patient_id IS NULL, 'Sense assignar', ra.admission_date) AS data_admissio
FROM rooms r
LEFT JOIN room_assignments ra ON r.room_id = ra.room_id AND ra.discharge_date IS NULL
LEFT JOIN patients p ON ra.patient_id = p.patient_id
ORDER BY room_type, room_number ASC;


-- 3 Llista els pacients que no tenen cap pòlissa d’assegurança associada.
-- Mostra patient_id, nom complet i email.
-- Ordena pel patient_id.
SELECT patient_id, CONCAT_WS(first_name,' ', last_name),email 
FROM patients
LEFT JOIN insurance_policies USING (patient_id)
WHERE policy_id IS  NULL
ORDER BY patient_id;


-- 4 Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received').
-- Mostra el nom del proveïdor i el nombre de comandes.
-- Mostrar només els proveïdors amb 2 o més comandes rebudes.
-- Ordena de més a menys comandes rebudes
SELECT name, count(order_id) FROM suppliers
LEFT JOIN orders USING (supplier_id)
WHERE status = 'received'
GROUP BY supplier_id
HAVING count(order_id) > 2 
ORDER BY count(order_id) DESC
LIMIT 5;


-- 5 Mostra el nom del medicament, la quantitat i el preu unitari arrodonit
-- a 1 decimal de totes les línies de comanda on la quantitat sigui superior a 5.
-- Ordena per quantitat descendent.
SELECT name, quantity, ROUND(unit_price) FROM medications
JOIN order_items USING (medication_id)
WHERE quantity > 5 
ORDER BY quantity DESC;


-- 6 Mostra totes les assignacions de personal a instal·lacions
-- amb el nom de la instal·lació, el staff_type, el staff_id i la start_date.
-- Ordena pel nom de la instal·lació
SELECT facility_name, staff_type, staff_id, start_date 
FROM hospital_facilities
LEFT JOIN staff_facility_assignments USING (facility_id)
ORDER BY facility_name;


-- 7 Mostra les instal·lacions que no tenen cap assignació de personal.
-- Mostra facility_id, facility_name i facility_type.
SELECT facility_id, facility_name, facility_type 
FROM hospital_facilities
JOIN staff_facility_assignments USING (facility_id)
WHERE assignment_id IS NULL;


-- 8 Fes una consulta amb UNION que mostri en una sola llista:
-- els noms complets dels doctors, i
-- els noms complets de les infermeres.
SELECT CONCAT_WS(first_name,' ',last_name) AS nom_complet, 'doctor' AS tipus_personal
FROM staff
JOIN doctors ON staff_id = doctor_id 
UNION ALL
SELECT CONCAT_WS(first_name,' ',last_name) AS nom_complet, 'nurse' AS tipus_personal
FROM staff
JOIN nurses ON staff_id = nurse_id
ORDER BY nom_complet;


-- 9 Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat.
-- Mostra només les especialitats que tenen exactament 1 doctor o més.
-- Ordena pel nombre de doctors descendent i després pel nom de l’especialitat.
SELECT name, COUNT(doctor_id)
FROM specialties
JOIN doctors USING (specialty_id)
GROUP BY specialty_id 
HAVING COUNT(doctor_id) >= 1
ORDER BY COUNT(doctor_id)DESC, name;


-- 10 Mostra els pacients ingressats amb: nom complet del pacient, número d’habitació,
-- tipus d’habitació, data d’ingrés, i el nombre de dies ingressat fins a la data actual.
-- Només s’han de mostrar ingressos actius (discharge_date IS NULL).
-- Empra una funció de dates per calcular els dies d’ingrés.
-- Ordena pels dies ingressats de major a menor.
SELECT CONCAT_WS(first_name,' ', last_name) AS nom_complet, room_number, room_type, admission_date,
DATEDIFF(CURDATE(),admission_date) AS dies_ingressat
FROM patients
JOIN room_assignments USING (patient_id)
JOIN rooms USING (room_id)
WHERE discharge_date IS NULL;


-- 11 Mostra els metges amb el seu número de llicència i el nom de l’especialitat, 
-- però només aquells en què el nom de l’especialitat conté la paraula “logia”.
-- Aplica una funció de text per mostrar el nom de l’especialitat en majúscules.
-- Ordena pel número de llicència.
SELECT doctor_id, license_number,UPPER(name) AS name FROM doctors
JOIN specialties USING (specialty_id)
WHERE name LIKE '%LOGIA'
ORDER BY license_number;


-- 12 Mostra les habitacions i el nombre total de llits que té cadascuna.
-- Mostra només les habitacions amb 2 o més llits.
-- Ordena primer pel nombre de llits descendent i després pel número d’habitació.
SELECT room_number, COUNT(bed_number) FROM rooms
JOIN room_assignments USING (room_id)
GROUP BY room_number 
HAVING COUNT(bed_number) >= 2
ORDER BY COUNT(bed_number) DESC, room_number ASC;


-- 13 Mostra els pacients que no tenen cap resultat de laboratori registrat.
-- Mostra patient_id, nom complet i telèfon.
-- Ordena pel nom complet.
SELECT  patient_id, CONCAT_WS(first_name, last_name) AS nom_complet, phone 
FROM patients
LEFT JOIN lab_results USING (patient_id)
WHERE result_id IS NULL
ORDER BY nom_complet;


-- 14 Fes una consulta amb UNION que retorni: totes les consultes mèdiques de l’any 2023, i
-- totes les cites cancel·lades de l’any 2023.
-- Les dues parts de la consulta han de retornar aquestes columnes:
-- tipus_registre, patient_id, doctor_id, data_registre.
-- A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'.
-- Ordena el resultat per data_registre.
SELECT 'Consulta' AS tipus_registre,patient_id, doctor_id,consultation_date AS data_registre
FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION ALL
SELECT 'Cita cancelada' AS tipus_registre, patient_id,doctor_id,appointment_date AS data_registre
FROM appointments
WHERE YEAR(appointment_date) = 2023
AND status = 'cancelled'
ORDER BY data_registre;


-- 15 Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
-- Mostra només els proveïdors amb una mitjana d’import superior a 90 euros.
-- Ordena per import mitjà descendent.
SELECT  name,COUNT(order_id), ROUND(AVG(total_amount),2)
FROM orders
JOIN suppliers USING (supplier_id)
GROUP BY order_id
HAVING AVG(total_amount) > 90
ORDER BY AVG(total_amount) DESC;

-- 16 Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'.
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS nom_complet,
    p.email
FROM patients p
WHERE p.patient_id IN (
    SELECT DISTINCT b.patient_id
    FROM billing b
    WHERE b.status = 'Paid'
)
ORDER BY p.patient_id;

-- 17 Mostra els medicaments que tenen un preu unitari (order_items.unit_price)
-- superior a qualsevol dels preus de la comanda amb  order_id = 1.
SELECT 
    m.name AS nom_medicament,
    oi.unit_price
FROM medications m
JOIN order_items oi ON m.medication_id = oi.medication_id
WHERE oi.unit_price > ANY (
    SELECT unit_price
    FROM order_items
    WHERE order_id = 1
)
ORDER BY oi.unit_price DESC;

-- 18 Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient 1.
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS nom_complet,
    b.amount AS import_factura
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > ALL (
    SELECT amount
    FROM billing
    WHERE patient_id = 1
)
ORDER BY b.amount DESC;

-- 19 Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures.
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS nom_complet,
    b.amount AS import_factura
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > (
    SELECT AVG(amount)
    FROM billing
)
ORDER BY b.amount DESC;

-- 20 Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes.
SELECT 
    o.order_id,
    o.supplier_id,
    o.order_date,
    o.status,
    o.total_amount
FROM orders o
WHERE o.total_amount = (
    SELECT MAX(total_amount)
    FROM orders
)
ORDER BY o.order_id;

-- 21 Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats.
SELECT 
    lr.result_id,
    lr.patient_id,
    lr.test_id,
    lr.result_date,
    lr.result_value
FROM lab_results lr
WHERE lr.result_value < (
    SELECT MIN(result_value)
    FROM lab_results
);

-- 22 Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc.
SELECT 
    consultes_per_pacient.num_consultes,
    COUNT(consultes_per_pacient.patient_id) AS num_pacients
FROM (
    SELECT 
        patient_id,
        COUNT(consultation_id) AS num_consultes
    FROM consultations
    GROUP BY patient_id
) AS consultes_per_pacient
GROUP BY consultes_per_pacient.num_consultes
ORDER BY consultes_per_pacient.num_consultes;

-- 23Mostra el nombre de comandes segons l’import total de cada comanda, 
-- classificades en els següents trams: Menys de 200 € Entre 200 € i 500 € Més de 500 € Mostra quantes comandes hi ha en cada tram.
SELECT 
    tram_import,
    COUNT(order_id) AS num_comandes
FROM (
    SELECT 
        order_id,
        total_amount,
        CASE 
            WHEN total_amount < 200 THEN 'Menys de 200 €'
            WHEN total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
            ELSE 'Més de 500 €'
        END AS tram_import
    FROM orders
) AS comandes_tram
GROUP BY tram_import
ORDER BY FIELD(tram_import, 'Menys de 200 €', 'Entre 200 € i 500 €', 'Més de 500 €');

-- 24 Mostra les consultes mèdiques (consultations) que són les més recents de cada pacient.
SELECT 
    c.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS nom_pacient,
    c.consultation_date AS data_mes_recent,
    c.doctor_id,
    c.consultation_notes
FROM consultations c
JOIN patients p ON c.patient_id = p.patient_id
WHERE c.consultation_date = (
    SELECT MAX(consultation_date)
    FROM consultations c2
    WHERE c2.patient_id = c.patient_id
)
ORDER BY c.patient_id;