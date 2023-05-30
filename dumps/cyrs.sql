CREATE DATABASE  IF NOT EXISTS `cyrs` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cyrs`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: cyrs
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `meaning` varchar(255) DEFAULT NULL,
  `equipment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_data_equipment1_idx` (`equipment_id`),
  CONSTRAINT `fk_data_equipment1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
INSERT INTO `data` VALUES (1,'2020-03-07','22',1),(2,'2021-07-09','15',2),(3,'2021-08-03','13',3),(4,'2021-09-11','17',4),(5,'2021-08-22','13',7),(6,'2022-09-25','32',5),(7,'2022-10-15','24',6),(8,'2022-10-29','1',8),(9,'2022-11-10','4',9),(10,'2022-11-05','10',3),(11,'2022-12-09','-5',7);
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dimension`
--

DROP TABLE IF EXISTS `dimension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dimension` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dimension`
--

LOCK TABLES `dimension` WRITE;
/*!40000 ALTER TABLE `dimension` DISABLE KEYS */;
INSERT INTO `dimension` VALUES (1,'гидрологический'),(2,'воздушный'),(3,'почвенный'),(4,'скоростной'),(5,'временной'),(6,'атмосферный'),(7,'температурный');
/*!40000 ALTER TABLE `dimension` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `weather_station_id` int NOT NULL,
  `type_equipment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_equipment_weather_station_idx` (`weather_station_id`),
  KEY `fk_equipment_type_equipment1_idx` (`type_equipment_id`),
  CONSTRAINT `fk_equipment_type_equipment1` FOREIGN KEY (`type_equipment_id`) REFERENCES `type_equipment` (`id`),
  CONSTRAINT `fk_equipment_weather_station` FOREIGN KEY (`weather_station_id`) REFERENCES `weather_station` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,1,3),(2,1,4),(3,2,1),(4,2,5),(5,3,3),(6,3,2),(7,4,6),(8,7,8),(9,5,1),(10,5,7),(11,6,2);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `station_equpment`
--

DROP TABLE IF EXISTS `station_equpment`;
/*!50001 DROP VIEW IF EXISTS `station_equpment`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `station_equpment` AS SELECT 
 1 AS `weather_station_id`,
 1 AS `station_title`,
 1 AS `mesto`,
 1 AS `type`,
 1 AS `type_equipment_id`,
 1 AS `type_equipment_title`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `type_equipment`
--

DROP TABLE IF EXISTS `type_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `dimension_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_type_equipment_dimension1_idx` (`dimension_id`),
  CONSTRAINT `fk_type_equipment_dimension1` FOREIGN KEY (`dimension_id`) REFERENCES `dimension` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_equipment`
--

LOCK TABLES `type_equipment` WRITE;
/*!40000 ALTER TABLE `type_equipment` DISABLE KEYS */;
INSERT INTO `type_equipment` VALUES (1,'гигрометр',1),(2,'флюгер',4),(3,'осадкометр',1),(4,'терметр для почв',7),(5,'термограф',7),(6,'барометр',6),(7,'психометр',3),(8,'секундомер',5);
/*!40000 ALTER TABLE `type_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather_station`
--

DROP TABLE IF EXISTS `weather_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_station` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `mesto` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_station`
--

LOCK TABLES `weather_station` WRITE;
/*!40000 ALTER TABLE `weather_station` DISABLE KEYS */;
INSERT INTO `weather_station` VALUES (1,'ТОРЖОК',' Р.ТВЕРЦА','ЦЕНТРАЛЬНОЕ УГМС'),(2,'СТАРИЦА',' P.BOЛГA','ЦЕНТРАЛЬНОЕ УГМС'),(3,'	БЕЖЕЦК','Р.МОЛОГА','ЦЕНТРАЛЬНОЕ УГМС'),(4,'	БЕЛЫЙ','	P.OБШA','ЦЕНТРАЛЬНОЕ УГМС'),(5,'ВЫШНИЙ ВОЛОЧЕК','Р.ВОЛГА','ЦЕНТРАЛЬНОЕ УГМС'),(6,'	КАШИН','Р.КАШИНКА','ЦЕНТРАЛЬНОЕ УГМС'),(7,'КРАСНЫЙ ХОЛМ','Р.НЕЛЕДИНО','ЦЕНТРАЛЬНОЕ УГМС'),(8,'	ОСТАШКОВ','ОЗ.СЕЛИГЕР','ЦЕНТРАЛЬНОЕ УГМС'),(9,'ПЕРЕСЛАВЛЬ-ЗАЛЕССКИЙ','ОЗ.ПЛЕЩЕЕВО','ЦЕНТРАЛЬНОЕ УГМС'),(10,'	ТУТАЕВ','	ВДХР.ГОРЬКОВСКОЕ','ЦЕНТРАЛЬНОЕ УГМС');
/*!40000 ALTER TABLE `weather_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cyrs'
--


/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `weather_station_add` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `weather_station_add`(IN _title varchar(255), in _mesto varchar(255), in _type varchar(255))
begin 
	INSERT INTO cyrs.weather_station (title,mesto,type) VALUES (_title,_mesto,_type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `weather_station_delete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `weather_station_delete`( in _id int)
begin 
	DELETE FROM cyrs.weather_station WHERE id =_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `station_equpment`
--

/*!50001 DROP VIEW IF EXISTS `station_equpment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `station_equpment` AS select `e`.`weather_station_id` AS `weather_station_id`,`we`.`title` AS `station_title`,`we`.`mesto` AS `mesto`,`we`.`type` AS `type`,`e`.`type_equipment_id` AS `type_equipment_id`,`d`.`title` AS `type_equipment_title` from ((`equipment` `e` join `weather_station` `we` on((`e`.`weather_station_id` = `we`.`id`))) join `type_equipment` `d` on((`e`.`type_equipment_id` = `d`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


