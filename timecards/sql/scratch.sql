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
SELECT p.effective, r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, r.`active`, p.`effective`, p.`coid` 
FROM rolewho r 
LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid 
WHERE r.coid='sbs'
ORDER BY p.effective DESC

SELECT r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, r.`active`, p.`effective`, p.`coid` FROM rolewho r LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid WHERE r.coid='sbs' ORDER BY p.effective 

SELECT r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, p.`active`, p.`effective`, p.`coid` FROM rolewho r LEFT JOIN persons p ON p.emailid = r.emailid AND p.coid =r.coid WHERE r.coid= ?  ORDER BY p.effective 

ALTER TABLE `rolewho` ADD `active` INT(1) NOT NULL DEFAULT '1' AFTER `coid`, ADD INDEX `active` (`active`);

ALTER TABLE `timecards`.`rolewho` ADD UNIQUE `rec` (`role`, `emailid`, `coid`);

ALTER TABLE `timecards`.`rolewho` DROP INDEX `rec`, ADD UNIQUE `rec` (`emailid`, `coid`) USING BTREE;

/*
(SELECT p.effective, r.id, r.emailid, r.role, p.`firstmid`, p.`lastname`, p.`street`, p.`city`, p.`st`, p.`zip`, p.`ssn`, p.rate, p.`w4allow`, p.`stallow`, r.`active`, p.`effective`, p.`coid` 
FROM rolewho r 
LEFT JOIN persons p 
ON p.emailid = r.emailid 
AND p.coid =r.coid 
WHERE r.coid= 'sbs' 
AND CURDATE()<p.effective
ORDER BY r.emailid,p.effective DESC
LIMIT 1)
*/

SELECT t.wprt, t.emailid, t.status, t.hrs, t.coid 
FROM `timecards`.`tcardwk` t
WHERE t.coid='reroo'
AND t.status='approved';

CREATE TABLE temp
SELECT t.wprt, t.emailid, t.status, t.hrs, t.coid 
FROM `timecards`.`tcardwk` t
WHERE `coid`='reroo'
AND `status`='approved';

INSERT INTO `temp` (`wprt`, `emailid`, `status`, `hrs`, `coid`) VALUES
('2018-W35', 'tim@sitebuilt.net', 'approved', '33.88', 'reroo'),
('2018-W38', 'tim@sitebuilt.net', 'approved', '33.00', 'reroo'),
('2018-W38', 'mckenna.tim@gmail.com', 'approved', '23.42', 'reroo'),
('2018-W39', 'mckenna.tim@gmail.com', 'approved', '22.83', 'reroo');

SELECT t.wprt, t.emailid, t.status, t.hrs, t.coid, p.firstmid, p.effective
FROM `timecards`.`tcardwk` t
LEFT JOIN `timecards`.`persons` p 
ON t.emailid=p.emailid
WHERE CURDATE()<p.effective
AND t.coid='reroo'
AND t.status='approved';

SELECT t.wprt, t.emailid, t.status, t.hrs, t.coid, p.firstmid, p.effective
FROM `timecards`.`tcardwk` t
JOIN `timecards`.`persons` p 
ON t.emailid=p.emailid AND t.coid=p.coid
AND t.coid='reroo'
AND t.status='approved'

SELECT t.wprt, t.emailid, t.status, t.hrs, p.rate, t.coid, p.firstmid, p.effective
FROM `timecards`.`tcardwk` t
JOIN `timecards`.`persons` p 
ON t.emailid=p.emailid AND t.coid=p.coid
AND t.coid='reroo'
AND t.status='approved'
ORDER BY t.emailid, t.wprt, p.effective DESC

SELECT t.wprt, t.emailid, t.status, t.hrs, p.rate, t.coid, p.firstmid, p.effective
FROM `timecards`.`tcardwk` t
JOIN `timecards`.`persons` p 
ON t.emailid=p.emailid AND t.coid=p.coid
WHERE t.coid='reroo'
AND t.status='approved'
ORDER BY t.emailid, t.wprt, p.effective DESC

SELECT t.wprt, t.emailid, t.status, t.hrs, p.rate, t.coid, p.firstmid, p.effective
FROM `timecards`.`tcardwk` t
JOIN `timecards`.`persons` p 
ON t.emailid=p.emailid AND t.coid=p.coid
WHERE t.coid='reroo'
AND CURDATE() > p.effective 
AND t.status='approved'
ORDER BY t.emailid, t.wprt, p.effective DESC

SELECT p.emailid, p.rate, p.coid, p.firstmid, p.lastname, p.effective
FROM `timecards`.`persons` p
WHERE coid='reroo'
AND emailid ='mckenna.tim@gmail.com'
AND CURDATE() > effective 
ORDER BY effective DESC
LIMIT 1

SELECT t.*, d.*
FROM `timecards`.`tcardwk` t
JOIN  (SELECT p.emailid, p.rate, p.coid, p.firstmid, p.lastname, p.effective
    FROM `timecards`.`persons` p
    WHERE p.coid='reroo'
    AND CURDATE() > effective 
    ORDER BY effective DESC
    LIMIT 1) d
ON t.emailid = d.emailid
AND t.coid=d.coid 
AND t.status='approved'


SELECT * from 
FROM `timecards`.`persons`
GROUP BY 'emailid'
  

SELECT emailid,coid,MAX(CURDATE()>effective)
FROM `timecards`.`persons`
GROUP BY coid,emailid HAVING coid='reroo'

SELECT t.wprt, t.emailid, t.status, t.hrs, t.coid, p.firstmid, p.effective
FROM `timecards`.`tcardwk` t
LEFT JOIN `timecards`.`persons` p 
ON t.emailid=p.emailid
WHERE CURDATE()<p.effective
AND t.coid='reroo'
AND t.status='approved' GROUP BY MAX(effective)

SELECT * 
FROM `timecards`.`persons`
WHERE effective < CURDATE()
AND coid ='reroo'
ORDER BY wprt,emailid,effective desc

DROP TABLE `timecards`.`cureff`;
CREATE TABLE `timecards`.`cureff`
SELECT p.emailid , MAX(p.effective) AS curedate
FROM `timecards`.`persons` p
WHERE effective < CURDATE()
AND p.coid ='reroo'
GROUP BY p.emailid;


/*big sucess: finds the curdate and rate from persons file*/
SELECT c.*, p.*
FROM `timecards`.`cureff` c
JOIN  `timecards`.`persons` p
ON c.emailid=p.emailid 
AND c.curedate=p.effective

SELECT p.*
FROM `timecards`.`cureff` c
JOIN  `timecards`.`persons` p
ON c.emailid=p.emailid 
AND c.curedate=p.effective

/**query to get current persons and rates***/
DROP TABLE IF EXISTS `timecards`.`cureff` ;

CREATE TABLE `timecards`.`cureff`
SELECT p.emailid , MAX(p.effective) AS curedate
FROM `timecards`.`persons` p
WHERE effective < CURDATE()
AND p.coid ='reroo'
GROUP BY p.emailid;

DROP TABLE IF EXISTS `timecards`.`cureffective` ;

CREATE TABLE `timecards`.`cureffective`
SELECT p.*
FROM `timecards`.`cureff` c
JOIN  `timecards`.`persons` p
ON c.emailid=p.emailid 
AND c.curedate=p.effective;

SELECT * FROM `timecards`.`cureffective`;


/**query to get current persons and rates for approved tcardwks***/
DROP TABLE IF EXISTS `timecards`.`cureff` ;

CREATE TABLE `timecards`.`cureff`
SELECT p.emailid , MAX(p.effective) AS curedate
FROM `timecards`.`persons` p
WHERE effective < CURDATE()
AND p.coid ='reroo'
GROUP BY p.emailid;

DROP TABLE IF EXISTS `timecards`.`cureffective` ;

CREATE TABLE `timecards`.`cureffective`
SELECT p.*
FROM `timecards`.`cureff` c
JOIN  `timecards`.`persons` p
ON c.emailid=p.emailid 
AND c.curedate=p.effective;

SELECT t.*, c.*
FROM `timecards`.`tcardwk` t
JOIN `timecards`.`cureffective` c
ON  c.emailid = t.emailid
WHERE t.status='approved'
AND t.coid= 'reroo';

DROP TABLE IF EXISTS `timecards`.`cureff`; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective < CURDATE() AND p.coid =? GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective`; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective; SELECT * FROM `timecards`.`cureffective`;

USE timecards;
SELECT w.emailid, w.role, c.coid, c.goodtil, a.appid FROM rolewho w RIGHT JOIN `roleapp` a ON a.`role`= w.`role` LEFT JOIN co c ON c.coid= w.coid WHERE w.emailid = 'mckenna.tim@gmail.com' AND c.goodtil > CURDATE() AND a.appid = 'persons'

DROP TABLE IF EXISTS `timecards`.`cureff`; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective < CURDATE() AND p.coid ='reroo' GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective`; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective; SELECT * FROM `timecards`.`cureffective`;

use timecards;
DROP TABLE IF EXISTS `fedwh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fedwh` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `period` varchar(10),
  `singmar` varchar(20) DEFAULT NULL,
  `over` int(4) ,
  `notover` int(4),
  `perc` decimal(2,2),
  `less` decimal (6,2),
  PRIMARY KEY (`id`),
  KEY (`year`),
  KEY (`singmar`),
  KEY (`period`),
  KEY (`over`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO fedwh (`year`, `singmar`, `period`, `over`, `notover`, `perc`, `less`)  
VALUES 
('2018', 'single', 'weekly', 0, 71, 0, 0),
('2018', 'single', 'weekly', 71, 254, .10, 7.10),
('2018', 'single', 'weekly', 245, 815, .12, 12.18),
('2018', 'single', 'weekly', 815, 1658, .22, 93.68),
('2018', 'single', 'weekly', 1658, 3100, .24, 126.84),
('2018', 'single', 'weekly', 3100, 3917, .32, 374.84),
('2018', 'single', 'weekly', 3917, 9687, .35, 492.35),
('2018', 'married', 'weekly', 0, 222, 0, 0),
('2018', 'married', 'weekly', 222, 588, .10, 22.20),
('2018', 'married', 'weekly', 588, 1711, .12, 33.96),
('2018', 'married', 'weekly', 1711, 3395, .22, 205.06),
('2018', 'married', 'weekly', 3395, 6280, .24, 272.96),
('2018', 'married', 'weekly', 6280, 7914, .32, 775.36),
('2018', 'married', 'weekly', 7914, 11761, .35, 1012.78);

select * from fedwh;

use timecards;
DROP TABLE IF EXISTS `fedr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fedr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT NULL,
  `allow` decimal(5,2),
  `ssw` decimal(4,4),
  `sse` decimal(4,4),
  `ssbase` decimal(6,0),
  `mediw` decimal(4,4),
  `medie` decimal(4,4),
  `mediadd` decimal(4,4),
  `mediexcess` decimal(6,0),
  `futa` decimal(4.4),
  `futa4first` decimal(5,0),
  PRIMARY KEY (`id`),
  KEY (`year`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO fedr (`year`, `allow`, `ssw`, `sse`, `ssbase`, `mediw`, `medie`, `mediadd`, `mediexcess`, `futa`, `futa4first`)  
VALUES 
('2018', 79.80, .062, .062, 128400, .0145, .0145, .009, 200000, .006, 7000);

select * from fedr;

use timecards;
DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(2),
  `year` varchar(4) DEFAULT NULL,
  `allow` decimal(5,2) ,
  `rate` decimal(4,4),
  `nowhbelow` decimal(3,0),
  `ficasub` decimal(4,0),
  `hohded` decimal(3,0),
  `blided` decimal(3,0),
  PRIMARY KEY (`id`),
  KEY (`year`),
  KEY (`state`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO state (`state`, `year`, `allow`, `rate`, `nowhbelow`, `ficasub`, `hohded`, `blided`)  
VALUES 
('MA', '2018', 85, .051, 154, 2000, 46, 42);

select * from state;

use timecards;
DROP TABLE IF EXISTS `payrec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payrec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(2),
  `year` varchar(4) DEFAULT NULL,
  `allow` decimal(5,2) ,
  `rate` decimal(4,4),
  `nowhbelow` decimal(3,0),
  `ficasub` decimal(4,0),
  `hohded` decimal(3,0),
  `blided` decimal(3,0),
  PRIMARY KEY (`id`),
  KEY (`year`),
  KEY (`state`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO payrec (`state`, `year`, `allow`, `rate`, `nowhbelow`, `ficasub`, `hohded`, `blided`)  
VALUES 
('MA', '2018', 85, .051, 154, 2000, 46, 42);

select * from payrec;

USE timecards;
DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons` (
  `id` int(11) NOT NULL,
  `emailid` varchar(60) DEFAULT '',
  `firstmid` varchar(60) DEFAULT '',
  `lastname` varchar(40) DEFAULT '',
  `street` varchar(100) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `st` varchar(2) DEFAULT '',
  `zip` varchar(10) DEFAULT '',
  `ssn` varchar(11) DEFAULT '',
  `w4allow` int(2) DEFAULT 3,
  `stallow` int(2) DEFAULT 1,
  `addwhfed` decimal(4,0) DEFAULT 0,
  `addwhst` decimal(4,0) DEFAULT 0,
  `hoh` int(1) DEFAULT 0,
  `blind` int(1) DEFAULT 0,
  `rate` decimal(5,2) DEFAULT 15,
  `coid` varchar(20) DEFAULT '',
  `effective` date DEFAULT '2018-09-26'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `emailid`, `firstmid`, `lastname`, `street`, `city`, `st`, `zip`, `ssn`, `w4allow`, `stallow`, `rate`, `coid`, `effective`) VALUES
(1, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '38.25', 'sbs', '2018-11-23'),
(3, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 1, 1, '47.25', 'sbs', '2018-09-22'),
(4, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 1, 1, '35.25', 'sbs', '2018-06-22'),
(6, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121440295', 0, 0, '27.45', 'reroo', '2018-11-30'),
(7, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', NULL, NULL, NULL, '33.23', 'sbs', '2019-06-02'),
(13, 'noah@sitebuilt.net', 'Noah', 'McKenna', 'ChestnutSquare', 'Jamaic Plain', 'MA', '02130', NULL, 1, 1, '21.50', 'sbs', '2018-09-25'),
(14, 'perimckenna@gmail.com', 'Peri Levin', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '050461312', 0, 0, '22.22', 'sbs', '2018-09-25'),
(15, 'tim2@sitebuilt.net', 'Tim2', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', NULL, 0, 0, '19.54', 'sbs', '2018-09-25'),
(20, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', NULL, NULL, NULL, '33.23', 'sbs', '2018-06-02'),
(21, 'jade@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(22, 'karen@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(23, 'modesto@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(24, 'noah@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(25, 'oliviaallegramay@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(26, 'pampi@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(27, 'perimckenna@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(28, 'perimckenna@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', NULL),
(29, 'perimckenna@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '19.99', 'reroo', '2018-09-26'),
(30, 'rubie@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', '2018-09-26'),
(31, 'samuel@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', '2018-09-26'),
(32, 'tim2@sitebuilt.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'reroo', '2018-09-26'),
(34, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '32.21', 'reroo', '2017-08-23'),
(36, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121440295', 0, 0, '26.35', 'reroo', '2018-09-25'),
(37, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121440295', 0, 0, '25.55', 'reroo', '2017-09-13'),
(43, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '34.25', 'reroo', '2018-05-09'),
(44, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '34.25', 'reroo', '2018-09-30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ece` (`emailid`,`coid`,`effective`),
  ADD KEY `firstmid` (`firstmid`),
  ADD KEY `lastname` (`lastname`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `city` (`city`),
  ADD KEY `st` (`st`),
  ADD KEY `coid` (`coid`),
  ADD KEY `rate` (`rate`),
  ADD KEY `effective` (`effective`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

SELECT * FROM `timecards`.`persons`;  

UPDATE `timecards`.`persons` SET  w4allow =IFNULL(w4allow,0);
UPDATE `timecards`.`persons` SET  stallow =IFNULL(stallow,0);
UPDATE `timecards`.`persons` SET  firstmid =IFNULL(firstmid,'');
UPDATE `timecards`.`persons` SET  lastname =IFNULL(lastname,'');
UPDATE `timecards`.`persons` SET  city =IFNULL(city,'');
UPDATE `timecards`.`persons` SET  street =IFNULL(street,'');
UPDATE `timecards`.`persons` SET  zip =IFNULL(zip,'');
UPDATE `timecards`.`persons` SET  st =IFNULL(st,'');
UPDATE `timecards`.`persons` SET  ssn =IFNULL(ssn,'');
UPDATE `timecards`.`persons` SET  rate =IFNULL(rate,15);
UPDATE `timecards`.`persons` SET  effective =IFNULL(effective,'2015-01-01');
SELECT * FROM `timecards`.`persons`; 

USE timecards;
DROP TABLE IF EXISTS `persons`;
CREATE TABLE `persons` (
  `id` int(11) NOT NULL,
  `emailid` varchar(60) DEFAULT '',
  `firstmid` varchar(60) DEFAULT '',
  `lastname` varchar(40) DEFAULT '',
  `street` varchar(100) DEFAULT '',
  `city` varchar(50) DEFAULT '',
  `st` varchar(2) DEFAULT '',
  `zip` varchar(10) DEFAULT '',
  `ssn` varchar(11) DEFAULT '',
  `w4allow` int(2) DEFAULT '3',
  `w4add` int(3) DEFAULT '0',
  `stallow` int(2) DEFAULT '1',
  `stadd` int(3) DEFAULT '0',
  `sthoh` int(1) DEFAULT 0,
  `stblind` int(1) DEFAULT 0,
  `rate` decimal(5,2) DEFAULT '15.00',
  `coid` varchar(20) DEFAULT '',
  `effective` date DEFAULT '2017-12-31'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`id`, `emailid`, `firstmid`, `lastname`, `street`, `city`, `st`, `zip`, `ssn`, `w4allow`, `stallow`, `rate`, `coid`, `effective`) VALUES
(1, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '38.25', 'sbs', '2018-11-23'),
(3, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 1, 1, '47.25', 'sbs', '2018-09-22'),
(4, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 1, 1, '35.25', 'sbs', '2018-06-22'),
(6, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121440295', 0, 0, '27.45', 'reroo', '2018-11-30'),
(7, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '', 0, 0, '33.23', 'sbs', '2019-06-02'),
(13, 'noah@sitebuilt.net', 'Noah', 'McKenna', 'ChestnutSquare', 'Jamaic Plain', 'MA', '02130', '', 1, 1, '21.50', 'sbs', '2018-09-25'),
(14, 'perimckenna@gmail.com', 'Peri Levin', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '050461312', 0, 0, '22.22', 'sbs', '2018-09-25'),
(15, 'tim2@sitebuilt.net', 'Tim2', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '', 0, 0, '19.54', 'sbs', '2018-09-25'),
(20, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '', 0, 0, '33.23', 'sbs', '2018-06-02'),
(21, 'jade@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(22, 'karen@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(23, 'modesto@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(24, 'noah@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(25, 'oliviaallegramay@gmail.com', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(26, 'pampi@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(28, 'perimckenna@yahoo.com', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2015-01-01'),
(29, 'perimckenna@yahoo.com', '', '', '', '', '', '', '', 0, 0, '19.99', 'reroo', '2018-09-26'),
(30, 'rubie@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2018-09-26'),
(31, 'samuel@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2018-09-26'),
(32, 'tim2@sitebuilt.net', '', '', '', '', '', '', '', 0, 0, '15.00', 'reroo', '2018-09-26'),
(34, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '32.21', 'reroo', '2017-08-23'),
(36, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121440295', 0, 0, '26.35', 'reroo', '2018-09-25'),
(37, 'tim@sitebuilt.net', 'Tim', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121440295', 0, 0, '25.55', 'reroo', '2017-09-13'),
(43, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '34.25', 'reroo', '2018-05-09'),
(44, 'mckenna.tim@gmail.com', 'Timothy S.', 'McKenna', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130', '121-44-0295', 3, 2, '34.25', 'reroo', '2018-09-30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ece` (`emailid`,`coid`,`effective`),
  ADD KEY `firstmid` (`firstmid`),
  ADD KEY `lastname` (`lastname`),
  ADD KEY `emailid` (`emailid`),
  ADD KEY `city` (`city`),
  ADD KEY `st` (`st`),
  ADD KEY `coid` (`coid`),
  ADD KEY `rate` (`rate`),
  ADD KEY `effective` (`effective`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

SELECT * from `timecards`.`persons`;  


use timecards;
DROP TABLE IF EXISTS `corates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(4) DEFAULT '2018',
  `coid` varchar(20) DEFAULT '',
  `wcrate` decimal(4,4) DEFAULT '.062',
  `stuirate` decimal(4,4) DEFAULT '.052',
  `effective` date DEFAULT '2018-01-01',
  PRIMARY KEY (`id`),
  KEY (`year`),
  KEY (`coid`),
  KEY (`effective`)
  ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `timecards`.`corates` (`year`, `coid`, wcrate, stuirate, effective) VALUES 
('2018', 'reroo', .062, .051, '2018-09-01'),
('2018', 'sbs', .042, .041, '2018-08-21');

SELECT * FROM  `timecards`.`corates` ;

USE timecards;
DROP TABLE IF EXISTS `co`;
CREATE TABLE `co` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodtil` date DEFAULT '2018-01-01',
  `coid` varchar(20) DEFAULT '',
  `name` varchar(40) DEFAULT '',
  `street` varchar(100) DEFAULT '',
  `city`  varchar(50) DEFAULT '',
  `st`  varchar(2) DEFAULT '',
  `zip`  varchar(10) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `co`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `city` (`city`),
  ADD KEY `st` (`st`),
  ADD KEY `coid` (`coid`),
  ADD KEY `zip` (`zip`),
  ADD KEY `goodtil` (`goodtil`);

INSERT INTO `co` (`id`, `goodtil`, `coid`, `name`, `street`, `city`,`st`,`zip`) VALUES
(1, '2018-11-12', 'reroo', 'Restoring Roots Cooperative', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130'),
(3, '2018-11-12', 'sbs', 'Site-Built Systems', '12 Parley Vale', 'Jamaica Plain', 'MA', '02130');

SELECT * FROM  `timecards`.`co` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `co`

ALTER TABLE `co`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coid` (`coid`),
  ADD KEY `goodtil` (`goodtil`);



use timecards;
DROP TABLE IF EXISTS `strates`;
CREATE TABLE `strates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `st` varchar(2) DEFAULT '',
  `year` varchar(4) DEFAULT '',
  `allow` decimal(5,2) DEFAULT '0.05',
  `rate` decimal(4,4) DEFAULT '0.0',
  `nowhbelow` decimal(3,0) DEFAULT '0.0',
  `ficasub` decimal(4,0) DEFAULT '0.0',
  `hohded` decimal(3,0) DEFAULT '0.0',
  `blided` decimal(3,0) DEFAULT '0.0',
  PRIMARY KEY (`id`),
   KEY `year` (`year`),
   KEY `st` (`st`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `strates` (`st`, `year`, `allow`, `rate`, `nowhbelow`, `ficasub`, `hohded`, `blided`) VALUES
('MA', '2018', '85.00', '0.0510', '154', '2000', '46', '42');


SELECT * FROM  `timecards`.`strates` ;

use timecards;
 INSERT INTO persons SET `emailid` = 'mckenna.tim@gmail.com', `coid` = 'reroo', `firstmid` = 'Timothy S.', `lastname` = 'McKenna', `street` = '12 Parley Vale', `city` = 'Jamaica Plain', `st` = 'MA', `zip` = '02130', `rate` = 34.25, `ssn` = '121-44-0295', `w4allow` = 3, `stallow` = 2, `effective` = '2018-09-30' ON DUPLICATE KEY UPDATE `emailid` = 'mckenna.tim@gmail.com', `coid` = 'reroo', `firstmid` = 'Timothy S.', `lastname` = 'McKenna', `street` = '12 Parley Vale', `city` = 'Jamaica Plain', `st` = 'MA', `zip` = '02130', `rate` = 34.25, `ssn` = '121-44-0295', `w4allow` = 3, `stallow` = 2, `effective` = '2018-09-30'

DROP TABLE IF EXISTS `timecards`.`cureff` ;
CREATE TABLE `timecards`.`cureff`
SELECT p.emailid , MAX(p.effective) AS curedate
FROM `timecards`.`persons` p
WHERE effective < CURDATE()
AND p.coid ='reroo'
GROUP BY p.emailid;
DROP TABLE IF EXISTS `timecards`.`cureffective` ;
CREATE TABLE `timecards`.`cureffective`
SELECT p.*
FROM `timecards`.`cureff` c
JOIN  `timecards`.`persons` p
ON c.emailid=p.emailid 
AND c.curedate=p.effective;
SELECT t.*, c.*
FROM `timecards`.`tcardwk` t
JOIN `timecards`.`cureffective` c
ON  c.emailid = t.emailid
WHERE t.status='approved'
AND t.coid= 'reroo';


DROP TABLE IF EXISTS `timecards`.`cureff` ; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective < CURDATE() AND p.coid ='reroo' GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective` ; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective; SELECT t.*, c.* FROM `timecards`.`tcardwk` t JOIN `timecards`.`cureffective` c ON c.emailid = t.emailid WHERE t.status='approved' AND t.coid= 'reroo';

DROP TABLE IF EXISTS `timecards`.`cureff` ; CREATE TABLE `timecards`.`cureff` SELECT p.emailid , MAX(p.effective) AS curedate FROM `timecards`.`persons` p WHERE effective < CURDATE() AND p.coid =? GROUP BY p.emailid; DROP TABLE IF EXISTS `timecards`.`cureffective` ; CREATE TABLE `timecards`.`cureffective` SELECT p.* FROM `timecards`.`cureff` c JOIN `timecards`.`persons` p ON c.emailid=p.emailid AND c.curedate=p.effective; SELECT t.*, c.* FROM `timecards`.`tcardwk` t JOIN `timecards`.`cureffective` c ON c.emailid = t.emailid WHERE t.status='approved' AND t.coid= ?;

use timecards;
DROP TABLE IF EXISTS `cosr`;
CREATE TABLE `cosr` (
  `id` int(11) NOT NULL,
  `year` varchar(4) DEFAULT '2018',
  `coid` varchar(20) DEFAULT '',
  `wcrate` decimal(4,4) DEFAULT '0.0620',
  `stuirate` decimal(4,4) DEFAULT '0.0520',
  `firstday` int(2) DEFAULT '1',
  `ot` varchar(120) DEFAULT '{}',
  `effective` date DEFAULT '2018-01-01'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cosr`
--

INSERT INTO `cosr` (`id`, `year`, `coid`, `wcrate`, `stuirate`, `effective`,firstday, ot) VALUES
(1, '2018', 'reroo', '0.0620', '0.0510', '2018-09-01',1 , '{"over40": 1.5, "sa": 1.0, "su": 1.0}'),
(2, '2018', 'sbs', '0.0420', '0.0410', '2018-08-21',5 , '{"over40": 1.5, "sa": 1.5, "su": 1.0}'),
(3, '2019', 'reroo', '0.0620', '0.0510', '2019-09-11',1 , '{"over40": 1.5, "sa": 1.0, "su": 1.0}'),
(4, '2019', 'sbs', '0.0420', '0.0410', '2019-05-15',5 , '{"over40": 1.5, "sa": 1.5, "su": 1.0}'),
(5, '2017', 'reroo', '0.0620', '0.0510', '2017-04-30',1 , '{"over40": 1.5, "sa": 1.0, "su": 1.0}'),
(6, '2017', 'sbs', '0.0420', '0.0410', '2017-05-21',5 , '{"over40": 1.5, "sa": 1.5, "su": 1.0}');


--
-- Indexes for dumped tables
--

--
-- Indexes for table `cosr`
--
ALTER TABLE `cosr`
  ADD PRIMARY KEY (`id`),
  ADD KEY `year` (`year`),
  ADD KEY `coid` (`coid`),
  ADD KEY `effective` (`effective`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cosr`
--
ALTER TABLE `cosr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;


use timecards;
ALTER TABLE `tcardwk` ADD `hrsarr` VARCHAR(120) NULL DEFAULT '\'[]\'' AFTER `coid`;  

SELECT p.ot , MAX(p.effective) AS curedate
FROM `timecards`.`cosr` p
WHERE effective < CURDATE()
AND p.coid ='reroo'
GROUP BY p.ot;

SELECT * FROM `timecards`.`cosr`
WHERE effective < CURDATE()
AND coid ='reroo'
ORDER BY effective DESC
LIMIT 1;

SELECT * FROM `timecards`.`co` WHERE coid='sbs';

SELECT * FROM `timecards`.`cosr`
WHERE effective < CURDATE()
AND coid ='reroo'
ORDER BY effective DESC
LIMIT 1;

SELECT * FROM `timecards`.`fedr`
WHERE year = YEAR(CURDATE());

SELECT * FROM `timecards`.`fedwh`
WHERE year = YEAR(CURDATE());

SELECT * FROM `timecards`.`strates`
WHERE year = YEAR(CURDATE())
AND st= 'MA';

SELECT * FROM `timecards`.`cosr`
WHERE effective < CURDATE()
AND coid =?
ORDER BY effective DESC
LIMIT 1;
SELECT * FROM `timecards`.`fedr`
WHERE year = YEAR(CURDATE());
SELECT * FROM `timecards`.`fedwh`
WHERE year = YEAR(CURDATE());
SELECT * FROM `timecards`.`strates`
WHERE year = YEAR(CURDATE())
AND st= ?;

SELECT * FROM `timecards`.`cosr` WHERE effective < CURDATE() AND coid =? ORDER BY effective DESC LIMIT 1; SELECT * FROM `timecards`.`fedr` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`fedwh` WHERE year = YEAR(CURDATE()); SELECT * FROM `timecards`.`strates` WHERE year = YEAR(CURDATE()) AND st= ?; 

use timecards;
ALTER TABLE `persons` ADD `marital` VARCHAR(20) NOT NULL DEFAULT 'marASsingl' AFTER `ssn`;
ALTER TABLE `persons` ADD `w4exempt` TINYINT NOT NULL DEFAULT '0' AFTER `w4add`;

ALTER TABLE `persons` ADD `student` TINYINT NOT NULL DEFAULT '0' AFTER `stadd`;

ALTER TABLE `co` CHANGE `goodtil` `goodtil` DATE NULL DEFAULT 'CURDATE() + 30 days';

SELECT * FROM tcardjc WHERE emailid = 'mckenna.tim@gmail.com' AND coid ='sbs' AND wdprt LIKE('2018-W40%')

SELECT * FROM tcardwk WHERE emailid = 'mckenna.tim@gmail.com' AND coid ='sbs' AND wprt = '2018-W40'

CREATE TABLE `months` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mo` varchar(20),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `months` (`mo`)
VALUES 
('January'),
('February'),
('March'),
('April'),
('May'),
('June'),
('July'),
('August'),
('September'),
('October'),
('November'),
('December')

use timecards;
DROP TABLE IF EXISTS `glaccounts`;
CREATE TABLE `glaccounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20),
  `description` varchar(100),
  PRIMARY KEY (`id`),
  KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO glaccounts (`account`, `description`)
VALUES 
('a1010-cash', 'CASH Operating Account'),
('a1210-AR', 'Accounts Receivable'),
('a2010-SS', 'Accrued Social Security'),
('a2020-medi', 'Accrued Medicare'),
('a2030-meda', 'Additional Medicare'),
('a2050-fedWh', 'Federal Income Tax Witheld'),
('a2060-stWh', 'State Income Tax Witheld'),
('a2070-locWh', 'Local Income Tax Witheld'),
('a2080-FUTA', 'Federal Unemployment Tax'),
('a2090-SUTA', 'State Unemployment Tax'),
('a2100-comp', 'Accrued Workmens Comp'),
('a2100-401K', 'Accrued 401K'),
('a2120-health', 'Accrued Health Insurance'),
('a2130-holiday', 'Accrued Holiday Benefit'),
('a2140-vacation', 'Accrued Vacation Benefit'),
('a2150-personal', 'Accrued Personal Benefit'),
('a2160-PTO', 'Accrued PTO Benefit'),
('a2200-grossAP', 'Gross Pay Payable'),
('a4010-revenue', 'Job Revenue'),
('a5010-COGS', 'Cost of Goods Sold debit'),
('a6000-labor', 'General Labor Expense'),
('a6010-gross', 'Gross Payroll Expense'),
('a6011-reg', 'Regular Pay Expense'),
('a6012-ot', 'Overtime Pay Expense'),
('a6020-burden', 'Payroll Burden Expense'),
('a6021-FICA', 'Employer FICA Expense'),
('a6022-insurance', 'Worker Insurance Expense'),
('a6023-401k', 'Company Paid 401K Expense'),
('a6024-health', 'Company Paid Health Expense'),
('a6025-PTO', 'Paid Time Off Expense'),
('a6030-wages', 'Wage Expense'),
('a6031-1099', '1099 Wage Expense'),
('a6031-dedu', 'Deductions'),
('a6032-net', 'Net Pay Wage Expense'),
('a6033-fed', 'Federal Tax Wage Expense'),
('a6034-state', 'State Tax Wage Expense'),
('a6035-local', 'Local Tax Wage Expense'),
('a6036-SS', 'Social Security Wage Expense'),
('a6037-medi', 'Medicare Wage Expense'),
('a6038-meda', 'Medicare Additional Wage Expense'),
('a6039-dedu', 'Deductible Expense'),
('a6040-fedWages', 'Federal Wages'),
('a6041-fedTaxable', 'Federal Taxable'),
('a6042-fedDed', 'Federal Deductions'),
('a6050-stateWages', 'State Wages'),
('a6051-stateTaxable', 'Stae Taxable'),
('a6052-stateDed', 'State Deductions'),
('a6060-FICAwages', 'FICA wages'),
('a6061-FICAtaxable', 'FICA Taxable'),
('a6062-FICAded', 'FICA Deductible'),
('a6070-addFICA', 'Additional FICA'),
('a6080-localWages', 'Local Wages'),
('a6081-localTaxablle', 'Local Taxable'),
('a6082-localDed', 'Local Deductions');

use timecards;
DROP TABLE IF EXISTS `gl`;
CREATE TABLE `gl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coid` varchar(20) DEFAULT '',
  `account` varchar(20) DEFAULT '',
  `wdprt` varchar(12) DEFAULT '',
  `job` varchar(60) DEFAULT '',
  `cat` varchar(40) DEFAULT '',
  `date` date,
  `someid` varchar(60) DEFAULT '',
  `somenum` decimal(6,2) DEFAULT 0,
  `debit` decimal(9,2) DEFAULT 0,
  `credit` decimal(9,2) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY (`account`),
  KEY (`coid`),
  KEY (`wdprt`),
  KEY (`date`),
  KEY (`job`),
  KEY (`cat`),
  KEY (`someid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `cosr` ADD `otrate` DECIMAL(3,2) NOT NULL DEFAULT '1.5' AFTER `firstday`, ADD `sarate` DECIMAL(3,2) NOT NULL DEFAULT '1' AFTER `otrate`, ADD `surate` DECIMAL(3,2) NOT NULL DEFAULT '1' AFTER `sarate`;

DELETE FROM co WHERE coid='tim4co';
DELETE FROM cosr WHERE coid='tim4co';
DELETE FROM persons WHERE coid='tim4co';
DELETE FROM rolewho WHERE coid='tim4co';


SELECT c.*, r.* FROM `timecards`.`cosr` r
JOIN `timecards`.`co` c 
ON c.coid=r.coid;
WHERE r.effective < CURDATE()
ORDER BY r.effective DESC LIMIT 1;

SELECT c.*, r.* FROM `timecards`.`cosr` r
JOIN `timecards`.`co` c 
ON c.coid=r.coid
AND r.effective < CURDATE()
AND r.coid = 'sbs'
ORDER BY r.effective DESC LIMIT 1;

ALTER TABLE `timecards`.`cosr` ADD UNIQUE `coef` (`coid`, `effective`);


USE timecards;
INSERT INTO tcardpu
SET `name` = 'mckenna.tim@gmail.com',
    `selected` = '[0,0,0,1,1,0,0,0,0,1,0]'
ON DUPLICATE KEY
UPDATE 
    `name` = 'mckenna.tim@gmail.com',
    `selected` = '[1,1,0,1,1,0,0,0,0,1,0]'

SELECT `job`, `category` FROM jobcatact WHERE week=42 AND coid='reroo' ORDER BY idx, category



SELECT someid, SUM(debit) as gross
FROM gl
WHERE account='a6010-gross'
AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid

SELECT someid, SUM(credit) as ss
FROM gl
WHERE (account='a2010-SS' OR account='a2020-medi')
AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid

SELECT account, SUM(credit) as credit, SUM(debit) as debit
FROM gl
WHERE (account='a2010-SS' OR account='a2020-medi' OR account= 'a2050-fedWh')
AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY account

SELECT account, SUM(credit) as credit, SUM(debit) as debit
FROM gl
WHERE (account='a2010-SS' 
OR account='a2020-medi' 
OR account= 'a2050-fedWh'
OR account= 'a6010-gross'
OR account= 'a2200-grossAP'
)
AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY account

SELECT coid, SUM(debit) as debit, SUM(credit) as credit,
FROM gl
GROUP BY coid

SELECT SUM(debit) as debit, SUM(credit) as credit
FROM gl


TRUNCATE TABLE gl;

-- SELECT someid, SUM(debit) as gross, SUM(credit) as ss
-- FROM gl
-- WHERE (account='a6010-gross' OR account='a2010-SS')
-- AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
-- AND coid = 'reroo'
-- GROUP BY someid

SELECT someid, SUM(credit) as ss
FROM gl
WHERE account='a2010-SS'
AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid

SELECT someid, SUM(credit) as medi
FROM gl
WHERE account='a2020-medi'
AND wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid

UPDATE tcardwk SET status ='approved' 
WHERE status = 'paid'

SELECT SUM(credit) as credit, SUM(debit) as debit
FROM gl
WHERE account='a5010-COGS'

--trialbalance of entire gl
SELECT SUM(debit) as debit, SUM(credit) as credit
FROM gl;

--redo gl
TRUNCATE TABLE gl; UPDATE tcardwk SET status ='approved' 
WHERE status = 'paid';

SELECT * FROM `tcardwk` order by emailid desc, wprt desc

SELECT account, someid, SUM(credit)
FROM gl
WHERE  wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY account, someid 

SELECT  someid, account, SUM(somenum) as hrs, SUM(debit) as debit, SUM(credit) as credit
FROM gl
WHERE  wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid,account 

SELECT  someid, wdprt, `date`, account, SUM(debit) as debit, SUM(credit) as credit
FROM gl 
WHERE  wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid, wdprt, `date`, account 

UPDATE gl SET account='a6000-labor' WHERE job = 'labor expense'

SELECT  g.account, d.description, SUM(g.debit) as debit, SUM(g.credit) as credit
FROM gl g
LEFT JOIN glaccounts d
ON g.account=d.account
WHERE  wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY g.account, d.description 

SELECT  someid, `date`, SUM(debit) as debit, SUM(credit) as credit
FROM gl 
WHERE  wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
GROUP BY someid, `date`

INSERT INTO jobcatact (job, category, active, idx, coid) 
VALUES 
('labor expense', 'general', 0, 0, 'monkeyshines'),
('labor expense', 'admin', 0, 0, 'monkeyshines')

DELETE FROM co WHERE coid='mokeyshines';
DELETE FROM cosr WHERE coid='mokeyshines';
DELETE FROM persons WHERE coid='mokeyshines';
DELETE FROM rolewho WHERE coid='mokeyshines';
DELETE FROM jobcatact WHERE coid='mokeyshines';

SELECT  MONTH(`date`) as mont, g.account, d.description, SUM(g.debit) as debit, SUM(g.credit) as credit
FROM gl g
LEFT JOIN glaccounts d
ON g.account=d.account
WHERE  wdprt like(CONCAT(YEAR(CURDATE()),'%'))
AND coid = 'reroo'
AND g.account='a2010-SS'
GROUP BY g.account, d.description, MONTH(`date`) 


--accrued/paid whithheld by month for year and coid
SELECT  YEAR(`date`) as year, MONTHNAME(`date`) as month,  SUM(debit) as paid, SUM(credit) as accrued
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' ||
  account='a2050-fedWh' 
)
GROUP BY YEAR(`date`), MONTH(`date`), MONTHNAME(`date`) 

--accrued/paid witholding by year for year and coid
SELECT  YEAR(`date`) as year,  SUM(debit) as paid, SUM(credit) as accrued
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' ||
  account='a2050-fedWh' 
)
GROUP BY YEAR(`date`)

--accrued/paid witholding by quarter for year and coid
SELECT  YEAR(`date`) as year,  QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' ||
  account='a2050-fedWh' 
)
GROUP BY YEAR(`date`), QUARTER(`date`)

--accrued/paid witholding by tax accrual account by quarter for year and coid
SELECT  YEAR(`date`) as year,  QUARTER(`date`) as qtr, account, SUM(debit) as paid, SUM(credit) as accrued
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' ||
  account='a2050-fedWh' 
)
GROUP BY YEAR(`date`), QUARTER(`date`), account

----accrued/paid witholding by quarter for year and coid NOT THAT USEFUL
SELECT  YEAR(`date`) as year,  QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued, ROUND(SUM(credit)/.124, 2) as taxable
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' 
)
GROUP BY YEAR(`date`), QUARTER(`date`)

SELECT  YEAR(`date`) as year,  QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND account='a6010-gross'
GROUP BY YEAR(`date`), QUARTER(`date`)

SELECT 'a6010-gross', YEAR(`date`) as year,  QUARTER(`date`) as qtr, someid, wdprt,SUM(debit) as paid, SUM(credit) as accrued
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND account='a6010-gross'
GROUP BY YEAR(`date`), QUARTER(`date`), someid, wdprt

SELECT * FROM gl
WHERE someid = 'mckenna.tim@gmail.com' 
AND coid = 'reroo'
AND wdprt = '2018-W11'
ORDER BY account


--to find which payroll record causes imbalance

SELECT coid, someid, SUBSTRING(wdprt, 1,8) as wprt, SUM(debit) as debit, SUM(credit) as credit from gl
GROUP BY coid, someid, SUBSTRING(wdprt, 1,8)

SELECT coid, someid, SUBSTRING(wdprt, 1,8) as wprt, account, SUM(debit) as debit, SUM(credit) as credit from gl
GROUP BY coid, someid, SUBSTRING(wdprt, 1,8), account

-- by someid
--sum of accounts for ONE coid,someid,wprt
SELECT coid, someid, SUBSTRING(wdprt, 1,8) as wprt, account, SUM(debit) as debit, SUM(credit) as credit from gl
WHERE someid = 'mckenna.tim@gmail.com'
AND coid = 'reroo'
AND YEAR(`date`) = '2018'
AND SUBSTRING(wdprt, 1,8) = '2018-W11'
GROUP BY coid, someid, SUBSTRING(wdprt, 1,8), account

--check that accrued SS is based upn the same wages as a6041-fedtaxable
SELECT  someid, account, YEAR(`date`) as year,  QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued, ROUND(SUM(credit)/.124, 2) as taxable
FROM gl 
WHERE someid = 'mckenna.tim@gmail.com'
AND coid = 'reroo'
AND YEAR(`date`) = '2018'
AND SUBSTRING(wdprt, 1,8) = '2018-W11'
AND (
  account='a2010-SS' ||
  account='a6061-FICAtaxable'
  ) 
GROUP BY coid, someid, account, YEAR(`date`), QUARTER(`date`)

--check that accrued medicare is based upn the same wages as a6041-fedtaxable
SELECT  someid, account, YEAR(`date`) as year,  QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued, 
FROM gl 
WHERE someid = 'mckenna.tim@gmail.com'
AND coid = 'reroo'
AND YEAR(`date`) = '2018'
AND SUBSTRING(wdprt, 1,8) = '2018-W11'
AND (
  account='a6041-fedTaxable' ||
  account='a6051-stateTaxable' ||
  account='a6061-FICAtaxable'
  ) 
GROUP BY coid, someid, account, YEAR(`date`), QUARTER(`date`)

--first try on count employees per qtr
DROP TABLE IF EXISTS `timecards`.`tempqtr` ;
CREATE TABLE `timecards`.`tempqtr`
SELECT  someid, YEAR(`date`) as year,  QUARTER(`date`) as qtr
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`) = '2018'
GROUP BY coid, YEAR(`date`), QUARTER(`date`), someid;
SELECT COUNT(someid), year, qtr
FROM tempqtr
GROUP BY year,qtr

--smarter count employees by quarter (subquery)
SELECT year, qtr, COUNT(someid)
FROM (
SELECT DISTINCT YEAR(`date`) as year,  QUARTER(`date`) as qtr, someid
FROM gl
WHERE coid = 'reroo'
AND YEAR(`date`) = '2018'
GROUP BY YEAR(`date`), QUARTER(`date`), someid
) b
GROUP BY year, qtr

--FORM 941 {sumempl}results[1]
--*** mobetter count employees by quarter LINE 1 941, MA M-941 numempl & period
SELECT COUNT(DISTINCT(someid)) as numempl, YEAR(`date`) as year, QUARTER(`date`) as qtr
FROM gl
WHERE coid = 'reroo'
AND YEAR(`date`) = '2018'
GROUP BY YEAR(`date`), QUARTER(`date`)

SELECT COUNT(DISTINCT(someid)) as numempl, YEAR(`date`) as year, QUARTER(`date`) as qtr FROM gl WHERE coid = 'reroo' AND YEAR(`date`) = '2018' GROUP BY YEAR(`date`), QUARTER(`date`)
"SELECT COUNT(DISTINCT(someid)) as numempl, YEAR(`date`) as year, QUARTER(`date`) as qtr FROM gl WHERE coid = 'reroo' AND YEAR(`date`) = '2018' GROUP BY YEAR(`date`), QUARTER(`date`)"

--accounts by month {acctsmo}reaults[0]
SELECT  account, YEAR(`date`) as year,  QUARTER(`date`) as qtr, MONTH(`date`) as mo, SUM(debit) as debit, SUM(credit) as credit
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`) = '2018'
AND (
  account='a6041-fedTaxable' ||
  account='a2050-fedWh' ||
  account='a2060-stWh' ||
  account='a6051-stateTaxable' ||
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a6061-FICAtaxable' ||
  account='a6070-addFICA' ||
  account='a2030-meda' 
  ) 
GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), coid, account

SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = 'reroo' AND YEAR(`date`) = '2018' AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), coid, account

"SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = ? AND YEAR(`date`) = ? AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), coid, account"

--FED 941 and MA M-941 {acctqtr}results[2]
SELECT  account, YEAR(`date`) as year,  QUARTER(`date`) as qtr, SUM(debit) as debit, SUM(credit) as credit
FROM gl 
WHERE coid = 'reroo'
AND YEAR(`date`) = '2018'
AND (
  account='a6041-fedTaxable' ||
  account='a2050-fedWh' ||
  account='a2060-stWh' ||
  account='a6051-stateTaxable' ||
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a6061-FICAtaxable' ||
  account='a6070-addFICA' ||
  account='a2030-meda' 
  ) 
GROUP BY YEAR(`date`), QUARTER(`date`),coid, account

  -- account='a6041-fedTaxable' ||  --LINE 2, LINE 5c COLUMN 1
  -- account='a2050-fedWh' ||       --LINE 3 
  -- account='a2060-stWh' ||        --MA M-941 LINE 1
  -- account='a6051-stateTaxable' ||
  -- account='a2010-SS' ||           --LINE 5a COLUMN 2
  -- account='a2020-medi' ||         --LINE 5c COLUMN 2
  -- account='a6061-FICAtaxable' ||  --LINE 5a COLUMN 1
  -- account='a6070-addFICA' ||      --LINE 5d COLUMN 1
  -- account='a2030-meda' ||         --LINE 5d COLUMN 2


SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = 'reroo' AND YEAR(`date`) = '2018'AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`),coid, account 

"SELECT account, YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as debit, SUM(credit) as credit FROM gl WHERE coid = ? AND YEAR(`date`) = ?  AND ( account='a6041-fedTaxable' || account='a2050-fedWh' || account='a2060-stWh' || account='a6051-stateTaxable' || account='a2010-SS' || account='a2020-medi' || account='a6061-FICAtaxable' || account='a6070-addFICA' || account='a2030-meda' ) GROUP BY YEAR(`date`), QUARTER(`date`),coid, account"




--941 Line 16  {fmobyqtr}results[3]
--monthly accrued and paid by quarter
SELECT  YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo,  MONTHNAME(`date`) as month,  SUM(debit) as paid, SUM(credit) as accrued
FROM gl g
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' ||
  account='a2050-fedWh' 
)
GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`) 

SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = 'reroo' AND YEAR(`date`)= '2018' AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh') GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`)

"SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh') GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`)"

--{fqtrtot}results[4]
--quarterly totals 941 LINE 12, LINE 16 Total Liability for quarter
SELECT  YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued
FROM gl g
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' ||
  account='a2050-fedWh' 
)
GROUP BY YEAR(`date`), QUARTER(`date`)

SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = 'reroo' AND YEAR(`date`)= '2018' AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh' ) GROUP BY YEAR(`date`), QUARTER(`date`)

"SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2010-SS' || account='a2020-medi' || account='a2020-meda' || account='a2050-fedWh' ) GROUP BY YEAR(`date`), QUARTER(`date`)"


--quarterly FICAtotals 941 LINE 5e, 10 NOT in payrol/taxes/year
SELECT  YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued
FROM gl g
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2010-SS' ||
  account='a2020-medi' ||
  account='a2020-meda' 
)
GROUP BY YEAR(`date`), QUARTER(`date`)

--{smobyqtr} Result[5] -in payrol/taxes/year
--state monthly accrued and paid by quarter 
SELECT  YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo,  MONTHNAME(`date`) as month,  SUM(debit) as paid, SUM(credit) as accrued
FROM gl g
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2060-stWh' 
)
GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`)

SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = 'reroo' AND YEAR(`date`)= '2018' AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`)

"SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, MONTH(`date`) as mo, MONTHNAME(`date`) as month, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`), MONTH(`date`), MONTHNAME(`date`)"

--{sqtrtot} Result[6] -in payrol/taxes/year
--quarterly totals 
SELECT  YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued
FROM gl g
WHERE coid = 'reroo'
AND YEAR(`date`)= '2018'
AND (
  account='a2060-stWh' 
)
GROUP BY YEAR(`date`), QUARTER(`date`)

SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = 'reroo' AND YEAR(`date`)= '2018' AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`)

"SELECT YEAR(`date`) as year, QUARTER(`date`) as qtr, SUM(debit) as paid, SUM(credit) as accrued FROM gl g WHERE coid = ? AND YEAR(`date`)= ? AND ( account='a2060-stWh' ) GROUP BY YEAR(`date`), QUARTER(`date`)"

DELETE FROM gl WHERE cat='payment' ; SELECT * FROM `gl` ORDER BY id DESC limit 100 ;

---
SELECT wdprt as ref, job as gov, QUARTER(`date`)as qtr, MONTH(`date`)as mo,
MONTHNAME(`date`) as month,
someid as paydate, credit as paid FROM gl 
WHERE YEAR(`date`)='2018' 
AND coid ='reroo' 
AND account = 'a1010-cash' 
AND (job='fed' OR job='state') 
AND cat='WhTaxPayment' AND credit>0
ORDER BY job, `date`

SELECT wdprt as ref, job as gov, QUARTER(`date`)as qtr, MONTH(`date`)as mo, MONTHNAME(`date`) as month, someid as paydate, credit as paid FROM gl WHERE YEAR(`date`)='2018' AND coid ='reroo' AND account = 'a1010-cash' AND (job='fed' OR job='state') AND cat='WhTaxPayment' AND credit>0 ORDER BY job, `date` 

"SELECT wdprt as ref, job as gov, QUARTER(`date`)as qtr, MONTH(`date`)as mo, MONTHNAME(`date`) as month, someid as paydate, credit as paid FROM gl WHERE YEAR(`date`)=? AND coid =? AND account = 'a1010-cash' AND (job='fed' OR job='state') AND cat='WhTaxPayment' AND credit>0 ORDER BY job, `date` "

update gl set cat = 'WhTaxPayment' where cat = 'payment'