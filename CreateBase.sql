-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'shedule'
-- 
-- ---

DROP TABLE IF EXISTS `shedule`;
		
CREATE TABLE `shedule` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `data` INTEGER NULL DEFAULT NULL,
  `lesson` INTEGER NULL DEFAULT NULL,
  `homework` MEDIUMTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'sheduleWeek'
-- 
-- ---

DROP TABLE IF EXISTS `sheduleWeek`;
		
CREATE TABLE `sheduleWeek` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `1` INTEGER NULL DEFAULT NULL,
  `2` INTEGER NULL DEFAULT NULL,
  `3` INTEGER NULL DEFAULT NULL,
  `4` INTEGER NULL DEFAULT NULL,
  `5` INTEGER NULL DEFAULT NULL,
  `6` INTEGER NULL DEFAULT NULL,
  `7` INTEGER NULL DEFAULT NULL,
  `8` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'lessons'
-- 
-- ---

DROP TABLE IF EXISTS `lessons`;
		
CREATE TABLE `lessons` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `lesson` CHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `shedule` ADD FOREIGN KEY (lesson) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (1) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (2) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (3) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (4) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (5) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (6) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (7) REFERENCES `lessons` (`id`);
ALTER TABLE `sheduleWeek` ADD FOREIGN KEY (8) REFERENCES `lessons` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `shedule` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `sheduleWeek` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `lessons` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `shedule` (`id`,`data`,`lesson`,`homework`) VALUES
-- ('','','','');
-- INSERT INTO `sheduleWeek` (`id`,`1`,`2`,`3`,`4`,`5`,`6`,`7`,`8`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `lessons` (`id`,`lesson`) VALUES
-- ('','');