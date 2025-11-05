-- 1.Mostra l’identificador i el nom complet en una sola columna de tots els clients; ordena pel nom complet de forma ascendent.
SELECT id_client, CONCAT(nom, ' ', cognoms) AS 'nom complet' FROM clients
order by 'nom complet' asc;

-- 2 Llista dels productes amb tres columnes anomenades exactament NOM_PRODUCTE, CATEGORIA i PREU_EUR
	-- ordena pel preu de més alt a més baix i limita el resultat a 5 files.
SELECT nom AS NOM_PRODUCTE, categoria AS CATEGORIA, ROUND(preu, 2) AS PREU_EUR FROM productes
order by PREU_EUR
LIMIT 5;

-- 3. Mostra els productes amb preu superior a 40
	-- ensenya l’identificador, el nom i el preu
    -- ordena pel preu de forma ascendent.
SELECT id_producte, nom, ROUND(preu, 2) FROM productes
where preu > 40
order by preu asc;

-- 4. Mostra els clients el cognom dels quals conté la seqüència de lletres ‘ra’
	-- ordena alfabèticament pel camp de cognoms.
select concat(nom, ' ', cognoms) AS nom_client FROM clients
where cognoms LIKE '%ra%';

-- 5. Mostra el nom, la categoria i el preu dels productes amb preu entre 20 i 40 (inclosos); 
	-- ordena primer pel preu i després pel nom.
SELECT nom AS nom_producte, preu AS preu_producte FROM productes
where preu between 19 and 41
order by preu, nom;

-- 6. Mostra l’identificador, el nom i la categoria dels productes la categoria dels quals sigui Electrònica o Llibres;
	-- ordena per categoria ascendent i per nom descendent.
select id_producte, nom, categoria from productes
where categoria like 'Electrònica' or 'Llibres'
ORDER BY categoria ASC, nom desc;

-- 7. Mostra de les comandes l’identificador, la data i l’estat; ordena de la més recent a la més antiga.
SELECT id_comanda, data_comanda AS 'Data', estat FROM comandes
order by data_comanda desc;

-- 8. Mostra per a cada línia de detall_comanda l’identificador de comanda, 
	-- el codi de producte, la quantitat, el preu unitari i una columna addicional amb el subtotal de la línia
    -- ordena per identificador de comanda i després pel codi de producte.
SELECT  id_comanda AS 'Identificador de comanda', id_producte AS 'codi producte', 
	quantitat ,ROUND(preu_unitari, 2), ROUND(SUM(preu_unitari), 2) AS 'Subtotal'
	FROM detall_comanda
group by id_comanda, id_producte
order by id_comanda, id_producte;

-- 9. De productes, mostra l’identificador, el nom en majúscules i la llargada del nom;
	-- ordena per la llargada de més gran a més petita i, en cas d’empat, pel nom en majúscules.
SELECT id_producte, UPPER(nom), LENGTH(nom) AS 'llargada del nom' FROM productes
order by length(nom) DESC, UPPER(nom) desc;

-- 10. De clients, mostra l’identificador, el nom i els 5 primers caràcters del camp de cognoms amb l’àlies prefix_cognoms;
--  ordena per prefix_cognoms
SELECT id_client, nom, SUBSTRING(cognoms, 1, 5) AS prefix_cognoms FROM clients
ORDER BY prefix_cognoms;

-- 11. De productes, mostra l’identificador, el nom, 
	-- el preu i una columna amb el preu amb un increment del 21%, arrodonit a 2 decimals; 
    -- filtra només els productes amb estoc igual o superior a 10; ordena pel nou preu de més alt a més baix.
SELECT id_producte, nom, preu, stock, ROUND(preu*1.21,2) AS preu_incrementat FROM productes
WHERE stock >= 10
ORDER BY preu_incrementat desc;

-- 12. De productes, mostra l’identificador, el nom, el preu i el valor enter del preu;
	-- filtra només els productes amb estoc imparell; ordena per estoc de més gran a més petit.
SELECT id_producte, nom, stock, FLOOR(preu) AS 'valor enter' FROM productes
where MOD(stock, 2) <> 0
ORDER BY stock desc;

-- 13.De comandes, mostra l’identificador, la data i les columnes separades d’any, mes, dia i hora obtingudes a partir de la data;
	-- ordena per data ascendent.
SELECT id_comanda, data_comanda AS data, DATE_FORMAT(data_comanda, '%Y') AS any, DATE_FORMAT(data_comanda, '%m') AS mes,
	DATE_FORMAT(data_comanda, '%d') AS dia, DATE_FORMAT(data_comanda, '%H') AS hora
FROM comandes
order by data asc;

-- 14. De comandes, mostra l’identificador i la data formatejada com YYYY-MM en una columna anomenada any_mes;
-- ordena per any_mes i després per identificador.
SELECT id_comanda, DATE_FORMAT(data_comanda, '%Y-%m') AS any_mes FROM comandes
ORDER BY any_mes, id_comanda;

-- 15. De productes, mostra l’identificador, el nom, la categoria, el preu i l’estoc 
	-- aplicant aquesta condició: no siguin de la categoria ‘Roba’ i, a més, preu < 30 o estoc > 30;
		-- ordena per categoria i després per preu.
SELECT  id_producte, nom, categoria, round(preu), stock FROM productes
	WHERE categoria not like 'Roba'
		AND preu < 30 OR stock > 30;
-- 16.De productes, mostra tots els registres que tenguin preu informat; 
	-- ensenya l’identificador i el preu. (Nota: el resultat pot incloure tots els productes si no n’hi ha cap amb valor desconegut.)
SELECT preu, id_producte FROM productes
where preu IS NOT NULL; -- no es correcte ?

-- 17.De comandes, calcula per a cada estat el nombre de comandes;
	-- mostra l’estat i el recompte; ordena del nombre més gran al més petit.
SELECT COUNT(id_comanda) AS recompte_comandes, estat FROM comandes
group by estat 
order by recompte_comandes desc;

-- 18 De comandes, calcula l’import mig, el mínim i el màxim agrupant per estat;
	-- ordena per estat ascendent.
SELECT estat, AVG(import_total) AS import_mig, MAX(import_total) AS maxim_import, MIN(import_total) AS minim_import FROM comandes
group by estat
order by estat asc;

-- 19. De comandes, calcula per a cada any-mes (YYYY-MM) el nombre de comandes,
	-- la suma d’imports i l’import mitjà arrodonit a 2 decimals; 
	-- ordena per any-mes ascendent.
SELECT DATE_FORMAT(data_comanda, '%Y-%m') AS any_mes, ROUND(SUM(import_total)) AS suma_imports, ROUND(AVG(import_total)) AS import_mitja from comandes
group by any_mes
ORDER BY any_mes ASC;

-- 20.De la taula comandes, mostra per a cada estat el nombre de comandes i l’import total acumulat de les comandes realitzades durant l’any 2024.
	-- Ordena de més a menys import total.
SELECT estat, count(id_comanda), import_total, data_comanda FROM comandes
WHERE data_comanda LIKE '2024-%'
GROUP BY estat, data_comanda, import_total
 ORDER BY import_total DESC;
 
 -- 21. De comandes, mostra l’identificador, la data i l’estat per a les comandes entre ‘2024-06-01’ i ‘2024-07-31’ (inclosos); ordena per data.
	SELECT id_comanda, data_comanda, estat FROM comandes
    WHERE data_comanda BETWEEN '2024-06-01' AND '2024-07-31'
    ORDER BY data_comanda;
    
-- 22. De clients, mostra els registres on el nom comença per ‘M’ i té exactament 4 lletres;
	-- ensenya identificador, nom i cognoms.
SELECT id_client, nom, cognoms FROM clients
where nom like 'M%' and length(nom) = 4;

-- 23. De detall_comanda, mostra les 3 línies amb subtotal més alt (on subtotal és quantitat per preu unitari); 
	-- retorna l’identificador de comanda, el codi de producte, la quantitat, el preu unitari i el subtotal;
    -- ordena per subtotal de més alt a més baix i limita a 3 files.
    SELECT id_comanda, id_producte, quantitat, preu_unitari, (quantitat * preu_unitari) AS subtotal FROM detall_comanda
    order by subtotal desc
    LIMIT 3;
    
-- 24. Fes una consulta que retorni una sola fila amb tres columnes: la data actual, l’hora actual i la marca de temps actual.
SELECT current_date(), current_time(), current_timestamp();

-- 25 De la taula productes, mostra per a cada categoria el nombre de productes i el preu mitjà, excloent les categories ‘Accessoris’ i ‘Llibres’. 
	-- Mostra només les categories que tinguin més d’un producte i ordena pel preu mitjà de més alt a més baix.
SELECT categoria, stock, AVG(preu) AS preu_mitja FROM productes
WHERE categoria NOT LIKE 'Llibres'  'Accessoris')
group by  stock, categoria




