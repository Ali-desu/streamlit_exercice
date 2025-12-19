-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: iscaeproject
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `candidature`
--

CREATE DATABASE IF NOT EXISTS ISCAEBDD;
USE ISCAEBDD;

DROP TABLE IF EXISTS `candidature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidature` (
  `id_candidature` int NOT NULL AUTO_INCREMENT,
  `date_candit` date DEFAULT NULL,
  `statut_candit` varchar(50) DEFAULT NULL,
  `commentaire_statut` text,
  `id_etudiant` int DEFAULT NULL,
  `id_offre` int DEFAULT NULL,
  PRIMARY KEY (`id_candidature`),
  KEY `fk_cand_etud` (`id_etudiant`),
  KEY `fk_cand_offre` (`id_offre`),
  CONSTRAINT `fk_cand_etud` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`),
  CONSTRAINT `fk_cand_offre` FOREIGN KEY (`id_offre`) REFERENCES `offre_stage` (`id_offre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidature`
--

LOCK TABLES `candidature` WRITE;
/*!40000 ALTER TABLE `candidature` DISABLE KEYS */;
INSERT INTO `candidature` VALUES (1,'2025-02-01','en_attente','',1,1),(2,'2025-02-03','accepte','Bonne fit',2,2),(3,'2025-02-05','refuse','Manque expérience',3,3),(4,'2025-02-10','accepte','Bon profil',4,4),(5,'2025-02-12','en_attente','',5,5);
/*!40000 ALTER TABLE `candidature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competence`
--

DROP TABLE IF EXISTS `competence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competence` (
  `id_competence` int NOT NULL AUTO_INCREMENT,
  `libelle_compt` varchar(100) DEFAULT NULL,
  `description_compt` text,
  PRIMARY KEY (`id_competence`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competence`
--

LOCK TABLES `competence` WRITE;
/*!40000 ALTER TABLE `competence` DISABLE KEYS */;
INSERT INTO `competence` VALUES (1,'JavaScript','Dev front/back'),(2,'SQL','Gestion BD relationnelle'),(3,'Finance','Analyse financière'),(4,'Audit','Audit interne'),(5,'Marketing','Marketing digital'),(6,'Excel','Tableaux & reporting'),(7,'Réseaux','Infrastructures réseau'),(8,'Analyse données','Data analysis'),(9,'Excel avancé','Pivot, macros, reporting'),(10,'Analyse financière','Ratios, bilans'),(11,'Marketing digital','SEO, Social Ads'),(12,'Audit interne','Normes & procédures'),(13,'Python','Scripting & data'),(14,'Communication','Oral & écrit'),(15,'Gestion de projet','Planification, Agile'),(16,'SQL','Requêtes et BD');
/*!40000 ALTER TABLE `competence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encadrant`
--

DROP TABLE IF EXISTS `encadrant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encadrant` (
  `id_encadrant` int NOT NULL AUTO_INCREMENT,
  `nom_enc` varchar(100) DEFAULT NULL,
  `prenom_enc` varchar(100) DEFAULT NULL,
  `departement_enc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_encadrant`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encadrant`
--

LOCK TABLES `encadrant` WRITE;
/*!40000 ALTER TABLE `encadrant` DISABLE KEYS */;
INSERT INTO `encadrant` VALUES (1,'Hassan','Mouline','Finance'),(2,'Yassine','El Amrani','Audit'),(3,'Salma','Naciri','Marketing'),(4,'Boughaleb','Rachid','Finance'),(5,'El Hadi','Leila','Marketing'),(6,'Bouazza','Sami','Audit');
/*!40000 ALTER TABLE `encadrant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entreprise`
--

DROP TABLE IF EXISTS `entreprise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entreprise` (
  `id_entreprise` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) DEFAULT NULL,
  `secteur_activite` varchar(100) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `nom_contact` varchar(100) DEFAULT NULL,
  `tel_contact` varchar(20) DEFAULT NULL,
  `email_contact` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_entreprise`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entreprise`
--

LOCK TABLES `entreprise` WRITE;
/*!40000 ALTER TABLE `entreprise` DISABLE KEYS */;
INSERT INTO `entreprise` VALUES (1,'TechCorp','Informatique','Rue A 10','Samir','0522001100','contact@techcorp.com'),(2,'BankPlus','Finance','Rue B 12','Leila','0522002200','contact@bankplus.com'),(3,'AuditPro','Audit','Rue C 5','Youssef','0522003300','contact@auditpro.com'),(4,'MarketWay','Marketing','Rue D 20','Salma','0522004400','contact@marketway.com'),(5,'NovaFinance','Finance','Av. Centrale 1','Samir','212600000101','hr@novafinance.com'),(6,'BrightMarket','Marketing','Rue du Marché 2','Laila','212600000102','jobs@brightmarket.com'),(7,'AuditLine','Audit','Bd. Auditeurs 3','Karim','212600000103','recrutement@auditline.com'),(8,'TechWave','IT','Zone Tech 4','Noureddine','212600000104','hello@techwave.ma'),(9,'GreenAgro','Agro','Route Verte 5','Salma','212600000105','contact@greenagro.ma');
/*!40000 ALTER TABLE `entreprise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiant`
--

DROP TABLE IF EXISTS `etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant` (
  `id_etudiant` int NOT NULL AUTO_INCREMENT,
  `nom_etd` varchar(100) DEFAULT NULL,
  `prenom_etd` varchar(100) DEFAULT NULL,
  `filiere_etd` varchar(50) DEFAULT NULL,
  `email_etd` varchar(150) DEFAULT NULL,
  `telephone_etd` varchar(20) DEFAULT NULL,
  `id_formation` int DEFAULT NULL,
  PRIMARY KEY (`id_etudiant`),
  KEY `fk_etudiant_formation` (`id_formation`),
  CONSTRAINT `fk_etudiant_formation` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id_formation`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant`
--

LOCK TABLES `etudiant` WRITE;
/*!40000 ALTER TABLE `etudiant` DISABLE KEYS */;
INSERT INTO `etudiant` VALUES (1,'Ben','Ali','Tronc commun','ali.ben@mail.com','0601010101',1),(2,'Sara','Idrissi','Finance','sara.idrissi@mail.com','0602020202',2),(3,'Amal','Karim','Audit','amal.karim@mail.com','0603030303',3),(4,'Mehdi','Othman','Marketing','mehdi.othman@mail.com','0604040404',4),(5,'Lina','Fassi','Tronc commun','lina.fassi@mail.com','0605050505',5),(6,'Daoud','Ilyas','Finance','ilyas.d@iscae.ma','212600000201',6),(7,'Nour','Amina','Marketing','amina.n@iscae.ma','212600000202',7),(8,'Said','Yassine','Tronc commun','yassine.s@iscae.ma','212600000203',8),(9,'Rania','Sara','Data','sara.r@iscae.ma','212600000204',9),(10,'Karim','Omar','Audit','omar.k@iscae.ma','212600000205',10),(11,'Lina','Fatima','Finance','fatima.l@iscae.ma','212600000206',1),(12,'Hamid','Youssef','Marketing','youssef.h@iscae.ma','212600000207',2),(13,'Meryem','Zahra','Tronc commun','zahra.m@iscae.ma','212600000208',3),(14,'Walid','Ibrahim','Data','ibrahim.w@iscae.ma','212600000209',4),(15,'Nadia','Sofia','Audit','sofia.n@iscae.ma','212600000210',5);
/*!40000 ALTER TABLE `etudiant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiant_possede_competence`
--

DROP TABLE IF EXISTS `etudiant_possede_competence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiant_possede_competence` (
  `id_etudiant` int NOT NULL,
  `id_competence` int NOT NULL,
  `proficiency` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_etudiant`,`id_competence`),
  KEY `idx_epc_comp` (`id_competence`),
  CONSTRAINT `fk_epc_comp` FOREIGN KEY (`id_competence`) REFERENCES `competence` (`id_competence`),
  CONSTRAINT `fk_epc_etud` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiant_possede_competence`
--

LOCK TABLES `etudiant_possede_competence` WRITE;
/*!40000 ALTER TABLE `etudiant_possede_competence` DISABLE KEYS */;
INSERT INTO `etudiant_possede_competence` VALUES (1,1,3),(1,2,4),(2,3,5),(2,6,4),(3,4,4),(3,6,5),(4,5,4),(5,2,3),(5,8,2),(6,9,4),(6,10,3),(6,16,2),(7,11,4),(7,14,3),(7,16,2),(8,9,2),(8,14,2),(9,13,4),(9,16,3),(10,9,3),(10,12,3),(11,9,4),(11,10,3),(12,11,3),(12,14,3),(13,16,1),(14,13,3),(14,16,3),(15,12,2),(15,14,2);
/*!40000 ALTER TABLE `etudiant_possede_competence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evaluation` (
  `id_evaluation` int NOT NULL AUTO_INCREMENT,
  `id_etudiant` int DEFAULT NULL,
  `id_competence` int DEFAULT NULL,
  `score_obtenu` decimal(5,2) DEFAULT NULL,
  `score_max` decimal(5,2) DEFAULT NULL,
  `date_eval` date DEFAULT NULL,
  PRIMARY KEY (`id_evaluation`),
  KEY `fk_eval_etud` (`id_etudiant`),
  KEY `fk_eval_comp` (`id_competence`),
  CONSTRAINT `fk_eval_comp` FOREIGN KEY (`id_competence`) REFERENCES `competence` (`id_competence`),
  CONSTRAINT `fk_eval_etud` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation`
--

LOCK TABLES `evaluation` WRITE;
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` VALUES (1,1,1,70.00,100.00,'2024-12-01'),(2,1,2,85.00,100.00,'2024-12-02'),(3,2,3,95.00,100.00,'2024-12-03'),(4,1,1,70.00,100.00,'2024-12-01'),(5,1,2,85.00,100.00,'2024-12-02'),(6,2,3,95.00,100.00,'2024-12-03');
/*!40000 ALTER TABLE `evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formation`
--

DROP TABLE IF EXISTS `formation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formation` (
  `id_formation` int NOT NULL AUTO_INCREMENT,
  `nom_form` varchar(100) DEFAULT NULL,
  `type_form` varchar(50) DEFAULT NULL,
  `niveau_form` varchar(50) DEFAULT NULL,
  `date_debut_form` date DEFAULT NULL,
  `date_fin_form` date DEFAULT NULL,
  `certifi_disp_form` varchar(100) DEFAULT NULL,
  `institution_form` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_formation`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formation`
--

LOCK TABLES `formation` WRITE;
/*!40000 ALTER TABLE `formation` DISABLE KEYS */;
INSERT INTO `formation` VALUES (1,'Informatique','Licence','L3','2024-09-01','2025-06-30','Certif Dev','ISCAE'),(2,'Management','Master','M1','2024-09-01','2025-06-30','Certif Gestion','ISCAE'),(3,'Audit & Finance','Master','M2','2024-09-01','2025-06-30','Certif Audit','ISCAE'),(4,'Tronc Commun Première Année','Licence','L1','2023-09-01','2024-06-30',NULL,'ISCAE'),(5,'M1 Finance','Master','M1','2023-09-01','2024-06-30',NULL,'ISCAE'),(6,'M1 Marketing','Master','M1','2023-09-01','2024-06-30',NULL,'ISCAE'),(7,'M2 Audit et Contrôle','Master','M2','2023-09-01','2024-06-30',NULL,'ISCAE'),(8,'M2 Finance de Marché','Master','M2','2023-09-01','2024-06-30',NULL,'ISCAE'),(9,'M1 Audit','Master','M1','2023-09-01','2024-06-30',NULL,'ISCAE'),(10,'M2 Marketing Digital','Master','M2','2023-09-01','2024-06-30',NULL,'ISCAE');
/*!40000 ALTER TABLE `formation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offre_require_competence`
--

DROP TABLE IF EXISTS `offre_require_competence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offre_require_competence` (
  `id_offre` int NOT NULL,
  `id_competence` int NOT NULL,
  `poids` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_offre`,`id_competence`),
  KEY `idx_orc_comp` (`id_competence`),
  CONSTRAINT `fk_orc_comp` FOREIGN KEY (`id_competence`) REFERENCES `competence` (`id_competence`),
  CONSTRAINT `fk_orc_offre` FOREIGN KEY (`id_offre`) REFERENCES `offre_stage` (`id_offre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre_require_competence`
--

LOCK TABLES `offre_require_competence` WRITE;
/*!40000 ALTER TABLE `offre_require_competence` DISABLE KEYS */;
INSERT INTO `offre_require_competence` VALUES (1,1,2),(1,2,1),(2,3,3),(2,6,1),(3,4,2),(3,6,1),(4,5,3),(5,2,1),(5,7,2),(6,9,3),(6,10,5),(6,16,2),(7,11,5),(7,14,2),(7,16,1),(8,9,2),(8,12,4),(8,14,1),(9,10,1),(9,13,8),(9,16,5),(10,14,2),(10,15,6),(10,16,1);
/*!40000 ALTER TABLE `offre_require_competence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offre_stage`
--

DROP TABLE IF EXISTS `offre_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offre_stage` (
  `id_offre` int NOT NULL AUTO_INCREMENT,
  `poste_stg` varchar(150) DEFAULT NULL,
  `description_stg` text,
  `duree_stg` int DEFAULT NULL,
  `remuneration_stg` decimal(10,2) DEFAULT NULL,
  `date_publication_stg` date DEFAULT NULL,
  `id_entreprise` int DEFAULT NULL,
  PRIMARY KEY (`id_offre`),
  KEY `fk_offre_entreprise` (`id_entreprise`),
  CONSTRAINT `fk_offre_entreprise` FOREIGN KEY (`id_entreprise`) REFERENCES `entreprise` (`id_entreprise`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offre_stage`
--

LOCK TABLES `offre_stage` WRITE;
/*!40000 ALTER TABLE `offre_stage` DISABLE KEYS */;
INSERT INTO `offre_stage` VALUES (1,'Dev Web','Fullstack junior',90,1500.00,'2025-01-10',1),(2,'Analyste Finance','Analyse de risque',120,2000.00,'2025-01-15',2),(3,'Assistant Audit','Audit interne',60,1200.00,'2025-01-20',3),(4,'Marketing Digital','Gestion des réseaux sociaux',45,1000.00,'2025-01-25',4),(5,'Support IT','Assistance technique',30,900.00,'2025-02-01',1),(6,'Analyste Junior','Reporting & modélisation financière',6,3200.00,'2024-03-01',5),(7,'Assistant Marketing','Campagnes & analytics',4,2100.00,'2024-03-10',6),(8,'Stagiaire Audit','Travail terrain & rapports',5,2500.00,'2024-02-20',7),(9,'Data Intern','ETL & dashboards',6,3000.00,'2024-04-01',8),(10,'Chef de projet junior','PMO & coordination',5,2300.00,'2024-03-15',8);
/*!40000 ALTER TABLE `offre_stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage`
--

DROP TABLE IF EXISTS `stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stage` (
  `id_stage` int NOT NULL AUTO_INCREMENT,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `id_etudiant` int DEFAULT NULL,
  `id_offre` int DEFAULT NULL,
  `id_encadrant` int DEFAULT NULL,
  PRIMARY KEY (`id_stage`),
  KEY `fk_stage_offre` (`id_offre`),
  KEY `fk_stage_encadrant` (`id_encadrant`),
  KEY `idx_stage_etud` (`id_etudiant`),
  CONSTRAINT `fk_stage_encadrant` FOREIGN KEY (`id_encadrant`) REFERENCES `encadrant` (`id_encadrant`),
  CONSTRAINT `fk_stage_etud` FOREIGN KEY (`id_etudiant`) REFERENCES `etudiant` (`id_etudiant`),
  CONSTRAINT `fk_stage_offre` FOREIGN KEY (`id_offre`) REFERENCES `offre_stage` (`id_offre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage`
--

LOCK TABLES `stage` WRITE;
/*!40000 ALTER TABLE `stage` DISABLE KEYS */;
INSERT INTO `stage` VALUES (1,'2025-03-01','2025-05-01',2,2,1),(2,'2025-03-10','2025-04-20',3,3,2),(3,'2025-03-15','2025-04-30',4,4,3);
/*!40000 ALTER TABLE `stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage_competence`
--

DROP TABLE IF EXISTS `stage_competence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stage_competence` (
  `id_stage` int NOT NULL,
  `id_competence` int NOT NULL,
  `niveau` tinyint NOT NULL,
  `commentaire` text,
  PRIMARY KEY (`id_stage`,`id_competence`),
  KEY `idx_stage_comp` (`id_competence`),
  CONSTRAINT `fk_sc_comp` FOREIGN KEY (`id_competence`) REFERENCES `competence` (`id_competence`),
  CONSTRAINT `fk_sc_stage` FOREIGN KEY (`id_stage`) REFERENCES `stage` (`id_stage`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage_competence`
--

LOCK TABLES `stage_competence` WRITE;
/*!40000 ALTER TABLE `stage_competence` DISABLE KEYS */;
INSERT INTO `stage_competence` VALUES (1,3,5,'Très bonne maîtrise finance'),(1,6,4,'Bon usage Excel'),(2,4,4,'Audit solide'),(2,6,5,'Excellent Excel'),(3,5,4,'Marketing appliqué');
/*!40000 ALTER TABLE `stage_competence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `summary_offre_stats`
--

DROP TABLE IF EXISTS `summary_offre_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `summary_offre_stats` (
  `id_offre` int NOT NULL DEFAULT '0',
  `poste_stg` varchar(150) DEFAULT NULL,
  `entreprise` varchar(150) DEFAULT NULL,
  `total_candidature` bigint NOT NULL DEFAULT '0',
  `nb_acceptes` decimal(23,0) DEFAULT NULL,
  `taux_accept` decimal(27,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `summary_offre_stats`
--

LOCK TABLES `summary_offre_stats` WRITE;
/*!40000 ALTER TABLE `summary_offre_stats` DISABLE KEYS */;
INSERT INTO `summary_offre_stats` VALUES (1,'Dev Web','TechCorp',1,0,0.000),(2,'Analyste Finance','BankPlus',1,1,1.000),(3,'Assistant Audit','AuditPro',1,0,0.000),(4,'Marketing Digital','MarketWay',1,1,1.000),(5,'Support IT','TechCorp',1,0,0.000),(6,'Analyste Junior','NovaFinance',0,0,NULL),(7,'Assistant Marketing','BrightMarket',0,0,NULL),(8,'Stagiaire Audit','AuditLine',0,0,NULL),(9,'Data Intern','TechWave',0,0,NULL),(10,'Chef de projet junior','TechWave',0,0,NULL);
/*!40000 ALTER TABLE `summary_offre_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-14  8:14:44
