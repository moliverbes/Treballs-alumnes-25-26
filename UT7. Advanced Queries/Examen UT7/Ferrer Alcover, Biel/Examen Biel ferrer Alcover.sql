
-- 1
select s.first_name, s.last_name, a.appointment_date, a.status from staff s
join doctors d on doctor_id = staff_id
join appointments a using (doctor_id);

-- 2
-- select CONCAT_WS(first_name, last_name), sum(amount) as total from patients
-- join billing using (patient_id)
-- order by total asc;

-- 3
select supplier_id, name , contact_person from suppliers
left join orders using (supplier_id)
where order_id is null
order by name;

/* 4 Mostra en dues files :
   - el total d’imports facturats (billing)
   - el total d’imports de comandes (orders)
Mostra també a cada vila una columna que indiqui el tipus (“Cobros” o “Pagaments”).*/
select sum(amount) as Cobros from billing
union
select  sum(total_amount) as Pagaments from orders ;

-- 5------------------------------
-- select name from medications
-- left join prescriptions using (medication_id) 
-- where medication_id is not null  =(
-- select prescription_id from prescriptions
-- where medication_id is not null);


-- 6
select * from lab_results
where result_value >(
select avg(normal_min) from lab_tests);

-- 7
select CONCAT_WS(first_name, last_name)  from patients
join billing using (patient_id)
where amount < (
select avg(amount) from billing)
order by first_name;


-- 8
-- select  count(result_id) from patients
-- where patient_id =(
-- select count);

-- 9 
select * from order_items c1
where c1.quantity > (
select avg(c2.quantity) from order_items c2
where c1.quantity = c2.quantity );

-- 10
select
 case
when  total < 100  then 'Menys de 100 €'
when total between 100 and 500 then 'Entre 100 i 500 €'
else  'Més de 500 €'
end as tram , count(*) 
from(
select patient_id, sum(amount) as total from patients  
join billing using(patient_id)
group by patient_id
) as r
group by tram;

