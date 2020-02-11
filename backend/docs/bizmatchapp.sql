-- MySQL Script generated by MySQL Workbench
-- mar 21 ene 2020 17:51:30 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bizmatchapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bizmatchapp` ;

-- -----------------------------------------------------
-- Schema bizmatchapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bizmatchapp` ;
USE `bizmatchapp` ;

-- -----------------------------------------------------
-- Table `bizmatchapp`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`user` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`user` (
  `id` CHAR(36) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `birthday` DATE NOT NULL,
  `country` VARCHAR(20) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `avatar_url` VARCHAR(255) NULL DEFAULT NULL,
  `company_name` VARCHAR(255) NULL DEFAULT NULL,
  `company_role` VARCHAR(255) NULL DEFAULT NULL,
  `page_url` VARCHAR(512) NULL DEFAULT NULL,
  `type` CHAR(1) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`project` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`project` (
  `id` CHAR(36) NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `subtitle` VARCHAR(135) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `ubication` VARCHAR(60) NOT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `video_url` VARCHAR(255) NULL DEFAULT NULL,
  `prize` VARCHAR(20) NULL DEFAULT NULL,
  `duration` CHAR(3) NULL DEFAULT NULL,
  `text` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `user_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Project_User_idx` (`user_id` ASC),
  CONSTRAINT `fk_Project_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`assesment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`assesment` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`assesment` (
  `id` CHAR(36) NOT NULL,
  `type` INT(1) NOT NULL,
  `user_id` CHAR(36) NOT NULL,
  `project_id` CHAR(36) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Assesment_User1_idx` (`user_id` ASC),
  INDEX `fk_Assesment_Project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_Assesment_Project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `bizmatchapp`.`project` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Assesment_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`bizmatch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`bizmatch` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`bizmatch` (
  `id` CHAR(36) NOT NULL,
  `user_id` CHAR(36) NOT NULL,
  `project_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_bizmatch_user1_idx` (`user_id` ASC),
  INDEX `fk_bizmatch_project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_bizmatch_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `bizmatchapp`.`project` (`id`),
  CONSTRAINT `fk_bizmatch_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`comment` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`comment` (
  `id` CHAR(36) NOT NULL,
  `text` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `user_id` CHAR(36) NOT NULL,
  `project_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Comentario_User1_idx` (`user_id` ASC),
  INDEX `fk_Comentario_Project1` (`project_id` ASC),
  CONSTRAINT `fk_Comentario_Project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `bizmatchapp`.`project` (`id`),
  CONSTRAINT `fk_Comentario_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`theme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`theme` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`theme` (
  `id` CHAR(36) NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `content` TEXT NOT NULL,
  `project_name` VARCHAR(60) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `user_id` CHAR(36) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_theme_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_theme_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`comment_theme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`comment_theme` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`comment_theme` (
  `id` CHAR(36) NOT NULL,
  `text` VARCHAR(200) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL,
  `theme_id` CHAR(36) NOT NULL,
  `user_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_comment_theme_theme1_idx` (`theme_id` ASC),
  INDEX `fk_comment_theme_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_comment_theme_theme1`
    FOREIGN KEY (`theme_id`)
    REFERENCES `bizmatchapp`.`theme` (`id`),
  CONSTRAINT `fk_comment_theme_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`message` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`message` (
  `id` CHAR(36) NOT NULL,
  `content` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `origin_id` CHAR(36) NOT NULL,
  `destination_id` CHAR(36) NOT NULL,
  `conversation` CHAR(72) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_Mensaje_User2_idx` (`destination_id` ASC),
  INDEX `fk_Mensaje_User1` (`origin_id` ASC),
  CONSTRAINT `fk_Mensaje_User1`
    FOREIGN KEY (`origin_id`)
    REFERENCES `bizmatchapp`.`user` (`id`),
  CONSTRAINT `fk_Mensaje_User2`
    FOREIGN KEY (`destination_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`reward`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`reward` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`reward` (
  `id` CHAR(36) NOT NULL,
  `project_id` CHAR(36) NOT NULL,
  `prize` VARCHAR(20) NOT NULL,
  `title` VARCHAR(60) NOT NULL,
  `month` VARCHAR(20) NOT NULL,
  `year` VARCHAR(10) NOT NULL,
  `subtitle` VARCHAR(135) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_table1_Project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_table1_Project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `bizmatchapp`.`project` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bizmatchapp`.`user_reward`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bizmatchapp`.`user_reward` ;

CREATE TABLE IF NOT EXISTS `bizmatchapp`.`user_reward` (
  `id` CHAR(36) NOT NULL,
  `User_id` CHAR(36) NOT NULL,
  `Reward_id` CHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_User_has_Reward_Reward1_idx` (`Reward_id` ASC),
  INDEX `fk_User_has_Reward_User1_idx` (`User_id` ASC),
  CONSTRAINT `fk_User_has_Reward_Reward1`
    FOREIGN KEY (`Reward_id`)
    REFERENCES `bizmatchapp`.`reward` (`id`),
  CONSTRAINT `fk_User_has_Reward_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `bizmatchapp`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
