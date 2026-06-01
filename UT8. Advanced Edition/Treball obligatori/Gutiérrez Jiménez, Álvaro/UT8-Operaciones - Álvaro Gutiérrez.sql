# PARTE 2
# 3 especialidades
insert into especialitats (nom)
values ('Dermatología'), ('Cardiología'), ('Pediatría');


# 3 metges asociados a una especialidad
insert into metges
values (null, 'Paco', 'Pérez Bonilla', '629374829', 'pacoperez@gmail.com', (select id_especialitat from especialitats where nom = 'Dermatología')),
(null, 'Clara', 'Zurera Jiménez', '609384098', 'clarazurera@gmail.com', (select id_especialitat from especialitats where nom = 'Cardiología')),
(null, 'Cletus', 'Calle Marín', '612907385', 'cletuscalle@gmail.com', (select id_especialitat from especialitats where nom = 'Pediatría'));


# 5 pacientes
insert into pacients (nom,cognoms,data_naixement,telefon,email,adreca) 
values ('Adrián','Díaz Romero','2001-07-19','650192234','adriandiaz@gmail.com','Calle Calatrava'),
('Elena','Bautista Sánchez','2004-02-09','601990284','elenabautista@gmail.com','Calle Nueva'),
('Juan','Jiménez Jurado','2003-09-10','620391827','juanjimenez@gmail.com','Calle Descartes'),
('Laura','Martínez Gómez','1998-03-14','611223344','lauramartinez@gmail.com','Calle Sol'),
('Mario','Ruiz López','1995-11-20','622334455','marioruiz@gmail.com','Avenida Andalucía');


# 3 medicamentos
insert into medicaments (nom,dosi,fabricant,stock) 
values ('Paracetamol','500 mg','Genfar',150),
('Ibuprofeno','600 mg','Bayer',85),
('Amoxicilina','875 mg','Pfizer',200);


# 3 citas médicas
insert into cites
values (null, (select id_pacient from pacients where nom = 'Adrián' and cognoms = 'Díaz Romero'), (select id_metge from metges where nom = 'Paco' and cognoms = 'Pérez Bonilla'), '2026-05-18', '08:30:00', 'Completada'),
(null, (select id_pacient from pacients where nom = 'Elena' and cognoms = 'Bautista Sánchez'), (select id_metge from metges where nom = 'Clara' and cognoms = 'Zurera Jiménez'), '2026-05-20', '17:00:00', 'Pendent'),
(null, (select id_pacient from pacients where nom = 'Juan' and cognoms = 'Jiménez Jurado'), (select id_metge from metges where nom = 'Cletus' and cognoms = 'Calle Marín'), '2026-05-22', '12:00:00', 'Cancel·lada');


# PARTE 3. ÚSO DE VARIABLES
# guardar el identificador de un paciente
select id_pacient into @id_pacient
from pacients
where nom = 'Adrián' and cognoms = 'Díaz Romero';

# guardar el identificador de un médico
select id_metge into @id_metge
from metges
where nom = 'Paco' and cognoms = 'Pérez Bonilla';

# insertar una nueva cita
insert into cites (id_pacient,id_metge,data_cita,hora_cita)
values (@id_pacient, @id_metge,'2026-05-25','10:30:00');

# PARTE 4. USO DE LAST_INSERT_ID()
# insertar nuevo paciente
insert into pacients (nom, cognoms, data_naixement, telefon, email, adreca)
values ('Lucía', 'Fernández Castro', '2000-06-18', '633445566', 'lucia@gmail.com', 'Calle Luna');

set @nuevo = last_insert_id();

# crear una cita para el nuevo paciente
insert into cites (id_pacient, id_metge, data_cita, hora_cita, estat)
values (@nuevo, 1, '2026-05-28', '09:00:00', 'Pendent');

# PARTE 5. TRANSACCIONES
start transaction;

-- inserta una nueva cita
insert into cites (id_pacient,id_metge,data_cita,hora_cita)
values (@id_pacient, @id_metge,'2026-06-02','15:30:00');

-- guardar el id de la cita insertada
set @id_cita = last_insert_id();

-- insertar una prescipcion asociada a esta cita
insert into prescripcions (id_cita, id_medicament, quantitat, indicacions)
values (@id_cita, 2, 2, 'Tomar durante 7 días');

-- actualiza el estado de la cita a completada
update cites
set estat = 'Completada'
where id_cita = @id_cita;

-- confirma los cambios con COMMIT
commit;

# PARTE 6. UPDATE
-- cambia el telefono de un paciente
select * from pacients where id_pacient = 1;

update pacients
set telefon = '600129438'
where id_pacient = 1;

-- modifica la fecha o la hora de una cita
select * from cites where id_cita = 3;

update cites
set hora_cita = '11:15:00'
where id_cita = 3;

-- actualiza el nombre de un medicamento o la dosis
select * from medicaments where nom = 'Ibuprofeno';

update medicaments
set dosi = '1 g'
where nom = 'Ibuprofeno';

# PARTE 7. DELETE
-- elimina una cita cancelada
select * from cites
where estat = 'Cancel·lada';

delete from cites
where estat = 'Cancel·lada'
limit 1;

-- un medicamento que no tenga ninguna prescripción asociada
select * from medicaments
where id_medicament NOT IN (select id_medicament from prescripcions);

delete from medicaments
where id_medicament NOT IN (select id_medicament from prescripcions);