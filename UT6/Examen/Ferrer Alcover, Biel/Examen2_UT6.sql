
-- 1 No es nesesari ja que ja asepta valors null esta comentat el comande per que em dona error

-- alter table peça
-- modify  column timestamp  datetime unique;


-- 2 No es nesesari ja que ja asepta valors null
alter table peça
modify  id_posicio tinyint unique;



-- 4
alter table posicio
add column color enum ('blanc', 'negre') not null;

-- 5
alter table moviment
modify segons decimal(4,1) check (segons <= 60.0) default 0.0;

-- 6
alter table peça
rename  peces;