CREATE DATABASE  IF NOT EXISTS `ranch_audit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ranch_audit`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ranch_audit
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` enum('started','closed') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit`
--

LOCK TABLES `audit` WRITE;
/*!40000 ALTER TABLE `audit` DISABLE KEYS */;
INSERT INTO `audit` VALUES (3,'End of Q4 2021','2022-08-15','started'),(4,'End of Q2 2022','2022-08-15','closed'),(5,'summer audit 2022','2022-09-14','started'),(20,'TEST','2022-12-26','started');
/*!40000 ALTER TABLE `audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_livestock`
--

DROP TABLE IF EXISTS `audit_livestock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_livestock` (
  `fk_audit_id` int NOT NULL,
  `fk_livestock_id` int NOT NULL,
  KEY `FK_tem_1` (`fk_audit_id`),
  KEY `FK_tem_2` (`fk_livestock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_livestock`
--

LOCK TABLES `audit_livestock` WRITE;
/*!40000 ALTER TABLE `audit_livestock` DISABLE KEYS */;
INSERT INTO `audit_livestock` VALUES (3,4),(3,3),(3,10),(7,13),(5,3),(5,20),(20,3),(20,1),(5,1),(5,5),(3,1),(5,7),(20,6);
/*!40000 ALTER TABLE `audit_livestock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL,
  `stage` varchar(45) DEFAULT NULL,
  `age_info` varchar(45) DEFAULT NULL,
  `weight_range` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (100,'Vitelo','a partir do nascimento até 10 meses','30kg a 200kg'),(200,'Novilho super precoce','9 meses à 14 meses','200kg a 300kg'),(300,'Novilho precoce	','15 meses à 24 meses','300kg a 450kg'),(400,'Novilho','18 meses a 28 meses','300kg a 450kg'),(500,'Boi','30 meses a 48 meses','400kg a 600kg'),(600,'Touros','entre 5 e 15 anos','700kg a 1500kg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livestock`
--

DROP TABLE IF EXISTS `livestock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livestock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `months_age` int DEFAULT NULL,
  `note` varchar(50) DEFAULT NULL,
  `fk_livestock_type_id` int NOT NULL,
  `tag` varchar(4) DEFAULT NULL,
  `fk_category_id` int NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `weight` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_UNIQUE` (`tag`),
  KEY `FK_animal_2` (`fk_livestock_type_id`),
  KEY `FK_livestock_3` (`fk_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livestock`
--

LOCK TABLES `livestock` WRITE;
/*!40000 ALTER TABLE `livestock` DISABLE KEYS */;
INSERT INTO `livestock` VALUES (1,8,'Lorem ipsum dolor',4,'125',100,'black',100),(3,13,'consectetur adipiscing elit',6,'224',300,'black',330),(4,30,'Maecenas sit amet lorem auctor',1,'200',500,'brown',510),(5,7,'pharetra ipsum non',2,'12',200,'brown',200),(6,6,'tristique felis',3,'13',100,'brown',140),(7,3,'Vivamus in lobortis odio',3,'133',200,'brown',210),(10,4,'In vehicula lorem eget ligula accumsan pulvinar',1,'134',400,'brown',450),(12,15,'Curabitur nunc nulla',5,'120',100,'mixed',110),(13,2,'Fusce consequat euismod urna',5,'122',200,'brown',210),(14,13,'condimentum at est ac',5,'2',200,'brown',200),(15,11,'Vivamus congue nisl elit non porttitor',5,'5',200,'brown',220),(16,10,'congue nisl elit non porttitor',5,'60',100,'mixed',90),(17,1,'nisl elit non porttitor',6,'1',100,'mixed',110),(19,10,'my note',1,'321',100,'black',333),(20,14,'from preview',3,'222',100,'brown',90),(21,15,'testing',1,'444',200,'black',120),(22,10,'whatever',1,'555',300,'brown',100);
/*!40000 ALTER TABLE `livestock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livestock_type`
--

DROP TABLE IF EXISTS `livestock_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livestock_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livestock_type`
--

LOCK TABLES `livestock_type` WRITE;
/*!40000 ALTER TABLE `livestock_type` DISABLE KEYS */;
INSERT INTO `livestock_type` VALUES (1,'Vacas de Leite'),(2,'Bezerros Vaca de Leite'),(3,'Gado Nelore'),(4,'Bezerros Gado Nelore'),(5,'Touros'),(6,'Gado Comum'),(8,'Garrotes'),(9,'Bezerros Apartados');
/*!40000 ALTER TABLE `livestock_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livestock_vaccine`
--

DROP TABLE IF EXISTS `livestock_vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livestock_vaccine` (
  `fk_livestock_id` int NOT NULL,
  `fk_vaccine_id` int NOT NULL,
  `date` date DEFAULT NULL,
  KEY `FK_possui_1` (`fk_livestock_id`),
  KEY `FK_possui_2` (`fk_vaccine_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livestock_vaccine`
--

LOCK TABLES `livestock_vaccine` WRITE;
/*!40000 ALTER TABLE `livestock_vaccine` DISABLE KEYS */;
INSERT INTO `livestock_vaccine` VALUES (1,1,'2022-10-21'),(1,2,'2022-10-21'),(3,2,'2022-10-20'),(3,3,'2022-10-20'),(4,3,'2022-10-19'),(6,3,'2022-10-18'),(7,3,'2022-10-18'),(7,2,'2022-10-18'),(7,1,'2022-10-18');
/*!40000 ALTER TABLE `livestock_vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccine`
--

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
INSERT INTO `vaccine` VALUES (1,'tetanus','pfizer'),(2,'malignant oedema','embrapa'),(3,'enterotoxaemia','norden');
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ranch_audit'
--

--
-- Dumping routines for database 'ranch_audit'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_audit_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_audit_name`(
	IN audit_name text
)
BEGIN
    IF (SELECT id FROM audit WHERE name = audit_name) > 0 THEN
		SELECT "duplicate";
	ELSE
		INSERT INTO audit VALUES (null, audit_name, CURRENT_DATE(), "started");
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_livestock_audit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_livestock_audit`(
IN audit_id INT,
IN livestock_tag INT
)
BEGIN

	IF (SELECT status FROM audit WHERE id = audit_id) = 'started' THEN
		IF (SELECT count(*) FROM audit_livestock WHERE fk_audit_id = audit_id 
			AND fk_livestock_id = (SELECT id FROM livestock WHERE tag = livestock_tag)) = 0 THEN
			INSERT INTO audit_livestock VALUES (audit_id, (SELECT id FROM livestock WHERE tag = livestock_tag));
		ELSE
			SELECT "Livestock is audited";
        END IF;
	ELSE
		SELECT "Audit is closed!";
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_table_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_table_exists`(table_name VARCHAR(100))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    SET @err = 0;
    SET @table_name = table_name;
    SET @sql_query = CONCAT('SELECT 1 FROM ',@table_name);
    PREPARE stmt1 FROM @sql_query;
    IF (@err = 1) THEN
        SET @table_exists = 0;
    ELSE
        SET @table_exists = 1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_temp_audit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_temp_audit`( 
IN audit_id INT
)
BEGIN
	CALL check_table_exists('temp_show_livestock_audit');
	IF @table_exists = 1 THEN 
	   DROP TEMPORARY TABLE temp_show_livestock_audit;
	END IF;
	CREATE TEMPORARY TABLE temp_show_livestock_audit	
    SELECT l.id, l.tag as "tag", lt.name as "type", l.months_age, l.note as "notes", l.weight, ca.stage FROM audit as a, audit_livestock as al, livestock as l, livestock_type as lt, category as ca
		WHERE a.id=al.fk_audit_id AND al.fk_livestock_id=l.id
		AND l.fk_livestock_type_id=lt.id AND l.fk_category_id=ca.id 
        AND a.id = audit_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_livestock_audit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_livestock_audit`(
IN audit_id INT,
IN livestock_tag INT
)
BEGIN
    	IF (SELECT count(*) FROM audit_livestock WHERE fk_audit_id = audit_id AND fk_livestock_id = (SELECT id FROM livestock WHERE tag = livestock_tag)) > 0 THEN
					DELETE FROM audit_livestock where fk_audit_id = audit_id AND fk_livestock_id = (SELECT id FROM livestock WHERE tag = livestock_tag);
		ELSE
			SELECT "Livestock is not audited";
		END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_livestock_audit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_livestock_audit`( 
IN audit_id INT
)
BEGIN
	call create_temp_audit(audit_id);
	SELECT * FROM temp_show_livestock_audit; -- Return the list of items that belog to audit_id
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_livestock_vaccines` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_livestock_vaccines`(
	IN livestock_id INT
)
BEGIN
	SELECT va.id, va.name, va.manufacturer, lv.date FROM vaccine as va, livestock_vaccine as lv, livestock as li
	WHERE li.id=lv.fk_livestock_id AND lv.fk_vaccine_id=va.id AND li.id=livestock_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_unaudited_items` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_unaudited_items`(
-- input audit_id and returns items that are not registered in that audit
	IN audit_id INT
)
BEGIN
	call create_temp_audit(audit_id);
    SELECT id, tag, months_age, note FROM livestock WHERE id NOT IN(SELECT id from  temp_show_livestock_audit);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-01 12:22:31
