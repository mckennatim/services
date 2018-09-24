show tables from timecards;
USE timecards;
SELECT * FROM jobcatact WHERE week=0;

select * from timecards.whoapp;
select * from timecards.jobcatact;
select * from timecards.jobcatact WHERE active;
delete from timecards.jobcatact;

ALTER TABLE timecards.jobcatact MODIFY COLUMN job VARCHAR(60); 

ALTER TABLE timecards.jobcatact MODIFY COLUMN week int(2) NOT NULL DEFAULT 0; 

update timecards.jobcatact set 
TRUNCATE TABLE timecards.jobcatact;
INSERT INTO timecards.jobcatact (job)
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

USE timecards;
ALTER TABLE `jobcatact` ADD `coid` varchar(20), ADD KEY (`coid`);
UPDATE `jobcatact` SET coid='timecards';
SELECT * FROM jobcatact;


ALTER TABLE `jobcatact` ADD KEY jobcat (`job`, `category`)
ALTER TABLE `jobcatact` ADD KEY (`category`)
ALTER TABLE `jobcatact` ADD KEY (`job`)
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `day1` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


USE timecards;
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

select * from timecards.workers;

UPDATE timecards.jobcatact SET active = ROUND(rand())

use timecards;
ALTER TABLE `timecards.workers` RENAME TO workers;



use timecards;
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


use timecards;
select email from workers;

USE timecards;
ALTER TABLE workers
ADD COLUMN id INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (id);

SELECT * from timecards.workers;
SELECT * from timecards.workers;
SELECT * from timecards.whoapp;


UPDATE timecards.workers SET role='consultor' WHERE name='Tim'
UPDATE timecards.workers SET role='member' WHERE name='Olivia';

show columns from timecards.whoapp

use timecards;
alter table whoapp
ADD `id` INT NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`),
modify column appid varchar(20),
modify column permisos varchar(20),
modify column emailid varchar(60),
add key (`emailid`),
add key (`appid`),
add key (`permisos`);

show columns from timecards.workers

use timecards;
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

use timecards;
alter table workers
modify column name varchar(60),
add key (`name`);
select * from timecards.workers

use timecards;
ALTER TABLE `whoapp` ADD `coid` varchar(20), ADD KEY (`coid`);
use timecards;
ALTER TABLE `whoapp` ADD `active` tinyint(4), ADD KEY (`active`);
use timecards;
UPDATE `timecards`.`whoapp` SET `active`=1;

ALTER TABLE `whoapp` ADD `auth` tinyint(4), ADD KEY (`auth`);

UPDATE timecards.whoapp SET coid='timecards';

SELECT * FROM timecards.whoapp;
SELECT * FROM timecards.jobcatact ORDER BY week,idx,category ASC;
SELECT * FROM timecards.week;

SELECT * FROM timecards.whoapp WHERE emailid='noah@sitebuilt.net' AND appid='jobs';

use timecards;
INSERT INTO jobcatact (`job`, `category`, active, week, idx, coid) VALUES ('Marketting', 'dog', 0, 18, 1, 'timecards'), ('Nursery', NULL, 1, 18, 2, 'timecards'), ('Truck and tools', NULL, 0, 18, 3, 'timecards')

use timecards;
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

use timecards;
INSERT INTO `tcardjc` (`wdprt`,`emailid`, `job`, `cat`, `hrs`) VALUES
('2018-W35-1', 'tim@sitebuilt.net', 'HYCC', 'constr', 8.25),
('2018-W35-2', 'tim@sitebuilt.net', 'HYCC', '', 3.50),
('2018-W35-2', 'tim@sitebuilt.net', 'Eastie Farm', '', 5.00),
('2018-W35-4', 'tim@sitebuilt.net', 'Marketting', '', 4.25),
('2018-W35-4', 'tim@sitebuilt.net', 'HYCC', 'constr', 3),
('2018-W35-5', 'tim@sitebuilt.net', 'Eastie Farm', 'constr', 2),
('2018-W35-5', 'tim@sitebuilt.net', 'Marketting', 'constr', 3),
('2018-W35-5', 'tim@sitebuilt.net', 'HYCC', 'constr', 4.5)

use timecards;
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


use timecards;
INSERT INTO `tcardpu`  (`wdprt`, `emailid`, `inout`, `hrs`) VALUES
('2018-W35-1', 'tim@sitebuilt.net', '["7:30", "15:45"]', 8.25),
("2018-W35-2", "tim@sitebuilt.net", '["7:15", "15:45"]', 8.5),
("2018-W35-4", "tim@sitebuilt.net", '["8:30", "15:45"]', 7.25),
("2018-W35-5", "tim@sitebuilt.net", '["7:30", "15:45", "15:45", "17:00"]', 9.5)

use timecards;
select * from tcardpu where wdprt like('2018-W35%')
select * from tcardjc where wdprt like('2018-W35%')

use timecards;
ALTER TABLE `tcardpu` ADD `coid` varchar(20), ADD KEY (`coid`);
ALTER TABLE `tcardjc` ADD `coid` varchar(20), ADD KEY (`coid`);
UPDATE tcardpu SET coid='timecards';
UPDATE tcardjc SET coid='timecards';

use timecards;
ALTER TABLE `tcardpu` ADD UNIQUE KEY `wec` (`wdprt`, `emailid`, `coid`);

use timecards;
ALTER TABLE `tcardjc` ADD UNIQUE KEY `wejcc` (`wdprt`, `emailid`, `job`, `cat`, `coid`);

use timecards;
ALTER TABLE `jobcatact` ADD UNIQUE KEY `jic` (`job`, `idx`, `coid`);

USE timecards;
INSERT INTO tcardpu
SET `name` = 'mckenna.tim@gmail.com',
    `selected` = '[0,0,0,1,1,0,0,0,0,1,0]'
ON DUPLICATE KEY
UPDATE 
    `name` = 'mckenna.tim@gmail.com',
    `selected` = '[1,1,0,1,1,0,0,0,0,1,0]'


use timecards;
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

use timecards;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'timecards' 
ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'timecards'

use timecards;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-6', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'timecards' 
ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-6', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'timecards'

use timecards;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[]', `hrs` = 0, `coid` = 'timecards' 
ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[]', `hrs` = 0, `coid` = 'timecards'

use timecards;
INSERT INTO tcardpu SET `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'timecards' ON DUPLICATE KEY UPDATE `wdprt` = '2018-W36-5', `emailid` = 'tim@sitebuilt.net', `inout` = '[\"7:30\",\"15:15\",\"15:45\",\"17:00\",\"16:12\"]', `hrs` = 9.5, `coid` = 'timecards'

use timecards;
INSERT INTO `whoapp` (`emailid`, `appid`, `permisos`, `coid`, `auth`) VALUES
('noah@sitebuilt.net', 'tcard', 'payroll', 'timecards', NULL),
('oliviaallegramay@gmail.com', 'tcard', 'user', 'timecards', NULL),
('oliviaallegramay@gmail.com', 'payroll', 'user', 'timecards', NULL),
('oliviaallegramay@gmail.com', 'jobs', 'user', 'timecards', NULL),
( 'noah.mckenna@gmail.com', 'payroll', 'admin', 'timecards', 1),
( 'perimckenna@gmail.com', 'payroll', 'admin', 'timecards', 1),
( 'perimckenna@yahoo.com', 'payroll', 'admin', 'timecards', 1),
( 'mckenna.tim@gmail.com', 'payroll', 'admin', 'timecards', 1);

use timecards;
select emailid, active from whoapp WHERE coid='timecards' AND appid = 'tcard'use timecards;
select emailid, active from whoapp WHERE coid='timecards' AND appid = 'tcard'

use timecards;
SELECT emailid, hrs, `status` FROM tcardwk WHERE status='submitted';

use timecards;
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
(1, '{"over40": 1.0, "sa": 1.0, "su": 1.0}', '2017-01-01', 'timecards'),
(1, '{"over40": 1.5, "sa": 1.0, "su": 1.0}', '2018-01-01', 'timecards'),
(5, '{"over40": 1.5, "sa": 1.0, "su": 1.0}', '2018-11-01', 'timecards'),
(1, '{"over40": 1.5, "sa": 1.0, "su": 1.5}', '2018-06-01', 'timecards');
SELECT * FROM `settings` WHERE `effective`< CURDATE() AND `coid`= 'timecards' ORDER BY `effective` DESC LIMIT 1;

SELECT * FROM `settings` WHERE `effective`< CURDATE() ORDER BY `effective` DESC LIMIT 1;

use timecards;
INSERT INTO jobs0 SELECT * FROM jobcatact WHERE week=0;

use timecards;
CREATE TABLE jobs0 SELECT * FROM jobcatact WHERE week = 0;

INSERT INTO `jobcatact` (`id`, `job`, `category`, `active`, `week`, `idx`, `coid`) VALUES
(2262, 'Ken Wing - Rockview', '', 1, 0, 0, 'timecards'),
(2263, 'Ken Wing - Rockview', 'stonework', 0, 0, 0, 'timecards'),
(2264, 'Egelston Library', NULL, 1, 0, 1, 'timecards'),
(2265, 'Nursery', '', 0, 0, 2, 'timecards'),
(2266, '2054 Dot Ave', '', 1, 0, 3, 'timecards'),
(2267, 'HYCC', '', 0, 0, 4, 'timecards'),
(2268, 'HYCC', 'constr', 1, 0, 4, 'timecards'),
(2269, 'HYCC', 'maintain', 1, 0, 4, 'timecards'),
(2272, 'Eastie Farm', '', 1, 0, 6, 'timecards'),
(2273, '105 Green St', NULL, 0, 0, 7, 'timecards'),
(2274, 'Marketting', NULL, 1, 0, 8, 'timecards'),
(2275, '19 cornelius way', NULL, 0, 0, 9, 'timecards'),
(2276, '20 Alveston', NULL, 1, 0, 10, 'timecards'),
(2277, '16 roanoke', NULL, 0, 0, 11, 'timecards'),
(2278, 'Roz Walter - 20 Dell', NULL, 0, 0, 12, 'timecards'),
(2279, 'Boston Microgreens', NULL, 0, 0, 13, 'timecards'),
(2280, 'Gibran and Samantha', NULL, 0, 0, 14, 'timecards'),
(2281, '195 chestnut', NULL, 0, 0, 15, 'timecards'),
(2282, '40 chestnut ave - alex marburger', NULL, 0, 0, 16, 'timecards'),
(2283, '38 Jamaica', NULL, 0, 0, 17, 'timecards'),
(2284, '18 Holbrook - Everett and Molly', NULL, 0, 0, 18, 'timecards'),
(2285, 'Karen and Duncan - 254 Hawthorne', NULL, 0, 0, 19, 'timecards'),
(2286, 'Terese Hammerle - ', NULL, 0, 0, 20, 'timecards'),
(2287, 'Arbour Hospital', NULL, 0, 0, 21, 'timecards'),
(2288, 'Diana McClure ', NULL, 0, 0, 22, 'timecards'),
(2289, 'Cam Kerry - 21 Adelaide', NULL, 0, 0, 23, 'timecards'),
(2290, 'Nancy Lipamn - Kitteridge Court', NULL, 0, 0, 24, 'timecards'),
(2291, '68 Cypress', NULL, 0, 0, 25, 'timecards'),
(2292, 'Rick Hammond - Liszt St Rosi', NULL, 0, 0, 26, 'timecards'),
(2293, 'Jeanette - Clayborne garden green roof', NULL, 0, 0, 27, 'timecards'),
(2294, '76 South St, Lucy Orloski', NULL, 0, 0, 28, 'timecards'),
(2295, '349 VFW Parkway - Bunny Hickey', NULL, 0, 0, 29, 'timecards'),
(2296, '68 Rockview - terri martell', NULL, 0, 0, 30, 'timecards'),
(2297, 'Jennileen Joseph 218 Neponset Ave', NULL, 0, 0, 31, 'timecards'),
(2298, 'Nathan Lord - 158 Hampshire', NULL, 0, 0, 32, 'timecards'),
(2299, 'South Boston Library - Kathleen Mar', NULL, 0, 0, 33, 'timecards'),
(2300, 'Jodie Wahldesbuhl - 22 Thayer st brookline', NULL, 0, 0, 34, 'timecards'),
(2301, 'Michael Bellefeille - 40 Gartland', NULL, 0, 0, 35, 'timecards'),
(2302, 'Daphnah and Jay - 1435 Centre', NULL, 0, 0, 36, 'timecards'),
(2303, '241-5 Chestnut Ave', NULL, 0, 0, 37, 'timecards'),
(2304, '241-5 Chestnut Ave', NULL, 0, 0, 37, 'timecards'),
(2305, '17 Park Lane', NULL, 0, 0, 38, 'timecards'),
(2306, 'JPNDC brewery', NULL, 0, 0, 39, 'timecards'),
(2307, 'John Stainton - 37 Pondview', NULL, 0, 0, 40, 'timecards'),
(2308, '37 ogden', NULL, 0, 0, 41, 'timecards'),
(2309, '14 chestnut', NULL, 0, 0, 42, 'timecards'),
(2310, 'Dae Kim - 16 Zamora', NULL, 0, 0, 43, 'timecards'),
(2311, '63-65 Chestnut', '', 0, 0, 44, 'timecards'),
(2312, '233 Chestnut - Greg Gulickssen', NULL, 0, 0, 45, 'timecards'),
(2313, '126 Thornton - Lucy Lomas', NULL, 0, 0, 46, 'timecards'),
(2314, 'Dee and Maya - Rockview', NULL, 0, 0, 47, 'timecards'),
(2315, 'Michael Hecht - 9 Park Lane', NULL, 1, 0, 48, 'timecards'),
(2316, 'Chestnut Rockview Backwoods', NULL, 0, 0, 49, 'timecards'),
(2317, '11 danforth', NULL, 1, 0, 50, 'timecards'),
(2318, 'connolly library', NULL, 0, 0, 51, 'timecards'),
(2319, 'Marushka Glissen - Lamartine?', NULL, 0, 0, 52, 'timecards'),
(2320, 'Donna Woonteiler - 8 Chetnut Place', NULL, 0, 0, 53, 'timecards'),
(2321, 'J&M Brown', NULL, 0, 0, 54, 'timecards');

USE timecards;
SELECT * FROM `tcardpu` WHERE emailid='noah.mckenna@gmail.com' AND wdprt LIKE('2018-W37-%') ORDER BY coid, emailid, wdprt;


use timecards;
DROP TABLE IF EXISTS `co`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `co` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodtil` date,
  `coid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`goodtil`),
  UNIQUE KEY (`coid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

use timecards;
insert into co (`goodtil`, `coid`) values ('2018-01-12', 'reroo')

use timecards;
INSERT INTO co SET `goodtil` = '2018-11-12', `coid` = 'sbs'
ON DUPLICATE KEY UPDATE `goodtil` = '2018-11-12', `coid` = 'sbs';

use timecards;
INSERT INTO co SET `goodtil` = '2018-01-12', `coid` = 'reroo'
ON DUPLICATE KEY UPDATE `goodtil` = '2018-01-12', `coid` = 'reroo';

use timecards;
SELECT * FROM `co` where goodtil > CURDATE();

use timecards;
DROP TABLE IF EXISTS `co`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `co` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodtil` date,
  `coid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`goodtil`),
  UNIQUE KEY (`coid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

use timecards;
DROP TABLE IF EXISTS `roleapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roleapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(20) DEFAULT NULL,
  `appid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`role`),
  KEY (`appid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

use timecards;
insert into roleapp (`role`, `appid`) 
values 
('partner', 'tcard'),
('partner', 'OKtcard'),
('partner', 'jobs'),
('partner', 'pay'),
('partner', 'persons');

use timecards;
insert into roleapp (`role`, `appid`) 
values 
('super', 'tcard'),
('super', 'OKtcard'),
('worker', 'jobs'),
('hr', 'tcard'),
('hr', 'persons');

use timecards;
DROP TABLE IF EXISTS `rolewho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rolewho` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(20) DEFAULT NULL,
  `emailid` varchar(60) DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY (`role`),
  KEY (`emailid`),
  KEY (`coid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

use timecards;
insert into rolewho (`emailid`, `role`, `coid`) 
values 
('noah@sitebuilt.net', 'partner', 'reroo'),
('oliviaallegramay@gmail.com', 'partner', 'reroo'),
('mckenna.tim@gmail.com', 'partner', 'reroo'),
('mckenna.tim@gmail.com', 'partner', 'sbs'),
('perimckenna@gmail.com', 'partner', 'reroo'),
('perimckenna@gmail.com', 'partner', 'sbs'),
('perimckenna@yahoo.com', 'hr', 'reroo'),
('tim2@sitebuilt.net', 'super', 'reroo'),
('tim@sitebuilt.net', 'worker', 'reroo'),
('tim@sitebuilt.net', 'worker', 'sbs'),
('rubie@sitebuilt.net', 'worker',  'reroo'),
('jade@sitebuilt.net', 'worker',  'reroo'),
('modesto@sitebuilt.net', 'worker',  'reroo'),
('pampi@sitebuilt.net', 'worker',  'reroo'),
('samuel@sitebuilt.net', 'worker',  'reroo'),
('karen@sitebuilt.net', 'worker',  'reroo');

select w.`emailid`,  w.`role`, w.`coid` from `rolewho` w

USE timecards;
SELECT w.`emailid`,  w.`role`, w.`coid`, a.`appid`
FROM `rolewho` w
LEFT JOIN `roleapp` a ON a.`role`= w.`role`
WHERE a.appid = 'tcard' 
AND w.emailid = 'mckenna.tim@gmail.com'
AND w.coid = 'reroo'

USE timecards;
SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid
FROM rolewho w
LEFT JOIN co c ON c.coid= w.coid
LEFT JOIN `roleapp` a ON a.`role`= w.`role`
WHERE w.emailid = 'mckenna.tim@gmail.com'
AND c.goodtil > CURDATE()
AND a.appid = 'tcard'
AND c.coid = 'reroo'

/*
for regtoka.auth and BearerTokenApp
(you only know the appid and the emailid)
*/
USE timecards;
SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid
FROM rolewho w
RIGHT JOIN `roleapp` a ON a.`role`= w.`role`
LEFT JOIN co c ON c.coid= w.coid
WHERE w.emailid = 'tim@sitebuilt.net'
AND c.goodtil > CURDATE()
AND a.appid = 'tcard'

SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w RIGHT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = 'tim@sitebuilt.net' AND c.goodtil > CURDATE() AND a.appid = 'tcard' 

SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w RIGHT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ?

/*
for bearerTokenCoid 
(you  know the appid and the emailid and the coid)
*/

USE timecards;
SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid
FROM rolewho w
RIGHT JOIN `roleapp` a ON a.`role`= w.`role`
LEFT JOIN co c ON c.coid= w.coid
WHERE w.emailid = 'tim@sitebuilt.net'
AND c.goodtil > CURDATE()
AND a.appid = 'tcard'
AND c.coid = 'reroo'

SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w LEFT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = 'tim@sitebuilt.net' AND c.goodtil > CURDATE() AND a.appid = 'tcard' AND c.coid = 'reroo' 

SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w LEFT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.appid = ? AND c.coid = ?


USE timecards;
SELECT w.emailid, w.role, c.coid, c.goodtil, a.task
FROM rolewho w
RIGHT JOIN co c ON c.coid= w.coid
LEFT JOIN `roleapp` a ON a.`role`= w.`role`
WHERE w.emailid = 'tim@sitebuilt.net'
AND c.goodtil > CURDATE()
AND a.task = 'jobs'

SELECT w.emailid, w.role, c.coid, c.goodtil, a.task FROM rolewho w LEFT JOIN co c ON c.coid= w.coid LEFT JOIN `roleapp` a ON a.`role`= w.`role` WHERE w.emailid = 'mckenna.tim@gmail.com' AND c.goodtil > CURDATE() AND a.task = 'tcard' 

SELECT w.emailid, w.role, c.coid, c.goodtil, a.task FROM rolewho w LEFT JOIN co c ON c.coid= w.coid LEFT JOIN `roleapp` a ON a.`role`= w.`role` WHERE w.emailid = ? AND c.goodtil > CURDATE() AND a.task = ? 

use timecards;
select * from jobcatact;

ALTER TABLE `timecards`.`jobcatact` DROP INDEX `jobcatwk`, ADD UNIQUE `jobcatwkco` (`job`, `category`, `week`, `coid`) USING BTREE;


ALTER TABLE `timecards`.`roleapp` CHANGE `task` `appid` VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL;

use timecards;
SELECT w.emailid, w.role, a.task FROM rolewho w 
RIGHT JOIN `roleapp` a ON a.`role`= w.`role` 
WHERE w.emailid = 'mckenna.tim@gmail.com' 
AND a.task = 'tcard';

select * from `timecards`.`roleapp`;

select * from `timecards`.`rolewho`;

UPDATE `timecards`.`roleapp` SET `task`='tcard' WHERE role='worker';

use timecards;
DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `emailid` varchar(60) DEFAULT NULL,
  `firstmid` varchar(60) DEFAULT NULL,
  `lastname` varchar(40) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city`  varchar(50) DEFAULT NULL,
  `st`  varchar(2) DEFAULT NULL,
  `zip`  varchar(10) DEFAULT NULL,
  `ssn`  varchar(11) DEFAULT NULL,
  `w4allow`  int(2) DEFAULT NULL,
  `stallow`  int(2) DEFAULT NULL,
  `rate` decimal(5,2),
  `active` int(1) DEFAULT NULL,
  `coid` varchar(20) DEFAULT NULL,
  `effective` date,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ece` (`emailid`, `coid`, `effective`),
  KEY (`firstmid`),
  KEY (`lastname`),
  KEY (`emailid`),
  KEY (`city`),
  KEY (`st`),
  KEY (`active`),
  KEY (`coid`),
  KEY (`rate`),
  KEY (`effective`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

USE timecards;
INSERT INTO persons (`emailid`, `firstmid`, `lastname`, `street`, `city`, `state`, `zip`, `ssn`, `rate`, `w4allow`, `stallow`, `active`, `effective`, `coid`) 
VALUES 
('mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 37.25, 1, 1, 1, '2018-11-23', 'sbs');

USE timecards;
INSERT INTO persons
SET 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 37.25, 
  w4allow = 1, 
  stallow = 1, 
  active = 1, 
  effective = '2018-11-23', 
  coid = 'sbs'
ON DUPLICATE KEY
UPDATE 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 37.25, 
  w4allow = 1, 
  stallow = 1, 
  active = 1, 
  effective = '2018-11-23', 
  coid = 'sbs';

USE timecards;
INSERT INTO persons
SET 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 38.25, 
  w4allow = 3, 
  stallow = 2, 
  active = 1, 
  effective = '2018-11-23', 
  coid = 'sbs'
ON DUPLICATE KEY
UPDATE 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 38.25, 
  w4allow = 3, 
  stallow = 2, 
  active = 1, 
  effective = '2018-11-23', 
  coid = 'sbs';

  USE timecards;
INSERT INTO persons
SET 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 47.25, 
  w4allow = 1, 
  stallow = 1, 
  active = 1, 
  effective = '2018-09-22', 
  coid = 'sbs'
ON DUPLICATE KEY
UPDATE 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 47.25, 
  w4allow = 1, 
  stallow = 1, 
  active = 1, 
  effective = '2018-09-22', 
  coid = 'sbs';

USE timecards;
INSERT INTO persons
SET 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 35.25, 
  w4allow = 1, 
  stallow = 1, 
  active = 1, 
  effective = '2018-06-22', 
  coid = 'sbs'
ON DUPLICATE KEY
UPDATE 
  emailid = 'mckenna.tim@gmail.com', 
  firstmid = 'Timothy S.', 
  lastname = 'McKenna', 
  street = '12 Parley Vale', 
  city = 'Jamaica Plain', 
  st = 'MA', 
  zip = '02130', 
  ssn = '121-44-0295', 
  rate = 35.25, 
  w4allow = 1, 
  stallow = 1, 
  active = 1, 
  effective = '2018-06-22', 
  coid = 'sbs';

select * from `timecards`.`persons` ;

SELECT * 
FROM `timecards`.`persons` 
WHERE effective <= CURDATE()
ORDER BY effective DESC;

SELECT * 
FROM `timecards`.`persons` 
WHERE effective <= CURDATE()
ORDER BY effective DESC
LIMIT 1;

USE timecards;
SELECT r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, p.`active`, p.`effective`, p.`coid` 
FROM rolewho r 
LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid 
WHERE r.coid='sbs'
AND p.effective <= CURDATE()
ORDER BY p.effective DESC
LIMIT 1;

SELECT r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, p.`active`, p.`effective`, p.`coid` FROM rolewho r LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid WHERE r.coid='sbs' AND p.effective <= CURDATE() ORDER BY p.effective DESC LIMIT 1 

SELECT r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, p.`active`, p.`effective`, p.`coid` FROM rolewho r LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid WHERE r.coid= ? AND p.effective <= CURDATE() ORDER BY p.effective DESC LIMIT 1 