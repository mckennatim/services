-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 09, 2018 at 03:04 PM
-- Server version: 5.7.16-0ubuntu0.16.04.1
-- PHP Version: 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `geniot`
--

-- --------------------------------------------------------

--
-- Table structure for table `apps`
--

CREATE TABLE `apps` (
  `id` int(11) NOT NULL,
  `appid` varchar(20) NOT NULL,
  `appurl` varchar(30) DEFAULT NULL,
  `apiurl` varchar(30) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apps`
--

INSERT INTO `apps` (`id`, `appid`, `appurl`, `apiurl`, `desc`) VALUES
(1, 'admind', NULL, NULL, NULL),
(2, 'shroom', NULL, NULL, NULL),
(3, 'pahoRawSB', NULL, NULL, NULL),
(4, 'cascada', NULL, NULL, NULL),
(5, 'hvac', NULL, NULL, NULL),
(6, 'lightsoff', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_loc`
--

CREATE TABLE `app_loc` (
  `id` int(11) NOT NULL,
  `appid` varchar(20) NOT NULL,
  `locid` varchar(20) NOT NULL,
  `devs` varchar(300) DEFAULT NULL,
  `zones` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `app_loc`
--

INSERT INTO `app_loc` (`id`, `appid`, `locid`, `devs`, `zones`) VALUES
(405, 'hvac', '12ParleyVale', '{"CYURD003": [{"sr":0,"label":"kid"}, {"sr":1,"label":"lr"}], "CYURD001": [{"sr":0,"label":"music"}, {"sr":1,"label":"peri"}]}', '[{"id":"kid", "name":"Kid\'s Suite","img":"kid.jpg"}, {"id":"lr","name":"Living Room","img":"lr.jpg"},{"id":"music","name":"Music Room","img":"music.jpg"},{"id":"peri","name":"Peri\'s Study","img":"peri.jpg"}]'),
(406, 'hvac', '255ChestnutAve', '{"CYURD013": [{"sr":0,"label":"kid"}, {"sr":1,"label":"lr"}], "CYURD016": [{"sr":0,"label":"music"}, {"sr":1,"label":"peri"}]}', '[{"id":"kid", "name":"Kid\'s Suite","img":"kid.jpg"}, {"id":"lr","name":"Living Room","img":"lr.jpg"},{"id":"music","name":"Music Room","img":"music.jpg"},{"id":"peri","name":"Peri\'s Study","img":"peri.jpg"}]');

-- --------------------------------------------------------

--
-- Table structure for table `biz`
--

CREATE TABLE `biz` (
  `id` int(11) NOT NULL,
  `bizid` varchar(20) NOT NULL,
  `bizname` varchar(120) DEFAULT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bizapp`
--

CREATE TABLE `bizapp` (
  `id` int(11) NOT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bizapp`
--

INSERT INTO `bizapp` (`id`, `bizid`, `appid`) VALUES
(300, 'sbs', 'admin'),
(392, 'sbs', 'base'),
(332, 'sbs', 'cascada'),
(331, 'sbs', 'cascada_hs'),
(377, 'sbs', 'hvac'),
(314, 'sbs', 'lightsoff'),
(353, 'sbs', 'pahoRawSB'),
(360, 'sbs', 'shroom'),
(451, 'sbs', 'shrooms'),
(301, 'sbs', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `devs`
--

CREATE TABLE `devs` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `devpwd` varchar(24) DEFAULT NULL,
  `description` varchar(220) DEFAULT NULL,
  `bizid` varchar(20) DEFAULT NULL,
  `locid` varchar(20) DEFAULT NULL,
  `server` varchar(120) DEFAULT NULL,
  `specs` varchar(120) DEFAULT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `apps` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `devs`
--

INSERT INTO `devs` (`id`, `devid`, `devpwd`, `description`, `bizid`, `locid`, `server`, `specs`, `owner`, `apps`) VALUES
(1, 'CYURD001', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12ParleyVale', '{"url":"10.0.1.105","mqtt":1883,"express":3332}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["hvac"]'),
(2, 'CYURD007', 'geniot', '2 temps, 3 timers 1 relay demo board2', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user"]'),
(3, 'CYURBAD', 'nopwd', NULL, 'sbs', '12ParleyVale', NULL, NULL, NULL, NULL),
(4, 'CYURD008', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '12ParleyVale', '{"url":"sitebuilt.net","mqtt":1884,"express":4332}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', NULL),
(5, 'CYURD003', 'geniot', 'DHT 3 timers 1 temp 1 humidity greenhouse control', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":"dht"}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "base", "shrooms", "hvac", "lightsoff"]'),
(6, 'CYURD006', 'geniot', 'just tem sensor', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "base", "shrooms", "hvac", "lightsoff"]'),
(7, 'CYURD004', 'geniot', 'DHT temp, humidity 1 relay greenhouse lights4', 'sbs', '12ParleyVale', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":"DHT"}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["lightsoff"]'),
(8, 'CYURD002', 'geniot', 'cascada 3 timers 3 relays', 'sbs', '12ParleyVale', '{"url":"sitebuilt.net","mqtt":1884,"express":3333}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', NULL),
(27, 'CYURD027', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '794048thAveS', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "hvac", "base"]'),
(29, 'CYURD013', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '255ChestnutAve', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "hvac", "base"]'),
(30, 'CYURD029', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '4505NHaightAve', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "hvac", "base"]'),
(38, 'CYURD016', 'geniot', '2 temps, 3 timers 1 relay demo board', 'sbs', '255ChestnutAve', '{"mqtt_server":"sitebuilt.net","mqtt_port":"1884","sensor_type":""}', '{"HAStIMER":28,"notTimerTags":["temp","onoff","hilimit","lolimit"]}', 'tim@sitebuilt.net', '["admin", "user", "hvac", "base"]');

-- --------------------------------------------------------

--
-- Table structure for table `holds`
--

CREATE TABLE `holds` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `until` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sched` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `holds`
--

INSERT INTO `holds` (`id`, `devid`, `senrel`, `until`, `sched`) VALUES
(1, 'CYURD001', 0, '2018-02-09 00:00:00', '[[0,0,74,72]]'),
(5, 'CYURD001', 1, '2018-02-11 00:00:00', '[[0,0,74,72]]'),
(6, 'CYURD003', 1, '2018-02-11 00:00:00', '[[0,0,74,72]]'),
(8, 'CYURD003', 0, '2018-02-11 00:00:00', '[[0,0,74,72]]');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `locid` varchar(20) NOT NULL,
  `address` varchar(120) NOT NULL,
  `latlng` varchar(100) DEFAULT NULL,
  `timezone` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `locid`, `address`, `latlng`, `timezone`) VALUES
(1000, '12ParleyVale', '12 Parley Vale, Jamaica Plain, MA 02130', '{"lat":42.315,"lng":-71.111}', 'America/New_York'),
(1001, '255ChestnutAve', '255 Chestnut Ave, Jamaica Plain, MA 02130, USA', '{"lat":42.31381409999999,"lng":-71.10874749999999}', 'America/New_York'),
(1002, '794048thAveS', '7940 48th Ave S, Seattle, WA 98118, USA', '{"lat":47.5303635,"lng":-122.2724899}', 'America/Los_Angeles'),
(1003, '4505NHaightAve', '4505 N Haight Ave, Portland, OR 97217, USA', '{"lat":45.5555363,"lng":-122.6703647}', 'America/Los_Angeles');

-- --------------------------------------------------------

--
-- Table structure for table `scheds`
--

CREATE TABLE `scheds` (
  `id` int(11) NOT NULL,
  `devid` varchar(30) NOT NULL,
  `senrel` int(2) NOT NULL,
  `dow` int(2) NOT NULL,
  `sched` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scheds`
--

INSERT INTO `scheds` (`id`, `devid`, `senrel`, `dow`, `sched`) VALUES
(1000, 'CYURD001', 1, 4, '[[12,20,77,75]]'),
(1001, 'CYURD001', 0, 4, '[[12,40,77,73]]'),
(1002, 'CYURD002', 3, 2, '[[0,0,0],[9,15,1],[9,45,0],[17,0,1],[17,56,0]]'),
(1003, 'CYURD002', 4, 0, '[[0,0,0],[9,10,1],[9,40,0],[17,0,1],[17,50,0]]'),
(1004, 'CYURD002', 4, 2, '[[0,0,0],[9,12,1],[9,44,0],[17,5,1],[17,56,0]]'),
(1005, 'CYURD002', 2, 0, '[[0,0,1]]'),
(1007, 'CYURD002', 3, 0, '[[0,0,1]]');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `userid` varchar(80) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_loc`
--

CREATE TABLE `user_app_loc` (
  `id` int(11) NOT NULL,
  `userid` varchar(60) NOT NULL,
  `appid` varchar(20) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  `devid` varchar(40) DEFAULT NULL,
  `auth` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_app_loc`
--

INSERT INTO `user_app_loc` (`id`, `userid`, `appid`, `role`, `devid`, `auth`) VALUES
(27, 'mckenna.tim@gmail.com', 'hvac', 'user', 'CYURD003', 0),
(55, 'tim@sitebuilt.net', 'hvac', 'user', 'CYURD006', 1),
(57, 'tim@sitebuilt.net', 'hvac', 'user', 'CYURD003', 1),
(59, 'mckenna.tim@gmail.com', 'hvac', 'user', 'CYURD006', 0),
(63, 'tim@sitebuilt.net', 'hvac', 'admin', 'CYURD006', 1),
(66, 'tim@sitebuilt.net', 'admin', 'admin', 'CYURD007', 0),
(71, 'tim@sitebuilt.net', 'user', 'admin', 'CYURD007', 0),
(78, 'tim@sitebuilt.net', 'admin', 'admin', 'CYURD027', 0),
(79, 'tim@sitebuilt.net', 'user', 'admin', 'CYURD027', 0),
(80, 'tim@sitebuilt.net', 'hvac', 'admin', 'CYURD027', 1),
(81, 'tim@sitebuilt.net', 'base', 'admin', 'CYURD027', 0),
(86, 'tim@sitebuilt.net', 'admin', 'admin', 'CYURD028', 0),
(87, 'tim@sitebuilt.net', 'user', 'admin', 'CYURD028', 0),
(88, 'tim@sitebuilt.net', 'hvac', 'admin', 'CYURD028', 1),
(89, 'tim@sitebuilt.net', 'base', 'admin', 'CYURD028', 0),
(90, 'tim@sitebuilt.net', 'admin', 'admin', 'CYURD029', 0),
(91, 'tim@sitebuilt.net', 'user', 'admin', 'CYURD029', 0),
(92, 'tim@sitebuilt.net', 'hvac', 'admin', 'CYURD029', 1),
(93, 'tim@sitebuilt.net', 'base', 'admin', 'CYURD029', 0),
(94, 'tim@sitebuilt.net', 'admin', 'admin', 'CYURD003', 0),
(95, 'tim@sitebuilt.net', 'base', 'admin', 'CYURD003', 0),
(96, 'tim@sitebuilt.net', 'shrooms', 'admin', 'CYURD003', 0),
(98, 'tim@sitebuilt.net', 'lightsoff', 'admin', 'CYURD003', 0),
(104, 'tim@sitebuilt.net', 'admin', 'admin', 'CYURD006', 0),
(105, 'tim@sitebuilt.net', 'base', 'admin', 'CYURD006', 0),
(106, 'tim@sitebuilt.net', 'shrooms', 'admin', 'CYURD006', 0),
(108, 'tim@sitebuilt.net', 'lightsoff', 'admin', 'CYURD006', 0),
(115, 'tim3@sitebuilt.net', 'hvac', 'user', 'CYURD14I', 0),
(116, 'tim4@sitebuilt.net', 'base', 'user', 'CYURD003', 0),
(118, 'tim@sitebuilt.net', 'lightsoff', 'admin', 'CYURD004', 0),
(122, 'mckenna.tim@gmail.com', 'admin', 'super', 'CYURD14I', 1),
(123, 'mckenna.tim@gmail.com', 'admin', 'admin', 'CYURD14I', 1),
(142, 'tim@sitebuilt.net', 'hvac', 'admin', 'CYURD001', 1),
(143, 'mckenna.tim@gmail.com', 'pahoRawSB', 'super', 'CYURD14I', 1),
(144, 'mckenna.tim@gmail.com', 'pahoRawSB', 'admin', 'CYURD14I', 1),
(145, 'mckenna.tim@gmail.com', 'hvac', 'super', 'CYURD14I', 1),
(146, 'mckenna.tim@gmail.com', 'hvac', 'admin', 'CYURD14I', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apps`
--
ALTER TABLE `apps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appid` (`appid`),
  ADD KEY `appurl` (`appurl`),
  ADD KEY `apiurl` (`apiurl`);

--
-- Indexes for table `app_loc`
--
ALTER TABLE `app_loc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`appid`,`locid`),
  ADD KEY `locid` (`locid`),
  ADD KEY `appid` (`appid`);

--
-- Indexes for table `biz`
--
ALTER TABLE `biz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `bizname` (`bizname`),
  ADD KEY `owner` (`owner`);

--
-- Indexes for table `bizapp`
--
ALTER TABLE `bizapp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`bizid`,`appid`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `appid` (`appid`);

--
-- Indexes for table `devs`
--
ALTER TABLE `devs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `devid` (`devid`),
  ADD KEY `bizid` (`bizid`),
  ADD KEY `locid` (`locid`),
  ADD KEY `owner` (`owner`);

--
-- Indexes for table `holds`
--
ALTER TABLE `holds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`devid`,`senrel`) USING BTREE,
  ADD KEY `devid` (`devid`),
  ADD KEY `senrel` (`senrel`),
  ADD KEY `until` (`until`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locid` (`locid`) USING BTREE,
  ADD KEY `timezone` (`timezone`);

--
-- Indexes for table `scheds`
--
ALTER TABLE `scheds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`devid`,`senrel`,`dow`) USING BTREE,
  ADD KEY `devid` (`devid`),
  ADD KEY `dow` (`dow`),
  ADD KEY `senrel` (`senrel`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `user_app_loc`
--
ALTER TABLE `user_app_loc`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `main` (`userid`,`appid`,`devid`,`role`) USING BTREE,
  ADD KEY `devid` (`devid`),
  ADD KEY `userid` (`userid`) USING BTREE,
  ADD KEY `appid` (`appid`) USING BTREE,
  ADD KEY `role` (`role`) USING BTREE,
  ADD KEY `auth` (`auth`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apps`
--
ALTER TABLE `apps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `app_loc`
--
ALTER TABLE `app_loc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=407;
--
-- AUTO_INCREMENT for table `biz`
--
ALTER TABLE `biz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `bizapp`
--
ALTER TABLE `bizapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=473;
--
-- AUTO_INCREMENT for table `devs`
--
ALTER TABLE `devs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `holds`
--
ALTER TABLE `holds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1022;
--
-- AUTO_INCREMENT for table `scheds`
--
ALTER TABLE `scheds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=400;
--
-- AUTO_INCREMENT for table `user_app_loc`
--
ALTER TABLE `user_app_loc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
