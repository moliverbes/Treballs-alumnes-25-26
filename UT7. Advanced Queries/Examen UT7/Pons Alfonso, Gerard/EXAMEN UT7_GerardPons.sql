-- 1
SELECT 
    s.first_name,
    s.last_name,
    a.appointment_date,
    a.status
FROM doctors d
JOIN staff s ON d.doctor_id = s.staff_id
JOIN appointments a ON d.doctor_id = a.doctor_id;

-- 2
SELECT 
    CONCAT_WS(p.first_name, ' ', p.last_name) AS nom_complet,
    SUM(b.amount) AS total_facturat
FROM patients p
LEFT JOIN billing b ON p.patient_id = b.patient_id
WHERE p.birth_date < '1990-01-01'
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_facturat DESC;

-- 3
SELECT 
    s.supplier_id,
    s.name,
    s.contact_person
FROM suppliers s
LEFT JOIN orders o ON s.supplier_id = o.supplier_id
WHERE o.order_id IS NULL
ORDER BY s.name;

-- 4
SELECT 'Cobros' AS tipus, SUM(amount) AS total FROM billing
UNION ALL
SELECT 'Pagaments' AS tipus, SUM(total_amount) AS total FROM orders;

-- 5
SELECT name
FROM medications
WHERE medication_id IN (SELECT DISTINCT medication_id FROM prescriptions)
ORDER BY name;

-- 6
SELECT lr.*
FROM lab_results lr
WHERE lr.result_value > ANY (SELECT normal_min FROM lab_tests WHERE test_id = lr.test_id);

-- 7
SELECT DISTINCT CONCAT_WS(p.first_name, ' ', p.last_name) AS nom_complet
FROM patients p
WHERE p.patient_id IN (
    SELECT b.patient_id
    FROM billing b
    WHERE b.amount < (SELECT AVG(amount) FROM billing WHERE status = 'Paid')
)
ORDER BY nom_complet;

-- 8
SELECT 
    num_resultats,
    COUNT(patient_id) AS num_pacients
FROM (
    SELECT 
        patient_id,
        COUNT(*) AS num_resultats
    FROM lab_results
    GROUP BY patient_id
) AS resultats_per_pacient
GROUP BY num_resultats
ORDER BY num_resultats;

-- 9
SELECT oi.*
FROM order_items oi
WHERE oi.quantity > (
    SELECT AVG(quantity)
    FROM order_items oi2
    WHERE oi2.medication_id = oi.medication_id
);

-- 10 
SELECT 
    CASE 
        WHEN despesa_total < 100 THEN 'Menys de 100 €'
        WHEN despesa_total BETWEEN 100 AND 500 THEN 'Entre 100 i 500 €'
        WHEN despesa_total > 500 THEN 'Més de 500 €'
        ELSE 'Sense despesa'
    END AS grup_despesa,
    COUNT(*) AS num_pacients
FROM (
    SELECT 
        p.patient_id,
        COALESCE(SUM(b.amount), 0) AS despesa_total
    FROM patients p
    LEFT JOIN billing b ON p.patient_id = b.patient_id
    GROUP BY p.patient_id
) AS despeses_pacients
GROUP BY grup_despesa
ORDER BY FIELD(grup_despesa, 'Menys de 100 €', 'Entre 100 i 500 €', 'Més de 500 €', 'Sense despesa');