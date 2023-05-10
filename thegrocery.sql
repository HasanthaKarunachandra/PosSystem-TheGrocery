-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema thegrocery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema thegrocery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `thegrocery` DEFAULT CHARACTER SET utf8 ;
USE `thegrocery` ;

-- -----------------------------------------------------
-- Table `thegrocery`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`user` (
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(750) NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thegrocery`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`customer` (
  `email` VARCHAR(100) NOT NULL,
  `name` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `salary` DOUBLE NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thegrocery`.`loyalty_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`loyalty_card` (
  `code` INT NOT NULL,
  `type` ENUM("GOLD", "PLATINUM", "SILVER") NULL,
  `barcode` LONGBLOB NULL,
  `customer_email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_loyalty_card_customer_idx` (`customer_email` ASC) VISIBLE,
  CONSTRAINT `fk_loyalty_card_customer`
    FOREIGN KEY (`customer_email`)
    REFERENCES `thegrocery`.`customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thegrocery`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`product` (
  `code` INT NOT NULL,
  `description` VARCHAR(100) NULL,
  `unit_price` DOUBLE NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thegrocery`.`product_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`product_detail` (
  `code` INT NOT NULL,
  `barcode` LONGBLOB NULL,
  `qty_on_hand` INT NULL,
  `selling_price` DOUBLE NULL,
  `discount_availability` DOUBLE NULL,
  `show_price` DOUBLE NULL,
  `product_code` INT NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_product_detail_product1_idx` (`product_code` ASC) VISIBLE,
  CONSTRAINT `fk_product_detail_product1`
    FOREIGN KEY (`product_code`)
    REFERENCES `thegrocery`.`product` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thegrocery`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`order_detail` (
  `code` INT NOT NULL,
  `issued_date` DATE NULL,
  `total_cost` DOUBLE NULL,
  `discount_amount` DOUBLE NULL,
  `customer_email` VARCHAR(100) NOT NULL,
  `user_email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_order_detail_customer1_idx` (`customer_email` ASC) VISIBLE,
  INDEX `fk_order_detail_user1_idx` (`user_email` ASC) VISIBLE,
  CONSTRAINT `fk_order_detail_customer1`
    FOREIGN KEY (`customer_email`)
    REFERENCES `thegrocery`.`customer` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_detail_user1`
    FOREIGN KEY (`user_email`)
    REFERENCES `thegrocery`.`user` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thegrocery`.`product_detail_has_order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thegrocery`.`product_detail_has_order_detail` (
  `product_detail_code` INT NOT NULL,
  `order_detail_code` INT NOT NULL,
  `product_qty` INT NULL,
  `discount` DOUBLE NULL,
  `amount` DOUBLE NULL,
  PRIMARY KEY (`product_detail_code`, `order_detail_code`),
  INDEX `fk_product_detail_has_order_detail_order_detail1_idx` (`order_detail_code` ASC) VISIBLE,
  INDEX `fk_product_detail_has_order_detail_product_detail1_idx` (`product_detail_code` ASC) VISIBLE,
  CONSTRAINT `fk_product_detail_has_order_detail_product_detail1`
    FOREIGN KEY (`product_detail_code`)
    REFERENCES `thegrocery`.`product_detail` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_detail_has_order_detail_order_detail1`
    FOREIGN KEY (`order_detail_code`)
    REFERENCES `thegrocery`.`order_detail` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
