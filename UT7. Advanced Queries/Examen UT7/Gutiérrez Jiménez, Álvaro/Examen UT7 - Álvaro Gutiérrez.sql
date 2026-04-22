-- 1.
select s.first_name, s.last_name, a.appointment_date, a.status
from appointments a
inner join doctors d on a.doctor_id = d.doctor_id
inner join staff s on d.doctor_id = s.staff_id;

-- 2.
select concat(p.first_name,' ', p.last_name) as nombre_completo, coalesce(sum(b.amount), 0) as total_facturado
from patients p
left join billing b on p.patient_id = b.patient_id
where year(p.birth_date) < 1990
group by p.patient_id, p.first_name, p.last_name
order by total_facturado desc;


-- 3.
select s.supplier_id, s.name, s.contact_person
from suppliers s
left join orders o on s.supplier_id = o.supplier_id
where o.supplier_id is null
order by s.name;

-- 4.
select 'Cobros' as tipo, sum(amount) as total
from billing
union
select 'Pagos', sum(total_amount)
from orders;


-- 5.
select distinct m.name 
from medications m
where m.medication_id in (
	select pr.medication_id
    from prescriptions pr
)
order by m.name;


-- 6.
select * from lab_results lr
where lr.result_value > any (
    select lt.normal_min
    from lab_tests lt
);


-- 7.
select distinct concat(p.first_name, ' ', p.last_name) as nombre_completo
from patients p
inner join billing b on p.patient_id = b.patient_id
where b.amount < (
    select avg(amount)
    from billing
    where status = 'Paid'
)
order by nombre_completo;

-- 8. 
select num_resultados, count(*) as total_pacientes
from (
	select patient_id, count(*) as num_resultados
    from lab_results
    group by patient_id
) subquery
group by num_resultados;


-- 9
select * from order_items oi
where oi.quantity > (
    select avg(oi2.quantity)
    from order_items oi2
);

-- 10
select tramo, count(*) as total_pacientes
from (
select p.patient_id,
case
	when sum(b.amount) < 100 then 'menos de 100 €'
	when sum(b.amount) between 100 and 500 then 'entre 100 y 500 €'
	else 'más de 500 €'
end as tramo
from patients p
left join billing b on p.patient_id = b.patient_id
group by p.patient_id
) subquery
group by tramo;