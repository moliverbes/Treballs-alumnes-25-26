-- Arnau Garcia Franco Compulsory_task 20/04/26
use hospitaldb;
/*1.Mostra el nom i llinatges dels pacients, la data de la cita i l’estat de totes les cites completades de l’any 2024.
Ordena el resultat per data de cita descendent i, en cas d’empat, per llinatge ascendent.*/
SELECT p.first_name, p.last_name, a.appointment_date, a.status FROM patients p
JOIN appointments a ON a.patient_id = a.patient_id
WHERE appointment_date like '2024-%'
ORDER BY a.appointment_date DESC, p.last_name ASC;
/*2. Mostra totes les habitacions (room_number, room_type) i, si està assignada, el nom del pacient i data d’admissió. Si no està assignada, mostra el text ‘Sense assignar’.
Mostra només les assignacions encara actives (discharge_date IS NULL).
Ordena per room_type i després per room_number. */
SELECT ro.room_number, ro.room_type,  r.admission_date, CONCAT(p.first_name, ' ', p.last_name) AS 'nom pacient' FROM rooms ro
JOIN room_assignments r ON r.room_id = ro.room_id
JOIN patients p ON p.patient_id = r.patient_id
WHERE r.discharge_date IS NULL;

/* 3.Llista els pacients que no tenen cap pòlissa d’assegurança associada.
Mostra patient_id, nom complet i email.
Ordena pel patient_id.*/
SELECT patient_id, CONCAT(first_name, ' ', last_name) AS nom_complet, email FROM patients
WHERE patient_id NOT IN ( SELECT patient_id FROM insurance_policies );

--  4.Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received').
SELECT s.name, COUNT(o.order_id) AS nombre_comandes FROM suppliers s
JOIN orders o ON s.supplier_id = o.supplier_id
WHERE o.status = 'Received'
GROUP BY s.supplier_id, s.name
HAVING COUNT(o.order_id) >= 2
ORDER BY nombre_comandes DESC
LIMIT 5;
/* 5. Mostra el nom del medicament, la quantitat i el preu unitari arrodonit a 1 decimal de totes les línies de comanda on la quantitat sigui superior a 5.
Ordena per quantitat descendent. */
SELECT ROUND(oi.unit_price, 1) As preu_arredonit, oi.quantity,  med.name FROM order_items oi
JOIN medications med ON oi.medication_id = med.medication_id
WHERE oi.quantity > 5
ORDER BY oi.quantity DESC;

/* 6.Mostra totes les assignacions de personal a instal·lacions amb el nom de la instal·lació, el staff_type, el staff_id i la start_date.
Ordena pel nom de la instal·lació */
SELECT sfa.staff_type, sfa.staff_id, sfa.start_date, hos.facility_type FROM staff_facility_assignments sfa
JOIN hospital_facilities hos ON sfa.facility_id = hos.facility_id
ORDER BY hos.facility_name;

/* 7.Mostra les instal·lacions que no tenen cap assignació de personal.
Mostra facility_id, facility_name i facility_type. */
SELECT hos.facility_id, hos.facility_name, hos.facility_type, sfa.staff_id FROM hospital_facilities hos 
LEFT JOIN staff_facility_assignments sfa ON hos.facility_id = sfa.facility_id	
where sfa.assignment_id IS null;
/* 8 Fes una consulta amb UNION que mostri en una sola llista:
els noms complets dels doctors, i
els noms complets de les infermeres.
*/
SELECT CONCAT(st.first_name, ' ', st.last_name) AS nom_complet, 'Doctor' AS tipus_personal FROM staff st
JOIN doctors d ON st.staff_id = d.doctor_id
UNION 
SELECT CONCAT(st.first_name, ' ', st.last_name) AS nom_complet, 'Nurse' AS tipus_personal FROM staff st
JOIN nurses n ON st.staff_id = n.nurse_id;

/* 9. Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat.
Mostra només les especialitats que tenen exactament 1 doctor o més.
Ordena pel nombre de doctors descendent i després pel nom de l’especialitat.
*/
SELECT s.name, COUNT(d.doctor_id) AS nombre_doctors FROM specialties s
JOIN doctors d ON s.specialty_id = d.specialty_id
GROUP BY s.specialty_id, s.name
HAVING COUNT(d.doctor_id) >= 1
ORDER BY nombre_doctors DESC, s.name;
/* 10. Mostra els pacients ingressats amb:
 nom complet del pacient, número d’habitació, tipus d’habitació, data d’ingrés,
 i el nombre de dies ingressat fins a la data actual. 
 Només s’han de mostrar ingressos actius (discharge_date IS NULL).
 Ordena pels dies ingressats de major a menor. */
 SELECT CONCAT(p.first_name, ' ', p.last_name) AS nom_pacient, DATEDIFF(CURDATE(),ra.admission_date ) AS dies_ingresat , r.room_number, r.room_type FROM patients p
 JOIN room_assignments ra ON ra.patient_id = p.patient_id
 JOIN rooms r ON r.room_id = ra.room_id
 WHERE ra.discharge_date IS NULL
 ORDER BY dies_ingresat desc;
 /* 11. Mostra els metges amb el seu número de llicència i el nom de l’especialitat,
però només aquells en què el nom de l’especialitat conté la paraula “logia”.
Aplica una funció de text per mostrar el nom de l’especialitat en majúscules.
Ordena pel número de llicència. */
SELECT d.license_number, UPPER(s.name) AS especialitat_majuscules FROM doctors d
JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE s.name LIKE '%logia%'
ORDER BY d.license_number;

 /*12. Mostra les habitacions i el nombre total de llits que té cadascuna.
 Mostra només les habitacions amb 2 o més llits.
 Ordena primer pel nombre de llits descendent i després pel número d’habitació.
SELECT r.room_number, COUNT(b.bed_id) AS nombre_llits */
FROM rooms r
LEFT JOIN beds b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_number
HAVING COUNT(b.bed_id) >= 2
ORDER BY nombre_llits DESC, r.room_number;

/* 13. Mostra els pacients que no tenen cap resultat de laboratori registrat.
 Mostra patient_id, nom complet i telèfon.
Ordena pel nom complet. */
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS nom_complet, p.phone FROM patients p
LEFT JOIN lab_results lr ON p.patient_id = lr.patient_id
WHERE lr.result_id IS NULL
ORDER BY nom_complet;

/* 14. Fes una consulta amb UNION que retorni:
 totes les consultes mèdiques de l’any 2023, i totes les cites cancel·lades de l’any 2023.
 Columnes: tipus_registre, patient_id, doctor_id, data_registre.
 tipus_registre: 'Consulta' a la primera part, 'Cita cancel·lada' a la segona.
 Ordena el resultat per data_registre. */
SELECT 'Consulta' AS tipus_registre, c.patient_id, c.doctor_id, c.consultation_date AS data_registre FROM consultations c
WHERE YEAR(c.consultation_date) = 2023
UNION
SELECT 'Cita cancel·lada' AS tipus_registre, a.patient_id, a.doctor_id, a.appointment_date AS data_registre FROM appointments a
WHERE YEAR(a.appointment_date) = 2023 AND a.status = 'Cancelled'
ORDER BY data_registre;

/* 15. Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
 Mostra només els proveïdors amb una mitjana d’import superior a 90 euros.
 Ordena per import mitjà descendent. */
SELECT s.name, COUNT(o.order_id) AS total_comandes,  ROUND(AVG(o.total_amount), 2) AS import_mitja FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.name
HAVING AVG(o.total_amount) > 90
ORDER BY import_mitja DESC;
-- SUBCONSULTES (IN, ANY, ALL)

-- 16.Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'.
SELECT first_name, last_name FROM PATIENTS
WHERE patient_id IN (SELECT status FROM BILLING
						WHERE status LIKE 'PAID');

/* 17Mostra els medicaments que tenen un preu unitari (order_items.unit_price) 
   superior a qualsevol dels preus de la comanda amb  order_id = 1. */
SELECT med.name, ord.unit_price FROM medications med
JOIN order_items ord ON med.medication_id = ord.medication_id
where ord.unit_price > ALL (SELECT unit_price FROM order_items
								WHERE order_id = 1 );
-- 18. Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient 1.
SELECT concat( p.first_name, ' ', p.last_name) AS nom_complet, b.amount FROM patients p
JOIN billing b ON b.patient_id = p.patient_id
WHERE b.amount > ALL (SELECT amount FROM billing
						WHERE patient_id = 1);
-- FUNCIONS D'AGREGACIÓ
-- 19. Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures.
SELECT p.patient_id, p.first_name, p.last_name, b.amount FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > (SELECT AVG(amount) FROM billing);
-- 20  Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes.
SELECT o.order_id, o.supplier_id, o.order_date, o.status, o.total_amount
FROM orders o
WHERE o.total_amount = (SELECT MAX(total_amount) FROM orders);

--  21 Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats.
SELECT lr.result_id, lr.patient_id, lr.test_id, lr.result_date, lr.result_value
FROM lab_results lr
WHERE lr.result_value < (SELECT MIN(result_value) FROM lab_results); 
-- TAULES DERIVADES
-- 22 Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc.
SELECT 
    nombre_consultes,
    COUNT(*) AS total_pacients
FROM (
    SELECT 
        p.patient_id,
        COUNT(c.consultation_id) AS nombre_consultes
    FROM patients p
    LEFT JOIN consultations c ON p.patient_id = c.patient_id
    GROUP BY p.patient_id
) AS consultes_per_pacient
WHERE nombre_consultes > 0
GROUP BY nombre_consultes
ORDER BY nombre_consultes;

-- 23 Mostra el nombre de comandes segons l'import total de cada comanda, classificades en trams
SELECT 
    tram_import,
    COUNT(*) AS total_comandes
FROM (
    SELECT 
        order_id,
        total_amount,
        CASE 
            WHEN total_amount < 200 THEN 'Menys de 200 €'
            WHEN total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
            WHEN total_amount > 500 THEN 'Més de 500 €'
        END AS tram_import
    FROM orders
    WHERE total_amount IS NOT NULL
) AS comandes_tram
GROUP BY tram_import
ORDER BY FIELD(tram_import, 'Menys de 200 €', 'Entre 200 € i 500 €', 'Més de 500 €');
-- 24 Mostra les consultes mèdiques (consultations) que són les més recents de cada pacient
SELECT c1.consultation_id, c1.patient_id, c1.doctor_id, c1.consultation_date, c1.consultation_notes
FROM consultations c1
WHERE c1.consultation_date = (
    SELECT MAX(c2.consultation_date)
    FROM consultations c2
    WHERE c2.patient_id = c1.patient_id
)
ORDER BY c1.patient_id;
