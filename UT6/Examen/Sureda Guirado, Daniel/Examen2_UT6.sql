-- Modificacions 

-- 1. 

alter table moviment 
modify column timestamp datetime unique; 

-- 2 

alter table peça 
modify column id_posicio tinyint null;

-- 3 

-- b -- no es pot eliminar l' id_posicio
alter table peça 
drop column id_posicio;

alter table posicio 
add column casella set('A1','B2','C3','D4','E5','F6','G7','H8') not null unique;


-- 4 

alter table posicio 
add column color enum('Blanc','Negre') not null;

-- 5

alter table moviment 
add check (segons <= '60.0');


-- 6 

rename table peça to Peces 



