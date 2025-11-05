--  1.Mostra l’identificador i el nom complet en una sola columna de tots els clients; ordena pel nom complet de forma ascendent.
SELECT id_client,concat_ws(nom,cognoms) AS nom_complet FROM clients;

-- 2.Llista dels productes amb tres columnes anomenades exactament NOM_PRODUCTE, CATEGORIA i PREU_EUR; ordena pel preu de més alt a més baix i limita el resultat a 5 files.
SELECT nom AS NOM_PRODUCTE,categoria AS CATEORIA , preu AS PREU_EUR FROM productes
ORDER BY preu DESC
LIMIT 5;

-- 3.Mostra els productes amb preu superior a 40; ensenya l’identificador, el nom i el preu; ordena pel preu de forma ascendent.
SELECT id_producte, nom, preu FROM productes
WHERE preu > 40
ORDER BY preu ASC;

-- 4.Mostra els clients el cognom dels quals conté la seqüència de lletres ‘ra’; ordena alfabèticament pel camp de cognoms.
SELECT id_client , cognoms FROM clients
WHERE cognoms LIKE "%RA%";

-- 5.Mostra el nom, la categoria i el preu dels productes amb preu entre 20 i 40 (inclosos); ordena primer pel preu i després pel nom.
SELECT nom, categoria,preu FROM productes
WHERE preu BETWEEN 20 AND 40 
ORDER BY preu AND nom;

-- 6.Mostra l’identificador, el nom i la categoria dels productes la categoria dels quals sigui Electrònica o Llibres; ordena per categoria ascendent i per nom descendent.
SELECT id_producte,nom,categoria FROM productes
WHERE categoria IN("electronica","llibres")
ORDER BY categoria AND nom DESC;

-- 7.Mostra de les comandes l’identificador, la data i l’estat; ordena de la més recent a la més antiga.
SELECT id_comanda, data_comanda, estat FROM comandes
ORDER BY data_comanda DESC;

-- 8.Mostra per a cada línia de detall_comanda l’identificador de comanda, el codi de producte, la quantitat, el preu unitari i una columna addicional
-- amb el subtotal de la línia; ordena per identificador de comanda i després pel codi de producte.
SELECT id_detall,id_producte,quantitat,preu_unitari,(preu_unitari*id_producte) AS subtotal FROM detall_comanda
ORDER BY id_comanda AND id_producte;

-- 9.De productes, mostra l’identificador, el nom en majúscules i la llargada del nom; ordena per la llargada de més gran a més petita
-- i, en cas d’empat, pel nom en majúscules.
SELECT  id_producte,UPPER(nom),LENGTH(nom) FROM productes
ORDER BY UPPER(nom) DESC, LENGTH(nom) DESC;

-- 10.De clients, mostra l’identificador, el nom i els 5 primers caràcters del camp de cognoms amb l’àlies prefix_cognoms; ordena per prefix_cognoms.
 SELECT id_client,nom,SUBSTRING(cognoms,5)AS prefix_cognoms FROM clients
 ORDER BY prefix_cognoms;
 
 -- 11.De productes, mostra l’identificador, el nom, el preu i una columna amb el preu amb un increment del 21%, arrodonit a 2 decimals; 
 -- filtra només els productes amb estoc igual o superior a 10; ordena pel nou preu de més alt a més baix.
SELECT id_producte,nom,preu,round((100/21)*preu,2) AS nou_preu,stock FROM productes
WHERE  stock >= 10
ORDER BY nou_preu;

-- 12.De productes, mostra l’identificador, el nom, el preu i el valor enter del preu; filtra només els productes amb estoc imparell; ordena per estoc de més gran a més petit.
SELECT id_producte,nom,preu,ROUND(preu),stock FROM productes
WHERE MOD(stock,2) = 1
ORDER BY stock DESC;

-- 13.De comandes, mostra l’identificador, la data i les columnes separades d’any, mes, dia i hora obtingudes a partir de la data; ordena per data ascendent.
SELECT id_comanda, data_comanda,YEAR(data_comanda) AS "any",MONTH(data_comanda) AS mes ,DAY(data_comanda) AS dia,HOUR(data_comanda) AS hora FROM comandes 
ORDER BY data_comanda ASC;

-- 14.De comandes, mostra l’identificador i la data formatejada com YYYY-MM en una columna anomenada any_mes; ordena per any_mes i després per identificador.
SELECT id_comanda,CONCAT_WS('-',YEAR(data_comanda), month(data_comanda)) AS any_mes FROM comandes
ORDER BY any_mes AND id_comanda;

-- 15.De productes, mostra l’identificador, el nom, la categoria, el preu i l’estoc aplicant aquesta condició: no siguin de la categoria ‘Roba’
-- i, a més, preu < 30 o estoc > 30; ordena per categoria i després per preu.
SELECT  id_producte, nom, categoria,preu,stock FROM productes
WHERE categoria NOT LIKE "%Roba%"
AND 
(preu < 30 OR stock > 30) 
ORDER BY categoria AND preu;

-- 16.De productes, mostra tots els registres que tenguin preu informat; ensenya l’identificador i el preu. (Nota: el resultat pot incloure tots els productes
-- si no n’hi ha cap amb valor desconegut.)
SELECT id_producte, preu FROM productes
WHERE preu IS NOT NULL;

-- 17.De comandes, calcula per a cada estat el nombre de comandes; mostra l’estat i el recompte; ordena del nombre més gran al més petit.
SELECT estat, SUM(id_comanda)FROM comandes
GROUP BY estat;

-- 18. De comandes, calcula l’import mig, el mínim i el màxim agrupant per estat; ordena per estat ascendent.
SELECT AVG(import_total),MIN(import_total),MAX(import_total),estat FROM comandes
GROUP BY estat
ORDER BY estat ASC;

-- 19.De comandes, calcula per a cada any-mes (YYYY-MM) el nombre de comandes, la suma d’imports i l’import mitjà arrodonit a 2 decimals; ordena per any-mes ascendent.
SELECT CONCAT_WS(YEAR(data_comanda),MONTH(data_comanda)) AS "any_mes", SUM(id_comanda), SUM(import_total),ROUND(AVG(import_total),2) FROM comandes
GROUP BY id_comanda
ORDER BY any_mes ASC;

-- 20.De la taula comandes, mostra per a cada estat el nombre de comandes i l’import total acumulat de les comandes realitzades durant l’any 2024.
--  Ordena de més a menys import total.
SELECT estat,SUM(id_comanda), SUM(import_total) FROM comandes
GROUP BY estat;

-- 21.De comandes, mostra l’identificador, la data i l’estat per a les comandes entre ‘2024-06-01’ i ‘2024-07-31’ (inclosos); ordena per data.
SELECT id_comanda,data_comanda, estat FROM comandes
WHERE data_comanda between "2024-06-01" AND "2024-07-31"
ORDER BY data_comanda ASC;
-- 22.De clients, mostra els registres on el nom comença per ‘M’ i té exactament 4 lletres; ensenya identificador, nom i cognoms.
SELECT id_client,substring(nom,1,4), cognoms FROM clients
WHERE nom LIKE "%M%";

-- 23.De detall_comanda, mostra les 3 línies amb subtotal més alt (on subtotal és quantitat per preu unitari); retorna l’identificador de comanda,
--  el codi de producte, la quantitat, el preu unitari i el subtotal; ordena per subtotal de més alt a més baix i limita a 3 files.
SELECT id_comanda, id_producte,quantitat, preu_unitari, id_comanda*preu_unitari AS "subtotal"  FROM detall_comanda
ORDER BY subtotal DESC
LIMIT 3;

-- 24.Fes una consulta que retorni una sola fila amb tres columnes: la data actual, l’hora actual i la marca de temps actual.
SELECT CONCAT_WS(" ",CURRENT_TIMESTAMP(),CURRENT_DATE(),CURRENT_TIME) FROM detall_comanda;

-- 25.De la taula productes, mostra per a cada categoria el nombre de productes i el preu mitjà, excloent les categories ‘Accessoris’ i ‘Llibres’. 
-- Mostra només les categories que tinguin més d’un producte i ordena pel preu mitjà de més alt a més baix.
SELECT categoria, SUM(stock) AS "num_productes",AVG(preu) AS "mitjana_preu" FROM productes
WHERE categoria NOT LIKE ("%Accesoris%" AND "%Llibres%")
AND stock > 1
GROUP BY categoria 
ORDER BY mitjana_preu DESC;



