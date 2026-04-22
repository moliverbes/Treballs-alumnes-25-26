-- 1

select first_name, last_name, appointment_date, status 
from staff
join doctors on staff_id = doctor_id
join appointments using (doctor_id);


-- 2

select concat_ws (' ', first_name, last_name) as nom_complet,
SUM(amount) as total_facturat
from patients
left join billing using (patient_id)
where year (birth_date) < 1990
group by patient_id
order by total_facturat desc;

-- 3

select supplier_id, name, contact_person
from suppliers s 
left join orders o using(supplier_id)
where o.supplier_id is null
order by name;


-- 4 

select sum(amount) as total, 'Cobros' as tipus
from billing
union 
select sum(total_amount) as total, 'Pagaments' as tipus
from orders;

-- 5 

select name
from medications 
where medication_id in (
select medication_id from prescriptions
join consultations using (consultation_id)
order by name asc);

-- 6 

select * from lab_results 
where result_value > any (
select normal_min from lab_tests
);

-- 7 
-- El distinct l'he posat ja que es repeteixen alguns noms.

select distinct concat_ws(' ', first_name, last_name) as nom_complet
from patients 
join billing using(patient_id)
where amount < (
select avg(amount) from billing)
order by nom_complet;

-- 8 

select total_resultats, count(*) as total_pacients 
from (
select patient_id,
count(*) as total_resultats
from lab_results
group by patient_id) as subquery
group by total_resultats;

-- 9 

select * 
from order_items o1
where quantity > (
select avg(quantity) from order_items o2
where o1.medication_id = o2.medication_id);


-- 10 

select 
case 
when despesa_total < 100 then 'Menys de 100€'
when despesa_total between 100 and 500 then 'Entre 100 i 500€'
else 'Més de 500€' 
end as tram_despesa
