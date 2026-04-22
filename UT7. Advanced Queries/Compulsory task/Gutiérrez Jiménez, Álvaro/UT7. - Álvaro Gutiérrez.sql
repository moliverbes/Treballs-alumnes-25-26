-- CONSULTAS CON INNER, LEFT/RIGHT JOIN Y UNION. NO UTILIZAR SUBCONSULTAS.

#1. Muestra el nombre y apellidos de los pacientes, la fecha de la cita y el estado de todas las citas completadas del año 2024. Ordena el resultado por fecha de cita descendente y, en caso de empate, por linaje ascendente.
select p.first_name, p.last_name, a.appointment_date, a.status
from appointments a
inner join patients p on a.patient_id = p.patient_id
where a.status = 'Completed' and year(a.appointment_date) = 2024
order by a.appointment_date desc, p.last_name asc;

#2. Muestra todas las habitaciones (room_number, room_type) y, si está asignada, el nombre del paciente y fecha de admisión. Si no está asignada, muestra el texto 'Sin asignar'. Muestra sólo las asignaciones todavía activas (discharge_date IS NULL).
-- Ordena por room_type y después por room_number.
select r.room_number, r.room_type, coalesce(concat(p.first_name, ' ', p.last_name), 'Sin asignar') as paciente, ra.admission_date
from rooms r
left join room_assignments ra on r.room_id = ra.room_id
left join patients p on ra.patient_id = p.patient_id
where ra.discharge_date is null
order by r.room_type, r.room_number;

#3. Lista a los pacientes que no tienen ninguna póliza de seguro asociada. Muestra patient_id, nombre completo y email. Ordena por el patient_id.
select p.patient_id, concat(p.first_name, ' ', p.last_name) as nombre_completo, p.email
from patients p
left join insurance_policies i on p.patient_id = i.patient_id
where i.patient_id is null
order by p.patient_id;

#4. Muestra los 5 proveedores que tienen más pedidos recibidos (status = 'Received'). Muestra el nombre del proveedor y el número de pedidos. Mostrar sólo los proveedores con 2 o más pedidos recibidos.
-- Ordena de más a menos pedidos recibidos
select s.name, count(o.order_id) as total_pedidos
from suppliers s
inner join orders o on s.supplier_id = o.supplier_id
where o.status = 'Received'
group by s.supplier_id, s.name
having count(o.order_id) >= 2
order by total_pedidos desc
limit 5;

#5. Muestra el nombre del medicamento, la cantidad y el precio unitario redondeado a 1 decimal de todas las líneas de pedido donde la cantidad sea superior a 5. Ordena por cantidad descendente.
select m.name, oi.quantity, round(oi.unit_price, 1) as precio
from order_items oi
inner join medications m on oi.medication_id = m.medication_id
where oi.quantity > 5
order by oi.quantity desc;

#6. Muestra todas las asignaciones de personal en instalaciones con el nombre de la instalación, el staff_type, el staff_id y la start_date. Ordena por el nombre de la instalación
select f.facility_name, sfa.staff_type, sfa.staff_id, sfa.start_date
from staff_facility_assignments sfa
inner join hospital_facilities f on sfa.facility_id = f.facility_id
order by f.facility_name;

#7. Muestra las instalaciones que no tienen ninguna asignación de personal. Muestra facility_id, facility_name y facility_type.
select f.facility_id, f.facility_name, f.facility_type
from hospital_facilities f
left join staff_facility_assignments sfa on f.facility_id = sfa.facility_id
where sfa.facility_id is null;

#8. Haz una consulta con UNION que muestre en una sola lista: los nombres completos de los doctores, y los nombres completos de las enfermeras. En ambos casos, la columna debe salir con el mismo sobrenombre, por ejemplo nombre_completo, y una segunda columna que indique el tipo de personal ('Doctor' o 'Nurse').
-- Ordena el resultado final por el nombre completo.
select concat(s.first_name, ' ', s.last_name) as nombre_completo, 'Doctor' as tipo
from staff s
inner join doctors d on s.staff_id = d.doctor_id
union
select concat(s.first_name, ' ', s.last_name), 'Nurse'
from staff s
inner join nurses n on s.staff_id = n.nurse_id
order by nombre_completo;

#9. Muestra el nombre de la especialidad y el número de doctores asignados a cada especialidad. Muestra sólo las especialidades que tienen exactamente 1 doctor o más.
-- Ordena por el número de doctores descendente y después por el nombre de la especialidad.
select s.name, count(d.doctor_id) as total_doctores
from specialties s
inner join doctors d on s.specialty_id = d.specialty_id
group by s.name
having count(d.doctor_id) >= 1
order by total_doctores desc, s.name;

#10. Muestra a los pacientes ingresados ​​con: nombre completo del paciente, número de habitación, tipo de habitación, fecha de ingreso, y el número de días ingresado hasta la fecha actual. Sólo deben mostrarse ingresos activos (discharge_date IS NULL).
-- Emplea una función de fechas para calcular los días de ingreso. Ordena por los días ingresados ​​de mayor a menor.
select concat(p.first_name, ' ', p.last_name) as paciente, r.room_number, r.room_type, ra.admission_date, datediff(current_date, ra.admission_date) as dias_ingresado
from room_assignments ra
inner join patients p on ra.patient_id = p.patient_id
inner join rooms r on ra.room_id = r.room_id
where ra.discharge_date is null
order by dias_ingresado desc;

#11. Muestra a los médicos con su número de licencia y el nombre de la especialidad, pero sólo aquellos en los que el nombre de la especialidad contiene la palabra “logía”. Aplica una función de texto para mostrar el nombre de la especialidad en mayúsculas.
-- Ordena por el número de licencia.
select d.license_number, upper(s.name) as especialidad
from doctors d
inner join specialties s on d.specialty_id = s.specialty_id
where s.name like '%logía%'
order by d.license_number;

#12. Muestra las habitaciones y el número total de camas que tiene cada una. Muestra sólo las habitaciones con 2 o más camas. Ordena primero por el número de camas descendente y después por el número de habitación.
select r.room_number, count(b.bed_id) as total_camas
from beds b
inner join rooms r on b.room_id = r.room_id
group by r.room_number
having count(b.bed_id) >= 2
order by total_camas desc, r.room_number;

#13. Muestra a los pacientes que no tienen ningún resultado de laboratorio registrado. Muestra patient_id, nombre completo y teléfono. Ordena por el nombre completo.
select p.patient_id, concat(p.first_name, ' ', p.last_name) as nombre_completo, p.phone
from patients p
left join lab_results l on p.patient_id = l.patient_id
where l.patient_id is null
order by nombre_completo;

#14. Haz una consulta con UNION que devuelva: todas las consultas médicas del año 2023, y todas las citas canceladas del año 2023. Las dos partes de la consulta deben devolver estas columnas: tipo_registro, sufriente_id, doctor_id, fecha_registro.
-- En la primera parte, tipo_registro debe valer 'Consulta'; en la segunda, 'Cita cancelada'. Ordena el resultado por fecha_registro.
select 'Consulta' as tipo_registro, patient_id, doctor_id, consultation_date as fecha_registro
from consultations
where year(consultation_date) = 2023
union
select 'Cita cancelada', patient_id, doctor_id, appointment_date
from appointments
where status = 'Cancelled'
and year(appointment_date) = 2023
order by fecha_registro;

#15. Muestra a los proveedores con el número total de pedidos y el importe medio de sus pedidos redondeado a 2 decimales. Muestra sólo los proveedores con una media de importe superior a 90 euros. Ordena por importe medio descendente.
select s.name, count(o.order_id) as total_pedidos, round(avg(o.total_amount), 2) as media_importe
from suppliers s
inner join orders o on s.supplier_id = o.supplier_id
group by s.name
having avg(o.total_amount) > 90
order by media_importe desc;

-- EJERCICIOS CON SUBCONSULTAS: IN, ANY, ALL

#16. Muestra a los pacientes que tienen alguna factura (billing) con estado 'Paid'.
select * from patients
where patient_id in (
    select patient_id
    from billing
    where status = 'Paid'
);

#17. Muestra los medicamentos que tienen un precio unitario (order_items.unit_price) superior a cualquiera de los precios del pedido con order_id = 1.
select distinct m.name
from order_items oi
inner join medications m on oi.medication_id = m.medication_id
where oi.unit_price > any (
    select unit_price
    from order_items
    where order_id = 1
);

#18. Muestra a los pacientes que tienen alguna factura con un importe superior a todas las facturas de un paciente 1.
select distinct p.* from patients p
inner join billing b on p.patient_id = b.patient_id
where b.amount > all (
    select amount
    from billing
    where patient_id = 1
);

-- FUNCIONES DE AGREGACIÓN

#19. Muestra a los pacientes que tienen alguna factura con un importe superior a la media de todas las facturas.
select distinct p.* from patients p
inner join billing b on p.patient_id = b.patient_id
where b.amount > (
    select avg(amount) from billing
);

#20. Muestra los pedidos (comoderos) que tienen un importe total igual al máximo importe de todos los pedidos.
select * from orders
where total_amount = (
    select max(total_amount) from orders
);

#21. Muestra los resultados de laboratorio cuyo valor es inferior al valor mínimo de todos los resultados.
select * from lab_results
where result_value < (
    select min(result_value) from lab_results
);

-- TABLAS DERIVADAS

#22. Muestra cuántos pacientes han ido a 1 consulta, 2 consultas, 3 consultas, etc.
select num_consultas, count(*) as total_pacientes
from (
    select patient_id, count(*) as num_consultas
    from consultations
    group by patient_id
    ) subquery
group by num_consultas
order by num_consultas;

#23. Muestra el número de pedidos según el importe total de cada pedido, clasificados en los siguientes tramos: Menos de 200 € / Entre 200€ y 500€ / Más de 500 €. Muestra cuántos pedidos hay en cada tramo.
select tramo, count(*) as total_pedidos
from (
    select order_id,
    case
        when total_amount < 200 then 'menos de 200 €'
        when total_amount between 200 and 500 then 'entre 200€ y 500€'
        else 'más de 500 €'
    end as tramo
    from orders
    ) subquery
group by tramo;

-- SUBCONSULTAS RELACIONADAS

#24. Muestra las consultas médicas (consultations) que son las más recientes de cada paciente.
select * from consultations c1
where consultation_date = (
    select max(c2.consultation_date)
    from consultations c2
    where c2.patient_id = c1.patient_id
);