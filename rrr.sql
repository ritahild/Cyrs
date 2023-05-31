create database `cyrs`;
-- создается база данных в которой будет проходить работа

use cyrs;

-- прописывается что используется конкретная база данных
-- создаются таблицы и в них же прописываются между ними связи

CREATE TABLE IF NOT EXISTS `cyrs`.`weather_station` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `mesto` VARCHAR(255) NULL,
  `type` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyrs`.`dimension`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyrs`.`dimension` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyrs`.`type_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyrs`.`type_equipment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL,
  `dimension_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_type_equipment_dimension1_idx` (`dimension_id` ASC) VISIBLE,
  CONSTRAINT `fk_type_equipment_dimension1`
    FOREIGN KEY (`dimension_id`)
    REFERENCES `cyrs`.`dimension` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyrs`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyrs`.`equipment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `weather_station_id` INT NOT NULL,
  `type_equipment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_equipment_weather_station_idx` (`weather_station_id` ASC) VISIBLE,
  INDEX `fk_equipment_type_equipment1_idx` (`type_equipment_id` ASC) VISIBLE,
  CONSTRAINT `fk_equipment_weather_station`
    FOREIGN KEY (`weather_station_id`)
    REFERENCES `cyrs`.`weather_station` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipment_type_equipment1`
    FOREIGN KEY (`type_equipment_id`)
    REFERENCES `cyrs`.`type_equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cyrs`.`data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cyrs`.`data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL,
  `meaning` VARCHAR(255) NULL,
  `equipment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_data_equipment1_idx` (`equipment_id` ASC) VISIBLE,
  CONSTRAINT `fk_data_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `cyrs`.`equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    
    -- пример добавления данных в таблицы
    
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('ТОРЖОК', ' Р.ТВЕРЦА', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('СТАРИЦА', ' P.BOЛГA', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('	БЕЖЕЦК', 'Р.МОЛОГА', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('	БЕЛЫЙ', '	P.OБШA', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('ВЫШНИЙ ВОЛОЧЕК', 'Р.ВОЛГА', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('	КАШИН', 'Р.КАШИНКА', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('КРАСНЫЙ ХОЛМ', 'Р.НЕЛЕДИНО', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('	ОСТАШКОВ', 'ОЗ.СЕЛИГЕР', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('ПЕРЕСЛАВЛЬ-ЗАЛЕССКИЙ', 'ОЗ.ПЛЕЩЕЕВО', 'ЦЕНТРАЛЬНОЕ УГМС');
INSERT INTO `cyrs`.`weather_station` (`title`, `mesto`, `type`) VALUES ('	ТУТАЕВ', '	ВДХР.ГОРЬКОВСКОЕ', 'ЦЕНТРАЛЬНОЕ УГМС');

-- создание представления. В моем случае данное представление соединяется две таблицы weather_station и type_equipment с помощью JOIN

create view cyrs.station_equpment AS 
select
	e.weather_station_id
    ,we.title AS station_title
    ,we.mesto
    ,we.type
    ,e.type_equipment_id
    ,d.title AS type_equipment_title
FROM
	cyrs.equipment AS e
    JOIN cyrs.weather_station AS we ON (e.weather_station_id=we.id)	
    JOIN cyrs.type_equipment AS d ON (e.type_equipment_id=d.id)
    ;
    

-- этот запрос показывает средние показатели
SELECT 
avg(meaning)
FROM cyrs.data


;
-- этот запрос показывает количество метеостанций на озере 
SELECT count(*) FROM cyrs.weather_station
where mesto like '%ОЗ.%'
;


SELECT 
data.meaning,
equipment.type_equipment_id,
type_equipment.title



FROM cyrs.data
join equipment
on equipment.id = equipment_id
join type_equipment
on type_equipment.id = type_equipment_id
;



SELECT * FROM cyrs.data
where data like '%2021%'
;

SELECT 

type_equipment.title,
type_equipment.dimension_id,
dimension.title


 FROM cyrs.type_equipment
 join dimension
 on dimension.id = dimension_id
 
 where dimension.title = 'гидрологический'
 


;

DELIMITER $$
create DEFINER=`root`@`localhost` PROCEDURE weather_station_add(IN _title varchar(255), in _mesto varchar(255), in _type varchar(255))
begin 
	INSERT INTO cyrs.weather_station (title,mesto,type) VALUES (_title,_mesto,_type);
END$$
DELIMITER ;


use cyrs;
delimiter //
create procedure cyrs.weather_station_delete( in _id int)
begin 
	DELETE FROM cyrs.weather_station WHERE id =_id;
END 
//
