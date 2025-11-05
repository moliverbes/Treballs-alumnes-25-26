-- 1 Mostra l’identificador i el nom complet en una sola columna de tots els clients; ordena pel nom complet de forma ascendent.

select id_client, concat_ws(' ', nom, cognoms) as 'nom_complet'
from clients
order by nom_complet asc;

-- 2 Llista dels productes amb tres columnes anomenades exactament NOM_PRODUCTE, CATEGORIA i PREU_EUR; 
-- ordena pel preu de més alt a més baix i limita el resultat a 5 files.

select  nom as 'Nom_Producte' , categoria, preu as 'Preu_EUR'
from productes 
order by preu_EUR DESC
limit 5;

-- 3 Mostra els productes amb preu superior a 40; ensenya l’identificador, el nom i el preu; ordena pel preu de forma ascendent.

select id_producte, nom, preu
from productes
where preu > 40
order by preu asc;

-- 4 Mostra els clients el cognom dels quals conté la seqüència de lletres ‘ra’; ordena alfabèticament pel camp de cognoms.

select id_client, cognoms 
from clients
where cognoms like '%ra%'
order by cognoms asc;

-- 5 Mostra el nom, la categoria i el preu dels productes amb preu entre 20 i 40 (inclosos); ordena primer pel preu i després pel nom.

select nom, categoria, preu 
from productes 
where preu between 20 and 40 
order by preu and nom;

-- 6 Mostra l’identificador, el nom i la categoria dels productes la categoria dels quals sigui Electrònica o Llibres; 
-- ordena per categoria ascendent i per nom descendent.

select id_producte, nom, categoria 
from productes
where categoria in ('electronica' , 'llibres')
order by categoria asc,  nom desc;

-- 7 Mostra de les comandes l’identificador, la data i l’estat; ordena de la més recent a la més antiga.

select id_comanda, data_comanda, estat 
from comandes
order by data_comanda desc;

-- 8 Mostra per a cada línia de detall_comanda l’identificador de comanda, 
-- el codi de producte, la quantitat, el preu unitari i una columna addicional amb el subtotal de la línia; ordena per identificador de comanda i després pel codi de producte.

select id_comanda, id_producte, quantitat * preu_unitari as 'subtotal'
from detall_comanda
order by id_comanda, id_producte;

-- 9 De productes, mostra l’identificador, el nom en majúscules i la llargada del nom;
-- ordena per la llargada de més gran a més petita i, en cas d’empat, pel nom en majúscules.

select id_producte, upper(nom), length(nom) as 'llargada nom'
from productes
order by length(nom) desc, upper(nom);

-- 10 De clients, mostra l’identificador, el nom i els 5 primers caràcters del camp de cognoms amb l’àlies prefix_cognoms; ordena per prefix_cognoms.

select id_client, substring(cognoms,1,5) as 'prefixc_cognoms'
from clients
order by prefix_cognoms;

-- 11 De productes, mostra l’identificador, el nom, el preu i una columna amb el preu amb un increment del 21%, arrodonit a 2 decimals; 
-- filtra només els productes amb estoc igual o superior a 10; ordena pel nou preu de més alt a més baix.

select id_producte, nom, round(preu * 0.21) + preu as 'preu amb increment 21%'
from productes
where stock >= 10
order by preu desc;

-- 12 De productes, mostra l’identificador, el nom, el preu i el valor enter del preu; 
-- filtra només els productes amb estoc imparell; ordena per estoc de més gran a més petit.

select id_producte, nom,stock, preu, round(preu)
from productes
where mod(stock, 2) <> 0
order by stock desc;

-- 13 De comandes, mostra l’identificador, la data i les columnes separades d’any, mes, dia i hora obtingudes a partir de la data; 
-- ordena per data ascendent.

select id_comanda, data_comanda, year(data_comanda)as'Any', month(data_comanda)as 'Mes', day(data_comanda)as 'Dia', hour(data_comanda) as 'Hora'
from comandes
order by data_comanda asc;

-- 14 De comandes, mostra l’identificador i la data formatejada com YYYY-MM en una columna anomenada any_mes; 
-- ordena per any_mes i després per identificador.

select id_comanda, date_format(data_comanda,'%Y-%m') as ' Any_mes'
from comandes
order by any_mes, id_comanda;


-- 15 De productes, mostra l’identificador, el nom, la categoria, el preu i l’estoc 
-- aplicant aquesta condició: no siguin de la categoria ‘Roba’ i, a més, preu < 30 o estoc > 30; ordena per categoria i després per preu.

select id_producte, nom, categoria, preu, stock
from productes
where categoria not like 'roba' and preu < 30 or stock > 30
order by categoria, preu;

-- 16 De productes, mostra tots els registres que tenguin preu informat; ensenya l’identificador i el preu. 
-- (Nota: el resultat pot incloure tots els productes si no n’hi ha cap amb valor desconegut.)

select id_producte, preu
from productes
where preu is not null;

-- 17 De comandes, calcula per a cada estat el nombre de comandes; 
-- mostra l’estat i el recompte; ordena del nombre més gran al més petit.

select estat, count(is_comanda) as 'recompte'
from comandes
group by estat
order by recompte desc;

-- 18  De comandes, 
-- calcula l’import mig, el mínim i el màxim agrupant per estat; 
-- ordena per estat ascendent.

select estat, avg (import_total) as 'import_mig', max(import_total) as 'import_maxim', min(import_total) as 'import_minim'
from comandes 
group by estat
order by estat asc;

-- 19 De comandes, calcula per a cada any-mes (YYYY-MM) el nombre de comandes, 
-- la suma d’imports i l’import mitjà arrodonit a 2 decimals; 
-- ordena per any-mes ascendent.

select date_format(data_comanda, "%Y-%m") as 'any_mes',
count(id_comanda) as 'nombre_comandes', sum(import_total) as 'suma_imports', round(avg(import_total),2) as 'import mitjà'
from comandes 
group by any_mes
order by any_mes asc;


-- 20 De la taula comandes, 
-- mostra per a cada estat el nombre de comandes i l’import total acumulat de les comandes realitzades durant l’any 2024. 
-- Ordena de més a menys import total.

select estat, count(id_comanda) as 'nombre_comandes',
sum(import_total) as 'import_acumulat'
from comandes
where data_comanda LIKE "2024%"
group by estat
order by import_acumulat desc;

-- 21 De comandes, mostra l’identificador, la data i l’estat per a les comandes entre ‘2024-06-01’ i ‘2024-07-31’ (inclosos);
-- ordena per data.

select id_comanda, data_comanda, estat
from comandes
where data_comanda between "2024-06-01" and "2024-07-31"
order by data_comanda;

-- 22 De clients, mostra els registres on el nom comença per ‘M’ i té exactament 4 lletres; 
-- ensenya identificador, nom i cognoms.

select id_client, nom, cognom
from clients
where nom like "M___";


-- 23  De detall_comanda, mostra les 3 línies amb subtotal més alt (on subtotal és quantitat per preu unitari); 
-- retorna l’identificador de comanda, el codi de producte, la quantitat, el preu unitari i el subtotal;
-- ordena per subtotal de més alt a més baix i limita a 3 files

select id_comanda, id_producte, quantitat, preu unitari, quantitat*preu_unitari as 'subtotal'
from detall_comanda
order by subtotal desc
limit 3;

-- 24 Fes una consulta que retorni una sola fila amb tres columnes: la data actual, l’hora actual i la marca de temps actual.

select current_date, current_time, now();

-- 25  De la taula productes, 
-- mostra per a cada categoria el nombre de productes i el preu mitjà, 
-- excloent les categories ‘Accessoris’ i ‘Llibres’. 
-- Mostra només les categories que tinguin més d’un producte i 
-- ordena pel preu mitjà de més alt a més baix.

select categoria, count(id_producte) as 'nombre_productes', avg(preu) as 'preu_mitja'
from productes 
where categoria not in ("accesoris", "llibres")
group by categoria
having nombre_productes > 1
order by preu_mitja desc;



