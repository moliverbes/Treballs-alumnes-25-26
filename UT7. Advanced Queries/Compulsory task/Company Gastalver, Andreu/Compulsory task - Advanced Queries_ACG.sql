/* CONSULTES AMB INNER, LEFT/RIGHT JOIN i UNION. NO UTILITZEU SUBCONSULTES. */

/* 1 Mostra el nom i llinatges dels pacients, la data de la cita i l’estat de totes les cites completades de l’any 2024. 
Ordena el resultat per data de cita descendent i, en cas d’empat, per llinatge ascendent.*/

SELECT p.first_name, p.last_name, a.appointment_date, a.status
FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
WHERE a.status = 'Completed' AND YEAR(a.appointment_date) = 2024
ORDER BY a.appointment_date DESC, p.last_name ASC;

/* 2 Mostra totes les habitacions (room_number, room_type) i, si està assignada, el nom del pacient i data d’admissió. Si no està assignada, mostra el text ‘Sense assignar’.
Mostra només les assignacions encara actives (discharge_date IS NULL). 
Ordena per room_type i després per room_number. */

SELECT r.room_number, r.room_type, IFNULL(p.first_name, 'Sense assignar') AS nom_pacient, ra.admission_date
FROM rooms r
LEFT JOIN room_assignments ra ON r.room_id = ra.room_id
LEFT JOIN patients p ON ra.patient_id = p.patient_id
WHERE ra.discharge_date IS NULL OR ra.assignment_id IS NULL
ORDER BY r.room_type ASC, r.room_number ASC;

/* 3 Llista els pacients que no tenen cap pòlissa d’assegurança associada.
Mostra patient_id, nom complet i email.
Ordena pel patient_id. */

SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS full_name, p.email
FROM patients p
LEFT JOIN insurance_policies ip ON p.patient_id = ip.patient_id
WHERE ip.policy_id IS NULL
ORDER BY p.patient_id ASC;

/* 4 Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received').
Mostra el nom del proveïdor i el nombre de comandes.
Mostrar només els proveïdors amb 2 o més comandes rebudes.
Ordena de més a menys comandes rebudes */

SELECT s.name, COUNT(o.order_id) AS total_orders
FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
WHERE o.status = 'Received'
GROUP BY s.supplier_id, s.name
HAVING COUNT(o.order_id) >= 2
ORDER BY total_orders DESC
LIMIT 5;

/* 5 Mostra el nom del medicament, la quantitat i el preu unitari arrodonit a 1 decimal de totes les línies de comanda on la quantitat sigui superior a 5.
Ordena per quantitat descendent. */

SELECT m.name, oi.quantity, ROUND(oi.unit_price, 1) AS unit_price
FROM order_items oi
INNER JOIN medications m ON oi.medication_id = m.medication_id
WHERE oi.quantity > 5
ORDER BY oi.quantity DESC;

/* 6 Mostra totes les assignacions de personal a instal·lacions amb el nom de la instal·lació, el staff_type, el staff_id i la start_date. 
Ordena pel nom de la instal·lació */

SELECT f.name, s.staff_type, s.staff_id, sf.start_date
FROM staff_facilities sf
INNER JOIN staff s ON sf.staff_id = s.staff_id
INNER JOIN facilities f ON sf.facility_id = f.facility_id
ORDER BY f.name ASC;

/* 7 Mostra les instal·lacions que no tenen cap assignació de personal.
Mostra facility_id, facility_name i facility_type. */

SELECT f.facility_id, f.name, f.type
FROM facilities f
LEFT JOIN staff_facilities sf ON f.facility_id = sf.facility_id
WHERE sf.staff_id IS NULL;

/* 8 Fes una consulta amb UNION que mostri en una sola llista:
els noms complets dels doctors, i
els noms complets de les infermeres.
En ambdós casos, la columna ha de sortir amb el mateix àlies, per exemple nom_complet, i una segona columna que indiqui el tipus de personal ('Doctor' o 'Nurse').
Ordena el resultat final pel nom complet. */

SELECT CONCAT(first_name, ' ', last_name) AS nom_complet, 'Doctor' AS tipus
FROM staff
WHERE staff_type = 'Doctor'
UNION
SELECT CONCAT(first_name, ' ', last_name), 'Nurse'
FROM staff
WHERE staff_type = 'Nurse'
ORDER BY nom_complet;

/* 9 Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat.
Mostra només les especialitats que tenen exactament 1 doctor o més.
Ordena pel nombre de doctors descendent i després pel nom de l’especialitat. */

SELECT sp.name, COUNT(d.doctor_id) AS total_doctors
FROM doctors d
INNER JOIN specialties sp ON d.specialty_id = sp.specialty_id
GROUP BY sp.name
HAVING COUNT(d.doctor_id) >= 1
ORDER BY total_doctors DESC, sp.name ASC;

/* 10 Mostra els pacients ingressats amb:
nom complet del pacient,
número d’habitació,
tipus d’habitació,
data d’ingrés,
i el nombre de dies ingressat fins a la data actual.
Només s’han de mostrar ingressos actius (discharge_date IS NULL).
Empra una funció de dates per calcular els dies d’ingrés.
Ordena pels dies ingressats de major a menor. */

SELECT CONCAT(p.first_name, ' ', p.last_name) AS pacient, r.room_number, r.room_type, ra.admission_date, DATEDIFF(CURDATE(), ra.admission_date) AS dies
FROM patients p
INNER JOIN room_assignments ra ON p.patient_id = ra.patient_id
INNER JOIN rooms r ON ra.room_id = r.room_id
WHERE ra.discharge_date IS NULL
ORDER BY dies DESC;

/* 11 Mostra els metges amb el seu número de llicència i el nom de l’especialitat, però només aquells en què el nom de l’especialitat conté la paraula “logia”.
Aplica una funció de text per mostrar el nom de l’especialitat en majúscules.
Ordena pel número de llicència. */

SELECT d.license_number, UPPER(sp.name) AS specialty
FROM doctors d
INNER JOIN specialties sp ON d.specialty_id = sp.specialty_id
WHERE sp.name LIKE '%logia%'
ORDER BY d.license_number;

/* 12 Mostra les habitacions i el nombre total de llits que té cadascuna.
Mostra només les habitacions amb 2 o més llits.
Ordena primer pel nombre de llits descendent i després pel número d’habitació. */

SELECT r.room_number, COUNT(b.bed_id) AS total_beds
FROM rooms r
INNER JOIN beds b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_number
HAVING COUNT(b.bed_id) >= 2
ORDER BY total_beds DESC, r.room_number ASC;

/* 13 Mostra els pacients que no tenen cap resultat de laboratori registrat.
Mostra patient_id, nom complet i telèfon.
Ordena pel nom complet. */

SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS full_name, p.phone
FROM patients p
LEFT JOIN lab_results lr ON p.patient_id = lr.patient_id
WHERE lr.result_id IS NULL
ORDER BY full_name ASC;

/* 14 Fes una consulta amb UNION que retorni:
totes les consultes mèdiques de l’any 2023, i
totes les cites cancel·lades de l’any 2023.
Les dues parts de la consulta han de retornar aquestes columnes:
tipus_registre, patient_id, doctor_id, data_registre.
A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'.
Ordena el resultat per data_registre. */

SELECT 'Consulta' AS tipus_registre, c.patient_id, c.doctor_id, c.consultation_date AS data_registre
FROM consultations c
WHERE YEAR(c.consultation_date) = 2023
UNION
SELECT 'Cita cancel·lada', a.patient_id, a.doctor_id, a.appointment_date
FROM appointments a
WHERE a.status = 'Cancelled' AND YEAR(a.appointment_date) = 2023
ORDER BY data_registre;

/* 15 Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
Mostra només els proveïdors amb una mitjana d’import superior a 90 euros.
Ordena per import mitjà descendent. */

SELECT s.name, COUNT(o.order_id) AS total_orders, ROUND(AVG(o.total_amount), 2) AS avg_amount
FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.name
HAVING AVG(o.total_amount) > 90
ORDER BY avg_amount DESC;

/* EXERCICIS AMB SUBCONSULTES 
IN, ANY, ALL */
/*16 Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'. */

SELECT p.patient_id, p.first_name
FROM patients p
WHERE p.patient_id IN (
    SELECT b.patient_id
    FROM billing b
    WHERE b.status = 'Paid'
);

/* 17 Mostra els medicaments que tenen un preu unitari (order_items.unit_price) superior a qualsevol dels preus d’una comanda concreta (per exemple, order_id = 1). */

SELECT DISTINCT m.medication_id, m.name
FROM medications m
INNER JOIN order_items oi ON m.medication_id = oi.medication_id
WHERE oi.unit_price > ANY (
    SELECT oi2.unit_price
    FROM order_items oi2
    WHERE oi2.order_id = 1
);

/* 18 Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient concret (per exemple, patient_id = 1). */

SELECT DISTINCT p.patient_id, p.first_name
FROM patients p
INNER JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > ALL (
    SELECT b2.amount
    FROM billing b2
    WHERE b2.patient_id = 1
);

/* FUNCIONS D’AGREGACIÓ */
/* 19 Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures. */

SELECT DISTINCT p.patient_id, p.first_name
FROM patients p
INNER JOIN billing b ON p.patient_id = b.patient_id
WHERE b.amount > (
    SELECT AVG(b2.amount)
    FROM billing b2
);

/* 20 Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes. */

SELECT o.order_id, o.total_amount
FROM orders o
WHERE o.total_amount = (
    SELECT MAX(o2.total_amount)
    FROM orders o2
);

/* 21 Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats. */

SELECT lr.result_id, lr.result_value
FROM lab_results lr
WHERE lr.result_value < (
    SELECT MIN(lr2.result_value)
    FROM lab_results lr2
);

/* TAULES DERIVADES */
/* 22 Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc. */

SELECT t.total_consultes, COUNT(*) AS num_pacients
FROM (
    SELECT c.patient_id, COUNT(*) AS total_consultes
    FROM consultations c
    GROUP BY c.patient_id
) t
GROUP BY t.total_consultes
ORDER BY t.total_consultes ASC;

/* 23 Mostra el nombre de comandes segons l’import total de cada comanda, classificades en els següents trams:
Menys de 200 €
Entre 200 € i 500 €
Més de 500 €
Mostra quantes comandes hi ha en cada tram. */

SELECT t.rang, COUNT(*) AS total_comandes
FROM (
    SELECT 
        CASE 
            WHEN o.total_amount < 200 THEN 'Menys de 200 €'
            WHEN o.total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
            ELSE 'Més de 500 €'
        END AS rang
    FROM orders o
) t
GROUP BY t.rang;