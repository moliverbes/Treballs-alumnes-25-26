-- 1
ALTER TABLE moviment
	ADD CONSTRAINT UNIQUE (timestamp);

-- 2 
-- ALTER TABLE peça

-- 3
-- ALTER TABLE

-- 4 
-- ALTER TABLE poiscio
-- 	MODIFY 

-- 5 
ALTER TABLE moviment
	DROP CONSTRAINT chk_segons;
    
ALTER TABLE moviment
    ADD CONSTRAINT chk_segons CHECK (segons <= 60);

-- 6
-- ALTER TABLE peça
-- 	RENAME TABLE peça TO peçes;