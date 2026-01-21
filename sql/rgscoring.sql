-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 21, 2026 at 05:58 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rgscoring`
--

-- --------------------------------------------------------

--
-- Table structure for table `apparatus`
--

CREATE TABLE `apparatus` (
  `apparatusID` int(11) NOT NULL,
  `apparatusName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apparatus`
--

INSERT INTO `apparatus` (`apparatusID`, `apparatusName`) VALUES
(1, 'Ball'),
(2, 'Clubs'),
(3, 'Hoop'),
(4, 'Ribbon'),
(5, 'Free Hand');

-- --------------------------------------------------------

--
-- Table structure for table `clerk`
--

CREATE TABLE `clerk` (
  `clerkID` int(11) NOT NULL,
  `clerkName` varchar(50) NOT NULL,
  `clerkUsername` varchar(50) DEFAULT NULL,
  `clerkPassword` varchar(50) DEFAULT NULL,
  `staffID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clerk`
--

INSERT INTO `clerk` (`clerkID`, `clerkName`, `clerkUsername`, `clerkPassword`, `staffID`) VALUES
(136, 'clerk', 'clerk', '123', 1);

-- --------------------------------------------------------

--
-- Table structure for table `coach`
--

CREATE TABLE `coach` (
  `coachIC` varchar(50) NOT NULL,
  `fisioIC` varchar(30) DEFAULT NULL,
  `coachName` varchar(50) DEFAULT NULL,
  `coachPOD` varchar(50) DEFAULT NULL,
  `fisioName` varchar(50) DEFAULT NULL,
  `fisioPOD` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coach`
--

INSERT INTO `coach` (`coachIC`, `fisioIC`, `coachName`, `coachPOD`, `fisioName`, `fisioPOD`) VALUES
('-', '-', '-', '-', '-', '-'),
('--', '-', '-', '-', '-', '-'),
('Et ratione dolores l', 'Tempor omnis volupta', 'Basil Dillard', 'Aspernatur laudantiu', 'Camille Best', 'Veniam accusantium ');

-- --------------------------------------------------------

--
-- Table structure for table `composite`
--

CREATE TABLE `composite` (
  `compositeID` int(11) NOT NULL,
  `gymnastID` int(11) DEFAULT NULL,
  `teamID` int(11) DEFAULT NULL,
  `apparatusID` int(11) DEFAULT NULL,
  `scoreID` int(11) DEFAULT NULL,
  `judgeID` int(11) DEFAULT NULL,
  `eventID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `composite`
--

INSERT INTO `composite` (`compositeID`, `gymnastID`, `teamID`, `apparatusID`, `scoreID`, `judgeID`, `eventID`) VALUES
(22, 13, 10, 3, 13, NULL, 6),
(23, 13, 10, 4, 14, NULL, 6),
(24, 14, 10, 3, 15, NULL, 6),
(25, 14, 10, 4, 16, NULL, 6),
(26, 15, 10, 3, 17, NULL, 8),
(27, 15, 10, 4, 18, NULL, 8),
(30, 17, 10, 3, 21, NULL, 8),
(31, 17, 10, 5, 22, NULL, 8),
(34, 19, 10, 3, 25, NULL, 8),
(35, 19, 10, 5, 26, NULL, 8),
(36, 20, 10, 3, 27, NULL, 8),
(37, 20, 10, 5, 28, NULL, 8),
(38, 21, 10, 3, 29, NULL, 8),
(39, 21, 10, 5, NULL, NULL, 8),
(40, 18, 10, 5, 30, NULL, 8),
(41, 18, 10, 3, NULL, NULL, 8),
(43, 22, 13, 1, NULL, NULL, 8),
(44, 22, 13, 5, NULL, NULL, 8),
(50, 27, 10, 2, NULL, NULL, 6);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `eventID` int(11) NOT NULL,
  `eventName` varchar(100) NOT NULL,
  `eventDate` varchar(50) NOT NULL,
  `clerkID` int(11) NOT NULL,
  `teamID` int(11) DEFAULT NULL COMMENT 'Organization that owns this event',
  `createdBy` int(11) DEFAULT NULL COMMENT 'staffID of superadmin who created this event',
  `hasJuryScreen` tinyint(1) DEFAULT 0,
  `juryAccessCode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`eventID`, `eventName`, `eventDate`, `clerkID`, `teamID`, `createdBy`, `hasJuryScreen`, `juryAccessCode`) VALUES
(6, 'SINGAPORE ', '2024-07-02', 136, 10, 2, 0, NULL),
(8, 'MALAYSIA OPEN', '2024-06-24', 136, 10, 2, 0, NULL),
(9, 'Glenna Adkins', '2024-06-30', 136, 11, 2, 0, NULL),
(10, 'MSSD', '2026-01-20', 1, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `event_judge_config`
--

CREATE TABLE `event_judge_config` (
  `configID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `positionTypeID` int(11) NOT NULL,
  `isActive` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `final_score`
--

CREATE TABLE `final_score` (
  `finalScoreID` int(11) NOT NULL,
  `sessionID` int(11) NOT NULL,
  `scoreDifficultyBody` decimal(5,3) DEFAULT NULL,
  `scoreDifficultyApparatus` decimal(5,3) DEFAULT NULL,
  `scoreDTotal` decimal(5,3) DEFAULT NULL,
  `scoreArtistic` decimal(5,3) DEFAULT NULL,
  `scoreExecution` decimal(5,3) DEFAULT NULL,
  `technicalDeduction` decimal(5,3) DEFAULT 0.000,
  `lineDeduction` decimal(5,3) DEFAULT 0.000,
  `timeDeduction` decimal(5,3) DEFAULT 0.000,
  `finalScore` decimal(5,3) DEFAULT NULL,
  `calculatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gymnast`
--

CREATE TABLE `gymnast` (
  `gymnastID` int(11) NOT NULL,
  `gymnastIC` varchar(50) DEFAULT NULL,
  `gymnastICPic` varchar(100) DEFAULT NULL,
  `gymnastName` varchar(50) DEFAULT NULL,
  `gymnastSchool` varchar(50) NOT NULL,
  `gymnastCategory` varchar(50) DEFAULT NULL,
  `clerkID` int(11) DEFAULT NULL,
  `teamID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gymnast`
--

INSERT INTO `gymnast` (`gymnastID`, `gymnastIC`, `gymnastICPic`, `gymnastName`, `gymnastSchool`, `gymnastCategory`, `clerkID`, `teamID`) VALUES
(13, '-', 'CHIAHZIHSUAN_-.avif', 'CHIAH ZI HSUANS', '-', 'U12', NULL, 10),
(14, '-', 'SHANTELLEYEOSHUTEIN_-.avif', 'SHANTELLE YEO SHU TEIN', '-', 'U12', NULL, 10),
(15, '-', 'ChuenXinYi_-.avif', 'CHUEN XIN YI', '-', 'U12', NULL, 10),
(17, '-', 'CHEAHENYA_-.avif', 'CHEAH ENYA', '-', 'U9', NULL, 10),
(18, '-', 'GWILESHYAN_-.avif', 'GWI LESHYAN', '-', 'U9', NULL, 10),
(19, '-', 'THAMWINXI_-.avif', 'THAM WIN XI', '-', 'U9', NULL, 10),
(20, '-', 'LOOIENYA_-.avif', 'LOOI ENYA', '-', 'U9', NULL, 10),
(21, '-', 'LOOSHERYUI_-.jpg', 'LOO SHER YUI', '-', 'U9', NULL, 11),
(22, 'Sed amet neque quas', 'PhoebeKeith_Sed amet neque quas.jpg', 'Phoebe Keith', 'Quis ut dolor qui in', 'U12', NULL, 13),
(23, 'Et est ducimus quis', 'MontanaMcneil_Et est ducimus quis.png', 'Montana Mcneil', 'Beatae eaque sed nul', 'U9', NULL, 10),
(24, 'Et est ducimus quis', 'MontanaMcneil_Et est ducimus quis.png', 'Montana Mcneil', 'Beatae eaque sed nul', 'U9', NULL, 10),
(25, 'Et est ducimus quis', 'MontanaMcneil_Et est ducimus quis.png', 'Montana Mcneil', 'Beatae eaque sed nul', 'U9', NULL, 11),
(27, 'Placeat et voluptat', 'AugustMatthews_Placeat et voluptat.png', 'August Matthews', 'Quis impedit et vol', 'U12', NULL, 10),
(28, 'Dolor voluptas dicta', 'GrantMcgee_Dolor voluptas dicta.png', 'Grant Mcgee', 'Eu do molestiae et q', 'U9', NULL, 10);

-- --------------------------------------------------------

--
-- Table structure for table `gymnast_app`
--

CREATE TABLE `gymnast_app` (
  `appID` int(11) NOT NULL,
  `gymnastID` int(11) NOT NULL,
  `apparatusID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gymnast_app`
--

INSERT INTO `gymnast_app` (`appID`, `gymnastID`, `apparatusID`, `eventID`) VALUES
(51, 13, 3, 6),
(52, 13, 4, 6),
(53, 14, 3, 6),
(54, 14, 4, 6),
(55, 15, 3, 8),
(56, 15, 4, 8),
(69, 17, 3, 8),
(70, 17, 5, 8),
(73, 19, 3, 8),
(74, 19, 5, 8),
(75, 20, 3, 8),
(76, 20, 5, 8),
(77, 21, 5, 8),
(78, 18, 5, 8),
(79, 18, 3, 8),
(81, 22, 1, 8),
(82, 22, 5, 8),
(83, 22, 2, 8),
(84, 23, 2, 8),
(85, 24, 2, 8),
(86, 25, 2, 8),
(91, 27, 2, 6);

-- --------------------------------------------------------

--
-- Table structure for table `headjudge`
--

CREATE TABLE `headjudge` (
  `headjudgeID` int(11) NOT NULL,
  `headName` varchar(50) NOT NULL,
  `headUsername` varchar(50) DEFAULT NULL,
  `headPassword` varchar(50) DEFAULT NULL,
  `clerkID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `headjudge`
--

INSERT INTO `headjudge` (`headjudgeID`, `headName`, `headUsername`, `headPassword`, `clerkID`) VALUES
(62, 'headjudge', 'headjudge', '123', 136),
(64, 'Clementine Juarez', 'konuxi', 'Pa$$w0rd!', 136);

-- --------------------------------------------------------

--
-- Table structure for table `judge`
--

CREATE TABLE `judge` (
  `judgeID` int(11) NOT NULL,
  `judgeName` varchar(50) DEFAULT NULL,
  `judgeNoIc` varchar(30) DEFAULT NULL,
  `judgePOD` varchar(50) DEFAULT NULL,
  `teamID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `judge`
--

INSERT INTO `judge` (`judgeID`, `judgeName`, `judgeNoIc`, `judgePOD`, `teamID`) VALUES
(21, 'MISS AFF', '-', '-', 10);

-- --------------------------------------------------------

--
-- Table structure for table `judge_position_type`
--

CREATE TABLE `judge_position_type` (
  `positionTypeID` int(11) NOT NULL,
  `positionCode` varchar(10) NOT NULL,
  `positionName` varchar(50) NOT NULL,
  `panelNumber` int(11) NOT NULL,
  `category` enum('DB','DA','A','E','TV','AV','AVB','EXE','LINE','TIME','RJ') NOT NULL,
  `scoreMin` decimal(5,3) DEFAULT 0.000,
  `scoreMax` decimal(5,3) DEFAULT 10.000,
  `isRequired` tinyint(1) DEFAULT 1,
  `displayOrder` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `judge_position_type`
--

INSERT INTO `judge_position_type` (`positionTypeID`, `positionCode`, `positionName`, `panelNumber`, `category`, `scoreMin`, `scoreMax`, `isRequired`, `displayOrder`) VALUES
(1, 'DB1', 'Difficulty Body 1', 1, 'DB', 0.000, 10.000, 1, 1),
(2, 'DB2', 'Difficulty Body 2', 1, 'DB', 0.000, 10.000, 1, 2),
(3, 'DB3', 'Difficulty Body 3', 1, 'DB', 0.000, 10.000, 1, 3),
(4, 'DB4', 'Difficulty Body 4', 1, 'DB', 0.000, 10.000, 1, 4),
(5, 'DA1', 'Difficulty Apparatus 1', 1, 'DA', 0.000, 10.000, 1, 5),
(6, 'DA2', 'Difficulty Apparatus 2', 1, 'DA', 0.000, 10.000, 1, 6),
(7, 'DA3', 'Difficulty Apparatus 3', 1, 'DA', 0.000, 10.000, 1, 7),
(8, 'DA4', 'Difficulty Apparatus 4', 1, 'DA', 0.000, 10.000, 1, 8),
(9, 'A1', 'Artistic 1', 1, 'A', 0.000, 10.000, 1, 9),
(10, 'A2', 'Artistic 2', 1, 'A', 0.000, 10.000, 1, 10),
(11, 'A3', 'Artistic 3', 1, 'A', 0.000, 10.000, 1, 11),
(12, 'A4', 'Artistic 4', 1, 'A', 0.000, 10.000, 1, 12),
(13, 'E1', 'Execution 1', 1, 'E', 0.000, 10.000, 1, 13),
(14, 'E2', 'Execution 2', 1, 'E', 0.000, 10.000, 1, 14),
(15, 'E3', 'Execution 3', 1, 'E', 0.000, 10.000, 1, 15),
(16, 'E4', 'Execution 4', 1, 'E', 0.000, 10.000, 1, 16),
(17, 'E5', 'Execution 5', 1, 'E', 0.000, 10.000, 1, 17),
(18, 'E6', 'Execution 6', 1, 'E', 0.000, 10.000, 1, 18),
(19, 'E7', 'Execution 7', 1, 'E', 0.000, 10.000, 1, 19),
(20, 'E8', 'Execution 8', 1, 'E', 0.000, 10.000, 1, 20),
(21, 'TV1', 'Video Technical 1', 1, 'TV', 0.000, 10.000, 1, 21),
(22, 'TV2', 'Video Technical 2', 1, 'TV', 0.000, 10.000, 1, 22),
(23, 'TV3', 'Video Technical 3', 1, 'TV', 0.000, 10.000, 1, 23),
(24, 'TV4', 'Video Technical 4', 1, 'TV', 0.000, 10.000, 1, 24),
(25, 'AV1', 'Video Artistic 1', 1, 'AV', 0.000, 10.000, 1, 25),
(26, 'AV2', 'Video Artistic 2', 1, 'AV', 0.000, 10.000, 1, 26),
(27, 'AV3', 'Video Artistic 3', 1, 'AV', 0.000, 10.000, 1, 27),
(28, 'AV4', 'Video Artistic 4', 1, 'AV', 0.000, 10.000, 1, 28),
(29, 'AVB1', 'Video Artistic Body 1', 1, 'AVB', 0.000, 10.000, 1, 29),
(30, 'AVB2', 'Video Artistic Body 2', 1, 'AVB', 0.000, 10.000, 1, 30),
(31, 'AVB3', 'Video Artistic Body 3', 1, 'AVB', 0.000, 10.000, 1, 31),
(32, 'AVB4', 'Video Artistic Body 4', 1, 'AVB', 0.000, 10.000, 1, 32),
(33, 'EXE1', 'Execution Extra 1', 1, 'EXE', 0.000, 10.000, 1, 33),
(34, 'EXE2', 'Execution Extra 2', 1, 'EXE', 0.000, 10.000, 1, 34),
(35, 'EXE3', 'Execution Extra 3', 1, 'EXE', 0.000, 10.000, 1, 35),
(36, 'EXE4', 'Execution Extra 4', 1, 'EXE', 0.000, 10.000, 1, 36),
(37, 'L1', 'Line Judge 1', 1, 'LINE', 0.000, 10.000, 1, 37),
(38, 'L2', 'Line Judge 2', 1, 'LINE', 0.000, 10.000, 1, 38),
(39, 'L3', 'Line Judge 3', 1, 'LINE', 0.000, 10.000, 1, 39),
(40, 'L4', 'Line Judge 4', 1, 'LINE', 0.000, 10.000, 1, 40),
(41, 'T1', 'Time Judge', 1, 'TIME', 0.000, 10.000, 1, 41),
(42, 'RJ', 'Reference Judge', 1, 'RJ', 0.000, 10.000, 1, 42),
(43, 'P2_DB1', 'Panel 2 Difficulty Body 1', 2, 'DB', 0.000, 10.000, 1, 101),
(44, 'P2_DB2', 'Panel 2 Difficulty Body 2', 2, 'DB', 0.000, 10.000, 1, 102),
(45, 'P2_DB3', 'Panel 2 Difficulty Body 3', 2, 'DB', 0.000, 10.000, 1, 103),
(46, 'P2_DB4', 'Panel 2 Difficulty Body 4', 2, 'DB', 0.000, 10.000, 1, 104),
(47, 'P2_DA1', 'Panel 2 Difficulty Apparatus 1', 2, 'DA', 0.000, 10.000, 1, 105),
(48, 'P2_DA2', 'Panel 2 Difficulty Apparatus 2', 2, 'DA', 0.000, 10.000, 1, 106),
(49, 'P2_DA3', 'Panel 2 Difficulty Apparatus 3', 2, 'DA', 0.000, 10.000, 1, 107),
(50, 'P2_DA4', 'Panel 2 Difficulty Apparatus 4', 2, 'DA', 0.000, 10.000, 1, 108),
(51, 'P2_A1', 'Panel 2 Artistic 1', 2, 'A', 0.000, 10.000, 1, 109),
(52, 'P2_A2', 'Panel 2 Artistic 2', 2, 'A', 0.000, 10.000, 1, 110),
(53, 'P2_A3', 'Panel 2 Artistic 3', 2, 'A', 0.000, 10.000, 1, 111),
(54, 'P2_A4', 'Panel 2 Artistic 4', 2, 'A', 0.000, 10.000, 1, 112),
(55, 'P2_E1', 'Panel 2 Execution 1', 2, 'E', 0.000, 10.000, 1, 113),
(56, 'P2_E2', 'Panel 2 Execution 2', 2, 'E', 0.000, 10.000, 1, 114),
(57, 'P2_E3', 'Panel 2 Execution 3', 2, 'E', 0.000, 10.000, 1, 115),
(58, 'P2_E4', 'Panel 2 Execution 4', 2, 'E', 0.000, 10.000, 1, 116),
(59, 'P2_E5', 'Panel 2 Execution 5', 2, 'E', 0.000, 10.000, 1, 117),
(60, 'P2_E6', 'Panel 2 Execution 6', 2, 'E', 0.000, 10.000, 1, 118),
(61, 'P2_E7', 'Panel 2 Execution 7', 2, 'E', 0.000, 10.000, 1, 119),
(62, 'P2_E8', 'Panel 2 Execution 8', 2, 'E', 0.000, 10.000, 1, 120),
(63, 'P2_TV1', 'Panel 2 Video Technical 1', 2, 'TV', 0.000, 10.000, 1, 121),
(64, 'P2_TV2', 'Panel 2 Video Technical 2', 2, 'TV', 0.000, 10.000, 1, 122),
(65, 'P2_TV3', 'Panel 2 Video Technical 3', 2, 'TV', 0.000, 10.000, 1, 123),
(66, 'P2_TV4', 'Panel 2 Video Technical 4', 2, 'TV', 0.000, 10.000, 1, 124),
(67, 'P2_AV1', 'Panel 2 Video Artistic 1', 2, 'AV', 0.000, 10.000, 1, 125),
(68, 'P2_AV2', 'Panel 2 Video Artistic 2', 2, 'AV', 0.000, 10.000, 1, 126),
(69, 'P2_AV3', 'Panel 2 Video Artistic 3', 2, 'AV', 0.000, 10.000, 1, 127),
(70, 'P2_AV4', 'Panel 2 Video Artistic 4', 2, 'AV', 0.000, 10.000, 1, 128),
(71, 'P2_AVB1', 'Panel 2 Video Artistic Body 1', 2, 'AVB', 0.000, 10.000, 1, 129),
(72, 'P2_AVB2', 'Panel 2 Video Artistic Body 2', 2, 'AVB', 0.000, 10.000, 1, 130),
(73, 'P2_AVB3', 'Panel 2 Video Artistic Body 3', 2, 'AVB', 0.000, 10.000, 1, 131),
(74, 'P2_AVB4', 'Panel 2 Video Artistic Body 4', 2, 'AVB', 0.000, 10.000, 1, 132),
(75, 'P2_EXE1', 'Panel 2 Execution Extra 1', 2, 'EXE', 0.000, 10.000, 1, 133),
(76, 'P2_EXE2', 'Panel 2 Execution Extra 2', 2, 'EXE', 0.000, 10.000, 1, 134),
(77, 'P2_EXE3', 'Panel 2 Execution Extra 3', 2, 'EXE', 0.000, 10.000, 1, 135),
(78, 'P2_EXE4', 'Panel 2 Execution Extra 4', 2, 'EXE', 0.000, 10.000, 1, 136),
(79, 'P2_L1', 'Panel 2 Line Judge 1', 2, 'LINE', 0.000, 10.000, 1, 137),
(80, 'P2_L2', 'Panel 2 Line Judge 2', 2, 'LINE', 0.000, 10.000, 1, 138),
(81, 'P2_L3', 'Panel 2 Line Judge 3', 2, 'LINE', 0.000, 10.000, 1, 139),
(82, 'P2_L4', 'Panel 2 Line Judge 4', 2, 'LINE', 0.000, 10.000, 1, 140),
(83, 'P2_T1', 'Panel 2 Time Judge', 2, 'TIME', 0.000, 10.000, 1, 141),
(84, 'P2_RJ', 'Panel 2 Reference Judge', 2, 'RJ', 0.000, 10.000, 1, 142);

-- --------------------------------------------------------

--
-- Table structure for table `jury_score`
--

CREATE TABLE `jury_score` (
  `juryScoreID` int(11) NOT NULL,
  `sessionID` int(11) NOT NULL,
  `positionTypeID` int(11) NOT NULL,
  `scoreValue` decimal(5,3) DEFAULT NULL,
  `submittedAt` timestamp NULL DEFAULT NULL,
  `isOverridden` tinyint(1) DEFAULT 0,
  `overriddenBy` int(11) DEFAULT NULL,
  `overrideReason` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jury_session`
--

CREATE TABLE `jury_session` (
  `sessionID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `startListID` int(11) NOT NULL,
  `sessionStatus` enum('WAITING','SCORING','SUBMITTED','FINALIZED') DEFAULT 'WAITING',
  `startedAt` timestamp NULL DEFAULT NULL,
  `submittedAt` timestamp NULL DEFAULT NULL,
  `finalizedAt` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `score`
--

CREATE TABLE `score` (
  `scoreID` int(11) NOT NULL,
  `scoreD1` double(5,2) DEFAULT NULL,
  `scoreD2` double(5,2) DEFAULT NULL,
  `scoreD3` double(5,2) DEFAULT NULL,
  `scoreD4` double(5,2) DEFAULT NULL,
  `scoreA1` double(5,2) DEFAULT NULL,
  `scoreA2` double(5,2) DEFAULT NULL,
  `scoreA3` double(5,2) DEFAULT NULL,
  `scoreE1` double(5,2) DEFAULT NULL,
  `scoreE2` double(5,2) DEFAULT NULL,
  `scoreE3` double(5,2) DEFAULT NULL,
  `technicalDeduction` double(5,2) DEFAULT NULL,
  `judgeID` int(11) DEFAULT NULL,
  `gymnastID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `score`
--

INSERT INTO `score` (`scoreID`, `scoreD1`, `scoreD2`, `scoreD3`, `scoreD4`, `scoreA1`, `scoreA2`, `scoreA3`, `scoreE1`, `scoreE2`, `scoreE3`, `technicalDeduction`, `judgeID`, `gymnastID`) VALUES
(11, 1.80, 0.00, 2.30, 0.00, 3.40, 0.00, 0.00, 2.50, 0.00, 0.00, 0.00, 21, 12),
(12, 1.60, 0.00, 0.90, 0.00, 3.20, 0.00, 0.00, 3.40, 0.00, 0.00, 0.00, 21, 12),
(13, 1.30, 0.00, 0.90, 0.00, 4.80, 0.00, 0.00, 3.90, 0.00, 0.00, 0.00, 21, 13),
(14, 0.90, 0.00, 1.10, 0.00, 3.60, 0.00, 0.00, 3.60, 0.00, 0.00, 0.00, 21, 13),
(15, 3.80, 0.00, 1.50, 0.00, 4.20, 0.00, 0.00, 3.30, 0.00, 0.00, 0.00, 21, 14),
(16, 1.50, 0.00, 3.40, 0.00, 2.50, 0.00, 0.00, 2.50, 0.00, 0.00, 0.00, 21, 14),
(17, 3.90, 0.00, 2.50, 0.00, 3.00, 0.00, 0.00, 2.50, 0.00, 0.00, 0.00, 21, 15),
(18, 1.60, 0.00, 1.50, 0.00, 3.10, 0.00, 0.00, 3.50, 0.00, 0.00, 0.00, 21, 15),
(19, 1.70, 0.00, 1.20, 0.00, 2.80, 0.00, 0.00, 2.50, 0.00, 0.00, 0.00, 21, 16),
(20, 1.10, 0.00, 0.90, 0.00, 3.80, 0.00, 0.00, 3.10, 0.00, 0.00, 0.00, 21, 16),
(21, 1.40, 0.00, 1.10, 0.00, 3.60, 0.00, 0.00, 2.20, 0.00, 0.00, 0.00, 21, 17),
(22, 0.00, 0.00, 1.90, 0.00, 2.70, 0.00, 0.00, 2.30, 0.00, 0.00, 0.00, 21, 17),
(23, 1.30, 0.00, 1.10, 0.00, 3.40, 0.00, 0.00, 2.40, 0.00, 0.00, 0.00, 21, 18),
(24, 0.00, 0.00, 2.00, 0.00, 23.00, 0.00, 0.00, 2.00, 0.00, 0.00, 0.00, 21, 18),
(25, 0.70, 0.00, 0.60, 0.00, 3.10, 0.00, 0.00, 4.30, 0.00, 0.00, 0.00, 21, 19),
(26, 0.00, 0.00, 0.90, 0.00, 4.00, 0.00, 0.00, 2.70, 0.00, 0.00, 0.00, 21, 19),
(27, 0.50, 0.00, 0.50, 0.00, 4.20, 0.00, 0.00, 4.50, 0.00, 0.00, 0.00, 21, 20),
(28, 0.00, 0.00, 1.00, 0.00, 3.00, 0.00, 0.00, 2.20, 0.00, 0.00, 0.00, 21, 20),
(29, 0.00, 0.00, 2.10, 0.00, 2.50, 0.00, 0.00, 2.00, 0.00, 0.00, 0.00, 21, 21),
(30, 1.00, 1.00, 1.00, 12.00, 2.00, 1.00, 1.00, 3.00, 1.00, 2.00, 1.00, 21, 18);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staffID` int(11) NOT NULL,
  `staffUsername` varchar(50) DEFAULT NULL,
  `staffPassword` varchar(50) DEFAULT NULL,
  `staffRole` enum('staff','superadmin') DEFAULT 'staff'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staffID`, `staffUsername`, `staffPassword`, `staffRole`) VALUES
(1, 'staff', 'staff', 'staff'),
(2, 'superadmin', 'superadmin123', 'superadmin');

-- --------------------------------------------------------

--
-- Table structure for table `start_list`
--

CREATE TABLE `start_list` (
  `startListID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `gymnastID` int(11) NOT NULL,
  `apparatusID` int(11) NOT NULL,
  `competitionDay` int(11) DEFAULT 1,
  `batchNumber` int(11) DEFAULT 1,
  `startOrder` int(11) NOT NULL,
  `randomSeed` int(11) DEFAULT NULL,
  `isFinalized` tinyint(1) DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `teamID` int(11) NOT NULL,
  `teamName` varchar(50) DEFAULT NULL,
  `coachIC` varchar(50) DEFAULT NULL,
  `orgUsername` varchar(50) DEFAULT NULL,
  `orgPassword` varchar(50) DEFAULT NULL,
  `orgStatus` enum('active','inactive') DEFAULT 'active',
  `createdBy` int(11) DEFAULT NULL COMMENT 'staffID of superadmin who created this organization'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`teamID`, `teamName`, `coachIC`, `orgUsername`, `orgPassword`, `orgStatus`, `createdBy`) VALUES
(10, 'REA', '-', 'rea_org', 'rea123', 'active', 2),
(11, 'ELEGANZA RYTHMIC GYMNASTIC', '--', 'eleganza_org', 'eleganza123', 'active', 2),
(13, 'Vanna Harmon', 'Et ratione dolores l', NULL, NULL, 'active', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apparatus`
--
ALTER TABLE `apparatus`
  ADD PRIMARY KEY (`apparatusID`);

--
-- Indexes for table `clerk`
--
ALTER TABLE `clerk`
  ADD PRIMARY KEY (`clerkID`),
  ADD KEY `staffID` (`staffID`);

--
-- Indexes for table `coach`
--
ALTER TABLE `coach`
  ADD PRIMARY KEY (`coachIC`);

--
-- Indexes for table `composite`
--
ALTER TABLE `composite`
  ADD PRIMARY KEY (`compositeID`),
  ADD KEY `gymnastID` (`gymnastID`),
  ADD KEY `teamID` (`teamID`),
  ADD KEY `scoreID` (`scoreID`),
  ADD KEY `judgeID` (`judgeID`),
  ADD KEY `apparatusID` (`apparatusID`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`eventID`),
  ADD KEY `event_ibfk_1` (`teamID`),
  ADD KEY `event_ibfk_2` (`createdBy`);

--
-- Indexes for table `event_judge_config`
--
ALTER TABLE `event_judge_config`
  ADD PRIMARY KEY (`configID`),
  ADD UNIQUE KEY `unique_event_position` (`eventID`,`positionTypeID`),
  ADD KEY `positionTypeID` (`positionTypeID`);

--
-- Indexes for table `final_score`
--
ALTER TABLE `final_score`
  ADD PRIMARY KEY (`finalScoreID`),
  ADD UNIQUE KEY `unique_session` (`sessionID`);

--
-- Indexes for table `gymnast`
--
ALTER TABLE `gymnast`
  ADD PRIMARY KEY (`gymnastID`),
  ADD KEY `clerkID` (`clerkID`),
  ADD KEY `teamID` (`teamID`);

--
-- Indexes for table `gymnast_app`
--
ALTER TABLE `gymnast_app`
  ADD PRIMARY KEY (`appID`),
  ADD KEY `apparatusID` (`apparatusID`),
  ADD KEY `gymnastID` (`gymnastID`) USING BTREE;

--
-- Indexes for table `headjudge`
--
ALTER TABLE `headjudge`
  ADD PRIMARY KEY (`headjudgeID`),
  ADD KEY `clerkID` (`clerkID`);

--
-- Indexes for table `judge`
--
ALTER TABLE `judge`
  ADD PRIMARY KEY (`judgeID`),
  ADD KEY `teamID` (`teamID`);

--
-- Indexes for table `judge_position_type`
--
ALTER TABLE `judge_position_type`
  ADD PRIMARY KEY (`positionTypeID`),
  ADD UNIQUE KEY `positionCode` (`positionCode`);

--
-- Indexes for table `jury_score`
--
ALTER TABLE `jury_score`
  ADD PRIMARY KEY (`juryScoreID`),
  ADD UNIQUE KEY `unique_session_position` (`sessionID`,`positionTypeID`),
  ADD KEY `positionTypeID` (`positionTypeID`),
  ADD KEY `idx_jury_score_session` (`sessionID`);

--
-- Indexes for table `jury_session`
--
ALTER TABLE `jury_session`
  ADD PRIMARY KEY (`sessionID`),
  ADD KEY `startListID` (`startListID`),
  ADD KEY `idx_event_status` (`eventID`,`sessionStatus`),
  ADD KEY `idx_jury_session_event` (`eventID`);

--
-- Indexes for table `score`
--
ALTER TABLE `score`
  ADD PRIMARY KEY (`scoreID`),
  ADD KEY `judgeID` (`judgeID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staffID`);

--
-- Indexes for table `start_list`
--
ALTER TABLE `start_list`
  ADD PRIMARY KEY (`startListID`),
  ADD UNIQUE KEY `unique_event_gymnast_apparatus` (`eventID`,`gymnastID`,`apparatusID`),
  ADD KEY `gymnastID` (`gymnastID`),
  ADD KEY `apparatusID` (`apparatusID`),
  ADD KEY `idx_start_order` (`eventID`,`competitionDay`,`batchNumber`,`startOrder`),
  ADD KEY `idx_start_list_event` (`eventID`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`teamID`),
  ADD KEY `coachIC` (`coachIC`),
  ADD KEY `team_ibfk_2` (`createdBy`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clerk`
--
ALTER TABLE `clerk`
  MODIFY `clerkID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;

--
-- AUTO_INCREMENT for table `composite`
--
ALTER TABLE `composite`
  MODIFY `compositeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `eventID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `event_judge_config`
--
ALTER TABLE `event_judge_config`
  MODIFY `configID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `final_score`
--
ALTER TABLE `final_score`
  MODIFY `finalScoreID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gymnast`
--
ALTER TABLE `gymnast`
  MODIFY `gymnastID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `gymnast_app`
--
ALTER TABLE `gymnast_app`
  MODIFY `appID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `headjudge`
--
ALTER TABLE `headjudge`
  MODIFY `headjudgeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `judge`
--
ALTER TABLE `judge`
  MODIFY `judgeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `judge_position_type`
--
ALTER TABLE `judge_position_type`
  MODIFY `positionTypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `jury_score`
--
ALTER TABLE `jury_score`
  MODIFY `juryScoreID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jury_session`
--
ALTER TABLE `jury_session`
  MODIFY `sessionID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `score`
--
ALTER TABLE `score`
  MODIFY `scoreID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staffID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `start_list`
--
ALTER TABLE `start_list`
  MODIFY `startListID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `teamID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clerk`
--
ALTER TABLE `clerk`
  ADD CONSTRAINT `clerk_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`staffID`);

--
-- Constraints for table `composite`
--
ALTER TABLE `composite`
  ADD CONSTRAINT `composite_ibfk_1` FOREIGN KEY (`gymnastID`) REFERENCES `gymnast` (`gymnastID`),
  ADD CONSTRAINT `composite_ibfk_2` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`),
  ADD CONSTRAINT `composite_ibfk_3` FOREIGN KEY (`scoreID`) REFERENCES `score` (`scoreID`),
  ADD CONSTRAINT `composite_ibfk_4` FOREIGN KEY (`judgeID`) REFERENCES `judge` (`judgeID`),
  ADD CONSTRAINT `composite_ibfk_5` FOREIGN KEY (`apparatusID`) REFERENCES `apparatus` (`apparatusID`);

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_ibfk_1` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`),
  ADD CONSTRAINT `event_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `staff` (`staffID`);

--
-- Constraints for table `event_judge_config`
--
ALTER TABLE `event_judge_config`
  ADD CONSTRAINT `event_judge_config_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_judge_config_ibfk_2` FOREIGN KEY (`positionTypeID`) REFERENCES `judge_position_type` (`positionTypeID`);

--
-- Constraints for table `final_score`
--
ALTER TABLE `final_score`
  ADD CONSTRAINT `final_score_ibfk_1` FOREIGN KEY (`sessionID`) REFERENCES `jury_session` (`sessionID`) ON DELETE CASCADE;

--
-- Constraints for table `gymnast`
--
ALTER TABLE `gymnast`
  ADD CONSTRAINT `gymnast_ibfk_1` FOREIGN KEY (`clerkID`) REFERENCES `clerk` (`clerkID`),
  ADD CONSTRAINT `gymnast_ibfk_2` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`);

--
-- Constraints for table `gymnast_app`
--
ALTER TABLE `gymnast_app`
  ADD CONSTRAINT `gymnast_app_ibfk_1` FOREIGN KEY (`gymnastID`) REFERENCES `gymnast` (`gymnastID`),
  ADD CONSTRAINT `gymnast_app_ibfk_2` FOREIGN KEY (`apparatusID`) REFERENCES `apparatus` (`apparatusID`);

--
-- Constraints for table `headjudge`
--
ALTER TABLE `headjudge`
  ADD CONSTRAINT `headjudge_ibfk_1` FOREIGN KEY (`clerkID`) REFERENCES `clerk` (`clerkID`);

--
-- Constraints for table `judge`
--
ALTER TABLE `judge`
  ADD CONSTRAINT `judge_ibfk_1` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`);

--
-- Constraints for table `jury_score`
--
ALTER TABLE `jury_score`
  ADD CONSTRAINT `jury_score_ibfk_1` FOREIGN KEY (`sessionID`) REFERENCES `jury_session` (`sessionID`) ON DELETE CASCADE,
  ADD CONSTRAINT `jury_score_ibfk_2` FOREIGN KEY (`positionTypeID`) REFERENCES `judge_position_type` (`positionTypeID`);

--
-- Constraints for table `jury_session`
--
ALTER TABLE `jury_session`
  ADD CONSTRAINT `jury_session_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`) ON DELETE CASCADE,
  ADD CONSTRAINT `jury_session_ibfk_2` FOREIGN KEY (`startListID`) REFERENCES `start_list` (`startListID`);

--
-- Constraints for table `score`
--
ALTER TABLE `score`
  ADD CONSTRAINT `score_ibfk_1` FOREIGN KEY (`judgeID`) REFERENCES `judge` (`judgeID`);

--
-- Constraints for table `start_list`
--
ALTER TABLE `start_list`
  ADD CONSTRAINT `start_list_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`) ON DELETE CASCADE,
  ADD CONSTRAINT `start_list_ibfk_2` FOREIGN KEY (`gymnastID`) REFERENCES `gymnast` (`gymnastID`) ON DELETE CASCADE,
  ADD CONSTRAINT `start_list_ibfk_3` FOREIGN KEY (`apparatusID`) REFERENCES `apparatus` (`apparatusID`);

--
-- Constraints for table `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`coachIC`) REFERENCES `coach` (`coachIC`),
  ADD CONSTRAINT `team_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `staff` (`staffID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
