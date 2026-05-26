-- Part 2. Inserció manual de dades
INSERT INTO especialitats (nom) VALUES 
('Pediatria'),('Cardiologia'),('Medicina General');

INSERT INTO metges (nom, cognoms, telefon, email, id_especialitat) VALUES 
('Jordi', 'Rovira i Sans', '600111222', 'jrovira@clinica.cat', 1),   
('Marta', 'Vila Gómez', '611222333', 'mvila@clinica.cat', 2),    
('Carles', 'Sánchez López', '622333444', 'csanchez@clinica.cat', 3);

INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) VALUES 
('Alvaro', 'Gutierrez Sevildo', '1985-04-12', '655444333', 'alvaro.guti@gmail.com', 'Carrer Major 15, Barcelona'),
('Marc', 'Pirez Torrente', '2015-08-22', '677888999', 'marc.pirez@gmail.com', 'Av. Diagonal 420, Barcelona'),
('Gerard', 'Pons Casas', '1960-11-02', '644555666', 'gerard.pons@gmail.com', 'Placeta del Pi 3, Girona'),
('Alex', 'Ferrer Alguiñano', '1992-01-30', '633222111', 'alex.ferrer@gmail.com', 'Carrer Nou 8, Tarragona'),
('Joan', 'Miquel Pedrero', '2000-05-18', '699000111', 'jmiquel@gmail.com', 'Passeig de Ronda 55, Lleida');

INSERT INTO medicaments (nom, dosi, fabricant, stock) VALUES 
('Paracetamol', '1g', 'Kern Pharma', 150),
('Ibuprofèn', '600mg', 'Bayer', 200),
('Amoxicil·lina', '500mg', 'Normon', 85);

insert into cites (id_pacient,id_metge,data_cita,hora_cita,estat)
values (2,3, CURDATE(), CURRENT_TIMESTAMP(),'Pendent'),
(4,2, CURDATE(), CURRENT_TIMESTAMP(),'Cancel·lada'),
(3,2, CURDATE(), CURRENT_TIMESTAMP(),'Completada');

-- Part 3. Ús de variables
select id_metge into @id_metge
from metges
where id_metge = 1;

select id_pacient into @id_pacient
from pacients
where id_pacient = 1;

insert into cites
values (null, @id_pacient,@id_metge, CURDATE(), CURRENT_TIMESTAMP(),'Pendent');

-- Part 4. Ús de LAST_INSERT_ID()
INSERT INTO pacients (nom, cognoms, data_naixement, telefon, email, adreca) VALUES 
('Marcos', 'Zurera Algalope', '1990-07-05', '652547812', 'marcos.zurera@gmail.com', 'Carrer Major 15, Barcelona');

insert into cites
values (null, last_insert_id(),@id_metge, CURDATE(), CURRENT_TIMESTAMP(),'Pendent');

-- Part 5. Transaccions
START transaction;
-- Inserir una nova cita.
INSERT INTO cites VALUES 
(null,5,2,curdate(),current_timestamp(),'Pendent');
-- Inserir una prescripció associada a aquesta cita.
INSERT INTO prescripcions VALUES
(null,last_insert_id(),2,9,'Tomar durante 3 dias cada 8 horas');
-- Actualitzar l’estat de la cita a Completada.
UPDATE cites SET estat = 'Completada'
WHERE id_cita = 6;
-- Confirma els canvis amb COMMIT.
COMMIT;

-- Part 6. Sentències UPDATE
select * from pacients;
UPDATE pacients SET telefon = '666999888'
WHERE id_pacient = 2;

select * from cites;
UPDATE cites SET hora_cita = current_timestamp()
WHERE id_cita = 1;

select * from medicaments;
UPDATE medicaments SET dosi = '10g'
WHERE id_medicament = 1;

-- Part 7. Sentències DELETE
select * from cites;
DELETE FROM cites WHERE estat = 'Cancel·lada' LIMIT 1;

select * from medicaments;
select * from prescripcions;
DELETE FROM medicaments WHERE id_medicament = 3;
