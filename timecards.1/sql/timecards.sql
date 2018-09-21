-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 20, 2018 at 03:10 PM
-- Server version: 5.7.23-0ubuntu0.16.04.1
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `timecards`
--
CREATE DATABASE IF NOT EXISTS `timecards` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `timecards`;

-- --------------------------------------------------------

--
-- Table structure for table `co`
--

DROP TABLE IF EXISTS `co`;
CREATE TABLE `co` (
  `id` int(11) NOT NULL,
  `goodtil` date DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `co`
--

INSERT INTO `co` (`id`, `goodtil`, `coid`) VALUES
(1, '2018-11-12', 'reroo'),
(3, '2018-11-12', 'sbs');

-- --------------------------------------------------------

--
-- Table structure for table `jobcatact`
--

DROP TABLE IF EXISTS `jobcatact`;
CREATE TABLE `jobcatact` (
  `id` int(11) NOT NULL,
  `job` varchar(60) DEFAULT NULL,
  `category` varchar(10) DEFAULT NULL,
  `active` int(1) DEFAULT NULL,
  `week` int(2) NOT NULL DEFAULT '0',
  `idx` int(11) DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jobcatact`
--

INSERT INTO `jobcatact` (`id`, `job`, `category`, `active`, `week`, `idx`, `coid`) VALUES
(602, 'Nursery', NULL, 1, 23, 2, 'reroo'),
(603, 'HYCC', 'constr', 1, 23, 4, 'reroo'),
(604, 'HYCC', 'maintain', 1, 23, 4, 'reroo'),
(605, 'HYCC', 'plant', 1, 23, 4, 'reroo'),
(606, 'Ken Wing - Rockview', NULL, 1, 23, 5, 'reroo'),
(607, 'Ken Wing - Rockview', 'constr', 1, 23, 5, 'reroo'),
(608, 'Eastie Farm', NULL, 1, 23, 6, 'reroo'),
(609, '2054 Dot Ave', NULL, 1, 23, 8, 'reroo'),
(610, '105 Green St', NULL, 1, 23, 9, 'reroo'),
(611, 'Michael Hecht - 9 Park Lane', NULL, 1, 23, 50, 'reroo'),
(612, '11 danforth', NULL, 1, 23, 53, 'reroo'),
(635, 'Nursery', NULL, 1, 31, 2, 'reroo'),
(636, 'HYCC', NULL, 1, 31, 4, 'reroo'),
(637, 'HYCC', 'constr', 1, 31, 4, 'reroo'),
(638, 'HYCC', 'maintain', 1, 31, 4, 'reroo'),
(639, 'HYCC', 'plant', 1, 31, 4, 'reroo'),
(640, 'Ken Wing - Rockview', NULL, 1, 31, 5, 'reroo'),
(641, 'Ken Wing - Rockview', 'constr', 1, 31, 5, 'reroo'),
(642, 'Eastie Farm', NULL, 1, 31, 6, 'reroo'),
(643, '15 Atherton', NULL, 1, 31, 7, 'reroo'),
(644, 'Michael Hecht - 9 Park Lane', NULL, 1, 31, 50, 'reroo'),
(645, '11 danforth', NULL, 1, 31, 53, 'reroo'),
(2322, 'Egelston Library', NULL, 1, 34, 1, 'reroo'),
(2323, '2054 Dot Ave', '', 1, 34, 3, 'reroo'),
(2324, 'HYCC', 'constr', 1, 34, 4, 'reroo'),
(2325, 'HYCC', 'maintain', 1, 34, 4, 'reroo'),
(2326, '15 Atherton', 'dogrun', 1, 34, 5, 'reroo'),
(2327, 'Marketting', NULL, 1, 34, 8, 'reroo'),
(2328, '20 Alveston', NULL, 1, 34, 10, 'reroo'),
(2329, '11 danforth', NULL, 1, 34, 50, 'reroo'),
(2330, 'Ken Wing - Rockview', '', 1, 35, 0, 'reroo'),
(2331, 'Egelston Library', NULL, 1, 35, 1, 'reroo'),
(2332, 'HYCC', 'constr', 1, 35, 4, 'reroo'),
(2333, 'HYCC', 'maintain', 1, 35, 4, 'reroo'),
(2334, '15 Atherton', 'dogrun', 1, 35, 5, 'reroo'),
(2335, 'Marketting', NULL, 1, 35, 8, 'reroo'),
(2336, '11 danforth', NULL, 1, 35, 50, 'reroo'),
(3585, '827 Centre St - Bob Min', 'Hardscape', 1, 37, 0, 'reroo'),
(3586, 'Nursery', '', 1, 37, 3, 'reroo'),
(3587, '105 Green St', NULL, 1, 37, 7, 'reroo'),
(3588, 'Marketting', NULL, 1, 37, 8, 'reroo'),
(3589, 'Roz Walter - 20 Dell', NULL, 1, 37, 12, 'reroo'),
(3590, 'Arbour Hospital', NULL, 1, 37, 21, 'reroo'),
(3591, '349 VFW Parkway - Bunny Hickey', NULL, 1, 37, 29, 'reroo'),
(3592, '241-5 Chestnut Ave', NULL, 1, 37, 37, 'reroo'),
(3593, 'JPNDC brewery', NULL, 1, 37, 39, 'reroo'),
(3594, '233 Chestnut - Greg Gulickssen', NULL, 1, 37, 45, 'reroo'),
(3595, 'connolly library', NULL, 1, 37, 51, 'reroo'),
(3791, 'HYCC', 'constr', 1, 36, 4, 'reroo'),
(3792, 'HYCC', 'maintain', 1, 36, 4, 'reroo'),
(3793, 'Eastie Farm', '', 1, 36, 6, 'reroo'),
(5171, '827 Centre St - Bob Min', 'Hardscape', 1, 38, 0, 'reroo'),
(5172, 'Nursery', '', 1, 38, 1, 'reroo'),
(5173, '105 Green St', '', 1, 38, 2, 'reroo'),
(5174, 'Roz Walter - 20 Dell', '', 1, 38, 4, 'reroo'),
(5175, 'Arbour Hospital', NULL, 1, 38, 5, 'reroo'),
(5176, 'JPNDC brewery', NULL, 1, 38, 8, 'reroo'),
(5177, 'connolly library', NULL, 1, 38, 10, 'reroo'),
(5376, '827 Centre St - Bob Min', 'Hardscape', 1, 0, 1, 'reroo'),
(5379, 'Roz Walter - 20 Dell', '', 1, 0, 3, 'reroo'),
(5380, 'Arbour Hospital', '', 1, 0, 4, 'reroo'),
(5381, '349 VFW Parkway - Bunny Hickey', NULL, 0, 0, 5, 'reroo'),
(5382, '241-5 Chestnut Ave', '', 0, 0, 6, 'reroo'),
(5383, 'JPNDC brewery', NULL, 1, 0, 7, 'reroo'),
(5384, '233 Chestnut - Greg Gulickssen', NULL, 0, 0, 8, 'reroo'),
(5385, 'connolly library', NULL, 1, 0, 9, 'reroo'),
(5386, 'Egleston Library', '', 0, 0, 10, 'reroo'),
(5387, 'HYCC', '', 0, 0, 11, 'reroo'),
(5388, 'HYCC', 'maintain', 0, 0, 11, 'reroo'),
(5389, '19 cornelius way', NULL, 0, 0, 12, 'reroo'),
(5390, 'Boston Microgreens', NULL, 0, 0, 13, 'reroo'),
(5391, 'Gibran and Samantha', NULL, 0, 0, 14, 'reroo'),
(5392, '195 chestnut', NULL, 0, 0, 15, 'reroo'),
(5393, '40 chestnut ave - alex marburger', NULL, 0, 0, 16, 'reroo'),
(5394, '38 Jamaica', NULL, 0, 0, 17, 'reroo'),
(5395, '18 Holbrook - Everett and Molly', NULL, 0, 0, 18, 'reroo'),
(5396, 'Karen and Duncan - 254 Hawthorne', NULL, 0, 0, 19, 'reroo'),
(5397, 'Terese Hammerle - ', NULL, 0, 0, 20, 'reroo'),
(5398, 'Diana McClure ', NULL, 0, 0, 21, 'reroo'),
(5399, 'Cam Kerry - 21 Adelaide', NULL, 0, 0, 22, 'reroo'),
(5400, 'Nancy Lipamn - Kitteridge Court', NULL, 0, 0, 23, 'reroo'),
(5401, '68 Cypress', NULL, 0, 0, 24, 'reroo'),
(5402, 'Rick Hammond - Liszt St Rosi', NULL, 0, 0, 25, 'reroo'),
(5403, 'Jeanette - Clayborne garden green roof', NULL, 0, 0, 26, 'reroo'),
(5404, '76 South St, Lucy Orloski', NULL, 0, 0, 27, 'reroo'),
(5405, '68 Rockview - terri martell', NULL, 0, 0, 28, 'reroo'),
(5406, 'Jennileen Joseph 218 Neponset Ave', NULL, 0, 0, 29, 'reroo'),
(5407, 'Nathan Lord - 158 Hampshire', NULL, 0, 0, 30, 'reroo'),
(5408, 'South Boston Library - Kathleen Mar', NULL, 0, 0, 31, 'reroo'),
(5409, 'Jodie Wahldesbuhl - 22 Thayer st brookline', NULL, 0, 0, 32, 'reroo'),
(5410, 'Michael Bellefeille - 40 Gartland', NULL, 0, 0, 33, 'reroo'),
(5411, 'Daphnah and Jay - 1435 Centre', NULL, 0, 0, 34, 'reroo'),
(5412, '17 Park Lane', NULL, 0, 0, 35, 'reroo'),
(5413, 'John Stainton - 37 Pondview', NULL, 0, 0, 36, 'reroo'),
(5414, '37 ogden', NULL, 0, 0, 37, 'reroo'),
(5415, '14 chestnut', NULL, 0, 0, 38, 'reroo'),
(5416, 'Dae Kim - 16 Zamora', NULL, 0, 0, 39, 'reroo'),
(5417, '63-65 Chestnut', '', 0, 0, 40, 'reroo'),
(5418, '126 Thornton - Lucy Lomas', NULL, 0, 0, 41, 'reroo'),
(5419, 'Dee and Maya - Rockview', NULL, 0, 0, 42, 'reroo'),
(5420, 'Chestnut Rockview Backwoods', NULL, 0, 0, 43, 'reroo'),
(5421, 'Marushka Glissen - Lamartine?', NULL, 0, 0, 44, 'reroo'),
(5423, '105 Green St', '', 1, 0, 2, 'reroo'),
(5424, 'NewJob', '', 0, 0, 0, NULL),
(5425, 'Nursery', '', 1, 0, 0, NULL),
(5426, 'Nursery', 'water', 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roleapp`
--

DROP TABLE IF EXISTS `roleapp`;
CREATE TABLE `roleapp` (
  `id` int(11) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roleapp`
--

INSERT INTO `roleapp` (`id`, `role`, `appid`) VALUES
(1, 'partner', 'tcard'),
(2, 'partner', 'OKtcard'),
(3, 'partner', 'jobs'),
(4, 'partner', 'pay'),
(5, 'partner', 'persons'),
(6, 'super', 'tcard'),
(7, 'super', 'OKtcard'),
(8, 'worker', 'jobs'),
(9, 'hr', 'tcard'),
(10, 'hr', 'persons');

-- --------------------------------------------------------

--
-- Table structure for table `rolewho`
--

DROP TABLE IF EXISTS `rolewho`;
CREATE TABLE `rolewho` (
  `id` int(11) NOT NULL,
  `role` varchar(20) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rolewho`
--

INSERT INTO `rolewho` (`id`, `role`, `emailid`, `coid`) VALUES
(1, 'partner', 'noah@sitebuilt.net', 'reroo'),
(2, 'partner', 'oliviaallegramay@gmail.com', 'reroo'),
(3, 'partner', 'mckenna.tim@gmail.com', 'reroo'),
(4, 'partner', 'mckenna.tim@gmail.com', 'sbs'),
(5, 'partner', 'perimckenna@gmail.com', 'reroo'),
(6, 'partner', 'perimckenna@gmail.com', 'sbs'),
(7, 'hr', 'perimckenna@yahoo.com', 'reroo'),
(8, 'super', 'tim2@sitebuilt.net', 'reroo'),
(9, 'worker', 'tim@sitebuilt.net', 'reroo'),
(10, 'worker', 'tim@sitebuilt.net', 'sbs'),
(11, 'worker', 'rubie@sitebuilt.net', 'reroo'),
(12, 'worker', 'jade@sitebuilt.net', 'reroo'),
(13, 'worker', 'modesto@sitebuilt.net', 'reroo'),
(14, 'worker', 'pampi@sitebuilt.net', 'reroo'),
(15, 'worker', 'samuel@sitebuilt.net', 'reroo'),
(16, 'worker', 'karen@sitebuilt.net', 'reroo');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `firstday` int(2) DEFAULT NULL,
  `ot` text,
  `effective` date DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `firstday`, `ot`, `effective`, `coid`) VALUES
(1, 1, '{"over40": 1.0, "sa": 1.0, "su": 1.0}', '2017-01-01', 'reroo'),
(2, 1, '{"over40": 1.5, "sa": 1.0, "su": 1.0}', '2018-01-01', 'reroo'),
(3, 5, '{"over40": 1.5, "sa": 1.0, "su": 1.0}', '2018-11-01', 'reroo'),
(4, 1, '{"over40": 1.5, "sa": 1.0, "su": 1.5}', '2018-06-01', 'reroo');

-- --------------------------------------------------------

--
-- Table structure for table `tcardjc`
--

DROP TABLE IF EXISTS `tcardjc`;
CREATE TABLE `tcardjc` (
  `id` int(11) NOT NULL,
  `wdprt` varchar(12) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `job` varchar(60) DEFAULT NULL,
  `cat` varchar(40) DEFAULT NULL,
  `hrs` decimal(4,2) NOT NULL DEFAULT '0.00',
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tcardjc`
--

INSERT INTO `tcardjc` (`id`, `wdprt`, `emailid`, `job`, `cat`, `hrs`, `coid`) VALUES
(1, '2018-W35-1', 'tim@sitebuilt.net', 'HYCC', 'constr', '8.25', 'reroo'),
(2, '2018-W35-2', 'tim@sitebuilt.net', 'HYCC', '', '3.50', 'reroo'),
(3, '2018-W35-2', 'tim@sitebuilt.net', 'Eastie Farm', '', '5.00', 'reroo'),
(4, '2018-W35-4', 'tim@sitebuilt.net', 'Marketting', '', '4.25', 'reroo'),
(5, '2018-W35-4', 'tim@sitebuilt.net', 'HYCC', 'constr', '3.00', 'reroo'),
(294, '2018-W41-5', 'tim@sitebuilt.net', 'yo boss: no job list', NULL, '0.00', 'reroo'),
(312, '2018-W37-4', 'tim@sitebuilt.net', '2054 Dot Ave', '', '-28.00', 'reroo'),
(313, '2018-W37-4', 'tim@sitebuilt.net', 'Egelston Library', NULL, '40.00', 'reroo'),
(315, '2018-W36-5', 'perimckenna@gmail.com', 'Egelston Library', NULL, '4.00', 'reroo'),
(316, '2018-W36-5', 'perimckenna@gmail.com', 'HYCC', 'maintain', '7.00', 'reroo'),
(317, '2018-W36-1', 'perimckenna@gmail.com', 'Egelston Library', NULL, '10.00', 'reroo'),
(318, '2018-W37-5', 'perimckenna@gmail.com', '15 Atherton', '', '10.97', 'reroo'),
(320, '2018-W37-1', 'samuel@sitebuilt.net', '15 Atherton', '', '7.55', 'reroo'),
(322, '2018-W37-2', 'samuel@sitebuilt.net', 'Egelston Library', NULL, '8.17', 'reroo'),
(324, '2018-W37-5', 'jade@sitebuilt.net', 'Egelston Library', NULL, '8.17', 'reroo'),
(325, '2018-W37-2', 'jade@sitebuilt.net', 'Egelston Library', NULL, '8.20', 'reroo'),
(341, '2018-W37-1', 'mckenna.tim@gmail.com', 'Egelston Library', NULL, '8.00', 'reroo'),
(352, '2018-W37-2', 'tim@sitebuilt.net', '15 Atherton', '', '2.00', 'reroo'),
(354, '2018-W36-1', 'tim@sitebuilt.net', 'Egelston Library', NULL, '5.00', 'reroo'),
(355, '2018-W36-1', 'tim@sitebuilt.net', 'Eastie Farm', '', '4.12', 'reroo'),
(356, '2018-W36-5', 'tim@sitebuilt.net', 'Egelston Library', NULL, '8.18', 'reroo'),
(360, '2018-W37-5', 'noah.mckenna@gmail.com', 'Eastie Farm', '', '5.00', 'reroo'),
(361, '2018-W37-5', 'noah.mckenna@gmail.com', 'Ken Wing - Rockview', '', '5.00', 'reroo'),
(362, '2018-W37-5', 'noah.mckenna@gmail.com', '15 Atherton', '', '0.75', 'reroo'),
(363, '2018-W37-4', 'noah.mckenna@gmail.com', 'Eastie Farm', '', '7.00', 'reroo'),
(364, '2018-W37-6', 'noah.mckenna@gmail.com', 'Ken Wing - Rockview', '', '1.00', 'reroo'),
(365, '2018-W37-7', 'noah.mckenna@gmail.com', '2054 Dot Ave', '', '5.00', 'reroo'),
(372, '2018-W37-5', 'samuel@sitebuilt.net', '105 Green St', NULL, '7.62', 'reroo'),
(401, '2018-W37-5', 'mckenna.tim@gmail.com', '105 Green St', NULL, '2.00', 'reroo'),
(438, '2018-W37-1', 'tim@sitebuilt.net', '105 Green St', NULL, '5.00', 'reroo'),
(439, '2018-W38-5', 'tim@sitebuilt.net', 'Arbour Hospital', NULL, '9.00', 'reroo'),
(451, '2018-W38-2', 'tim@sitebuilt.net', 'Arbour Hospital', NULL, '4.00', 'reroo'),
(452, '2018-W38-2', 'tim@sitebuilt.net', 'Nursery', '', '3.00', 'reroo'),
(453, '2018-W38-2', 'tim@sitebuilt.net', 'JPNDC brewery', NULL, '1.00', 'reroo'),
(466, '2018-W37-5', 'tim@sitebuilt.net', '105 Green St', '', '9.00', 'reroo'),
(467, '2018-W38-1', 'tim@sitebuilt.net', 'Roz Walter - 20 Dell', '', '5.05', 'reroo');

-- --------------------------------------------------------

--
-- Table structure for table `tcardpu`
--

DROP TABLE IF EXISTS `tcardpu`;
CREATE TABLE `tcardpu` (
  `id` int(11) NOT NULL,
  `wdprt` varchar(12) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `inout` varchar(120) DEFAULT NULL,
  `hrs` decimal(4,2) NOT NULL DEFAULT '0.00',
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tcardpu`
--

INSERT INTO `tcardpu` (`id`, `wdprt`, `emailid`, `inout`, `hrs`, `coid`) VALUES
(1, '2018-W35-1', 'tim@sitebuilt.net', '["7:30","15:45","16:12","17:12","03:45"]', '9.25', 'reroo'),
(3, '2018-W35-4', 'tim@sitebuilt.net', '["8:30", "15:45"]', '7.25', 'reroo'),
(51, '2018-W40-5', 'tim@sitebuilt.net', '["07:12"]', '0.00', 'reroo'),
(56, '2018-W34-5', 'tim@sitebuilt.net', '["07:15","15:25","16:25","17:25","18:34"]', '9.17', 'reroo'),
(63, '2018-W35-3', 'tim@sitebuilt.net', '["07:15"]', '0.00', 'reroo'),
(74, '2018-W35-5', 'tim@sitebuilt.net', '["07:15","15:33"]', '8.30', 'reroo'),
(76, '2018-W35-2', 'tim@sitebuilt.net', '["07:30","16:35",""]', '9.08', 'reroo'),
(107, '2018-W33-5', 'tim@sitebuilt.net', '["07:31","16:12"]', '8.68', 'reroo'),
(114, '2018-W37-1', 'tim@sitebuilt.net', '["07:33","12:33"]', '5.00', 'reroo'),
(116, '2018-W37-2', 'tim@sitebuilt.net', '["17:57","19:57"]', '2.00', 'reroo'),
(122, '2018-W37-4', 'tim@sitebuilt.net', '["17:57","17:57","05:57","17:57"]', '12.00', 'reroo'),
(126, '2018-W36-5', 'perimckenna@yahoo.com', '["09:00","17:00"]', '8.00', 'reroo'),
(130, '2018-W36-2', 'perimckenna@yahoo.com', '["23:06","23:06","23:06","23:06","23:06","23:06","09:00","17:00"]', '8.00', 'reroo'),
(146, '2018-W36-3', 'perimckenna@yahoo.com', '["09:00","17:00"]', '8.00', 'reroo'),
(148, '2018-W36-4', 'perimckenna@yahoo.com', '["23:06","09:00"]', '-14.10', 'reroo'),
(179, '2018-W36-5', 'perimckenna@gmail.com', '["07:29","15:29","18:37","21:37"]', '11.00', 'reroo'),
(183, '2018-W36-5', 'tim@sitebuilt.net', '[]', '0.00', 'reroo'),
(185, '2018-W36-1', 'perimckenna@gmail.com', '[]', '0.00', 'reroo'),
(187, '2018-W37-5', 'perimckenna@gmail.com', '["06:42","17:40"]', '10.97', 'reroo'),
(189, '2018-W37-2', 'perimckenna@gmail.com', '["13:43","17:47"]', '4.07', 'reroo'),
(191, '2018-W36-2', 'tim@sitebuilt.net', '["16:58"]', '0.00', 'reroo'),
(192, '2018-W37-5', 'samuel@sitebuilt.net', '["07:56","15:33"]', '7.62', 'reroo'),
(194, '2018-W37-1', 'samuel@sitebuilt.net', '["08:00","15:33"]', '7.55', 'reroo'),
(198, '2018-W37-2', 'samuel@sitebuilt.net', '["07:23","15:33"]', '8.17', 'reroo'),
(202, '2018-W37-5', 'jade@sitebuilt.net', '[]', '0.00', 'reroo'),
(204, '2018-W37-2', 'jade@sitebuilt.net', '["07:21","15:33"]', '8.20', 'reroo'),
(212, '2018-W37-1', 'mckenna.tim@gmail.com', '["07:30","15:30"]', '8.00', 'reroo'),
(216, '2018-W44-5', 'tim@sitebuilt.net', '["07:30","15:30"]', '8.00', 'reroo'),
(220, '2018-W36-1', 'tim@sitebuilt.net', '["07:08","16:15"]', '9.12', 'reroo'),
(222, '2018-W38-5', 'tim@sitebuilt.net', '["12:00","15:00","12:03","18:03"]', '9.00', 'reroo'),
(226, '2018-W38-1', 'tim@sitebuilt.net', '["11:56","11:59","12:03","15:03","16:17","18:17"]', '5.05', 'reroo'),
(231, '2018-W37-5', 'noah.mckenna@gmail.com', '[]', '0.00', 'reroo'),
(233, '2018-W37-4', 'noah.mckenna@gmail.com', '["10:35","17:35"]', '7.00', 'reroo'),
(235, '2018-W37-6', 'noah.mckenna@gmail.com', '["22:35","23:35"]', '1.00', 'reroo'),
(237, '2018-W37-7', 'noah.mckenna@gmail.com', '["07:34","12:34"]', '5.00', 'reroo'),
(243, '2018-W37-5', 'mckenna.tim@gmail.com', '["19:35","21:35","19:57","21:57"]', '4.00', 'reroo'),
(257, '2018-W37-5', 'tim@sitebuilt.net', '["11:51","16:51"]', '5.00', 'reroo'),
(307, '2018-W38-2', 'tim@sitebuilt.net', '["16:13","23:13","13:13","14:13"]', '8.00', 'reroo'),
(340, '2018-W36-5', 'tim@sitebuilt.net', '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(341, '2018-W36-5', 'tim@sitebuilt.net', '[]', '0.00', NULL),
(342, '2018-W36-5', 'tim@sitebuilt.net', '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(343, '2018-W36-5', 'tim@sitebuilt.net', '[]', '0.00', NULL),
(344, '2018-W36-5', 'tim@sitebuilt.net', '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(345, '2018-W36-5', 'tim@sitebuilt.net', '[]', '0.00', NULL),
(346, '2018-W36-5', 'tim@sitebuilt.net', '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(347, '2018-W36-5', 'tim@sitebuilt.net', '[]', '0.00', NULL),
(348, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(349, '2018-W36-5', NULL, '[]', '0.00', NULL),
(350, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(351, '2018-W36-5', NULL, '[]', '0.00', NULL),
(352, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(353, '2018-W36-5', NULL, '[]', '0.00', NULL),
(354, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(355, '2018-W36-5', NULL, '[]', '0.00', NULL),
(356, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(357, '2018-W36-5', NULL, '[]', '0.00', NULL),
(358, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(359, '2018-W36-5', NULL, '[]', '0.00', NULL),
(360, '2018-W36-5', NULL, '["7:30","15:15","15:45","17:00","16:12"]', '9.50', NULL),
(361, '2018-W36-5', NULL, '[]', '0.00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tcardwk`
--

DROP TABLE IF EXISTS `tcardwk`;
CREATE TABLE `tcardwk` (
  `id` int(11) NOT NULL,
  `wprt` varchar(12) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `hrs` decimal(4,2) NOT NULL DEFAULT '0.00',
  `coid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tcardwk`
--

INSERT INTO `tcardwk` (`id`, `wprt`, `emailid`, `status`, `hrs`, `coid`) VALUES
(1, '2018-W35', 'tim@sitebuilt.net', 'submitted', '25.00', 'reroo'),
(19, '2018-W36', 'tim@sitebuilt.net', 'inprocess', '9.12', 'reroo'),
(29, '2018-W33', 'tim@sitebuilt.net', 'inprocess', '8.68', 'reroo'),
(31, '2018-W44', 'tim@sitebuilt.net', 'ready', '8.00', 'reroo'),
(36, '2018-W41', 'tim@sitebuilt.net', 'inprocess', '0.00', 'reroo'),
(37, '2018-W38', 'tim@sitebuilt.net', 'approved', '22.05', 'reroo'),
(46, '2018-W37', 'tim@sitebuilt.net', 'ready', '24.00', 'reroo'),
(69, '2018-W36', 'perimckenna@yahoo.com', 'inprocess', '9.90', 'reroo'),
(111, '2018-W36', 'perimckenna@gmail.com', 'inprocess', '11.00', 'reroo'),
(161, '2018-W37', 'perimckenna@gmail.com', 'inprocess', '15.04', 'reroo'),
(170, '2018-W37', 'samuel@sitebuilt.net', 'inprocess', '24.91', 'reroo'),
(188, '2018-W37', 'jade@sitebuilt.net', 'inprocess', '8.20', 'reroo'),
(195, '2018-W37', 'mckenna.tim@gmail.com', 'inprocess', '0.00', 'reroo'),
(278, '2018-W37', 'noah.mckenna@gmail.com', 'inprocess', '13.00', 'reroo'),
(295, '2018-W35', 'tim@sitebuilt.net', 'submitted', '25.00', NULL),
(296, '2018-W35', 'tim@sitebuilt.net', 'submitted', '25.00', NULL),
(297, '2018-W35', 'tim@sitebuilt.net', 'submitted', '25.00', NULL),
(298, '2018-W35', 'tim@sitebuilt.net', 'submitted', '25.00', NULL),
(299, '2018-W35', NULL, 'submitted', '25.00', NULL),
(300, '2018-W35', NULL, 'submitted', '25.00', NULL),
(301, '2018-W35', NULL, 'submitted', '25.00', NULL),
(302, '2018-W35', NULL, 'submitted', '25.00', NULL),
(303, '2018-W35', NULL, 'submitted', '25.00', NULL),
(304, '2018-W35', NULL, 'submitted', '25.00', NULL),
(305, '2018-W35', NULL, 'submitted', '25.00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `week`
--

DROP TABLE IF EXISTS `week`;
CREATE TABLE `week` (
  `id` int(11) NOT NULL,
  `ontcard` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `week`
--

INSERT INTO `week` (`id`, `ontcard`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `whoapp`
--

DROP TABLE IF EXISTS `whoapp`;
CREATE TABLE `whoapp` (
  `id` int(11) NOT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `role` varchar(40) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `permisos` varchar(20) DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL,
  `auth` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `whoapp`
--

INSERT INTO `whoapp` (`id`, `emailid`, `role`, `appid`, `permisos`, `coid`, `auth`) VALUES
(1, 'noah@sitebuilt.net', '', 'tcard', 'admin', 'reroo', NULL),
(2, 'olivia@sitebuilt.net', '', 'tcard', 'user', 'reroo', NULL),
(3, 'rubie@sitebuilt.net', '', 'tcard', 'user', 'reroo', NULL),
(4, 'jade@sitebuilt.net', '', 'tcard', 'user', 'reroo', 1),
(5, 'modesto@sitebuilt.net', '', 'tcard', 'user', 'reroo', NULL),
(6, 'pampi@sitebuilt.net', '', 'tcard', 'user', 'reroo', NULL),
(7, 'samuel@sitebuilt.net', '', 'tcard', 'user', 'reroo', 1),
(8, 'karen@sitebuilt.net', '', 'tcard', 'user', 'reroo', NULL),
(9, 'tim@sitebuilt.net', '', 'tcard', 'admin', 'reroo', 1),
(10, 'noah@sitebuilt.net', '', 'jobs', 'admin', 'reroo', 1),
(11, 'olivia@sitebuilt.net', '', 'jobs', 'user', 'reroo', NULL),
(12, 'tim@sitebuilt.net', '', 'jobs', 'admin', 'reroo', 1),
(13, 'noah.mckenna@gmail.com', '', 'jobs', 'admin', 'reroo', 1),
(14, 'perimckenna@gmail.com', '', 'jobs', 'admin', 'reroo', 1),
(15, 'perimckenna@yahoo.com', '', 'jobs', 'admin', 'reroo', 1),
(16, 'mckenna.tim@gmail.com', '', 'jobs', 'admin', 'reroo', 1),
(17, 'perimckenna@gmail.com', '', 'tcard', 'user', 'reroo', 1),
(18, 'perimckenna@yahoo.com', '', 'tcard', 'user', 'reroo', 1),
(19, 'noah@sitebuilt.net', '', 'tcard', 'payroll', 'reroo', NULL),
(20, 'oliviaallegramay@gmail.com', '', 'tcard', 'user', 'reroo', NULL),
(21, 'oliviaallegramay@gmail.com', '', 'payroll', 'user', 'reroo', NULL),
(22, 'oliviaallegramay@gmail.com', '', 'jobs', 'user', 'reroo', NULL),
(23, 'noah.mckenna@gmail.com', '', 'payroll', 'admin', 'reroo', 1),
(24, 'perimckenna@gmail.com', '', 'payroll', 'admin', 'reroo', 1),
(25, 'perimckenna@yahoo.com', '', 'payroll', 'admin', 'reroo', 1),
(26, 'mckenna.tim@gmail.com', '', 'payroll', 'admin', 'reroo', 1),
(27, 'noah.mckenna@gmail.com', '', 'tcard', 'admin', 'reroo', 1);

-- --------------------------------------------------------

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
CREATE TABLE `workers` (
  `id` int(11) NOT NULL,
  `handle` varchar(20) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workers`
--

INSERT INTO `workers` (`id`, `handle`, `name`, `email`, `role`) VALUES
(1, 'Noah', 'Noah', 'noah@sitebuilt.net', 'member'),
(2, 'Olivia', 'Olivia', 'olivia@sitebuilt.net', 'member'),
(3, 'Rubie', 'Rubie', 'rubie@sitebuilt.net', 'worker'),
(4, 'Jade', 'Jade', 'jade@sitebuilt.net', 'worker'),
(5, 'Modesto', 'Modesto', 'modesto@sitebuilt.net', 'worker'),
(6, 'Pampi', 'Pampi', 'pampi@sitebuilt.net', 'worker'),
(7, 'Samuel', 'Samuel', 'samuel@sitebuilt.net', 'worker'),
(8, 'Karen', 'Karen', 'karen@sitebuilt.net', 'worker'),
(9, 'Tim', 'Tim', 'tim@sitebuilt.net', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `co`
--
ALTER TABLE `co`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coid` (`coid`),
  ADD KEY `goodtil` (`goodtil`);

--
-- Indexes for table `jobcatact`
--
ALTER TABLE `jobcatact`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `jobcatwk` (`job`,`category`,`week`),
  ADD KEY `jobcat` (`job`,`category`) USING BTREE,
  ADD KEY `category` (`category`),
  ADD KEY `job` (`job`),
  ADD KEY `active` (`active`),
  ADD KEY `week` (`week`),
  ADD KEY `idx` (`idx`),
  ADD KEY `coid` (`coid`);

--
-- Indexes for table `roleapp`
--
ALTER TABLE `roleapp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role` (`role`),
  ADD KEY `appid` (`appid`);

--
-- Indexes for table `rolewho`
--
ALTER TABLE `rolewho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role` (`role`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `coid` (`coid`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `effective` (`effective`),
  ADD KEY `coid` (`coid`);

--
-- Indexes for table `tcardjc`
--
ALTER TABLE `tcardjc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wejcc` (`wdprt`,`emailid`,`job`,`cat`,`coid`),
  ADD KEY `wdprt` (`wdprt`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `job` (`job`),
  ADD KEY `cat` (`cat`),
  ADD KEY `jobcat` (`job`,`cat`) USING BTREE,
  ADD KEY `coid` (`coid`);

--
-- Indexes for table `tcardpu`
--
ALTER TABLE `tcardpu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wec` (`wdprt`,`emailid`,`coid`),
  ADD KEY `wdprt` (`wdprt`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `coid` (`coid`);

--
-- Indexes for table `tcardwk`
--
ALTER TABLE `tcardwk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wec` (`wprt`,`emailid`,`coid`),
  ADD KEY `wprt` (`wprt`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `week`
--
ALTER TABLE `week`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `whoapp`
--
ALTER TABLE `whoapp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `appid` (`appid`),
  ADD KEY `permisos` (`permisos`),
  ADD KEY `coid` (`coid`),
  ADD KEY `auth` (`auth`),
  ADD KEY `role` (`role`);

--
-- Indexes for table `workers`
--
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`),
  ADD KEY `handle` (`handle`),
  ADD KEY `role` (`role`),
  ADD KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `co`
--
ALTER TABLE `co`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `jobcatact`
--
ALTER TABLE `jobcatact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5432;
--
-- AUTO_INCREMENT for table `roleapp`
--
ALTER TABLE `roleapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `rolewho`
--
ALTER TABLE `rolewho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tcardjc`
--
ALTER TABLE `tcardjc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=468;
--
-- AUTO_INCREMENT for table `tcardpu`
--
ALTER TABLE `tcardpu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=362;
--
-- AUTO_INCREMENT for table `tcardwk`
--
ALTER TABLE `tcardwk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306;
--
-- AUTO_INCREMENT for table `week`
--
ALTER TABLE `week`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `whoapp`
--
ALTER TABLE `whoapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `workers`
--
ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
