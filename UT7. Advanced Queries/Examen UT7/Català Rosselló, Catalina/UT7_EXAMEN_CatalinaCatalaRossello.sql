-- Resol sense utilitzar subconsultes --

/*1. Mostra el nom i cognom dels metges juntament amb la data de les seves
cites (appointments) i l’estat d’aquestes.*/

SELECT first_name, last_name, appointment_date, status FROM staff
JOIN doctors ON doctor_id = staff_id
JOIN appointments USING(doctor_id);

/*2. Mostra el nom complet dels pacients, tenguin o no registres de facturació
(billing), juntament amb la suma total facturada.
Mostra només els pacients nascuts abans de 1990.
Ordena pel total facturat de més a menys.*/

SELECT CONCAT_WS(' ', first_name, last_name) AS nom_complet, 
	SUM(amount) AS 'total_facturat'
FROM patients
LEFT JOIN billing USING(patient_id)
WHERE YEAR(birth_date) < 1990
GROUP BY patient_id
ORDER BY total_facturat DESC;

/*3. Mostra supplier_id, name i contact_person de tots els proveïdors que no
tenen cap comanda (order) registrada.
Ordena per nom.*/

SELECT supplier_id, name, contact_person FROM suppliers
LEFT JOIN orders USING(supplier_id)
WHERE order_id IS NULL
ORDER BY name;

/*4. Mostra el total d’imports facturats (billing) i el total d’imports de
comandes (orders), en dues files separades amb una columna que
indiqui el tipus (“Cobros” o “Pagaments”).*/

SELECT COUNT(*) AS  total_facturats, 'Cobros' AS Tipus FROM billing

UNION

SELECT COUNT(*) AS  total_comandes, 'Pagaments' AS Tipus FROM billing;


-- Resol utilitzant subconsultes --

/*5. Mostra el nom dels medicaments que han estat prescrits (prescriptions)
en alguna consulta.
Ordena’ls alfabèticament.*/

SELECT name FROM medications
WHERE medication_id IN(
	SELECT medication_id FROM prescriptions
	JOIN consultations USING(consultation_id)
)
ORDER BY name ;

/*6. Mostra tots els camps dels resultats de laboratori (lab_results) on el seu
valor sigui major que algun valor normal mínim definit a les proves
(lab_tests).*/

SELECT * FROM lab_results
WHERE result_value > ANY (
	SELECT DISTINCT normal_min FROM lab_tests
);

/*7. Mostra el nom complet dels pacients que tenen factures amb un import
inferior a la mitjana de les factures pagades.
Ordena pel nom del pacient.*/

SELECT DISTINCT CONCAT_WS(' ', first_name, last_name) AS nom_complet
FROM patients
JOIN billing USING(patient_id)
WHERE amount < (
	SELECT AVG(amount) FROM billing
	WHERE status LIKE 'Paid'
)
ORDER BY nom_complet;

/*8. Mostra quants pacients tenen 1 resultat de laboratori, 2, 3, etc.*/

SELECT total_resultats, COUNT(*) AS 'total_pacients'
FROM(
	SELECT patient_id, COUNT(*) AS 'total_resultats'
	FROM lab_results
	GROUP BY patient_id
) AS subquery
GROUP BY total_resultats;

/*9. Mostra tots els camps de les línies de comanda (order_items) en què la
quantitat demanada és superior a la mitjana de quantitats demanades
d’aquell mateix medicament.*/

SELECT * FROM order_items oi1
WHERE quantity > (
	SELECT AVG(quantity) FROM order_items oi2
	WHERE oi1.medication_id = oi2.medication_id
);

/*10. Classifica els pacients segons la seva despesa total en (billing):
	a.​ Menys de 100 €
	b.​ Entre 100 i 500 €
	c.​ Més de 500 €
I mostra quants pacients hi ha en cada grup.*/

SELECT
	CASE
		WHEN suma_despesa < 100 THEN 'Menys de 100 €'
        WHEN suma_despesa BETWEEN 100 AND 500 THEN 'Entre 100 i 500 €'
        ELSE 'Més de 500 €'
	END AS 'total_despeses',
    COUNT(*) AS total_pacients
FROM(
SELECT patient_id, SUM(amount) AS 'suma_despesa'
FROM billing
GROUP BY patient_id
) AS subquery
GROUP BY total_despeses;
