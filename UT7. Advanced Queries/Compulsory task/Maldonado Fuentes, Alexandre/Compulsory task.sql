/*1.Mostra el nom i llinatges dels pacients, la data de la cita i l’estat 
de totes les cites completades de l’any 2024.
Ordena el resultat per data de cita descendent i, en cas d’empat, 
per llinatge ascendent.*/

SELECT first_name,last_name, appointment_date, status 
FROM patients
INNER JOIN appointments USING(patient_id)
WHERE 
	status="Completed" 
AND
	YEAR(appointment_date) = 2024
ORDER BY appointment_date DESC, last_name ASC;
/*2.Mostra totes les habitacions (room_number, room_type) i, si 
està assignada, el nom del pacient i data d’admissió. Si no està 
assignada, mostra el text ‘Sense assignar’.Mostra només les assignacions
encara actives (discharge_date IS NULL).
Ordena per room_type i després per room_number.
*/

SELECT COALESCE(first_name,"sense assignar"), COALESCE(last_name,"sense assignar"), room_number, room_type, COALESCE(admission_date, "Sense assignar") 
FROM patients
RIGHT JOIN room_assignments USING(patient_id)
right JOIN rooms USING(room_id)
WHERE discharge_date IS NULL
ORDER BY room_type, room_number;

delete from room_assignments
where room_id =76;
select * from rooms;

/*3.Llista els pacients que no tenen cap pòlissa d’assegurança associada.
Mostra patient_id, nom complet i email.
Ordena pel patient_id.*/

SELECT patient_id, 
	CONCAT_ws(" ", first_name, last_name) AS 'Nom complet',
		email
FROM patients
INNER JOIN insurance_policies USING(patient_id)
ORDER BY patient_id
LIMIT 5;



/*4.Mostra els 5 proveïdors que tenen més comandes rebudes 
(status = 'Received').
Mostra el nom del proveïdor i el nombre de comandes.
Mostrar només els proveïdors amb 2 o més comandes rebudes.
Ordena de més a menys comandes rebudes*/

SELECT name  ,COUNT(O.order_id) 
FROM suppliers
LEFT JOIN orders O USING(supplier_id)
WHERE status="Received"
GROUP BY supplier_id
HAVING COUNT(O.order_id) >= 2
ORDER BY COUNT(O.order_id) DESC
LIMIT 5;


/*5.Mostra el nom del medicament, la quantitat i el preu unitari 
arrodonit a 1 decimal de totes les línies de comanda on la quantitat 
sigui superior a 5.
Ordena per quantitat descendent.*/

SELECT name, quantity, ROUND(unit_price,1)
FROM medications
INNER JOIN order_items USING(medication_id)
WHERE quantity > 5
ORDER BY quantity DESC;


/*6.Mostra totes les assignacions de personal a instal·lacions 
amb el nom de la instal·lació, el staff_type, el staff_id i la 
start_date.Ordena pel nom de la instal·lació*/

SELECT s.staff_type, staff_id, start_date 
FROM staff
INNER JOIN staff_facility_assignments s USING(staff_id)
INNER JOIN hospital_facilities USING(facility_id)
ORDER BY s.staff_type;


/*7.Mostra les instal·lacions que no tenen cap assignació de personal.
Mostra facility_id, facility_name i facility_type.*/

SELECT 
    hf.facility_id,
    hf.facility_name,
    hf.facility_type
FROM hospital_facilities hf
LEFT JOIN staff_facility_assignments sfa ON hf.facility_id = sfa.facility_id
WHERE sfa.assignment_id IS NULL;
/*8.Fes una consulta amb UNION que mostri en una sola llista:
els noms complets dels doctors, i
els noms complets de les infermeres.
En ambdós casos, la columna ha de sortir amb el mateix àlies, 
per exemple nom_complet, i una segona columna que indiqui el tipus de 
personal ('Doctor' o 'Nurse').
Ordena el resultat final pel nom complet.*/

SELECT CONCAT_WS(" ",first_name, last_name) 'Nom_Complet','Doctor' AS 'Tipus' FROM staff
WHERE staff_type="Doctor"
UNION
SELECT CONCAT_WS(" ",first_name, last_name) ,'Nurse' FROM staff
WHERE staff_type="Nurse"
ORDER BY Nom_Complet;


/*9.Mostra el nom de l’especialitat i el nombre de doctors 
assignats a cada especialitat.
Mostra només les especialitats que tenen 
exactament 1 doctor o més.
Ordena pel nombre de doctors descendent i després pel nom de 
l’especialitat.*/
SELECT name, doctor_id
FROM doctors
INNER JOIN specialties USING(specialty_id)
where specialty_id >= 1 
ORDER BY doctor_id DESC, name;




/*10.Mostra els pacients ingressats amb:
nom complet del pacient,
número d’habitació,
tipus d’habitació,
data d’ingrés,
i el nombre de dies ingressat fins a la data actual.
Només s’han de mostrar ingressos actius (discharge_date IS NULL).
Empra una funció de dates per calcular els dies d’ingrés.
Ordena pels dies ingressats de major a menor.*/

SELECT  DATEDIFF(CURDATE(), admission_date) AS 'Dies_ingresats',
		CONCAT_WS(" ", first_name, last_name) AS 'Nom_complet', 
		room_number, room_type, admission_date	
FROM patients
JOIN room_assignments USING(patient_id)
JOIN rooms USING(room_id)
WHERE discharge_date IS NULL
ORDER BY Dies_ingresats DESC;


/*11.Mostra els metges amb el seu número de llicència i el 
nom de l’especialitat, però només aquells en què el nom de 
l’especialitat conté la paraula “logia”.
Aplica una funció de text per mostrar el nom de 
l’especialitat en majúscules.
Ordena pel número de llicència.*/

SELECT license_number, UPPER(name) 
FROM doctors
INNER JOIN specialties USING(specialty_id)
WHERE UPPER(name) LIKE '%logia%'
ORDER BY license_number;

/*12.Mostra les habitacions i el nombre total de llits que té cadascuna.
Mostra només les habitacions amb 2 o més llits.
Ordena primer pel nombre de llits descendent i després pel 
número d’habitació.*/

SELECT room_id, COUNT(bed_number) FROM rooms
JOIN beds USING (room_id)
GROUP BY room_id
HAVING COUNT(bed_number) >= 2
ORDER BY COUNT(bed_number) DESC, room_number;


/*13.Mostra els pacients que no tenen cap resultat de laboratori registrat.
Mostra patient_id, nom complet i telèfon.
Ordena pel nom complet.*/

SELECT patient_id, CONCAT_WS(' ',first_name, last_name) AS 'Nom_Complet', phone 
FROM patients
JOIN lab_results USING(patient_id)
WHERE result_value IS NULL
ORDER BY Nom_Complet;


/*14.Fes una consulta amb UNION que retorni:
totes les consultes mèdiques de l’any 2023, i
totes les cites cancel·lades de l’any 2023.
Les dues parts de la consulta han de retornar aquestes columnes:
tipus_registre, patient_id, doctor_id, data_registre.
A la primera part, tipus_registre ha de valer 'Consulta'; a la segona, 'Cita cancel·lada'.
Ordena el resultat per data_registre.*/

SELECT 'Consulta' AS tipus_resgistre, patient_id, doctor_id, consultation_date AS data_registre
FROM consultations
WHERE YEAR(consultation_date) = 2023
UNION ALL
SELECT 'cita_cancel·lada' AS tipus_resgistre, patient_id, doctor_id, appointment_date AS data_registre
FROM appointments
WHERE YEAR(appointment_date) = 2023
AND status = 'Cancelled'
ORDER BY data_registre;


/*15.Mostra els proveïdors amb el nombre total de comandes i l’import mitjà de les 
seves comandes arrodonit a 2 decimals.
Mostra només els proveïdors amb una mitjana d’import superior a 90 euros.
Ordena per import mitjà descendent.*/

SELECT supplier_id, COUNT(order_id), ROUND(AVG(total_amount),2)
FROM suppliers
JOIN orders USING(supplier_id)
GROUP BY supplier_id
HAVING AVG(total_amount) > 90
ORDER BY AVG(total_amount) DESC;

/*16Mostra els pacients que tenen alguna factura (billing) amb estat 'Paid'.*/

SELECT *
FROM patients
WHERE patient_id IN (
	SELECT DISTINCT patient_id 
    FROM billing
    WHERE status = 'Paid');
select * from billing;

/*17.Mostra els medicaments que tenen un preu unitari (order_items.unit_price) 
superior a qualsevol dels preus de la comanda amb  order_id = 1.*/

SELECT DISTINCT m.*
FROM medications m
JOIN order_items oi ON m.medication_id = oi.medication_id
WHERE oi.unit_price > ANY (
    SELECT unit_price
    FROM order_items
    WHERE order_id = 1
);

/*18.Mostra els pacients que tenen alguna factura amb un import superior a totes les factures d’un pacient 1.*/

SELECT *
FROM patients
WHERE patient_id IN (
    SELECT DISTINCT patient_id
    FROM billing
    WHERE amount > ALL (
        SELECT amount
        FROM billing
        WHERE patient_id = 1
    )
);

/*19.Mostra els pacients que tenen alguna factura amb un import superior a la mitjana de totes les factures.*/

SELECT * 
FROM patients
JOIN billing USING(patient_id)
WHERE amount > (
	SELECT AVG(amount)
    FROM billing
);
    
/*20.Mostra les comandes (orders) que tenen un import total igual al màxim import de totes les comandes.*/

SELECT *
FROM orders
WHERE total_amount = (
	SELECT MAX(total_amount)
    FROM orders);
    
/*21.Mostra els resultats de laboratori que tenen un valor inferior al valor mínim de tots els resultats.*/

SELECT *
FROM lab_results
WHERE result_value < (
    SELECT MIN(result_value)
    FROM lab_results
);


/*22. Mostra quants pacients han anat a 1 consulta, 2 consultes, 3 consultes, etc.*/

SELECT 
    num_consultes,
    COUNT(*) AS num_pacients
FROM (
    SELECT 
        patient_id,
        COUNT(*) AS num_consultes
    FROM consultations
    GROUP BY patient_id
) AS consultes_per_pacient
GROUP BY num_consultes
ORDER BY num_consultes;

/*23.Mostra el nombre de comandes segons l’import total de cada comanda, classificades en els següents trams:
Menys de 200 €
Entre 200 € i 500 €
Més de 500 €
Mostra quantes comandes hi ha en cada tram. */

SELECT 
    tram,
    COUNT(*) AS num_comandes
FROM (
    SELECT 
        order_id,
        total_amount,
        CASE 
            WHEN total_amount < 200 THEN 'Menys de 200 €'
            WHEN total_amount BETWEEN 200 AND 500 THEN 'Entre 200 € i 500 €'
            WHEN total_amount > 500 THEN 'Més de 500 €'
            ELSE 'Sense import'
        END AS tram
    FROM orders
    WHERE total_amount IS NOT NULL
) AS comandes_per_tram
GROUP BY tram
ORDER BY num_comandes;

/*24.Mostra les consultes mèdiques (consultations) que són les més recents de cada pacient.*/

SELECT c1.*
FROM consultations c1
WHERE c1.consultation_date = (
    SELECT MAX(c2.consultation_date)
    FROM consultations c2
    WHERE c2.patient_id = c1.patient_id
)
ORDER BY c1.patient_id, c1.consultation_date DESC;






