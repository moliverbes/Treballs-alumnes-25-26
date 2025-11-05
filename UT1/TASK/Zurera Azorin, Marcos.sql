-- 1 Mostra l’identificador i el nom complet en una sola columna de tots els clients; ordena pel nom complet de forma ascendent.
Select UPPER( CONCAT(nom,' ', cognoms)) as 'Nombre_completo', id_client From clients
Order by Nombre_completo asc;

-- 2 Llista dels productes amb tres columnes anomenades exactament NOM_PRODUCTE, CATEGORIA i PREU_EUR;
-- ordena pel preu de més alt a més baix i limita el resultat a 5 files.
Select nom as 'NOM_PRODUCTE', categoria, preu as 'PREU_EUR' From productes
Order by PREU_EUR DESC
limit 5;

-- 3 Mostra els productes amb preu superior a 40; ensenya l’identificador, el nom i el preu; ordena pel preu de forma ascendent.
Select id_producte, preu FROM productes
Where preu > 40
Order by preu asc;

-- 4 Mostra els clients el cognom dels quals conté la seqüència de lletres ‘ra’; ordena alfabèticament pel camp de cognoms.
Select nom, cognoms FROM clients
Where cognoms like '%ra%'
Order by cognoms;

-- 5 Mostra el nom, la categoria i el preu dels productes amb preu entre 20 i 40 (inclosos); 
-- ordena primer pel preu i després pel nom.
Select preu, nom, categoria FROM productes
Where preu between 20 and 40;

-- 6 Mostra l’identificador, el nom i la categoria dels productes la categoria dels quals sigui Electrònica o Llibres; 
-- ordena per categoria ascendent i per nom descendent.

Select id_producte, nom, categoria FROM productes
Where categoria = 'Electrònica' or categoria = 'Llibres'
Order by categoria asc, nom desc;

-- 7 Mostra de les comandes l’identificador, la data i l’estat; ordena de la més recent a la més antiga.
Select id_comanda, data_comanda, estat From comandes
Order by data_comanda desc;

-- 8 Mostra per a cada línia de detall_comanda l’identificador de comanda, el codi de producte, 
-- la quantitat, el preu unitari i una columna addicional amb el subtotal de la línia; 
-- ordena per identificador de comanda i després pel codi de producte.
Select id_detall, id_comanda, id_producte, quantitat, (quantitat * preu_unitari) as 'subtotal' From detall_comanda
Order by id_comanda, id_producte;

-- 9 De productes, mostra l’identificador, el nom en majúscules i la llargada del nom; ordena per la llargada 
-- de més gran a més petita i, en cas d’empat, pel nom en majúscules.
Select id_producte, UPPER(nom) as 'Npm_mayus', length(nom) as 'llargada_nom' From productes
Order by llargada_nom asc;

-- 10 De clients, mostra l’identificador, el nom i els 5 primers caràcters del camp de cognoms amb
-- l’àlies prefix_cognoms; ordena per prefix_cognoms.
Select id_client, nom, substring(cognoms,1,5) as 'prefix_cognoms' From clients
Order by prefix_cognoms;

-- 11 De productes, mostra l’identificador, el nom, el preu i una columna amb el 
-- preu amb un increment del 21%, arrodonit a 2 decimals; filtra només els productes 
-- amb estoc igual o superior a 10; ordena pel nou preu de més alt a més baix.
Select id_producte, nom, preu, Round(preu * 1.21, 2) From productes
Where stock >= 10
Order by preu desc;


-- 12 De productes, mostra l’identificador, el nom, el preu i el valor enter del preu; 
-- filtra només els productes amb estoc imparell; ordena per estoc de més gran a més petit.
Select id_producte, nom, preu, Round(preu,0) as 'valor_enter', stock From productes
Where stock % 2 <> 0
Order by stock desc;

-- 13 De comandes, mostra l’identificador, la data i les columnes separades d’any, mes, 
-- dia i hora obtingudes a partir de la data; ordena per data ascendent.
Select id_comanda, data_comanda, Year(data_comanda) as 'any_comanda', Month(data_comanda) as 'mes_comanda', 
Day(data_comanda) as 'dia_comanda', Hour(data_comanda) as 'hora_comanda'
From comandes
Order by data_comanda;

-- 14 De comandes, mostra l’identificador i la data formatejada com YYYY-MM en una columna anomenada 
-- any_mes; ordena per any_mes i després per identificador.
Select id_comanda, Date_format( data_comanda, '%Y-%m') as 'any_mes' From comandes
Order by any_mes, id_comanda;

-- 15 De productes, mostra l’identificador, el nom, la categoria, el preu i l’estoc aplicant aquesta condició:
-- no siguin de la categoria ‘Roba’ i, a més, preu < 30 o estoc > 30; ordena per categoria i després per preu.
Select id_producte, nom, categoria, preu, stock From productes
Where categoria not like 'Roba' and (preu < 30 or stock > 30)
Order by categoria, preu;

-- 16 De productes, mostra tots els registres que tenguin preu informat; ensenya l’identificador i el preu. 
-- (Nota: el resultat pot incloure tots els productes si no n’hi ha cap amb valor desconegut.)
Select preu, id_producte From Productes
Where preu is not null;

-- 17 De comandes, calcula per a cada estat el nombre de comandes; mostra l’estat i el recompte; 
-- ordena del nombre més gran al més petit.
SELECT estat, COUNT(*) AS nombre_comandes FROM comandes
GROUP BY estat
ORDER BY nombre_comandes DESC;

-- 18 De comandes, calcula l’import mig, el mínim i el màxim agrupant per estat; ordena per estat ascendent.
Select estat, AVG(import_total) as 'mig_import', Min(import_total) as 'minim_import', Max(import_total) as 'maxim_import'
From comandes 
Group by estat
order by estat;

-- 19 De comandes, calcula per a cada any-mes (YYYY-MM) el nombre de comandes, la suma d’imports i 
-- l’import mitjà arrodonit a 2 decimals; ordena per any-mes ascendent.
Select Date_format( data_comanda, '%Y-%m') as 'Año_mes', COUNT(id_comanda) as 'Nombre_comandes', 
SUM(import_total) as 'Suma_imports', ROUND(AVG(import_total), 2) as 'import_mitja'
From comandes 
Group by Año_mes
Order by Año_mes;

-- 20 De la taula comandes, mostra per a cada estat el nombre de comandes i l’import total acumulat de les 
-- comandes realitzades durant l’any 2024. Ordena de més a menys import total.
Select estat, Count(id_comanda) as 'nombre_comandes', Sum(import_total) as 'Import_acumulat' From comandes
Where Year(data_comanda) = 2024
Group by estat
Order by Import_acumulat;

-- 21 De comandes, mostra l’identificador, la data i l’estat per a les comandes entre ‘2024-06-01’ i 
-- ‘2024-07-31’ (inclosos); ordena per data.

Select id_comanda, data_comanda, estat From comandes
Where data_comanda between '2024-06-01' and '2024-07-31'
Order by data_comanda ASC;

-- 22 De clients, mostra els registres on el nom comença per ‘M’ i té exactament 4 lletres; 
-- ensenya identificador, nom i cognoms.
Select id_client, nom, cognoms From clients
Where nom like 'M%' and nom like '____';

-- 23 De detall_comanda, mostra les 3 línies amb subtotal més alt (on subtotal és quantitat per preu unitari); 
-- retorna l’identificador de comanda, el codi de producte, la quantitat, el preu unitari i el subtotal; 
-- ordena per subtotal de més alt a més baix i limita a 3 files.
Select id_comanda, quantitat, preu_unitari, id_detall, (quantitat * preu_unitari) as 'subtotal'
From detall_comanda
Order by subtotal
limit 3;

-- 24 Fes una consulta que retorni una sola fila amb tres columnes: la data actual, l’hora actual i la 
-- marca de temps actual.
Select current_date() as 'Data_actual', current_time() as 'Hora_actual', Now() as 'Marca_temps_actual';

-- 25 De la taula productes, mostra per a cada categoria el nombre de productes i el preu mitjà, 
-- excloent les categories ‘Accessoris’ i ‘Llibres’. Mostra només les categories que tinguin més d’un producte
-- i ordena pel preu mitjà de més alt a més baix.
Select categoria, count(id_producte) as 'Nombre_productes', avg(preu) as 'Mitjana' From productes
Where categoria not in ('Accessoris', 'Llibres')
Group by categoria
Having Nombre_productes > 1
Order by Mitjana desc; 


