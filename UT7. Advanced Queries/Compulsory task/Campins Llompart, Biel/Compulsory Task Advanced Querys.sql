/*Mostra el nom i llinatges dels pacients, la data de la cita i l’estat de totes les cites completades de l’any 2024.
Ordena el resultat per data de cita descendent i, en cas d’empat, per llinatge ascendent.*/
SELECT CONCAT_WS(' ', p.first_name, p.last_name) AS nom_pacient, a.appointment_date, a.status
FROM patients p
INNER JOIN appointments a ON p.patient_id = a.patient_id
WHERE a.status = 'Completed' AND YEAR(a.appointment_date) = 2024
ORDER BY a.appointment_date DESC, p.last_name ASC;

/*Mostra totes les habitacions (room_number, room_type) i, si està assignada, el nom del pacient i data d’admissió. Si no està assignada, mostra el text ‘Sense assignar’.
Mostra només les assignacions encara actives (discharge_date IS NULL).
Ordena per room_type i després per room_number.*/
SELECT r.room_number,  r.room_type,  COALESCE(CONCAT_WS(' ', p.first_name, p.last_name), 'Sense asignar') AS nom_pacient, ra.admission_date
FROM rooms r
LEFT JOIN room_assignments ra ON r.room_id = ra.room_id AND ra.discharge_date IS NULL
LEFT JOIN patients p ON ra.patient_id = p.patient_id
ORDER BY r.room_type, r.room_number;


/*Llista els pacients que no tenen cap pòlissa d’assegurança associada.
Mostra patient_id, nom complet i email.
Ordena pel patient_id.*/
SELECT p.patient_id, CONCAT_WS(' ', p.first_name, p.last_name) AS nom_complet, p.email
FROM patients p
LEFT JOIN insurance_policies ip ON p.patient_id = ip.patient_id
WHERE ip.policy_id IS NULL
ORDER BY p.patient_id;

/*Mostra els 5 proveïdors que tenen més comandes rebudes (status = 'Received').
Mostra el nom del proveïdor i el nombre de comandes.
Mostrar només els proveïdors amb 2 o més comandes rebudes.
Ordena de més a menys comandes rebudes*/
SELECT s.name, COUNT(o.order_id) AS total_comandes
FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
WHERE o.status = 'Received'
GROUP BY s.supplier_id
HAVING total_comandes >= 2
ORDER BY total_comandes DESC
LIMIT 5;

/*Mostra el nom del medicament, la quantitat i el preu unitari arrodonit a 1 decimal de totes les línies de comanda on la quantitat sigui superior a 5.
Ordena per quantitat descendent.*/
SELECT m.name, oi.quantity, ROUND(oi.unit_price, 1) AS preu_unitari
FROM order_items oi
INNER JOIN medications m ON oi.medication_id = m.medication_id
WHERE oi.quantity > 5
ORDER BY oi.quantity DESC;

/*Mostra totes les assignacions de personal a instal·lacions amb el nom de la instal·lació, el staff_type, el staff_id i la start_date.
Ordena pel nom de la instal·lació*/
-- Part A: Assignacions actuals
SELECT hf.facility_name, sfa.staff_type, sfa.staff_id, sfa.start_date
FROM hospital_facilities hf
INNER JOIN staff_facility_assignments sfa ON hf.facility_id = sfa.facility_id
ORDER BY hf.facility_name;


/*Mostra les instal·lacions que no tenen cap assignació de personal.
Mostra facility_id, facility_name i facility_type.*/
SELECT hf.facility_id, hf.facility_name, hf.facility_type
FROM hospital_facilities hf
LEFT JOIN staff_facility_assignments sfa ON hf.facility_id = sfa.facility_id
WHERE sfa.assignment_id IS NULL;

/*Fes una consulta amb UNION que mostri en una sola llista:
els noms complets dels doctors, i
els noms complets de les infermeres.
En ambdós casos, la columna ha de sortir amb el mateix àlies, per exemple nom_complet, i una segona columna que indiqui el tipus de personal ('Doctor' o 'Nurse').
Ordena el resultat final pel nom complet.*/
SELECT CONCAT_WS(' ', s.first_name, s.last_name) AS nom_complet, 'Doctor' AS tipus_personal
FROM staff s
INNER JOIN doctors d ON s.staff_id = d.doctor_id
UNION
SELECT CONCAT_WS(' ', s.first_name, s.last_name) AS nom_complet, 'Nurse' AS tipus_personal
FROM staff s
INNER JOIN nurses n ON s.staff_id = n.nurse_id
ORDER BY nom_complet;

/*Mostra el nom de l’especialitat i el nombre de doctors assignats a cada especialitat.
Mostra només les especialitats que tenen exactament 1 doctor o més.
Ordena pel nombre de doctors descendent i després pel nom de l’especialitat.*/
SELECT s.name, COUNT(d.doctor_id) AS nombre_doctors
FROM specialties s
INNER JOIN doctors d ON s.specialty_id = d.specialty_id
GROUP BY s.specialty_id
HAVING nombre_doctors >= 1
ORDER BY nombre_doctors DESC, s.name ASC;

/*Mostra els pacients ingressats amb:
nom complet del pacient,
número d’habitació,
tipus d’habitació,
data d’ingrés,
i el nombre de dies ingressat fins a la data actual.
Només s’han de mostrar ingressos actius (discharge_date IS NULL).
Empra una funció de dates per calcular els dies d’ingrés.
Ordena pels dies ingressats de major a menor.*/
SELECT CONCAT_WS(' ', p.first_name, p.last_name) AS nom_complet, 
       r.room_number, r.room_type, ra.admission_date,
       DATEDIFF(CURDATE(), ra.admission_date) AS dies_ingressat
FROM room_assignments ra
INNER JOIN patients p ON ra.patient_id = p.patient_id
INNER JOIN rooms r ON ra.room_id = r.room_id
WHERE ra.discharge_date IS NULL
ORDER BY dies_ingressat DESC;

/*Mostra els metges amb el seu número de llicència i el nom de l’especialitat, però només aquells en què el nom de l’especialitat conté la paraula “logia”.
Aplica una funció de text per mostrar el nom de l’especialitat en majúscules.
Ordena pel número de llicència.*/
SELECT d.license_number, UPPER(s.name) AS especialitat_majuscules
FROM doctors d
INNER JOIN specialties s ON d.specialty_id = s.specialty_id
WHERE s.name LIKE '%logia%'
ORDER BY d.license_number;

/*Mostra les habitacions i el nombre total de llits que té cadascuna.
Mostra només les habitacions amb 2 o més llits.
Ordena primer pel nombre de llits descendent i després pel número d’habitació.*/
SELECT r.room_number, COUNT(b.bed_id) AS total_llits
FROM rooms r
INNER JOIN beds b ON r.room_id = b.room_id
GROUP BY r.room_id
HAVING total_llits >= 2
ORDER BY total_llits DESC, r.room_number ASC;

/*Mostra els pacients que no tenen cap resultat de laboratori registrat.
Mostra patient_id, nom complet i telèfon.
Ordena pel nom complet.*/
SELECT p.patient_id, CONCAT_WS(' ', p.first_name, p.last_name) AS nom_complet, p.phone
FROM patients p
LEFT JOIN lab_results lr ON p.patient_id = lr.patient_id
WHERE lr.result_id IS NULL
ORDER BY nom_complet;

/*Fes una consulta amb UNION que retorni:
totes les consultes mèdiques de l’any 2023, i
totes les cites cancel·lades de l’any 2023.
Les dues parts de la consulta han de retornar aquestes columnes:
tipus_registre, patient_id, doctor_id, data_registre.
A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'.
Ordena el resultat per data_registre.*/

SELECT 'Consulta' AS tipus_registre, patient_id, doctor_id, consultation_date AS data_registre
FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION
SELECT 'Cita cancel·lada' AS tipus_registre, patient_id, doctor_id, appointment_date AS data_registre
FROM appointments
WHERE status = 'Cancelled' AND YEAR(appointment_date) = 2023
ORDER BY data_registre;

/*Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les seves comandes arrodonit a 2 decimals.
Mostra només els proveïdors amb una mitjana d’import superior a 90 euros.
Ordena per import mitjà descendent.*/
SELECT s.name, COUNT(o.order_id) AS total_comandes, ROUND(AVG(o.total_amount), 2) AS import_mitja
FROM suppliers s
INNER JOIN orders o ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id
HAVING import_mitja > 90
ORDER BY import_mitja DESC;

/*EXERCICIS AMB SUBCONSULTES
IN, ANY, ALL
Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'.*/
SELECT * FROM patients 
WHERE patient_id IN (SELECT patient_id FROM billing WHERE status = 'Paid');

/*Mostra els medicaments que tenen un preu unitari (order_items.unit_price) superior a qualsevol dels preus d’una comanda concreta (per exemple, order_id = 1).*/
SELECT name FROM medications 
WHERE medication_id IN (
    SELECT medication_id FROM order_items 
    WHERE unit_price > ANY (SELECT unit_price FROM order_items WHERE order_id = 1));

/*Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient concret (per exemple, patient_id = 1).*/
SELECT * FROM billing 
WHERE amount > ALL (SELECT amount FROM billing WHERE patient_id = 1);

/*FUNCIONS D’AGREGACIÓ
Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures.*/
SELECT * FROM billing 
WHERE amount > (SELECT AVG(amount) FROM billing);

/*Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes.*/
SELECT * FROM orders 
WHERE total_amount = (SELECT MAX(total_amount) FROM orders);

/*Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats.*/
SELECT * FROM lab_results 
WHERE result_value < (SELECT MIN(result_value) FROM lab_results);

/*TAULES DERIVADES
Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc.*/
SELECT t.num_consultes, COUNT(*) AS quants_pacients
FROM (SELECT patient_id, COUNT(*) AS num_consultes FROM consultations GROUP BY patient_id) AS t
GROUP BY t.num_consultes;

/*Mostra el nombre de comandes segons l’import total de cada comanda, classificades en els següents trams:
Menys de 200 €
Entre 200 € i 500 €
Més de 500 €
Mostra quantes comandes hi ha en cada tram.*/
SELECT tram, COUNT(*) AS quantitat_comandes
FROM (
    SELECT order_id,
        CASE 
            WHEN total_amount < 200 THEN 'Menys de 200 €'
            WHEN total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
            ELSE 'Més de 500 €'
        END AS tram
    FROM orders
) AS dades_trams
GROUP BY tram;