-- -----------------------------------------------------
-- Schema Travel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Travel` DEFAULT CHARACTER SET utf8 ;
USE `Travel` ;

-- -----------------------------------------------------
-- Table `Travel`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Client` (
  `Document` VARCHAR(20) NOT NULL,
  `Name` VARCHAR(40) NULL,
  `Phone_number` VARCHAR(11) NULL,
  `Signed_up` DATE NULL,
  `Ordered_tours` SMALLINT NULL,
  PRIMARY KEY (`Document`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Note` (
  `Note_ID` INT NOT NULL AUTO_INCREMENT,
  `Client_Document` VARCHAR(20) NOT NULL,
  `Type` ENUM('Клиент', 'Агентство') NULL,
  `Text` VARCHAR(45) NULL,
  PRIMARY KEY (`Note_ID`),
  INDEX `fk_Note_Client_idx` (`Client_Document` ASC) VISIBLE,
  CONSTRAINT `fk_Note_Client`
    FOREIGN KEY (`Client_Document`)
    REFERENCES `Travel`.`Client` (`Document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Service` (
  `Type` VARCHAR(30) NOT NULL,
  `Price` DECIMAL(8,2) NOT NULL,
  `Days_needed` TINYINT NULL,
  PRIMARY KEY (`Type`, `Price`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Travel_visa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Travel_visa` (
  `Travel_visa_ID` INT NOT NULL AUTO_INCREMENT,
  `Client_Document` VARCHAR(15) NOT NULL,
  `Region` VARCHAR(25) NULL,
  `Date` DATE NULL,
  `Type` VARCHAR(20) NULL,
  PRIMARY KEY (`Travel_visa_ID`),
  INDEX `fk_Travel_visa_Client1_idx` (`Client_Document` ASC) VISIBLE,
  CONSTRAINT `fk_Travel_visa_Client1`
    FOREIGN KEY (`Client_Document`)
    REFERENCES `Travel`.`Client` (`Document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Transboard_passport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Transboard_passport` (
  `Pasport_number` VARCHAR(10) NOT NULL,
  `Client_Document` VARCHAR(20) NOT NULL,
  `Date_given` DATE NULL,
  `Date_invalid` DATE NULL,
  PRIMARY KEY (`Pasport_number`),
  INDEX `fk_Transboard_passport_Client1_idx` (`Client_Document` ASC) VISIBLE,
  CONSTRAINT `fk_Transboard_passport_Client1`
    FOREIGN KEY (`Client_Document`)
    REFERENCES `Travel`.`Client` (`Document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Tour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Tour` (
  `Tour_ID` INT NOT NULL AUTO_INCREMENT,
  `Price` DECIMAL(9,2) NULL,
  `Departure_date` DATE NULL,
  `Arrival_date` DATE NULL,
  PRIMARY KEY (`Tour_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Client_has_Tour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Client_has_Tour` (
  `Client_Document` VARCHAR(20) NOT NULL,
  `Tour_Tour_ID` INT NOT NULL,
  PRIMARY KEY (`Client_Document`, `Tour_Tour_ID`),
  INDEX `fk_Client_has_Tour_Tour1_idx` (`Tour_Tour_ID` ASC) VISIBLE,
  INDEX `fk_Client_has_Tour_Client1_idx` (`Client_Document` ASC) VISIBLE,
  CONSTRAINT `fk_Client_has_Tour_Client1`
    FOREIGN KEY (`Client_Document`)
    REFERENCES `Travel`.`Client` (`Document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Tour_Tour1`
    FOREIGN KEY (`Tour_Tour_ID`)
    REFERENCES `Travel`.`Tour` (`Tour_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Feature` (
  `Description` VARCHAR(30) NOT NULL,
  `Price` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`Description`, `Price`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Country` (
  `Country_name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Country_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Place` (
  `Place_ID` INT NOT NULL AUTO_INCREMENT,
  `Country_name` VARCHAR(25) NOT NULL,
  `Place_name` VARCHAR(30) NULL,
  `Stay_time` TIME NULL,
  `Stay_place` VARCHAR(35) NULL,
  PRIMARY KEY (`Place_ID`, `Country_name`),
  INDEX `fk_Place_Country1_idx` (`Country_name` ASC) VISIBLE,
  CONSTRAINT `fk_Place_Country1`
    FOREIGN KEY (`Country_name`)
    REFERENCES `Travel`.`Country` (`Country_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Route` (
  `Route_ID` INT NOT NULL AUTO_INCREMENT,
  `Place_ID` INT NOT NULL,
  `Transport` VARCHAR(20) NULL,
  `Departure_place` VARCHAR(50) NULL,
  `Departure_time` DATETIME NULL,
  `Arrival_time` DATETIME NULL,
  PRIMARY KEY (`Route_ID`),
  INDEX `fk_Route_Place1_idx` (`Place_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Route_Place1`
    FOREIGN KEY (`Place_ID`)
    REFERENCES `Travel`.`Place` (`Place_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Tour_has_Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Tour_has_Route` (
  `Tour_ID` INT NOT NULL,
  `Route_ID` INT NOT NULL,
  PRIMARY KEY (`Tour_ID`, `Route_ID`),
  INDEX `fk_Tour_has_Route_Route1_idx` (`Route_ID` ASC) VISIBLE,
  INDEX `fk_Tour_has_Route_Tour1_idx` (`Tour_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Tour_has_Route_Tour1`
    FOREIGN KEY (`Tour_ID`)
    REFERENCES `Travel`.`Tour` (`Tour_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tour_has_Route_Route1`
    FOREIGN KEY (`Route_ID`)
    REFERENCES `Travel`.`Route` (`Route_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Excursion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Excursion` (
  `Excursion_ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(35) NULL,
  `Price` DECIMAL(7,2) NULL,
  PRIMARY KEY (`Excursion_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Tour_has_Excursion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Tour_has_Excursion` (
  `Tour_ID` INT NOT NULL,
  `Excursion_ID` INT NOT NULL,
  PRIMARY KEY (`Tour_ID`, `Excursion_ID`),
  INDEX `fk_Tour_has_Excursion_Excursion1_idx` (`Excursion_ID` ASC) VISIBLE,
  INDEX `fk_Tour_has_Excursion_Tour1_idx` (`Tour_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Tour_has_Excursion_Tour1`
    FOREIGN KEY (`Tour_ID`)
    REFERENCES `Travel`.`Tour` (`Tour_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tour_has_Excursion_Excursion1`
    FOREIGN KEY (`Excursion_ID`)
    REFERENCES `Travel`.`Excursion` (`Excursion_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Excursion_has_Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Excursion_has_Route` (
  `Excursion_ID` INT NOT NULL,
  `Route_ID` INT NOT NULL,
  PRIMARY KEY (`Excursion_ID`, `Route_ID`),
  INDEX `fk_Excursion_has_Route_Route1_idx` (`Route_ID` ASC) VISIBLE,
  INDEX `fk_Excursion_has_Route_Excursion1_idx` (`Excursion_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Excursion_has_Route_Excursion1`
    FOREIGN KEY (`Excursion_ID`)
    REFERENCES `Travel`.`Excursion` (`Excursion_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Excursion_has_Route_Route1`
    FOREIGN KEY (`Route_ID`)
    REFERENCES `Travel`.`Route` (`Route_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Client_ordered_Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Client_ordered_Service` (
  `Client_Document` VARCHAR(20) NOT NULL,
  `Service_Type` VARCHAR(30) NOT NULL,
  `Service_Price` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`Client_Document`, `Service_Type`, `Service_Price`),
  INDEX `fk_Client_has_Service_Service1_idx` (`Service_Type` ASC, `Service_Price` ASC) VISIBLE,
  INDEX `fk_Client_has_Service_Client1_idx` (`Client_Document` ASC) VISIBLE,
  CONSTRAINT `fk_Client_has_Service_Client1`
    FOREIGN KEY (`Client_Document`)
    REFERENCES `Travel`.`Client` (`Document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Service_Service1`
    FOREIGN KEY (`Service_Type` , `Service_Price`)
    REFERENCES `Travel`.`Service` (`Type` , `Price`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Tour_has_Feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Tour_has_Feature` (
  `Tour_ID` INT NOT NULL,
  `Feature_Description` VARCHAR(30) NOT NULL,
  `Feature_Price` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`Tour_ID`, `Feature_Description`, `Feature_Price`),
  INDEX `fk_Tour_has_Feature_Feature1_idx` (`Feature_Description` ASC, `Feature_Price` ASC) VISIBLE,
  INDEX `fk_Tour_has_Feature_Tour1_idx` (`Tour_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Tour_has_Feature_Tour1`
    FOREIGN KEY (`Tour_ID`)
    REFERENCES `Travel`.`Tour` (`Tour_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tour_has_Feature_Feature1`
    FOREIGN KEY (`Feature_Description` , `Feature_Price`)
    REFERENCES `Travel`.`Feature` (`Description` , `Price`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Discount` (
  `Min_ordered` INT NOT NULL,
  `Discount` FLOAT NULL,
  UNIQUE INDEX `Min_ordered_UNIQUE` (`Min_ordered` ASC) VISIBLE,
  PRIMARY KEY (`Min_ordered`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Travel`.`Client_has_Discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Travel`.`Client_has_Discount` (
  `Client_Document` VARCHAR(20) NOT NULL,
  `Discount_Min_ordered` INT NOT NULL,
  PRIMARY KEY (`Client_Document`, `Discount_Min_ordered`),
  INDEX `fk_Client_has_Discount_Discount1_idx` (`Discount_Min_ordered` ASC) VISIBLE,
  INDEX `fk_Client_has_Discount_Client1_idx` (`Client_Document` ASC) VISIBLE,
  CONSTRAINT `fk_Client_has_Discount_Client1`
    FOREIGN KEY (`Client_Document`)
    REFERENCES `Travel`.`Client` (`Document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Discount_Discount1`
    FOREIGN KEY (`Discount_Min_ordered`)
    REFERENCES `Travel`.`Discount` (`Min_ordered`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO Client VALUES ('1111 666666', 'V. V. Plushkin', '88005553535', '2022-10-02', 1),
('III-МЮ 123456', 'A. V. Plushkin', null, '2022-10-02', 1), 
('6516 303030', 'S. G. Ivanov', '89821234567', '2012-5-02', 12),
('2929 323232', 'O.B. Petrova', '89988998989', '2015-12-31', 8),
('1122 334455', 'M.I. Sobyankin', '81234567890', '2016-01-12', 4);


INSERT INTO Transboard_passport VALUES('12 3456789', '1111 666666', '2020-10-05', '2030-10-05'),
('12 9876543', '1111 666666', '2018-02-22', '2023-02-22'),
('34 5678912', 'III-МЮ 123456', '2020-10-05', '2030-10-05'),
('57 1313131', '2929 323232', '2021-12-25', '2031-12-25'),
('11 2222222', '6516 303030', '2019-04-09', '2029-04-09');


INSERT INTO Travel_visa VALUES(null, '1111 666666', 'США', '2020-10-05', 'Деловая'),
(null, '1111 666666', 'Шенген', '2019-08-07', 'Туристическая'),
(null, 'III-МЮ 123456', 'Шенген', '2019-08-07', 'Туристическая'),
(null, '6516 303030', 'Шенген', '2025-05-01', 'Дипломатическая'),
(null, '6516 303030', 'США', '2025-05-01', 'Дипломатическая');


INSERT INTO Discount VALUES (0, 0),
(3, 0.1),
(5, 0.15),
(7, 0.20),
(10, 0.25),
(15, 0.30);


INSERT INTO Client_has_Discount
(SELECT Document, MAX(Min_ordered) FROM Client
INNER JOIN Discount ON Ordered_tours >= Min_ordered
GROUP BY Document);


INSERT INTO Tour VALUES (NULL, 36000.00, '2022-01-12', '2022-01-15'),
(NULL, 80000, '2022-07-12', '2022-07-16'),
(NULL, 12000, '2023-01-07', '2023-01-09'),
(NULL, 25000, '2023-01-31', '2023-02-02'),
(NULL, 30000, '2023-02-20', '2023-02-22');


INSERT INTO Country VALUES ('Россия'),
('Турция'),
('Финляндия'),
('Италия'),
('Франция');


INSERT INTO Place VALUES (NULL, 'Россия', 'Санкт-Петербург', NULL, NULL),
(NULL, 'Россия', 'Москва', '48:00:00', 'Отель "Россия"'),
(NULL, 'Россия', 'Москва, Красная площадь', '2:30:00', NULL),
(NULL, 'Россия', 'Москва, Третьяковская галерея', '2:30:00', NULL),
(NULL, 'Италия', 'Рим', '92:00:00', 'Villa "Katerina"'),
(NULL, 'Италия', 'Венеция', '5:00:00', NULL),
(NULL, 'Финляндия', 'Хельсинки', '48:00:00', 'Sokos Hotel City Bors'),
(NULL, 'Финляндия', 'Турку', '24:00:00', 'Holiday Club Caribia');


INSERT INTO Feature VALUES('Full supply', 7500.00),
('Breakfast and Dinner', 5000.00),
('Breakfast only', 2500.00),
('Full supply', 12000.00),
('Breakfast and Dinner', 8000.00),
('Breakfast only', 4000.00);


INSERT INTO Note VALUES(null, '1122 334455', 'Агентство', 'Дважды отменял заказ — ненадежный клиент.'),
(null, '1122 334455', 'Клиент', 'Требую возврата средств в полном объеме!'),
(null, '1111 666666', 'Клиент', 'Сообщите, как только появятся туры в Грецию.');


INSERT INTO Excursion VALUES(NULL, 'Red Square excursion', 1500.00),
(NULL, '"Tretyakovka"', 2500.00),
(NULL, 'Venice cannals excursion', 4000.00);


INSERT INTO Route VALUES(NULL, 2, 'Самолет', 'Санкт-Петербург, Пулково', '2022-01-12 10:00:00', '2022-01-12 12:00:00'),
(NULL, 3, 'Автобус', 'Москва, ул. Сикуэлина, ост. "Джсонина"', '2022-01-13 10:00:00', '2022-01-13 11:00:00'),
(NULL, 4, 'Автобус', 'Москва, Красная Площадь', '2022-01-13 13:30:00', '2022-01-13 14:00:00'),
(NULL, 1, 'Самолет', 'Москва, Шереметьево', '2022-01-16 8:00:00', '2022-01-16 10:00:00'),
(NULL, 5, 'Самолет', 'Санкт-Петербург, Пулково', '2022-07-12 7:00:00', '2022-07-12 12:00:00'),
(NULL, 4, 'Автобус', 'Рим, бульв. Массая, 75', '2022-07-14 7:00:00', '2022-07-14 12:00:00'),
(NULL, 5, 'Автобус', 'Венеция, Calle Nuova Tabacchi, 433', '2022-07-14 17:00:00', '2022-07-14 22:00:00'),
(NULL, 1, 'Самолет', 'Рим, Чампино', '2022-07-16 7:00:00', '2022-07-16 12:00:00'),
(NULL, 7, 'Автобус', 'Санкт-Петербург, метро "Комендантский проспект"', '2023-02-20 8:00:00', '2023-02-20 13:00:00'),
(NULL, 8, 'Автобус', 'Хельсинки,  Bwarhlog st. 45', '2023-02-22 8:00:00', '2023-02-22 12:00:00'),
(NULL, 1, 'Автобус', 'Турку, Hyargath st. 39', '2023-02-23 13:00:00', '2023-02-2 16:00:00');


INSERT INTO Tour_has_Route VALUES(1, 1),
(1, 4),
(2, 5),
(2, 8),
(5, 9),
(5, 10),
(5, 11);


INSERT INTO Excursion_has_Route VALUES(1, 2),
(2, 3),
(3, 6),
(3, 7);


INSERT INTO Tour_has_Feature VALUES(1, 'Full supply', 7500.00),
(1, 'Breakfast and Dinner', 5000.00),
(1, 'Breakfast only', 2500.00),
(2, 'Full supply', 12000.00),
(2, 'Breakfast and Dinner', 8000.00),
(2, 'Breakfast only', 4000.00),
(5, 'Full supply', 12000.00),
(5, 'Breakfast and Dinner', 8000.00),
(5, 'Breakfast only', 4000.00);


INSERT INTO Tour_has_Excursion VALUES(1, 1),
(1, 2),
(2, 1);


INSERT INTO Service VALUES('Оформление визы', 5000, 45),
('Оформление визы', 10000, 30),
('Оформление загранпаспорта', 3000, 20),
('Оформление загранпаспорта', 5000, 10),
('Страхование жизни', 7000, 1),
('Страхование рейса', 4000, 1);


INSERT INTO Client_ordered_Service VALUES('1122 334455', 'Оформление загранпаспорта', 5000),
('2929 323232', 'Оформление визы', 5000);


SET @max_price := 100000;
SELECT * FROM Tour
INNER JOIN Tour_has_Route AS thr ON (Tour.tour_id = thr.tour_id)
INNER JOIN Route ON (thr.route_id = Route.route_id)
INNER JOIN Place ON (Route.place_id = Place.place_id)
WHERE Tour.price <  @max_price;


SET @chosen_country = 'Россия', @min_date := '2022-01-12', @max_date :='2022-01-31';
SELECT * FROM Tour 
INNER JOIN Tour_has_Route AS thr ON (Tour.tour_id = thr.tour_id)
INNER JOIN Route ON (thr.route_id = Route.route_id)
INNER JOIN Place ON (Route.place_id = Place.place_id)
WHERE DATEDIFF(Tour.departure_date, @min_date) >= 0 AND DATEDIFF(@max_date, Tour.arrival_date) >= 0 AND Place.country_name LIKE @chosen_country;

SET @chosen_document = '1122 334455';
SELECT @chosen_document AS Документ, Type AS 'Название усуги', ROUND(Price * (1 - (SELECT MAX(discount) FROM Client
INNER JOIN Discount ON Ordered_tours + 1 >= Min_ordered WHERE Document LIKE @chosen_document)), 2) AS Цена FROM Service;

SET  @min_date := '2023-01-01', @max_date :='2023-02-28';
WITH tour_with_plane AS (SELECT DISTINCT Tour.tour_id FROM Tour 
INNER JOIN Tour_has_Route AS thr ON (Tour.tour_id = thr.tour_id)
INNER JOIN Route ON (thr.route_id = Route.route_id)
WHERE transport LIKE 'Самолет') 
SELECT * FROM Tour 
INNER JOIN Tour_has_Route AS thr ON (Tour.tour_id = thr.tour_id)
INNER JOIN Route ON (thr.route_id = Route.route_id)
INNER JOIN Place ON (Route.place_id = Place.place_id)
WHERE DATEDIFF(Tour.departure_date, @min_date) >= 0 AND DATEDIFF(@max_date, Tour.arrival_date) >= 0 AND Tour.tour_id NOT IN (SELECT tour_id FROM tour_with_plane);


SELECT * FROM Tour
WHERE DATEDIFF(departure_date, CURDATE()) BETWEEN 1 AND 4;


SELECT * FROM Discount;


SELECT * FROM Tour 
INNER JOIN Tour_has_Route AS thr ON (Tour.tour_id = thr.tour_id)
INNER JOIN Route ON (thr.route_id = Route.route_id)
INNER JOIN Place ON (Route.place_id = Place.place_id)
WHERE Tour.tour_id = (SELECT tour_id FROM Tour ORDER BY price DESC LIMIT 1);