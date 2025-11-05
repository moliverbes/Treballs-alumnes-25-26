-- 1. Mostra l’identificador i el nom complet en una sola columna de tots els clients; ordena pel nom complet de forma ascendent.
SELECT id_client, CONCAT(nom, ' ', cognoms) AS nom_complet FROM clients
ORDER BY nom_complet ASC;

-- 2. Llista dels productes amb tres columnes anomenades exactament NOM_PRODUCTE, CATEGORIA i PREU_EUR; ordena pel preu de més alt a més baix i limita el resultat a 5 files.
SELECT nom AS NOM_PRODUCTE, categoria AS CATEGORIA, preu AS PREU_EURo FROM productes
ORDER BY preu DESC
LIMIT 5;

-- 3. Mostra els productes amb preu superior a 40; ensenya l’identificador, el nom i el preu; ordena pel preu de forma ascendent.
SELECT id_producte, nom, preu FROM productes
WHERE preu > 40
ORDER BY preu ASC;

-- 4. Mostra els clients el cognom dels quals conté la seqüència de lletres ‘ra’; ordena alfabèticament pel camp de cognoms.
SELECT * FROM clients
WHERE cognoms LIKE '%ra%'
ORDER BY cognoms ASC;

-- 5. Mostra el nom, la categoria i el preu dels productes amb preu entre 20 i 40 (inclosos); ordena primer pel preu i després pel nom.
SELECT nom, categoria, preu FROM productes
WHERE preu BETWEEN 20 AND 40
ORDER BY preu ASC, nom ASC;

-- 6. Mostra l’identificador, el nom i la categoria dels productes la categoria dels quals sigui Electrònica o Llibres; ordena per categoria ascendent i per nom descendent.
SELECT id_producte, nom, categoria FROM productes
WHERE categoria IN ('Electrònica', 'Llibres')
ORDER BY categoria ASC, nom DESC;

-- 7. Mostra de les comandes l’identificador, la data i l’estat; ordena de la més recent a la més antiga.
SELECT id_comanda, data_comanda, estat FROM comandes
ORDER BY data_comanda DESC;

-- 8. Mostra per a cada línia de detall_comanda l’identificador de comanda, el codi de producte, la quantitat, el preu unitari i una columna addicional amb el subtotal de la línia; ordena per identificador de comanda i després pel codi de producte.
SELECT id_comanda, id_producte, quantitat, preu_unitari, (quantitat * preu_unitari) AS subtotal
FROM detall_comanda
ORDER BY id_comanda ASC, id_producte ASC;

-- 9. De productes, mostra l’identificador, el nom en majúscules i la llargada del nom; ordena per la llargada de més gran a més petita i, en cas d’empat, pel nom en majúscules.
SELECT  id_producte, UPPER(nom) AS nom_majuscules, CHAR_LENGTH(nom) AS longitud_nom FROM productes
ORDER BY longitud_nom DESC, nom_majuscules ASC;

-- 10. De clients, mostra l’identificador, el nom i els 5 primers caràcters del camp de cognoms amb l’àlies prefix_cognoms; ordena per prefix_cognoms.
SELECT  id_client, nom, LEFT(cognoms, 5) AS prefix_cognoms
FROM clients
ORDER BY prefix_cognoms ASC;

-- 11. De productes, mostra l’identificador, el nom, el preu i una columna amb el preu amb un increment del 21%, arrodonit a 2 decimals; filtra només els productes amb estoc igual o superior a 10; ordena pel nou preu de més alt a més baix.
SELECT id_producte, nom, preu, ROUND(preu * 1.21, 2) AS preu_amb_iva FROM productes
WHERE stock >= 10
ORDER BY preu_amb_iva DESC;

-- 12. De productes, mostra l’identificador, el nom, el preu i el valor enter del preu; filtra només els productes amb estoc imparell; ordena per estoc de més gran a més petit.
SELECT  id_producte, nom, preu, FLOOR(preu) AS preu_enter FROM productes
WHERE stock % 2 = 1
ORDER BY stock DESC;

-- 13. De comandes, mostra l’identificador, la data i les columnes separades d’any, mes, dia i hora obtingudes a partir de la data; ordena per data ascendent.
SELECT  id_comanda, data_comanda,
    YEAR(data_comanda) AS any,
    MONTH(data_comanda) AS mes,
    DAY(data_comanda) AS dia,
    HOUR(data_comanda) AS hora
FROM comandes
ORDER BY data_comanda ASC;

-- 14. De comandes, mostra l’identificador i la data formatejada com YYYY-MM en una columna anomenada any_mes; ordena per any_mes i després per identificador.
SELECT  id_comanda, DATE_FORMAT(data_comanda, '%Y-%m') AS any_mes FROM comandes
ORDER BY any_mes ASC, id_comanda ASC;

-- 15. De productes, mostra l’identificador, el nom, la categoria, el preu i l’estoc aplicant aquesta condició: no siguin de la categoria ‘Roba’ i, a més, preu < 30 o estoc > 30; ordena per categoria i després per preu.
SELECT id_producte, nom, categoria, preu, stock FROM productes
WHERE categoria != 'Roba'
  AND (preu < 30 OR stock > 30)
ORDER BY categoria ASC, preu ASC; 

-- 16. De productes, mostra tots els registres que tenguin preu informat; ensenya l’identificador i el preu. (Nota: el resultat pot incloure tots els productes si no n’hi ha cap amb valor desconegut.)
SELECT id_producte, preu FROM productes
WHERE preu IS NOT NULL;

-- 17. De comandes, calcula per a cada estat el nombre de comandes; mostra l’estat i el recompte; ordena del nombre més gran al més petit.
SELECT estat, COUNT(*) AS nombre_comandes FROM comandes
GROUP BY estat
ORDER BY nombre_comandes DESC;

-- 18. De comandes, calcula l’import mig, el mínim i el màxim agrupant per estat; ordena per estat ascendent.
SELECT  estat, ROUND(AVG(import_total), 2) AS import_mig,MIN(import_total) AS import_min, MAX(import_total) AS import_max
FROM comandes
GROUP BY estat
ORDER BY estat ASC;

-- 19. De comandes, calcula per a cada any-mes (YYYY-MM) el nombre de comandes, la suma d’imports i l’import mitjà arrodonit a 2 decimals; ordena per any-mes ascendent.
SELECT  DATE_FORMAT(data_comanda, '%Y-%m') AS any_mes, COUNT(*) AS nombre_comandes, SUM(import_total) AS suma_import, ROUND(AVG(import_total), 2) AS import_mitja FROM comandes
GROUP BY any_mes
ORDER BY any_mes ASC;

-- 20. De la taula comandes, mostra per a cada estat el nombre de comandes i l’import total acumulat de les comandes realitzades durant l’any 2024. Ordena de més a menys import total.
SELECT  estat, COUNT(*) AS nombre_comandes, SUM(import_total) AS import_total_2024 FROM comandes
WHERE YEAR(data_comanda) = 2024
GROUP BY estat
ORDER BY import_total_2024 DESC;

-- 21. De comandes, mostra l’identificador, la data i l’estat per a les comandes entre ‘2024-06-01’ i ‘2024-07-31’ (inclosos); ordena per data.
SELECT id_comanda, data_comanda, estat FROM comandes
WHERE data_comanda BETWEEN '2024-06-01' AND '2024-07-31 23:59:59'
ORDER BY data_comanda ASC;

-- 22. De clients, mostra els registres on el nom comença per ‘M’ i té exactament 4 lletres; ensenya identificador, nom i cognoms.
SELECT id_client, nom, cognoms FROM clients
WHERE nom LIKE 'M___';

-- 23. De detall_comanda, mostra les 3 línies amb subtotal més alt (on subtotal és quantitat per preu unitari); retorna l’identificador de comanda, el codi de producte, la quantitat, el preu unitari i el subtotal; ordena per subtotal de més alt a més baix i limita a 3 files.
SELECT id_comanda, id_producte,quantitat, preu_unitari, (quantitat * preu_unitari) AS subtotal FROM detall_comanda
ORDER BY subtotal DESC
LIMIT 3;

-- 24. Fes una consulta que retorni una sola fila amb tres columnes: la data actual, l’hora actual i la marca de temps actual.
SELECT  CURDATE() AS data_actual, CURTIME() AS hora_actual, NOW() AS marca_temps_actual;

-- 25. De la taula productes, mostra per a cada categoria el nombre de productes i el preu mitjà, excloent les categories ‘Accessoris’ i ‘Llibres’. Mostra només les categories que tinguin més d’un producte i ordena pel preu mitjà de més alt a més baix.
SELECT categoria, COUNT(*) AS nombre_productes, ROUND(AVG(preu), 2) AS preu_mitja FROM productes
WHERE categoria NOT IN ('Accessoris', 'Llibres')
GROUP BY categoria
HAVING COUNT(*) > 1
ORDER BY preu_mitja DESC;
