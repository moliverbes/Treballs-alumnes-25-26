# PARTE 8. Carga de datos desde un CSV con LOAD DATA
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nous_pacients.csv'
into table pacients
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;


# PARTE 9. CARGA DE DATOS DESDE UN JSON
insert into medicaments (nom, dosi, fabricant, stock)
select nom, dosi, fabricant, stock
from json_table(
    convert(
        load_file('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/nous_medicaments.json')
        using utf8mb4),
    '$[*]' columns (
        nom varchar(100) path '$.nom',
		dosi varchar(50) path '$.dosi',
		fabricant varchar(100) path '$.fabricant',
		stock int path '$.stock'
    )
) as t;

-- convierte los datos del JSON en INSERT
insert into medicaments (nom, dosi, fabricant, stock)
values ('Aspirina', '500 mg', 'Bayer', 120),
('Omeprazol', '20 mg', 'Cinfa', 75),
('Ventolin', '100 mcg', 'GSK', 40),
('Gelocatil', '650 mg', 'Ferrer', 90);

# PARTE 10. USO DE CSVConvert
/*
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/noves_cites.csv'
into table cites
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;
*/

insert into cites (id_pacient, id_metge, data_cita, hora_cita, estat)
values (1, 1, '2026-06-10', '09:00:00', 'Pendent');

insert into cites (id_pacient, id_metge, data_cita, hora_cita, estat)
values (2, 2, '2026-06-11', '10:30:00', 'Pendent');

insert into cites (id_pacient, id_metge, data_cita, hora_cita, estat)
values (3, 3, '2026-06-12', '11:15:00', 'Pendent');

insert into cites (id_pacient, id_metge, data_cita, hora_cita, estat)
values (4, 1, '2026-06-13', '16:00:00', 'Pendent');

insert into cites (id_pacient, id_metge, data_cita, hora_cita, estat)
values (5, 2, '2026-06-14', '17:45:00', 'Pendent');