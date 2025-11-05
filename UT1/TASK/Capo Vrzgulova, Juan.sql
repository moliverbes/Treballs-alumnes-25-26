-- 1. Mostra l’identificador i el nom complet en una sola columna de tots els clients; ordena pel nom complet de forma ascendent.
SELECT id_client, CONCAT_WS(' ', nom, cognoms) AS 'NOM_COMPLET'
FROM clients
ORDER BY NOM_COMPLET ASC;

-- 2. Llista dels productes amb tres columnes anomenades exactament NOM_PRODUCTE, CATEGORIA i PREU_EUR; 
-- ordena pel preu de més alt a més baix i limita el resultat a 5 files.
SELECT nom AS 'NOM_PRODUCTE', 
categoria AS 'CATEGORIA',
preu AS 'PREU_EUR'
FROM productes
ORDER BY preu DESC
LIMIT 5;

-- 3. Mostra els productes amb preu superior a 40; ensenya l’identificador, el nom i el preu; ordena pel preu de forma ascendent.
SELECT id_producte, nom, preu
FROM productes
WHERE preu > 40
ORDER BY preu ASC;

-- 4. Mostra els clients el cognom dels quals conté la seqüència de lletres ‘ra’; ordena alfabèticament pel camp de cognoms.
SELECT id_client, cognoms
FROM clients
WHERE cognoms LIKE '%ra%'
ORDER BY  cognoms ASC;

-- 5. Mostra el nom, la categoria i el preu dels productes amb preu entre 20 i 40 (inclosos); ordena primer pel preu i després pel nom.
SELECT nom, categoria, preu
FROM productes
WHERE preu BETWEEN 20 AND 40
ORDER BY preu, nom;

-- 6. Mostra l’identificador, el nom i la categoria dels productes la categoria dels quals sigui Electrònica o Llibres; 
-- ordena per categoria ascendent i per nom descendent.
SELECT id_producte, nom, categoria
FROM productes
WHERE categoria IN ('Electrònica', 'Llibres')
ORDER BY categoria ASC, nom DESC;

-- 7. Mostra de les comandes l’identificador, la data i l’estat; ordena de la més recent a la més antiga.
SELECT id_comanda, data_comanda, estat
FROM comandes
ORDER BY data_comanda DESC;

-- 8. Mostra per a cada línia de detall_comanda l’identificador de comanda, el codi de producte, 
-- la quantitat, el preu unitari i una columna addicional amb el subtotal de la línia; ordena per identificador de comanda i després pel codi de producte.
SELECT id_comanda, id_producte, quantitat, preu_unitari, quantitat * preu_unitari AS 'SUBTOTAL'
FROM detall_comanda
ORDER BY id_comanda, id_producte;

-- 9. De productes, mostra l’identificador, el nom en majúscules i la llargada del nom; ordena per la llargada de més gran a més petita i,
-- en cas d’empat, pel nom en majúscules.
SELECT id_producte, UPPER(nom) AS 'NOM', length(nom) AS 'LLARGADA NOM'
FROM productes
ORDER BY length(nom) DESC, UPPER(nom);

-- 10. De clients, mostra l’identificador, el nom i els 5 primers caràcters del camp de cognoms amb l’àlies prefix_cognoms; ordena per prefix_cognoms.
SELECT id_client, SUBSTRING(cognoms,1,5) AS 'PREFIX_COGNOMS'
FROM clients
ORDER BY PREFIX_COGNOMS;

-- 11. De productes, mostra l’identificador, el nom, el preu i una columna amb el preu amb un increment del 21%, 
-- arrodonit a 2 decimals; filtra només els productes amb estoc igual o superior a 10; ordena pel nou preu de més alt a més baix.
SELECT id_producte, nom, ROUND(preu * 0.21 + preu,2) AS 'PREU AMB INCREMENT 21%'
FROM productes
WHERE stock >= 10
ORDER BY preu DESC;

-- 12. De productes, mostra l’identificador, el nom, el preu i el valor enter del preu; filtra només els productes amb estoc imparell; 
-- ordena per estoc de més gran a més petit.
SELECT id_producte, nom, preu, stock, ROUND(preu)
FROM productes
WHERE MOD(stock, 2) <> 0
ORDER BY stock DESC;

-- 13. De comandes, mostra l’identificador, la data i les columnes separades d’any, mes, dia i hora obtingudes a partir de la data; ordena per data ascendent.
SELECT id_comanda, data_comanda, year(data_comanda) AS 'ANY', month(data_comanda) AS 'MES', day(data_comanda) AS 'DIA', hour(data_comanda) AS 'HORA'
FROM comandes
ORDER BY data_comanda ASC;

-- 14. De comandes, mostra l’identificador i la data formatejada com YYYY-MM en una columna anomenada any_mes; ordena per any_mes i després per identificador.
SELECT id_comanda, date_format(data_comanda, '%Y-%m') AS 'any_mes'
from comandes
ORDER BY any_mes, id_comanda;


-- 15. De productes, mostra l’identificador, el nom, la categoria, el preu i l’estoc aplicant aquesta condició: no siguin de la categoria ‘Roba’ i, 
-- a més, preu < 30 o estoc > 30; ordena per categoria i després per preu.
SELECT id_producte, nom, categoria, preu, stock
FROM productes
WHERE categoria NOT LIKE 'roba' AND preu < 30 OR stock > 30
ORDER BY categoria, preu;

-- 16. De productes, mostra tots els registres que tenguin preu informat;ensenya l’identificador i el preu. (Nota: el resultat pot incloure tots els
-- productes si no n’hi ha cap amb valor desconegut.)
SELECT id_producte, preu
FROM productes
WHERE preu IS NOT NULL;

-- 17.De comandes, calcula per a cada estat el nombre de comandes; mostra
-- l’estat i el recompte; ordena del nombre més gran al més petit.
SELECT estat, count(id_comanda) AS 'RECOMPTE'
FROM comandes
GROUP BY estat
ORDER BY recompte desc;

-- 18.De comandes, calcula l’import mig, el mínim i el màxim agrupant per
-- estat; ordena per estat ascendent.
SELECT estat, avg(import_total) AS 'MITJANA', MIN(import_total), MAX(import_total)
FROM comandes
GROUP BY estat
ORDER BY estat ASC;

-- 19.De comandes, calcula per a cada any-mes (YYYY-MM) el nombre de comandes, la suma d’imports i l’import mitjà arrodonit a 2 decimals; ordena per any-mes ascendent.
SELECT date_format(data_comanda, "%Y-%m") AS 'ANY_MES', 
count(id_comanda) AS 'SUMA_COMANDES', 
SUM(import_total) AS 'SUMA_IMPORTS', 
ROUND(AVG(import_total),2) AS 'MITJA'
FROM comandes
GROUP BY ANY_MES
ORDER BY ANY_MES ASC;

-- 20.De la taula comandes, mostra per a cada estat el nombre de comandes i l’import total acumulat de les comandes realitzades durant l’any 2024.
-- Ordena de més a menys import total.
SELECT estat, 
count(id_comanda) AS 'SUMA_COMANDES',
SUM(import_total) AS 'SUMA_IMPORTS'
FROM comandes
WHERE YEAR(data_comanda) = 2024
GROUP BY estat
ORDER BY SUMA_IMPORTS DESC;

-- 21. De comandes, mostra l’identificador, la data i l’estat per a les comandes entre ‘2024-06-01’ i ‘2024-07-31’ (inclosos); ordena per data.
SELECT id_comanda, data_comanda, estat
FROM comandes
WHERE data_comanda BETWEEN '2024-06-01' AND '2024-07-31'
ORDER BY data_comanda;

-- 22. De clients, mostra els registres on el nom comença per ‘M’ i té exactament 4 lletres; ensenya identificador, nom i cognoms.
SELECT id_client, nom, cognoms
FROM clients 
WHERE nom LIKE 'M___';

-- 23. De detall_comanda, mostra les 3 línies amb subtotal més alt (on subtotal és quantitat per preu unitari); retorna l’identificador de comanda, el codi
-- de producte, la quantitat, el preu unitari i el subtotal; ordena per subtotal de més alt a més baix i limita a 3 files.
SELECT id_comanda, id_producte, quantitat, preu_unitari, quantitat*preu_unitari AS 'SUBTOTAL'
FROM detall_comanda
ORDER BY SUBTOTAL DESC
LIMIT 3;

-- 24. Fes una consulta que retorni una sola fila amb tres columnes: la data actual, l’hora actual i la marca de temps actual.
SELECT current_date, current_time, now() AS 'TEMPS_ACTUAL'
LIMIT 1;

-- 25. De la taula productes, mostra per a cada categoria el nombre de productes i el preu mitjà, excloent les categories ‘Accessoris’ i ‘Llibres’.
-- Mostra només les categories que tinguin més d’un producte i ordena pel preu mitjà de més alt a més baix.
SELECT categoria, COUNT(id_producte) AS 'SUMA_PRODUCTES', AVG(preu) AS 'MITJA_PREU'
FROM productes
WHERE categoria NOT IN ('Accessoris','Llibres')
GROUP BY categoria
HAVING SUMA_PRODUCTES > 1
ORDER BY MITJA_PREU DESC;
