ALTER TABLE `players`
	ADD COLUMN `play_time` INT NULL DEFAULT '0',
	ADD COLUMN `char_kills` INT NULL DEFAULT '0',
	ADD COLUMN `char_deaths` INT NULL DEFAULT '0';