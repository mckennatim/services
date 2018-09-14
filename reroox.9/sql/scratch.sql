show tables from reroo;
USE reroo;
SELECT * FROM jobcatact WHERE week=0;

select * from reroo.whoapp;
select * from reroo.jobcatact;
select * from reroo.jobcatact WHERE active;
delete from reroo.jobcatact;

ALTER TABLE reroo.jobcatact MODIFY COLUMN job VARCHAR(60); 

ALTER TABLE reroo.jobcatact MODIFY COLUMN week int(2) NOT NULL DEFAULT 0; 

update reroo.jobcatact set 
TRUNCATE TABLE reroo.jobcatact;
INSERT INTO reroo.jobcatact (job)
  VALUES 
('Marketting'),
('Nursery'),
('Truck and tools'),
('HYCC'),
('Ken Wing - Rockview'),
('Eastie Farm'),
('15 Atherton'),
('2054 Dot Ave'),
('105 Green St'),
('Egelston Library'),
('19 cornelius way'),
('20 Alveston'),
('16 roanoke'),
('Roz Walter - 20 Dell'),
('Boston Microgreens'),
('Gibran and Samantha'),
('195 chestnut'),
('40 chestnut ave - alex marburger'),
('38 Jamaica'),
('18 Holbrook - Everett and Molly'),
('Karen and Duncan - 254 Hawthorne'),
('Terese Hammerle - '),
('Arbour Hospital'),
('Diana McClure '),
('Cam Kerry - 21 Adelaide'),
('Nancy Lipamn - Kitteridge Court'),
('68 Cypress'),
('Rick Hammond - Liszt St Rosi'),
('Jeanette - Clayborne garden green roof'),
('76 South St, Lucy Orloski'),
('349 VFW Parkway - Bunny Hickey'),
('68 Rockview - terri martell'),
('Jennileen Joseph 218 Neponset Ave'),
('Nathan Lord - 158 Hampshire'),
('South Boston Library - Kathleen Mar'),
('Jodie Wahldesbuhl - 22 Thayer st brookline'),
('Michael Bellefeille - 40 Gartland'),
('Daphnah and Jay - 1435 Centre'),
('241-5 Chestnut Ave'),
('17 Park Lane'),
('JPNDC brewery'),
('John Stainton - 37 Pondview'),
('37 ogden'),
('14 chestnut'),
('Dae Kim - 16 Zamora'),
('63-65 Chestnut'),
('233 Chestnut - Greg Gulickssen'),
('126 Thornton - Lucy Lomas'),
('Dee and Maya - Rockview'),
('Michael Hecht - 9 Park Lane'),
('241-5 Chestnut Ave'),
('Chestnut Rockview Backwoods'),
('11 danforth'),
('connolly library'),
('Marushka Glissen - Lamartine?'),
('Donna Woonteiler - 8 Chetnut Place'),
('J&M Brown');  

ALTER TABLE TABLE_1 RENAME TO jobcatact;

ALTER TABLE `jobcatact` ADD `id` INT NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`);

USE reroo;
ALTER TABLE `jobcatact` ADD `coid` varchar(20), ADD KEY (`coid`);
UPDATE `jobcatact` SET coid='reroo';
SELECT * FROM jobcatact;


ALTER TABLE `jobcatact` ADD KEY jobcat (`job`, `category`)
ALTER TABLE `jobcatact` ADD KEY (`category`)
ALTER TABLE `jobcatact` ADD KEY (`job`)
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `day1` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


USE reroo;
DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(10) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `role` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `handle` (`handle`),
  KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

INSERT INTO `workers` (handle, name, role)
  VALUES
('Noah', 'Noah',  'member'),
('Olivia','Olivia', 'worker' ),
('Rubie', 'Rubie',  'worker'),
('Jade', 'Jade',  'worker'),
('Modesto', 'Modesto', 'worker'),
('Pampi', 'Pampi',  'worker'),
('Samuel','Samuel', 'worker' ),
('Karen', 'Karen',  'worker');

select * from reroo.workers;

UPDATE reroo.jobcatact SET active = ROUND(rand())

use reroo;
ALTER TABLE `reroo.workers` RENAME TO workers;



use reroo;
DROP TABLE IF EXISTS `whoapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whoapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emailid` text,
  `appid` text,
  `permisos` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whoapp`
--


use reroo;
select email from workers;

USE reroo;
ALTER TABLE workers
ADD COLUMN id INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (id);

SELECT * from reroo.workers;
SELECT * from reroo.workers;
SELECT * from reroo.whoapp;


UPDATE reroo.workers SET role='consultor' WHERE name='Tim'
UPDATE reroo.workers SET role='member' WHERE name='Olivia';

show columns from reroo.whoapp

use reroo;
alter table whoapp
ADD `id` INT NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`),
modify column appid varchar(20),
modify column permisos varchar(20),
modify column emailid varchar(60),
add key (`emailid`),
add key (`appid`),
add key (`permisos`);

show columns from reroo.workers

use reroo;
alter table workers
ADD `id` INT NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`),
modify column handle varchar(20),
modify column name varchar(60),
modify column role varchar(20),
modify column email varchar(60),
add key (`email`),
add key (`handle`),
add key (`role`),
aedd key (`name`);

use reroo;
alter table workers
modify column name varchar(60),
add key (`name`);
select * from reroo.workers

use reroo;
ALTER TABLE `whoapp` ADD `coid` varchar(20), ADD KEY (`coid`);
use reroo;
ALTER TABLE `whoapp` ADD `active` tinyint(4), ADD KEY (`active`);
use reroo;
UPDATE `reroo`.`whoapp` SET `active`=1;

ALTER TABLE `whoapp` ADD `auth` tinyint(4), ADD KEY (`auth`);

UPDATE reroo.whoapp SET coid='reroo';

SELECT * FROM reroo.whoapp;
SELECT * FROM reroo.jobcatact ORDER BY week,idx,category ASC;
SELECT * FROM reroo.week;

SELECT * FROM reroo.whoapp WHERE emailid='noah@sitebuilt.net' AND appid='jobs';

use reroo;
INSERT INTO jobcatact (`job`, `category`, active, week, idx, coid) VALUES ('Marketting', 'dog', 0, 18, 1, 'reroo'), ('Nursery', NULL, 1, 18, 2, 'reroo'), ('Truck and tools', NULL, 0, 18, 3, 'reroo')

use reroo;
DROP TABLE IF EXISTS `tcardjc`;
CREATE TABLE `tcardjc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wdprt` varchar(12) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `job` varchar(60) DEFAULT NULL,
  `cat` varchar(12) DEFAULT NULL,
  `hrs` decimal(4,2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY (`wdprt`),
  KEY (`emailid`),
  KEY (`job`),
  KEY (`cat`),
  KEY `jobcat` (`job`,`cat`)  USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

use reroo;
INSERT INTO `tcardjc` (`wdprt`,`emailid`, `job`, `cat`, `hrs`) VALUES
('2018-W35-1', 'tim@sitebuilt.net', 'HYCC', 'constr', 8.25),
('2018-W35-2', 'tim@sitebuilt.net', 'HYCC', '', 3.50),
('2018-W35-2', 'tim@sitebuilt.net', 'Eastie Farm', '', 5.00),
('2018-W35-4', 'tim@sitebuilt.net', 'Marketting', '', 4.25),
('2018-W35-4', 'tim@sitebuilt.net', 'HYCC', 'constr', 3),
('2018-W35-5', 'tim@sitebuilt.net', 'Eastie Farm', 'constr', 2),
('2018-W35-5', 'tim@sitebuilt.net', 'Marketting', 'constr', 3),
('2018-W35-5', 'tim@sitebuilt.net', 'HYCC', 'constr', 4.5)

use reroo;
DROP TABLE IF EXISTS `tcardpu`;
CREATE TABLE `tcardpu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wdprt` varchar(12) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `inout` varchar(60) DEFAULT NULL,
  `hrs` decimal(4,2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY (`wdprt`),
  KEY (`emailid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


use reroo;
INSERT INTO `tcardpu`  (`wdprt`, `emailid`, `inout`, `hrs`) VALUES
('2018-W35-1', 'tim@sitebuilt.net', '["7:30", "15:45"]', 8.25),
("2018-W35-2", "tim@sitebuilt.net", '["7:15", "15:45"]', 8.5),
("2018-W35-4", "tim@sitebuilt.net", '["8:30", "15:45"]', 7.25),
("2018-W35-5", "tim@sitebuilt.net", '["7:30", "15:45", "15:45", "17:00"]', 9.5)

use reroo;
select * from tcardpu where wdprt like('2018-W35%')
select * from tcardjc where wdprt like('2018-W35%')

use reroo;
ALTER TABLE `tcardpu` ADD `coid` varchar(20), ADD KEY (`coid`);
ALTER TABLE `tcardjc` ADD `coid` varchar(20), ADD KEY (`coid`);
UPDATE tcardpu SET coid='reroo';
UPDATE tcardjc SET coid='reroo';

use reroo;
ALTER TABLE `tcardpu` ADD UNIQUE KEY `wec` (`wdprt`, `emailid`, `coid`);

use reroo;
ALTER TABLE `tcardjc` ADD UNIQUE KEY `wejcc` (`wdprt`, `emailid`, `job`, `cat`, `coid`);

use reroo;
ALTER TABLE `jobcatact` ADD UNIQUE KEY `jic` (`job`, `idx`, `coid`);

USE reroo;
INSERT INTO tcardpu
SET `name` = 'mckenna.tim@gmail.com',
    `selected` = '[0,0,0,1,1,0,0,0,0,1,0]'
ON DUPLICATE KEY
UPDATE 
    `name` = 'mckenna.tim@gmail.com',
    `selected` = '[1,1,0,1,1,0,0,0,0,1,0]'


use reroo;
DROP TABLE IF EXISTS `tcardwk`;
CREATE TABLE `tcardwk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wprt` varchar(12) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `hrs` decimal(4,2) NOT NULL DEFAULT '0',
  `coid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wec` (`wprt`, `emailid`, `coid`),
  KEY (`wprt`),
  KEY (`emailid`),
  KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;    

use reroo;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'reroo' 
ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'reroo'

use reroo;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-6', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'reroo' 
ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-6', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'reroo'

use reroo;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[]', `hrs` = 0, `coid` = 'reroo' 
ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[]', `hrs` = 0, `coid` = 'reroo'

use reroo;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'reroo' ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'reroo'

use reroo;
INSERT INTO `whoapp` (`emailid`, `appid`, `permisos`, `coid`, `auth`) VALUES
('noah@sitebuilt.net', 'tcard', 'payroll', 'reroo', NULL),
('oliviaallegramay@gmail.com', 'tcard', 'user', 'reroo', NULL),
('oliviaallegramay@gmail.com', 'payroll', 'user', 'reroo', NULL),
('oliviaallegramay@gmail.com', 'jobs', 'user', 'reroo', NULL),
( 'noah.mckenna@gmail.com', 'payroll', 'admin', 'reroo', 1),
( 'perimckenna@gmail.com', 'payroll', 'admin', 'reroo', 1),
( 'perimckenna@yahoo.com', 'payroll', 'admin', 'reroo', 1),
( 'mckenna.tim@gmail.com', 'payroll', 'admin', 'reroo', 1);

use reroo;
select emailid, active from whoapp WHERE coid='reroo' AND appid = 'tcard'use reroo;
select emailid, active from whoapp WHERE coid='reroo' AND appid = 'tcard'

use reroo;
SELECT emailid, hrs, `status` FROM tcardwk WHERE status='submitted';

use reroo;
DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstday` int(2),
  `ot` text,
  `effective` date,
  `coid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`effective`),
  KEY (`coid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `settings` (`firstday`, `ot`, `effective`, `coid`)
VALUES 
(1, '{"over40": 1.0, "sa": 1.0, "su": 1.0}', '2017-01-01', 'reroo'),
(1, '{"over40": 1.5, "sa": 1.0, "su": 1.0}', '2018-01-01', 'reroo'),
(5, '{"over40": 1.5, "sa": 1.0, "su": 1.0}', '2018-11-01', 'reroo'),
(1, '{"over40": 1.5, "sa": 1.0, "su": 1.5}', '2018-06-01', 'reroo');
SELECT * FROM `settings` WHERE `effective`< CURDATE() AND `coid`= 'reroo' ORDER BY `effective` DESC LIMIT 1;

SELECT * FROM `settings` WHERE `effective`< CURDATE() ORDER BY `effective` DESC LIMIT 1;

use reroo;
INSERT INTO jobs0 SELECT * FROM jobcatact WHERE week=0;

use reroo;
CREATE TABLE jobs0 SELECT * FROM jobcatact WHERE week = 0;

INSERT INTO `jobcatact` (`id`, `job`, `category`, `active`, `week`, `idx`, `coid`) VALUES
(2262, 'Ken Wing - Rockview', '', 1, 0, 0, 'reroo'),
(2263, 'Ken Wing - Rockview', 'stonework', 0, 0, 0, 'reroo'),
(2264, 'Egelston Library', NULL, 1, 0, 1, 'reroo'),
(2265, 'Nursery', '', 0, 0, 2, 'reroo'),
(2266, '2054 Dot Ave', '', 1, 0, 3, 'reroo'),
(2267, 'HYCC', '', 0, 0, 4, 'reroo'),
(2268, 'HYCC', 'constr', 1, 0, 4, 'reroo'),
(2269, 'HYCC', 'maintain', 1, 0, 4, 'reroo'),
(2272, 'Eastie Farm', '', 1, 0, 6, 'reroo'),
(2273, '105 Green St', NULL, 0, 0, 7, 'reroo'),
(2274, 'Marketting', NULL, 1, 0, 8, 'reroo'),
(2275, '19 cornelius way', NULL, 0, 0, 9, 'reroo'),
(2276, '20 Alveston', NULL, 1, 0, 10, 'reroo'),
(2277, '16 roanoke', NULL, 0, 0, 11, 'reroo'),
(2278, 'Roz Walter - 20 Dell', NULL, 0, 0, 12, 'reroo'),
(2279, 'Boston Microgreens', NULL, 0, 0, 13, 'reroo'),
(2280, 'Gibran and Samantha', NULL, 0, 0, 14, 'reroo'),
(2281, '195 chestnut', NULL, 0, 0, 15, 'reroo'),
(2282, '40 chestnut ave - alex marburger', NULL, 0, 0, 16, 'reroo'),
(2283, '38 Jamaica', NULL, 0, 0, 17, 'reroo'),
(2284, '18 Holbrook - Everett and Molly', NULL, 0, 0, 18, 'reroo'),
(2285, 'Karen and Duncan - 254 Hawthorne', NULL, 0, 0, 19, 'reroo'),
(2286, 'Terese Hammerle - ', NULL, 0, 0, 20, 'reroo'),
(2287, 'Arbour Hospital', NULL, 0, 0, 21, 'reroo'),
(2288, 'Diana McClure ', NULL, 0, 0, 22, 'reroo'),
(2289, 'Cam Kerry - 21 Adelaide', NULL, 0, 0, 23, 'reroo'),
(2290, 'Nancy Lipamn - Kitteridge Court', NULL, 0, 0, 24, 'reroo'),
(2291, '68 Cypress', NULL, 0, 0, 25, 'reroo'),
(2292, 'Rick Hammond - Liszt St Rosi', NULL, 0, 0, 26, 'reroo'),
(2293, 'Jeanette - Clayborne garden green roof', NULL, 0, 0, 27, 'reroo'),
(2294, '76 South St, Lucy Orloski', NULL, 0, 0, 28, 'reroo'),
(2295, '349 VFW Parkway - Bunny Hickey', NULL, 0, 0, 29, 'reroo'),
(2296, '68 Rockview - terri martell', NULL, 0, 0, 30, 'reroo'),
(2297, 'Jennileen Joseph 218 Neponset Ave', NULL, 0, 0, 31, 'reroo'),
(2298, 'Nathan Lord - 158 Hampshire', NULL, 0, 0, 32, 'reroo'),
(2299, 'South Boston Library - Kathleen Mar', NULL, 0, 0, 33, 'reroo'),
(2300, 'Jodie Wahldesbuhl - 22 Thayer st brookline', NULL, 0, 0, 34, 'reroo'),
(2301, 'Michael Bellefeille - 40 Gartland', NULL, 0, 0, 35, 'reroo'),
(2302, 'Daphnah and Jay - 1435 Centre', NULL, 0, 0, 36, 'reroo'),
(2303, '241-5 Chestnut Ave', NULL, 0, 0, 37, 'reroo'),
(2304, '241-5 Chestnut Ave', NULL, 0, 0, 37, 'reroo'),
(2305, '17 Park Lane', NULL, 0, 0, 38, 'reroo'),
(2306, 'JPNDC brewery', NULL, 0, 0, 39, 'reroo'),
(2307, 'John Stainton - 37 Pondview', NULL, 0, 0, 40, 'reroo'),
(2308, '37 ogden', NULL, 0, 0, 41, 'reroo'),
(2309, '14 chestnut', NULL, 0, 0, 42, 'reroo'),
(2310, 'Dae Kim - 16 Zamora', NULL, 0, 0, 43, 'reroo'),
(2311, '63-65 Chestnut', '', 0, 0, 44, 'reroo'),
(2312, '233 Chestnut - Greg Gulickssen', NULL, 0, 0, 45, 'reroo'),
(2313, '126 Thornton - Lucy Lomas', NULL, 0, 0, 46, 'reroo'),
(2314, 'Dee and Maya - Rockview', NULL, 0, 0, 47, 'reroo'),
(2315, 'Michael Hecht - 9 Park Lane', NULL, 1, 0, 48, 'reroo'),
(2316, 'Chestnut Rockview Backwoods', NULL, 0, 0, 49, 'reroo'),
(2317, '11 danforth', NULL, 1, 0, 50, 'reroo'),
(2318, 'connolly library', NULL, 0, 0, 51, 'reroo'),
(2319, 'Marushka Glissen - Lamartine?', NULL, 0, 0, 52, 'reroo'),
(2320, 'Donna Woonteiler - 8 Chetnut Place', NULL, 0, 0, 53, 'reroo'),
(2321, 'J&M Brown', NULL, 0, 0, 54, 'reroo');
