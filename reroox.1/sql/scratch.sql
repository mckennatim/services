show tables from reroo;

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
ALTER TABLE `whoapp` ADD `auth` tinyint(4), ADD KEY (`auth`);

UPDATE reroo.whoapp SET coid='reroo';

SELECT * FROM reroo.whoapp;
SELECT * FROM reroo.jobcatact;
SELECT * FROM reroo.week;

SELECT * FROM reroo.whoapp WHERE emailid='noah@sitebuilt.net' AND appid='jobs';