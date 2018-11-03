CREATE DATABASE  IF NOT EXISTS `policeinformationdeparment` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `policeinformationdeparment`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: policeinformationdeparment
-- ------------------------------------------------------
-- Server version	5.6.36-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `arrest`
--

DROP TABLE IF EXISTS `arrest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arrest` (
  `ArrestId` varchar(20) NOT NULL,
  `DateOfArrest` date DEFAULT NULL,
  `Reason` varchar(100) DEFAULT NULL,
  `PoliceId` varchar(20) NOT NULL,
  `CellNumber` varchar(20) NOT NULL,
  `ArrestedId` varchar(20) NOT NULL,
  PRIMARY KEY (`ArrestId`),
  KEY `fk_Arrest_Police1_idx` (`PoliceId`),
  KEY `fk_Arrest_PrisonCell1_idx` (`CellNumber`),
  KEY `fk_Arrest_Arrested1_idx` (`ArrestedId`),
  CONSTRAINT `fk_Arrest_Arrested1` FOREIGN KEY (`ArrestedId`) REFERENCES `arrested` (`ArrestedId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arrest_Police1` FOREIGN KEY (`PoliceId`) REFERENCES `police` (`PoliceId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Arrest_PrisonCell1` FOREIGN KEY (`CellNumber`) REFERENCES `prisoncell` (`CellNumber`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrest`
--

LOCK TABLES `arrest` WRITE;
/*!40000 ALTER TABLE `arrest` DISABLE KEYS */;
INSERT INTO `arrest` VALUES ('Arr1','2017-04-04','Arrested for rough driving','Pol1','BosCell00','Arrested1'),('Arr2','2017-05-05','Charges of Murder','Pol1','BosCell00','Arrested2'),('Arr3','2017-05-05','Arrested for rough driving','Pol1','BosCell00','Arrested3'),('Arr4','2017-06-07','Charges of Murder','Pol2','IndCell01','Arrested4'),('Arr5','2017-07-08','Charges of Murder','Pol2','IndCell01','Arrested5'),('Arr6','2017-08-09','Charges of Rape','Pol2','IndCell01','Arrested6');
/*!40000 ALTER TABLE `arrest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arrestcrime`
--

DROP TABLE IF EXISTS `arrestcrime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arrestcrime` (
  `CrimeId` varchar(20) NOT NULL,
  `ArrestId` varchar(20) NOT NULL,
  KEY `fk_ArrestCrime_Crime1_idx` (`CrimeId`),
  KEY `fk_ArrestCrime_Arrest1_idx` (`ArrestId`),
  CONSTRAINT `fk_ArrestCrime_Arrest1` FOREIGN KEY (`ArrestId`) REFERENCES `arrest` (`ArrestId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ArrestCrime_Crime1` FOREIGN KEY (`CrimeId`) REFERENCES `crime` (`CrimeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrestcrime`
--

LOCK TABLES `arrestcrime` WRITE;
/*!40000 ALTER TABLE `arrestcrime` DISABLE KEYS */;
INSERT INTO `arrestcrime` VALUES ('crime1','Arr1'),('crime2','Arr2'),('crime1','Arr3'),('crime2','Arr4'),('crime2','Arr5'),('crime3','Arr6');
/*!40000 ALTER TABLE `arrestcrime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arrested`
--

DROP TABLE IF EXISTS `arrested`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arrested` (
  `ArrestedId` varchar(20) NOT NULL,
  `ArrestedFirstName` varchar(20) DEFAULT NULL,
  `ArrestedLastName` varchar(20) DEFAULT NULL,
  `ArrestationCity` varchar(20) DEFAULT NULL,
  `ArrestationState` varchar(20) DEFAULT NULL,
  `ArrestationZipCode` int(20) DEFAULT NULL,
  `CriminalId` varchar(20) DEFAULT NULL,
  `Status` varchar(45) NOT NULL,
  PRIMARY KEY (`ArrestedId`),
  KEY `fk_Arrested_Criminal1_idx` (`CriminalId`),
  CONSTRAINT `fk_Arrested_Criminal1` FOREIGN KEY (`CriminalId`) REFERENCES `criminal` (`CriminalId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrested`
--

LOCK TABLES `arrested` WRITE;
/*!40000 ALTER TABLE `arrested` DISABLE KEYS */;
INSERT INTO `arrested` VALUES ('Arrested1','Pablo','Escobar','Boston','Ma',2115,'criminal1','Guilty'),('Arrested2','osama','laden','Boston','Ma',3116,'criminal2','Guilty'),('Arrested3','Nikunj','Singh','Boston','Ma',2115,'criminal3','Pending'),('Arrested4','Chetan','Mistry','Boston','Ma',2115,'criminal4','Not Guilty'),('Arrested5','Harsh','Shah','Boston','Ma',2115,'criminal5','Guilty'),('Arrested6','Shreyas','Kal','Boston','Ma',2155,'criminal6','Not Guilty');
/*!40000 ALTER TABLE `arrested` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crime`
--

DROP TABLE IF EXISTS `crime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crime` (
  `CrimeId` varchar(20) NOT NULL,
  `CrimeType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CrimeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crime`
--

LOCK TABLES `crime` WRITE;
/*!40000 ALTER TABLE `crime` DISABLE KEYS */;
INSERT INTO `crime` VALUES ('crime1','Speeding'),('crime2','Murder'),('crime3','Rape');
/*!40000 ALTER TABLE `crime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `criminal`
--

DROP TABLE IF EXISTS `criminal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criminal` (
  `CriminalId` varchar(20) NOT NULL,
  `CriminalFirstName` varchar(20) DEFAULT NULL,
  `CriminalLastName` varchar(20) DEFAULT NULL,
  `BloodTestResult` varchar(20) DEFAULT NULL,
  `SpermTestResult` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CriminalId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criminal`
--

LOCK TABLES `criminal` WRITE;
/*!40000 ALTER TABLE `criminal` DISABLE KEYS */;
INSERT INTO `criminal` VALUES ('criminal1','Pablo','Escobar','B+','3'),('criminal2','osama','laden','A+','2'),('criminal3','Nikunj','Singh','O+','2'),('criminal4','Chetan','Mistry','A-','3'),('criminal5','Harsh','Shah','B+','1'),('criminal6','Shreyas','Kal','0-','3');
/*!40000 ALTER TABLE `criminal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `criminalcrime`
--

DROP TABLE IF EXISTS `criminalcrime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criminalcrime` (
  `CriminalId` varchar(20) NOT NULL,
  `CrimeId` varchar(20) NOT NULL,
  KEY `fk_CriminalCrime_Crime1_idx` (`CrimeId`),
  KEY `fk_CriminalCrime_Criminal1` (`CriminalId`),
  CONSTRAINT `fk_CriminalCrime_Crime1` FOREIGN KEY (`CrimeId`) REFERENCES `crime` (`CrimeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CriminalCrime_Criminal1` FOREIGN KEY (`CriminalId`) REFERENCES `criminal` (`CriminalId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criminalcrime`
--

LOCK TABLES `criminalcrime` WRITE;
/*!40000 ALTER TABLE `criminalcrime` DISABLE KEYS */;
INSERT INTO `criminalcrime` VALUES ('criminal1','crime1'),('criminal2','crime2'),('criminal3','crime1'),('criminal4','crime2'),('criminal5','crime2'),('criminal6','crime3');
/*!40000 ALTER TABLE `criminalcrime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `DepartmentName` varchar(20) NOT NULL,
  `ClassCode` varchar(20) NOT NULL,
  PRIMARY KEY (`ClassCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('CBI','BOSCBI'),('FBI','BOSFBI');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departmentstation`
--

DROP TABLE IF EXISTS `departmentstation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departmentstation` (
  `StationCode` varchar(20) NOT NULL,
  `ClassCode` varchar(20) NOT NULL,
  KEY `fk_DepartmentStation_PoliceStation1_idx` (`StationCode`),
  KEY `fk_DepartmentStation_Department1_idx` (`ClassCode`),
  CONSTRAINT `fk_DepartmentStation_Department1` FOREIGN KEY (`ClassCode`) REFERENCES `department` (`ClassCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DepartmentStation_PoliceStation1` FOREIGN KEY (`StationCode`) REFERENCES `policestation` (`StationCode`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departmentstation`
--

LOCK TABLES `departmentstation` WRITE;
/*!40000 ALTER TABLE `departmentstation` DISABLE KEYS */;
INSERT INTO `departmentstation` VALUES ('BOS2115','BOSCBI'),('BOS3116','BOSFBI');
/*!40000 ALTER TABLE `departmentstation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `judge_decision`
--

DROP TABLE IF EXISTS `judge_decision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `judge_decision` (
  `JudgeId` varchar(20) NOT NULL,
  `JudgeFirstName` varchar(45) DEFAULT NULL,
  `JudgeDecision` varchar(45) NOT NULL,
  `ArrestedId` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`JudgeId`),
  KEY `fk_Judge_Decision_Arrested1_idx` (`ArrestedId`),
  CONSTRAINT `fk_Judge_Decision_Arrested1` FOREIGN KEY (`ArrestedId`) REFERENCES `arrested` (`ArrestedId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `judge_decision`
--

LOCK TABLES `judge_decision` WRITE;
/*!40000 ALTER TABLE `judge_decision` DISABLE KEYS */;
INSERT INTO `judge_decision` VALUES ('judge1','Anil','Guilty','Arrested1'),('judge2','Punita','Guilty','Arrested2'),('judge4','Maya','Not Guilty','Arrested4'),('judge5','Punita','Guilty','Arrested5'),('judge6','Mohini','Not Guilty','Arrested6');
/*!40000 ALTER TABLE `judge_decision` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger Judgetrigger
 After Insert on judge_decision
 for each row
 Begin
-- Declare arrestedId1 varchar(20);
 update arrested set status= 'Guilty' where ArrestedId IN (select ArrestedId from judge_decision where judgedecision ='Guilty');
 update arrested set status= 'Not Guilty' where ArrestedId IN (select ArrestedId from judge_decision where judgedecision ='NOT Guilty');
-- select arrestedid from arrested where status='Not Guilty' into arrestedId1;
-- update arrest set cellnumber='' Where ArrestId IN (select arrestedid from arrested where arrestedid=arrestedid1);
-- arrestedid=arrestedId1; 
-- in (select cellnumber from arrest where arrestedId1 in (select arrestedid from arrested where status='Not Guilty') );

 End */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `police`
--

DROP TABLE IF EXISTS `police`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `police` (
  `PoliceId` varchar(20) NOT NULL,
  `Town` varchar(20) DEFAULT NULL,
  `DateOfJoining` date DEFAULT NULL,
  `FirstName` varchar(20) DEFAULT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  `StationCode` varchar(20) NOT NULL,
  `VehicleId` varchar(20) NOT NULL,
  PRIMARY KEY (`PoliceId`),
  UNIQUE KEY `PoliceId_UNIQUE` (`PoliceId`),
  KEY `fk_Police_PoliceStation1_idx` (`StationCode`),
  KEY `fk_Police_Vehicle1_idx` (`VehicleId`),
  CONSTRAINT `fk_Police_PoliceStation1` FOREIGN KEY (`StationCode`) REFERENCES `policestation` (`StationCode`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Police_Vehicle1` FOREIGN KEY (`VehicleId`) REFERENCES `vehicle` (`VehicleId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `police`
--

LOCK TABLES `police` WRITE;
/*!40000 ALTER TABLE `police` DISABLE KEYS */;
INSERT INTO `police` VALUES ('Pol1','Arlington','2017-01-01','James','Bond','BOS2115','MA1234'),('Pol2','Churchgate','2016-02-02','Robo','Cop','BOS3116','MA5678');
/*!40000 ALTER TABLE `police` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `policedepartmentvehicles`
--

DROP TABLE IF EXISTS `policedepartmentvehicles`;
/*!50001 DROP VIEW IF EXISTS `policedepartmentvehicles`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `policedepartmentvehicles` AS SELECT 
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `DateOfJoining`,
 1 AS `STATIONCODE`,
 1 AS `Street`,
 1 AS `City`,
 1 AS `State`,
 1 AS `ZipCode`,
 1 AS `DepartmentName`,
 1 AS `VEHICLETYPE`,
 1 AS `VEHICLEBRAND`,
 1 AS `VEHICLEMODEL`,
 1 AS `SEATS`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `policestation`
--

DROP TABLE IF EXISTS `policestation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policestation` (
  `StationCode` varchar(20) NOT NULL,
  `Street` varchar(20) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` varchar(20) DEFAULT NULL,
  `ZipCode` int(10) DEFAULT NULL,
  PRIMARY KEY (`StationCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policestation`
--

LOCK TABLES `policestation` WRITE;
/*!40000 ALTER TABLE `policestation` DISABLE KEYS */;
INSERT INTO `policestation` VALUES ('BOS2115','Fenway','Boston','MA',2115),('BOS3116','Andheri','Mumbai','MH',3116);
/*!40000 ALTER TABLE `policestation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `policewitnesscrim`
--

DROP TABLE IF EXISTS `policewitnesscrim`;
/*!50001 DROP VIEW IF EXISTS `policewitnesscrim`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `policewitnesscrim` AS SELECT 
 1 AS `firstname`,
 1 AS `lastname`,
 1 AS `Reason`,
 1 AS `ARRESTEDFIRSTNAME`,
 1 AS `ARRESTEDLASTNAME`,
 1 AS `STATUS`,
 1 AS `BloodTestResult`,
 1 AS `SpermTestResult`,
 1 AS `CRIMETYPE`,
 1 AS `witnessfirstname`,
 1 AS `witnesslastname`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `prisoncell`
--

DROP TABLE IF EXISTS `prisoncell`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prisoncell` (
  `CellNumber` varchar(20) NOT NULL,
  `Capacity` int(255) DEFAULT NULL,
  `StationCode` varchar(20) NOT NULL,
  PRIMARY KEY (`CellNumber`),
  KEY `fk_PrisonCell_PoliceStation1_idx` (`StationCode`),
  CONSTRAINT `fk_PrisonCell_PoliceStation1` FOREIGN KEY (`StationCode`) REFERENCES `policestation` (`StationCode`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prisoncell`
--

LOCK TABLES `prisoncell` WRITE;
/*!40000 ALTER TABLE `prisoncell` DISABLE KEYS */;
INSERT INTO `prisoncell` VALUES ('BosCell00',100,'BOS2115'),('IndCell01',200,'BOS3116');
/*!40000 ALTER TABLE `prisoncell` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `VehicleId` varchar(20) NOT NULL,
  `VehicleType` varchar(20) DEFAULT NULL,
  `VehicleBrand` varchar(20) DEFAULT NULL,
  `VehicleModel` varchar(20) DEFAULT NULL,
  `Seats` int(20) DEFAULT NULL,
  PRIMARY KEY (`VehicleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('MA1234','SUV','Ford','Explorer',7),('MA5678','Muscle','Ford','Mustang',5);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `witness`
--

DROP TABLE IF EXISTS `witness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `witness` (
  `WitnessId` varchar(20) NOT NULL,
  `CellPhone` int(15) DEFAULT NULL,
  `WitnessFirstName` varchar(20) DEFAULT NULL,
  `WitnessLastName` varchar(20) DEFAULT NULL,
  `WitnessCity` varchar(20) DEFAULT NULL,
  `WitnessState` varchar(20) DEFAULT NULL,
  `WitnessZipCode` int(20) DEFAULT NULL,
  PRIMARY KEY (`WitnessId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `witness`
--

LOCK TABLES `witness` WRITE;
/*!40000 ALTER TABLE `witness` DISABLE KEYS */;
INSERT INTO `witness` VALUES ('witness1',11234567,'Yusuf','Ozbek','Boston','MA',2115),('witness2',11345667,'shruti','mehta','Mumbai','MH',2115),('witness3',93234598,'Tianqi','Singh','Dubai','UAE',3116);
/*!40000 ALTER TABLE `witness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `witnesscrime`
--

DROP TABLE IF EXISTS `witnesscrime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `witnesscrime` (
  `CrimeId` varchar(20) NOT NULL,
  `WitnessId` varchar(20) NOT NULL,
  KEY `fk_WitnessCrime_Witness1_idx` (`WitnessId`),
  KEY `fk_WitnessCrime_Crime1` (`CrimeId`),
  CONSTRAINT `fk_WitnessCrime_Crime1` FOREIGN KEY (`CrimeId`) REFERENCES `crime` (`CrimeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_WitnessCrime_Witness1` FOREIGN KEY (`WitnessId`) REFERENCES `witness` (`WitnessId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `witnesscrime`
--

LOCK TABLES `witnesscrime` WRITE;
/*!40000 ALTER TABLE `witnesscrime` DISABLE KEYS */;
INSERT INTO `witnesscrime` VALUES ('crime1','witness1'),('crime2','witness2'),('crime3','witness3');
/*!40000 ALTER TABLE `witnesscrime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'policeinformationdeparment'
--

--
-- Dumping routines for database 'policeinformationdeparment'
--
/*!50003 DROP PROCEDURE IF EXISTS `abc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `abc`()
begin
update arrested set status= 'Guilty' where ArrestedId IN (select ArrestedId from judge_decision where judgedecision ='Guilty');
update arrested set status= 'Not Guilty' where ArrestedId IN (select ArrestedId from judge_decision where judgedecision ='NOT Guilty');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `def` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `def`()
begin 
delete from arrest where cellnumber in (select cellnumber from arrest where arrestedid in (select arrestedid from arrested where status='Not Guilty') );
End ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PoliceArrest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PoliceArrest`()
begin
select distinct A.PoliceId AS Police_Identity_Number,A.FirstName,A.LastName,D.StationCode,B.DateOfArrest,E.ArrestedFirstName,E.ArrestedLastName ,B.Reason,E.ArrestationCity,E.ArrestationState,E.ArrestationZipCode,E.Status,C.CellNumber
from Police AS A Inner join arrest AS B
on (A.policeid=B.policeId)
inner join arrested AS E
on(E.ArrestedId = B.ArrestedId)
Inner join prisoncell AS C
on(B.cellNumber=C.CellNumber)
INNER JOIN policestation AS D
on(C.StationCode=D.StationCode);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PoliceArrests` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PoliceArrests`()
begin
select distinct A.PoliceId AS PoliceId,A.FirstName,A.LastName,D.StationCode,B.DateOfArrest,E.ArrestedFirstName,E.ArrestedLastName ,B.Reason,E.ArrestationCity,E.ArrestationState,E.ArrestationZipCode,E.Status,C.CellNumber
from Police AS A Inner join arrest AS B
on (A.policeid=B.policeId)
inner join arrested AS E
on(E.ArrestedId = B.ArrestedId)
Inner join prisoncell AS C
on(B.cellNumber=C.CellNumber)
INNER JOIN policestation AS D
on(C.StationCode=D.StationCode);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PoliceInformation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PoliceInformation`()
Begin 
SELECT distinct A.PoliceId , A.FirstName, A.LastName,A.Town,A.DateOfJoining,
B.VehicleId,B.VehicleType AS Type ,B.VehicleBrand AS Brand,B.VehicleModel AS Model,B.Seats AS Seats,
C.StationCode ,C.Street,C.City,C.State,C.ZipCode,
E.DepartmentName,
F.DateOfArrest,F.Reason,
G.ArrestedFirstName,G.ArrestedLastName,G.ArrestationCity,G.ArrestationState,G.ArrestationZipCode,G.Status,
H.CellNumber AS PrisonCellNumber,H.CAPACITY AS Capacity,
J.CRIMETYPE AS TypeOfCrime,
L.WitnessFirstName,L.WitnessLastName,L.CELLPHONE AS MobileNumber,L.WITNESSCITY As WitnessCity,L.WITNESSSTATE As State,L.WITNESSZIPCODE AS ZipCode
FROM POLICE AS A
INNER JOIN VEHICLE AS B
ON(A.VEHICLEID=B.VEHICLEID)
INNER JOIN POLICESTATION AS C
ON(A.STATIONCODE=C.STATIONCODE)
INNER JOIN departmentstation AS D
ON(D.stationCode=C.STAtioncode)
inner join department as E
ON (E.ClassCode=D.CLASSCODE)
INNER JOIN ARREST AS F
ON(F.POLICEID=A.POLICEID)
INNER JOIN ARRESTED AS G
ON(G.ARRESTEDID=F.ARRESTEDID) 
INNER JOIN PRISONCELL AS H
ON(H.STATIONCODE=C.STATIONCODE)
INNER JOIN ARRESTCRIME AS I
ON (I.ARRESTID=F.ARRESTID)
INNER JOIN CRIME AS J
ON(J.CRIMEID=I.CRIMEID)
INNER JOIN witnesscrime AS K
ON(K.CRIMEID=J.CRIMEID)
INNER JOIN WITNESS AS L
ON(L.WITNESSID=K.WITNESSID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `policedepartmentvehicles`
--

/*!50001 DROP VIEW IF EXISTS `policedepartmentvehicles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `policedepartmentvehicles` AS select distinct `a`.`FirstName` AS `FirstName`,`a`.`LastName` AS `LastName`,`a`.`DateOfJoining` AS `DateOfJoining`,`b`.`StationCode` AS `STATIONCODE`,`b`.`Street` AS `Street`,`b`.`City` AS `City`,`b`.`State` AS `State`,`b`.`ZipCode` AS `ZipCode`,`d`.`DepartmentName` AS `DepartmentName`,`e`.`VehicleType` AS `VEHICLETYPE`,`e`.`VehicleBrand` AS `VEHICLEBRAND`,`e`.`VehicleModel` AS `VEHICLEMODEL`,`e`.`Seats` AS `SEATS` from ((((`police` `a` join `policestation` `b` on((`a`.`StationCode` = `b`.`StationCode`))) join `departmentstation` `c` on((`b`.`StationCode` = `c`.`StationCode`))) join `department` `d` on((`c`.`ClassCode` = `d`.`ClassCode`))) join `vehicle` `e` on((`e`.`VehicleId` = `a`.`VehicleId`))) group by `a`.`FirstName`,`a`.`LastName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `policewitnesscrim`
--

/*!50001 DROP VIEW IF EXISTS `policewitnesscrim`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `policewitnesscrim` AS select distinct `a`.`FirstName` AS `firstname`,`a`.`LastName` AS `lastname`,`b`.`Reason` AS `Reason`,`c`.`ArrestedFirstName` AS `ARRESTEDFIRSTNAME`,`c`.`ArrestedLastName` AS `ARRESTEDLASTNAME`,`c`.`Status` AS `STATUS`,`d`.`BloodTestResult` AS `BloodTestResult`,`d`.`SpermTestResult` AS `SpermTestResult`,`f`.`CrimeType` AS `CRIMETYPE`,`h`.`WitnessFirstName` AS `witnessfirstname`,`h`.`WitnessLastName` AS `witnesslastname` from (((((((`police` `a` left join `arrest` `b` on((`a`.`PoliceId` = `b`.`PoliceId`))) left join `arrested` `c` on((`b`.`ArrestedId` = `c`.`ArrestedId`))) left join `criminal` `d` on((`c`.`CriminalId` = `d`.`CriminalId`))) left join `arrestcrime` `e` on((`e`.`ArrestId` = `b`.`ArrestId`))) left join `crime` `f` on((`f`.`CrimeId` = `e`.`CrimeId`))) left join `witnesscrime` `g` on((`g`.`CrimeId` = `f`.`CrimeId`))) left join `witness` `h` on((`h`.`WitnessId` = `g`.`WitnessId`))) */;
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

-- Dump completed on 2017-12-13 23:48:27
